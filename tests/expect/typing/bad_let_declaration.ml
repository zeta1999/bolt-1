open Core
open Print_typed_ast

let%expect_test "Try to define 'this'" =
  print_typed_ast " 
    void main(){ 
    let this = 1
    }
  " ;
  [%expect {|
    Line:3 Position:5 Type error - Trying to declare 'this'. |}]
