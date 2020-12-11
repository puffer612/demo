package com.youlu.api;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

/**
 * https://blog.csdn.net/fanjieshanghai/article/details/50242419 中英文
 */
@RunWith(Cucumber.class)
@CucumberOptions(plugin = {"pretty", "html:target/cucumber.html", "json:target/cucumber.json"},
        features = "classpath:features/",
        useFileNameCompatibleName = true)
public class RunCucumberTest {
    
}
