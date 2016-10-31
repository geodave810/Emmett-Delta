//Shim to replace multiple shims used with V-Slot Wheels & also create a wider shim
// 11/23/2015 By: David Bunch
//

//CUSTOMIZER VARIABLES

//1. Maximum Outside Diameter of Shim
ShimMaxOD = 14;

//2. Minimum Outside Diameter of Shim
ShimMinOD = 8.8;

//3. Height of Shim
ShimTotHt = 8.7;        //My print heights are usually about .3mm higher than specified

//4. Height of Base before Taper
SimBaseHt = 2.5;

//3. Diameter of Bolt Hole
M5 = 5.5;

//4. How Many shims to print (1,2,3 or 4)
Qty = 3;

//5. Resolution of Shim
iRes = 72;

TaperHt = ShimTotHt - SimBaseHt;        //Calculate height of Taper
$fn= iRes;

//CUSTOMIZER VARIABLES END

module TaperShim(S_ODBig = ShimMaxOD, S_ODSmall = ShimMinOD, S_THT = ShimTotHt, S_BHT = SimBaseHt)
{
    color("cyan")
    {
        difference()
        {
            union()
            {
                cylinder(d=S_ODBig,h=S_BHT);
                translate([0,0,S_BHT])
                cylinder(d1=S_ODBig,d2=S_ODSmall,h=S_THT-S_BHT);
            }
            translate([0,0,-.1])
            cylinder(d=M5,h=S_THT+.2);
        }
    }
}
if (Qty == 1)
{
    TaperShim();
}
if (Qty > 1)
{
    rotate([0,0,0])
    translate([ShimMaxOD-3,0,0])
    TaperShim();
    rotate([0,0,90])
    translate([ShimMaxOD-3,0,0])
    TaperShim();
    if (Qty > 2)
    {
        rotate([0,0,180])
        translate([ShimMaxOD-3,0,0])
        TaperShim();
        if (Qty > 3)
        {
            rotate([0,0,-90])
            translate([ShimMaxOD-3,0,0])
            TaperShim();
        }
    }
}