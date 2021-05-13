public class Screen {
	private void resetColors() {
		System.out.print(BackgroundColor.DEFAULT.colorCode());
		System.out.print(FontColor.DEFAULT.colorCode());
	}

	public void displayOnScreen(Display d) {
		System.out.print(d.display());
		this.resetColors();
		System.out.println("");
	}
}
