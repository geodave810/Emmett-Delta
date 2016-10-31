//2 Hole Idler mount for top of Emmett Deltat Vertex
//This will allow for some belt adjustment
//11/23/2015    By: David Bunch
//
Ht = 6;
OD = 24;
ShimOD = 14;
ShimHt = 8.8;
Rad = OD / 2;
echo("Rad = ",Rad);
echo("Rad - 2.6 = ",Rad - 2.6);
X_Offset = 22;
Len = X_Offset * 2;
BumpRad = Rad - 2.6;
M5 = 5.5;
M5Nut = 9.5;
BoltBumpHt = 1.5;
$fn=72;
M5_Res = 24;
Qty = 3;                //1 or 3 parts
Assembly = 0;               //Draw Assembled = 1, Print parts = 0
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
module Pulley()
{
    color("gray")
    difference()
    {
        union()
        {
            cylinder(d=22,h=1.75);
            translate([0,0,1.75])
            cylinder(d=17.6,h=9.25);
            translate([0,0,1.75+9.25])
            cylinder(d=22,h=1.75);
        }
        translate([0,0,-.01])
        cylinder(d=M5,h=12.77);
    }
}
module TaperShim(S_OD = ShimOD)
{
    color("cyan")
    {
        difference()
        {
            union()
            {
                cylinder(d=S_OD,h=2.5);
                translate([0,0,2.5])
                cylinder(d1=S_OD,d2=8.8,h=ShimHt-2.5);
            }
            translate([0,0,-.1])
            cylinder(d=M5,h=ShimHt+.2);
        }
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
module Bolt(BHt=30)
{
    color("red")
    difference()
    {
        union()
        {
            cylinder(d=M5Nut,h=5,$fn=M5_Res);
            translate([0,0,-BHt])
            cylinder(d=M5,h=BHt);
        }
        translate([0,0,3])
        cylinder(d=4,h=5,$fn=6);
    }
}
module Vertex()
{
    translate([0,0,40])
    rotate([0,180,0])
    import("VertexTop_1xEMTAtTop_SideMount_2060V_NoEars_rev43_repaired.stl", convexity=3);
}
module V_Slot_20x60(Ht_A=100)
{
    translate([-20,0,-82])
//This was traced from the V-Slot 20x60 & taking out the small details
    rotate([0,0,-90])
    difference()
    {
        linear_extrude(height = Ht_A, center = false, convexity = 10)polygon(points = 
        [[-2.84,-8.2],[-5.5,-8.2],[-5.5,-6.56],[-2.84,-3.9],[2.84,-3.9],
        [5.5,-6.56],[5.5,-8.2],[2.84,-8.2],[4.64,-10],[8.5,-10],
        [10,-8.5],[10,-4.64],[8.2,-2.84],[8.2,-5.5],[6.56,-5.5],
        [3.9,-2.84],[3.9,2.84],[6.56,5.5],[8.2,5.5],[8.2,2.84],
        [10,4.64],[10,15.36],[8.2,17.16],[8.2,14.5],[6.56,14.5],
        [3.9,17.16],[3.9,22.84],[6.56,25.5],[8.2,25.5],[8.2,22.84],
        [10,24.64],[10,35.36],[8.2,37.16],[8.2,34.5],[6.56,34.5],
        [3.9,37.16],[3.9,42.84],[6.56,45.5],[8.2,45.5],[8.2,42.84],
        [10,44.64],[10,48.5],[8.5,50],[4.64,50],[2.84,48.2],
        [5.5,48.2],[5.5,46.56],[2.84,43.9],[-2.84,43.9],[-5.5,46.56],
        [-5.5,48.2],[-2.84,48.2],[-4.64,50],[-8.5,50],[-10,48.5],
        [-10,44.64],[-8.2,42.84],[-8.2,45.5],[-6.56,45.5],[-3.9,42.84],
        [-3.9,37.16],[-6.56,34.5],[-8.2,34.5],[-8.2,37.16],[-10,35.36],
        [-10,24.64],[-8.2,22.84],[-8.2,25.5],[-6.56,25.5],[-3.9,22.84],
        [-3.9,17.16],[-6.56,14.5],[-8.2,14.5],[-8.2,17.16],[-10,15.36],
        [-10,4.64],[-8.2,2.84],[-8.2,5.5],[-6.56,5.5],[-3.9,2.84],
        [-3.9,-2.84],[-6.56,-5.5],[-8.2,-5.5],[-8.2,-2.84],[-10,-4.64],
        [-10,-8.5],[-8.5,-10],[-4.64,-10]]);
//Cut opening between 20x20's
        translate([0,0,-1])
        linear_extrude(height = Ht_A+2, center = false, convexity = 10)polygon(points = 
        [[-8.2,7.3],[-6.24,7.3],[-2.84,3.9],[2.84,3.9],[6.24,7.3],
        [8.2,7.3],[8.2,12.7],[6.24,12.7],[2.84,16.1],[-2.84,16.1],
        [-6.24,12.7],[-8.2,12.7]]);
//Cut 2nd opening
        translate([0,0,-1])
        linear_extrude(height = Ht_A+2, center = false, convexity = 10)polygon(points = 
        [[-8.2,27.3],[-6.24,27.3],[-2.84,23.9],[2.84,23.9],[6.24,27.3],
        [8.2,27.3],[8.2,32.7],[6.24,32.7],[2.84,36.1],[-2.84,36.1],
        [-6.24,32.7],[-8.2,32.7]]);
        translate([0,0,-1])
        cylinder(d=M5,h=Ht_A+2,$fn=12);      //Drill M5 holes
        translate([0,20,-1])
        cylinder(d=M5,h=Ht_A+2,$fn=12);
        translate([0,40,-1])
        cylinder(d=M5,h=Ht_A+2,$fn=12);
    }
}
if (Assembly == 1)
{
    %Vertex();
    translate([0,-42.50,12])
    rotate([90,0,0])
    {
        DrawFinal();
        color("black")
        translate([0,0,Ht+BoltBumpHt])
        cylinder(d=8.8,h=1);
        translate([0,0,Ht+1+BoltBumpHt])
        Bolt(40);
        translate([-X_Offset,0,Ht])
        Bolt(20);
        translate([X_Offset,0,Ht])
        Bolt(20);
        translate([0,0,-22.875])
        Pulley();
        translate([0,0,0])
        rotate([180,0,0])
        TaperShim();
        color("black")
        translate([0,0,-10.125])
        cylinder(d=8.8,h=1);
        color("black")
        translate([0,0,-23.875])
        cylinder(d=8.8,h=1);
        color("silver")
        translate([0,0,-28.875])
        cylinder(d=9,h=5,$fn=6);
        rotate([-90,0,0])
        translate([0,42.5,0])
        %V_Slot_20x60(100);
}
} else {
    DrawFinal();
    if (Qty > 2)
    {
        translate([0,30,0])
        DrawFinal();
        translate([0,-30,0])
        DrawFinal();
    }
}