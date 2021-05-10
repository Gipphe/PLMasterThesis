/**
 * The finest cutlery you can find.
 */
public class SilverwareCutleryFactory implements CutleryFactory {
	public Fork makeFork() {
		return new SilverwareFork();
	}

	public Knife makeKnife() {
		return new SilverwareKnife();
	}
}
