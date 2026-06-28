`timescale 1ns/1ps
module uart_tx_tb;
    reg clk;
    reg reset;

    reg [7:0]tx_data;
    reg tx_start;

    reg baud_tick;

    wire tx;
    wire tx_busy;

    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam DATA = 2'b10;
    localparam STOP = 2'b11;

    uart_tx dut(
        .clk(clk),
        .reset(reset),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .baud_tick(baud_tick),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    always #10 clk = ~clk;

    task send_baud_tick;
    begin
            baud_tick = 1;
            #20;
            baud_tick = 0;
            #100;
    end
    endtask
    
    initial begin
        $dumpfile("uart_tx.vcd");
        $dumpvars(0,uart_tx_tb);

        clk = 0;
        reset =1;

        tx_data = 0;
        tx_start =0;
        baud_tick =0;
        
        
        #100;
        reset =0;

        tx_data = 8'b10011010;

        tx_start =1;
        #20;
        tx_start =0;

        

        repeat(10)
        send_baud_tick();

        #100;

        $finish;
    end
endmodule