class vagonesPasajeros {
	const property largo
	const property ancho
	const property tieneBanios
	var estaOrdenado = false
	
	method cantPasajeros(){
		var cant = 0
		if (ancho <= 3)
			return cant = largo*8
		else return cant = largo*10
		if (!estaOrdenado)
			return cant -=15
	}
	
	method cargaMaxima(){
		if (tieneBanios)
			return 300
		else return 800
	}
	
	method peso() = 2000 + (80*self.cantPasajeros()) + self.cargaMaxima()
	
	method hacerMantenimiento(){
		estaOrdenado = true	
	}
}

class vagonesCarga{
	const property cargaIdeal
	var property maderaSuelta = 0
	method tieneBanios() = false
	method cantPasajeros = 0
	
	method cargaMaxima() = cargaIdeal - (maderaSuelta*400)
	
	
	method peso() = 1500 + self.capacidad()
	
	method hacerMantenimiento(){
		if (maderaSuelta == 5) maderaSuelta = 3
		else if (maderaSuelta == 1) maderaSuelta = 0
		else maderaSuelta = 0
	} 
}

class vagonesDormitorio {
	const property compartimentos
	const property camasPorCompartimento
	
	method cantPasajeros() = compartimentos * camasPorCompartimento
	
	method tieneBanios() = true
	method cargaMaxima() = 1200
	
	method peso()= 4000 +(self.cantPasajeros()*80) + self.cargaMaxima()
	method hacerMantenimiento(){}
}

class formacion {
	var lista = []
	
	method cantPasajeros(){
		return lista.sum( {vagon => vagon.cantPasajeros()} )
	}
	
	method vagonesPopulares(){
		return lista.filter( {vagon => vagon.cantPasajeros > 50} )
	}
	
	method esFormacionCarguera(){
		return lista.all( {vagon => vagon.cargaMaxima() >= 1000} )
	}
	
	method dispersionDePeso(){
		return lista.max({ vagon => vagon.peso()}).peso() - lista.min({ vagon => vagon.peso()}).peso()
	}
	
	method cantBanios(){
		var contador = 0
		lista.forEach( {vagon => if (vagon.tieneBanios() == 1) contador += 1} )
		return contador
	}
	
	method realizarMantenimiento(){
		lista.forEach( {vagon => vagon.hacerMantenimiento()} )
	}
	
	method elQueMenosLleva(){return lista.min( {vagon => vagon.cantPasajeros()})}
	method elQueMasLleva(){return lista.max( {vagon => vagon.cantPasajeros()})}
	
	method estaEquilibrada(){
		if (self.elQueMenosLleva()-self.elQueMasLleva() <= 20) return true
		else return false
	}
	
	method formacionOrdenada(){lista.sortedBy( {vagon1, vagon2 => vagon1.cantPasajeros()>vagon2.cantPasajeros()} )}
	
	method estaOrganizada(){
		if (lista != self.formacionOrdenada()) return false
		else return true
	} 
	
	method velocidadMax(){
		return lista.min( {locomotora => locomotora.velocidadMax()} )
	}
	
	method esEficiente(){
		return lista.all( {locomotora => locomotora.esEficiente()} )
	}
	
	method fuerza() {return lista.sum( {locomotora => locomotora.fuerza} )}
	method peso() {return lista.sum( {locomotora, vagon => locomotora.peso() + vagon.peso()}) }
	method puedeMoverse() = self.fuerza() >= self.peso()
	
	method fuerzaFaltante(){
		if (self.puedeMoverse()) return 0
		else return self.peso() - self.fuerza()
	}
}

class locomotora {
	var property peso
	var property fuerza
	var property velocidadMax
	
	method esEficiente() = fuerza*5 >= peso
}