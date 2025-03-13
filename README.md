# 📌 PinApp Challenge

**PinApp Challenge** es una aplicación desarrollada en **Flutter** como parte de un reto técnico. Implementa **BLoC** para la gestión del estado, consume una API externa para obtener posts y comentarios, y permite a los usuarios realizar búsquedas y marcar favoritos. 🚀

---

## 🛠 Tecnologías Utilizadas

- **Flutter** (Dart)
- **BLoC (flutter_bloc)** para el manejo de estado
- **Dio** para consumo de API
- **MethodChannel** para llamadas nativas en Android
- **Clean Architecture** aplicada
- **MultiBlocProvider** para inyección de dependencias
- **Unit Tests** para validación de funcionalidades

---

## 📥 Instalación y Configuración

### 1️⃣ **Clonar el repositorio**
```bash
git clone https://github.com/igna777/pinapp_mobile_challenge.git
cd pinapp_mobile_challenge
```

### 2️⃣ **Instalar dependencias**
```bash
flutter pub get
```

### 3️⃣ **Ejecutar la app**
```bash
flutter run
```

> 📌 **Nota:** Asegúrate de tener un emulador o dispositivo conectado.

---

## 📌 Funcionalidades Implementadas

✅ **Lista de Posts**: Se obtiene desde la API y se muestra en una lista interactiva.  
✅ **Detalle de Post**: Al hacer tap en un post, se abre una pantalla con su detalle.  
✅ **Comentarios desde Native**: Se recuperan comentarios utilizando `MethodChannel`.  
✅ **Búsqueda de Posts**: Filtra los posts en tiempo real.  
✅ **Likes en Posts**: Se pueden marcar/desmarcar posts favoritos.  
✅ **Gestión de Estados con BLoC**: Implementación de `PostBloc` con eventos y estados.  
✅ **Inyección de Dependencias**: Uso de un `DependencyInjection` centralizado.  
✅ **Manejo de Errores**: Se implementaron controles para errores de red y excepciones.  
✅ **Test Unitarios**: Se escribieron pruebas para validar la lógica de negocio.  

---

## 🏗️ Arquitectura del Proyecto

El proyecto sigue **Clean Architecture**, organizando el código en:

📂 `core/` → Colores, strings, configuraciones  
📂 `data/` → Implementaciones de acceso a datos  
📂 `domain/` → Entidades y casos de uso  
📂 `presentation/` → UI y lógica de presentación  
📂 `navigation/` → Gestión de rutas y navegación  

---

## ✅ API Utilizada

La API utilizada es [`jsonplaceholder.typicode.com`](https://jsonplaceholder.typicode.com/), específicamente:

- 📥 Obtener posts:  
  `GET https://jsonplaceholder.typicode.com/posts`

- 💬 Obtener comentarios de un post:  
  `GET https://jsonplaceholder.typicode.com/comments?postId={id}`

---

## 🚀 Futuras Mejoras

- [ ] Persistencia de favoritos (local storage)
- [ ] Modo oscuro
- [ ] Tests de integración
- [ ] Soporte para iOS

---

## 📜 Licencia

Este proyecto es solo con fines educativos y no tiene fines comerciales. 🛠️

