# Parent 1  
#   Cou : long
#   Pattes : courtes
#   => adaptation : moyenne

# Parent 2
#   Cou : court
#   Pattes : longues
#   => adaptation : moyenne

# Fils 1  
#   Cou : court
#   Pattes : courtes
#   => adaptation : mauvaise

# Fils 2  
#  Cou : court
#  Pattes : longues
#  => adaptation : moyenne

# Fils 3
#   Cou : long
#   Pattes : longues
#  => adaptation : bonne


# Il s'agit de résoudre un problème d'optimisation d'une combinaison de paramètres dépendants les uns des autres. Ces paramètres peuvent prendre plusieurs valeurs prédéfinies, de la même manière que des gènes peuvent prendre plusieurs expressions (pattes longues ou pattes courtes, par exemple). Une solution particulière au problème (une solution approchée) est représentée par l'ensemble des valeurs prises pour chaque paramètre, qui constitue en quelque sorte l'ADN de cette solution.

# Quant à l'adaptation à l'environnement, elle est représentée par une évaluation chiffrée indiquant la pertinence de la solution.
# Par exemple pour le PVC : un individu est un trajet, son évaluation est la longueur totale de ce trajet, un gène est la ville où l'on passe à une certaine position dans le parcours, et l'ADN est la liste des villes dans l'ordre du parcours.

# Parmi un ensemble de solutions approchées (la population), on sélectionne alors deux bonnes solutions et on les recombine pour en produire une nouvelle.
# D'autre part, on élimine les solutions les moins adaptées.
# En répétant ce processus, l'adaptation de la population augmente, et donc on converge vers la solution du problème.
# Il s'agit bien sûr d'une adaptation informatique, il ne faut pas chercher une similitude plus poussée avec les "lois de la nature". Entre autres parce dans la nature, le cerveau joue un grand rôle, et que l'environnement est changeant. Donc une solution moyenne mais adaptable à plusieurs environnements est plus intéressante qu'une solution très adaptée à un environnement particulier.

# De manière plus formelle, voici un algorithme génétique de base :

# Pour chaque Individu dans Groupe
#         Initialiser Individu
# FinPour
# Pour nombre_d'itérations
#         Parent A = Sélection_d'un_Individu (Groupe)
#         Parent B = Sélection_d'un_Individu (Groupe)
#         Fils =  Recombinaison (Parent A, Parent B)
#         Si hasard > pourcentage Alors
#                 Appliquer_une_mutation_à Fils
#         FinSi
#         Optimiser Fils  // Optionnel
#         Evaluer Fils
#         Si Fils est_accepté_dans Groupe Alors
#                 Réinsérer Fils dans Groupe
#         FinSi
# FinPour
# Il existe énomément de variantes et de paramétrages qui affectent grandement les résultats.


# # Pour chaque Individu dans Groupe
# #         Initialiser Individu
# stages = stages.all
# from_stage = initial_stage
# other_stage = stages-initial_stage
# # FinPour

# # Pour nombre_d'itérations
# Sélection
        # au hasard
        # préférer les individus avec une meilleur évaluation (stratégie élitiste)
        # toujours choisir le meilleur individu comme premier parent et un autre individu au hasard comme deuxième parent (variante de la stratégie élitiste)
        # sélectionner les deux parents selon un critère de proximité dans la liste des individus
#     Parent A = Sélection_d'un_Individu (Groupe)
#     Parent B = Sélection_d'un_Individu (Groupe)
#     Fils =  Recombinaison (Parent A, Parent B)
class GeneticSearch

      attr_accessor :population


      def initialize(initial_population_size, generations)
        @population_size = initial_population_size
        @max_generation = generations
        @generation = 0
      end

      #     1. Choose initial population
      #     2. Evaluate the fitness of each individual in the population
      #     3. Repeat
      #           1. Select best-ranking individuals to reproduce
      #           2. Breed new generation through crossover and mutation (genetic operations) and give birth to offspring
      #           3. Evaluate the individual fitnesses of the offspring
      #           4. Replace worst ranked part of population with offspring
      #     4. Until termination    
      #     5. Return the best chromosome

      def run
        generate_initial_population                    #Generate initial population 
        @max_generation.times do
          selected_to_breed = selection                #Evaluates current population 
          offsprings = reproduction selected_to_breed  #Generate the population for this new generation
          replace_worst_ranked offsprings
        end
        return best_chromosome
        puts @best_chromosomes_archive
      end

      def generate_initial_population
       @population = []
       @population_size.times do
         population << Chromosome.seed
       end
      end

