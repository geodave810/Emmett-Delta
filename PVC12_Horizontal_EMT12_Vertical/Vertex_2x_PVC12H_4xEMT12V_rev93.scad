// Emmett-Delta 3D Printer 
// Based on Delta-Six Vertex Created by Sage Merrill
// Base on https://github.com/Jaydmdigital/Kossel_2020
// Released on Openbuilds.com
// which was Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

//Modified by David Bunch to handle 3/4" Electrical Conduit Pipe for Horizontals

//Modified 2/1/2016 to handle 4x 1/2" Electrical Conduit Pipes Vertically 

//Printed 1st test 10/28/2016
//3.4oz 40% infill PLA & print time of 06:58:22
//$vpt=[-4.8,-22,25.6];
//$vpr =[55,0,71.2];
//$vpd =435;
height = 49.8;
ExtendHt = 0;          //Extend height above main part

EMT_OD = 18.4;
EMT12_OD = 18.4;
EMT12_Rad = EMT12_OD / 2;
EMT_Rad = EMT_OD / 2;
EMT_EndHole_OD = 8;
EMT_EndHole_Res = 36;

PVC12_OD = 21.4;
PVC12_Rad = PVC12_OD / 2;
PVC_Hor_X = 25.79;
PVC_Hor_Y = 16.61;

Ht_Half = height / 2;

M5 = 5.5;
M5Nut = 10.0;               //Locknut measures 9.1mm but adding 10%
                            //Used for Idler Mount bracket
                            //This should make it a little easier to put the Locknut on
M4 = 4.6;
Wire_Z_Height = 4;
M8 = 8.5;
M3 = 3.5;
M3_Res = 16;
M5_Res = 24;
PipeScrewDia = 4.5;   //Dia. of holes for Screws that mount EMT Pipe to Vertex
                       //Use 5.15 to 5.5 for M5, or 4.15 to 4.5 for M4
Screw_X1_Offset = 43.63;
Screw_Y1_Offset = 16.99;
Screw_X2_Offset = 64.63;
Screw_Y2_Offset = 53.36;
Pipe_Qty = 2;

Pipe_Spacing = 28.4;      //Use +20 for pipe at bottom & -20 for pipe even with top
ScrewSockSpace = 12.5;   //Spacing between t-Slot screw holes in corner

BaseThk = 4;
$fn=48;
PipeBaseThk=0;
IdlerMnt_X_Offset = 19;             //Idler Mount Bolt offset from center
                                    //Need at leas 20mm for 5mm thick plastic from Center hole
Idler_Move = 0;

Pipe_Z = PVC12_Rad;                       //Pipe will be level with bottom, so we can add corner part at top

TotHt = PipeBaseThk + height + ExtendHt;
echo("TotHt = ", TotHt);
echo("Ht_Half + PipeBaseThk = ",Ht_Half + PipeBaseThk);
echo(Pipe_Z = Pipe_Z);
//Makes each segment about .7mm and even number of segments
EMT12OD_Res = (round(((EMT12_OD * 3.14)/4)/.7)*4);       //Resolution of Chamfers
echo("EMT12OD_Res = ",EMT12OD_Res);

