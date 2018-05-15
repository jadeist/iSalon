/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ctrl;

/**
 *
 * @author Laxelott
 */
public class AuxFunctions {
    
    public static String[] fillArray(String[] array, String item, int start, int end) {
        if(start > end) {
            int aux = start;
            start = end;
            end = aux;
        }
        
        for(int i=start; i<end; ++i) {
            array[i] = item;
        }
        
        return array;
    }
    
}
