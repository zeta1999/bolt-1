open Core
open Print_frontend_ir

let%expect_test "Consume linear variable" =
  print_frontend_ir
    " 
    class Foo {
      capability linear Bar;
      const int f : Bar;
      const int g : Bar ; 
      const int h : Bar;
    }
    void main(){
        let x = new Foo(f:4, g:5, h:6);
        let y = consume x // Consume linear variable 
    }
  " ;
  [%expect
    {|
    Program
    └──Class: Foo
       └──VTable []
       └──Field: Int
       └──Field: Int
       └──Field: Int
    └──Main expr
       └──Expr: Let var: _x0
          └──Expr: Constructor for: Foo
             └── Field: 0
                └──Expr: Int:4
             └── Field: 1
                └──Expr: Int:5
             └── Field: 2
                └──Expr: Int:6
       └──Expr: Let var: _y0
          └──Expr: Consume
             └──Expr: Variable: _x0 |}]

let%expect_test "Consume linear field of variable" =
  print_frontend_ir
    " 
    class Foo {
      capability local Bar;
      var Baz f : Bar;
    }
   class Baz {
       capability linear Fa;
       var int g : Fa;
    }
    void main(){
        let x = new Foo();
        let y = consume x.f // Consume linear field of variable 

    }
  " ;
  [%expect
    {|
    Program
    └──Class: Foo
       └──VTable []
       └──Field: Class: Baz
    └──Class: Baz
       └──VTable []
       └──Field: Int
    └──Main expr
       └──Expr: Let var: _x0
          └──Expr: Constructor for: Foo
       └──Expr: Let var: _y0
          └──Expr: Consume
             └──Expr: Objfield: _x0[0] |}]
