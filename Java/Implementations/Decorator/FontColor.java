public class FontColor implements Color {
	private BaseColor color;

	public FontColor(BaseColor color) {
		this.color = color;
	}

	private String cc() {
		switch (this.color) {
			case BLACK:     return "30";
			case RED:       return "31";
			case GREEN:     return "32";
			case YELLOW:    return "33";
			case BLUE:      return "34";
			case PURPLE:    return "35";
			case LIGHTBLUE: return "36";
			case WHITE:     return "37";
			default:   return "30";
		}
	}

	public String colorCode() {
		return "\u001b[" + this.cc() + "m";
	}

	public static Color DEFAULT = new FontColor(BaseColor.WHITE);
}
