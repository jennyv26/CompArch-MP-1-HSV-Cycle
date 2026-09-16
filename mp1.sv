module mp1(
    input logic clk,
    output logic RGB_R,
    output logic RGB_G,
    output logic RGB_B
);
    parameter BLINK_INTERVAL = 2000000; // 12MHz clock, so 2,000,000 cycles for 6 colors (12MHz / 2,000,000 = 6Hz)
    logic [$clog2(BLINK_INTERVAL) - 1:0] count = 0; // Counter for the blink interval
    logic [2:0] state = 3'd0; // State variable to track the current color

    initial begin
        RGB_R = 1'b0;
        RGB_G = 1'b1;
        RGB_B = 1'b1;
    end
 
    always_ff @(posedge clk) begin
        if (count == BLINK_INTERVAL - 1) begin
            count <= 0;
            if (state == 3'd5) 
                state <= 3'd0; // Reset state to 0 after reaching 5
            else
                state <= state + 1; // Increment state to move to the next color
        end
        else begin
            count <= count + 1;
        end
        case (state)
            3'd0: begin // red
                RGB_R <= 1'b0; // Red on
                RGB_G <= 1'b1; // Green off
                RGB_B <= 1'b1; // Blue off
            end
            3'd1: begin // yellow (red + green)
                RGB_R <= 1'b0; // Red on
                RGB_G <= 1'b0; // Green on
                RGB_B <= 1'b1; // Blue off
            end

            3'd2: begin // green
                RGB_R <= 1'b1; // Red off
                RGB_G <= 1'b0; // Green on
                RGB_B <= 1'b1; // Blue off
            end
            3'd3: begin // cyan (green + blue)
                RGB_R <= 1'b1; // Red off
                RGB_G <= 1'b0; // Green on
                RGB_B <= 1'b0; // Blue on
            end
            3'd4: begin // blue
                RGB_R <= 1'b1; // Red off
                RGB_G <= 1'b1; // Green off
                RGB_B <= 1'b0; // Blue on
            end
            3'd5: begin // magenta (red + blue)
                RGB_R <= 1'b0; // Red on
                RGB_G <= 1'b1; // Green off
                RGB_B <= 1'b0; // Blue on
            end
        endcase

    end
endmodule