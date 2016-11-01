package aspectos;

public aspect Logger {
	
	pointcut logger(): 
	within(uniandes.cupi2.impuestosCarro.mundo..*) && // Solo intercepta metodos en paquete mundo
	(call(* *(..)) || call(* uniandes.cupi2.impuestosCarro.mundo.*.*(..)));
	
	before(): logger(){
		
		StringBuffer signatureString = new StringBuffer(""); // Guarda la cadena
		StringBuffer methodName = new StringBuffer(""); // para extraer el metodo de la cadena anterior
		StringBuffer callObject = new StringBuffer(""); // para extraer el objeto dueno del metodo
		StringBuffer signatureLongString = new StringBuffer(""); // Guarda la cadena larga
		StringBuffer arguments = new StringBuffer(""); // Guarda la cadena larga
		
		signatureString.append(thisJoinPointStaticPart.getSignature().toShortString());
		methodName.append(signatureString.substring(signatureString.indexOf(".") + 1, signatureString.lastIndexOf("(")));
		callObject.append(signatureString.substring(0, signatureString.indexOf(".")));
		
		signatureLongString.append(thisJoinPointStaticPart.getSignature().toString());
		arguments.append(signatureLongString.substring(signatureLongString.indexOf("("), signatureLongString.lastIndexOf(")")));
		
		System.out.println("Objeto:" + callObject + " Metodo:" + methodName);
		System.out.println("Definicion Argumentos:[" + arguments + ")]");
		
	}
	
	after() returning(Object r): logger(){
		
		Object[] args = thisJoinPoint.getArgs();
		StringBuffer sb = new StringBuffer("[");
		for (int i = 0; i < args.length; i++) {
			Object o = args[i];
			sb.append("'" + o + "'");
			sb.append((i == args.length - 1) ? "" : ", ")	;
		}
		sb.append("]");
		
		System.out.println("Retorno Argumentos:" + sb);
		System.out.println("Objeto Retornado:" + r);
	
	}
	
	after() throwing(Throwable e): logger(){
		System.out.println("Excepcion: " + e.toString());
	}

}
