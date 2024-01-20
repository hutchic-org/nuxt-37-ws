// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  vite: {
    server: {
      hmr: {
        protocol: 'ws',
        port: 22301,
        clientPort: 22301,
        path: 'hmr/',
        timeout: 3,
      },
      middlewareMode: true
    }
  },
  ssr: false,
})
