//2 Hole Idler mount for top of Emmett-Delta Vertex
//
//11/23/2015    By: David Bunch
//
Ht = 6;
OD = 24;
ShimOD = 14;
ShimHt = 8.8-2;
Rad = OD / 2;
echo("Rad = ",Rad);
echo("Rad - 2.6 = ",Rad - 2.6);
X_Offset = 19;                      //Gives 38mm between outer holes
Len = X_Offset * 2;
BumpRad = Rad - 2.6;
M5 = 5.5;
M5Nut = 9.5;
BoltBumpHt = 1.5;
$fn=72;
M5_Res = 24;
Qty = 1;                //1 or 3 parts
module SideBump()
{
    difference()
    {
        rotate_extrude(convexity = 10, $fn = 72)
        translate([BumpRad, 0, 0])
        rotate([0,0,30])
        circle(r = 3, $fn = 6);
        translate([0,-20,-20])
        cube([40,40,40]);
    }
}
module Plate()
{
    union()
    {
        translate([-X_Offset,0,0])
        cylinder(d=OD,h=Ht);            //Draw Left Side of Plate
        translate([X_Offset,0,0])
        cylinder(d=OD,h=Ht);            //Draw Right Side of Plate
        translate([-X_Offset,-Rad,0])
        cube([Len,OD,Ht]);              //Draw Cube connecting Left & Right Side

        translate([-X_Offset,0,Ht])
        SideBump();                     //Draw left Side Bumps
        translate([X_Offset,0,Ht])
        rotate([0,0,180])
        SideBump();                     //Draw Right Side Bumps

        translate([-X_Offset,-BumpRad,Ht])
        rotate([0,90,0])
        cylinder(d=6,h=Len+.001,$fn=6);   //Draw Bump along the Bottom of Plate
        translate([-X_Offset,BumpRad,Ht])
        rotate([0,90,0])
        cylinder(d=6,h=Len+.001,$fn=6);      //Draw Bump along the Top of Plate
        translate([0,0,Ht])
        cylinder(d1=15,d2=13.6,h=BoltBumpHt);    //Raised Center part by 1.5mm for better fit
    }
}
module DrawFinal()
{
    difference()
    {
        Plate();
        translate([0,0,-1])
        cylinder(d=M5,h=Ht+3,$fn=M5_Res);
        translate([-X_Offset,0,-1])
        cylinder(d=M5,h=Ht+2,$fn=M5_Res);
        translate([X_Offset,0,-1])
        cylinder(d=M5,h=Ht+2,$fn=M5_Res);
    }
}
DrawFinal();
if (Qty > 2)
{
    translate([0,30,0])
    DrawFinal();
    translate([0,-30,0])
    DrawFinal();
}