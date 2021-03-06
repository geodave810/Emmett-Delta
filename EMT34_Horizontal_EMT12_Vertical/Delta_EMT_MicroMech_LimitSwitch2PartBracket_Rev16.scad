//Mechanical Micro Limit Switch bracket
//10/21/2016    By: David Bunch
//This is for a 12.7 x 6.5 x 5.8mm Micro Limit Switch
//With 2.5mm Hole Spacing 9.7mm apart

Ht = 8.1;               //Height of Limit Switch Bracket
EMT_OD=18.4;            //Used for the Internal Cuts
M3 = 3.4;               //Holding Bolt Diameter hole
M2 = 2.2;               //Diameter of Limit Switch holes

Display_Type = 0;        //0 = Display for Printing
                        //1 = Display Assembly of Parts
Slider_Mirror = 0;      //1 = Mirror Slider, 0 = No Mirror
Spacer_On = 1;          //1 = Draw 2 spacers, 0 = No Spacers
Spacer_ID = 2.2;        //Interal Diameter of Screw hole for Spacer
Spacer_OD = 5.2;        //Outside Diameter of Spacer
Spacer_Ht = 2;          //Spacer height

Ht_2 = Ht / 2;
EMT_Rad = EMT_OD / 2;
EMT_Res = (round(((EMT_OD * 3.14)/4)/.7)*4);
echo(EMT_Res = EMT_Res);
EMT12_OD = 17.9;    //This is the Diameter of the 1/2" EMT for Display only
EMT12_Rad = EMT12_OD / 2;

M3_Res = 16;
echo(Ht = Ht);
EMT12OD_Res = (round(((EMT12_OD * 3.14)/4)/.7)*4);
$fn=24;

module LimitSwitch()
{
    {
        translate([2,-(EMT_OD)-3,-6.7])
        rotate([90,0,0])
        {
            color("Black",.5)
            difference()
            {
                union()
                {
                    cube([12.7,6.5,5.8]);
                    translate([3.375,5.7,0])
                    cylinder(d=3.4641,h=5.8,$fn=6);
                    translate([9.25,5.7,0])
                    cylinder(d=3.4641,h=5.8,$fn=6);
                }
                translate([3.375,5.7,-1])
                cylinder(d=2,h=7.8,$fn=12);
                translate([9.25,5.7,-1])
                cylinder(d=2,h=7.8,$fn=12);
            }
            color("Silver",.5)
            translate([0,0,.5])
            linear_extrude(height = 5, center = false, convexity = 10)polygon(points = 
            [[12.82,0.29],[0.18,-3.24],[-0.24,-3.97],[-0.74,-4.43],[-1.36,-4.71],
            [-2.03,-4.79],[-2.69,-4.66],[-3.33,-4.31],[-3.47,-4.58],[-2.8,-4.95],
            [-2.04,-5.09],[-1.28,-5],[-0.58,-4.68],[-0.01,-4.17],[0.38,-3.5],
            [12.9,0]]);
        }
    }
}
module Slider()
{
    translate([0,0,-63-16.1+4])
    rotate([0,0,180])
    if (Slider_Mirror == 1)
    {
        translate([26+8.95,9.5+17.9,0])         //used for Mirror
        rotate([90,0,0])
        {
            mirror([1,0,0])
            {
                color("cyan",.5)
                import("emt_customizableslider_rev26a_lowerheight.stl", convexity=3);
                color("red",.5)
                Carriage();
            }
        }
    } else
    {
        translate([-26-8.95,9.5+17.9,0])      //used for Not Mirrored
        rotate([90,0,0])
        {
            color("cyan",.5)
            import("emt_customizableslider_rev26a_lowerheight.stl", convexity=3);
            color("red",.5)
            Carriage();
        }
    }
}
module Carriage()
{
    translate([34.7,40,0])
    rotate([180,0,180])
    import("Carriage_Mod_M3_Right_Rev22.stl", convexity=3);
}
module TopVertex()
{
    color("Silver",.2)
    translate([0,0,40+Ht])
    rotate([0,180,0])
    import("VertexTop_1xEMTH_4xEMTV_rev54_repaired.stl", convexity=3);
}
module IdlerAssembly()
{
    color("cyan",.5)
    translate([0,-8.5,40+Ht])
    rotate([0,180,0])
    import("Idler_2holeMount_44mmHoleSpacingAssembly_rev8_repaired.stl", convexity=3);
}
module Plate()
{
    mirror([1,0,0])
    linear_extrude(height = Ht, center = false, convexity = 10)polygon(points = 
    [[12.88,22.78],[11.5,21.4],[6.77,21.4],[2.29,19.54],[-2.29,19.54],
    [-6.77,21.4],[-11.63,21.4],[-16.11,19.54],[-19.54,16.11],[-21.4,11.63],
    [-21.4,6.77],[-19.54,2.29],[-19.54,-2.29],[-21.4,-6.77],[-21.4,-11.5],
    [-22.78,-12.88],[-12.88,-22.78],[-11.5,-21.4],[-6.77,-21.4],[-2.29,-19.54],
    [2.29,-19.54],[6.77,-21.4],[11.63,-21.4],[16.11,-19.54],[19.54,-16.11],
    [21.4,-11.63],[21.4,-6.77],[19.54,-2.29],[19.54,2.29],[21.4,6.77],
    [21.4,11.5],[22.78,12.88]]);
}
module EMT_Nut()
{
    translate([-1,21.4,Ht_2])
    rotate([-90,0,0])
    rotate([0,-90,0])
    difference()
    {
        linear_extrude(height = 6, center = false, convexity = 10)polygon(points = 
        [[8.23,-1.74],[8.23,1.74],[8.19,2.13],[8.08,2.51],[7.89,2.86],
        [7.64,3.16],[0,10.8],[-0.86,10.8],[-0.86,-10.8],[0,-10.8],
        [7.64,-3.16],[7.89,-2.86],[8.08,-2.51],[8.19,-2.13]]);
    }
}

