(* 
 * This module goes near the *bottom* of the dependency DAG, and holds logging, 
 * option, and global-state machinery for a single run of the compiler.
 *)

open Common;;

type sess = 
{
  mutable sess_crate: filename;
  mutable sess_out: filename;
  mutable sess_targ: target;
  mutable sess_log_lex: bool;
  mutable sess_log_parse: bool;
  mutable sess_log_resolve: bool;
  mutable sess_log_type: bool;
  mutable sess_log_trans: bool;
  mutable sess_log_ra: bool;
  mutable sess_log_insn: bool;
  mutable sess_log_obj: bool;
  mutable sess_log_out: out_channel;
  mutable sess_failed: bool;
}
;;


let log name flag chan = 
  let k1 s = 
    Printf.fprintf chan "%s: %s\n%!" name s
  in
  let k2 s = () in 
    Printf.ksprintf (if flag then k1 else k2)
;;

let fail sess = 
  sess.sess_failed <- true;
  Printf.fprintf sess.sess_log_out
;;


let string_of_pos (p:pos) = 
  let (filename, line, col) = p in
  Printf.sprintf "%s:%d:%d" filename line col
;;


let string_of_span (s:span) = 
	let (filename, line0, col0) = s.lo in 
	let (_, line1, col1) = s.hi in 
	Printf.sprintf "%s:%d:%d - %d:%d" filename line0 col0 line1 col1
;;


(* 
 * Local Variables:
 * fill-column: 70; 
 * indent-tabs-mode: nil
 * compile-command: "make -k -C .. 2>&1 | sed -e 's/\\/x\\//x:\\//g'"; 
 * End:
 *)