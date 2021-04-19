public class Main {
	public static void main(String... args) {
		Collection<Integer> ll = new LinkedList<>();
		ll.add(11);
		ll.add(35);
		ll.add(34563298);
		ll.add(-12);

		Collection<Integer> bt = new BinaryTree<>(new IntComparator());
		bt.add(34);
		bt.add(19846);
		bt.add(1);
		bt.add(78656);
		bt.add(2);
		bt.add(2);

		bt.addIterator(ll.createIterator());

		Iterator<Integer> llitr = ll.createIterator();
		Iterator<Integer> btitr = bt.createIterator();


		System.out.println("LinkedList");
		printIterator(llitr);
		System.out.println("--------");
		System.out.println("BinaryTree");
		printIterator(btitr);
	}

	private static <T> void printIterator(Iterator<T> itr) {
		if (itr == null) {
			return;
		}
		while (!itr.isDone()) {
			System.out.println(itr.currentItem());
			itr.next();
		}
	}
}

class IntComparator implements Comparator<Integer> {
	public Ordering compare(Integer x, Integer y) {
		if (x > y) {
			return Ordering.GT;
		} else if (x < y) {
			return Ordering.LT;
		} else {
			return Ordering.EQ;
		}
	}
}
