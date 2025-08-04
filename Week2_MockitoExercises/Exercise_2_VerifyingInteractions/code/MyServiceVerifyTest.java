import static org.mockito.Mockito.*;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

public class MyServiceVerifyTest {

    @Test
    public void testVerifyInteraction() {
        // Create mock
        ExternalApi mockApi = Mockito.mock(ExternalApi.class);

        // Inject mock into service
        MyService service = new MyService(mockApi);

        // Call method
        service.fetchData();

        // Verify getData() was called
        verify(mockApi).getData();
    }
}
