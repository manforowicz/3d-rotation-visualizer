# 3d-rotation-visualizer
Visualize orientation data over time in 3D.

## How to run

1. Clone this repository with `git clone https://github.com/manforowicz/3d-rotation-visualizer.git`.
2. Download, unzip, and run the [Godot game engine](https://godotengine.org/download/).
3. From Godot, import and open `project.godot`.
4. Click the triangle in the top right to run the program.
6. Click `Load CSV` and select the orientation data.
7. Right click drag on the screen to change the view.
8. Use the controls to play the data.

## Orientation Data Format

The orientation data must be in the following CSV format:
- Starts with a title row which is ignored.
- Each following row contains (comma separated):
  - The current time in seconds (decimal).
  - 4 comma separated quaternion decimal values, representing the current orientation.
- The times must be strictly increasing

Form:

```csv
{ANY TITLE ROW. WILL BE IGNORED}
{decimal time in seconds},{q1},{q2},{q3},{q4}
{decimal time in seconds},{q1},{q2},{q3},{q4}
{decimal time in seconds},{q1},{q2},{q3},{q4}
...
```
