import java.util.HashMap;

public class Test {
    public static void main(String[] args) {
        System.out.println(super.getClass().getName());
        HashMap<String,String> map=new HashMap();
        map.put("one","one");
        map.put("two","two");
        System.out.println(map);

    }
}
