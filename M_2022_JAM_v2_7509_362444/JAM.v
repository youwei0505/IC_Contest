module JAM (
input CLK,
input RST,
output reg [2:0] W,
output reg [2:0] J,
input [6:0] Cost,
output reg [3:0] MatchCount,
output reg [9:0] MinCost,
output reg Valid );

// 2C, 1S
reg [4:0] curt_state;
reg [4:0] next_state;
reg [2:0] Person [0:7];

reg finish_flag;
// reg [12:0] case_i;

// State machine Control
always @(*) 
begin
    case ( curt_state )
        0 :begin  
            next_state = 1;
        end
        1 :begin  
            next_state = 2;
        end
        2 :begin  
            next_state = 3;
        end  
        3 :begin  
            next_state = 4;
        end
        4 : begin
            next_state = 5;
        end
        5 : begin
            next_state = 6;
        end
        6 : begin
            next_state = 7;
        end
        7 : begin
            next_state = 8;
        end
        8 : begin 
            next_state = 9; 
        end  
        9 : begin 
            next_state = 10; 
        end
        10 : begin 
            next_state = 2; 
        end  
        default : 
        begin
            next_state = 0;
        end
    endcase
end

// 尋找替換點
reg [2:0] next_Person0;
reg [2:0] next_Person1;
reg [2:0] next_Person2;
reg [2:0] next_Person3;
reg [2:0] next_Person4;
reg [2:0] next_Person5;
reg [2:0] next_Person6;
reg [2:0] next_Person7;

