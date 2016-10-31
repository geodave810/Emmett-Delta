//Limit Switch holder for Delta - Emmett
//Orgin is at center of Aluminum 2060
//11/26/2015    By: David Bunch

Len = 20;           //Length of Switchh
Wid = 10.5;         //Width of Switch
Ht = 6.5;           //Height or thickness of Switch
$fn=24;
M5 = 5.5;           //Diameter of M5 Bolt
M5Head = 9.5;       //Daimeter of M5 Head (not used here)
M2_5 = 2.6;         //Diameter of M2.5 bolt or Wire tie holes
Holder_Ht = 15;     //Height Limit Switch Holder
Holder_Half = Holder_Ht / 2;
Qty = 3;            //1 or 3
Assembled = 0;      //1 = Show relavent Parts assembled, 0 = No
module VSlot_Holder()
{
    difference()
    {
        linear_extrude(height = Holder_Ht, center = false, convexity = 10)polygon(points = 
        [[-9.58,-14],[-9.43,-14.77],[-8.99,-15.41],[-8.35,-15.85],[-7.58,-16],
        [4.82,-16],[5.52,-16.03],[6.21,-16.12],[6.89,-16.27],[7.56,-16.48],
        [8.2,-16.75],[8.82,-17.07],[9.41,-17.45],[9.96,-17.87],[10.48,-18.34],
        [10.95,-18.86],[11.38,-19.41],[11.75,-20],[20.17,-34.58],[20.35,-34.84],
        [20.56,-35.07],[20.81,-35.26],[21.09,-35.41],[21.38,-35.52],[21.69,-35.57],
        [22.01,-35.58],[22.32,-35.54],[22.62,-35.45],[22.9,-35.32],[25.5,-33.82],
        [11.75,-10],[4.58,-10],[2.89,-8.31],[-2.89,-8.31],[-4.58,-10],
        [-9.58,-10]]);
        translate([0,-17,Holder_Half])
        rotate([-90,0,0])
        cylinder(d=M5,h=20);        //Drill hole for M5 screw into Tnut
//Drill hole for WireTies or M2.5 bolts
        translate([12.83,-23.86,Holder_Half])
        rotate([0,0,-60])
        rotate([-90,0,0])
        cylinder(d=M2_5,h=12);          //Drill hole for WireTies
        translate([17.63,-32.18,Holder_Half])
        rotate([0,0,-60])
        rotate([-90,0,0])
        cylinder(d=M2_5,h=12);          //Drill hole for WireTies
    }
}
module Pin()
{
    color("silver")
    cube([.5,4,3]);
}
module Pins3()
{
    Pin();
    translate([8,0,0])
    Pin();
    translate([16.8,0,0])
    Pin();
}
module Lever()
{
    cube([19,.5,4]);
    translate([19-2.25,-4.25,0])
    {
        color("red")
        {
            cylinder(d=4.5,h=4);
            translate([-2.25,0,0])
            cube([4.5,2.25+2,4]);
        }
    }
}
module DrawUnion()
{
    union()
    {
        cube([Len,Wid,Ht]);
        translate([1.5,10.4,2])
        Pins3();
        rotate([0,0,-5])
        translate([3,0,1])
        Lever();
    }
}
module DrawSwitch()
{
    difference()
    {
        DrawUnion();
        translate([5.3,7.7,-1])
        cylinder(d=2.5,h=8.5);
        translate([15,7.7,-1])
        cylinder(d=2.5,h=Ht+2);
    }
}
module Idler_Cap()
{
    //color("red")
    import("Idler_2holeMount_44mmHoleSpacingAssembly_rev8_repaired.stl", convexity=3);
}
module TimingBelt()
{
    color("black")
    import("TimingBelt_100mm.stl", convexity=3);
}
module Carriage()
{
    color("Orange")
    import("carriage_20x60_Rev20_repaired.stl", convexity=3);
}
module CarriageBack()
{
    rotate([0,0,180])
    color("Orange")
    import("BackPlate_20x60_Rev20_repaired.stl", convexity=3);
}
module V_Slot_2060()
{
    rotate([180,0,0])
    import("V_Slot_2060_140mm.stl", convexity=3);
}
module Vertex()
{
    translate([0,0,6])
    color("blue")
    rotate([180,0,0])
    import("VertexTop_1xEMTAtTop_SideMount_2060V_NoEars_rev43_repaired.stl", convexity=3);
}
if (Assembled == 1)
{
%V_Slot_2060();

rotate([0,0,180])
#translate([0,0,-35])
%Idler_Cap();
%Vertex();

translate([0,0,-68])
{
    translate([0,10+1.5,0])
    rotate([-90,0,0])
    Carriage();         //Measures 1.5mm clearance from Vertical 2060
    translate([0,-11.5,0])
    rotate([90,0,0])
    CarriageBack();
}

translate([0,22,-22])
rotate([-90,0,0])
TimingBelt();

translate([0,0,-50])
rotate([0,0,180])
{
    translate([15.5,-16.5,0])
    rotate([0,0,120])
    rotate([90,0,0])
    translate([-20,0,0])
    %DrawSwitch();
    
    VSlot_Holder();
}
} else {
    if (Qty == 3)
    {
        VSlot_Holder();
        translate([8,14,0])
        VSlot_Holder();
        translate([16,28,0])
        VSlot_Holder();
    } else {
        VSlot_Holder();
    }
}