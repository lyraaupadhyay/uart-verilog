`timescale 1ns/1ps
module uart_rx_tb;
reg clk;
reg reset;
reg rx;
reg sample_tick;

wire [7:0]rx_data;
wire rx_done;

uart_rx dut(
    .clk(clk),
    .reset(reset),
    .rx(rx),
    .sample_tick(sample_tick),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

    always #10 clk = ~clk;

    integer sample_counter;

    always@(posedge clk)begin
        if(reset)begin
            sample_counter <= 0;
            sample_tick <= 0;
        end
        else begin
            if(sample_counter == 7)begin
                sample_tick <= 1;
                sample_counter <= 0;
            end
            else begin
                sample_tick <= 0;
                sample_counter <= sample_counter + 1;
            end
        end
    end

    task send_bit;
        input bit_value;
        integer i;
        begin
            rx = bit_value;

            for(i=0; i<16; i=i+1)begin
                @(posedge sample_tick);
            end
        end
    endtask

    initial begin
        $dumpfile("uart_rx.vcd");
        $dumpvars(0, uart_rx_tb);

        clk = 0;
        reset = 1;

        rx = 1;
        sample_tick = 0;
        #20;
        reset = 0;
        #100;

        send_bit(0);
        send_bit(0);
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(1);
        send_bit(0);
        send_bit(0);
        send_bit(1);
        send_bit(1);

        #200;

        $finish;
    end

    always@(posedge clk)begin
        if(rx_done)begin
            $display("time = %0t",$time);
            $display("expected data = %0b",rx_data);
        end
    end
endmodule