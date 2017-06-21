// Emmett-Delta 3D Printer 
// Based on Delta-Six Vertex Created by Sage Merrill
// Base on https://github.com/Jaydmdigital/Kossel_2020
// Released on Openbuilds.com
// which was Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

//Modified by David Bunch to handle 3/4" Electrical Conduit Pipe for Horizontals

//Modified 2/1/2016 to handle 4x 1/2" Electrical Conduit Pipes Vertically 

//Modified 10/28/2016 to use 1/2"EMT both horizontal & Vertical
//Modified 5/23/2017 to make some minor adjustments

//06:26:45 print time at 50% infill PLA 2.89oz
//$vpt=[-4.8,-22,25.6];
//$vpr =[55,0,71.2];
//$vpd =435;
height = 43;
ExtendHt = 0;                       //Extend height above main part

EMT12_Hor_OD = 18.0;                  //For Visual display of acutal size of pipe
EMT12_Hor_Rad = EMT12_Hor_OD / 2;   //Calculate Pipe offset using actual pipe size

//Nomimal 1/2" EMT from HomeDepot site is .706" OD or 17.9324mm
//Nomimal 1/2" EMT from HomeDepot site is .622" ID or 15.7988mm
//Wall thickness .042" or 1.0668mm

EMT_OD = 18.0;                      //Originally used 18.4, but seemed too loose
                                    //after upgrading the extruder on my printer
                                    //Based on what worked for 3/4" on MPCNC
                                    //Adding .2mm to OD should be a good number
EMT12_OD = 18.0;
EMT12_Rad = EMT12_OD / 2;
EMT_Rad = EMT_OD / 2;
EMT_EndHole_OD = 8;
EMT_EndHole_Res = 36;

EMT_Hor_X = 24.32;          //Other version was 44.1432
EMT_Hor_Y = 17.46;          //Other Versionwas 18.7292
Ht_Half = height / 2;

Ht = 8;
M5 = 5.5;
M5Nut = 10.0;               //Locknut measures 9.1mm but adding 10%
                            //Used for Idler Mount bracket
                            //This should make it a little easier to put the Locknut on
Slot_Gap = 3;               //Gap width for tightening vertex against 4x EMT12
                            //increased from 2mm to 3mm to give more tightening
                            //in case pipes are too loose from print
Slot_Gap2 = Slot_Gap / 2;

M4 = 4.8;
M8 = 8.5;
M3 = 3.5;
M3_Res = 16;
M5_Res = 24;
PipeScrewDia = 4.5;   //Dia. of holes for Screws that mount EMT Pipe to Vertex
                       //Use 5.15 to 5.5 for M5, or 4.15 to 4.5 for M4
//EMT Horizontal Mounting Holes have 42mm spacing
Screw_X1_Offset = 43.63;
Screw_Y1_Offset = 16.99;
Screw_X2_Offset = 64.63;
Screw_Y2_Offset = 53.36;
Pipe_Qty = 2;

Pipe_Spacing = 25;      //Use +20 for pipe at bottom & -20 for pipe even with top

BaseThk = 4;
$fn=48;
PipeBaseThk=0;
IdlerMnt_X_Offset = 19;             //Idler Mount Bolt offset from center
                                    //Need at least 19mm for 4mm thick from motor outer cut
Idler_Move = 0;                     //I would use 6mm to 7mm max, but I am using 0
                                    //As I am going to take care of belt tensioning on the carriage