module EMT12_4xCut()
{
    for (x = [-1,1])
    {
        for (y = [-1,1])
        {
            translate([x * EMT12_Rad,y * EMT12_Rad,0])
            EMT12_1xPipe();
        }
    }
    translate([-15.4,-15.4,0])
    cube([30.8,30.8,height+2]);
}
module EMT12_4xChamfer()
{
    Chamf_Ht = 1.5;
    CH_OD = EMT12_OD + Chamf_Ht + Chamf_Ht;
    mirror([0,0,1])
    {
        for (x = [-1,1])
        {
            for (y = [-1,1])
            {
        translate([x * EMT12_Rad,y * EMT12_Rad,0])
        cylinder(d1=CH_OD,d2=EMT12_OD,h=Chamf_Ht + .01,$fn=EMT12OD_Res);
            }
        }
    }

}
module EMT12_1xPipe(E_Ht = height+2)
{
    cylinder(d=EMT12_OD,h=E_Ht,$fn=EMT12OD_Res);
}
module EMT12_Pipes()
{
    translate([0,0,height - BaseThk])
    rotate([180,0,0])
    {
        for (x = [-1,1])
        {
            for (y = [-1,1])
            {
                translate([x * EMT12_Rad,y * EMT12_Rad,0])
                EMT12_1xPipe(100);
            }
        }
    }
}
//EMT12_Pipes();
module Vertex_Outline()
{
    linear_extrude(height = height, center = false, convexity = 10)polygon(points = 
    [[45.09,75.43],[44.35,75.68],[43.57,75.63],[42.87,75.29],[42.35,74.7],
    [34.24,60.65],[33.89,60.15],[33.5,59.68],[33.06,59.25],[32.57,58.88],
    [32.06,58.55],[31.51,58.28],[30.93,58.06],[30.34,57.91],[29.74,57.82],
    [29.12,57.79],[-29.12,57.79],[-29.74,57.82],[-30.34,57.91],[-30.93,58.06],
    [-31.51,58.28],[-32.06,58.55],[-32.57,58.88],[-33.06,59.25],[-33.5,59.68],
    [-33.89,60.15],[-34.24,60.65],[-42.35,74.7],[-42.87,75.29],[-43.57,75.63],
    [-44.35,75.68],[-45.09,75.43],[-48.98,73.18],[-49.57,72.67],[-49.91,71.97],
    [-49.97,71.19],[-49.71,70.45],[-21.42,21.44],[-21.17,20.7],[-21.22,19.92],
    [-21.56,19.22],[-22.15,18.71],[-33.59,12.1],[-34.11,11.67],[-34.45,11.1],
    [-34.59,10.44],[-34.5,9.77],[-34.19,9.17],[-33.7,8.71],[-28.32,5.1],
    [-27.79,4.72],[-27.27,4.31],[-26.79,3.88],[-26.32,3.42],[-25.88,2.93],
    [-25.47,2.42],[-25.09,1.9],[-24.74,1.35],[-24.41,0.78],[-24.12,0.19],
    [-23.86,-0.41],[-23.64,-1.02],[-23.44,-1.64],[-23.28,-2.28],[-23.16,-2.92],
    [-23.07,-3.57],[-23.02,-4.22],[-23,-4.87],[-23,-9],[-22.98,-9.69],
    [-22.93,-10.37],[-22.85,-11.05],[-22.73,-11.73],[-22.58,-12.4],[-22.4,-13.06],
    [-22.18,-13.72],[-21.93,-14.36],[-21.66,-14.99],[-21.35,-15.6],[-21.01,-16.2],
    [-20.64,-16.78],[-20.25,-17.34],[-19.82,-17.88],[-19.37,-18.4],[-18.9,-18.9],
    [-18.4,-19.37],[-17.88,-19.82],[-17.34,-20.25],[-16.78,-20.64],[-16.2,-21.01],
    [-15.6,-21.35],[-14.99,-21.66],[-14.36,-21.93],[-13.72,-22.18],[-13.06,-22.4],
    [-12.4,-22.58],[-11.73,-22.73],[-11.05,-22.85],[-10.37,-22.93],[-9.69,-22.98],
    [-9,-23],[9,-23],[9.69,-22.98],[10.37,-22.93],[11.05,-22.85],
    [11.73,-22.73],[12.4,-22.58],[13.06,-22.4],[13.72,-22.18],[14.36,-21.93],
    [14.99,-21.66],[15.6,-21.35],[16.2,-21.01],[16.78,-20.64],[17.34,-20.25],
    [17.88,-19.82],[18.4,-19.37],[18.9,-18.9],[19.37,-18.4],[19.82,-17.88],
    [20.25,-17.34],[20.64,-16.78],[21.01,-16.2],[21.35,-15.6],[21.66,-14.99],
    [21.93,-14.36],[22.18,-13.72],[22.4,-13.06],[22.58,-12.4],[22.73,-11.73],
    [22.85,-11.05],[22.93,-10.37],[22.98,-9.69],[23,-9],[23,-4.87],
    [23.02,-4.22],[23.07,-3.57],[23.16,-2.92],[23.28,-2.28],[23.44,-1.64],
    [23.64,-1.02],[23.86,-0.41],[24.12,0.19],[24.41,0.78],[24.74,1.35],
    [25.09,1.9],[25.47,2.42],[25.88,2.93],[26.32,3.42],[26.79,3.88],
    [27.27,4.31],[27.79,4.72],[28.32,5.1],[33.7,8.71],[34.19,9.17],
    [34.5,9.77],[34.59,10.44],[34.45,11.1],[34.11,11.67],[33.59,12.1],
    [22.15,18.71],[21.56,19.22],[21.22,19.92],[21.17,20.7],[21.42,21.44],
    [49.71,70.45],[49.97,71.19],[49.91,71.97],[49.57,72.67],[48.98,73.18],
    [45.09,75.43],[48.98,73.18]]);
}
module Vertex_UpperFrameCut()
{
    linear_extrude(height = height+2, center = false, convexity = 10)polygon(points = 
    [[26.52,47.29],[26.76,47.94],[26.76,48.63],[26.52,49.29],[26.08,49.82],
    [25.48,50.16],[24.79,50.29],[-24.79,50.29],[-25.48,50.16],[-26.08,49.82],
    [-26.52,49.29],[-26.76,48.63],[-26.76,47.94],[-26.52,47.29],[-14.11,25.79],
    [-13.81,25.36],[-13.44,24.99],[-13.01,24.69],[-12.54,24.47],[-12.03,24.33],
    [-11.51,24.29],[11.51,24.29],[12.03,24.33],[12.54,24.47],[13.01,24.69],
    [13.44,24.99],[13.81,25.36],[14.11,25.79]]);
}
module VertexTop_EMT12_FullCut()
{
    translate([0,0,0])
    EMT12_4xCut();
}
module VertexTop_EMT12_HalfCut()
{
    difference()
    {
        EMT12_4xCut();
        translate([-19.4,-5,-1])
        cube([38.8,10,height+4]);
        translate([0,0,-1])
        cylinder(d=14.5,h=height+4,$fn=68);     //Allow for extra space around center hole
        //%EMT12_Pipes();
    }
}
module EMT_Nut()
{
    translate([1,-23,BaseThk+10.5])
    mirror([0,0,1])
    difference()
    {
//If Nut lock is not flush with outside pipe, try adjusting Pipe_Rad-1.3
        rotate([90,0,0])
        rotate([0,90,0])
        rotate([0,0,180])
        difference()
        {
            linear_extrude(height = 5, center = false, convexity = 10)polygon(points = 
            [[-0.5,0],[-0.5,26.43],[0,26.43],[1.5,24.93],[6.27,24.93],
            [6.87,24.83],[7.42,24.55],[7.86,24.12],[8.13,23.57],[8.23,22.97],
            [8.23,9.06],[8.19,8.67],[8.08,8.29],[7.89,7.94],[7.64,7.64],
            [0,0]]);

            translate([4.1,10.8,-1])
            cylinder(d=M3,h=8,$fn=24);
            translate([4.1,20.8,-1])
            cylinder(d=M3,h=8,$fn=24);
        }
    }
}
module EMT_NutsSide()
{
    EMT_Nut();
    translate([-7,0,0])
    EMT_Nut();
}
module SlantCut()
{
    color("red",.5)
    translate([31.5084,7.4496,20-13])
    rotate([90,0,0])
    linear_extrude(height = .1, center = false, convexity = 10)polygon(points = 
    [[0,25.76],[0.05,26.42],[0.21,27.07],[0.46,27.68],[0.81,28.25],
    [1.24,28.76],[1.75,29.19],[2.32,29.54],[2.93,29.79],[3.58,29.95],
    [4.24,30],[4.91,29.95],[5.55,29.79],[6.17,29.54],[6.74,29.19],
    [7.24,28.76],[7.68,28.25],[8.02,27.68],[8.28,27.07],[8.43,26.42],
    [8.49,25.76],[8.49,4.24],[8.43,3.58],[8.28,2.93],[8.02,2.32],
    [7.68,1.75],[7.24,1.24],[6.74,0.81],[6.17,0.46],[5.55,0.21],
    [4.91,0.05],[4.24,0],[3.58,0.05],[2.93,0.21],[2.32,0.46],
    [1.75,0.81],[1.24,1.24],[0.81,1.75],[0.46,2.32],[0.21,2.93],
    [0.05,3.58],[0,4.24]]);     //Rounded Top cut
}
module BearingOpening()
{
    rotate([-90,0,0])
    hull()
    {
        cylinder(d=16,h=40,$fn=72);
        union()
        {
            translate([-6.5,0,0])
            cylinder(d=10,h=40,$fn=48);
            translate([6.5,0,0])
            cylinder(d=10,h=40,$fn=48);
            translate([-6.5,-5,0])
            cube([13,10,40]);
        }
    }    
}

