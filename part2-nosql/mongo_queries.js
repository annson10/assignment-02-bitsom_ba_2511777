// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    _id: "PROD1001",
    name: "Samsung 55-inch 4K Smart TV",
    category: "Electronics",
    brand: "Samsung",
    price: 54999,
    currency: "INR",
    stock: 18,
    specifications: {
      screen_size_inches: 55,
      resolution: "3840x2160",
      display_type: "LED",
      voltage: "220-240V",
      warranty_months: 24
    },
    features: [
      "Dolby Audio",
      "Wi-Fi Enabled",
      "Voice Assistant Support"
    ],
    seller: {
      name: "ElectroHub",
      rating: 4.6
    },
    tags: ["tv", "smart-tv", "4k", "electronics"]
  },
  {
    _id: "PROD2001",
    name: "Men's Slim Fit Denim Jacket",
    category: "Clothing",
    brand: "Levis",
    price: 3499,
    currency: "INR",
    stock: 42,
    apparel_details: {
      size_options: ["S", "M", "L", "XL"],
      color: "Dark Blue",
      material: "Cotton Denim",
      fit: "Slim Fit",
      gender: "Men"
    },
    care_instructions: [
      "Machine wash cold",
      "Do not bleach",
      "Dry in shade"
    ],
    seller: {
      name: "FashionPoint",
      rating: 4.3
    },
    tags: ["jacket", "denim", "mens-wear", "clothing"]
  },
  {
    _id: "PROD3001",
    name: "Amul Fresh Paneer 200g",
    category: "Groceries",
    brand: "Amul",
    price: 95,
    currency: "INR",
    stock: 120,
    grocery_details: {
      expiry_date: "2024-12-28",
      weight_grams: 200,
      is_vegetarian: true,
      storage_instruction: "Keep refrigerated"
    },
    nutrition_per_100g: {
      energy_kcal: 265,
      protein_g: 18.3,
      fat_g: 20.8,
      carbohydrates_g: 1.2
    },
    ingredients: [
      "Milk solids",
      "Common salt",
      "Acidity regulator"
    ],
    seller: {
      name: "DailyGrocer",
      rating: 4.7
    },
    tags: ["paneer", "dairy", "fresh-food", "groceries"]
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find(
  {
    category: "Electronics",
    price: { $gt: 20000 }
  }
);

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find(
  {
    category: "Groceries",
    "grocery_details.expiry_date": { $lt: "2025-01-01" }
  }
);

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { _id: "PROD1001" },
  {
    $set: {
      discount_percent: 10
    }
  }
);

// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex({ category: 1 });
/* Creating an index on the "category" field improves query performance,
for operations, that frequently filter by category (e.g., Electronics, Clothing, Groceries). 
It reduces full collection scans and speeds up retrieval in large datasets.
*/