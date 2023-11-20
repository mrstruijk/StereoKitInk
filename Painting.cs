using System;
using System.Collections.Generic;
using System.Linq;
using StereoKit;


internal class Painting
{
    private Pose _pose = new(0, 0, -0.8f, Quat.Identity);
    private readonly List<LinePoint> _activeStroke = new();
    private List<LinePoint[]> _strokeList = new();
    private readonly Stack<LinePoint[]> _undoStack = new();

    private Vec3 _prevFingertip;
    private bool _isDrawing;


    public void Step(Handed handed, Color color, float thickness)
    {
        // We'll make the whole painting the child of a handle, so we can
        // move the painting around while we work with it! Handles and 
        // Windows both push a transform onto the Hierarchy stack, so all 
        // subsequent locations are then relative to that transform.
        UI.HandleBegin("PaintingRoot", ref _pose, new Bounds(Vec3.One * 5 * U.cm), true);

        UpdateInput(handed, color, thickness);
        Draw();

        UI.HandleEnd();
    }


    public void Undo()
    {
        // No undo if there's nothing in the painting
        if (_strokeList.Count == 0)
        {
            return;
        }

        // Push the last stroke into the undo stack, and remove from the
        // painting!
        _undoStack.Push(_strokeList.Last());
        _strokeList.RemoveAt(_strokeList.Count - 1);
    }


    public void Redo()
    {
        // Nothing to redo? No redo!
        if (_undoStack.Count == 0)
        {
            return;
        }

        // Pop the most recent Undo off the stack, and add it to the painting.
        _strokeList.Add(_undoStack.Pop());
    }


    private void UpdateInput(Handed handed, Color color, float thickness)
    {
        // Get the hand's fingertip, convert it to local space, and smooth
        // it out to reduce any jagged noise! The hand's location data is
        // always provided in world space, but since we're inside of an
        // Affordance which uses the Hierarchy stack, we need to convert the
        // fingertip's coordinates into Heirarchy local coordinates before we
        // can work with it.
        var hand = Input.Hand(handed);
        var fingertip = hand[FingerId.Index, JointId.Tip].position;
        fingertip = Hierarchy.ToLocal(fingertip);
        fingertip = Vec3.Lerp(_prevFingertip, fingertip, 0.3f);

        // If the user just made a pinching motion, and is not interacting
        // with the UI, we'll begin a paint stroke!
        if (hand.IsJustPinched && !UI.IsInteracting(handed))
        {
            BeginStroke(fingertip, color, thickness);
            _isDrawing = true;
        }

        // If we're drawing a paint stroke, then lets update it with the
        // current steps information!
        if (_isDrawing)
        {
            UpdateStroke(fingertip, color, thickness);
        }

        // And when they cease the pinching motion, we'll end whatever stroke
        // we started.
        if (_isDrawing && hand.IsJustUnpinched)
        {
            EndStroke();
            _isDrawing = false;
        }

        _prevFingertip = fingertip;
    }


    private void Draw()
    {
        // Draw the unfinished stroke the user may be drawing
        Lines.Add(_activeStroke.ToArray());

        // Then draw all the other strokes that are part of the painting!
        for (var i = 0; i < _strokeList.Count; i++)
        {
            Lines.Add(_strokeList[i]);
        }
    }


    private void BeginStroke(Vec3 at, Color32 color, float thickness)
    {
        // Start with two points! The first one begins at the point provided,
        // and the second one will always be updated to the current fingertip
        // location. We add new points once we reach a certain distance from 
        // the last point, but a naive implementation of this can result in
        // a popping effect when points are simply added at distance 
        // intervals. The extra point that directly follows the fingertip
        // will nicely prevent this 'popping' artifact!
        _activeStroke.Add(new LinePoint(at, color, thickness));
        _activeStroke.Add(new LinePoint(at, color, thickness));
        _prevFingertip = at;
    }


    private void UpdateStroke(Vec3 at, Color32 color, float thickness)
    {
        // Calculate the current distance from the last point, as well as the
        // speed at which the hand is traveling.
        var prevLinePoint = _activeStroke[^2].pt;
        var dist = Vec3.Distance(prevLinePoint, at);
        var speed = Vec3.Distance(at, _prevFingertip) / Time.Stepf;

        // Create a point at the current location, using speed as the
        // thickness of the stroke!
        var here = new LinePoint(at, color, Math.Max(1 - speed * 0.5f, 0.1f) * thickness);

        // If we're more than a centimeter away from our last point, we'll
        // add a new point! This is simple, but effective enough. A higher
        // quality implementation might use an error/change function that
        // also factors into account the change in angle.
        // Otherwise, the last point in the stroke should always be at the
        // current fingertip location to prevent 'popping' when adding a new
        // point.
        if (dist > 1 * U.cm)
        {
            _activeStroke.Add(here);
        }
        else
        {
            _activeStroke[^1] = here;
        }
    }


    private void EndStroke()
    {
        // Add the active stroke to the painting, and clear it out for the
        // next one!
        _strokeList.Add(_activeStroke.ToArray());
        _activeStroke.Clear();
    }


    #region File Load and Save

    public static Painting FromFile(string fileData)
    {
        // Here we're using Linq to parse a file! Linq is a Functional way of 
        // writing code that can be pretty great once you get used to it.
        // Linq should probably not be used in performance critical sections,
        // but it's acceptable enough for discrete events.
        //
        // In this file, each line is a paint stroke, and each point on that
        // stroke is separated by a comma. Each item within a point is
        // separated by spaces, which is taken care of in LinePointFromString.
        //
        // Example of a two stroke painting, two points in the first stroke 
        // (white), and three points in the second stroke (red):
        // 0 0 0 255 255 255 0.01, 0.1 0 0 255 255 255 0.01
        // 0 0.1 0 255 0 0 0.02, 0.1 0.1 0 255 0 0 0.02, 0.2 0 0 255 0 0 0.02
        var result = new Painting();

        result._strokeList = fileData
                             .Split('\n')
                             .Select(textLine => textLine
                                                 .Split(',')
                                                 .Select(LinePointFromString)
                                                 .ToArray())
                             .ToList();

        return result;
    }


    public string ToFileData()
    {
        // To convert this painting to a file is pretty simple! We have
        // LinePointToString which we can use for each point, and then we
        // just have to join all the data together. Each paint stroke goes on
        // its own line using '\n', and each point on that stroke separated
        // with a comma.
        //
        // Example of a two stroke painting, two points in the first stroke
        // (white), and three points in the second stroke (red):
        // 0 0 0 255 255 255 0.01, 0.1 0 0 255 255 255 0.01
        // 0 0.1 0 255 0 0 0.02, 0.1 0.1 0 255 0 0 0.02, 0.2 0 0 255 0 0 0.02
        return string.Join('\n', _strokeList
            .Select(line => string.Join(',', line
                .Select(LinePointToString))));
    }


    private static string LinePointToString(LinePoint point)
    {
        return $"{point.pt.x} {point.pt.y} {point.pt.z} {point.color.r} {point.color.g} {point.color.b} {point.thickness}";
    }


    private static LinePoint LinePointFromString(string point)
    {
        var values = point.Split(' ');
        var result = new LinePoint();
        result.pt.x = float.Parse(values[0]);
        result.pt.y = float.Parse(values[1]);
        result.pt.z = float.Parse(values[2]);
        result.color.r = byte.Parse(values[3]);
        result.color.g = byte.Parse(values[4]);
        result.color.b = byte.Parse(values[5]);
        result.color.a = 255;
        result.thickness = float.Parse(values[6]);

        return result;
    }

    #endregion
}