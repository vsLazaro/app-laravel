<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $products = [
            [
                'name' => 'Notebook Dell Inspiron',
                'description' => 'Notebook Dell Inspiron 15 3000 com processador Intel Core i5, 8GB RAM e 256GB SSD',
                'price' => 2499.99,
            ],
            [
                'name' => 'Mouse Logitech MX Master',
                'description' => 'Mouse sem fio Logitech MX Master 3 com precisão avançada e design ergonômico',
                'price' => 399.90,
            ],
            [
                'name' => 'Teclado Mecânico Redragon',
                'description' => 'Teclado mecânico Redragon Kumara K552 com switches Blue e iluminação RGB',
                'price' => 189.99,
            ],
            [
                'name' => 'Monitor Samsung 24"',
                'description' => 'Monitor Samsung Full HD 24 polegadas com tecnologia LED e taxa de atualização de 75Hz',
                'price' => 679.90,
            ],
            [
                'name' => 'Headset HyperX Cloud',
                'description' => 'Headset gamer HyperX Cloud II com som surround 7.1 e microfone removível',
                'price' => 299.99,
            ],
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}
