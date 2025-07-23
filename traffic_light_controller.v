module traffic_light_controller(
    input clk,         // Clock signal
    input reset,       // Active-high synchronous reset
    output reg [2:0] ns_light, // North-South: [Red, Yellow, Green]
    output reg [2:0] ew_light  // East-West:   [Red, Yellow, Green]
);

    // State Encoding using localparam constants (no enum)
    localparam NS_GREEN_EW_RED   = 3'd0,
               NS_YELLOW_EW_RED  = 3'd1,
               NS_RED_EW_GREEN   = 3'd2,
               NS_RED_EW_YELLOW  = 3'd3;
               
    reg [2:0] current_state, next_state;  // Using reg instead of enum
    reg [3:0] timer; // 4-bit timer for delay

    // Duration constants
    localparam GREEN_TIME  = 4'd7;
    localparam YELLOW_TIME = 4'd2;

    // State Register and Timer Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= NS_GREEN_EW_RED;
            timer <= GREEN_TIME;
        end else begin
            if (timer == 0) begin
                current_state <= next_state;
                // timer will be set in combinational logic below
            end else begin
                timer <= timer - 1;
            end
        end
    end

    // Next State and Output Logic
    always @(*) begin
        case (current_state)
            NS_GREEN_EW_RED: begin
                ns_light = 3'b001; // Green
                ew_light = 3'b100; // Red
                if (timer == 0) begin
                    next_state = NS_YELLOW_EW_RED;
                    timer = YELLOW_TIME;
                end else begin
                    next_state = NS_GREEN_EW_RED;
                    // timer unchanged here as it decrements in sequential always block
                end
            end

            NS_YELLOW_EW_RED: begin
                ns_light = 3'b010; // Yellow
                ew_light = 3'b100; // Red
                if (timer == 0) begin
                    next_state = NS_RED_EW_GREEN;
                    timer = GREEN_TIME;
                end else begin
                    next_state = NS_YELLOW_EW_RED;
                end
            end

            NS_RED_EW_GREEN: begin
                ns_light = 3'b100; // Red
                ew_light = 3'b001; // Green
                if (timer == 0) begin
                    next_state = NS_RED_EW_YELLOW;
                    timer = YELLOW_TIME;
                end else begin
                    next_state = NS_RED_EW_GREEN;
                end
            end

            NS_RED_EW_YELLOW: begin
                ns_light = 3'b100; // Red
                ew_light = 3'b010; // Yellow
                if (timer == 0) begin
                    next_state = NS_GREEN_EW_RED;
                    timer = GREEN_TIME;
                end else begin
                    next_state = NS_RED_EW_YELLOW;
                end
            end

            default: begin
                ns_light = 3'b100;
                ew_light = 3'b100;
                next_state = NS_GREEN_EW_RED;
                timer = GREEN_TIME;
            end
        endcase
    end

endmodule

