LISTA DE LOCALES

Ficheros:
1. Local.swift -> Estructura de datos
2. Conectar.swift -> Clase para realizar la petición HTTPS
3. LocalesTableViewController.swift -> Controlador de tabla
4. LocalesTableViewCell.swift -> Celda para mostrar un registro (Local)

ANTES DE EJECUTAR LA APLICACIÓN DEBE:

1. Abrir fichero Conectar.swift.
2. En linea 23, reemplazar el valor de la constante "authorization" por el token.
3. Guardar y ejecutar.

OBSERVACIONES

1. Realicé la paginación pero con un UIRefreshControl, se ejecuta al deslizar la pantalla hacia arriba, no hacia abajo como se solicitó en el documento.

2. Prueba Unitaria func testProximaPagina (), comprueba lo consistencia de datos de la función func proximaPagina (pagina : Int) de la página conectar.

3. Prueba Unitaria, comprueba que en la función func buscarLocales(completion: @escaping (Result<Respuesta, Error>) -> Void) se genere un JSON con 20 registros en la primera consulta.

Adrián Otero