# Select best-ranking individuals to reproduce
# 
# Selection is the stage of a genetic algorithm in which individual 
# genomes are chosen from a population for later breeding. 
# There are several generic selection algorithms, such as 
# tournament selection and roulette wheel selection. We implemented the
# latest.
# 
# Steps:
# 
# 1. The fitness function is evaluated for each individual, providing fitness values
# 2. The population is sorted by descending fitness values.
# 3. The fitness values ar then normalized. (Highest fitness gets 1, lowest fitness gets 0). The normalized value is stored in the "normalized_fitness" attribute of the chromosomes.
# 4. A random number R is chosen. R is between 0 and the accumulated normalized value (all the normalized fitness values added togheter).
# 5. The selected individual is the first one whose accumulated normalized value (its is normalized value plus the normalized values of the chromosomes prior it) greater than R.
# 6. We repeat steps 4 and 5, 2/3 times the population size.

 def selection
        @population.sort! { |a, b| b.fitness_notation <=> a.fitness_notation}
        #@population.sort! { |a, b| [b.fitness_notation, b.fitness_distance] <=> [a.fitness_notation, a.fitness_distance]}

        #nom_du_tableau.sort{|x,y| [x.attribut_pour_trier, x.attribut_pour_trier_cas_egalite] <=> [y.attribut_pour_trier, y.attribut_pour_trier_cas_egalite]}
        best_fitness_notation = @population[0].fitness_notation
        worst_fitness_notation = @population.last.fitness_notation
        acum_fitness = 0
        if best_fitness_notation-worst_fitness_notation > 0
        @population.each do |chromosome| 
          chromosome.normalized_fitness = (chromosome.fitness_notation - worst_fitness_notation)/(best_fitness_notation-worst_fitness)
          acum_fitness += chromosome.normalized_fitness
        end
        else
          @population.each { |chromosome| chromosome.normalized_fitness = 1}  
        end
        selected_to_breed = []
        ((2*@population_size)/3).times do 
          selected_to_breed << select_random_individual(acum_fitness)
        end
        selected_to_breed
      end


# We combine each pair of selected chromosome using the method 
# Chromosome.reproduce
#
# The reproduction will also call the Chromosome.mutate method with 
# each member of the population. You should implement Chromosome.mutate
# to only change (mutate) randomly. E.g. You could effectivly change the
# chromosome only if 
#     rand < ((1 - chromosome.normalized_fitness) * 0.4)
      def reproduction(selected_to_breed)
        offsprings = []
    #???
        0.upto(selected_to_breed.length/2-1) do |i|
          offsprings << Chromosome.reproduce(selected_to_breed[2*i], selected_to_breed[2*i+1])
        end
        @best_chromosomes_archive = []
        @best_chromosomes_archive << @population[0]
        @population.each do |individual|
          Chromosome.mutate(individual)
        end
        return offsprings
      end

      # Replace worst ranked part of population with offspring
      def replace_worst_ranked(offsprings)
        size = offsprings.length
        # La nouvelle génération remplace l'ancienne génération (sauf le meilleur individu de l'ancienne génération)
        @population = @population [0..((-1*size)-1)] + offsprings
      end

      # Select the best chromosome in the population
      def best_chromosome
        the_best = @population[0]
        @population.each do |chromosome|
          the_best = chromosome if chromosome.fitness > the_best.fitness
        end
        return the_best
      end

      private 
      def select_random_individual(acum_fitness)
        select_random_target = acum_fitness * rand
        local_acum = 0
        @population.each do |chromosome|
          local_acum += chromosome.normalized_fitness
          return chromosome if local_acum >= select_random_target
        end
      end

    end



    # A Chromosome is a representation of an individual solution for a specific 
    # problem. You will have to redifine the Chromosome representation for each
    # particular problem, along with its fitness, mutate, reproduce, and seed 
    # methods.
    class Chromosome

      attr_accessor :meteo_path
      attr_accessor :normalized_fitness

      def initialize(meteo_path)
        @meteo_path = meteo_path
      end

# The fitness method quantifies the optimality of a solution 
      # (that is, a chromosome) in a genetic algorithm so that that particular 
      # chromosome may be ranked against all the other chromosomes. 
      # 
      # Optimal chromosomes, or at least chromosomes which are more optimal, 
      # are allowed to breed and mix their datasets by any of several techniques, 
      # producing a new generation that will (hopefully) be even better.
      def fitness_notation
        return @fitness_notation if @fitness_notation
        global_notation = 0
        @meteo_path[1..-1].each do |notation_by_address|
          global_notation += notation_by_address
        end
        @fitness_notation = global_notation
        return @fitness_notation
      end


