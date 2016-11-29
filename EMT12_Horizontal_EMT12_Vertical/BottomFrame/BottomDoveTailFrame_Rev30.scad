//Dove Tail Base Assembly for Emmett-Delta using 1/2" EMT horizontal
//11/23/2016    By: David Bunch
//
//I plan to use 6 - #8x3/4" Flat Head Screws & locknuts to connect base at bottom of Vertex parts
//and 6 - #8x5/8" to 3/4" Pan Head Screws to mount center section to dove tail legs
//M3 screws to mount electronics boards to center section
//11/29:2016    Fixed Interference problem with Heat Bed Bracket
//
Build_Plate_OD = 210;           //try 210, 300 or whatever you want (only tested 210 & 300)
Mid_Leg_Qty = 0;                //Only really need this if Build_Plate_OD greater than 210mm
                                //Mid_Leg_Qty = 0, 1, 2 or 3
DT_Ht = 5;                      //Need enough height for countersink screw at bottom of vertex
Ledge_Ht = 6;                   //Height of the Ledges
Cen_Ht = 3;                     //Height of the Center section above Dove Tail Legs

DT_M3 = 3.6;                    //M3 Size Screw Hole which are holes on Center Part
DT_M3_Res = 16;                 //Resolution of M3 holes
Weld_OD = 12;                   //Weld size on the Vertex connector
DT_Hole_OD = 4.8;               //M4 or #8 Size Screw Hole
                                //#8 measures 4.05mm
DT_ScrewHD_OD = 9.5;            //#8 flat head is 7.7mm
DT_ScrewHD_Ht = 4;
DT_Hole_OD_Res = 24;            //24 is best match to transition to 6 sided hex
//M4Nut_OD = 9.4;               //M4 = 7.9mm measured, 9.4mm worked for me
M4Nut_OD = 11;                  //#8 locknut measures 9.95mm, 11mm worked for me
M4Nut_Ht = 7;                   //#8 measured 6mm, M4 measured 4.7mm, so making it the longest
EMT12_OD = 18.2;                //Match the size used on the Bottom Vertex part

EL_Mnt_Hole_Qty = 5;            //Number of holes to use for Center Frame mounting
EL_Mnt_Hole_Spacing = 25;       //Hole Spacing to use for Center Frame Mounting
E_Qty_Loop = (EL_Mnt_Hole_Qty - 1) / 2;     //Used for Index number in For loop

EMT12_Rad = EMT12_OD / 2;
DoveCut_Y1_Offset = 9.35;       //1st DoveTail Offset along Y-Axis from outside edge of Legs
DoveCut_Y2_Offset = 25.26;      //2nd DoveTail Offset along Y-Axis from outside edge of Legs
Dove_Ht = DT_Ht + Ledge_Ht;     //Total Height of the Leg at the Dove Tail Joint

Total_Ht = DT_Ht + Cen_Ht;
DT_Hole_X_Offset = 14.55;
DT_Hole_Y_Offset = 26.8;
DT_Size = 3;                    //4 = .4mm clearance
                                //3 = .3mm clearance (Default)
                                //2 = .2mm clearance
Print_Part =1;                  //0 = All Parts
                                //1 = Assembly
                                //2 = Left Female Part
                                //3 = Right Male Part
                                //4 = Mid Leg
                                //5 = Left Female, Right Male Part & Mid Part if needed
                                //6 = Center part
                                //7 = Test Print
echo(Dove_Ht = Dove_Ht);
//Use Arrays to tell the difference between different Vertex types for future use
Nema_Ht = 40;
ET = 0;                 //0 = 1/2" Horizontal EMT & 1/2" Vertical EMT
A_A = [48.63,92.62,51.58,51.58];
A_C = [27.28,38.29,27.28,30.22];
A_D = [12.33,31.36,14.03,12.33];
A_Qty = [1,1,2,3,3,3,3];
M_Qty = A_Qty[Mid_Leg_Qty];     //Use this instead of Mid_Leg_Qty,
                                //So we do not get a divide / 0 problem
ETxx_A = A_A[ET];
ETxx_C = A_C[ET];
ETxx_D = A_D[ET];
Build_Plate_Rad = Build_Plate_OD / 2;

ETxx_F = tan(60) * Build_Plate_Rad;
echo(ETxx_F = ETxx_F);
ETxx_F_OD = ETxx_F * 2;
L2 = ETxx_F - ETxx_A;           //133.235mm is 210mm half length
E_H_Len = L2 + L2;
MidLeg_Len = L2 - 133.235;
MidLegTot_Len = (MidLeg_Len * 2 + 6.25) / M_Qty;
ML_Len = MidLeg_Len / M_Qty;

