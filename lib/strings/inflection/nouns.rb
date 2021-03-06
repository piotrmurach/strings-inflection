# frozen_string_literal: true

module Strings
  module Inflection
    module Nouns
      # Remove suffix from a word
      #
      # @return [Array[String]]
      #   a list of all stems without suffixes
      #
      # @api private
      def self.to_stem(list, suffix)
        list.map { |word| word[0...-suffix.size] }
      end

      @category_o_os = %w[
        albino
        alto
        archipelago
        armadillo
        auto
        basso
        bongo
        banjo
        bolero
        burrito
        burro
        bronco
        canto
        cargo
        casino
        cello
        commando
        congo
        contralto
        crescendo
        ditto
        dynamo
        embryo
        fiasco
        fugato
        generalissimo
        ghetto
        guano
        halo
        jalapeno
        inferno
        jumbo
        kimono
        lingo
        libido
        limo
        logo
        lumbago
        macro
        maestro
        magneto
        mambo
        manifesto
        medico
        metro
        memo
        octavo
        oregano
        photo
        piano
        piccolo
        pinto
        placebo
        pro
        polo
        pomelo
        poncho
        quarto
        rhino
        stylo
        tempo
        solo
        soprano
        silo
        sombrero
        stiletto
        stucco
        taco
        taro
        tobacco
        tomatillo
        tornado
        torso
        tuxedo
        yoyo
        zero
      ]

      @category_ex_ices = to_stem(%w[
        codex
        index
        murex
        silex
        vortex
      ], "ex")

      @category_on_a = to_stem(%w[
        criterion
        phenomenon
      ], "on")

      @category_a_ae = %w[
        alumna
        alga
        antenna
        vertebra
      ]

      @category_um_a = to_stem(%w[
        agendum
        bacterium
        candelabrum
        datum
        desideratum
        erratum
        extremum
        formicarium
        fusarium
        ovum
        stratum
      ], "um")

      @category_ie_ies = %w[
        calorie
        cookie
        beastie
        beanie
        bowtie
        bourgeoisie
        brownie
        doggie
        floozie
        goodie
        lie
        movie
        necktie
        oldie
        pie
        pinkie
        prairie
        ramie
        tie
        zombie
      ]

      @category_us_uses = %w[
        apparatus
        cantus
        coitus
        focus
        fungus
        genius
        hiatus
        impetus
        incubus
        nexus
        nimbus
        nucleolus
        radius
        plexus
        prospectus
        sinus
        status
        stylus
        succubus
        torus
        umbilicus
        uterus
      ]

      @category_man_mans = %w[
        ataman
        caiman
        cayman
        ceriman
        desman
        dolman
        farman
        harman
        hetman
        human
        leman
        ottoman
        shaman
        talisman
      ]

      @category_us_i = to_stem(%w[
        alumnus
        cactus
        fungus
        nucleus
        leptocephalus
        stimulus
      ], "us")

      @category_se_ses = %w[
        apse
        abuse
        anise
        bookcase
        case
        cheese
        close
        creche
        database
        dose
        doe
        disease
        enterprise
        excuse
        expose
        glimpse
        glucose
        grease
        high-rise
        hoe
        hose
        impulse
        initialise
        initialize
        inverse
        merchandise
        mousse
        noise
        nose
        nucleotidase
        paradise
        phase
        phrase
        pickaxe
        porpoise
        pose
        prose
        pulse
        purchase
        purpose
        refuse
        resolve
        reverse
        rise
        rose
        staircase
        suitcase
        sunrise
        surprise
        tortoise
        universe
        use
        vase
        verse
        viscose
        vise
      ]

      @category_ze_zes = %w[
        haze
        kamikaze
        maize
        prize
        size
      ]

      @uncountable = %w[
        acoustics
        adrenalin
        aircraft
        aluminium
        aluminum
        analytics
        anesthesiology
        anime
        applewood
        arthur
        athletics
        bakeware
        barium
        barracks
        barbeque
        bellows
        beyond
        bifocals
        bison
        bloodflow
        bowling
        bream
        breeches
        britches
        cappuccino
        carp
        cash
        catsup
        cattle
        celeriac
        celsius
        chemotaxis
        cod
        coevolution
        collagen
        colorlessness
        commonsense
        cooking
        cooperation
        coordination
        copying
        corporatism
        corps
        counterterrorism
        crystallography
        crayfish
        clothes
        chassis
        chaos
        chem
        chess
        chino
        cilantro
        corps
        contretemps
        clippers
        decrease
        decryption
        deer
        debris
        diabetes
        diagnosis
        dining
        disco
        djinn
        downstairs
        dynamics
        earnings
        eaves
        east
        economics
        ego
        electronics
        elk
        eland
        emery
        ethics
        equipment
        eyestrain
        fahrenheit
        fish
        flounder
        fedelini
        fibrosis
        flesh
        footwear
        fun
        grass
        gallows
        genetics
        garbage
        graffiti
        gigantism
        goldfish
        golf
        gravitas
        gymnastics
        hovercraft
        headquarters
        hydraulics
        herpes
        high-jinks
        homework
        innings
        info
        information
        internet
        jackanapes
        jazz
        jeans
        jellyfish
        judo
        karate
        kendo
        kingfish
        laryngitis
        lieu
        linguistics
        logistics
        lox
        lycra
        mackerel
        mankind
        mathematics
        measles
        melatonin
        mercury
        methane
        molasses
        money
        most
        moose
        multimedia
        mews
        moose
        mosquito
        mumps
        netball
        news
        oasis
        osmosis
        oxygen
        ozone
        paintwork
        pantyhose
        pathogenesis
        pants
        physics
        pincers
        pince-nez
        police
        postgres
        pliers
        proceedings
        politics
        police
        press
        proceedings
        pyridine
        quinoa
        rain
        rabies
        reindeer
        rice
        rhinoceros
        robotics
        rubbish
        rugby
        salmon
        series
        sheep
        shears
        spacecraft
        species
        swine
        scissors
        sea-bass
        seafood
        semantics
        series
        soccer
        software
        soot
        soy
        spaghetti
        spandex
        stamina
        subconscious
        sushi
        suspenders
        sustenance
        sweets
        swordfish
        tech
        tectonics
        tennis
        teriyaki
        thanks
        tights
        thermals
        trousers
        tights
        titanium
        today
        tonight
        tongs
        tomography
        trash
        trout
        trigonometry
        tuna
        twins
        underclothes
        underpants
        upstairs
        vascular
        veal
        venison
        vertigo
        veto
        vitro
        vivo
        volcano
        voting
        warfare
        wasabi
        watercress
        wealth
        whiting
        wildebeest
        wheat
        west
        whey
        woolens
        willingness
        yang
        yoga
        young
        zebrafish
      ]

      @singular_irregular = [
        [/\A(.*[mlftw]ax)es$/i, "\\1"],
        [/\A(.*[k]axe)s$/i, "\\1"],
        [/\A(.*ax)es$/i, "\\1is"],
        [/\A(.*iri)[ds]es$/, "\\1s"],
        [/\A(.*ox)en$/i, "\\1"],
        [/\A(.*child)ren$/i, "\\1"],
        [/\A(.*pe)ople$/i, "\\1rson"],
        [/\A(.*g)eese$/i, "\\1oose"],
        [/\A(.*(mong|cab)oose)s$/i, "\\1"],
        [/\A(.*t)eeth$/i, "\\1ooth"],
        [/\A(.*f)eet$/i, "\\1oot"],
        [/\A(.*geni)(es|i)$/i, "\\1e"],
        [/\A(.*(ga|canva))sses$/i, "\\1s"],
        [/\A(.*di)ce$/i, "\\1e"],
        [/\A(.*pen)ce$/i, "\\1ny"],
        [/\A(.*(append|matr))ices$/i, "\\1ix"],
        [/\A(.*loo)ies$/i, "\\1ey"],
        [/\A(.*(l|m))ice$/i, "\\1ouse"],
        [/\A(.*lanche)s$/, "\\1"],
        [/\A(.*canoe)s$/, "\\1"],
        [/\A(.*[aum]ise)s$/, "\\1"],
        [/\A(.*[u]rse)s$/, "\\1"],
        [/\A(.*(trell|it)is)es$/i, "\\1"],
        [/\A(.*chrysalis)es$/i, "\\1"],
        [/\A(.*cirr)i$/i, "\\1us"],
        [/\A(.*nase)s$/i, "\\1"],
        [/\A(.*(heart|head|moust|must)ache)s$/i, "\\1"],
        [/\A(.*(galoshe|quiche|niche))s$/i, "\\1"],
        [/\A(.*oboe)s$/i, "\\1"],
        [/\A(.*olive)s$/i, "\\1"],
        [/\A(toe)s$/i, "\\1"],
        # ends in -ies
        [/\A(.*#{@category_ie_ies.join("|")})s$/, "\\1"],
        [/\A(.*yrie)s$/, "\\1"],
        # ends in -zes
        [/\A(.*#{@category_ze_zes.join("|")})s$/, "\\1"],
        # ends in -ses
        [/\A(.*#{@category_se_ses.join("|")})s$/, "\\1"],
        [/\A(.*pancreas)es$/, "\\1"],
        [/\A(.*ease)s$/, "\\1"],
        [/\A(.*ipse)s$/, "\\1"],
        [/\A(.*hubris)es$/i, "\\1"],
        [/\A(.*meris)es$/, "\\1"],
        [/\A(.*lens)es$/, "\\1"],
        [/\A(.*nis)es$/i, "\\1"],
        # ends in -man
        [/\A(#{@category_man_mans.join("|")})s$/, "\\1"],
        [/\A(.*m)en$/i, "\\1an"],
        # ends in -i
        [/\A(#{@category_us_i.join("|")})i$/, "\\1us"],
        # ends in -f
        [/\A(.*(tur|thie|loa|hoo|bee))ves$/i, "\\1f"],
        [/\A(.*(roof|belief|chef|chief))s$/i, "\\1"],
      ]

      @singular_rules = [
        [/\A(.+[aeiou])os$/, "\\1o"],
        # ends in -uses
        [/\A(.+[i]as)es$/i, "\\1"],
        [/\A(.+(aus|ous))es$/i, "\\1e"],
        [/\A(.+us)es$/i, "\\1"],
        # ends in -ices, -a, -ae
        [/\A(#{@category_ex_ices.join("|")})ices$/i, "\\1ex"],
        [/\A(#{@category_um_a.join("|")})a$/i, "\\1um"],
        [/\A(#{@category_a_ae.join("|")})e$/i, "\\1"],
        [/\A(.*)a$/i, "\\1on"],
        # ends in -ves
        [/\A(.*[aeo]l)ves$/, "\\1f"],
        [/\A(.*[^d]ea)ves$/, "\\1f"],
        [/\A(.*[nlw]i)ves$/i, "\\1fe"],
        [/\A(.+ar)ves$/i, "\\1f"],
        # ends in -ys
        [/\A(.+[aeiou]y)s$/i, "\\1"],
        # ends in -ches, -shes, -sses, -zes, -xes
        [/\A(.+uzz)es$/i, "\\1"],
        [/\A(.+)zzes$/i, "\\1z"],
        [/\A(.+[en]ze)s$/i, "\\1"],
        [/\A(.+orse)s$/i, "\\1"],
        [/\A(.*r[ct]ise)s$/, "\\1"],
        [/\A(.+[n]s)es$/i, "\\1e"],
        [/\A(.+[^ns]s)es$/i, "\\1is"],
        [/\A(.+(ss|sh|ch|x|z))es$/i, "\\1"],
        # ends in -ies
        [/\A(.+)ies$/i, "\\1y"],
        # ends in -os, -oes
        [/\A(#{@category_o_os.join("|")})s$/i, "\\1"],
        [/\A(.+[aeiou]o)s$/i, "\\1"],
        [/\A(.+ho)es$/i, "\\1e"],
        [/\A(.+o)es$/i, "\\1"],
        [/\A(.+)ses$/i, "\\1s"],
        [/\A(.+)s$/i, "\\1"]
      ]

      @singulars = @singular_irregular + @singular_rules

      @plural_irregular = [
        [/\A(.*avocado)$/i, "\\1s"],
        [/\A(.*child)$/i, "\\1ren"],
        [/\A(.*pe)rson$/i, "\\1ople"],
        [/\A(.*mongoose)$/i, "\\1s"],
        [/\A(.*g)oose$/i, "\\1eese"],
        [/\A(.*t)ooth$/i, "\\1eeth"],
        [/\A(.*f)oot$/i, "\\1eet"],
        [/\A(ox)$/i, "\\1en"],
        [/\A(.*qu)y$/i, "\\1ies"],
        [/\A(di)e$/i, "\\1ce"],
        [/\A(.*pen)ny$/i, "\\1ce"],
        [/\A(.*(append|matr))ix$/i, "\\1ices"],
        [/\A(.*trilby)$/i, "\\1s"],
        [/\A(.*loo)ey$/i, "\\1ies"],
        [/\A(.*(chrysa|trel)lis)$/i, "\\1es"],
        [/\A(.*cirr)us$/i, "\\1i"],
        [/\A(.*blouse)$/i, "\\1s"],
        [/\A(.*canvas)$/i, "\\1ses"],
        [/\A(.*(l|m))ouse$/i, "\\1ice"],
        [/\A(.*gyro)$/i, "\\1s"],
        [/\A(.*helo)$/i, "\\1s"],
        [/\A(.*lens)$/i, "\\1es"],
        [/\A(.*patriarch)$/i, "\\1s"],
        [/\A(.*nis)$/i, "\\1es"],
        [/\A(.*pancreas)$/i, "\\1es"],
        # ends in -man
        [/\A(#{@category_man_mans.join("|")})$/, "\\1s"],
        [/\A(.*m)an$/i, "\\1en"],
        # ends in -us
        [/(#{@category_us_i.join("|")})us$/, "\\1i"],
        # ends in -ch, -sh, -ss, -z, -x
        [/\A(.*(stomach|epoch))$/i, "\\1s"],
        [/\A(.*gas)$/i, "\\1ses"],
        # ends in -f
        [/\A(.*(tur|thie|loa|hoo))f$/i, "\\1ves"],
        [/\A(.*(behalf|beef|roof|belief|chef|chief))$/i, "\\1s"],
        # ends in -s
        [/\A(.+[a]s)$/, "\\1es"]
      ]

      @plural_rules = [
        # ends in -is
        [/([csx])is$/i, "\\1es"],
        [/(ri)s$/i, "\\1ses"],
        # ends in -us
        [/\A(#{@category_us_uses.join("|")})$/i, "\\1es"],
        [/\A(.+us)$/i, "\\1es"],
        # ends in -ex, -um, -on, -a
        [/\A(#{@category_ex_ices.join("|")})ex$/i, "\\1ices"],
        [/\A(#{@category_um_a.join("|")})um$/i, "\\1a"],
        [/\A(#{@category_on_a.join("|")})on$/i, "\\1a"],
        [/(#{@category_a_ae.join("|")})$/i, "\\1e"],
        # ends in -ch, -sh, -ss, -z, -x
        [/\A(.+[ie]z)$/i, "\\1zes"],
        [/\A(.+(ss|sh|ch|x|z))$/i, "\\1es"],
        # ends in -f/fe
        [/\A(.*[aeo]l)f$/, "\\1ves"],
        [/\A(.*[^d]ea)f$/, "\\1ves"],
        [/\A(.*[nlw]i)fe$/i, "\\1ves"],
        [/\A(.+ar)f$/i, "\\1ves"],
        # ends in -y
        [/\A((.+)[aeiou]y)$/i, "\\1s"],
        [/\A(.+)y$/i, "\\1ies"],
        # ends in -o
        [/\A(#{@category_o_os.join("|")})$/i, "\\1s"],
        [/\A((.+)[aeiou]o)$/i, "\\1s"],
        [/\A(.+o)$/i, "\\1es"],
        # default
        [/\A(.+itis)$/i, "\\1es"],
        [/\A(.+)s$/i, "\\1s"],
        [/\A(.+)$/i, "\\1s"]
      ]

      @plurals = @plural_irregular + @plural_rules

      # A set of uncoutanble nouns
      #
      # @return [Array[String]]
      #
      # @api private
      def uncountable
        @uncountable
      end
      module_function :uncountable

      # A list of singular rules
      #
      # @return [Array[String]]
      #
      # @api private
      def singulars
        @singulars
      end
      module_function :singulars

      # A list of plural rules
      #
      # @return [Array[String]]
      #
      # @api private
      def plurals
        @plurals
      end
      module_function :plurals
    end # Nouns
  end # Inflection
end # Strings
