package com.yy.wechat.config;

import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.support.config.FastJsonConfig;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import com.yy.wechat.interceptor.AuthInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 * Web配置类，用于配置拦截器和消息转换器等Web相关设置。
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {
    private final AuthInterceptor authInterceptor;

    /**
     * 构造函数注入AuthInterceptor实例。
     *
     * @param authInterceptor 身份验证拦截器
     */
    public WebConfig(AuthInterceptor authInterceptor) {
        this.authInterceptor = authInterceptor;
    }

    /**
     * 配置拦截器。
     * 添加身份验证拦截器，对所有 /api/** 的请求进行身份验证，
     * 排除不需要身份验证的路径：/api/auth/**, /api/product/**, /api/coupons/** 和 /error。
     *
     * @param registry 拦截器注册表
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authInterceptor)
                .addPathPatterns("/api/**") // 对所有/api开头的请求生效
                .excludePathPatterns("/api/auth/**", "/api/product/**", "/api/coupons/**", "/error"); // 排除特定路径
    }

    /**
     * 配置HTTP消息转换器。
     * 用于自定义字符串和JSON的消息转换行为。
     *
     * @param converters HTTP消息转换器列表
     */
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        // 配置字符串消息转换器
        // 1. 创建一个StringHttpMessageConverter对象，并指定字符集为UTF-8
        StringHttpMessageConverter converter = new StringHttpMessageConverter(StandardCharsets.UTF_8);
        // 2. 将该转换器添加到converters列表的最前面（优先级最高）
        converters.add(0, converter);

        // 配置FastJSON消息转换器
        // 1. 创建一个FastJsonHttpMessageConverter对象
        FastJsonHttpMessageConverter fastConverter = new FastJsonHttpMessageConverter();
        // 2.1 创建FastJsonConfig并设置序列化特性
        FastJsonConfig fastJsonConfig = new FastJsonConfig();
        fastJsonConfig.setSerializerFeatures(
                SerializerFeature.WriteMapNullValue, // 序列化时写入空字段
                SerializerFeature.WriteNullStringAsEmpty, // 将null字符串序列化为空字符串
                SerializerFeature.WriteNullListAsEmpty, // 将null集合序列化为空集合
                SerializerFeature.WriteDateUseDateFormat, // 使用日期格式序列化日期
                SerializerFeature.DisableCircularReferenceDetect); // 禁用循环引用检测

        // 2.2 设置支持的媒体类型并解决中文乱码问题
        List<MediaType> fastMediaTypes = new ArrayList<>();
        fastMediaTypes.add(MediaType.APPLICATION_JSON); // 支持application/json类型
        fastConverter.setSupportedMediaTypes(fastMediaTypes);

        // 3. 将fastJsonConfig配置到fastConverter中
        fastConverter.setFastJsonConfig(fastJsonConfig);

        // 4. 将FastJsonHttpMessageConverter添加到converters列表中，排在第二位
        converters.add(1, fastConverter);
    }
}
