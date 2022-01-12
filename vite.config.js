import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'


// https://vitejs.dev/config/
export default defineConfig({
    plugins: [vue()],
    server: {
        proxy: {
            // string shorthand
            '/rpc': 'http://localhost:8988'
        }
    }
    // ,
    // optimizeDeps: { exclude: ["vue-router"] }
})
