package org.funtimecoding.java.skeleton;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class JavaSkeletonMainTest {
    @Test
    public void testRun() {
        JavaSkeletonMain application = new JavaSkeletonMain();

        int result = application.run();

        assertEquals(result, 0);
    }
}
