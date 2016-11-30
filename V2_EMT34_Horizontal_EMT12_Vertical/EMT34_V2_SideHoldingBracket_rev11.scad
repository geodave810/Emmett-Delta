//Vertex Brackets for Version 2 of 3/4" Horizontal EMT
//11/30/2016    By: David Bunch
//
Ht = 8;
HoleID = 3.6;           //Use M3 screws
BoltHdDia = 7.8;
M3Nut = 7;
M3NutHt = 4.6;
Ht2 = Ht / 2;
$fn=24;
module Ver34Bracket()
{
    difference()
    {
        linear_extrude(height = Ht, center = false , convexity = 10)
        import(file = "EMT34_V2_SideHoldingBracket_rev10.dxf", layer = "Ver34Bracket_V2");
        translate([0,-15.15,0])
        Holes();
    }
}
module Holes()
{
    translate([0, 0, Ht2])
    rotate([0,90,0])
    cylinder(d = HoleID, h = 42,center=true);
    translate([-9.52,0,Ht2])
    rotate([0,-90,0])
    cylinder(d = 6, h = 3);         //Countersink M3 socket head by 2mm
}

module Ver34_ExtBracket()
{
    difference()
    {
        linear_extrude(height = Ht, center = false , convexity = 10)
        import(file = "EMT34_V2_SideHoldingBracket_rev10.dxf", layer = "Ver34_ExtBracket_V2");
        translate([0,-15.15,0])
        Holes();
        translate([0,24.85,0])
        Holes();
    }
}
module Dove34_Bracket()
{
    difference()
    {
        linear_extrude(height = Ht, center = false , convexity = 10)
        import(file = "EMT34_V2_SideHoldingBracket_rev10.dxf", layer = "Ver34DoveBracket_V2");
        translate([0,-15.15,0])
        Holes();
    }
}

module Bump()
{
    translate([0,0,-3])
    cylinder(d1=0,d2=6,h=3.01,$fn=6);
    cylinder(d=6,h=25,$fn=6);
    translate([0,0,24.99])
    cylinder(d1=6,d2=0,h=3,$fn=6);
}
module BracketCube()
{
    union()
    {
        difference()
        {
            translate([-7.25,-Ht2,0])
            cube([54.5,Ht,4]);
            translate([0,0,-1])
            cylinder(d=HoleID,h=30,$fn=24);
            translate([40,0,-1])
            cylinder(d=HoleID,h=30,$fn=24);

        }
        translate([6.95,0,Ht/2])
        rotate([0,90,0])
        Bump();
    }
}
translate([19,0,0])
rotate([0,0,-90])
BracketCube();              //Back part of Extended Bracket

Ver34_ExtBracket();         //Front part of Extended Bracket

translate([-8,-30.3,0])
rotate([0,0,180])
Ver34Bracket();             //Main Bracket

translate([-42,0,0])
Dove34_Bracket();           //Bracket to hold pipe to vertex & vertex to Dovetail Frame