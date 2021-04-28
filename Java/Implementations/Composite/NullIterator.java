import java.util.*;

public class NullIterator<T> implements Iterator<T> {
	public boolean hasNext() {
		return false;
	}

	public T next() {
		throw new NoSuchElementException("NullIterators never have any elements");
	}
}
