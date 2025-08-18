# Proyecto SQL – Análisis de Base de Datos de Alquiler de Películas

## 📝 Descripción

Este proyecto ha sido desarrollado como parte del curso de formación en SQL. El objetivo ha sido analizar una base de datos de un videoclub utilizando PostgreSQL y DBeaver como entorno de trabajo.

A partir de una base de datos relacional con tablas como `film`, `rental`, `customer`, `category`, `actor`, etc., se han realizado consultas que permiten extraer conclusiones sobre el comportamiento de clientes, rendimiento de películas, y organización de la información.

---

## 🧩 Esquema de la base de datos

Se ha trabajado sobre un modelo de base de datos proporcionado por la formación, compuesto por las siguientes tablas principales:

- `film`: información de películas
- `actor` y `film_actor`: relación entre actores y películas
- `category` y `film_category`: relación entre categorías y películas
- `inventory`: copias físicas disponibles
- `rental`: registros de alquileres
- `customer`: clientes del videoclub
- `store` y `staff`: tiendas y empleados
- `payment`: pagos asociados a los alquileres

🔗 El esquema gráfico de la base de datos está incluido en el repositorio como imagen o documento PDF.

---

## 🔄 Pasos seguidos durante el proyecto

1. Exploración inicial de las tablas y relaciones en DBeaver.
2. Análisis del esquema y mapeo de relaciones con JOINs.
3. Desarrollo progresivo de consultas simples y avanzadas.
4. Uso de funciones agregadas, subconsultas, `HAVING`, `GROUP BY`, `ORDER BY`, `LEFT JOIN`, `CROSS JOIN`, etc.
5. Creación de vistas y tablas temporales para simplificar análisis.
6. Documentación del trabajo y organización de resultados.

---

## 🔍 Consultas realizadas

Se han desarrollado un total de **63 consultas**, entre ellas:

- Total de alquileres por cliente.
- Actores que han actuado en películas de categorías concretas.
- Clientes que alquilaron películas más de X días.
- Películas sin actores o actores sin películas.
- Alquileres activos de un cliente concreto.
- Cruce entre empleados y tiendas (producto cartesiano).
- Películas más alquiladas y categorías más populares.
- Subconsultas con condiciones dependientes.
- Creación de vistas y tablas temporales.

📄 Todas las consultas están recogidas en el archivo [`consultas_proyecto.sql`](./consultas_proyecto.sql), con su número y enunciado comentado para facilitar la lectura.

---

## 📈 Conclusiones

- La mayoría de los alquileres son de duración corta, lo que indica rotación alta de inventario.
- Las categorías de acción, comedia y drama concentran la mayor parte del catálogo.
- Algunos actores no han participado en ninguna película registrada.
- Es posible detectar películas sin alquileres, así como clientes muy activos.
- Las funciones agregadas, combinadas con subconsultas y filtrado por fecha, permiten extraer insights útiles para el negocio.

---

## 🛠 Herramientas utilizadas

- PostgreSQL 15+
- DBeaver como cliente de base de datos
- Git y GitHub para control de versiones y entrega

---

## 📂 Estructura del repositorio

```
/proyecto-sql
│
├── README.md
├── esquema-bbdd.pdf (o imagen)
├── consultas_proyecto.sql
```

---

## 👤 Autor

**Adrián Barroso Arévalo**  
Proyecto realizado como ejercicio final del curso de formación en SQL.
