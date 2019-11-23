(** This module checks linear references are not aliased *)

open Core
open Typed_ast
open Ast_types

val type_linear_ownership :
  class_defn list -> trait_defn list -> expr -> (bool, Error.t) Result.t
(** The "Ok" result type ("") is not used at all when the function returns, it is only
    used when the function makes recursive calls to itself *)
