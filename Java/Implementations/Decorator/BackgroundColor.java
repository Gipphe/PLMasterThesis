public class BackgroundColor implements Color {
	private BaseColor color;

	public BackgroundColor(BaseColor color) {
		this.color = color;
	}

	private String cc() {
		switch (this.color) {
			case BLACK:     return "40";
			case RED:       return "41";
			case GREEN:     return "42";
			case YELLOW:    return "43";
			case BLUE:      return "44";
			case PURPLE:    return "45";
			case LIGHTBLUE: return "46";
			case WHITE:     return "47";
			default:   return "40";
		}
	}

	public String colorCode() {
		return "\u001b[" + this.cc() + "m";
	}

	public static Color DEFAULT = new BackgroundColor(BaseColor.BLACK);
}
