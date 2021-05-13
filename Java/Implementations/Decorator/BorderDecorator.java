import java.util.*;

public class BorderDecorator extends DisplayDecorator {
	private int width;

	public BorderDecorator(int width, Display contained) {
		super(contained);
		this.width = width;
	}

	private String padRight(char c, int l, String s) {
		int missing = l - s.length();
		if (missing > 0) {
			s = s + String.valueOf(c).toString().repeat(missing);
		}
		return s;
	}

	private String horizontalBorder(int longestLine) {
		int borderLength = longestLine + 2 + (this.width * 2);
		return "-".repeat(borderLength);
	}

	private String verticalBorderLineSpacer(int longestLine) {
		String l = "|".repeat(this.width);
		String m = " ".repeat(longestLine);
		return l + " " + m + " " + l;
	}

	private String addVerticalBorder(int longestLine, String line) {
		String padded = this.padRight(' ', longestLine, line);
		String border = "|".repeat(this.width);
		return border + " " + padded + " " + border;
	}

	private int longestLine(List<String> lines) {
		int longest = 0;
		for (String line : lines) {
			longest = Math.max(longest, line.length());
		}
		return longest;
	}

	private void addHorizontalBorders(int longest, List<String> res) {
		for (int i = 0; i < this.width; i += 1) {
			res.add(this.horizontalBorder(longest));
		}
	}

	private void addVerticalBorderSpacer(int longest, List<String> res) {
		res.add(this.verticalBorderLineSpacer(longest));
	}

	public String display() {
		if (this.width <= 0) {
			return this.contained.display();
		}

		List<String> lines = Arrays.asList(this.contained.display().split("\n"));
		List<String> res = new ArrayList<>();
		int longest = this.longestLine(lines);

		this.addHorizontalBorders(longest, res);
		this.addVerticalBorderSpacer(longest, res);

		for (String line : lines) {
			res.add(this.addVerticalBorder(longest, line));
		}

		this.addVerticalBorderSpacer(longest, res);
		this.addHorizontalBorders(longest, res);

		StringJoiner sj = new StringJoiner("\n");
		for (String line : res) {
			sj.add(line);
		}
		return sj.toString();
	}
}
