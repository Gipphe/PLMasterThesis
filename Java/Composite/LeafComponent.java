import java.util.*;

public abstract class LeafComponent extends Component {
	private List<Component> components = new ArrayList<>();

	protected LeafComponent(String name) {
		super(name);
	}

	public abstract int price();

	public abstract int wattage();

	public abstract String display();

	public void add(Component c) {}

	public void remove(Component c) {}

	public Iterator<Component> iterator() {
		return new NullIterator<>();
	}
}