always @( * ) begin
    // 替換點:Person[1]   
    if ( Person[0] > Person[1] )
    begin  
        // finish_flag = 0;
        Valid = 0;
        // case_i <= 11;
        next_Person0 <= 1;
        next_Person1 <= 0;

        next_Person2 <= 2;
        next_Person3 <= 3;      
        next_Person4 <= 4;
        next_Person5 <= 5;
        next_Person6 <= 6;
        next_Person7 <= 7;
    end
    // 替換點:Person[2]  
    else if ( Person[1] > Person[2] )
    begin    
        if ( ( Person[0] > Person[2] ) )
        begin
            Valid = 0;
            // case_i <= 22;
            // next_Person0 <= next_Person1;
            // next_Person1 <= next_Person2;
            // next_Person2 <= next_Person0;

            next_Person0 <= 1;
            next_Person1 <= 2;
            next_Person2 <= 0;

            next_Person3 <= 3;      
            next_Person4 <= 4;
            next_Person5 <= 5;
            next_Person6 <= 6;
            next_Person7 <= 7;  
        end
        // if ( ( Person[1] > Person[0] ) && ( Person[0] < Person[2] ) )
        else
        begin
            Valid = 0;
            // case_i <= 23;
            // next_Person0 <= next_Person2;
            // next_Person1 <= next_Person0;
            // next_Person2 <= next_Person1;

            next_Person0 <= 2;
            next_Person1 <= 0;
            next_Person2 <= 1;

            next_Person3 <= 3;      
            next_Person4 <= 4;
            next_Person5 <= 5;
            next_Person6 <= 6;
            next_Person7 <= 7;
        end
    end
    // 替換點:Person[3]  
    else if ( Person[2] > Person[3] )
    begin
        if ( ( Person[0] > Person[3] ) )
        begin
            Valid = 0;
            // case_i <= 31;
            // Person[3] <= Person[0]; 
            // Person[2] <= Person[3];
            // Person[1] <= Person[1]; 
            // Person[0] <= Person[2]; 

            next_Person0 <= 2;
            next_Person1 <= 1;
            next_Person2 <= 3;
            next_Person3 <= 0; 

            next_Person4 <= 4;
            next_Person5 <= 5;
            next_Person6 <= 6;
            next_Person7 <= 7;
        end
        else if ( ( Person[1] > Person[3] ) )
        begin            
            // case_i <= 32;
            Valid = 0;
            // Person[3] <= Person[1]; 
            // Person[2] <= Person[0];
            // Person[1] <= Person[3]; 
            // Person[0] <= Person[2];

            next_Person0 <= 2;
            next_Person1 <= 3;
            next_Person2 <= 0;
            next_Person3 <= 1; 

            next_Person4 <= 4;
            next_Person5 <= 5;
            next_Person6 <= 6;
            next_Person7 <= 7; 
        end
        else
        begin
            // case_i <= 33;
            // Person[3] <= Person[2]; 
            // Person[2] <= Person[0];
            // Person[1] <= Person[1]; 
            // Person[0] <= Person[3]; 
            Valid = 0;    
            next_Person0 <= 3;
            next_Person1 <= 1;
            next_Person2 <= 0;
            next_Person3 <= 2; 

            next_Person4 <= 4;
            next_Person5 <= 5;
            next_Person6 <= 6;
            next_Person7 <= 7;
        end                    
    end
    // 替換點:Person[4]  
    else if ( Person[3] > Person[4] )
    begin                    
        if ( ( Person[0] > Person[4] ) )
        begin
            // case_i <= 41;
            // Person[4] <= Person[0]; 
            // Person[3] <= Person[4]; 
            // Person[2] <= Person[1];
            // Person[1] <= Person[2]; 
            // Person[0] <= Person[3]; 
            Valid = 0;    
            next_Person0 <= 3;
            next_Person1 <= 2;
            next_Person2 <= 1;
            next_Person3 <= 4; 
            next_Person4 <= 0;
            
            next_Person5 <= 5;
            next_Person6 <= 6;
            next_Person7 <= 7;
        end
        else if ( ( Person[1] > Person[4] ) )
        begin
            // case_i <= 42;
            // Person[4] <= Person[1]; 
            // Person[3] <= Person[0]; 
            // Person[2] <= Person[4];
            // Person[1] <= Person[2]; 
            // Person[0] <= Person[3];
            Valid = 0;    
            next_Person0 <= 3;
            next_Person1 <= 2;
            next_Person2 <= 4;
            next_Person3 <= 0; 
            next_Person4 <= 1;
            
            next_Person5 <= 5;
            next_Person6 <= 6;
            next_Person7 <= 7; 
        end
        else if ( ( Person[2] > Person[4] ) )
        begin
            // case_i <= 43;
            // Person[4] <= Person[2]; 
            // Person[3] <= Person[0]; 
            // Person[2] <= Person[1];
            // Person[1] <= Person[4]; 
            // Person[0] <= Person[3]; 
            Valid = 0;    
            next_Person0 <= 3;
            next_Person1 <= 4;
            next_Person2 <= 1;
            next_Person3 <= 0; 
            next_Person4 <= 2;
            
            next_Person5 <= 5;
            next_Person6 <= 6;
            next_Person7 <= 7;
        end
        else 
        // else if ( ( Person[3] > Person[4] ) )
        begin
            // case_i <= 44;
            // Person[4] <= Person[3]; 
            // Person[3] <= Person[0]; 
            // Person[2] <= Person[1];
            // Person[1] <= Person[2]; 
            // Person[0] <= Person[4]; 
            Valid = 0;                
            next_Person0 <= 4;
            next_Person1 <= 2;
            next_Person2 <= 1;
            next_Person3 <= 0; 
            next_Person4 <= 3;
            
            next_Person5 <= 5;
            next_Person6 <= 6;
            next_Person7 <= 7;
        end
    end
    // 替換點:Person[5] 
    else if ( Person[4] > Person[5] )
    begin
        if ( ( Person[0] > Person[5] ) )
        begin
            // case_i <= 51;
            // Person[5] <= Person[0]; 
            // Person[4] <= Person[5]; 
            // Person[3] <= Person[1]; 
            // Person[2] <= Person[2];
            // Person[1] <= Person[3]; 
            // Person[0] <= Person[4]; 
            Valid = 0;                
            next_Person5 <= 0;
            next_Person4 <= 5;
            next_Person3 <= 1;
            next_Person2 <= 2; 
            next_Person1 <= 3;
            next_Person0 <= 4;
            
            next_Person6 <= 6;
            next_Person7 <= 7; 
        end
        else if ( ( Person[1] > Person[5] ) )
        begin
            // case_i <= 52;
            // Person[5] <= Person[1]; 
            // Person[4] <= Person[0]; 
            // Person[3] <= Person[5]; 
            // Person[2] <= Person[2];
            // Person[1] <= Person[3]; 
            // Person[0] <= Person[4];
            Valid = 0;                
            next_Person5 <= 1;
            next_Person4 <= 0;
            next_Person3 <= 5;
            next_Person2 <= 2; 
            next_Person1 <= 3;
            next_Person0 <= 4;
            
            next_Person6 <= 6;
            next_Person7 <= 7;  
        end
        else if ( ( Person[2] > Person[5] ) )
        begin
            // case_i <= 53;
            // Person[5] <= Person[2]; 
            // Person[4] <= Person[0]; 
            // Person[3] <= Person[1]; 
            // Person[2] <= Person[5];
            // Person[1] <= Person[3]; 
            // Person[0] <= Person[4]; 
            Valid = 0;                
            next_Person5 <= 2;
            next_Person4 <= 0;
            next_Person3 <= 1;
            next_Person2 <= 5; 
            next_Person1 <= 3;
            next_Person0 <= 4;
            
            next_Person6 <= 6;
            next_Person7 <= 7;
        end
        else if ( ( Person[3] > Person[5] ) )
        begin
            // case_i <= 54;
            // Person[5] <= Person[3]; 
            // Person[4] <= Person[0]; 
            // Person[3] <= Person[1]; 
            // Person[2] <= Person[2];
            // Person[1] <= Person[5]; 
            // Person[0] <= Person[4];
            Valid = 0;                
            next_Person5 <= 3;
            next_Person4 <= 0;
            next_Person3 <= 1;
            next_Person2 <= 2; 
            next_Person1 <= 5;
            next_Person0 <= 4;
            
            next_Person6 <= 6;
            next_Person7 <= 7; 
        end
        else
        // else if ( ( Person[4] > Person[5] ) )
        begin
            // case_i <= 55;
            // Person[5] <= Person[4]; 
            // Person[4] <= Person[0]; 
            // Person[3] <= Person[1]; 
            // Person[2] <= Person[2];
            // Person[1] <= Person[3]; 
            // Person[0] <= Person[5]; 
            Valid = 0;                
            next_Person5 <= 4;
            next_Person4 <= 0;
            next_Person3 <= 1;
            next_Person2 <= 2; 
            next_Person1 <= 3;
            next_Person0 <= 5;
            
            next_Person6 <= 6;
            next_Person7 <= 7; 
        end
    end
    // 替換點:Person[6] 
    else if ( Person[5] > Person[6] )
    begin
        if ( ( Person[0] > Person[6] ) )
        begin
            // case_i <= 61;
            // Person[6] <= Person[0]; 
            // Person[5] <= Person[6]; 
            // Person[4] <= Person[1]; 
            // Person[3] <= Person[2]; 
            // Person[2] <= Person[3];
            // Person[1] <= Person[4]; 
            // Person[0] <= Person[5]; 
            Valid = 0;    
            next_Person6 <= 0;
            next_Person5 <= 6;
            next_Person4 <= 1;
            next_Person3 <= 2;
            next_Person2 <= 3; 
            next_Person1 <= 4;
            next_Person0 <= 5;            
            
            next_Person7 <= 7; 
        end
        else if ( ( Person[1] > Person[6] ) )
        begin
            // case_i <= 62;
            // Person[6] <= Person[1]; 
            // Person[5] <= Person[0]; 
            // Person[4] <= Person[6]; 
            // Person[3] <= Person[2]; 
            // Person[2] <= Person[3];
            // Person[1] <= Person[4]; 
            // Person[0] <= Person[5]; 
            Valid = 0;                
            next_Person6 <= 1;
            next_Person5 <= 0;
            next_Person4 <= 6;
            next_Person3 <= 2;
            next_Person2 <= 3; 
            next_Person1 <= 4;
            next_Person0 <= 5;            
            
            next_Person7 <= 7;
        end
        else if ( ( Person[2] > Person[6] ) )
        begin
            // case_i <= 63;
            // Person[6] <= Person[2]; 
            // Person[5] <= Person[0]; 
            // Person[4] <= Person[1]; 
            // Person[3] <= Person[3]; 
            // Person[2] <= Person[6];
            // Person[1] <= Person[4]; 
            // Person[0] <= Person[5]; 
            Valid = 0;                
            next_Person6 <= 2;
            next_Person5 <= 0;
            next_Person4 <= 1;
            next_Person3 <= 3;
            next_Person2 <= 6; 
            next_Person1 <= 4;
            next_Person0 <= 5;            
            
            next_Person7 <= 7;
        end
        else if ( ( Person[3] > Person[6] ) )
        begin
            // case_i <= 64;
            // Person[6] <= Person[3]; 
            // Person[5] <= Person[0]; 
            // Person[4] <= Person[1]; 
            // Person[3] <= Person[2]; 
            // Person[2] <= Person[6];
            // Person[1] <= Person[4]; 
            // Person[0] <= Person[5];
            Valid = 0;                
            next_Person6 <= 3;
            next_Person5 <= 0;
            next_Person4 <= 1;
            next_Person3 <= 2;
            next_Person2 <= 6; 
            next_Person1 <= 4;
            next_Person0 <= 5;            
            
            next_Person7 <= 7; 
        end
        else if ( ( Person[4] > Person[6] ) )
        begin
            // case_i <= 65;
            // Person[6] <= Person[4]; 
            // Person[5] <= Person[0]; 
            // Person[4] <= Person[1]; 
            // Person[3] <= Person[2]; 
            // Person[2] <= Person[3];
            // Person[1] <= Person[6]; 
            // Person[0] <= Person[5];
            Valid = 0;                
            next_Person6 <= 4;
            next_Person5 <= 0;
            next_Person4 <= 1;
            next_Person3 <= 2;
            next_Person2 <= 3; 
            next_Person1 <= 6;
            next_Person0 <= 5;            
            
            next_Person7 <= 7;  
        end
        else
        begin
            // case_i <= 66;
            // Person[6] <= Person[5]; 
            // Person[5] <= Person[0]; 
            // Person[4] <= Person[1]; 
            // Person[3] <= Person[2]; 
            // Person[2] <= Person[3];
            // Person[1] <= Person[4]; 
            // Person[0] <= Person[6];
            Valid = 0;                
            next_Person6 <= 5;
            next_Person5 <= 0;
            next_Person4 <= 1;
            next_Person3 <= 2;
            next_Person2 <= 3; 
            next_Person1 <= 4;
            next_Person0 <= 6;            
            
            next_Person7 <= 7; 
        end
    end
    // 替換點:Person[7] 
    else if ( Person[6] > Person[7] )
    // else if ( Person[5] > Person[6] )
    begin
        if ( ( Person[0] > Person[7] ) )
        begin
            // case_i <= 71;
            // Person[7] <= Person[0]; 
            // Person[6] <= Person[7]; 
            // Person[5] <= Person[1]; 
            // Person[4] <= Person[2]; 
            // Person[3] <= Person[3]; 
            // Person[2] <= Person[4];
            // Person[1] <= Person[5]; 
            // Person[0] <= Person[6]; 
            Valid = 0;    
            next_Person7 <= 0;
            next_Person6 <= 7;
            next_Person5 <= 1;
            next_Person4 <= 2;
            next_Person3 <= 3;
            next_Person2 <= 4; 
            next_Person1 <= 5;
            next_Person0 <= 6; 
             
        end
        else if ( ( Person[1] > Person[7] ) )
        begin
            // case_i <= 72;
            // Person[7] <= Person[1]; 
            // Person[6] <= Person[0]; 
            // Person[5] <= Person[7]; 
            // Person[4] <= Person[2]; 
            // Person[3] <= Person[3]; 
            // Person[2] <= Person[4];
            // Person[1] <= Person[5]; 
            // Person[0] <= Person[6]; 
            Valid = 0;    
            next_Person7 <= 1;
            next_Person6 <= 0;
            next_Person5 <= 7;
            next_Person4 <= 2;
            next_Person3 <= 3;
            next_Person2 <= 4; 
            next_Person1 <= 5;
            next_Person0 <= 6; 
             
        end
        else if ( ( Person[2] > Person[7] ) )
        begin
            // case_i <= 73;
            Valid = 0;    
            next_Person7 <= 2;
            next_Person6 <= 0;
            next_Person5 <= 1;
            next_Person4 <= 7;
            next_Person3 <= 3;
            next_Person2 <= 4; 
            next_Person1 <= 5;
            next_Person0 <= 6; 
             
        end
        else if ( ( Person[3] > Person[7] ) )
        begin
            // case_i <= 74;
            Valid = 0;    
            next_Person7 <= 3;
            next_Person6 <= 0;
            next_Person5 <= 1;
            next_Person4 <= 2;
            next_Person3 <= 7;
            next_Person2 <= 4; 
            next_Person1 <= 5;
            next_Person0 <= 6; 
             
        end
        else if ( ( Person[4] > Person[7] ) )
        begin
            // case_i <= 75;
            Valid = 0;    
            next_Person7 <= 4;
            next_Person6 <= 0;
            next_Person5 <= 1;
            next_Person4 <= 2;
            next_Person3 <= 3;
            next_Person2 <= 7; 
            next_Person1 <= 5;
            next_Person0 <= 6; 
             
        end
        else if ( ( Person[5] > Person[7] ) )
        begin
            // case_i <= 76;
            Valid = 0;    
            next_Person7 <= 5;
            next_Person6 <= 0;
            next_Person5 <= 1;
            next_Person4 <= 2;
            next_Person3 <= 3;
            next_Person2 <= 4; 
            next_Person1 <= 7;
            next_Person0 <= 6; 
             
        end
        // else if ( ( Person[5] > Person[7] ) )
        else
        begin
            // case_i <= 77;
            Valid = 0;    
            next_Person7 <= 6;
            next_Person6 <= 0;
            next_Person5 <= 1;
            next_Person4 <= 2;
            next_Person3 <= 3;
            next_Person2 <= 4; 
            next_Person1 <= 5;
            next_Person0 <= 7;              
        end
    end
    // 當沒有替換點
    else
    begin
        // finish_flag = 1;
        Valid = 1;
        next_Person0 <= 0;
        next_Person1 <= 0;
        next_Person2 <= 0;

        next_Person3 <= 0;      
        next_Person4 <= 0;
        next_Person5 <= 0;
        next_Person6 <= 0;
        next_Person7 <= 0; 
    end
