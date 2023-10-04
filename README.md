# El Lobo

Proyecto de Flutter para la App "El Lobo"

## Contexto

Este proyecto se originó a raíz de un trabajo práctico y teórico de la Asignatura de Desarrollo de Software para Dispositivos Móviles, del Grado de Ingeniería Informática de la UJA.

A día de hoy no está completada por falta de recursos y tiempo.

## FEATURES

✅ Seleccionar Jugadores
✅ Añadir y Eliminar Jugadores de la lista de selección
✅ Añadir Fotos de Perfil a cada jugador
✅ Seleccionar Roles
✅ Seleccionar Roles de forma aleatoria (de forma balanceada)
✅ Ver Reglas del Juego
✅ Seleccionar Jugadores
✅ Bucle del Juego
✅ Pantalla de Estado de la Partida
✅ Selección de Acción para cada Rol despertado
✅ Pantalla votaciones
⬛ Lógica y acciones disponibles de cada Rol
⬛ Game Over

## ¿Qué es El Lobo?

Es mi versión del juego de mesa "Los hombres lobo de Castronegro", en el que todos los jugadores obtienen un rol privado, cada uno con unas acciones especiales.

La dinámica principal es el sistema de días o fases de Juego.
El objetivo de los Lobos será matar a todos los demás Jugadores durante la noche. Y los Jugadores aldeanos deben matar los lobos antes de que todos mueran, por medio de sus acciones según su rol durante la noche, o por medio de las votaciones durante el día

### Fases del día

Durante la noche todos permanecen dormidos (con los ojos cerrados) y el/la Narrador/a, que se encarga de gestionar la partida y repartir los roles, va despertando a cada Rol en un orden específico.
Cuando un Jugador se despierta debe tomar una decisión según la acción asociada a su Rol (la narradora se encarga de preguntarle y ejecutar su acción).

Durante el día se procede a una votación en la que todo jugador vivo puede participar y se acaba "linchando" a la persona que tiene una mayoría de votos, la cual acaba muerto.

### Funcionalidad de la APP

Está totalmente pensada para facilitar al narrador el desarrollo de la partida. Es únicamente este narrador el que maneja la App.
La distribución de Roles entre los Jugadores se hace de forma totalmente aleatoria, y la selección de que roles aparecen en la partida es totalmente configurable.

Durante la partida, cada fase, y dentro de cada fase, cada decisión tiene su propia pantalla. Viendo la decisión que toma el jugador despierto, o durante la votación, a quién vota cada jugador, será el Narrador, quien por medio de la App, traslade la decisión a un tablón con la lista de jugadores, clickando en el jugador al que se le hace objetivo de la acción.

Toda la lógica de juego ( si la persona objetivo estaba protegida, si estaba enamorada, etc) se gestiona automáticamente por la App, reduciendo la carga cognitiva del Narrador/a y la posibilidad del fallo humano. Los cambios en el estado de juego se pueden consultar y serán visibles al narrador durante toda la partida.

### Diferenciación con otras Apps similares

Después de un análisis exhaustivo del mercado, descubrí que todas las aplicaciones que simulan partidas de "Los hombres lobo de Castronegro", aparte de tomarse licencias para cambiar la lógica de juego, quitan al Narrador de la ecuación. La dinámica de estan Apps se basa en ir pasando el móvil de una persona a otra, lo cual hace al juego muy aparatoso y complicado de gestionar, en mi opinión y una opinión de un grupo representativo de personas con las que he hablado.

Creo fervientemente que el/la Narrador/a tienen un papel fundamental en el Juego. Yo en lo personal, y algunas personas con las que he jugado, disfrutamos de llevar la narración de la partida, y cada uno tiene su toque personal de narrar. Por ello he decidido crear esta aplicación, y creo que si la comercializado tendría un impacto positivo.
