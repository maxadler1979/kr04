module prizm_add_dfask(n, height, rib, r_fask, fn_fask, center = false)
{
  r = rib/sqrt(3);
  minkowski()
  {
    cylinder(height/2, r, r, $fn=n, center);
    cylinder(height/2, r_fask, r_fask, $fn=fn_fask*32, center);
  }
}

//базовая призма
module prizm_side(n, w, h, r, center = true)
{
  rotate([0,-90,180])
  {
    prizm_add_dfask(n, w, h, r,16, center);
  }
}
//призма - труба
module prizm_box(n, w, h, r, t, center = true)
{
  r2 = (r-t < 0) ? 0.1 :  r-t;
  rotate([0,-90,180]) difference()
  {
    prizm_add_dfask(n, w, h, r,16, center);
    translate([0,0,-0.5])prizm_add_dfask(n, w+3, h, r2,16, center);
  }
}



 //толщина платы
plateThickness=4;
//размер кнопки взят из даташита на cherry
lkey=19.05;
//Hole size, from Cherry MX data sheet
holesize=14;
//length, in units, of board
width2=15.6;
//Height, in units, of board
height2=6;
//Radius of mounting holes
mountingholeradius=2;
//height of switch clasp cutouts
cutoutheight = 3;
//width of switch clasp cutouts
cutoutwidth = 1;

//calculated vars

holediff=lkey-holesize;
w2=width2*lkey;
h3=height2*lkey;





h=268;
r=10;
t= 5; // толщина корпуса
w=147;
z = h/(sqrt(3)*2) + r;
h2=40;
ts = 8; // толщина боковой стенки
ts2 = 5;



 
 
 





digit_holes = [
        [[0,1],1],
        [[1,1],1],
        [[2,1],1],
        [[3,1],1],
        [[4,1],1],
        [[5,1],1],
        [[6,1],1],
        [[7,1],1],
        [[8,1],1],
        [[9,1],1],
        [[10,1],1],
        [[11,1],1],
        [[12,1],1],
        [[13,1],1],
        [[14,1],1.5],//backspace
        ];

// keyboard layout layer
kr04keyboard = [
//start ROW 0
[[0,0],1.5],//k1
[[1.5,0],1.5],  //k2
[[3,0],1.5],//k3
[[4.5,0],1.5],  //k4
[[6,0],1.5],//k5
[[9,0],1.5],
[[10.5,0],1.5],
[[12.5,0],1.5],
[[14,0],1.5],
//ROW1

//row2
[[0,2],1.5],//tab
[[1.5,2],1],
[[2.5,2],1],
[[3.5,2],1],
[[4.5,2],1],
[[5.5,2],1],
[[6.5,2],1],
[[7.5,2],1],
[[8.5,2],1],
[[9.5,2],1],
[[10.5,2],1],
[[11.5,2],1],
[[12.5,2],1],
[[13.5,2],1],
[[14.5,2],1],//enter up
//row3
[[0,3],1.75],//upr
[[1.75,3],1],
[[2.75,3],1],
[[3.75,3],1],
[[4.75,3],1],
[[5.75,3],1],
[[6.75,3],1],
[[7.75,3],1],
[[8.75,3],1],
[[9.75,3],1],
[[10.75,3],1],
[[11.75,3],1],
[[12.75,3],1.25],
[[14,3],2],
//row4
[[0,4],1.25],
[[1.25,4],1],
[[2.25,4],1],
[[3.25,4],1],
[[4.25,4],1],
[[5.25,4],1],
[[6.25,4],1],
[[7.25,4],1],
[[8.25,4],1],
[[9.25,4],1],
[[10.25,4],1],
[[11.25,4],1.25],
[[12.5,4],1],
[[13.5,4],1],
[[14.5,4],1],
//row5
[[0,5],2],
[[2,5],1.25],


[[10.5,5],2],
[[12.5,5],1],
[[13.5,5],1],
[[14.5,5],1],

];



module plate(w2,h3){
	cube([w2,h3,plateThickness]);
}

module switchhole(){
	union(){
		cube([holesize,holesize,plateThickness]);

		translate([-cutoutwidth,1,0])
		cube([holesize+2*cutoutwidth,cutoutheight,plateThickness]);

		translate([-cutoutwidth,holesize-cutoutwidth-cutoutheight,0])
		cube([holesize+2*cutoutwidth,cutoutheight,plateThickness]);
	}
}

