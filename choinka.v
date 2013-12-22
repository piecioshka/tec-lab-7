module choinka
    (
        input zegar,
        input reset,
        input dir,
        output [15:0] led
    );

    localparam n = 24;
    // logarytmicznie
    localparam [3:0] start = 0, s1 = 1, s2 = 2, s3 = 4, s4 = 8;

    reg [3:0] state_reg, state_next;
    reg [n-1:0] div_reg,;
    wire [n-1:0] div_next;
    wire div_zegar;

    always@(posedge zegar)
        if (reset)
            div_reg <= 0;
        else
            div_reg <= div_next;

    assign div_next = div_reg + 1;
    // wyciągamy najstarszy bit, aby spowolnić diody
    assign div_zegar = div_reg[n-1];

    always@(posedge zegar)
        if (reset)
            state_reg <= start;
        else
            state_reg <= state_next;

    always@* begin
        case (state_reg)
            start: state_next = s1;
            s1: 
                if (dir)
                    state_next = s2;
                else
                    state_next = s4;
            s2: 
                if (dir)
                    state_next = s3;
                else 
                    state_next = s1;
            s3: 
                if (dir)
                    state_next = s4;
                else 
                    state_next = s2;
            s4: 
                if (dir)
                    state_next = s1;
                else 
                    state_next = s3;
        endcase
    end

    assign leg[3:0] = state_reg;
    assign leg[7:4] = state_reg;
    assign leg[11:8] = state_reg;
    assign leg[15:12] = state_reg;

endmodule
