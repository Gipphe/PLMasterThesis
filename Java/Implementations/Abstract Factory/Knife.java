public abstract class Knife {
	protected boolean isDoubleEdged;
	protected int weight;

	protected Knife(boolean isDoubleEdged, int weight) {
		this.isDoubleEdged = isDoubleEdged;
		this.weight = weight;
	}

	public boolean isDoubleEdged() {
		return this.isDoubleEdged;
	}

	public int weight() {
		return this.weight;
	}

	public abstract void cutFood(String food);
}
