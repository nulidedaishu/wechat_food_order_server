package com.yy.wechat.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class RestTemplateConfig {

    @Bean
    public RestTemplate restTemplate() {
        RestTemplate rest = new RestTemplate();

        // 创建一个 MappingJackson2HttpMessageConverter 实例，用于处理 JSON 数据
        MappingJackson2HttpMessageConverter jsonConv = new MappingJackson2HttpMessageConverter();
        
        // 获取默认支持的媒体类型列表，并添加 text/plain 类型
        // 这样配置后 RestTemplate 可以处理文本格式的响应数据
        List<MediaType> mts = new ArrayList<>(jsonConv.getSupportedMediaTypes());
        mts.add(MediaType.TEXT_PLAIN);
        jsonConv.setSupportedMediaTypes(mts);

        // 从 RestTemplate 的消息转换器列表中移除原有的 Jackson JSON 转换器
        // 将我们自定义配置的 jsonConv 添加到转换器列表最前面
        // 确保优先使用我们配置的转换器来解析响应内容
        List<HttpMessageConverter<?>> converters = rest.getMessageConverters();
        converters.removeIf(c -> c instanceof MappingJackson2HttpMessageConverter);
        converters.add(0, jsonConv);

        return rest;
    }
}


