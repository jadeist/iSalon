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
    
    public static String[] fillArrayHorario(String[] array, String item, int start, int end) {
        if(start > end) {
            int aux = start;
            start = end;
            end = aux;
        }
        
        for(int i=start; i<end; ++i) {
            if(array[i].equals("")) {
                array[i] = item;
            } else {
                array[i] = "<div class='blue lighten-3'>" + array[i] + "<br>" + item + "</div>";
            }
        }
        
        return array;
    }
    
}
