# You Make a Game

# Its a chalenge to create a game in ruby, diferent the first created. But we need to use class, method and module.

# I will use the game maded in other class like a base, but i want to make a different history and different paths. 
# Like in salvador we can go to feira de santana, barimbau by car and ilheus, porto seguro by ship.
# I want to make a treasure hunt the hero will start in salvador and can choice different path to find the treasure
# I want to make the hero equip different things that can help him to find the treasure
# Like the hero rent a car but this spend money, he can earn money working in some places that he can find inside the city.
# In the history the path is not important, but the main path is perfect to solve all puzzles quickly
# But the hero can choice travel and return to different cities, working in different places and earn money with this.
# Some works in the path will be trapped for the hero, this way i hope that the hero learn to make better choices
# Move to another city spend money and energy, the hero have to charge your energy in a hotel, this needs to spend money.
# The treasure is hidden inside a home that the hero need to buy, each city have a home to buy, but randomly will but hidden in some house
# NPC that the hero can talk will help the hero in this path, but some NPC will give to the hero not so good advertisements.
# The challenge of this game is the hero choice the better jobs and the better advertising about your jorney. 
# If the money and the energy of the hero over, the hero die.
# If the hero falls in a trap he dies.
# The city that the hero choice is the only place that can recharge the energy without spend money. Each city have different values to sleep and travel.
# And some cities is impossible go to another city without pass throght a middle point city. Like is impossible go feira de santana -> eunapolis without pass
# throught ilheus, and is impossible go directly from ilheus -> porto seguro without pass throught eunapolis. This is only throught by car transport
# using a ship is only possible access cities that have a sea. The target of the game is move different cities and find the treasure.

class Scene
    def enter()
        puts "This scene is not yet configured. Subclass it and implement enter()."
        exit(1)
    end
end

class Engine
    def initialize(scene_map)
        @scene_map = scene_map
    end

    def play()
        current_scene = @scene_map.opening_scene()
        last_scene = @scene_map.next_scene('finished')

        while current_scene != last_scene
            next_scene_name = current_scene.enter()
            current_scene = @scene_map.next_scene(next_scene_name)
        end

        current_scene.enter()
    end
end

class Death < Scene
    @@quips = [
        "You died. You kinda suck at this.",
        "Yout mom would be pround.. if she were smarter.",
        "Suck a luser.",
        "A have a small puppy that's better at this."
    ]

    def enter()
        puts @@quips[rand(0..(@@quips.length - 1))]
        exit(1)
    end
end

class CentralCorridor < Scene
    def enter()
        puts "The Gothons of Planet Percal #25 have invaded your ship and destroyed"
        puts "yout entire crew. You are the last surviving member and your last"
        puts "mission is to get the neutron destruct bomb from the Weapons Armory,"
        puts "put it in the bridge , and blow the ship up after getting into an"
        puts "escape pod."
        puts "\n"
        puts "You're running down the central corridor to the Weapons Armory when"
        puts "a Gothon jumps out, red scaly skin, dark grimy teeth, evil clown costume"
        puts "flowing around his hate filled body. He's blocking the door to the"
        puts "Armory and about to pull a weapon to blast you."
        print "> "
        
        action = $stdin.gets.chomp

        if action == "shoot!"
            puts "Quick on the draw you yank out your blaster and fire it at the Gothon."
            puts "His clown costume is flowing and moving around his body, which throws"
            puts "off your aim.  Your laser hits his costume but misses him entirely.  This"
            puts "completely ruins his brand new costume his mother bought him, which"
            puts "makes him fly into an insane rage and blast you repeatedly in the face until"
            puts "you are dead.  Then he eats you."
            return 'death'
        elsif action == "dodge!" 
            puts "Like a world class boxer you dodge, weave, slip and slide right"
            puts "as the Gothon's blaster cranks a laser past your head."
            puts "In the middle of your artful dodge your foot slips and you"
            puts "bang your head on the metal wall and pass out."
            puts "You wake up shortly after only to die as the Gothon stomps on"
            puts "your head and eats you."
            return 'death'
        elsif action == "tell a joke"
            puts "Lucky for you they made you learn Gothon insults in the academy."
            puts "You tell the one Gothon joke you know:"
            puts "Lbhe zbgure vf fb sng, jura fur fvgf nebhaq gur ubhfr, fur fvgf nebhaq gur ubhfr."
            puts "The Gothon stops, tries not to laugh, then busts out laughing and can't move."
            puts "While he's laughing you run up and shoot him square in the head"
            puts "putting him down, then jump through the Weapon Armory door."
            return 'laser_weapon_armory'
        else 
            puts "DOES NOT COMPUTE!"
            return 'central_corridor'
        end
    end
end

