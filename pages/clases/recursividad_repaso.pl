% Ciudades
% distancia(origen,destino,kilometros).
distancia(buenosAires, puertoMadryn, 1300).
distancia(puertoMadryn, puertoDeseado, 732).
distancia(puertoDeseado, rioGallegos, 736).
distancia(puertoDeseado, calafate, 979).
distancia(rioGallegos, calafate, 304).
distancia(calafate, chalten, 213).

% Si digo que desde Rio gallegos a Puerto Santa Cruz tenemos la misma distancia que a Chaltén
distancia(calafate, puertoSantaCruz, Distancia):-distancia(calafate, chalten, Distancia).

% Una ciudad lejana es la que está a mas de 735 kms de cualquier otra ciudad
% Buenos Aires y Puerto Deseado son ciudades lejanas
ciudad(Ciudad):-distancia(Ciudad, _, _).

ciudadLejana1(Ciudad):-
  ciudad(Ciudad),  % necesito el predicado generador para Ciudad, porque yo quiero que para toda distancia...
  forall(distancia(Ciudad, _, Distancia), Distancia > 735).

% Otra variante
ciudadLejana2(Ciudad):-
  ciudad(Ciudad),  % necesito el predicado generador porque de lo contrario falla cuando encuentra la primera ciudad con menos de 735 kms
  not((distancia(Ciudad, _, Distancia), Distancia =< 735)).

% Cuál NO va
ciudadLejana3(Ciudad):-
  ciudad(Ciudad),
  findall(OtraCiudad, (distancia(Ciudad, OtraCiudad, Distancia), Distancia =< 735), OtrasCiudades),
  OtrasCiudades = [].
  % 1. al pedo el matching con OtrasCiudades, en todo caso es  findall(OtraCiudad, distancia(Ciudad, OtraCiudad, Distancia), []), pero lo peor es
  % 2. para qué obtener la lista? La regla lógica tiene mucho más que ver con el paradigma que contar la cantidad de ciudades

