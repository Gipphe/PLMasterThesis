public class SilverFork implements Fork {
	public String appearance() {
		return "elegant and exquisite";
	}

	public String pointiness() {
		return "flawless";
	}

	public String stabFood(String food) {
		return "You stab the "
			+ food
			+ " with the silver fork. It looks "
			+ this.appearance()
			+ ", and its pointiness is "
			+ this.pointiness()
			+ ".";
	}
}