module EMT_NutsSide()
{
    EMT_Nut();
    translate([8,0,0])
    EMT_Nut();
}
module PipeSlot()
{
    translate([-1,-1,-1])
    cube([2,EMT_OD*3,Ht+20]);
}
module Pipes4xCuts(EMT_Ht = Ht)
{
    for (x =[-1,1])
    {
        for (y = [-1,1])
        {
            translate([x*EMT_Rad,y*EMT_Rad,-1])
            cylinder(d=EMT_OD,h=EMT_Ht + 2,$fn=EMT_Res);
            translate([x*EMT_Rad,y*EMT_Rad,-.01])
//Chamfer bottom opening
            cylinder(d1=EMT_OD+4,d2=EMT_OD,h=2.01,$fn=EMT_Res);
            translate([x*EMT_Rad,y*EMT_Rad,EMT_Ht-2])
//Chamfer Top Pipe opening
            cylinder(d1=EMT_OD,d2=EMT_OD+2,h=2.01,$fn=EMT_Res);
        }
    }
}
module Pipes4x(EMT_Ht = Ht)
{
    for (x =[-1,1])
    {
        for (y = [-1,1])
        {
            difference()
            {
                translate([x*EMT_Rad,y*EMT_Rad,-1])
                cylinder(d=EMT_OD,h=EMT_Ht + 2,$fn=EMT_Res);
                translate([x*EMT_Rad,y*EMT_Rad,-2])
                cylinder(d=EMT_OD-2.8,h=EMT_Ht + 4,$fn=EMT_Res);
            }
        }
    }
}
module ExtendBracket()
{
    EB_Ht = 2;
    difference()
    {
    translate([2,-(19.4+EB_Ht),-6.5])
        cube([12.7,EB_Ht,6.5+Ht]);
        translate([5.415,-22,-1])
        rotate([-90,0,0])
        cylinder(d=M2,h=10,$fn=M3_Res,center=true);
        translate([11.425,-22,-1])
        rotate([-90,0,0])
        cylinder(d=M2,h=10,$fn=M3_Res,center=true);
        translate([2,-21.4,-7.7])
        cylinder(d=4,h=8.7+Ht,$fn=4);
        translate([2+12.7,-21.4,-7.7])
        cylinder(d=4,h=8.7+Ht,$fn=4);
    }
}

module Spacer()
{
    difference()
    {
        cylinder(d=Spacer_OD,h=Spacer_Ht);
        translate([0,0,-1])
        cylinder(d=Spacer_ID,h=Spacer_Ht+2,$fn=24);
    } 
}
module DrawFinal()
{
    difference()
    {
        union()
        {
            rotate([0,0,90])
            difference()
            {
                union()
                {
                    Plate();
                    translate([0,0,0])
                    rotate([0,0,45])
                    {
                    EMT_NutsSide();
                    mirror([0,1,0])
                    EMT_NutsSide();
                    }
                }
                Pipes4xCuts();
        
                translate([0,0,-1])
                rotate([0,0,22.5])
                cylinder(d=34,h=Ht+2,$fn=8);
                rotate([0,0,45])
                {
                    PipeSlot();
                    mirror([0,1,0])
                    PipeSlot();
                }
                translate([0,0,Ht])
                cylinder(d=200,h=10);
                translate([0,0,-10])
                cylinder(d=200,h=10);
        
            }
            ExtendBracket();
        }
        rotate([0,0,45])
        {
            translate([26.6,0,Ht/2])
            rotate([90,0,0])
            cylinder(d=M3,h=16,$fn=24,center=true);
            translate([-26.6,0,Ht/2])
            rotate([90,0,0])
            cylinder(d=M3,h=16,$fn=24,center=true);
        }
    }
}
if (Display_Type == 0)
{
    translate([0,0,Ht])
    rotate([0,180,0])
    {
        DrawFinal();
        %LimitSwitch();
    }
    if (Spacer_On == 1)
    {
        translate([-4,0,0])
        Spacer();
        translate([4,0,0])
        Spacer();
    }
} else if (Display_Type == 1)
{
    %IdlerAssembly();
    %TopVertex();
    
    %Slider();
    %LimitSwitch();
    translate([0,0,-171+Ht])
    %Pipes4x(200);
    DrawFinal();
}