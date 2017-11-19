package cn.smbms.util;

import org.springframework.beans.TypeMismatchException;
import org.springframework.beans.propertyeditors.PropertiesEditor;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

public class MyDate extends PropertiesEditor {
    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        SimpleDateFormat sdf=getOneDate(text);
        try {
            Date parse = sdf.parse(text);
            setValue(parse);
        } catch (ParseException e) {
            e.printStackTrace();
        }

    }

    public SimpleDateFormat getOneDate(String source){
        SimpleDateFormat sdf=null;
        if(Pattern.matches("^\\d{4}-\\d{2}-\\d{2}$",source)){
           sdf=new SimpleDateFormat("yyyy-MM-dd");
        }else if(Pattern.matches("^\\d{4}/\\d{2}/\\d{2}$",source)){
            sdf=new SimpleDateFormat("yyyy/MM/dd");
        }else if(Pattern.matches("^\\d{4}\\d{2}\\d{2}$",source)){
            sdf=new SimpleDateFormat("yyyyMMdd");
        }else if(Pattern.matches("^\\d{4}年\\d{2}月\\d{2}$",source)){
            sdf=new SimpleDateFormat("yyyy年MM月dd");
        }else{
            throw  new TypeMismatchException("",Date.class);
        }

        return sdf;
    }
}
