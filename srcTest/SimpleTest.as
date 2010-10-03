package {
	import org.flexunit.Assert;

	public class SimpleTest {

		[Test]
		public function testMe() : void {
			Assert.assertTrue("Was not true", false);
		}
	}
}
