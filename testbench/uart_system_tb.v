`timescale 1ns/1ps
module uart_system_tb;

localparam clk_freq = 50000000;
localparam baud_rate = 9600;
localparam sampling_rate = 153600;

reg clk;
reg reset;

wire baud_tick; 
wire sample_tick;

reg tx_start;
wire tx_busy;
reg [7:0] tx_data;
wire [7:0] rx_data;

wire serial_line;

wire rx_done;

baud_gen #(
    .clk_freq(clk_freq),
    .baud_rate(baud_rate),
    .sampling_rate(sampling_rate)
) dut0(
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick),
    .sample_tick(sample_tick)
);

uart_tx dut1(
    .clk(clk),
    .reset(reset),
    .baud_tick(baud_tick),
    .tx_data(tx_data),
    .tx_start(tx_start),
    .tx(serial_line),
    .tx_busy(tx_busy)
);

uart_rx dut2(
    .clk(clk),
    .reset(reset),
    .sample_tick(sample_tick),
    .rx(serial_line),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

    always #10 clk = ~clk;
    
    initial begin
        $dumpfile("uart_system.vcd");
        $dumpvars(0,uart_system_tb);

        

        clk = 0;
        reset = 1;

        tx_start = 0;
        tx_data = 8'd0;

        #100;
        reset = 0;
        #20;

        tx_data = 8'b10011010;
        
        tx_start = 1;
        #20;
        tx_start = 0;

        

        #2000000;
        $finish;
    end

    always@(posedge clk)begin
        if(rx_done)begin
            $display("the final output is = %0b",rx_data);

            if(rx_data == tx_data)begin
                $display("success");
            end
            else begin
                $display("fail");
            end
        end
    end

endmodule