Pipe_Z = EMT12_Hor_Rad;
UpHt = 6;
Bot_EMT_Holes_ON = 1;               //Add surface & holes under outside 2 vertical EMT's, 1 = Yes
                                    //This is useful for more clearance to screw wooden base to vertex
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
    translate([-30.7/2,-30.7/2,0])
    cube([30.7,30.7,height+2]);
    translate([-EMT12_Rad,-EMT_OD,0])
    cube([EMT_OD,EMT_OD,height+2]);
}
module EMT12_4xChamfer()
{
    Chamf_Ht = 1.5;
    CH_OD = EMT12_OD + Chamf_Ht + Chamf_Ht;
    mirror([0,0,1])
    {
        for (x = [-1,1])
        {
            translate([x * EMT12_Rad,EMT12_Rad,0])
            cylinder(d1=CH_OD,d2=EMT12_OD,h=Chamf_Ht + .01,$fn=EMT12OD_Res);
        }
//Changed the outer chamfer to hull after slicing inside flush at the back inside
        hull()
        {
                translate([-EMT12_Rad,-EMT12_Rad,0])
                cylinder(d1=CH_OD,d2=EMT12_OD,h=Chamf_Ht + .01,$fn=EMT12OD_Res);
                translate([EMT12_Rad,-EMT12_Rad,0])
                cylinder(d1=CH_OD,d2=EMT12_OD,h=Chamf_Ht + .01,$fn=EMT12OD_Res);
        }
    }
}
//Used for Vertical Pipes
module EMT12_1xPipe(E_Ht = height+2)
{
    cylinder(d=EMT12_OD,h=E_Ht,$fn=EMT12OD_Res);
}
module EMT12_1xPipeDisplay(E_Ht = height+2)
{
    difference()
    {
        cylinder(d=EMT12_OD,h=E_Ht,$fn=EMT12OD_Res);
        translate([0,0,-1])
        cylinder(d=EMT12_OD-2.8,h=E_Ht+2,$fn=EMT12OD_Res);
    }
}
module EMT12_Pipes()
{
    translate([0,0,BaseThk])
    rotate([0,0,0])
    {
        for (x = [-1,1])
        {
            for (y = [-1,1])
            {
                translate([x * EMT12_Rad,y * EMT12_Rad,0])
                EMT12_1xPipeDisplay(100);
            }
        }
    }
}
module Vertex_Outline()
{
    linear_extrude(height = height, center = false, convexity = 10)polygon(points = 
    [[42.35,74.7],[42.87,75.29],[43.57,75.63],[44.35,75.68],[45.09,75.43],
    [48.98,73.18],[49.57,72.67],[49.91,71.97],[49.97,71.19],[49.71,70.45],
    [21.42,21.44],[21.17,20.7],[21.22,19.92],[21.56,19.22],[22.15,18.71],
    [30.65,13.8],[31.19,13.34],[31.54,12.71],[31.65,12.01],[31.5,11.31],
    [31.11,10.71],[25.13,4.3],[24.69,3.77],[24.31,3.19],[24,2.56],
    [23.77,1.91],[23.61,1.23],[23.53,0.54],[23,-9],[22.94,-10.25],
    [22.88,-10.87],[22.78,-11.48],[22.65,-12.09],[22.5,-12.7],[22.33,-13.29],
    [22.12,-13.88],[21.8,-14.68],[21.53,-15.24],[21.22,-15.84],[20.87,-16.42],
    [20.5,-16.98],[20.1,-17.53],[19.68,-18.05],[19.23,-18.56],[18.76,-19.04],
    [18.26,-19.5],[17.75,-19.93],[17.21,-20.34],[16.65,-20.72],[16.08,-21.08],
    [15.49,-21.41],[14.89,-21.7],[14.27,-21.97],[13.64,-22.21],[12.99,-22.42],
    [12.34,-22.6],[11.68,-22.74],[11.02,-22.85],[10.35,-22.94],[9.68,-22.98],
    [9,-23],[-9,-23],[-9.68,-22.98],[-10.35,-22.94],[-11.02,-22.85],
    [-11.68,-22.74],[-12.34,-22.6],[-12.99,-22.42],[-13.64,-22.21],[-14.27,-21.97],
    [-14.89,-21.7],[-15.49,-21.41],[-16.08,-21.08],[-16.65,-20.72],[-17.21,-20.34],
    [-17.75,-19.93],[-18.26,-19.5],[-18.76,-19.04],[-19.23,-18.56],[-19.68,-18.05],
    [-20.1,-17.53],[-20.5,-16.98],[-20.87,-16.42],[-21.22,-15.84],[-21.53,-15.24],
    [-21.8,-14.68],[-22.12,-13.88],[-22.33,-13.29],[-22.5,-12.7],[-22.65,-12.09],
    [-22.78,-11.48],[-22.88,-10.87],[-22.94,-10.25],[-23,-9],[-23.53,0.54],
    [-23.61,1.23],[-23.77,1.91],[-24,2.56],[-24.31,3.19],[-24.69,3.77],
    [-25.13,4.3],[-31.11,10.71],[-31.5,11.31],[-31.65,12.01],[-31.54,12.71],
    [-31.19,13.34],[-30.65,13.8],[-22.15,18.71],[-21.56,19.22],[-21.22,19.92],
    [-21.17,20.7],[-21.42,21.44],[-49.71,70.45],[-49.97,71.19],[-49.91,71.97],
    [-49.57,72.67],[-48.98,73.18],[-45.09,75.43],[-44.35,75.68],[-43.57,75.63],
    [-42.87,75.29],[-42.35,74.7],[-34.24,60.65],[-33.89,60.15],[-33.5,59.68],
    [-33.06,59.25],[-32.57,58.88],[-32.06,58.55],[-31.51,58.28],[-30.93,58.06],
    [-30.34,57.91],[-29.74,57.82],[-29.12,57.79],[29.12,57.79],[29.74,57.82],
    [30.34,57.91],[30.93,58.06],[31.51,58.28],[32.06,58.55],[32.57,58.88],
    [33.06,59.25],[33.5,59.68],[33.89,60.15],[34.24,60.65]]);
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
        if (Bot_EMT_Holes_ON == 1)
        {
            translate([-19.4,-5-30,-1])
            cube([38.8,10+30,height+4]);
        } else
        {
            translate([-19.4,-5,-1])
            cube([38.8,10,height+4]);
        }
        translate([0,0,-1])
        cylinder(d=14.5,h=height+4,$fn=68);     //Allow for extra space around center hole
        //%EMT12_Pipes();
    }
}