end

// always @( * ) begin
//     if ( Person[0] > Person[1] | Person[1] > Person[2] | Person[2] > Person[3] | Person[1] > Person[2] | Person[2] > Person[3] | Person[1] > Person[2] | Person[2] > Person[3])
//         Valid = 1; 
//     else
//         Valid = 0;    
// end

reg [10:0] Total_Cost;
// reg [10:0] // Real_Total_Cost;

// Signal Control & Computing Block
always @(posedge CLK or posedge RST ) 
begin
    if ( RST )
    begin   
        // Initial    
        W <= 3'd0;
        J <= 3'd0;
        Total_Cost <= 0;
        MatchCount <= 4'd0;
        // Find the minima, so let it very large at first
        MinCost    <= 10'b1111111111; 

        // Person array initial
        Person[0] <= 7;
        Person[1] <= 6;
        Person[2] <= 5;
        Person[3] <= 4;
        Person[4] <= 3;
        Person[5] <= 2;
        Person[6] <= 1;
        Person[7] <= 0;
               
        //State initial
        curt_state <= 0;
    end
    else
    begin
        curt_state <= next_state; 
        case ( curt_state )
            0 : begin
                W <= Person[0];
                J <= 0;
                // Total_Cost <= Total_Cost + Cost;
            end 
            1 : begin
                W <= Person[1];
                J <= 1;                
            end
            2 : begin
                W <= Person[2];
                J <= 2;
                Total_Cost <= Cost;
            end
            3 : begin
                W <= Person[3];
                J <= 3;
                Total_Cost <= Total_Cost + Cost;
            end
            4 : begin
                W <= Person[4];
                J <= 4;
                Total_Cost <= Total_Cost + Cost;
            end
            5 : begin
                W <= Person[5];
                J <= 5;
                Total_Cost <= Total_Cost + Cost;
            end
            6 : begin
                W <= Person[6];
                J <= 6;
                Total_Cost <= Total_Cost + Cost;
            end
            7 : begin
                W <= Person[7];
                J <= 7;
                Total_Cost <= Total_Cost + Cost;
            end
            8 : begin
                Total_Cost <= Total_Cost + Cost;
                Person[0] <= Person[next_Person0];
                Person[1] <= Person[next_Person1];
                Person[2] <= Person[next_Person2];
                Person[3] <= Person[next_Person3];
                Person[4] <= Person[next_Person4];
                Person[5] <= Person[next_Person5];
                Person[6] <= Person[next_Person6];
                Person[7] <= Person[next_Person7];
            end
            9 : begin
                W <= Person[0];
                J <= 0;
                Total_Cost <= Total_Cost + Cost;
                // Real_Total_Cost  <= Total_Cost + Cost;
            end
            10 : begin
                W <= Person[1];
                J <= 1;   
                if ( MinCost > Total_Cost )
                begin
                    MinCost <= Total_Cost;
                    MatchCount <= 1;
                    // MatchCount <= MatchCount + 1;
                end
                   
                     
                if ( MinCost == Total_Cost )
                    MatchCount <= MatchCount + 1;
            end
        endcase
    end
end

endmodule
