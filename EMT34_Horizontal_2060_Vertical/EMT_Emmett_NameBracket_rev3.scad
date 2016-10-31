//Name Bracket to Attach to two sides of Tetrahedron Pipe on top of Printer
//11/29/15  By: David Bunch
//
OD=32;              //Outside Diameter of EMT Clamp
ID=24;              //Diameter of 3/4" EMT
M3=3.5;             //Diameter of Holes
Ht=12;              //height of Clamp
Rad=OD/2;
$fn=102;
Assembly = 0;       //0 = Draw printable part, 1 = assemble, 2 = Draw as designed
module EMT_Wrap()
{
    difference()
    {
        cylinder(d=OD,h=Ht);
        translate([0,0,-1])
        cylinder(d=ID,h=Ht+2);
        rotate([0,0,90])            //Originally was putting locknuts parrallel with Arms
                                    //But better printing the part this way
        translate([-OD,-1,-1])
        cube([OD,2,Ht+2]);
        translate([0,-(ID/2-.6),-1])
        scale([.578,1,1])                           //Makes chamfer angle 60 deg. instead of 45
        cylinder(d=10,h=Ht+2,$fn=4);     //Chamfer the Slot Opening

    }
    %cylinder(d=ID,h=246,center=true);
}
module NutLockWelds()
{
    translate([-6,-13.86,0])
    cylinder(d=4,h=Ht,$fn=4);
    translate([6,-13.86,0])
    cylinder(d=4,h=Ht,$fn=4);
}
module Arm()
{
    translate([0,Rad-4,12])
    rotate([-90,0,0])
    difference()
    {
        linear_extrude(height = 4, center = false, convexity = 10)polygon(points = 
        [[47.21,-26.59],[28.39,6],[27.98,6.67],[27.52,7.31],[27.02,7.91],
        [26.49,8.49],[25.91,9.02],[25.31,9.52],[24.67,9.98],[24,10.39],
        [23.31,10.76],[22.59,11.09],[21.86,11.36],[21.11,11.59],[20.34,11.77],
        [19.57,11.9],[18.78,11.97],[18,12],[0,12],[0,0],
        [18,0],[18.65,-0.04],[19.29,-0.17],[19.91,-0.38],[20.5,-0.67],
        [21.04,-1.03],[21.54,-1.46],[21.97,-1.96],[22.33,-2.5],[38.98,-31.34],
        [39.36,-31.9],[39.81,-32.4],[40.34,-32.83],[40.92,-33.18],[41.54,-33.45],
        [42.19,-33.63],[42.87,-33.71],[43.54,-33.69],[44.21,-33.58],[44.86,-33.37],
        [45.47,-33.08],[46.03,-32.7],[46.53,-32.24],[46.96,-31.72],[47.31,-31.14],
        [47.58,-30.52],[47.76,-29.86],[47.84,-29.19],[47.82,-28.51],[47.71,-27.84],
        [47.5,-27.2]]);
        translate([43.09,-28.96,-1])
        cylinder(d=M3,h=6,$fn=24);
        translate([32.64,-10.85,-1])
        cylinder(d=M3,h=6,$fn=24);
    }
}
module FillCorner()
{
    linear_extrude(height = Ht, center = false, convexity = 10)polygon(points = 
    [[12,0],[16,0],[16,10],[18,12],[18,13],
    [9.95,13],[12,6.99]]);
}
module BottomFlat()
{
    linear_extrude(height = Ht, center = false, convexity = 10)polygon(points = 
    [[-16,0],[-14,0],[-14,5.8],[-5.8,14],[0,14],
    [0,16],[-9.24,16],[-16,4.29]]);
}

module NutLock()
{
    rotate([0,0,90])
    translate([-Rad,0,0])
    rotate([90,0,0])
    difference()
    {
        linear_extrude(height = 5, center = false, convexity = 10)polygon(points = 
        [[1.28,12],[-4.6,12],[-7.64,8.96],[-8.08,8.31],[-8.23,7.55],
        [-8.23,4.45],[-8.08,3.69],[-7.64,3.04],[-4.6,0],[1.28,0]]);
        translate([-4.11,6,-1])
        cylinder(d=M3,h=7,$fn=24);
    }
}
module DrawFinal()
{
    union()
    {
        EMT_Wrap();
        translate([1,0,0])
        NutLock();
        translate([-6,0,0])
        NutLock();
        Arm();
        FillCorner();
        BottomFlat();
        NutLockWelds();
    }
}
if (Assembly == 1)
{
    rotate([0,150,0])
    DrawFinal();
    translate([-144,0,0])
    rotate([0,-150,0])
    mirror([1,0,0])
    DrawFinal();
    translate([-132,8,-61.5])
    %cube([120,4,30]);
} else if (Assembly == 0){
    translate([0,0,Rad])
    rotate([-90,0,0])
    DrawFinal();                    //Draw part for 1 side
    translate([0,-Ht-5,Rad])
    rotate([-90,0,0])
    mirror([1,0,0])
    DrawFinal();                    //Mirror part for other side
} else {
    DrawFinal();            //Draw As is
}