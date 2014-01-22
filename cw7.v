module cw7
    #(
        parameter n = 4
    )
    (
        input [n-1:0] a, b,cw7
        output [n-1:0] result
    );

    lpm_divide #(.LPM_WIDTHN(4), .LPM_WIDTHD(4)) c (.numer(a), .denom(b), .quotient(result));

endmodule
