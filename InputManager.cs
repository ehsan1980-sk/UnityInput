using UnityEngine;
using System.Runtime.InteropServices;

public enum MouseButton {Left, Right};

public class InputManager : MonoBehaviour {
    
	public GameObject inputDelegate;

	[DllImport ("__Internal")]
	private static extern void inputEnable ();

	[DllImport ("__Internal")]
	private static extern void inputDisable ();

	[DllImport ("__Internal")]
	private static extern bool inputIsMouseCursorHidden ();

	[DllImport ("__Internal")]
	private static extern void inputSetMouseCursorHidden (bool value);

	[DllImport ("__Internal")]
	private static extern System.IntPtr inputMousePosition ();

	[DllImport ("__Internal")]
	private static extern void inputSetMousePosition (string point);

	[DllImport ("__Internal")]
	private static extern bool inputIsKeyPressed (string key);

	[DllImport ("__Internal")]
	private static extern bool inputIsMouseButtonPressed (int button);

	private static Vector2 StringToVector2(string str) {
		string[] values = str.Split (',');
		float x = float.Parse (values [0]);
		float y = float.Parse (values [1]);
		return new Vector2(x, y);
	}

	// Public methods
	public static void Enable() {
		inputEnable ();
	}

	public static void Disable() {
		inputDisable ();
	}

	public static bool IsMouseCursorHidden {
		get {
			return inputIsMouseCursorHidden ();
		}
		set {
			inputSetMouseCursorHidden (value);
		}
	}

	public static Vector2 MousePosition {
		get {
			return StringToVector2(Marshal.PtrToStringAnsi (inputMousePosition ()));
		}
		set {
			inputSetMousePosition (string.Format ("{0},{1}", value.x, value.y));
		}
	}

	public static bool IsKeyPressed(string key) {
		return inputIsKeyPressed (key);
	}

	public static bool IsMouseButtonPressed(MouseButton button) {
		switch (button) {
		case MouseButton.Left:
			return inputIsMouseButtonPressed (0);
		case MouseButton.Right:
			return inputIsMouseButtonPressed (1);
		}
		return false;
	}

	// Private delegate methods
	private void didPressMouseButton(string btn) {
		inputDelegate.SendMessage ("InputDidPressMouseButton", int.Parse (btn));
	}

	private void didReleaseMouseButton(string btn) {
		inputDelegate.SendMessage ("InputDidReleaseMouseButton", int.Parse (btn));
	}

	private void didMoveMouse(string offset) {
		inputDelegate.SendMessage ("InputDidMoveMouse", StringToVector2(offset));
	}

	private void didPressKeyboardKey(string key) {
		inputDelegate.SendMessage ("InputDidPressKeyboardKey", key);
	}

	private void didReleaseKeyboardKey(string key) {
		inputDelegate.SendMessage ("InputDidReleaseKeyboardKey", key);
	}
}