module EMT_Nut()
{
    translate([Slot_Gap2,-23,0])
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
            [[0,0],[7.64,7.64],[7.89,7.94],[8.08,8.29],[8.19,8.67],
            [8.23,9.06],[8.23,12.97],[8.13,13.57],[7.86,14.12],[7.42,14.55],
            [6.87,14.83],[6.27,14.93],[1.5,14.93],[0,16.43],[-0.5,16.43],
            [-0.5,0]]);
//            [[-0.5,0],[-0.5,26.43],[0,26.43],[1.5,24.93],[6.27,24.93],
//            [6.87,24.83],[7.42,24.55],[7.86,24.12],[8.13,23.57],[8.23,22.97],
//            [8.23,9.06],[8.19,8.67],[8.08,8.29],[7.89,7.94],[7.64,7.64],
//            [0,0]]);          //For Double
            translate([4.1,10.8,-1])
            cylinder(d=M3,h=8,$fn=24);
//            translate([4.1,20.8,-1])
//            cylinder(d=M3,h=8,$fn=24);
        }
    }
}
module EMT_NutsSide()
{
    EMT_Nut();
    mirror([1,0,0])         //Changed to mirroring after adding Slot_Gap variable
    EMT_Nut();
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
module BackTriCut()
{
    translate([0,-EMT12_OD,-1])
    {
        difference()
        {
            cylinder(d=6,h=TotHt+2,$fn=12);
            translate([-5,-10,-2])
            color("cyan")
            cube([10,10,TotHt+5]);
        }
        translate([-Slot_Gap2,0,0])
        cylinder(d=3,h=TotHt+2,$fn=4);
        translate([Slot_Gap2,0,0])
        cylinder(d=3,h=TotHt+2,$fn=4);
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
            translate([0,0,0])
            EMT_NutsSide();
            translate([0,0,28.07])
            EMT_NutsSide();
        }
        translate([-8,-26,height])
        cube([16,4,2]);             //Slice off nub at top of Tightening Nut bracket
        MotorCut();

        translate([0,12,8])
        rotate([0,0,45])
        cylinder(d1=0,d2=20,h=10,$fn=4);        //Chamfer overhang of Idler Cut
        translate([0,12,25])
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

//Upper A Frame Hole (Large)
        translate([0,0,-1])
        Vertex_UpperFrameCut();

        WireTopEMT12();
//Cut out around base at Vertical EMTs
        translate([0,0,-1])
        VertexTop_EMT12_HalfCut();

