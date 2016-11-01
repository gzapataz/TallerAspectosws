/*ADICIONAR UN NUEVO MODELO A LA LISTA DE MODELOS
 * OPCION 1: POR MEDIO DE PRIVILEGED. NOTA TAMBIEN SE DESARROLLO MEDIANTE ADICIONAR UN METODO PUBLICO E
 * EN EL CODIGO FUENTE DE CUPI2
 * Aspecto que adiciona una marca de vehiculo a la lista usando 
 * la funcionalidad de priviledged para acceder variables y metodos privadas
 * En este caso se usa la variable Privated de Marcas para adicionar un elemento justo despues 
 * de que es cargado por el programa en el Advise After();
 */


package aspectos;

//Clases de de cupi2 necesarias para crear el nuevo carro
import uniandes.cupi2.impuestosCarro.mundo.CalculadorImpuestos;
import uniandes.cupi2.impuestosCarro.mundo.Linea;
import uniandes.cupi2.impuestosCarro.mundo.Marca;
import uniandes.cupi2.impuestosCarro.mundo.Modelo;

privileged public aspect AppendModelPriviledged {
	pointcut appendModel(CalculadorImpuestos p):
		within(uniandes.cupi2.impuestosCarro.mundo.CalculadorImpuestos) &&
		call(private void cargarVehiculos( String )) && target(p);
	
	//Despues de cargar los vehiculos adiciona el nuevo modelo
	after(CalculadorImpuestos p) returning: appendModel(p) 
	{	
		
		System.out.println("Object After: " + thisJoinPoint.getSignature().toString());
		System.out.println("CosasObjetoAfter:" + p);
		try {
			
			//Adiciona un objeto marca, linea modelo usando el metodo privado adicionarMarca
	        Marca newMarca = new Marca("Sastava");
	        Linea newLine = new Linea("S1");
	        p.adicionarMarca(newMarca);
	        newMarca.adicionarLinea(newLine);
	        newLine.adicionarModelo(new Modelo("2005",38000000));
	        
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
