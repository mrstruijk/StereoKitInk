using System;
using StereoKit;
using StereoKit.Framework;


internal static class Program
{
    private static Painting _activePainting = new();
    private static PaletteMenu _paletteMenu;
    private static Pose _menuPose = new(0.4f, 0, -0.4f, Quat.LookDir(-1, 0, 1));
    private static Sprite _appLogo;
    private static MetaPassthroughToggler _passthroughToggler;


    private static void Main(string[] args)
    {
        // Needs to be the first thing that's called, before SK.Initialize
        _passthroughToggler = new MetaPassthroughToggler();
        
        var settings = new SKSettings
        {
            appName = "StereoKit Ink",
            assetsFolder = "Assets"
        };

        if (!SK.Initialize(settings))
        {
            Environment.Exit(1);
        }

        // This is a simple radial hand menu where we'll store some quick
        // actions. It's activated by a grip motion, and is great for fast,
        // gesture-like activation of menu items. It also can be used with
        // multiple HandRadialLayers to nest commands in sub-menus.
        //
        // Steppers are classes that implement the IStepper interface, and
        // once added to StereoKit's stepper list, will have their Step
        // method called each frame. This is a great way to add fire-and-
        // forget objects or systems that need to update each frame.
        SK.AddStepper(new HandMenuRadial(
            new HandRadialLayer("Root", -90,
                new HandMenuItem("Undo", null, () => _activePainting?.Undo()),
                new HandMenuItem("Redo", null, () => _activePainting?.Redo()),
                new HandMenuItem("Quit", null, SK.Quit),
                new HandMenuItem("Clear", null, () => _activePainting = new Painting())
            )));


        _paletteMenu = new PaletteMenu();

        _appLogo = Sprite.FromFile("StereoKitInkLight.png");

        // The callback code here is called every frame after input and
        // system events, but before the draw events.
        SK.Run(() =>
        {
            _passthroughToggler.DrawPassthroughTogglerUI();

            _activePainting.Step(Handed.Right, _paletteMenu.PaintColor, _paletteMenu.PaintSize);

            _paletteMenu.Step();

            StepMenuWindow();
        });
    }


    private static void StepMenuWindow()
    {
        // Begin the application's menu window, we'll draw this without a
        // head bar (Body only) since we have a nice application image we can
        // add instead.
        UI.WindowBegin("Menu", ref _menuPose, UIWin.Body);

        // Just draw the application logo across the top of the Menu window.
        // Vec2.Zero here tells StereoKit to auto-size both axes, so this
        // will automatically expand to the width of the window.
        UI.Image(_appLogo, V.XY(UI.LayoutRemaining.x, 0));

        if (HelperFunctions.IsRunningOnQuest())
        {
            UI.Label("Quest doesn't support Save/Load");
        }
        else
        {
            UI.Label(Device.Name);

            if (UI.Button("Save"))
            {
                Platform.FilePicker(PickerMode.Save, SavePainting, null, ".skp");
            }

            UI.SameLine();

            if (UI.Button("Load"))
            {
                Platform.FilePicker(PickerMode.Open, LoadPainting, null, ".skp");
            }
        }

        UI.HSeparator();

        // Clear is easy. Just create a new Painting object.
        if (UI.Button("Clear"))
        {
            _activePainting = new Painting();
        }

        UI.SameLine();

        if (UI.Button("Quit"))
        {
            SK.Quit();
        }

        UI.WindowEnd();
    }


    private static void LoadPainting(string file)
    {
        _activePainting = Painting.FromFile(Platform.ReadFileText(file) ?? "");
    }


    private static void SavePainting(string file)
    {
        Platform.WriteFile(file, _activePainting.ToFileData());
    }
}