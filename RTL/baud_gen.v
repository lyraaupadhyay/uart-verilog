`timescale 1ns/1ps
module baud_gen #(
    parameter clk_freq = 50000000,
    parameter baud_rate = 9600,
    parameter sampling_rate = 153600
    
)(
    input clk,
    input reset,
    output reg baud_tick,
    output reg sample_tick
);
    localparam baud_div = clk_freq/baud_rate;
    localparam sample_div = clk_freq/sampling_rate;
    
    reg [12:0] baud_counter ;
    reg [8:0] sample_counter ;

    always@(posedge clk) begin
        if(reset)begin
            baud_counter <= 0;
            sample_counter <= 0;
            baud_tick <= 0;
            sample_tick <= 0;
        end
        else begin
                if(baud_counter == baud_div-1)begin
                baud_tick <= 1;
                baud_counter <= 0;
            end
            else begin
                baud_tick <= 0;
                baud_counter <= baud_counter +1;
            end

            if(sample_counter == sample_div-1)begin
                sample_tick <= 1;
                sample_counter <=0;
            end
            else begin
                sample_tick <= 0;
                sample_counter <= sample_counter +1;
            end

        end
    end      
    
endmodule
