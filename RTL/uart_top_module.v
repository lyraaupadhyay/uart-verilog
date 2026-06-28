`timescale 1ns/1ps
module uart_top_module  #(
    parameter clk_freq = 50000000,
    parameter baud_rate = 9600,
    parameter sampling_rate = 153600
    
) (
    input clk,
    input reset,

    input [7:0] tx_data,
    input tx_start,

    output [7:0] rx_data,
    output rx_done
);
    wire baud_tick;
    wire sample_tick;
    wire serial_line;
    wire tx_busy;

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

endmodule
