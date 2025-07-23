module tb_traffic_light_controller;

    reg clk;
    reg reset;
    wire [2:0] ns_light;
    wire [2:0] ew_light;

    // Instantiate the controller
    traffic_light_controller uut (
        .clk(clk),
        .reset(reset),
        .ns_light(ns_light),
        .ew_light(ew_light)
    );

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk; // 10 time units period

    // Simulation Control
    initial begin
        reset = 1;
        #15;
        reset = 0;

        // Run for a set number of cycles
        #200;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time: %0d | NS: %b (R-Y-G) | EW: %b (R-Y-G)", 
           $time, ns_light, ew_light);
    end

endmodule
