const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const auth = require('./routes/auth');

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use('/api', auth);

const PORT = 3000;
app.listen(PORT, () => console.log(`API running: http://localhost:${PORT}`));
