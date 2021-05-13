import java.util.*;

public abstract class Coll<T> {
	public abstract void add(T v);

	public abstract Iterator<T> createIterator();

	public void addIterator(Iterator<T> itr) {
		if (itr == null) {
			return;
		}
		while (itr.hasNext()) {
			this.add(itr.next());
		}
	}
}
