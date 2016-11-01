package resources;


import java.io.*;
import java.util.ArrayList;

import resources.Marca;
import resources.Modelo;;

public class Cargar {
	
	/** Marcas de vehículos que maneja el calculador */
    private ArrayList marcas;
    /** Rangos de los impuestos */
    
	public Cargar() {
		marcas = new ArrayList( );
		// TODO Auto-generated constructor stub
	}
	public void cargarVehiculos1( String archivo ) throws Exception
    {
        Marca marca;
        Linea linea;
        Modelo modelo;
        String texto, valores[], sMarca, sLinea, sModelo;
        double precio;
        BufferedReader lector;
        try
        {
            File datos = new File( archivo );
            lector = new BufferedReader( new FileReader( datos ) );
            texto = lector.readLine( );
        }
        catch( Exception e )
        {
            throw new Exception( "Error al cargar los datos almacenados de vehículos" );
        }
        
        while( texto != null )
        {
        	//Si comienza con # es comentario
            if( !texto.startsWith( "#" ) && !texto.equals( "" ) )
            {
                //Lee los datos
            	//System.out.println("VEHICULOStexto2:" + texto);
                valores = texto.split( "," );

                if( valores.length < 3 )
                    throw new Exception( "Faltan datos línea: " + texto );

                sMarca = valores[ 0 ];
                sLinea = valores[ 1 ];
                sModelo = valores[ 2 ];
                try
                {
                    precio = Double.parseDouble( valores[ 3 ] );
                }
                catch( Exception e )
                {
                    throw new Exception( "El valor de precio debe ser numérico: " + valores[ 3 ] );
                }
                //Crea la configuración de un vehículo según los datos
                //Busca o crea la marca
                marca = buscarMarca( sMarca );
                if( marca == null )
                {
                    marca = new Marca( sMarca );
                    adicionarMarca( marca );
                }
                //A la marca le busca o le adiciona una línea
                linea = marca.buscarLinea( sLinea );
                if( linea == null )
                {
                    linea = new Linea( sLinea );
                    marca.adicionarLinea( linea );
                }
                //A la línea le busca o adiciona un modelo
                modelo = linea.buscarModelo( sModelo );
                if( modelo == null )
                {
                    modelo = new Modelo( sModelo, precio );
                    linea.adicionarModelo( modelo );
                }
            }
            try
            {
                //siguiente línea
                texto = lector.readLine( );
            }
            catch( Exception e )
            {
                throw new Exception( "Error al cargar los datos almacenados de vehículos" );
            }
        }
    }
	
	private void adicionarMarca( Marca unaMarca )
    {
        if( buscarMarca( unaMarca.darNombre( ) ) == null )
            marcas.add( unaMarca );
    }
	
	private Marca buscarMarca( String nombre )
    {
        Marca marca = null;
        for( int i = 0; i < marcas.size( ) && marca == null; i++ )
        {
            Marca marcaAux = ( Marca )marcas.get( i );
            if( marcaAux.darNombre( ).equalsIgnoreCase( nombre ) )
                marca = marcaAux;
        }
        return marca;
    }


}