        translate([0,0,BaseThk])
        VertexTop_EMT12_FullCut();
//Cut Slot for tightening around 4x vertical pipe
//        translate([-Slot_Gap2,-32,BaseThk])
        translate([-Slot_Gap2,-32,-1])
        cube([Slot_Gap,16,TotHt+2]);
        BackTriCut();
        //translate([-2,0,0])  
        rotate([0,0,90])
        SideHoles();
        //translate([2,0,0])
        rotate([0,0,-(90)])
        SideHoles();
        EMT_EndHoles();             //In case you want to run something thru EMT Horizontals
//Add an M4 hole thru base under Vertical EMTs
        translate([0,0,-1])
        cylinder(d=M4,h=BaseThk+2,$fn=M5_Res);
        if (Bot_EMT_Holes_ON == 1)
        {
            for (x = [-1,1])
            {
                translate([x * EMT_Rad,-EMT_Rad,-1])
                cylinder(d=M4,h=BaseThk+2,$fn=M5_Res);
            }
        }
        ChamTopCornerEMTH();
        translate([0,0,height])
        ChamTopCornerEMTH();
//Taper bottom wire holes to 45 degrees
        for (x = [-1,1])
        {
            translate([x * 9.2,6,5.98])
            rotate([-90,0,0])
            cylinder(d=4.93,h=26,$fn=4);
        }
        for (m = [0,1])
        {
            mirror([m,0,0])
            {
                ChamEndTops();
                rotate([0,0,30])
                EdgePipes();
                RndMiddle();
//Chamfer the top & bottom of side cuts for no overhangs at top of cuts
                translate([-17.22,0,24])
                rotate([0,90,0])
                cylinder(d1=10,d2=14,h=2.01,$fn=36);
                translate([-17.22,0,19])
                rotate([0,90,0])
                cylinder(d1=10,d2=14,h=2.01,$fn=36);
            }
        }
        IdlerCutTop30();
        MotorChamf();
    }
}
module MotorChamf()
{
    translate([0,49.28+9.5,0])
    rotate([90,0,0])
    linear_extrude(height = 9.5, center = false, convexity = 10)polygon(points = 
    [[-8.77,37.16],[-8.83,37.82],[-8.95,38.47],[-9.15,39.1],[-9.42,39.71],
    [-9.75,40.28],[-10.14,40.81],[-10.59,41.3],[-11.08,41.73],[-11.63,42.11],
    [-12.21,42.43],[-12.82,42.67],[-13.46,42.85],[-14.11,42.96],[-14.77,43],
    [-14.77,44],[14.76,44],[14.76,43],[14.1,42.96],[13.44,42.85],
    [12.8,42.67],[12.19,42.42],[11.6,42.1],[11.06,41.72],[10.56,41.28],
    [10.11,40.79],[9.72,40.25],[9.39,39.67],[9.13,39.06],[8.93,38.42],
    [8.81,37.77],[8.76,37.11]]);
    for (m = [0,1])
    {
        mirror([m,0,0])
        hull()
        {
            translate([-10.9038,49.2,22.9676])
            rotate([0,9.07,0])
            cube([10,.1,21.2984]);
            translate([-11.7633,58.68,24.5455])
            rotate([0,14.35,0])
            cube([10,.1,21.6254]);
        }
    }   
}
module IdlerCutTop30()
{
    translate([0,25.29,0])
    rotate([90,0,0])
    linear_extrude(height = 11, center = false, convexity = 10)polygon(points = 
    [[-10.04,25.04],[10.04,25.04],[0,35.07]]);
//    [[-9,25.83],[9,25.83],[0,31.03]]);        //30 degree cutout
}

module RndMiddle()
{
    rotate([0,0,30])
    translate([0,14.92+14,0])
    rotate([90,0,0])
    linear_extrude(height = 15, center = false, convexity = 10)polygon(points = 
    [[-16.95,19],[-16.66,19.59],[-16.45,20.21],[-16.32,20.85],[-16.28,21.5],
    [-16.32,22.15],[-16.45,22.79],[-16.66,23.41],[-16.95,24],[-22.63,33.83],
    [-22.63,9.17]]);
}

module EdgePipes()
{
    Sh_Len = 5;         //Shorten Bottom cut length by this much
    translate([-16.45,14.92,-1])
    difference()
    {
        translate([-6.13,-5.9 + Sh_Len,35])
        cube([6.13 + 3.87,13 + 3.9 + 2,12]);
        translate([3.87,14 + Sh_Len,35])
        rotate([90,0,0])
        cylinder(d=18,h=15,$fn=64);
        translate([3.87,Sh_Len,35])
        rotate([90,0,0])
        cylinder(d1=18,d2=26,h=6,$fn=64);
    }
    translate([-16.45,14.92,35+9])
    mirror([0,0,1])
    difference()
    {
        translate([-6.13,-5.9 + Sh_Len,35])
        cube([6.13 + 3.87,13 + 3.9 + 2,12]);
        translate([3.87,14 + Sh_Len,35])
        rotate([90,0,0])
        cylinder(d=18,h=15,$fn=64);
        translate([3.87,Sh_Len,35])
        rotate([90,0,0])
        cylinder(d1=18,d2=26,h=6,$fn=64);
    }
}
module ChamEndTops()
{
//Chamfer Top Ends
    rotate([0,0,30])
    translate([1,87.9,43])
    rotate([0,0,-90])
    rotate([90,0,0])
    difference()
    {
        rotate([0,0,45])
        cylinder(d=25.46,h=12,$fn=4);
        translate([9,-9,-1])
        cylinder(d=18,h=14,$fn=64);
    }
//Chamfer Bottom Ends
    rotate([0,0,30])
    translate([1,87.9,0])
    rotate([0,0,-90])
    rotate([90,0,0])
    difference()
    {
        rotate([0,0,45])
        cylinder(d=25.46,h=12,$fn=4);
        translate([9,9,-1])
        cylinder(d=18,h=14,$fn=64);
    }
}

