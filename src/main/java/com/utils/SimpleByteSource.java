package com.utils;

import org.apache.shiro.util.ByteSource;

import java.io.File;
import java.io.InputStream;
import java.io.Serializable;

/**
 * 解决缓存SimpleByteSource的序列化异常
 */
public class SimpleByteSource extends org.apache.shiro.util.SimpleByteSource implements Serializable {

    public static final long serialVersionUID = 6468276192434082416L;

    public SimpleByteSource(String str){
        super(str);
    }
    public SimpleByteSource(char[] chars){
        super(chars);
    }

    public SimpleByteSource(ByteSource source) {
        super(source);
    }

    public SimpleByteSource(File file) {
        super(file);
    }

    public SimpleByteSource(InputStream stream) {
        super(stream);
    }

    public SimpleByteSource(byte[] bytes) {
        super(bytes);
    }

    public static SimpleByteSource bytes(byte[] bytes){
        return new SimpleByteSource(bytes);
    }
    public static SimpleByteSource bytes(String byteStr){
        return new SimpleByteSource(byteStr.getBytes());
    }

}
