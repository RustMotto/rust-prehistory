let _ =
  if Array.length Sys.argv != 2
  then
    (Printf.printf "usage: %s FILE.rc\n"  Sys.argv.(0);
     exit 1);
  let fname = Sys.argv.(1) in
  let crate_items = Ll1parser.parse_crate Lexer.token fname in
    Printf.printf "parsed OK\n";
	Semant.resolve_mod_items Semant.root_ctxt crate_items;
	Pe.emit_testfile "rust_out.exe";
;;