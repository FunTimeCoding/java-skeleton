package org.funtimecoding.java.skeleton;

import org.testng.Assert;
import org.testng.annotations.Test;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class TestJavaSkeletonMain {
    @Test
    public void testRun() {
        JavaSkeletonMain application = new JavaSkeletonMain();
        Assert.assertEquals(application.run(), 0);
    }

    @Test
    public void testGet() {
        try {
            URL locator = new URL("http://example.org");
            HttpURLConnection connection = (HttpURLConnection) locator.openConnection();
            connection.setRequestMethod("GET");
            Assert.assertEquals(connection.getResponseCode(), 200);
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String line;
            StringBuilder buffer = new StringBuilder();

            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }

            reader.close();
            Assert.assertNotEquals(buffer.toString(), "");
            Assert.assertTrue(buffer.toString().contains("Example Domain"));
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }
}
