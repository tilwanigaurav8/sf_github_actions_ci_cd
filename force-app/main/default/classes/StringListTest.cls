public class StringListTest {
    public static List<String> generateStringList(Integer n){
		List<String> lis = new List<String>();
        for(Integer i = 1 ; i<=n ; i++){
            String s= 'Test '+(i-1);
            lis.add(s);
        }
        return lis;
    }
}