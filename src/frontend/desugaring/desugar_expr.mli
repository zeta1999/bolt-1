open Core

val desugar_expr : Typing.Typed_ast.expr -> Desugared_ast.expr Or_error.t

val desugar_block_expr :
  Typing.Typed_ast.block_expr -> Desugared_ast.block_expr Or_error.t
