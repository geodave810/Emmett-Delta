//Delta Emmett
//Heat Bed or Build Plate Brackets for 1/2" EMT, 3/4" EMT or 1/2" PVC
//12/9/2015     By: David Bunch
//11/3/2016     Revised to include brackets for 1/2" EMT, 3/4" EMT or 1/2" PVC
ET = 0;         //0 = 1/2" EMT, 1 = 3/4" EMT or 2 = 1/2" PVC
Ht = 12;        //Height of Bracket
Ht2 = Ht / 2;
HoleID = 3.6;           //Use M3 screws
BoltHdDia = 7.8;
M3Nut = 7;
M3NutHt = 4.6;

//Array variables using index variable ET to determine values to us
A_Pipe_OD = [18.4,23.7,21.8];
A_Hole_Y_Offset = [12.5,20,14.2];
A_PS_Hole_Y_Offset = [58.8,41.15,53.7];
A_M3Head_X_Offset = [9.7,5,10.48];
A_M3Nut_X_Offset = [-9.7,-4.97,-10.48];

Pipe_OD = A_Pipe_OD[ET];
Hole_Y_Offset = A_Hole_Y_Offset[ET];
Pipe_Y_Offset = Hole_Y_Offset * 2;
PS_Hole_Y_Offset = A_PS_Hole_Y_Offset[ET];
M3Head_X_Offset = A_M3Head_X_Offset[ET];
M3Nut_X_Offset = A_M3Nut_X_Offset[ET];
Pipe_Rad = Pipe_OD / 2;
NutAccess_OD = (cos(30)* (M3Nut/2)) * 2;    //Flat side dia. of M3Nut
echo(NutAccess_OD = NutAccess_OD);

Hole_Res = 24;
Pipe_Res = (round(((Pipe_OD * 3.14)/4)/.7)*4);      //Resolution for Chamfer Pipe Cuts
echo(Pipe_Res = Pipe_Res);
$fn=24;
module HB_Bracket()
{
    if (ET == 0)
    {
        linear_extrude(height = Ht, center = false, convexity = 10)
        import("HB_PipeBrackets.dxf", layer = "EMT12_Outline");
    } else if (ET == 1)
    {
        linear_extrude(height = Ht, center = false, convexity = 10)
        import("HB_PipeBrackets.dxf", layer = "EMT34_Outline");
    } else if (ET == 2)
    {
        linear_extrude(height = Ht, center = false, convexity = 10)
        import("HB_PipeBrackets.dxf", layer = "PVC12_Outline");
    }
}
module CutNutTrap()
{
    rotate([0,90,0])
    rotate([90,0,0])
    {
        translate([0,0,-M3NutHt / 2])
        cylinder(d = M3Nut, h = M3NutHt, $fn = 6);
        translate([-20, -(NutAccess_OD / 2), -(M3NutHt / 2)])
        cube([20,NutAccess_OD,M3NutHt]);
    }
}
module TaperPipe_Hole()
{
    translate([0,0,Ht-1])
    cylinder(d1 = Pipe_OD, d2 = Pipe_OD + 2, h = 1.01, $fn = Pipe_Res);
    translate([0,-Pipe_Y_Offset,Ht-1])
    cylinder(d1 = Pipe_OD, d2=Pipe_OD + 2, h = 1.01, $fn = Pipe_Res);

    translate([0,0,-.01])
    cylinder(d1 = Pipe_OD + 2, d2 = Pipe_OD, h = 1.01, $fn = Pipe_Res);
    translate([0,-Pipe_Y_Offset, -.01])
    cylinder(d1 = Pipe_OD + 2, d2 = Pipe_OD, h = 1.01, $fn = Pipe_Res);
}
module DrawBracket()
{
    difference()
    {
        HB_Bracket();

        translate([0, Pipe_Rad + 7.5, Ht2])
        CutNutTrap();

        translate([0, 0, Ht2])
        rotate([-90,0,0])
        cylinder(d = HoleID, h = 26, $fn = 24);

        translate([0,Pipe_Rad + 7.5,-1])
        cylinder(d = HoleID, h = 30, $fn = 24);         //Add Hole to release Nut

        translate([-15,-Hole_Y_Offset,Ht2])
        rotate([0,90,0])
        cylinder(d = HoleID, h = 30, $fn = Hole_Res);   //M3 hole to tighten Bracket around Pipe

        translate([M3Head_X_Offset,-Hole_Y_Offset,Ht2])
        rotate([0,90,0])
        cylinder(d = 6, h = 3, $fn = Hole_Res);         //Countersink M3 socket head by 2mm
        translate([M3Nut_X_Offset,-Hole_Y_Offset,Ht2])
        rotate([0,-90,0])
        cylinder(d = M3Nut, h = 3, $fn = 6);               //Countersink M3 Nut by 2mm          
//Taper for easier assembly of Pipes
        TaperPipe_Hole();
    }
}
DrawBracket();