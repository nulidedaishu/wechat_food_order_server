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

        // 1. 新建一个 Jackson JSON converter
        MappingJackson2HttpMessageConverter jsonConv = new MappingJackson2HttpMessageConverter();
        // 2. 在它原有的媒体类型列表里，加上 text/plain
        List<MediaType> mts = new ArrayList<>(jsonConv.getSupportedMediaTypes());
        mts.add(MediaType.TEXT_PLAIN);
        jsonConv.setSupportedMediaTypes(mts);

        // 3. 把默认的 Jackson converter 替换成这个
        List<HttpMessageConverter<?>> converters = rest.getMessageConverters();
        converters.removeIf(c -> c instanceof MappingJackson2HttpMessageConverter);
        converters.add(0, jsonConv);

        return rest;
    }
}


