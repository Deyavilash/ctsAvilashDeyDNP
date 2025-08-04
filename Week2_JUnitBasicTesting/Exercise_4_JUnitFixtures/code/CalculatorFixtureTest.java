import static org.junit.Assert.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class CalculatorFixtureTest {

    private Calculator calculator;

    @Before
    public void setUp() {
        calculator = new Calculator();
        System.out.println("Setup done");
    }

    @After
    public void tearDown() {
        System.out.println("Teardown done");
    }

    @Test
    public void testAdd() {
        int a = 2, b = 3;
        int result = calculator.add(a, b);
        assertEquals(5, result);
    }

    @Test
    public void testSubtract() {
        int a = 5, b = 3;
        int result = calculator.subtract(a, b);
        assertEquals(2, result);
    }
}
