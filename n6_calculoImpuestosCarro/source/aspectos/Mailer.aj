/*ENVIA UN CORREO PARA CASOS DONDE EL IMPUESTO CALCULADO SEA SUPERIOR A 2 MILLONES
 * Para lograrlo se intercepta el metodo calcular pago y se revisa la variable de calculo,
 * si es mayor a 2M se envia el correo por medio de MailTransport correo = new MailTransport();
 * 
 */
package aspectos;

import java.io.*;

import resources.MailTransport;

public aspect Mailer {
	
	pointcut mailer(): 
	within(uniandes.cupi2.impuestosCarro.interfaz..*) &&
	call(public double calcularPago(..)) ; //Solo intercepta calcularpago dentro de interfaz
	
	after() returning(Object r): mailer(){
		double valueImpuesto = 0;
		MailTransport correo = new MailTransport(); // Clase que envia el correo
		String eMailAddr;
		
		//Convierte a Double y compara contra 2 Millones
		valueImpuesto = Double.parseDouble(r.toString());
		if (valueImpuesto > 2000000 ) { 
			//Pide el correo a donde enviar la informacion si se deja en blaco usa por defecto:
			//desarrollosgzapata@gmail.com
			BufferedReader eMail = new BufferedReader(new InputStreamReader(System.in));
			System.out.print("Ingrese Correo Electronico:");
	        try {
				eMailAddr = eMail.readLine();
				// Busca los valores detallados del carro para enriquecer la informacion del correo
				Object[] args = thisJoinPoint.getArgs();
				StringBuffer sb = new StringBuffer("[");
				for (int i = 0; i < args.length; i++) {
					Object o = args[i];
					sb.append("'" + o + "'");
					sb.append((i == args.length - 1) ? "" : ", ")	;
				}
				sb.append("]");
				
				System.out.println("Objeto Retornado Enviando mail:" + valueImpuesto);
				correo.sendEmail(eMailAddr, sb.toString() + " Valor Impuesto " + valueImpuesto); // Envia el Correo
			
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}