module ChamTopCornerEMTH()
{
    for(a = [0,1])
    {
        mirror([a,0,0])
        {
            translate([-34.59,10.44,0])
            rotate([0,0,15])
            rotate([90,0,0])
            cylinder(d=16,h=20,center=true,$fn=4);
        }
    }
}
module EMT_EndHoles()
{
    for(a = [0,1])
    {
        mirror([a,0,0])
        {
            translate([-27.15,.99,EMT12_Rad])
            rotate([0,0,-5])
            rotate([-90,0,0])
            cylinder(d=5,h=20,$fn=24);
            translate([-27.15,.99,EMT12_Rad + Pipe_Spacing])
            rotate([0,0,-5])
            rotate([-90,0,0])
            cylinder(d=5,h=20,$fn=24);
        }
    }
}
module SideHoles()
{
    translate([0,8.4,height / 2])
    rotate([-90,0,0])
    {
        translate([0,-2.5,0])
        cylinder(d=10,h=20,$fn=36);
        translate([-5,-2.5,0])
        cube([10,5,20]);
        translate([0,2.5,0])
        cylinder(d=10,h=20,$fn=36);
    }
}
module MotorCut()
{
    translate([0,49.28,height/2])
    rotate([-90,0,0])
    {
        cylinder(d1=22.06,d2=24.35,h=9.5,$fn=48);

        for(x = [-1,1])
        {
            echo(x = x);
            for(y = [-1,1])
            {
                translate([x*15.5,y*15.5,0])
                cylinder(d=M3,h=9.5,$fn=M3_Res);
            }
//Uncomment next 10 lines if you want cutouts for idler hardware
//            hull()
//            {
//                translate([x*IdlerMnt_X_Offset,Idler_Move,0])
//                cylinder(d=M5,h=9.5,$fn=M5_Res);
//                translate([x*IdlerMnt_X_Offset,-Idler_Move,0])
//                cylinder(d=M5,h=9.5,$fn=M5_Res);
//            }
//            translate([x*IdlerMnt_X_Offset,0,1])
//            rotate([0,0,30])
//            cylinder(d=M5Nut,h=2,center=true,$fn=6);    //Add 1mm Locknut recess for easier assembly
        }
    }
//Add 45 degree cutout at top of Motor hole for no overhang
    hull()
    {
        translate([0,49.28,29.33])
        rotate([-90,0,0])
        cylinder(d=15.52,h=.1,$fn=4);
        translate([0,49.28+9.4,30.14])
        rotate([-90,0,0])
        cylinder(d=17.15,h=.1,$fn=4);
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
        translate([-EMT_Hor_X,EMT_Hor_Y,0])
        rotate([0,0,30])
        rotate([-90,0,0])
        difference()
        {
            cylinder(d=EMT12_OD,h=300,$fn=64);  //Cut Left Side opening for EMT pipe
            translate([-17.5,-10,-1])
            cube([20,20,302]);
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
            %EMT12();
            translate([0,0,Pipe_Spacing])
            Pipe1x();
            translate([0,0,Pipe_Spacing])
            %EMT12();
        } else {
            Pipe1x();
          %EMT12();
        }
    }
}
module EMT12()
{
    for (a = [0,1])
    {
        mirror([a,0,0])
        translate([-EMT_Hor_X,EMT_Hor_Y,0])
        rotate([0,0,30])
        rotate([-90,0,0])
        difference()
        {
            cylinder(d=EMT12_Hor_OD,h=300,$fn=64);
            translate([0,0,-1])
            cylinder(d=EMT12_Hor_OD-2.8,h=302,$fn=64);
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