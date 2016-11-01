/*ADICIONAR UN NUEVO MODELO A LA LISTA DE MODELOS
 * OPCION 2: SE CREO UN METODO PUBLICO QUE BASICAMENTE ES LA COPIA DEL METODO CARGARVEHICULOS de Cupi2, 
 * Este nuevo metodo se invova despues del primero y lo que hace es cargar otro archivo con carros nuevos
 * llamado "vehiculos1.txt"
 */


package aspectos;

import uniandes.cupi2.impuestosCarro.mundo.CalculadorImpuestos;

public aspect AppendModel {
	pointcut appendModel(CalculadorImpuestos p):
		within(uniandes.cupi2.impuestosCarro.mundo.CalculadorImpuestos) &&
		call(private void cargarVehiculos( String )) && target(p);

	//Una vez cargado el archivo Original, llama el segundo metodos cargarVehiculos1( "data/vehiculos1.txt" );
	after(CalculadorImpuestos p) returning: appendModel(p) 
	{	
		System.out.println("Object After: " + thisJoinPoint.getSignature().toString());
		System.out.println("CosasObjetoAfter:" + p);
		try {
			//Metodo publico creado en Cupi2 para cargar un archivo adicional
			p.cargarVehiculos1( "data/vehiculos1.txt" );
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
