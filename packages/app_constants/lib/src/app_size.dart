import 'package:flutter/material.dart';

/// Constant sizes to be used in the app (paddings, gaps, rounded corners etc.)
/// must be 4, 8, 12, 16, 24, 32, 48
enum KEdgeInsets {
  a4(EdgeInsets.all(4)),
  a8(EdgeInsets.all(8)),
  a12(EdgeInsets.all(12)),
  a16(EdgeInsets.all(16)),
  a24(EdgeInsets.all(24)),
  a32(EdgeInsets.all(32)),
  a48(EdgeInsets.all(48)),

  h4(EdgeInsets.symmetric(horizontal: 4)),
  h8(EdgeInsets.symmetric(horizontal: 8)),
  h12(EdgeInsets.symmetric(horizontal: 12)),
  h16(EdgeInsets.symmetric(horizontal: 16)),
  h24(EdgeInsets.symmetric(horizontal: 24)),
  h32(EdgeInsets.symmetric(horizontal: 32)),
  h48(EdgeInsets.symmetric(horizontal: 48)),

  v4(EdgeInsets.symmetric(vertical: 4)),
  v8(EdgeInsets.symmetric(vertical: 8)),
  v12(EdgeInsets.symmetric(vertical: 12)),
  v16(EdgeInsets.symmetric(vertical: 16)),
  v24(EdgeInsets.symmetric(vertical: 24)),
  v32(EdgeInsets.symmetric(vertical: 32)),
  v48(EdgeInsets.symmetric(vertical: 48)),

  ol4(EdgeInsets.only(left: 4)),
  ol8(EdgeInsets.only(left: 8)),
  ol12(EdgeInsets.only(left: 12)),
  ol16(EdgeInsets.only(left: 16)),
  ol24(EdgeInsets.only(left: 24)),
  ol32(EdgeInsets.only(left: 32)),
  ol48(EdgeInsets.only(left: 48)),

  ot4(EdgeInsets.only(top: 4)),
  ot8(EdgeInsets.only(top: 8)),
  ot12(EdgeInsets.only(top: 12)),
  ot16(EdgeInsets.only(top: 16)),
  ot24(EdgeInsets.only(top: 24)),
  ot32(EdgeInsets.only(top: 32)),
  ot48(EdgeInsets.only(top: 48)),

  or4(EdgeInsets.only(right: 4)),
  or8(EdgeInsets.only(right: 8)),
  or12(EdgeInsets.only(right: 12)),
  or16(EdgeInsets.only(right: 16)),
  or24(EdgeInsets.only(right: 24)),
  or32(EdgeInsets.only(right: 32)),
  or48(EdgeInsets.only(right: 48)),

  ob4(EdgeInsets.only(bottom: 4)),
  ob8(EdgeInsets.only(bottom: 8)),
  ob12(EdgeInsets.only(bottom: 12)),
  ob16(EdgeInsets.only(bottom: 16)),
  ob24(EdgeInsets.only(bottom: 24)),
  ob32(EdgeInsets.only(bottom: 32)),
  ob48(EdgeInsets.only(bottom: 48)),
  ;

  const KEdgeInsets(this.size);

  final EdgeInsets size;
}

enum KSizedBox {
  h4(SizedBox(height: 4)),
  h8(SizedBox(height: 8)),
  h12(SizedBox(height: 12)),
  h16(SizedBox(height: 16)),
  h24(SizedBox(height: 24)),
  h32(SizedBox(height: 32)),
  h48(SizedBox(height: 48)),
  h64(SizedBox(height: 64)),
  h96(SizedBox(height: 96)),

  w4(SizedBox(width: 4)),
  w8(SizedBox(width: 8)),
  w12(SizedBox(width: 12)),
  w16(SizedBox(width: 16)),
  w24(SizedBox(width: 24)),
  w32(SizedBox(width: 32)),
  w48(SizedBox(width: 48)),
  w64(SizedBox(width: 64)),
  w96(SizedBox(width: 96)),
  ;

  const KSizedBox(this.size);

  final SizedBox size;
}

enum KRadius {
  r4(Radius.circular(4)),
  r8(Radius.circular(8)),
  r12(Radius.circular(12)),
  r16(Radius.circular(16)),
  rT16(Radius.circular(16)),
  r32(Radius.circular(32)),
  ;

  const KRadius(this.radius);
  final Radius radius;
}
