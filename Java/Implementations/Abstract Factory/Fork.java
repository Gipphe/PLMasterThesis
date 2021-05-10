public abstract class Fork {
	protected int numberOfProngs;
	protected int length;

	protected Fork(int numberOfProngs, int length) {
		this.numberOfProngs = numberOfProngs;
		this.length = length;
	}

	public int numberOfProngs() {
		return this.numberOfProngs;
	}

	public int length() {
		return this.length;
	}

	public abstract void stickFood(String food);
}