ML_TotLen = MidLeg_Len * 2 + 6.25;
Vertex_X = L2 + ETxx_C;
Vertex_Y = -(Build_Plate_Rad - ETxx_D);
Pipe_Y_Offset = Vertex_Y - 12.33;

echo(L2 = L2);
echo(E_H_Len = E_H_Len);
echo(Build_PLate_OD = Build_Plate_OD);
echo(Vertex_X = Vertex_X);
echo(Vertex_Y = Vertex_Y);
echo(Pipe_Y_Offset = Pipe_Y_Offset);

echo(MidLeg_Len = MidLeg_Len);
echo(ML_Len = ML_Len);
echo(MidLegTot_Len = MidLegTot_Len);

module Leg()
{
    difference()
    {
        union()
        {
            linear_extrude(height = DT_Ht, center = false, convexity = 10)polygon(points = 
            [[0,34.6],[-22.73,34.6],[-23.51,34.5],[-24.23,34.2],[-24.85,33.73],
            [-25.33,33.1],[-25.63,32.38],[-25.73,31.6],[-25.78,26.29],[-25.93,25.6],
            [-26.18,24.93],[-26.52,24.3],[-26.95,23.73],[-27.46,23.22],[-28.03,22.8],
            [-28.65,22.46],[-29.32,22.21],[-30.02,22.05],[-30.73,22],[-159.34,22],
            [-180.41,9.84],[-175.93,2.04],[-175.58,1.46],[-175.2,0.9],[-174.79,0.36],
            [-174.36,-0.16],[-173.91,-0.66],[-173.43,-1.13],[-172.93,-1.58],[-172.41,-2.01],
            [-171.86,-2.41],[-171.3,-2.79],[-170.72,-3.14],[-170.13,-3.45],[-169.52,-3.75],
            [-168.9,-4.01],[-168.26,-4.24],[-167.62,-4.44],[-166.96,-4.6],[-166.3,-4.74],
            [-165.64,-4.84],[-164.97,-4.92],[-164.29,-4.96],[-163.62,-4.96],[-162.94,-4.94],
            [-162.33,-4.89],[-161.47,-4.77],[-160.86,-4.65],[-160.25,-4.51],[-159.65,-4.34],
            [-159.06,-4.14],[-158.48,-3.91],[-157.91,-3.66],[-156.8,-3.09],[-148.27,1.22],
            [-147.64,1.5],[-146.97,1.7],[-146.29,1.83],[-145.59,1.87],[-144.9,1.83],
            [-144.22,1.72],[-134.2,0],[0,0]]);
            Ledge();
            VertexConnect();
        }
        VertexHole();           //Add hole to connect to back of Vertex
        LocknutHole();          //Hole where center Section connects
        translate([-60.5,26,-1])
        cylinder(d=6,h=50,$fn=4);   //Chamfer back of Vertex Connection
    }
}
module MidEndLeg()
{
    union()
    {
        linear_extrude(height = DT_Ht, center = false, convexity = 10)polygon(points = 
        [[25.73,31.6],[25.63,32.38],[25.33,33.1],[24.85,33.72],[24.23,34.2],
        [23.51,34.5],[22.73,34.6],[0,34.6],[0,22],[30.73,22],
        [30.02,22.05],[29.32,22.21],[28.65,22.46],[28.03,22.8],[27.46,23.22],
        [26.95,23.73],[26.52,24.3],[26.18,24.93],[25.93,25.59],[25.78,26.29],
        [25.73,27]]);
        MidLedge();
    }
}
module MidLeg()
{
    color("teal")
    difference()
    {
        union()
        {
            translate([-ML_Len,0,0])
            cube([ML_Len * 2,22,DT_Ht]);
            translate([-ML_Len,0,0])
            MidEndLeg();
            translate([ML_Len,0,0])
            mirror([1,0,0])
            MidEndLeg();
            if (DT_Size == 4)
            {
                translate([-ML_Len,DoveCut_Y1_Offset,0])
                Dove_4(DT_Ht);
                translate([-ML_Len,DoveCut_Y2_Offset,0])
                Dove_4(DT_Ht);
            } else if (DT_Size == 3)
            {
                translate([-ML_Len,DoveCut_Y1_Offset,0])
                Dove_3(DT_Ht);
                translate([-ML_Len,DoveCut_Y2_Offset,0])
                Dove_3(DT_Ht);
            } else if (DT_Size == 2)
            {
                translate([-ML_Len,DoveCut_Y1_Offset,0])
                Dove_2(DT_Ht);
                translate([-ML_Len,DoveCut_Y2_Offset,0])
                Dove_2(DT_Ht);
            }
        }

        translate([ML_Len,DoveCut_Y1_Offset,0])
        Female_Dove();
        translate([ML_Len,DoveCut_Y2_Offset,0])
        Female_Dove();
        for(m = [0,1])
        {
            mirror([m,0,0])
            translate([-ML_Len+29.1,0,0])
            LocknutHole();          //Hole where center Section connects
        }
    }
}
module MidLedge()
{
    linear_extrude(height = Dove_Ht, center = false, convexity = 10)polygon(points = 
    [[7,34.6],[22.73,34.6],[23.51,34.5],[24.23,34.2],[24.85,33.72],
    [25.33,33.1],[25.63,32.38],[25.73,31.6],[25.73,25.28],[29,19],
    [11,19],[7,23]]);
    translate([29,19,DT_Ht])
    Dove_Weld(18);
}

