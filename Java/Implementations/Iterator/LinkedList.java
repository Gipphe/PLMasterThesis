public class LinkedList<T> extends Collection<T> {
	private Node<T> head;

	public void add(T v) {
		Node<T> node = new Node<>(v);
		if (this.head == null) {
			this.head = node;
			return;
		}
		Node<T> curr = this.head;
		while (curr.getNext() != null) {
			curr = curr.getNext();
		}
		curr.setNext(node);
	}

	public Iterator<T> createIterator() {
		return new LinkedListIterator(this);
	}

	public class Node<T> {
		private Node<T> next;
		private T value;

		private Node(T v) {
			this.value = v;
		}

		private void setNext(Node<T> next) {
			this.next = next;
		}

		private Node<T> getNext() {
			return this.next;
		}

		private T getValue() {
			return this.value;
		}
	}

	public class LinkedListIterator implements Iterator<T> {
		private Node<T> curr;
		private Node<T> first;

		public LinkedListIterator(LinkedList<T> list) {
			this.curr = list.head;
			this.first = list.head;
		}

		public boolean isDone() {
			return this.curr == null;
		}

		public T currentItem() {
			return this.curr.getValue();
		}

		public void next() {
			if (this.curr != null) {
				this.curr = this.curr.next;
			}
		}

		public void first() {
			this.curr = this.first;
		}
	}
}
