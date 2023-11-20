using System;
using System.Runtime.InteropServices;


namespace StereoKit.Framework
{
    internal class PassthroughFBExt : IStepper
    {
        private bool _enabled;
        private readonly bool _enableOnInitialize;
        private XrPassthroughFB _activePassthrough = new();
        private XrPassthroughLayerFB _activeLayer = new();

        private Color _oldColor;
        private bool _oldSky;


        public PassthroughFBExt(bool enabled = true)
        {
            if (SK.IsInitialized)
            {
                Log.Err("PassthroughFBExt must be constructed before StereoKit is initialized!");
            }

            Backend.OpenXR.RequestExt("XR_FB_passthrough");
            _enableOnInitialize = enabled;
        }


        public bool Available { get; private set; }

        public bool Enabled
        {
            get => _enabled;
            set
            {
                if (Available == false || _enabled == value)
                {
                    return;
                }

                if (value)
                {
                    _enabled = StartPassthrough();
                }
                else
                {
                    PausePassthrough();
                    _enabled = false;
                }
            }
        }


        public bool Initialize()
        {
            Available =
                Backend.XRType == BackendXRType.OpenXR &&
                Backend.OpenXR.ExtEnabled("XR_FB_passthrough") &&
                LoadBindings() &&
                InitPassthrough();

            if (_enableOnInitialize)
            {
                Enabled = true;
            }

            return true;
        }


        public void Step()
        {
            if (Enabled == false)
            {
                return;
            }

            var layer = new XrCompositionLayerPassthroughFB(
                XrCompositionLayerFlags.BlendTextureSourceAlphaBit, _activeLayer);

            Backend.OpenXR.AddCompositionLayer(layer, -1);
        }


        public void Shutdown()
        {
            if (!Enabled)
            {
                return;
            }

            Enabled = false;
            DestroyPassthrough();
        }


        private bool InitPassthrough()
        {
            var result = _xrCreatePassthroughFB(
                Backend.OpenXR.Session,
                new XrPassthroughCreateInfoFB(XrPassthroughFlagsFB.None),
                out _activePassthrough);

            if (result != XrResult.Success)
            {
                Log.Err($"xrCreatePassthroughFB failed: {result}");

                return false;
            }

            result = _xrCreatePassthroughLayerFB(
                Backend.OpenXR.Session,
                new XrPassthroughLayerCreateInfoFB(_activePassthrough, XrPassthroughFlagsFB.None, XrPassthroughLayerPurposeFB.ReconstructionFB),
                out _activeLayer);

            if (result != XrResult.Success)
            {
                Log.Err($"xrCreatePassthroughLayerFB failed: {result}");

                return false;
            }

            return true;
        }


        private void DestroyPassthrough()
        {
            _xrDestroyPassthroughLayerFB(_activeLayer);
            _xrDestroyPassthroughFB(_activePassthrough);
        }


        private bool StartPassthrough()
        {
            var result = _xrPassthroughStartFB(_activePassthrough);

            if (result != XrResult.Success)
            {
                Log.Err($"xrPassthroughStartFB failed: {result}");

                return false;
            }

            result = _xrPassthroughLayerResumeFB(_activeLayer);

            if (result != XrResult.Success)
            {
                Log.Err($"xrPassthroughLayerResumeFB failed: {result}");

                return false;
            }

            _oldColor = Renderer.ClearColor;
            _oldSky = Renderer.EnableSky;
            Renderer.ClearColor = Color.BlackTransparent;
            Renderer.EnableSky = false;

            return true;
        }


        private void PausePassthrough()
        {
            _xrPassthroughPauseFB(_activePassthrough);

            Renderer.ClearColor = _oldColor;
            Renderer.EnableSky = _oldSky;
        }


        #region OpenXR native bindings and types

        private enum XrStructureType : ulong
        {
            XrTypePassthroughCreateInfoFB = 1000118001,
            XrTypePassthroughLayerCreateInfoFB = 1000118002,
            XrTypePassthroughStyleFB = 1000118020,
            XrTypeCompositionLayerPassthroughFB = 1000118003
        }


        private enum XrPassthroughFlagsFB : ulong
        {
            None = 0,
            IsRunningAtCreationBitFB = 0x00000001,
            LayerDepthBitFB = 0x00000002
        }


        private enum XrCompositionLayerFlags : ulong
        {
            None = 0,
            CorrectChromaticAberrationBit = 0x00000001,
            BlendTextureSourceAlphaBit = 0x00000002,
            UnpremultipliedAlphaBit = 0x00000004
        }


        private enum XrPassthroughLayerPurposeFB : uint
        {
            ReconstructionFB = 0,
            ProjectedFB = 1,
            TrackedKeyboardHandsFB = 1000203001,
            MaxEnumFB = 0x7FFFFFFF
        }


        private enum XrResult
        {
            Success = 0
        }


        #pragma warning disable 0169 // handle is not "used", but required for interop
        private struct XrPassthroughFB
        {
            private ulong _handle;
        }


        private struct XrPassthroughLayerFB
        {
            private ulong _handle;
        }
        #pragma warning restore 0169


        [StructLayout(LayoutKind.Sequential)]
        private struct XrPassthroughCreateInfoFB
        {
            private XrStructureType type;
            public IntPtr next;
            public XrPassthroughFlagsFB flags;


            public XrPassthroughCreateInfoFB(XrPassthroughFlagsFB passthroughFlags)
            {
                type = XrStructureType.XrTypePassthroughCreateInfoFB;
                next = IntPtr.Zero;
                flags = passthroughFlags;
            }
        }


