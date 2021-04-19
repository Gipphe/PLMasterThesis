public class Main {
	public static void main(String... args) {
		Screen s = new Screen();
		Display[] shapes = new Display[] {
			new ColorDecorator("Magenta", new BorderWidthDecorator(2, new Rectangle(10, 20))),
			new BorderColorDecorator("Cyan", new BorderWidthDecorator(1, new Circle(314))),
			new OpacityDecorator(50, new UpperCaseDecorator(new ColorDecorator("Black", new Square(11))))
		};

		for (Display shape : shapes) {
			s.displayOnScreen(shape);
		}
	}
}
