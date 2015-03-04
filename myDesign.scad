/*Bilal Mawji
Section A07
bmawji3@gatech.edu
I worked on this assignment by myself using only
this course's resources as guides.*/

/*Please note, when I press F5, it shows the middle portion of the trophy (the two cylinders and the hull'ed circles). When I press F6, they disappear and don't show.*/

/*This object is a trophy for the 1st place winner of a ninja competition.*/

/*I originally wanted to make some pyramids (which make up the ninja star), but I lated added in multiple different objects and shaped it into a trophy.*/

/*It is made up of a base that a minkowski between a cube and a cylinder. I also added some rounded cylinders on the bottom to give it some fashion. The rounded cylinders are made up of cylinders, spheres and cubes. To make it able to stand properly on a base, the spheres are differenced from the cubes so that it's flat on the bottom, but still has a curved look. The spheres are unioned to the cylinders which are unioned to the minkowski base. The minkowski base also has some tiled cubes on the long sides to add some fasion to it. I used a for loop and if statement to space them out properly.*/

/*Above the base are two cylinders that support the next level. The level above the cylinders are hulls of two circles. I used a forr loop to iterate through and create the hulls of cirlces on top of the other with smaller radii.*/

/*Above this is a cube that holds the ninja star. The ninja star is one pyramid that was rotated on the z-axis, and the y-axis to create the shape it is. There is also a sphere attached to the top of each pyramid, with exception to the left and right sides which have two because of the way they were rotated.*/

/*Finally, there is an intersection of a cube and a cylinder (made into a cone) that forms the base for the number 1. The "1" is made up of cubes that are translated and rotated to form the correct shape.*/


module baseTrophy(){
//forms rounded base above rounded cylinders
minkowski()
{
	cube([40, 20, 2], center = true);
	cylinder(r=2, h=1);
}

//forms base for "1" to stand on
translate([0,0,28])
intersection(){
	cube([8,8,8], center = true);
		cylinder(r1 = 5, r2 = 0, h = 8);
}

//forms "1" with cubes -- rotated and translated
union(){
	translate([0,0,32]){
		cube([4,1,1], center = true);
		cube([1,1,10], center = true);
	}

	translate([-1,0,36]){
		rotate([0,-45,0])
			cube([3,1,1], center = true);
	}	
}

//Creates 2 cylinders to support hull'ed pyramid
//Also creates pyramid of hull'ed circles. 
//They decrease in radius and go upwards
//This portion of the code doesn't work with F6
union(){
	for(i = [0:9])
	{
		translate([0,0,10+i])
		hull() {
			translate([13, 0, 0])
				circle(10-i);
			translate([-13, 0, 0])
				circle(10-i);
		}
	}

	translate([-15,0,0])
		cylinder(r=5, h=10, $fn=30);
	translate([15,0,0])
		cylinder(r=5, h=10, $fn=30);
}

//Sets variables to specific instances. 
dx1 = 19;
dy1 = 9;
dz1 = 11;

//Translates and unions cylinder with differenced sphere & cube. 
//This looks like a cylinder that is joined with a sphere and the sphere is cut off at the end. This is done 4 times, so with variables, if I change one instance, I can change the others just as easily.
union()
{
	translate([-dx1,-dy1,-dz1])
		cylinder(r =3, h=10, $fn=30);
	difference(){
		translate([-dx1,-dy1,-dz1])
			sphere(r = 3, $fn = 30);
		translate([-dx1,-dy1,-(dz1+7.8)])
			cube([10,10,10], center = true);
	}

}

union()
{
	translate([dx1,-dy1,-dz1])
		cylinder(r =3, h=10, $fn=30);
	difference(){
		translate([dx1,-dy1,-dz1])
			sphere(r = 3, $fn = 30);
		translate([dx1,-dy1,-(dz1+7.8)])
			cube([10,10,10], center = true);
	}

}

union()
{
	translate([dx1,dy1,-dz1])
		cylinder(r =3, h=10, $fn=30);
	difference(){
		translate([dx1,dy1,-dz1])
			sphere(r = 3, $fn = 30);
		translate([dx1,dy1,-(dz1+7.8)])
			cube([10,10,10], center = true);
	}

}

union()
{
	translate([-dx1,dy1,-dz1])
		cylinder(r =3, h=10, $fn=30);
	difference(){
		translate([-dx1,dy1,-dz1])
			sphere(r = 3, $fn = 30);
		translate([-dx1,dy1,-(dz1+7.8)])
			cube([10,10,10], center = true);
	}

}

//Forms tiled cubes on long edge of first base. Uses if statement to separate it and make it look spaced. 
for (qq = [0:36])
if (qq % 3 == 0)
	translate([-18+qq,-12,.5])
		cube([2,.5,2.5], center = true);

for (ww = [0:36])
if (ww % 3 == 0)
	translate([-18+ww,12,.5])
		cube([2,.5,2.5], center = true);
}

//Creates pyramid that is made up of cubes and constantly goes upwards with size decreasing each time. Has a circle attached to end (top) of pyramid. 
module pyramid(){
cube([10,10,1], center = true);
translate([0,0,1])
	cube([9,9,1], center = true);
translate([0,0,2])
	cube([8,8,1], center = true);
translate([0,0,3])
	cube([7,7,1], center = true);
translate([0,0,4])
	cube([6,6,1], center = true);
translate([0,0,5])
	cube([5,5,1], center = true);
translate([0,0,6])
	cube([4,4,1], center = true);
translate([0,0,7])
	cube([3,3,1], center = true);
translate([0,0,8])
	cube([2,2,1], center = true);
translate([0,0,9])
	cube([1,1,1], center = true);
translate([0,0,10])
	sphere(1, $fn=30);
}

//Translates and creates pyramid. Also mirrors it on z-axis. 
module pyramid2(){
translate([0,0,5])
	pyramid();
translate([0,0,-5])
	mirror([0,0,1])
		pyramid();
}

//Calls pyramid2 and rotates it on z-axis. Rotates on y-axis and z-axis again to form cool looking ninja star. 
module ninjaStar(){
pyramid2();
rotate([0,0,10])
	pyramid2();
rotate([0,90,0])
	pyramid2();
rotate([0,90,10])
	pyramid2();
}

//Combines baseTrophy (bottom) with ninjaStar (top) to form finalTrophy.
module finalTrophy()
{
	union(){
		translate([0,0,20])
			cube([2,2,2], center = true);
		baseTrophy();
		translate([0,0,35])
			ninjaStar();
	}
}

//Calls finalTrophy to create and display design. 
finalTrophy();
