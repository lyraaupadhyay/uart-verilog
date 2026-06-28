`timescale 1ns/1ps
module uart_tx(
    input clk,
    input reset,

    input [7:0]tx_data,
    input tx_start,

    input baud_tick,

    output reg tx,
    output reg tx_busy
);
    reg [1:0] state;
    reg [7:0] shift_register;
    reg [2:0] bit_counter;

    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam DATA = 2'b10;
    localparam STOP = 2'b11;

    always@(posedge clk) begin
        if(reset)begin
            state <= IDLE;
            shift_register <= 8'd0;
            bit_counter <= 3'd0;
        end
        else begin
            case(state)
                IDLE : 
                if(tx_start)begin
                    state <= START;
                    bit_counter <= 0;
                    shift_register <= tx_data;
                end

                START:
                if(baud_tick)begin
                    
                        state <= DATA;
                    
                end
                DATA:
                if(baud_tick)begin
                    shift_register <= shift_register >> 1;
                    bit_counter <= bit_counter +1;
                    if(bit_counter == 7)begin
                        state <= STOP;
                    end
                end
                STOP:
                if(baud_tick)begin
                    state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end

    always@(*) begin
        case(state)
            IDLE : tx = 1'b1;
            START : tx = 1'b0;
            DATA : tx = shift_register[0];
            STOP : tx = 1'b1;
            default: tx = 1'b1;
        endcase

        tx_busy = (state != IDLE);

    end

    

endmodule