module holematrix(holes,startx,starty){
	for (key = holes){
		translate([startx+lkey*key[0][0], starty-lkey*key[0][1], 0])
		translate([(lkey*key[1]-holesize)/2,(lkey - holesize)/2, 0])
		switchhole();
	}
}

module mountingholes(){
	translate([6,9,0])
	cylinder(h=plateThickness,r=mountingholeradius, $fn=12);
    translate([65,9,0])
	cylinder(h=plateThickness,r=mountingholeradius, $fn=12);
    translate([110,9,0])
	cylinder(h=plateThickness,r=mountingholeradius, $fn=12);
    translate([200,9,0])
	cylinder(h=plateThickness,r=mountingholeradius, $fn=12);
    translate([155,104,0])
	cylinder(h=plateThickness,r=mountingholeradius, $fn=12);
    translate([28,104,0])
	cylinder(h=plateThickness,r=mountingholeradius, $fn=12);
    translate([266,104,0])
	cylinder(h=plateThickness,r=mountingholeradius, $fn=12);
    translate([269,48,0])
	cylinder(h=plateThickness,r=mountingholeradius, $fn=12);
    translate([30,48,0])
	cylinder(h=plateThickness,r=mountingholeradius, $fn=12);
}

module kr04plate(){
	     difference(){
		 plate(w2,h3);
		 translate([0,0,-0.1]) scale([1,1,1.05]) holematrix(kr04keyboard,0,h3-lkey);
            translate([3,0,-0.1]) scale([1,1,1.05])holematrix(digit_holes,0,h3-lkey);

        
		translate([0,0,-0.1]) scale([1,1,1.05]) mountingholes();
        translate([74,2.5,-0.1]) scale([1,1,1.05]) switchhole();
        translate([124,2.5,-0.1]) scale([1,1,1.05]) switchhole();
        translate([174,2.5,-0.1]) scale([1,1,1.05]) switchhole();
	}
}
zw=169;
 module pravy_chast()
intersection()
{
  //translate([0,50,h2/2])cube([169,h,h2],true); // уберем треугольник оставим санки # - подсветка  
      translate([0,50,h2/2])
  {
    hull()
    {  
      translate([0,-h/2+55.5,0]) cube([zw,111,h2],true); // уберем треугольник оставим санки # - подсветка   
      translate([0,h/2-1,-10])cube([zw,2,h2-20],true); // уберем треугольник оставим санки # - подсветка   
    }
  }
  translate([0,0,z]) //rotate([0,0,0]) 
  union()
  {  
      difference() { 
       translate([8,0,-0])prizm_box(3, 153, h, r, t);
       translate([-74,130,-65]) cube([159,6,5],false);   // фаска под клаву спереди 
       translate([-68,-87,-87.5]) cube([140,110,6],false); //дыра внизу 1
       translate([-68,37,-87.5])  cube([140,100,6],false);  //дыра внизу 2
       translate([-70,-87,-87.5]) cube([142,114,2.5],false); //фаска под дырку 1
       translate([-70,34,-87.5])  cube([142,104,2.5],false); //фаска под дырку 2
       //translate([-70,-80,-87.5]) cube([142,4,2.5],false); // фаска 
        translate([70,-83,-87.5]) cube([5,110,2.5],false); //фаска под дырку 1
          translate([70,34,-87.5]) cube([5,104,2.5],false); //фаска под дырку 1
      }
      difference() {
      translate([-70,0,0])prizm_side(3, ts2, h, r, 20); // боковая стенка
      translate([-64,-100,-52]) rotate([0,0,90]) cube([237,4,5],false);
      translate([-63,-92,-87.5]) rotate([0,0,90])  cube([230,4,2.5],false);
      translate([-64,18,-51.5])   rotate([0,6.8,90])  cube([126.7,4,5],false);//фаска на клаву на боковой стенке  
      }
      difference() {
       translate([-70,-86,-87.5]) cube([155,6,40],false);// задняя стенка
       translate([-70,-83,-52]) rotate([0,0,0]) cube([155,6,5],false); // фаска под крышку
       translate([-70,-83,-87.5]) rotate([0,0,0]) cube([145,4,2.5],false); // фаска под крышку снизу
       translate([-10,-78,-71]) rotate([90,0,00]) cube([56,12,6.5],false);
  //translate([-15,-85,-66]) rotate([90,0,00])#cylinder($fn = 0, h = 15, r1 = 1, r2 = 1, center = false);
  //translate([48,-85,-66]) rotate([90,0,00])#cylinder($fn = 0, h = 15, r1 = 1, r2 = 1, center = false);
       //translate([60,-86.5,-59]) rotate([90,180,0])cube([9,14,6.5],false);// выключатель
       translate([-45,-78.5,-66]) rotate([90,180,0]) cylinder($fn = 0, h = 7, r1 = 8, r2 = 7.8, center = false); //питание  
       translate([169/2,-78,-63]) rotate([90,180,0]) cube([9,14,3],false);// вставка для скрепления
      }
  }
  // translate([-0.5,5,34]) cube([237,6.5,6],false);
 }
 
 module levy_chast()
