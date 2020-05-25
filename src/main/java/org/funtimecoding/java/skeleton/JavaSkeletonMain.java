package org.funtimecoding.java.skeleton;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class JavaSkeletonMain {
    private static final Logger LOGGER = LoggerFactory.getLogger(
        JavaSkeletonMain.class
    );

    public static void main(final String[] args) {
        JavaSkeletonMain application = new JavaSkeletonMain();
        System.exit(application.run());
    }

    int run() {
        LOGGER.info(
            "Hello friend from {}",
            JavaSkeletonMain.class.getSimpleName()
        );

        return 0;
    }
}
