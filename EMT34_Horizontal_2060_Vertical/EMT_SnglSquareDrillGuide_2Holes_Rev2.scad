//Drill guide for drilling holes in 3/4" EMT
//I used a drill press for better accuracy
//By: David Bunch 10/24/2015

Pipe_Spacing = 37;     //gives 6mm clearance top & bottom of 86mm high vertex
                        //We Need 45mm to put Pipe Tensioning mount in vertically
Pipe_SpaceHalf = Pipe_Spacing / 2;
MinkSub = 0;            //use 4 of using minkowski
Len=37.7-MinkSub;
Wid=37.7-MinkSub;
TotWid = 37.7;
Len_Half = Len / 2;
Wid_Half = Wid /2;
TotHt = 55;
Ht = TotHt-MinkSub;

Ht_2 = TotHt / 2;

EMT_OD=23.7;
EMT_Res = 106;
M3 = 3.4;
M5 = 5.15;
$fn=24;
M3_ires=24;
M3NutDia=9.18;

M3Nut_Ht=4.7;
RotNut=30;
module DrHole()
{
    rotate([0,90,0])
    cylinder(d=M5,h=Len+10,center=true);
}
module Plate()
{
    rotate([0,0,90])
    linear_extrude(height = Ht, center = false, convexity = 10)polygon(points = 

    [[-18.85,-7.81],[-10.81,-15.85],[10.81,-15.85],
    [18.85,-7.81],[18.85,7.54],[5.81,20.85],
    [-5.81,20.85],[-18.85,7.81]]);
}
module PipeConnectSngl()
{
    Plate();
}
module EMT_Nut()
{
    translate([-1,TotWid/2+.5,Ht_2])
    rotate([-90,0,0])
    rotate([0,-90,0])
    difference()
    {
        linear_extrude(height = 6, center = false, convexity = 10)polygon(points = 
        [[8.23,-1.74],[8.23,1.74],[8.19,2.13],[8.08,2.51],[7.89,2.86],
        [7.64,3.16],[0,10.8],[-0.86,10.8],[-0.86,-10.8],[0,-10.8],
        [7.64,-3.16],[7.89,-2.86],[8.08,-2.51],[8.19,-2.13]]);
        translate([4.1,0,-1])
        cylinder(d=M3,h=8,$fn=24);
    }
        translate([-1,TotWid/2+.5,Ht_2])
    rotate([-90,0,0])
    rotate([0,-90,0])
    translate([4.1,0,-1])
    rotate([0,0,30])
    %cylinder(d=M3NutDia,h=8,$fn=6);
}
module EMT_NutsSide()
{
    EMT_Nut();
    translate([8,0,0])
    EMT_Nut();
}
module PipeSlots()
{
    translate([-1,-1,-1])
    cube([2,EMT_OD,Ht+20]);
}
module Pipes()
{
    translate([0,0,-1])
    cylinder(d=EMT_OD,h=100,$fn=EMT_Res);
}
module DrawFinal()
{
    difference()
    {
        union()
        {
            PipeConnectSngl();
            EMT_NutsSide();
        }
        Pipes();

        PipeSlots();
        translate([0,0,9])
        DrHole();
        translate([0,0,46])
        DrHole();

    }
}
rotate([90,0,0])
DrawFinal();