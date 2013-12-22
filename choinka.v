module choinka
    (
        input zegar,
        input reset,
        output [3:0] led
    );

    localparam [3:0] start = 0, s1=1, s2=2, s3=4, s4=8;
    reg [3:0] state_reg, state_next;

    always@(posedge zegar)
        if (reset)
            state_reg <= start;
        else 
            state_reg <= state_next;

    always@* begin
        case (state_reg)
            start: state_next = s1;
            s1: state_next = s2;
            s2: state_next = s3;
            s3: state_next = s4;
            s4: state_next = s1;
        endcase
    end

    assign leg = state_reg;

endmodule
