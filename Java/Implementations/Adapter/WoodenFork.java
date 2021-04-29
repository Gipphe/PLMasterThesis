public class WoodenFork implements Fork {
	public String appearance() {
		return "like a twig right off of a tree";
	}

	public String pointiness() {
		return "lackluster at best, blunt at worst";
	}

	public String stabFood(String food) {
		return "You stab the "
			+ food
			+ " with the wooden fork. The fork isn't very pointy, and you end up smushing your "
			+ food;
	}
}