intersection()
{
  translate([0,50,h2/2])
  {
    hull()
    {  
      translate([0,-h/2+55.5,0]) cube([w,111,h2],true); // уберем треугольник оставим санки # - подсветка   
      translate([0,h/2-1,-10])cube([w,2,h2-20],true); // уберем треугольник оставим санки # - подсветка   
    }
  }
    
  translate([0,0,z]) //rotate([0,0,0]) 
  union()
  {  
      difference() { 
       prizm_box(3, w, h, r, t);
       translate([-74,130,-65]) cube([146,6,6],false); //фаска под клаву передняя   
       translate([-68,-80,-87.5]) cube([140,100,6],false); //дыра внизу 1
       translate([-68,37,-87.5]) cube([140,100,6],false);  //дыра внизу 2
       translate([-70,-82,-87.5]) cube([142,105,2.5],false); //фаска под дырку 1
       translate([-70,33,-87.5])  cube([142,105,2.5],false); //фаска под дырку 2
       //translate([-70,-80,-92.5])  #cube([142,4,2.5],false); // фаска 
        //translate([-74,-82,-89]) #cube([4,220,2],false); //фаска под дырку 1
      }
      difference() 
      {
        translate([w/2-ts/2,0,0])prizm_side(3, ts, h, r, 20); // боковая стенка
          translate([72,-82,-87.5]) rotate([0,0,90]) cube([105,4,2.5],false);//фаска снизу на боковой стенке
       translate([72,-100,-51.5]) rotate([0,0,90]) cube([237,4,5],false);//фаска сверху на боковой стенке
       translate([72,18,-51.5]) rotate([0,6.8,90]) cube([126.7,4,5],false);//фаска на клаву на боковой стенке  
        translate([72,33.1,-87.7]) rotate([0,0,90])  cube([105,4,2.5],false);
      }
      difference() {
       translate([-w/2,-86,-87.5])cube([147,6,40],false);// задняя стенка
       translate([-70,-83,-87.5]) rotate([0,0,0]) cube([146,4,3],false); // фаска под крышку снизу
       translate([-74,-83,-52]) rotate([0,0,0]) cube([146,4,5],false); // фаска под крышку
       translate([60,-79,-59]) rotate([90,180,0])cube([9,14,6.5],false);// выключатель
       translate([25,-78.5,-66]) rotate([90,180,0]) cylinder($fn = 0, h = 7, r1 = 8, r2 = 7.8, center = false); //питание  
       translate([-65,-78.5,-63]) rotate([90,180,0])cube([9,14,3],false);// выключатель
      }
  }
  // translate([-0.5,5,34]) cube([237,6.5,6],false);
 }
 
 module stoyka(x,y)
{
    translate([x,y,32.5])
 difference() {
 cylinder($fn = 0, h = 7, r1 = 3.5, r2 = 3.5, center = false);
 cylinder($fn = 0, h = 7.5, r1 = 1, r2 = 1, center = false);   
    
}
}
 
 module top_case()
 {
      difference() {
          
     cube([297,103,2],false);
     translate([10,5,-0.5])cube([135,95,2],false);
     translate([156,5,-0.5])cube([135,95,2],false);
     for (i=[140:6:200])
     translate([i-120,12,-0.5])rotate([00,00,70])cube([40,3,8],false);
    }


    translate([0,4.5,-2.9])   cube([5,98,3],false);
    translate([150,4.5,-2.9]) cube([5,98,3],false);
    translate([292,4.5,-2.9]) cube([5,98,3],false);
    translate([0,0,-2.9]) cube([297,4.5,3],false);   
 }
 
 
 
  //levy_chast();
  //translate([-225.5,22,36] ) rotate([-7,0,0])kr04plate();
  //translate([-158,0,0]) pravy_chast();
 translate([-225.5,-82,38] )top_case();
 stoyka(-37,-67);
 stoyka(44,-67);
    
   stoyka(-37,10);
   stoyka(44,10);
  stoyka(-9,8);
  stoyka(-9,-63);
 //translate([-40,-70,38] )cube([89,82,2],false);
 
 
 