public class BinaryTree<T> extends Collection<T> {
	private Node<T> root;
	private Comparator<? super T> comp;

	public BinaryTree(Comparator<? super T> comp) {
		this.comp = comp;
	}

	public void add(T x) {
		Node<T> current = this.root;
		Node<T> result = null;
		Ordering compval = Ordering.EQ;

		while (current != null) {
			result = current;
			compval = this.comp.compare(x, current.value);
			current = compval == Ordering.LT ? current.left : current.right;
		}

		current = new Node<>(x);
		current.parent = result;

		if (result == null) {
			this.root = current;
		} else if (compval == Ordering.LT) {
			result.left = current;
		} else {
			result.right = current;
		}
	}

	public boolean contains(T x) {
		if (x == null) {
			return false;
		}
		Node<T> current = this.root;
		while (current != null) {
			switch (this.comp.compare(current.value, x)) {
				case EQ:
					return true;
				case LT:
					current = current.left;
					break;
				case GT:
					current = current.right;
					break;
			}
		}
		return false;
	}

	public Iterator<T> createIterator() {
		return new InOrderIterator<>(this.root);
	}

	private static final class Node<T> {
		private T value;
		private Node<T> parent;
		private Node<T> left;
		private Node<T> right;

		private Node(T x) {
			this.value = x;
		}
	}

	public static final class InOrderIterator<T> implements Iterator<T> {
		private final Node<T> root;
		private Node<T> next;
		private Node<T> lastVisited;

		private InOrderIterator(Node<T> root) {
			this.root = root;
			this.next = leftMost(root);
		}

		public T currentItem() {
			return this.next.value;
		}

		public void first() {
			this.next = leftMost(this.root);
		}

		public void next() {
			this.next = nextNode(this.next);
		}

		public boolean isDone() {
			return this.next == null;
		}

		private static <T> Node<T> nextNode(Node<T> node) {
			if (node == null) {
				return null;
			}
			if (node.right != null) {
				Node<T> curr = node.right;
				while (curr.left != null) {
					curr = curr.left;
				}
				return curr;
			}

			Node<T> paren = node.parent;
			while (paren != null && node == paren.right) {
				node = paren;
				paren = paren.parent;
			}
			return paren;
		}

		private static <T> Node<T> leftMost(Node<T> node) {
			if (node == null) {
				return null;
			}
			while (node.left != null) {
				node = node.left;
			}
			return node;
		}
	}
}
