import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TelaLocalDoacao extends StatefulWidget {
  const TelaLocalDoacao({Key? key}) : super(key: key);

  @override
  _TelaLocalDoacaoState createState() => _TelaLocalDoacaoState();
}

class _TelaLocalDoacaoState extends State<TelaLocalDoacao> {
  // Inicialização do controlador de mapas e coordenadas padrão
  late GoogleMapController mapController;

  // Localização inicial do mapa (coordenadas fictícias)
  final LatLng _initialPosition = const LatLng(-23.5505, -46.6333); // São Paulo, SP, Brasil

  // Lista de locais de doação fictícios (você pode alterar conforme sua necessidade)
  final List<Map<String, dynamic>> _localDoacao = [
    {
      'nome': 'Hemocentro São Paulo',
      'endereco': 'Av. Dr. Enéas Carvalho de Aguiar, 155',
      'coordenadas': LatLng(-23.5587, -46.6602),
    },
    {
      'nome': 'Hemocentro Campinas',
      'endereco': 'Rua Carlos Chagas, 480',
      'coordenadas': LatLng(-22.9068, -47.0626),
    },
  ];

  // Método que inicializa o controlador de mapas
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // Pega a largura da tela e aplica 80%
    double screenWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Locais de Doação'),
        backgroundColor: const Color.fromARGB(255, 81, 177, 84),
      ),
      body: Column(
        children: [
          // Mapa mostrando a localização dos pontos de doação
          SizedBox(
            height: 300,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 12,
              ),
              markers: _localDoacao
                  .map((local) => Marker(
                        markerId: MarkerId(local['nome']),
                        position: local['coordenadas'],
                        infoWindow: InfoWindow(
                          title: local['nome'],
                          snippet: local['endereco'],
                        ),
                      ))
                  .toSet(),
            ),
          ),
          const SizedBox(height: 20),
          // Lista de locais de doação com informações
          Expanded(
            child: ListView.builder(
              itemCount: _localDoacao.length,
              itemBuilder: (context, index) {
                final local = _localDoacao[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 217, 235, 206),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          local['nome'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(local['endereco']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
