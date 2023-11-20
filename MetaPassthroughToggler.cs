using StereoKit;
using StereoKit.Framework;


/// <summary>
///     This combines the FB Passthrough with a UI window to toggle it on and off
///     It needs to be called before StereoKit is initialized
/// </summary>
public class MetaPassthroughToggler
{
    private readonly PassthroughFBExt _passthrough = null;
    private Pose _passthroughWindowPose = new(0.4f, 0.1f, -0.4f, Quat.LookDir(-1, 0, 1));


    public MetaPassthroughToggler()
    {
        _passthrough = SK.GetOrCreateStepper<PassthroughFBExt>();
    }


    /// <summary>
    ///     Call this on every frame you want to see it
    /// </summary>
    public void DrawPassthroughTogglerUI()
    {
        UI.WindowBegin("Passthrough Settings", ref _passthroughWindowPose);
        var toggle = _passthrough.Enabled;

        if (!_passthrough.Available)
        {
            UI.Label("No passthrough available :(");
            UI.Label("Did you set it before initializing StereoKit?");
        }

        UI.PushEnabled(_passthrough.Available);

        if (UI.Toggle("Passthrough", ref toggle))
        {
            _passthrough.Enabled = toggle;
        }

        UI.PopEnabled();
        UI.WindowEnd();
    }
}