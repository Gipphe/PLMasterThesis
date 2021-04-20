interface Display {
	String display();
}

class Foo implements Display {
	public String display() { return "Foo"; }
}

class Bar implements Display {
	public String display() { return "Bar"; }
}

class Baz implements Display {
	public String display() { return "Baz"; }
}

public class JavaExample {
	public static void main(String... args) {
		Display[] list = new Display[] {
			new Foo(),
			new Bar(),
			new Baz()
		};
		for (Display x : list) {
			System.out.println(x.display());
		}
	}
}
