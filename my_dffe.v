module my_dffe(d, clk, clr, en, q);
   
   //Inputs
   input d, clk, clr, en;
   
   //Internal wire
   wire clr;

   //Output
   output q;
	
   
   //Register
   reg q;

   //Intialize q to 0
   initial
   begin
       q = 1'b0;
   end

   //Set value of q on positive edge of the clock or clear
   always @(posedge clk or posedge clr) begin
       //If clear is high, set q to 0
       if (clr) begin
           q <= 1'b0;
       //If enable is high, set q to the value of d
       end else if (en) begin
           q <= d;
       end
   end
endmodule
