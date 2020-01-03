open Core
open Print_desugared_ast

let%expect_test "Good if statement" =
  print_desugared_ast
    " 
   void main(){
     let x = true;
     if x {
       0
     }
     else {
       1
     }
   }
  " ;
  [%expect
    {|
      Program
      └──Main expr
         └──Expr: Let var: _var_x0
            └──Type expr: Bool
            └──Expr: Bool:true
         └──Expr: If
            └──Type expr: Int
            └──Expr: Variable: _var_x0
               └──Type expr: Bool
            └──Then block
               └──Expr: Int:0
            └──Else block
               └──Expr: Int:1 |}]

let%expect_test "Good while loop" =
  print_desugared_ast " 
  void main(){
   while (1 < 2){
     let x = 5
   }
  }
  " ;
  [%expect
    {|
      Program
      └──Main expr
         └──Expr: While
            └──Type expr: Void
            └──Expr: Bin Op: <
               └──Type expr: Bool
               └──Expr: Int:1
               └──Expr: Int:2
            └──Body block
               └──Expr: Let var: _var_x0
                  └──Type expr: Int
                  └──Expr: Int:5 |}]

let%expect_test "Good for loop" =
  print_desugared_ast
    " 
  void main(){
    for (let i=0; i < (5*5); i:= i+1) {
      i
    }
   }
  " ;
  [%expect
    {|
      Program
      └──Main expr
         └──Expr: Let var: _var_i0
            └──Type expr: Int
            └──Expr: Int:0
         └──Expr: While
            └──Type expr: Void
            └──Expr: Bin Op: <
               └──Type expr: Bool
               └──Expr: Variable: _var_i0
                  └──Type expr: Int
               └──Expr: Bin Op: *
                  └──Type expr: Int
                  └──Expr: Int:5
                  └──Expr: Int:5
            └──Body block
               └──Expr: Variable: _var_i0
                  └──Type expr: Int
               └──Expr: Assign
                  └──Type expr: Int
                  └──Expr: Variable: _var_i0
                     └──Type expr: Int
                  └──Expr: Bin Op: +
                     └──Type expr: Int
                     └──Expr: Variable: _var_i0
                        └──Type expr: Int
                     └──Expr: Int:1 |}]
