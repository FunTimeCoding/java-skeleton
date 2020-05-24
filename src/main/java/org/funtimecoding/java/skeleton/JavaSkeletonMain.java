package org.funtimecoding.java.skeleton;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JavaSkeletonMain {
    private static final Logger logger = LoggerFactory.getLogger(JavaSkeletonMain.class);

    public static void main(String[] args) {
        JavaSkeletonMain application = new JavaSkeletonMain();
        System.exit(application.run());
    }

    int run() {
        logger.info("Hello friend from {}", JavaSkeletonMain.class.getSimpleName());

        return 0;
    }
}
