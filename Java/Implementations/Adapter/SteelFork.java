public class SteelFork implements Fork {
	public String appearance() {
		return "dull and boring";
	}

	public String pointiness() {
		return "adequate for any meal";
	}

	public String stabFood(String food) {
		return "You stab the "
			+ food
			+ " with the steel fork. Its pointiness is "
			+ this.pointiness()
			+ ", even though its apperance is "
			+ this.appearance();
	}
}
