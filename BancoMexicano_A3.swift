import Foundation

// Estado de la cuenta del usuario
var saldo: Double = 0.0
var primerIngresoRetiro: Bool = true
var continuarPrograma: Bool = true

func mostrarMenu() {
    print("Banco Mexicano")
    print("1. Deposito")
    print("2. Retiro")
    print("3. Saldo")
    print("4. Salir")
    print("Elige el numero de la opcion: ", terminator: "")
}

func leerTexto() -> String {
    return (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
}

func preguntarOtraOperacion() -> Bool {
    while true {
        print("Desea continuar con otra operacion s/S n/N: ", terminator: "")
        let respuesta = leerTexto().lowercased()
        if respuesta == "s" {
            return true
        } else if respuesta == "n" {
            return false
        } else {
            print("Opcion no valida. Escribe 's' para si o 'n' para no.")
        }
    }
}

func procesarDeposito() {
    print("Ingresa la cantidad a depositar: ", terminator: "")
    if let monto = Double(leerTexto()), monto > 0 {
        saldo += monto
        print("Deposito realizado. Nuevo saldo: \(saldo) pesos")
    } else {
        print("Cantidad no valida.")
    }
}

func procesarRetiro() {
    if primerIngresoRetiro && saldo <= 0 {
        print("No cuentas con saldo disponible en tu cuenta.")
        primerIngresoRetiro = false
    } else {
        primerIngresoRetiro = false
        var repetirRetiro = true
        while repetirRetiro {
            if saldo <= 0 {
                print("No cuentas con saldo disponible para realizar un retiro.")
            } else {
                print("Ingresa la cantidad a retirar: ", terminator: "")
                if let montoRetiro = Double(leerTexto()), montoRetiro > 0 {
                    if montoRetiro <= saldo {
                        saldo -= montoRetiro
                        print("Retiro exitoso. Saldo actual: \(saldo) pesos")
                    } else {
                        print("No cuentas con el saldo tecleado.")
                    }
                } else {
                    print("Cantidad no valida.")
                }
            }

            while true {
                print("Desea realizar otro retiro? s/S n/N: ", terminator: "")
                let respRetiro = leerTexto().lowercased()
                if respRetiro == "s" {
                    repetirRetiro = true
                    break
                } else if respRetiro == "n" {
                    repetirRetiro = false
                    break
                } else {
                    print("Opcion no valida. Escribe 's' o 'n'.")
                }
            }
        }
    }

    continuarPrograma = preguntarOtraOperacion()
    if !continuarPrograma {
        print("Cerrando sesion de cuenta, vuelva pronto...")
    }
}

func procesarSaldo() {
    let saldoFormateado = saldo.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(saldo)) : String(saldo)
    print("Tienes un saldo de :\(saldoFormateado) pesos")
    continuarPrograma = preguntarOtraOperacion()
    if !continuarPrograma {
        print("Cerrando sesion de cuenta, vuelva pronto...")
    }
}

// Bucle principal de la aplicación
while continuarPrograma {
    mostrarMenu()
    let opcion = leerTexto()

    switch opcion {
    case "1":
        procesarDeposito()
    case "2":
        procesarRetiro()
    case "3":
        procesarSaldo()
    case "4":
        print("Cerrando sesion de cuenta, vuelva pronto...")
        continuarPrograma = false
    default:
        print("Opcion invalida, intenta de nuevo.")
    }
}