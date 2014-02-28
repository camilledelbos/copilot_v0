bascule sur nouveau repo


Obj.:
1. définir le nom d'un voyage
2. choisir les lieux de destination
3. définir une durée pour chaque destination
4. ordonner les destinations selon les souhaits utilisateurs
5. bouton "Auto" ordonner les pays selon "l'algo" 
=> tenir compte de la distance d'un pays à l'autre (distance la plus courte n'est pas forcément à retenir),
=> tenir compte de la note climat
6. 

Back

git ci -m "delete LonLatMigration, CountryCityMigration" 

X1. générer un controller, vue et modèle Travel

X2. générer un controller, vue et modèle Route

X3. générer un modèle Stage comprenant des stopoff

4. générer du modèle Country : model Country country_code:string capital:string surface_area:integer geo_zone:string pop_count:integer pop_density:integer   

générer modelè Continent: rails generate model Continent continent_code:string continent_name:string                                                                                        ✓ Projet_web/rails-geoloc • r •
  
  générer Main City : rails generate model MainCity city:string                                                                                                                         ✓ Projet_web/rails-geoloc • r •
   

5. generer un modèle Climate

6. générer un modèle Geocode 
 




1. création de nouvelles tables 
	- Voyages
	- itineraires
	- villes
	- pays
	- climat
	- geocode

2.




Front
1. suppression de Gmap4rails

2. ajout de leaflet