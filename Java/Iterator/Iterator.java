public interface Iterator<T> {
	void first();
	void next();
	T currentItem();
	boolean isDone();
}
