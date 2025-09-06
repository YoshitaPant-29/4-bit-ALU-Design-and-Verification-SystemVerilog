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

    initial begin
        repeat (20) begin // ask 20 random questions
            a = $urandom_range(0, 15);
            b = $urandom_range(0, 15);
            alu_ctrl = $urandom_range(0, 7);

            compute_expected(a, b, alu_ctrl);
            #5; // wait for ALU to answer

            // Teacher checks the answer
            assert(result == expected_result)
                else $error("WRONG! a=%0d b=%0d op=%0d got=%0d expected=%0d",
                            a, b, alu_ctrl, result, expected_result);

            $display("PASS: a=%0d b=%0d op=%0d => result=%0d", a, b, alu_ctrl, result);
        end
        $finish;
    end
endmodule
