const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Banco de dados em memória com trechos do Ceará
let viagens = [
  {
    id: 1,
    viacao: 'Expresso Guanabara',
    origem: 'Fortaleza (Rodoviária Eng. João Thomé)',
    destino: 'Sobral',
    horarioSaida: '08:00',
    horarioChegada: '11:45',
    classe: 'Executivo',
    preco: 78.50,
    assentosDisponiveis: 14
  },
  {
    id: 2,
    viacao: 'Fretcar',
    origem: 'Fortaleza (Terminal Messejana)',
    destino: 'Jijoca de Jericoacoara',
    horarioSaida: '06:30',
    horarioChegada: '12:10',
    classe: 'Leito',
    preco: 115.00,
    assentosDisponiveis: 6
  },
  {
    id: 3,
    viacao: 'Expresso Guanabara',
    origem: 'Fortaleza (Rodoviária Eng. João Thomé)',
    destino: 'Juazeiro do Norte',
    horarioSaida: '21:00',
    horarioChegada: '05:30',
    classe: 'Semi-Leito',
    preco: 149.90,
    assentosDisponiveis: 9
  },
  {
    id: 4,
    viacao: 'Viação Princesa dos Inhamuns',
    origem: 'Fortaleza',
    destino: 'Quixadá',
    horarioSaida: '14:15',
    horarioChegada: '17:00',
    classe: 'Convencional',
    preco: 46.00,
    assentosDisponiveis: 22
  }
];

// GET: Listar todas as viagens (com filtro opcional por destino)
app.get('/api/viagens', (req, res) => {
  const { destino } = req.query;
  if (destino) {
    const filtradas = viagens.filter(v =>
      v.destino.toLowerCase().includes(destino.toLowerCase())
    );
    return res.json(filtradas);
  }
  res.json(viagens);
});

// POST: Comprar/Reservar 1 passagem (reduz assento)
app.post('/api/viagens/:id/comprar', (req, res) => {
  const id = parseInt(req.params.id);
  const viagem = viagens.find(v => v.id === id);

  if (!viagem) {
    return res.status(404).json({ erro: 'Viagem não encontrada.' });
  }
  if (viagem.assentosDisponiveis <= 0) {
    return res.status(400).json({ erro: 'Ônibus lotado!' });
  }

  viagem.assentosDisponiveis -= 1;
  res.json({
    mensagem: 'Passagem emitida com sucesso!',
    bilhete: {
      codigo: `CE-${Date.now().toString().slice(-6)}`,
      viagem
    }
  });
});

const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`API Ceará Bus rodando em http://localhost:${PORT}`);
});