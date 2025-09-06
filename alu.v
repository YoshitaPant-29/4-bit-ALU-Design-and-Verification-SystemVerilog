module alu (
    input  logic [3:0] a, b,       // 4-bit inputs (numbers between 0–15)
    input  logic [2:0] alu_ctrl,   // control signal = which operation to do
    output logic [3:0] result,     // output of the ALU
    output logic       carry_out,  // flag (if carry happened in ADD/SUB)
    output logic       zero        // flag (if result = 0)
);

    logic [4:0] tmp; // 5 bits to catch carry

    always_comb begin
        case (alu_ctrl)
            3'b000: begin // ADD
                tmp = a + b;
                result = tmp[3:0];
                carry_out = tmp[4];
            end
            3'b001: begin // SUB
                tmp = a - b;
                result = tmp[3:0];
                carry_out = tmp[4];
            end
            3'b010: result = a & b; // AND
            3'b011: result = a | b; // OR
            3'b100: result = a ^ b; // XOR
            3'b101: result = a << 1; // Shift Left
            3'b110: result = a >> 1; // Shift Right
            3'b111: result = a;      // Pass-through
            default: result = 4'b0000;
        endcase

        zero = (result == 4'b0000);
    end

endmodule
