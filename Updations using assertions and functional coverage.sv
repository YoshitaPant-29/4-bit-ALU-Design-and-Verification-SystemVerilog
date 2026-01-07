// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module alu_tb;

    logic [3:0] a, b;      // numbers to give to ALU
    logic [2:0] alu_ctrl;  // operation we want
    logic [3:0] result;    // answer from ALU
    logic carry_out, zero; // flags from ALU

    // Connect our ALU (the student) to the testbench (the teacher)
    alu dut (
        .a(a), .b(b), .alu_ctrl(alu_ctrl),
        .result(result), .carry_out(carry_out), .zero(zero)
    );
    // Functional Coverage: Did we test all ops, all inputs, and zero flag?
    covergroup alu_cg;
        coverpoint alu_ctrl { bins all_ops[] = {[0:7]}; }  // cover all 8 operations
        coverpoint a        { bins all_vals[] = {[0:15]}; } // cover input values for 'a'
        coverpoint b        { bins all_vals[] = {[0:15]}; } // cover input values for 'b'
        coverpoint carry_out {
        bins no_carry = {0};
        bins carry    = {1};
    }

        cross alu_ctrl, zero;  // check zero flag behavior across all ops
    cross alu_ctrl, carry_out;
    endgroup

    alu_cg cg = new();

    // The "answer key" (what the teacher expects)
    logic [3:0] expected_result;
    logic expected_zero;
    logic expected_carry;

    // Teacher calculates expected answers
    task compute_expected(input [3:0] a, b, input [2:0] alu_ctrl);
        logic [4:0] tmp;
        begin
            case (alu_ctrl)
                3'b000: begin tmp = a + b; expected_result = tmp[3:0]; expected_carry = tmp[4]; end
                3'b001: begin tmp = a - b; expected_result = tmp[3:0]; expected_carry = tmp[4]; end
                3'b010: expected_result = a & b;
                3'b011: expected_result = a | b;
                3'b100: expected_result = a ^ b;
                3'b101: expected_result = a << 1;
                3'b110: expected_result = a >> 1;
                3'b111: expected_result = a;
                default: expected_result = 4'b0000;
            endcase
            expected_zero = (expected_result == 0);
        end
    endtask
//Assertions
// 1️⃣ Zero flag must always reflect result
    assert property (@(*) zero == (result == 4'b0000))
      else $error("ZERO flag incorrect: result=%0d zero=%0b", result, zero);

    // 2️⃣ Carry correctness for ADD operation
    assert property (@(*)
        (alu_ctrl == 3'b000) |-> (carry_out == ((a + b) > 4'hF))
    )
    else $error("ADD carry incorrect: a=%0d b=%0d carry=%0b", a, b, carry_out);

    // 3️⃣ Pass-through operation correctness
    assert property (@(*)
        (alu_ctrl == 3'b111) |-> (result == a)
    )
    else $error("PASS failed: a=%0d result=%0d", a, result);
//Test Sequence
    initial begin
      $dumpfile("dump.vcd");   // name of the VCD file
      $dumpvars(0, alu_tb);    // dump all signals in  alu_tb
       // Random tests
    repeat (200) begin
        a = $urandom_range(0, 15);
        b = $urandom_range(0, 15);
        alu_ctrl = $urandom_range(0, 7);

        compute_expected(a, b, alu_ctrl);
        #5;
        cg.sample();

        assert(result == expected_result)
            else $error("Mismatch: a=%0d b=%0d op=%0d got=%0d exp=%0d",a, b, alu_ctrl, result, expected_result);
    end

      // Directed tests (force all ops at least once)## trying      to force missing values 
        // ADD overflow
        a = 4'hF; b = 4'h1; alu_ctrl = 3'b000;
        compute_expected(a, b, alu_ctrl); #5; cg.sample();

        // SUB underflow
        a = 4'h0; b = 4'h1; alu_ctrl = 3'b001;
        compute_expected(a, b, alu_ctrl); #5; cg.sample();

        // ZERO result
        a = 4'h5; b = 4'h5; alu_ctrl = 3'b001;
        compute_expected(a, b, alu_ctrl); #5; cg.sample();

        // SHIFT boundary
        a = 4'h8; alu_ctrl = 3'b101;
        compute_expected(a, b, alu_ctrl); #5; cg.sample();

        // PASS through
        a = 4'hA; alu_ctrl = 3'b111;
        compute_expected(a, b, alu_ctrl); #5; cg.sample();

        $display("Coverage = %0.2f%%", $get_coverage());
        $finish;
    end

endmodule
