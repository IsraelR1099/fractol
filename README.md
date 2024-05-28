## Clarifications
In my implementation, I will use column-major order to iterate over the loops. This means that the first index will be the column and the second index will be the row. This is the opposite of the row-major order that is used in C.

<img src="https://github.com/IsraelR1099/pdf/blob/master/images/Row_and_column_major_order.png" width="100" height="100">


## Transforms
### Viewing and modeling
In an application, we have a rectangle compose of pixels, we will call this rectangle **Viewport**. We also have some objects that make up the "scene" or "world" that we want to view, the coordinates that we use to define the scene are called **World Coordinates**. For 2D graphics the world lies in a plane. As we are not able to show a picture of the entire infinite plane we should pick some rectangular area in the plane to display in the image.

![Image graphic](https://github.com/IsraelR1099/pdf/blob/master/images/graphic.png)

In our case, we want to transform the viewport to world coordinates so we will use the following formula:

```
T(x, y) = ((8 * x_pixel / height) - 4, 3 - (6 * y_pixel / width))
```

Where `x_pixel` and `y_pixel` are the coordinates of the pixel in the viewport, `width` and `height` are the dimensions of the viewport and `T(x, y)` are the world coordinates.
This is the simplest transformation that we can do, it is a linear transformation. So far, we are not adding any translation or scaling to the transformation. So we could use a simple loop to create our fractal:
```c
int x_pixel;
int y_pixel;

x_pixel = 0;
while (x_pixel < width)
{
	j_pixel = 0;
	while (j_pixel < height)
	{
		x_world = 8 * x_pixel / height - 4;
		y_world = 3 - 6 * y_pixel / width;
		// Do something with x_world and y_world
		j_pixel++;
	}
	x_pixel++;
}
```
