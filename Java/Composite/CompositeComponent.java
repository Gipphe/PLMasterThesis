import java.util.*;

public abstract class CompositeComponent extends Component {
	private List<Component> components = new ArrayList<>();

	protected CompositeComponent(String name) {
		super(name);
	}

	public abstract int price();

	public abstract int wattage();

	public abstract String display();

	protected String displayComponents() {
		Iterator<Component> itr = this.iterator();
		StringJoiner csj = Utils.collectionStringJoiner();
		while (itr.hasNext()) {
			Component c = itr.next();
			csj.add(Utils.indentAfterFirst(c.display()));
		}
		return csj.toString();
	}

	public void add(Component c) {
		this.components.add(c);
	}

	public void remove(Component c) {
		this.components.remove(c);
	}

	public Iterator<Component> iterator() {
		return this.components.iterator();
	}
}
