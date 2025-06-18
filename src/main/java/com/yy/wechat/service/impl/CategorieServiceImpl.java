package com.yy.wechat.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yy.wechat.model.entity.Categorie;
import com.yy.wechat.service.CategorieService;
import com.yy.wechat.mapper.CategorieMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class CategorieServiceImpl extends ServiceImpl<CategorieMapper, Categorie>
    implements CategorieService{

}




