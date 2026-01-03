import 'package:flutter/material.dart';

class PokemonListHeader extends StatelessWidget {
  const PokemonListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.85,
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.25,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(211, 10, 64, 1),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pokédex',
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Image.asset('assets/images/pokebola.png', height: 32),
                  ],
                ),
              ),
            ],
          ),

          /// img do pokemon
          Positioned(
            top: size.height * 0.03,
            right: -55,
            child: Image.asset('assets/images/koraidon.png', height: size.height * 0.75, fit: BoxFit.contain),
          ),

          /// fade
          Positioned(
            top: size.height * 0.48,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.white],
                ),
              ),
            ),
          ),

          //fundo do texto
          Positioned(
            top: size.height * 0.62,
            left: 0,
            right: 0,
            child: Container(height: 150, decoration: const BoxDecoration(color: Colors.white)),
          ),

          Positioned(
            top: size.height * 0.60,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Explore o incrível\nmundo dos Pokémon.', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                  Text('Descubra informações detalhadas sobre seus personagens favoritos.', style: TextStyle(fontSize: 16)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '+1000k',
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color.fromRGBO(211, 10, 64, 1)),
                      ),
                      SizedBox(width: 8),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text('Pokemons', style: TextStyle(fontSize: 16, color: Color.fromRGBO(211, 10, 64, 1))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
