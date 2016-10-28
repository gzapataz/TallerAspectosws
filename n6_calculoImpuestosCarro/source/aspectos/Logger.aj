package aspectos;

public aspect Logger {
	pointcut logger():
	      call(* uniandes.cupi2.impuestosCarro.mundo.CalculadorImpuestos.*s(..));
	
	before(): logger(){
		
		StringBuffer signatureString = new StringBuffer("");
		StringBuffer methodName = new StringBuffer("");
		StringBuffer callObject = new StringBuffer("");
		
		signatureString.append(thisJoinPointStaticPart.getSignature().toShortString());
		methodName.append(signatureString.substring(signatureString.indexOf(".") + 1, signatureString.lastIndexOf("(")));
		callObject.append(signatureString.substring(0, signatureString.indexOf(".")));
		System.out.println("Objeto:" + callObject + " Metodo:" + methodName);
		Object[] args = thisJoinPoint.getArgs();
		StringBuffer sb = new StringBuffer("[");
		for (int i = 0; i < args.length; i++) {
			Object o = args[i];
			sb.append("'" + o + "'");
			sb.append((i == args.length - 1) ? "" : ", ")	;
		}
		sb.append("]");
		System.out.println("Argumentos:" + sb);
		
		
		System.out.println("MetodoEstatico:" + thisJoinPointStaticPart.getSignature().toString());
		System.out.println("MetodoTarget:" + thisJoinPoint.getTarget().toString());
		
		
		
		
		
	
	}
	
	before(): logger(){
		System.out.println("Despues de la llamada:");
	}
	
}