module vertex()
{
    difference()
    {
        union()
        {
            translate([0,0,PipeBaseThk])
            Vertex_Outline();
            EMT_NutsSide();
        }
        IdlerCut();
        translate([0,10,8.5])
        rotate([0,0,45])
        cylinder(d1=0,d2=20,h=10,$fn=4);        //Chamfer overhang of Idler Cut
        translate([0,10,31.7])
        rotate([0,0,45])
        cylinder(d1=20,d2=0,h=10,$fn=4);        //Chamfer overhang of Idler Cut

//Bearing Opening
        translate([0, 27.5, height/2]) rotate([90, 0, 0])
        cylinder(r=8, h=40, center=true, $fn=60);
        Pipes();
        translate([0,0,height+.01])
        EMT12_4xChamfer();
        translate([0,0,height / 2])
        BearingOpening();
//Hole access in end of Horizontal EMT
        PipeScrewsBothSides();

////Upper A Frame Hole (Large)
        translate([0,0,-1])
        Vertex_UpperFrameCut();

        WireTopEMT12();
//Cut out around base at Vertical EMTs
        translate([0,0,-1])
        VertexTop_EMT12_HalfCut();

        translate([0,0,BaseThk])
        VertexTop_EMT12_FullCut();
//Cut 2mm slot for Pipe Tighten
        translate([-1,-30,BaseThk])
        cube([2,18,height]);
        translate([-2,0,0])  
        rotate([0,0,90])
        SideHoles();
        translate([2,0,0])
        rotate([0,0,-(90)])
        SideHoles();
        EMT_EndHoles();             //In case you want to run something thru EMT Horizontals
//Add an M4 hole thru base under Vertical EMTs
        translate([0,0,-1])
        cylinder(d=M4,h=BaseThk+2,$fn=M5_Res);

        ChamTopCornerEMTH();
        translate([0,0,height])
        ChamTopCornerEMTH();
    }
}
module ChamTopCornerEMTH()
{
    for(a = [0,1])
    {
        mirror([a,0,0])
        {
            translate([-34.59,10.44,0])
            rotate([0,0,-10.71])
            rotate([90,0,0])
            cylinder(d=9,h=21,center=true,$fn=4);
        }
    }
}
module EMT_EndHoles()
{
    for(a = [0,1])
    {
        mirror([a,0,0])
        {
            translate([-25.79,-16,Pipe_Z])
            rotate([-90,0,0])
            cylinder(d=5,h=36,$fn=24);
            translate([-25.79,-16,Pipe_Z + Pipe_Spacing])
            rotate([-90,0,0])
            cylinder(d=5,h=36,$fn=24);
        }
    }
}
module MidTSlot_Open()
{
    linear_extrude(height = height + 20+ ExtendHt, center = false, convexity = 10)polygon(points = 
    [[-6.5,6.15],[-3.25,2.9],[3.25,2.9],[6.5,6.15],[6.5,9.2],
    [-6.5,9.2]]);
}
module SideHoles()
{
    translate([0,8.4,height / 2])
    rotate([-90,0,0])
    {
        translate([0,-2,0])
        cylinder(d=10,h=20,$fn=36);
        translate([-5,-2,0])
        cube([10,4,20]);
        translate([0,2,0])
        cylinder(d=10,h=20,$fn=36);
    }
}
module IdlerCut()
{
    translate([0,49.28,height/2])
    rotate([-90,0,0])
    {
        scale([1,1.39375,1])        //Scale Vertical to match bevel motor mount cut
        cylinder(d=16,h=9.5,$fn=72);
        translate([0,0,6.7])
        cylinder(d1=22.3,d2=24.12,h=1.82,$fn=108);
        for(x = [-1,1])
        {
            echo(x = x);
            for(y = [-1,1])
            {
                translate([x*15.5,y*15.5,0])
                cylinder(d=M3,h=9.5,$fn=M3_Res);
            }
            hull()
            {
                translate([x*IdlerMnt_X_Offset,Idler_Move,0])
                cylinder(d=M5,h=9.5,$fn=M5_Res);
                translate([x*IdlerMnt_X_Offset,-Idler_Move,0])
                cylinder(d=M5,h=9.5,$fn=M5_Res);
            }
            translate([x*IdlerMnt_X_Offset,0,1])
            rotate([0,0,30])
            cylinder(d=M5Nut,h=2,center=true,$fn=6);    //Add 1mm Locknut recess for easier assembly
        }
    }
}

