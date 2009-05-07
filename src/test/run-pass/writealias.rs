// -*- C -*-

prog a
{
  type point = rec(int x, int y, int z);
  fn f(^point p) -> () {
    p.z = 13;
  }
  main {
    let point x = rec(x=10, y=11, z=12);
    f(x);
    check (x.z == 13);
  }
}