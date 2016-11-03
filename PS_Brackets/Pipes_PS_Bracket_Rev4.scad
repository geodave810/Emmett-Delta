//Delta Emmett P/S Mounting Bracket
//Bracket for mounting P/S on 2 - 1/2" EMT, 2 - 3/4" EMT or 2 - 1/2" PVC Horizontals
//12/9/2015     By: David Bunch
//10/23/2016    Modified for use with an P/S holding bracket
//11/3/2016     Combined 1/2"EMT, 3/4"EMT & 1/2"PVC into 1 file

Ht = 12;
ET = 0;                 //0 = 1/2", 1 = 3/4", 2 = 1/2" PVC
HoleID = 3.5;           //Probably need M3x16mm screws for Bracket mount to 3/4" EMT
                        //and M3x30mm screws for 1/2" EMT or 1/2" PVC
PS_Hole_OD = 4.5;       //Diameter of Hole for P/S
BoltHdDia = 7.8;        //Diameer of M3 Bolt Head
M3Nut = 7;              //Diameter of M3 Nut to use

//Setup arrays to choose between 1/2"EMT, 3/4"EMT or 1/2"PVC based on ET variable
A_Pipe_Type = [12,34,12];
A_Pipe_OD = [18.4,23.7,21.8];
A_Hole_Y_Offset = [12.5,20,14.2];
A_PS_Hole_Y_Offset = [58.8,41.15,53.7];
A_M3Head_X_Offset = [9.7,5,10.48];
A_M3Nut_X_Offset = [-9.7,-4.97,-10.48];

Ht2 = Ht / 2;

Pipe_Type = A_Pipe_Type[ET];
Pipe_OD = A_Pipe_OD[ET];
Hole_Y_Offset = A_Hole_Y_Offset[ET];
Pipe_Y_Offset = Hole_Y_Offset * 2;
PS_Hole_Y_Offset = A_PS_Hole_Y_Offset[ET];
M3Head_X_Offset = A_M3Head_X_Offset[ET];
M3Nut_X_Offset = A_M3Nut_X_Offset[ET];

Hole_Res = 24;
Pipe_Res = (round(((Pipe_OD * 3.14)/4)/.7)*4);      //Resolution for Chamfer Pipe Cuts
echo(Pipe_Res = Pipe_Res);
$fn=76;
module PS_Bracket()
{
    if (ET < 2)
    {
        linear_extrude(height = Ht, center = false, convexity = 10)
        import("Pipes_PS_Brackets.dxf", layer = str("EMT",Pipe_Type,"_PS_Bracket_Outline"));
    } else
    {
        linear_extrude(height = Ht, center = false, convexity = 10)
        import("Pipes_PS_Brackets.dxf", layer = str("PVC",Pipe_Type,"_PS_Bracket_Outline"));
    }
}
module PS_Bracket_Cut()
{
    if (ET < 2)
    {
    translate([0,0,-1])
        linear_extrude(height = Ht+ 2, center = false, convexity = 10)
        import("Pipes_PS_Brackets.dxf", layer = str("EMT",Pipe_Type,"_PS_Bracket_Cutout"));
    } else
    {
    translate([0,0,-1])
        linear_extrude(height = Ht + 2, center = false, convexity = 10)
        import("Pipes_PS_Brackets.dxf", layer = str("PVC",Pipe_Type,"_PS_Bracket_Cutout"));
    }
}
module CutNutTrap()
{
    rotate([0,90,0])
    rotate([90,0,0])
    {
        translate([0,0,-2.25])
        cylinder(d=7,h=4.5,$fn=6);
        translate([-20,-3.0311,-2.25])
        cube([20,6.0622,4.5]);
    }
}
module TaperPipe_Hole()
{
    translate([0,0,Ht-1])
    cylinder(d1 = Pipe_OD, d2 = Pipe_OD+2, h = 1.01, $fn = Pipe_Res);
    translate([0,-Pipe_Y_Offset,Ht-1])
    cylinder(d1=Pipe_OD,d2=Pipe_OD+2,h=1.01, $fn = Pipe_Res);

    translate([0,0,-.01])
    cylinder(d1 = Pipe_OD + 2, d2 = Pipe_OD, h = 1.01, $fn = Pipe_Res);
    translate([0,-Pipe_Y_Offset,-.01])
    cylinder(d1 = Pipe_OD + 2, d2 = Pipe_OD, h = 1.01, $fn = Pipe_Res);
}
module DrawBracket()
{
    difference()
    {
        PS_Bracket();
        PS_Bracket_Cut();
        {
            translate([-15,-Hole_Y_Offset,Ht2])
            rotate([0,90,0])
            cylinder(d=HoleID,h=30,$fn=Hole_Res);         //M3 hole to tighten Bracket around 1/2" EMT
    
            translate([M3Head_X_Offset,-Hole_Y_Offset,Ht2])
            rotate([0,90,0])
            cylinder(d=6,h=3,$fn=Hole_Res);               //Countersink M3 socket head by 2mm
            translate([M3Nut_X_Offset,-Hole_Y_Offset,Ht2])
            rotate([0,-90,0])
            cylinder(d=M3Nut,h=3,$fn=6);               //Countersink M3 Nut by 2mm
        }

        translate([8.2,PS_Hole_Y_Offset,Ht/2])
        rotate([0,90,0])
        cylinder(d=PS_Hole_OD,h=30,$fn=Hole_Res);         //M4 hole for P/S
        TaperPipe_Hole();
//        translate([0,0,Ht2])
//        cylinder(d=300,h=100);                    //Cross Section Test
    }
}
DrawBracket();