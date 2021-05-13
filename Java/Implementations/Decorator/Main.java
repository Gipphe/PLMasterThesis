public class Main {
	public static void main(String... args) {
		Screen s = new Screen();
		Display[] shapes = new Display[] {
			new BorderDecorator(1,
				new Rectangle(40, 10)
			),
			new ColorDecorator(new BackgroundColor(BaseColor.PURPLE),
				new BorderDecorator(2,
					new Rectangle(10, 20)
				)
			),
			new ColorDecorator(new BackgroundColor(BaseColor.GREEN),
				new LowerCaseDecorator(
					new BorderDecorator(1,
						new Circle(314)
					)
				)
			),
			new ColorDecorator(new FontColor(BaseColor.RED),
				new UpperCaseDecorator(
					new Square(11)
				)
			)
		};

		for (Display shape : shapes) {
			s.displayOnScreen(shape);
			System.out.println("\n");
		}
	}
}
