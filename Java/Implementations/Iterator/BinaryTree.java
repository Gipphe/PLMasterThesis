import java.util.*;

public class BinaryTree<T> extends Coll<T> {
	private Node<T> root;
	private Comparator<? super T> comp;

	public BinaryTree(Comparator<? super T> comp) {
		this.comp = comp;
	}

	public void add(T x) {
		Node<T> current = this.root;
		Node<T> result = null;
		int compval = 0;

		while (current != null) {
			result = current;
			compval = this.comp.compare(x, current.value);
			current = compval < 0 ? current.left : current.right;
		}

		current = new Node<>(x);
		current.parent = result;

		if (result == null) {
			this.root = current;
		} else if (compval < 0) {
			result.left = current;
		} else {
			result.right = current;
		}
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

		public T next() {
			T curr = this.next.value;
			this.next = nextNode(this.next);
			return curr;
		}

		public boolean hasNext() {
			return this.next != null;
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
