package org.funtimecoding.java.skeleton;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class JavaSkeletonMainTest {
    @Test
    public void testRun() {
        JavaSkeletonMain application = new JavaSkeletonMain();
        assertEquals(0, application.run());
    }
}
