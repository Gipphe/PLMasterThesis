public abstract class Part implements Cloneable {
	public abstract String display();

	public Part clone() throws CloneNotSupportedException {
		return (Part) super.clone();
	}
}
