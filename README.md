## Transforms
### Viewing and modeling
In an application, we have a rectangle compose of pixels, we will call this rectangle **Viewport**. We also have some objects that make up the "scene" or "world" that we want to view, the coordinates that we use to define the scene are called **World Coordinates**. For 2D graphics the world lies in a plane. As we are not able to show a picture of the entire infinite plane we should pick some rectangular area in the plane to display in the image.

![Image graphic](https://github.com/IsraelR1099/pdf/blob/master/images/graphic.png)

In our case, we want to transform the viewport to world coordinates so we will use the following formula:

```
T(x, y) = ((8 * x_pixel / width) - 4, 3 - (6 * y_pixel / height))
```

Where `x_pixel` and `y_pixel` are the coordinates of the pixel in the viewport, `width` and `height` are the dimensions of the viewport and `T(x, y)` are the world coordinates.
