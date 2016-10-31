//Delta Emmett
//Brackets for Bottom Vertex using EMT
//12/9/2015     By: David Bunch
Ht = 12;
HoleID = 4.5;           //I am using M4x25mm bolts to attach brackets to Vertex
BoltHdDia = 7.8;
Qty = 2;        //1, 2 or 4 quantity
module Bracket()
{
    linear_extrude(height = Ht, center = false , convexity = 10)
    import(file = "EMT_SideHoldingBracket_rev5.dxf", layer = "BotBracket");
}
module DrawFinal()
{
    difference()
    {
        Bracket();
        translate([0,-1,Ht/2])
        rotate([-90,0,0])
        cylinder(d=HoleID,h=30,$fn=24);
//Cut for M4 Bolt Head
        translate([0,18.4,Ht/2])
        rotate([-90,0,0])
        cylinder(d=BoltHdDia,h=Ht,$fn=24);
    }
}
module DrawOne()
{
    difference()
    {
        Bracket();
        translate([0,-1,Ht/2])
        rotate([-90,0,0])
        cylinder(d=HoleID,h=30,$fn=24);
//Cut for M4 Bolt Head
        translate([0,18.4,Ht/2])
        rotate([-90,0,0])
        cylinder(d=BoltHdDia,h=Ht,$fn=24);
    }
}
module DrawTwo()
{
    DrawFinal();
    translate([12,11,0])
    rotate([0,0,180])
    DrawFinal();
}
module DrawOne()
{
    DrawFinal();
}
if (Qty == 1)
{
    DrawOne();
}
if (Qty > 1)
{
    DrawTwo();
}
if (Qty > 2)
{
    translate([-7,-60,0])
    DrawTwo();
}
