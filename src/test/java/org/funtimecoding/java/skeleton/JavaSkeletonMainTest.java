package org.funtimecoding.java.skeleton;

import org.hamcrest.CoreMatchers;
import org.junit.Test;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import static org.junit.Assert.*;

public class JavaSkeletonMainTest {
    @Test
    public void testRun() {
        JavaSkeletonMain application = new JavaSkeletonMain();
        assertEquals(0, application.run());
    }

    @Test
    public void testGet() {
        try {
            URL locator = new URL("http://example.org");
            HttpURLConnection connection = (HttpURLConnection) locator.openConnection();
            connection.setRequestMethod("GET");
            assertEquals(200, connection.getResponseCode());
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String line;
            StringBuilder buffer = new StringBuilder();

            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }

            reader.close();
            assertNotEquals("", buffer.toString());
            assertThat(buffer.toString(), CoreMatchers.containsString("Example Domain"));
            // TODO: This leads to OutOfMemoryError when running mvn test. How to compare entire buffer content?
            //assertEquals("test", buffer.toString());
        } catch (Exception e) {
            fail(e.getMessage());
        }
    }
}
