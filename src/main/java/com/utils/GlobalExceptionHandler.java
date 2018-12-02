package com.utils;

import com.alibaba.fastjson.support.spring.FastJsonJsonView;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


public class GlobalExceptionHandler implements HandlerExceptionResolver {
    static final Logger log=Logger.getLogger("GlobalExceptionHandler");
    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception ex) {

        ModelAndView mv = new ModelAndView();
        /*	使用FastJson提供的FastJsonJsonView视图返回，不需要捕获异常	*/
        FastJsonJsonView view = new FastJsonJsonView();
        Map<String, Object> attributes = new HashMap<String, Object>();
        attributes.put("code", "500");
        attributes.put("msg", ex.getMessage());
        attributes.put("data", ex.getMessage());
        view.setAttributesMap(attributes);
        mv.setView(view);
        log.error("500",ex);
        return mv;

    }
}
