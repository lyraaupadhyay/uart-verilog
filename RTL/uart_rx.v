`timescale 1ns/1ps
module uart_rx (
    input clk,
    input reset,

    input rx,
    input sample_tick,

    output reg [7:0]rx_data,
    output reg rx_done
);

    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam DATA = 2'b10;
    localparam STOP = 2'b11;
    
    reg rx_sync;
    reg [1:0] state;
    reg [7:0] shift_register;
    reg [2:0] bit_counter;
    reg [3:0] sample_counter;
    reg [1:0] ff = 0;

    always@(posedge clk)begin

        ff[0] <= rx;
        ff[1] <= ff[0];
        rx_sync <= ff[1];

        if(reset) begin
            rx_done <= 0;
            rx_data <= 0;
            rx_sync <= 1;
            state <= IDLE;
            shift_register <= 0;
            bit_counter <= 0;
            sample_counter <= 0;
        end

        else begin
            if(state != IDLE && sample_tick)begin
                if(sample_counter == 15)begin
                    sample_counter <= 0;
                end
                else begin
                    sample_counter <= sample_counter + 1;
                end
            end


            case(state) 
                IDLE:
                begin
		    rx_done <= 0;
                    if(!rx_sync)begin
                        state <= START;
                        sample_counter <= 0;
                    end
                end
                START:
                if(sample_tick)begin
                    
                    if(sample_counter == 8)begin
                        if(!rx_sync)begin
                            state <= DATA;
                            sample_counter <= 0;
                            bit_counter <= 0;
                        end
                        else begin
                            state <= IDLE;
                        end
                    end
                    
                end
                DATA:
                if(sample_tick)begin
                    if(sample_counter == 8)begin
                        shift_register[bit_counter] <= rx_sync;
                        bit_counter <= bit_counter +1;
                        
                        if(bit_counter == 7) begin
                            state <= STOP;
                            sample_counter <= 0;
                        end
                    end
                end
                STOP:
                if(sample_tick)begin
                    if(sample_counter == 8)begin
                        if(rx_sync)begin
                            state <= IDLE;
                            rx_done <= 1;
                            rx_data <= shift_register;
                        end
                        else begin
                            state <= IDLE;
                            rx_done <= 0;
                        end
                    end
                end
            
            endcase
        end
    end

    
    
endmodule