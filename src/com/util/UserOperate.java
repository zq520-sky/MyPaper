package com.util;

import com.Enum.OperationType;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
@Documented
public @interface UserOperate {

    //操作描述
    String describe() default "";

    //操作类型
    String type() default "";

}