# mutation method is used to maintain genetic diversity from one 
# generation of a population of chromosomes to the next. It is analogous 
# to biological mutation. 
# 
# The purpose of mutation in GAs is to allow the 
# algorithm to avoid local minima by preventing the population of 
# chromosomes from becoming too similar to each other, thus slowing or even 
# stopping evolution.
# 
# Calling the mutate function will "probably" slightly change a chromosome
# randomly. 
#
# This implementation of "mutation" will (probably) reverse the 
# order of 2 consecutive randome nodes 
# (e.g. from [ 0, 1, 2, 4] to [0, 2, 1, 4]) if:
#     ((1 - chromosome.normalized_fitness) * 0.4)
      def self.mutate(chromosome)
        if chromosome.normalized_fitness && rand < ((1 - chromosome.normalized_fitness) * 0.3)
          data = chromosome.data
          index = rand(data.length-1)
          data[index], data[index+1] = data[index+1], data[index]
          chromosome.data = data
          @fitness_notation = nil
        end
      end

  # Reproduction method is used to combine two chromosomes (solutions) into 
  # a single new chromosome. There are several ways to
  # combine two chromosomes: One-point crossover, Two-point crossover,
  # "Cut and splice", edge recombination, and more. 
  # 
  # The method is usually dependant of the problem domain.
  # In this case, we have implemented edge recombination, wich is the 
  # most used reproduction algorithm for the Travelling salesman problem.
      def self.reproduce(a, b)
        # indique le nombre de destinations
        stages_count = @meteo_path.length
        available_stages = []
        #de l'index 1 (index 0 étant point de départ) -> dernier index
        1.upto(stages_count-1) { |n| available << n }
        token = a.data[0]
        
def recombinaison
    random = rand(0..other_stage.count)
    fils1 = parent1[0..random]
    fils2 = parent2[random+1..other_stage.count]+parent2[0..random]
    fils.push(fils1.concat(fils2).uniq)
  end 
  if population.include?(fils) 
    recombinaison
  else
    population.push(inceste)
  end





        token = a.data[0]
        spawn = [token]
        available.delete(token)
        while available.length > 0 do 
          #Select next
          if token != b.data.last && available.include?(b.data[b.data.index(token)+1])
            next_token = b.data[b.data.index(token)+1]
          elsif token != a.data.last && available.include?(a.data[a.data.index(token)+1])
            next_token = a.data[a.data.index(token)+1] 
          else
            next_token = available[rand(available.length)]
          end
          #Add to spawn
          token = next_token
          available.delete(token)
          spawn << next_token
          a, b = b, a if rand < 0.4
        end
        return Chromosome.new(spawn)
      end

      # Initializes an individual solution (chromosome) for the initial 
      # population. Usually the chromosome is generated randomly, but you can 
      # use some problem domain knowledge, to generate a 
      # (probably) better initial solution.
      def self.seed
        # !! a "stops" si retour au même point que point de départ, alors déduire 2 au lien de 1 (lieu de départ)
        stops = @travel.stages.count-1
        available_stages = []
        1.upto(stops) { |n| available_stages << n }
        seed = []
        while available_stages.length > 0 do 
          index = rand(available_stages.length)
          seed << available_stages.delete_at(index)
        end
        return Chromosome.new(seed)
      end

      def self.set_note_matrix(climat_notation)
        @@costs = costs
      end
  end








def selection
  parent1 = chemin_optimal
  parent2 = chemin_optimal.shuffle
end

def initialize(population)
    @population = population
end

def recombinaison





def population
  population = []
  population << chemin_optimal

  if chemin_optimal.count <= 4
    chemin_optimal.count.each {|n| n * recombination}
  else
    recombination * 30
  end
end

  fils = []
  def recombinaison
    random = rand(0..other_stage.count)
    fils1 = parent1[0..random]
    fils2 = parent2[random+1..other_stage.count]+parent2[0..random]
    fils.push(fils1.concat(fils2).uniq)
  end 
  if population.include?(fils) 
    recombinaison
  else
    population.push(inceste)
  end





def mutation
end

def optimisation
#   Le principe est le suivant :

# On génére un trajet initial aléatoirement (ou par une autre méthode).
# On applique à ce trajet une transformation simple (la plus simple possible).
# Si la transformation améliore le trajet, on garde cette transformation, sinon on l'annule.
# Puis on répète l'opération jusqu'à ce que l'on ne puisse plus améliorer le trajet.
# Le mieux est d'effectuer une recherche systématique (par exemple tester toutes les permutations possibles sur un trajet).

# Pour Ville_1 allant de 1 à N
#   Pour Ville_2 allant de Ville_1 + 1 à N
#     Renverser parcours entre Ville_1 et Ville_2
#     Si le renversement raccourcit le trajet Alors on garde le renversement
#     Sinon on ne garde pas le renversement
#   FinPour
# FinPour
end
