const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const app = express();
const port = process.env.PORT || 3000;

// Middleware to parse JSON
app.use(express.json());

// MongoDB connection string
const mongoURI = 'mongodb://localhost:27017/find_my_kid_db';

// Connect to MongoDB
mongoose.connect(mongoURI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => {
  console.log('Connected to MongoDB');
})
.catch((err) => {
  console.error('Failed to connect to MongoDB', err);
});

// User schema
const userSchema = new mongoose.Schema({
  phoneNumber: { type: String, required: true, unique: true },
  countryCode: { type: String, required: true },
  flag: { type: String, required: true },
  passwordHash: { type: String, required: true },
  role: { type: String, enum: ['parent', 'child'], required: true },
});

const User = mongoose.model('User', userSchema);

// Signup route
app.post('/api/signup', async (req, res) => {
  try {
    const { phoneNumber, countryCode, flag, password, role } = req.body;

    if (!phoneNumber || !countryCode || !flag || !password || !role) {
      return res.status(400).json({ message: 'Missing required fields' });
    }

    if (!/^\d{9}$/.test(phoneNumber)) {
      return res.status(400).json({ message: 'Phone number must be 9 digits' });
    }

    const existingUser = await User.findOne({ phoneNumber: countryCode + phoneNumber });
    if (existingUser) {
      return res.status(409).json({ message: 'User already exists' });
    }

    const passwordHash = await bcrypt.hash(password, 10);

    const newUser = new User({
      phoneNumber: countryCode + phoneNumber,
      countryCode,
      flag,
      passwordHash,
      role,
    });

    await newUser.save();

    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    console.error('Signup error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

// Login route
app.post('/api/login', async (req, res) => {
  try {
    const { phoneNumber, countryCode, password } = req.body;

    if (!phoneNumber || !countryCode || !password) {
      return res.status(400).json({ message: 'Missing required fields' });
    }

    const user = await User.findOne({ phoneNumber: countryCode + phoneNumber });
    if (!user) {
      return res.status(401).json({ message: 'Invalid phone number or password' });
    }

    const passwordMatch = await bcrypt.compare(password, user.passwordHash);
    if (!passwordMatch) {
      return res.status(401).json({ message: 'Invalid phone number or password' });
    }

    res.status(200).json({ message: 'Login successful', role: user.role });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

// Basic route
app.get('/', (req, res) => {
  res.send('Find My Kid Backend is running');
});

// Start server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
