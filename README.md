# gatacos-game
El ataque de los gatos 😼


## Estructura
gamejam-practice/
├── assets/              # Imágenes, audio, fuentes, etc.
│   ├── characters/      # Sprites del jugador, gatos, enemigos
│   ├── backgrounds/     # Fondos por nivel
│   ├── sounds/          # Efectos de sonido (pop, hit, lose)
│   └── music/           # Música de fondo
│
├── scenes/              # Escenas de Godot
│   ├── main/            # Escena principal del juego
│   ├── player/          # Escena del jugador
│   └── enemies/         # Escena(s) de los gatos
│
├── scripts/             # Todos los scripts GDScript
│   ├── player/          # Scripts del jugador
│   ├── enemies/         # Scripts de los gatos
│   └── ui/              # Scripts de la UI (puntaje, vidas)
│
├── ui/                  # Escenas y assets de interfaz (HUD, Game Over)
│
├── globals/             # Autoloads o escenas/singletons globales
│
└── main.tscn            # Escena principal del juego