module Ledge()
{
    linear_extrude(height = Dove_Ht, center = false, convexity = 10)polygon(points = 
    [[-25.73,25.28],[-25.73,31.6],[-25.63,32.38],[-25.33,33.1],[-24.85,33.72],
    [-24.23,34.2],[-23.51,34.5],[-22.73,34.6],[-7,34.6],[-7,23],
    [-11,19],[-29,19]]);
    translate([-11,19,DT_Ht])
    Dove_Weld();
}
module Female_Dove()
{
    translate([0,0,-1])
    linear_extrude(height = Dove_Ht + 2, center = false, convexity = 10)polygon(points = 
    [[1,-3.5],[0,-3.5],[-6.25,-4.55],[-6.25,4.55],[0,3.5],
    [1,3.5]]);
}
module Dove_4(D4_Ht = DT_Ht)
{
    linear_extrude(height = D4_Ht, center = false, convexity = 10)polygon(points = 
    [[0,-3.09],[-5.85,-4.07],[-5.85,4.07],[0,3.09]]);
}
//.3mm gap in dove tail joint
module Dove_3(D3_Ht = DT_Ht)
{
    linear_extrude(height = D3_Ht, center = false, convexity = 10)polygon(points = 
    [[0,3.2],[-5.95,4.19],[-5.95,-4.19],[0,-3.2]]);
}
//.2mm gap in dove tail joint
module Dove_2(D2_Ht = DT_Ht)
{
    linear_extrude(height = D2_Ht, center = false, convexity = 10)polygon(points = 
    [[0,3.3],[-6.05,4.31],[-6.05,-4.31],[0,-3.3]]);
}
module Dove_Weld(DW_Ht = 18)
{
    difference()
    {
        rotate([0,-90,0])
        cylinder(d=6,h=DW_Ht,$fn=4);
        translate([-(DW_Ht+1),-3,-6])
        cube([DW_Ht + 2,6,6]);
        translate([-(DW_Ht+1),0,-1])
        cube([DW_Ht + 2,6,6]);
    }
}
module Pipe_1x()
{
    color("silver",.5)
    translate([0,Pipe_Y_Offset,EMT12_Rad+DT_Ht])
    rotate([0,0,90])
    rotate([90,0,0])
    difference()
    {
        cylinder(d=EMT12_OD,h=E_H_Len,center=true,$fn=48);
        translate([0,0,-1])
        cylinder(d=15.8,h=E_H_Len+2,center=true,$fn=48);
        
    }
}
module VertexConnect()
{
    color("magenta")
    difference()
    {
        union()
        {
            linear_extrude(height = 21.51 + DT_Ht +6.25, center = false, convexity = 10)polygon(points = 
            [[-90.74,22],[-87.74,26],[-60.55,26],[-60.55,22]]);
            translate([-71.55,22,DT_Ht])
            Weld();

        }
//Drill hole to mount to Vertex
        translate([-81.9895,21,DT_Ht + 21.51])
        rotate([-90,0,0])
        cylinder(d=DT_Hole_OD,h=10,$fn=24);
//Chamfer outside top corner
        translate([-60.55,21,DT_Ht + 21.51 + 6.25])
        scale([1,1,1.8])
        rotate([-90,0,0])
        cylinder(d=20,h=10,$fn=4);
//Chamfer inside top corner
        translate([-90.74,21,DT_Ht + 21.51 + 6.25])
        rotate([-90,0,0])
        cylinder(d=12,h=10,$fn=4);
    }
}
module Weld()
{
    difference()
    {
        rotate([0,90,0])
        cylinder(d=Weld_OD,h=11,$fn=4);
        translate([-1,-Weld_OD/2,-Weld_OD])
        cube([13,Weld_OD,Weld_OD]);
        translate([-1,0,-1])
        cube([13,Weld_OD,Weld_OD]);
    }
}
module Center()
{
    difference()
    {
        color("cyan")
        union()
        {
            translate([0,0,DT_Ht])
            linear_extrude(height = Cen_Ht, center = false, convexity = 10)polygon(points = 
            [[-21.48,-83.06],[-19.59,-88.85],[-19.33,-89.48],[-19,-90.08],[-18.59,-90.63],
            [-18.12,-91.12],[-17.58,-91.54],[-17,-91.9],[-16.37,-92.17],[-15.72,-92.37],
            [-15.04,-92.47],[-14.36,-92.49],[-13.68,-92.43],[-13.02,-92.27],[-12.38,-92.03],
            [-11.77,-91.71],[-11.21,-91.32],[-10.71,-90.85],[-10.22,-90.4],[-9.66,-90.01],
            [-9.06,-89.71],[-8.43,-89.48],[-7.76,-89.35],[-7.09,-89.3],[7.09,-89.3],
            [7.76,-89.35],[8.43,-89.48],[9.06,-89.71],[9.66,-90.01],[10.22,-90.4],
            [10.71,-90.85],[11.21,-91.32],[11.77,-91.71],[12.38,-92.03],[13.02,-92.27],
            [13.68,-92.43],[14.36,-92.49],[15.04,-92.47],[15.72,-92.37],[16.37,-92.17],
            [17,-91.9],[17.58,-91.54],[18.12,-91.12],[18.59,-90.63],[19,-90.08],
            [19.33,-89.48],[19.59,-88.85],[21.48,-83.06],[82.67,22.92],[86.74,27.46],
            [87.16,28],[87.51,28.59],[87.78,29.21],[87.97,29.87],[88.07,30.54],
            [88.09,31.23],[88.01,31.91],[87.85,32.57],[87.61,33.21],[87.28,33.81],
            [86.88,34.37],[86.42,34.86],[85.89,35.3],[85.31,35.66],[84.69,35.95],
            [84.04,36.15],[83.39,36.35],[82.78,36.64],[82.22,37.01],[81.71,37.45],
            [81.26,37.95],[80.88,38.51],[73.79,50.79],[73.49,51.4],[73.28,52.04],
            [73.16,52.7],[73.12,53.37],[73.18,54.05],[73.32,54.7],[73.47,55.37],
            [73.54,56.05],[73.51,56.73],[73.4,57.41],[73.2,58.06],[72.92,58.68],
            [72.56,59.27],[72.13,59.8],[71.64,60.27],[71.09,60.67],[70.49,61],
            [69.85,61.25],[69.19,61.41],[68.51,61.49],[67.83,61.48],[67.15,61.39],
            [61.19,60.13],[-61.19,60.13],[-67.15,61.39],[-67.83,61.48],[-68.51,61.49],
            [-69.19,61.41],[-69.85,61.25],[-70.49,61],[-71.09,60.67],[-71.64,60.27],
            [-72.13,59.8],[-72.56,59.27],[-72.92,58.68],[-73.2,58.06],[-73.4,57.41],
            [-73.51,56.73],[-73.54,56.05],[-73.47,55.37],[-73.32,54.7],[-73.18,54.05],
            [-73.12,53.37],[-73.16,52.7],[-73.28,52.04],[-73.49,51.4],[-73.79,50.79],
            [-80.88,38.51],[-81.26,37.95],[-81.71,37.45],[-82.22,37.01],[-82.78,36.64],
            [-83.39,36.35],[-84.04,36.15],[-84.69,35.95],[-85.31,35.66],[-85.89,35.3],
            [-86.42,34.86],[-86.88,34.37],[-87.28,33.81],[-87.61,33.21],[-87.85,32.57],
            [-88.01,31.91],[-88.09,31.23],[-88.07,30.54],[-87.97,29.87],[-87.78,29.21],
            [-87.51,28.59],[-87.16,28],[-86.74,27.46],[-82.67,22.92]]);
            CenterTop();
        }
        translate([0,0,-1])
        linear_extrude(height = DT_Ht + 1, center = false, convexity = 10)polygon(points = 
        [[-60.28,54.38],[-61.15,54.88],[-78.1,25.51],[-77.24,25.01],[-16.96,-79.4],
        [-16.96,-80.4],[16.96,-80.4],[16.96,-79.4],[77.24,25.01],[78.1,25.51],
        [61.15,54.88],[60.28,54.38]]);
//Inside cut all the way thru
        translate([0,0,-1])
        linear_extrude(height = Total_Ht + 2, center = false, convexity = 10)polygon(points = 
        [[-5.87,-79.4],[5.87,-79.4],[71.7,34.61],[65.82,44.78],[-65.82,44.78],
        [-71.7,34.61]]);
        translate([0,0,-1])
        linear_extrude(height = DT_Ht + 1, center = false, convexity = 10)polygon(points = 
        [[-78.39,27.01],[-15.8,-81.4],[15.8,-81.4],[78.39,27.01],[62.59,54.38],
        [-62.59,54.38]]);
        for (a = [0:2])
        {

            rotate([0,0,a * 120])
            {
//Add mounting holes to outer Dovetail frame
                translate([-14.55,-87.1968,-1])
                cylinder(d=DT_Hole_OD,h = DT_Ht * 2,$fn=DT_Hole_OD_Res);
                translate([14.55,-87.1968,-1])
                cylinder(d=DT_Hole_OD,h = Total_Ht + 2,$fn=DT_Hole_OD_Res);
//Add M3 holes spaced 25mm apart for adding electronics mounting plates
                for (x = [-E_Qty_Loop:E_Qty_Loop])
                {
                    translate([x * EL_Mnt_Hole_Spacing,49.58,-1])
                    cylinder(d=DT_M3,h=Total_Ht + 2,$fn=DT_M3_Res);
                }
            }
        }
    }  
}
module CenterTop()
{
    linear_extrude(height = DT_Ht, center = false, convexity = 10)polygon(points = 
    [[-23.6,-79.4],[23.6,-79.4],[80.56,19.26],[56.96,60.13],[-56.96,60.13],
    [-80.56,19.26]]);
}
module MidFrame()
{
    translate([0,125.2073,0])     //125.2073mm from Vertex origin Point
    color("cyan")
    difference()
    {
        linear_extrude(height = Total_Ht, center = false, convexity = 10)polygon(points = 
        [[-61.19,0],[-67.15,-1.25],[-67.83,-1.35],[-68.51,-1.36],[-69.19,-1.28],
        [-69.85,-1.12],[-70.49,-0.87],[-71.09,-0.54],[-71.64,-0.13],[-72.13,0.34],
        [-72.56,0.87],[-72.92,1.45],[-73.2,2.07],[-73.4,2.73],[-73.51,3.4],
        [-73.54,4.08],[-73.47,4.76],[-73.32,5.43],[-73.18,6.09],[-73.12,6.76],
        [-73.16,7.43],[-73.28,8.1],[-73.49,8.74],[-73.79,9.34],[-80.88,21.62],
        [-81.26,22.18],[-81.71,22.69],[-82.22,23.13],[-82.78,23.49],[-83.39,23.78],
        [-84.04,23.98],[-84.69,24.19],[-85.31,24.47],[-85.89,24.84],[-86.42,25.27],
        [-86.88,25.77],[-87.28,26.32],[-87.61,26.92],[-87.85,27.56],[-88.01,28.23],
        [-88.09,28.91],[-88.07,29.59],[-87.97,30.26],[-87.78,30.92],[-87.51,31.55],
        [-87.16,32.14],[-86.74,32.67],[-86.41,33.01],[-85.91,33.42],[-85.37,33.77],
        [-84.79,34.05],[-84.17,34.25],[-83.54,34.38],[-82.9,34.43],[-82.25,34.41],
        [-76.49,33.82],[76.49,33.82],[82.25,34.41],[82.9,34.43],[83.54,34.38],
        [84.17,34.25],[84.79,34.05],[85.37,33.77],[85.91,33.42],[86.41,33.01],
        [86.74,32.67],[87.16,32.14],[87.51,31.55],[87.78,30.92],[87.97,30.26],
        [88.07,29.59],[88.09,28.91],[88.01,28.23],[87.85,27.56],[87.61,26.92],
        [87.28,26.32],[86.88,25.77],[86.42,25.27],[85.89,24.84],[85.31,24.47],
        [84.69,24.19],[84.04,23.98],[83.39,23.78],[82.78,23.49],[82.22,23.13],
        [81.71,22.69],[81.26,22.18],[80.88,21.62],[73.79,9.34],[73.49,8.74],
        [73.28,8.1],[73.16,7.43],[73.12,6.76],[73.18,6.09],[73.32,5.43],
        [73.47,4.76],[73.54,4.08],[73.51,3.4],[73.4,2.73],[73.2,2.07],
        [72.92,1.45],[72.56,0.87],[72.13,0.34],[71.64,-0.13],[71.09,-0.54],
        [70.49,-0.87],[69.85,-1.12],[69.19,-1.28],[68.51,-1.36],[67.83,-1.35],
        [67.15,-1.25],[61.19,0]]);
        for(m = [0,1])
        {
            mirror([m,0,0])
            {
                translate([0,0,-1])
                linear_extrude(height = Total_Ht-1 -Cen_Ht, center = false, convexity = 10)polygon(points = 
                [[55.1,-2.36],[71.88,-2.36],[93.7,35.43],[76.92,35.43]]);
                translate([68.2396,3.934,-1])
                cylinder(d=DT_Hole_OD,h = Dove_Ht + 2,$fn=DT_Hole_OD_Res);
                translate([82.7896,29.1353,-1])
                cylinder(d=DT_Hole_OD,h = Dove_Ht + 2,$fn=DT_Hole_OD_Res);
                for (x = [-E_Qty_Loop:E_Qty_Loop])
                {
                    translate([x * EL_Mnt_Hole_Spacing,27,-1])
                    cylinder(d=DT_M3,h=Total_Ht + 2,$fn=DT_M3_Res);
                }
            }
        }
        translate([-89,12.45,-1])
        cube([178,23,Total_Ht - 1 - Cen_Ht]);
    }
}
module MidLegBracket()
{
    color("cyan")
    translate([0,0,Ledge_Ht])
    difference()
    {
        linear_extrude(height = Ledge_Ht, center = false, convexity = 10)polygon(points = 
        [[22.73,33.1],[-22.73,33.1],[-23.51,33],[-24.23,32.7],[-24.85,32.23],
        [-25.33,31.6],[-25.63,30.88],[-25.73,30.1],[-25.73,23.5],[-25.63,22.73],
        [-25.33,22],[-24.85,21.38],[-24.23,20.91],[-23.51,20.61],[-22.73,20.5],
        [-15.88,20.5],[-15.18,20.54],[-14.49,20.66],[-13.81,20.85],[-13.17,21.12],
        [-12.55,21.46],[-11.98,21.86],[-11.45,22.32],[-10.98,22.84],[-10.47,23.38],
        [-9.89,23.84],[-9.25,24.21],[-8.56,24.48],[-7.83,24.65],[-7.09,24.7],
        [7.09,24.7],[7.83,24.65],[8.56,24.48],[9.25,24.21],[9.89,23.84],
        [10.47,23.38],[10.98,22.84],[11.45,22.32],[11.98,21.86],[12.55,21.46],
        [13.17,21.12],[13.81,20.85],[14.49,20.66],[15.18,20.54],[15.88,20.5],
        [22.73,20.5],[23.51,20.61],[24.23,20.91],[24.85,21.38],[25.33,22],
        [25.63,22.73],[25.73,23.5],[25.73,30.1],[25.63,30.88],[25.33,31.6],
        [24.85,32.23],[24.23,32.7],[23.51,33]]);
        for (x = [-1,1])
        {
            translate([x * DT_Hole_X_Offset,DT_Hole_Y_Offset,-1])
            cylinder(d=DT_Hole_OD,h = Dove_Ht + 2,$fn=DT_Hole_OD_Res);
        }
    }
}
module VertexBottom()
{
    color("green",.5)
    rotate([0,0,180])
    import("Vertex_2x_EM12TH_4xEMT12V_rev100.stl", convexity=3);
    nema17();
}
module nema17()
{
    color("red",.5)
    translate([0,-57.78,-12])
    rotate([0,0,90])
    union()
    {
        translate([0,-.4,33.35])
        rotate([0,-90,0])
        {
            linear_extrude(height = Nema_Ht, center = false, convexity = 10)polygon(points = 
            [[-21.1,-14.07],[-20.63,-14.99],[-14.99,-20.63],[-14.07,-21.1],[14.07,-21.1],
            [14.99,-20.63],[20.63,-14.99],[21.1,-14.07],[21.1,14.07],[20.63,14.99],
            [14.99,20.63],[14.07,21.1],[-14.07,21.1],[-14.99,20.63],[-20.63,14.99],
            [-21.1,14.07]]);
            translate([0,0,-2])
            cylinder(d1=22.3,d2=24.3,h=2,$fn=72);
            translate([0,0,-23])
            cylinder(d=7,h=23);
    
            translate([-15.5,-15.5,-10])
            cylinder(d=3.2,h=10);
            translate([15.5,-15.5,-10])
            cylinder(d=3.2,h=10);
            translate([-15.5,15.5,-10])
            cylinder(d=3.2,h=10);
            translate([15.5,15.5,-10])
            cylinder(d=3.2,h=10);
        }
    }
}
module VertexHole()
{
    translate([0,114,0])
    rotate([0,0,120])
    translate([-EMT12_Rad,185.34+EMT12_Rad,-1])
    {
        cylinder(d=DT_Hole_OD,h = Dove_Ht + 2,$fn=36);  //hole under 1/2"EMT Vertical
//Taper Hole so head is above bottom of plate
        cylinder(d1=DT_ScrewHD_OD,d2=DT_Hole_OD,h = DT_ScrewHD_Ht + 1,$fn=36);
    }
}
module LocknutHole()
{
    translate([-DT_Hole_X_Offset,DT_Hole_Y_Offset,-1])
    rotate([0,0,30])            //Rotate to give more clearance at DoveTail Joint
    {
        rotate([0,0,7.5])       //Rotate for better transion of Nut trap to drill hole
                                //This will match 1 of the 24 sides to a 6 side
        cylinder(d=DT_Hole_OD,h = Dove_Ht + 2,$fn=DT_Hole_OD_Res);
        cylinder(d=M4Nut_OD,h = M4Nut_Ht + 1,$fn=6);
//Transition Nut Trap to hole diameter at 45 degree incline
        translate([0,0,M4Nut_Ht + .99])
        cylinder(d1=M4Nut_OD,d2 = 5.32,h = 1.31,$fn=6);
//Add access hole to locknut in case needed hold while tightening
        translate([0,0,5])
        rotate([-90,0,0])
        cylinder(d=3,h=10,$fn=12);
    }
}
module Lt_DoveTail()
{
    difference()
    {
        Leg();
//Cut out the 2 Female Dovetail joints
        translate([0,DoveCut_Y1_Offset,0])
        Female_Dove();
        translate([0,DoveCut_Y2_Offset,0])
        Female_Dove();
    }
}
module Rt_DoveTail()
{
    color("blue")
    difference()
    {
        union()
        {
            mirror([1,0,0])
            Leg();
//Add the Male Dove Tail joint of either .4, .3 or .2mm clearanc
            if (DT_Size == 4)
            {
                translate([0,DoveCut_Y1_Offset,0])
                Dove_4(DT_Ht);
                translate([0,DoveCut_Y2_Offset,0])
                Dove_4(DT_Ht);
            } else if (DT_Size == 3)
            {
                translate([0,DoveCut_Y1_Offset,0])
                Dove_3(DT_Ht);
                translate([0,DoveCut_Y2_Offset,0])
                Dove_3(DT_Ht);
            } else if (DT_Size == 2)
            {
                translate([0,DoveCut_Y1_Offset,0])
                Dove_2(DT_Ht);
                translate([0,DoveCut_Y2_Offset,0])
                Dove_2(DT_Ht);
            }
        }
    }
}
module HB_Bracket()
{
    translate([0,0,9+5+25])
    rotate([0,0,90])
    rotate([90,0,0])
    translate([0,0,-6])
    color("red",.5)
    import("HB_EMT12_Bracket_Simple_rev2.stl", convexity=3);
}

