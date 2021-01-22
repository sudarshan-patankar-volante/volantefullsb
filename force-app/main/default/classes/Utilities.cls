Public Class Utilities{
    
    public static Set<String> avoidRecursionSet= new Set<String>();
    
    public static boolean avoidRecursionCheck(String input){
        System.debug('avoid::'+avoidRecursionSet.contains(input));
        return avoidRecursionSet.contains(input);
    }  
    
    public static Set<String> SkipMethods(String context){
        System.debug('context::'+context);
        Skip_Context__c sc = [Select id,Recursion_Name__c,Methods__c from Skip_Context__c where Recursion_Name__c=:context];
        avoidRecursionSet.addAll(sc.Methods__c.split(';'));
        System.debug('avoidRecursionSet::'+avoidRecursionSet);
        return avoidRecursionSet;         
    }
    
    public static void clearMethods(){
        avoidRecursionSet.clear();
    }
    
     public static List<String> decode(final Blob input,  final String charset){
        final String hex  =  EncodingUtil.convertToHex(input);
        final Integer size  =  hex.length() >> 1;
        final List<String> bytes  =  new String[size];
        
        for (Integer i  =  0; i < size; ++i) {
            bytes.set(i,  hex.mid(i << 1,  2));
        }
        System.debug(EncodingUtil.urlDecode('%' + String.join(bytes,  '%'), charset));
        String[] filelines  =  (EncodingUtil.urlDecode('%' + String.join(bytes,  '%'), charset)).remove('ï»¿').split('\n');
        System.debug(filelines  );
        System.debug(filelines.size());
        String[] inputvalues  =  new String[]{};
        inputvalues.add(filelines[0]);
        for (Integer j = 1;j < filelines.size();j++){
            String tmpLine =  filelines[j];
            String[] tmp =  filelines[j].split(',');  
            System.debug(tmpLine ); 
            System.debug(tmp );                   
            boolean allowAdd = false;
            for(integer k = 0; k < tmp.size(); k++){
                if(tmp[k].trim() == ''){
                    allowAdd = false;
                }else{
                    allowAdd = true;
                }
                if(allowAdd)
                    break;
            }
            if(allowAdd){
                inputvalues.add(tmpLine);
            }
            System.debug(inputvalues.size()); 
        }
        //return (EncodingUtil.urlDecode('%' + String.join(bytes,  '%'), charset)).remove('ï»¿');
        return inputvalues;
    }   
    
    
}