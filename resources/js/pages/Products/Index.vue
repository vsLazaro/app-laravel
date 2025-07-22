<template>
  <AppLayout title="Produtos">
    <template #header>
      <Heading>Produtos</Heading>
    </template>

    <div class="py-12">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
          <div class="p-6 text-gray-900 dark:text-gray-100">
            <div class="mb-6">
              <h2 class="text-lg font-medium text-gray-900 dark:text-gray-100">
                Lista de Produtos
              </h2>
              <p class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                Aqui estão todos os produtos disponíveis em nossa loja.
              </p>
            </div>

            <div v-if="products.length === 0" class="text-center py-8">
              <p class="text-gray-500 dark:text-gray-400">
                Nenhum produto encontrado.
              </p>
            </div>

            <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              <div
                v-for="product in products"
                :key="product.id"
                class="bg-white dark:bg-gray-700 border border-gray-200 dark:border-gray-600 rounded-lg shadow hover:shadow-md transition-shadow duration-200"
              >
                <div class="p-6">
                  <h3 class="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-2">
                    {{ product.name }}
                  </h3>
                  <p class="text-gray-600 dark:text-gray-300 text-sm mb-4 line-clamp-3">
                    {{ product.description }}
                  </p>
                  <div class="flex items-center justify-between">
                    <span class="text-2xl font-bold text-green-600 dark:text-green-400">
                      R$ {{ formatPrice(product.price) }}
                    </span>
                    <span class="text-xs text-gray-500 dark:text-gray-400">
                      ID: {{ product.id }}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </AppLayout>
</template>

<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue'
import Heading from '@/components/Heading.vue'

interface Product {
  id: number
  name: string
  description: string
  price: number
}

withDefaults(defineProps<{
  products?: Product[]
}>(), {
  products: () => []
})

function formatPrice(price: number): string {
  return new Intl.NumberFormat('pt-BR', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  }).format(price)
}
</script>

<style scoped>
.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style> 