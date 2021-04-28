public abstract class Collection<T> {
	public abstract void add(T v);

	public abstract Iterator<T> createIterator();

	public void addIterator(Iterator<T> itr) {
		if (itr == null) {
			return;
		}
		while (!itr.isDone()) {
			this.add(itr.currentItem());
			itr.next();
		}
	}
}