        [StructLayout(LayoutKind.Sequential)]
        private struct XrPassthroughLayerCreateInfoFB
        {
            private XrStructureType type;
            public IntPtr next;
            public XrPassthroughFB passthrough;
            public XrPassthroughFlagsFB flags;
            public XrPassthroughLayerPurposeFB purpose;


            public XrPassthroughLayerCreateInfoFB(XrPassthroughFB passthrough, XrPassthroughFlagsFB flags, XrPassthroughLayerPurposeFB purpose)
            {
                type = XrStructureType.XrTypePassthroughLayerCreateInfoFB;
                next = IntPtr.Zero;
                this.passthrough = passthrough;
                this.flags = flags;
                this.purpose = purpose;
            }
        }


        [StructLayout(LayoutKind.Sequential)]
        private struct XrPassthroughStyleFB
        {
            public XrStructureType type;
            public IntPtr next;
            public float textureOpacityFactor;
            public Color edgeColor;


            public XrPassthroughStyleFB(float textureOpacityFactor, Color edgeColor)
            {
                type = XrStructureType.XrTypePassthroughStyleFB;
                next = IntPtr.Zero;
                this.textureOpacityFactor = textureOpacityFactor;
                this.edgeColor = edgeColor;
            }
        }


        [StructLayout(LayoutKind.Sequential)]
        private struct XrCompositionLayerPassthroughFB
        {
            public XrStructureType type;
            public IntPtr next;
            public XrCompositionLayerFlags flags;
            public ulong space;
            public XrPassthroughLayerFB layerHandle;


            public XrCompositionLayerPassthroughFB(XrCompositionLayerFlags flags, XrPassthroughLayerFB layerHandle)
            {
                type = XrStructureType.XrTypeCompositionLayerPassthroughFB;
                next = IntPtr.Zero;
                space = 0;
                this.flags = flags;
                this.layerHandle = layerHandle;
            }
        }


        private delegate XrResult DelXrCreatePassthroughFB(ulong session, [In] XrPassthroughCreateInfoFB createInfo, out XrPassthroughFB outPassthrough);

        private delegate XrResult DelXrDestroyPassthroughFB(XrPassthroughFB passthrough);

        private delegate XrResult DelXrPassthroughStartFB(XrPassthroughFB passthrough);

        private delegate XrResult DelXrPassthroughPauseFB(XrPassthroughFB passthrough);

        private delegate XrResult DelXrCreatePassthroughLayerFB(ulong session, [In] XrPassthroughLayerCreateInfoFB createInfo, out XrPassthroughLayerFB outLayer);

        private delegate XrResult DelXrDestroyPassthroughLayerFB(XrPassthroughLayerFB layer);

        private delegate XrResult DelXrPassthroughLayerPauseFB(XrPassthroughLayerFB layer);

        private delegate XrResult DelXrPassthroughLayerResumeFB(XrPassthroughLayerFB layer);

        private delegate XrResult DelXrPassthroughLayerSetStyleFB(XrPassthroughLayerFB layer, [In] XrPassthroughStyleFB style);

        private DelXrCreatePassthroughFB _xrCreatePassthroughFB;
        private DelXrDestroyPassthroughFB _xrDestroyPassthroughFB;
        private DelXrPassthroughStartFB _xrPassthroughStartFB;
        private DelXrPassthroughPauseFB _xrPassthroughPauseFB;
        private DelXrCreatePassthroughLayerFB _xrCreatePassthroughLayerFB;
        private DelXrDestroyPassthroughLayerFB _xrDestroyPassthroughLayerFB;
        private DelXrPassthroughLayerPauseFB _xrPassthroughLayerPauseFB;
        private DelXrPassthroughLayerResumeFB _xrPassthroughLayerResumeFB;
        private DelXrPassthroughLayerSetStyleFB _xrPassthroughLayerSetStyleFB;


        private bool LoadBindings()
        {
            _xrCreatePassthroughFB = Backend.OpenXR.GetFunction<DelXrCreatePassthroughFB>("xrCreatePassthroughFB");
            _xrDestroyPassthroughFB = Backend.OpenXR.GetFunction<DelXrDestroyPassthroughFB>("xrDestroyPassthroughFB");
            _xrPassthroughStartFB = Backend.OpenXR.GetFunction<DelXrPassthroughStartFB>("xrPassthroughStartFB");
            _xrPassthroughPauseFB = Backend.OpenXR.GetFunction<DelXrPassthroughPauseFB>("xrPassthroughPauseFB");
            _xrCreatePassthroughLayerFB = Backend.OpenXR.GetFunction<DelXrCreatePassthroughLayerFB>("xrCreatePassthroughLayerFB");
            _xrDestroyPassthroughLayerFB = Backend.OpenXR.GetFunction<DelXrDestroyPassthroughLayerFB>("xrDestroyPassthroughLayerFB");
            _xrPassthroughLayerPauseFB = Backend.OpenXR.GetFunction<DelXrPassthroughLayerPauseFB>("xrPassthroughLayerPauseFB");
            _xrPassthroughLayerResumeFB = Backend.OpenXR.GetFunction<DelXrPassthroughLayerResumeFB>("xrPassthroughLayerResumeFB");
            _xrPassthroughLayerSetStyleFB = Backend.OpenXR.GetFunction<DelXrPassthroughLayerSetStyleFB>("xrPassthroughLayerSetStyleFB");

            return
                _xrCreatePassthroughFB != null &&
                _xrDestroyPassthroughFB != null &&
                _xrPassthroughStartFB != null &&
                _xrPassthroughPauseFB != null &&
                _xrCreatePassthroughLayerFB != null &&
                _xrDestroyPassthroughLayerFB != null &&
                _xrPassthroughLayerPauseFB != null &&
                _xrPassthroughLayerResumeFB != null &&
                _xrPassthroughLayerSetStyleFB != null;
        }

        #endregion
    }
}