module OuterFrame()
{
    translate([-(L2 - 133.235),0,0])
    Lt_DoveTail();
    translate([L2 - 133.235,0,0])
    Rt_DoveTail();
}
//////////////////////////////////////////////
/// Begin displaying different Print types ///
//////////////////////////////////////////////
if (Print_Part == 0)
{

    if (Build_Plate_OD == 210)
    {
        Lt_DoveTail();
        translate([0,-14,0])
        rotate([0,0,180])
        Rt_DoveTail();
        translate([-110,117,DT_Ht + Cen_Ht])
        rotate([180,0,180])
        Center();
    } else
    {
        translate([0,120,0])
        Lt_DoveTail();
        translate([0,-14,0])
        rotate([0,0,180])
        Rt_DoveTail();
        translate([-75,-85,0])
        MidLeg();
        translate([-89,30,0])
        for (a = [0:2])
        {
            translate([0,a * 40,0])
            translate([0,125.2073,DT_Ht + Cen_Ht])
            rotate([180,0,0])
            MidFrame();
        }
        if (Mid_Leg_Qty == 2)
        {
            for (q = [0:2])
            {
                translate([q * 16.6,0,0])
                translate([-17,25.6,0])
                rotate([0,0,-90])
                MidLegBracket();
            }
        } else if (Mid_Leg_Qty == 3)
        {
            for (y = [0:1])
            {
                for (q = [0:2])
                {
                    translate([q * 16.6,y * 56,0])
                    translate([-17,25.6,0])
                    rotate([0,0,-90])
                    MidLegBracket();
                }
            }
        }
    }
} else if (Print_Part == 1)
{
    if (Build_Plate_OD == 210)
    {
        translate([0,0,Ledge_Ht])
        Center();
    }
    for (a = [0:2])
    {
        rotate([0,0,a * 120])
        translate([0,Pipe_Y_Offset - 9,0])
        OuterFrame();
        if (Build_Plate_OD > 210)
        {
            rotate([0,0,a * 120])
            {
                translate([0,Pipe_Y_Offset - 9,0])
                for (q = [0:M_Qty-1])
                {
                    translate([q * (ML_Len * 2),0,0])
                    translate([-MidLeg_Len,0,0])
                    translate([ML_Len,0,0])
                    MidLeg();                    
                }
                if (Mid_Leg_Qty > 1)
                {
                    if (Mid_Leg_Qty == 2)
                    {
                        translate([0,Pipe_Y_Offset - 9,DT_Ht])
                        MidLegBracket();
                    } else if (Mid_Leg_Qty == 3)
                    {
                        translate([-ML_Len,Pipe_Y_Offset - 9,DT_Ht])
                        MidLegBracket();
                        translate([ML_Len,Pipe_Y_Offset - 9,DT_Ht])
                        MidLegBracket();
                    }
                }
            }
        }
        rotate([0,0,a* 120])
        %Pipe_1x();
        rotate([0,0,a * 120])
        translate([0,0,25])
        %Pipe_1x();

        rotate([0,0,a * 120])
        rotate([0,0,60])
        translate([0,-Pipe_Y_Offset,0])
        %HB_Bracket();
    }
    for (a = [0:2])
    {
        rotate([0,0,a * 120])
        {
            translate([Vertex_X,Vertex_Y,1 + DT_Ht])
            rotate([0,0,-120])
            %VertexBottom();
            if (Build_Plate_OD > 210)
            { 
                translate([-Vertex_X,Vertex_Y,1 + DT_Ht])
                rotate([0,0,-60])
                MidFrame();
            }
        }
    }
} else if (Print_Part == 2)
{
    difference()
    {
        Lt_DoveTail();
        translate([80,0,0])
        VertexHole();
    }
} else if (Print_Part == 3)
{
    Rt_DoveTail();
} else if (Print_Part == 4)
{
    MidLeg();
} else if (Print_Part == 5)
{
    Lt_DoveTail();
    translate([0,-14,0])
    rotate([0,0,180])
    Rt_DoveTail();
    if (Mid_Leg_Qty > 0)
    {
        translate([-75,-85,0])
        MidLeg();
    }
} else if (Print_Part == 6)
{
    if (Build_Plate_OD == 210)
    {
        translate([0,0,DT_Ht + Cen_Ht])
        rotate([180,0,0])
        Center();
    } else
    {
        for (a = [0:2])
        {
            translate([0,a * 40,0])
            translate([0,125.2073,DT_Ht + Cen_Ht])
            rotate([180,0,0])
            MidFrame();
        }
    }
} else if (Print_Part == 7)
{
    difference()
    {
        union()
        {
            Lt_DoveTail();
            translate([31,0,0])
            VertexConnect();            //Test horizontal hole height & size
        }
        translate([-200,-100,-1])
        cube([140.3,200,200]);
        translate([-59.7,0,-1])
        cylinder(d=36,h=20,$fn=4);
        translate([140,0,0])
        VertexHole();           //Test tapered hold that will be under Vetex
    }
    translate([8,0,0])
    difference()
    {
        Rt_DoveTail();
        translate([23,-100,-1])
        cube([170,200,200]);
        translate([23,0,-1])
        cylinder(d=24,h=20,$fn=4);
    }
}
