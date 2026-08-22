# Documentación de Tablas — Petromovil

Esta carpeta contiene la documentación del diseño de las tablas físicas referenciadas
en los programas y vistas del proyecto. Bob la utiliza como referencia en cada
conversación para entender la estructura de datos sin necesidad de consultar el IBM i.

## Cómo usar

- **Un archivo por tabla.** Nombre del archivo = nombre exacto de la tabla en DB2 for i.
- **Llenar los campos** con la información real de la tabla (tipos, longitudes, claves, relaciones).
- **Mantener actualizado** cuando cambie el diseño de una tabla.

## Inventario de tablas documentadas

### Módulo NOM — Nómina de Empleados
| Archivo | Tabla | Descripción |
|---------|-------|-------------|
| [NomEmp.md](NomEmp.md) | NomEmp | Maestro de empleados |
| [NomDep.md](NomDep.md) | NomDep | Departamentos |
| [NomCar.md](NomCar.md) | NomCar | Cargos / Puestos |
| [NomCat.md](NomCat.md) | NomCat | Categorías de empleados |
| [NomCmc.md](NomCmc.md) | NomCmc | Centros de costo de nómina |
| [NomCno.md](NomCno.md) | NomCno | Conceptos / Ciclos de nómina |
| [NomNac.md](NomNac.md) | NomNac | Nacionalidades |
| [NomUbi.md](NomUbi.md) | NomUbi | Ubicaciones |
| [NomPro.md](NomPro.md) | NomPro | Provincias |
| [NomTno.md](NomTno.md) | NomTno | Tipos de nómina |
| [NomCip.md](NomCip.md) | NomCip | Comprobantes individuales de pago |
| [NomCui.md](NomCui.md) | NomCui | Códigos únicos de identificación |
| [NomNgeh.md](NomNgeh.md) | NomNgeh | Histórico de movimientos de nómina |
| [NomAecd.md](NomAecd.md) | NomAecd | Anticipos / Deducciones |
| [NomHord.md](NomHord.md) | NomHord | Horas ordinarias detalle |
| [NomExtd.md](NomExtd.md) | NomExtd | Horas extras detalle |
| [NomCse.md](NomCse.md) | NomCse | Cambios de sueldo / historial |

### Módulo SEG — Seguridad / Tablas Generales
| Archivo | Tabla | Descripción |
|---------|-------|-------------|
| [SegFec.md](SegFec.md) | SegFec | Tabla de fechas (calendario) |
| [SegCep.md](SegCep.md) | SegCep | Control de ejecución de programas |
| [SegNcf.md](SegNcf.md) | SegNcf | Numeración correlativa fiscal |
| [SegPrv.md](SegPrv.md) | SegPrv | Proveedores de seguridad |
| [SegReg.md](SegReg.md) | SegReg | Registro de seguridad |

### Módulo COG — Contabilidad
| Archivo | Tabla | Descripción |
|---------|-------|-------------|
| [CogCco.md](CogCco.md) | CogCco | Centros de costo contables |
| [CogCta.md](CogCta.md) | CogCta | Plan de cuentas contables |

### Módulo INV — Inventario
| Archivo | Tabla | Descripción |
|---------|-------|-------------|
| [InvArt.md](InvArt.md) | InvArt | Artículos / Inventario maestro |
| [InvPar.md](InvPar.md) | InvPar | Parámetros de inventario |

---
> Agregar nuevas tablas siguiendo el template en [_TEMPLATE.md](_TEMPLATE.md)
