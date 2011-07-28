		var peter = <%= (Fish.find current_user.fish_id).lvl-4 %>;
		var peter2 = <%= (Fish.find current_user.fish_id).lvl + 12  %>;
		
		function inc(i) {
			if(peter > used()) {
				ob = document.getElementById("points[" + i + "]");
				ob.value = parseInt(ob.value) + 1;
			} 
			getAnz()
		}
		function incA(i) {
			if(peter2 > usedA()) {
				ob = document.getElementById("points[" + i + "]");
				ob.value = parseInt(ob.value) + 1;
			} 
			getAnzA()
		}
	
		function dec(i) {
			ob = document.getElementById("points[" + i + "]");
			if (parseInt(ob.value) != 0) {
				ob.value = parseInt(ob.value) - 1;
			}
			getAnz()
		}
		
		function decA(i) {
			
			ob = document.getElementById("points[" + i + "]");
			if (parseInt(ob.value) != 0) {
				if(i == "Str") {
					if(parseInt(ob.value) > <%= @attr[:str] %> ) {
						ob.value = parseInt(ob.value) - 1;
					}
				} else if(i == "Con") {
					if(parseInt(ob.value) > <%= @attr[:con] %> ) {
						ob.value = parseInt(ob.value) - 1;
					}
				} else if(i == "Dev") {
					if(parseInt(ob.value) > <%= @attr[:dev] %> ) {
						ob.value = parseInt(ob.value) - 1;
					}
				} else if(i == "Init") {
					if(parseInt(ob.value) > <%= @attr[:init] %> ) {
						ob.value = parseInt(ob.value) - 1;
					}
				} else if(i == "Dex") {
					if(parseInt(ob.value) > <%= @attr[:dex] %> ) {
						ob.value = parseInt(ob.value) - 1;
					}
				}
			}
			getAnzA()
		}
	
		function used() {
			ob = document.forms[0].elements;
			var summ = 0;
			for (var i = 0; i < ob.length; i++) {
				if(ob[i].type == "text" && ob[i].name != "points[Str]" && ob[i].name != "points[Dev]" && ob[i].name != "points[Con]" && ob[i].name != "points[Init]" && ob[i].name != "points[Dex]" && ob[i].name != "name") {
					summ += parseInt(ob[i].value);
				}
			}
			return summ ;
		}
		
		function usedA() {
			ob = document.forms[0].elements;
			var summ = 0;
			for (var i = 0; i < ob.length; i++) {
				if(ob[i].type == "text") {
					if(ob[i].name == "points[Str]" || ob[i].name == "points[Dev]" || ob[i].name == "points[Con]" || ob[i].name == "points[Init]" || ob[i].name == "points[Dex]") {
						summ += parseInt(ob[i].value);
					}
				}
			}
			return summ ;
		}
		
		function getAnz() {
			var tmp = peter - used();
			if(tmp <= 0) {
				document.getElementById("Anzahl2").innerHTML = "0";
			} else {
				document.getElementById("Anzahl2").innerHTML = tmp;
			}
		}
		
		function getAnzA() {
			var tmp = peter2 - usedA();
			if(tmp < 0) {
				document.getElementById("Anzahl1").innerHTML = "0";
			} else {
				document.getElementById("Anzahl1").innerHTML = tmp;
			}
		}