class LaserWeaponArmory < Scene
    def enter()
        puts "You do a dive roll into the Weapon Armory, crouch and scan the room"
        puts "for more Gothons that might be hiding.  It's dead quiet, too quiet."
        puts "You stand up and run to the far side of the room and find the"
        puts "neutron bomb in its container.  There's a keypad lock on the box"
        puts "and you need the code to get the bomb out.  If you get the code"
        puts "wrong 10 times then the lock closes forever and you can't"
        puts "get the bomb.  The code is 3 digits."
        
        code = "#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}"
        
        # Code Cheat
        puts "The code is #{code}"
        
        print "[keypad]>"
        
        guess = $stdin.gets.chomp
        guesses = 0

        while guess != code && guesses < 10
            puts "BZZZZEDDD!"
            guesses += 1
            print "[keypad]>"
            guess = $stdin.gets.chomp
        end

        if guess == code
            puts "The container clicks open and the seal breaks, letting gas out."
            puts "You grab the neutron bomb and run as fast as you can to the"
            puts "bridge where you must place it in the right spot."
            return 'the_bridge'
        else
            puts "The lock buzzes one last time and then you hear a sickening"
            puts "melting sound as the mechanism is fused together."
            puts "You decide to sit there, and finally the Gothons blow up the"
            puts "ship from their ship and you die."
            return 'death'
        end
    end
end

class TheBridge < Scene
    def enter()
        puts "You burst onto the Bridge with the netron destruct bomb"
        puts "under your arm and surprise 5 Gothons who are trying to"
        puts "take control of the ship.  Each of them has an even uglier"
        puts "clown costume than the last.  They haven't pulled their"
        puts "weapons out yet, as they see the active bomb under your"
        puts "arm and don't want to set it off."
        print "> "

        action = $stdin.gets.chomp

        if action == "throw the bomb"
            puts "In a panic you throw the bomb at the group of Gothons"
            puts "and make a leap for the door.  Right as you drop it a"
            puts "Gothon shoots you right in the back killing you."
            puts "As you die you see another Gothon frantically try to disarm"
            puts "the bomb. You die knowing they will probably blow up when"
            puts "it goes off."
            return 'death'
        elsif action == "slowly place the bomb"
            puts "You point your blaster at the bomb under your arm"
            puts "and the Gothons put their hands up and start to sweat."
            puts "You inch backward to the door, open it, and then carefully"
            puts "place the bomb on the floor, pointing your blaster at it."
            puts "You then jump back through the door, punch the close button"
            puts "and blast the lock so the Gothons can't get out."
            puts "Now that the bomb is placed you run to the escape pod to"
            puts "get off this tin can."
            return "escape_pod"
        else
            puts "DOES NOT COMPUTE"
            return "the_bridge"
        end
    end
end

class EscapePod < Scene
    def enter()
        puts "You rush through the ship desperately trying to make it to"
        puts "the escape pod before the whole ship explodes.  It seems like"
        puts "hardly any Gothons are on the ship, so your run is clear of"
        puts "interference.  You get to the chamber with the escape pods, and"
        puts "now need to pick one to take.  Some of them could be damaged"
        puts "but you don't have time to look.  There's 5 pods, which one"
        puts "do you take?"

        good_pod = rand(1..5)
        # Pod cheat
        puts "The good_pod number is #{good_pod}"
        
        print "[pod#]> "
        guess = $stdin.gets.chomp.to_i

        if guess != good_pod
            puts "You jump into pod %s and hit the eject button." % guess
            puts "The pod escapes out into the void of space, then"
            puts "implodes as the hull ruptures, crushing your body"
            puts "into jam jelly."
            return 'death'
        else
            puts "You jump into pod %s and hit the eject button." % guess
            puts "The pod easily slides out into space heading to"
            puts "the planet below.  As it flies to the planet, you look"
            puts "back and see your ship implode then explode like a"
            puts "bright star, taking out the Gothon ship at the same"
            puts "time.  You won!"
            return 'finished'
        end
    end
end

class Finished < Scene
    def enter()
        puts "You won! Good job."
    end
end

class Map
    @@scenes = {
        'salvador' => Salvador.new(),
        'feira_de_santana' => FeiraDeSantana.new(),
        'berimbau' => Berimbau.new(),
        'ilheus' => Ilheus.new(),
        'porto_seguro' => PortoSeguro.new(),
        'death' => Death.new(),
        'finished' => Finished.new()
    }

    def initialize(start_scene)
        @start_scene = start_scene
    end

    def next_scene(scene_name)
        val = @@scenes[scene_name]
        return val
    end

    def opening_scene()
        return next_scene(@start_scene)
    end
end

a_map = Map.new('central_corridor')
a_game = Engine.new(a_map)
a_game.play()

