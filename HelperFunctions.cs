using StereoKit;


public static class HelperFunctions
{
    /// <summary>
    ///     Returns true if the operating system is Meta Quest
    ///     Checks for "Quest" or "Oculus" or "Meta" in the device name
    /// </summary>
    /// <returns></returns>
    public static bool IsRunningOnQuest()
    {
        return Device.Name.Contains("Quest") || Device.Name.Contains("Oculus") || Device.Name.Contains("Meta");
    }
}