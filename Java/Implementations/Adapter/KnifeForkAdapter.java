public class KnifeForkAdapter implements Fork {
	private Knife knife;

	public KnifeForkAdapter(Knife knife) {
		this.knife = knife;
	}

	public String pointiness() {
		return "like its sharpness, " + this.knife.sharpness();
	}

	public String appearance() {
		return this.knife.appearance();
	}

	public String stabFood(String food) {
		return "You stab the "
			+ food
			+ " with a "
			+ this.knife.type()
			+ " knife, using it like a single-pronged fork. The knife's sharpness is "
			+ this.knife.sharpness()
			+ ", which shows in how it handles as a makeshift fork.";
	}
}