module RndCorner()
{
    translate([-4,34+8.4,22])
    rotate([-90,0,0])
    translate([-14,16,0])
    difference()
    {
        cylinder(d=18,h=10,$fn=24);
        translate([0,0,-1])
        cylinder(d=12,h=12,$fn=48);
        translate([-10,-20,-1])
        cube([20,20,12]);
        translate([-20,-10,-1])
        cube([20,20,12]);
    }
}
module IdlerMntAdjustHoles()
{ 
    translate([IdlerMnt_X_Offset,0,12])
    IdlerMntAdjustSlot();

    translate([-IdlerMnt_X_Offset,0,12])
    IdlerMntAdjustSlot();
}
module IdlerMntAdjustSlot()
{
    translate([0,58,3.5])
    rotate([90,0,0])
    union()
    {
        translate([0,Idler_Move,0])
        cylinder(d=5.5,h=10,$fn=24);
        translate([-2.75,-Idler_Move,0])
        cube([5.5,Idler_Move*2,10]);
        translate([0,-Idler_Move,0])
        cylinder(d=5.5,h=10,$fn=24);
    }
}
module WireTopEMT12()
{
    translate([-9.2,20.9,0])
    BotWireCut();
    translate([9.2,20.9,0])
    BotWireCut();

}
//We use 7mm for Diameter of Wire cut
module BotWireCut()
{
    rotate([90,0,0])
    translate([0,0,-5.5])
    linear_extrude(height = 11, center = false, convexity = 10)polygon(points = 
    [[-3.5,3.5],[-3.5,1.5],[-5,0],[-5,-1],[5,-1],
    [5,0],[3.5,1.5],[3.5,3.5],[3.43,4.18],[3.23,4.84],
    [2.91,5.44],[2.47,5.97],[1.94,6.41],[1.34,6.73],[0.68,6.93],
    [0,7],[-0.68,6.93],[-1.34,6.73],[-1.94,6.41],[-2.47,5.97],
    [-2.91,5.44],[-3.23,4.84],[-3.43,4.18]]);
}
module Pipe1x()
{
    for (a = [0,1])
    {
        mirror([a,0,0])
        translate([-PVC_Hor_X,PVC_Hor_Y,0])
        rotate([0,0,30])
        rotate([-90,0,0])
        {
            difference()
            {
                cylinder(d=PVC12_OD,h=300,$fn=64);  //Cut Left Side opening for EMT pipe
                translate([-17.5,-10,-1])
                cube([20,20,302]);
            }
            color("white",.9)
            %difference()
            {
                cylinder(d=PVC12_OD,h=300,$fn=64);  //Cut Left Side opening for EMT pipe
                translate([0,0,-1])
                cylinder(d=PVC12_OD - 2.8,h=302,$fn=64);
            }
        }
    }
}
module Pipes()
{
    translate([0,0,Pipe_Z])
    {
        if (Pipe_Qty == 2)
        {
            Pipe1x();
            //%EMT12();
            %Pipe1x();
            translate([0,0,Pipe_Spacing])
            Pipe1x();
            translate([0,0,Pipe_Spacing])
            %Pipe1x();
            //%Pipe1x();
        } else {
            Pipe1x();
            %Pipe1x();
        }
    }
}
module EMT12()
{
    for (a = [0,1])
    {
        mirror([a,0,0])
        translate([-PVC_Hor_X,PVC_Hor_Y,0])
        rotate([0,0,30])
        rotate([-90,0,0])
    difference()
    {
        cylinder(d=PVC12_OD,h=300,$fn=64);
        translate([0,0,-1])
        cylinder(d=v-2.8,h=302,$fn=64);
    }
}
}
module PipeScrewsBothSides()
{
    if (PipeBaseThk > 0)
    {
        PipeScrews();
        mirror([1,0,0])
        PipeScrews();
    } else {
        PipeScrews();
        mirror([1,0,0])
        PipeScrews();
    }
}
module PipeScrews()
{
    translate([0,0,Pipe_Z])
    {
        if (Pipe_Qty == 2)
        {
            PipeScrews1x();
            translate([0,0,Pipe_Spacing])
            PipeScrews1x();
            translate([0,0,Pipe_Spacing / 2])
            PipeScrews1x();
        } else {
            PipeScrews1x();
            translate([0,0,Pipe_Spacing])
            PipeScrews1x();
        }
    }
}
module PipeScrews1x()
{
    translate([-Screw_X1_Offset,Screw_Y1_Offset,0])
    rotate([0,0,30])
    rotate([0,90,0])
    cylinder(d=PipeScrewDia,h=32);

    translate([-Screw_X2_Offset,Screw_Y2_Offset,0])
    rotate([0,0,30])
    rotate([0,90,0])
    cylinder(d=PipeScrewDia,h=32);
}
module DrawFinal()
{
    vertex();
}
DrawFinal();