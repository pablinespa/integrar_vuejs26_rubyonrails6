<template>
    <div class="container text-center mt-5">

        <div class="row">
            <div class="col-md-12">

                <div id="app">
                    <h1>{{ titulo }}</h1>
                    <br/>
                    <!-- Componente -->
                    <Schedule />

                </div>

            </div>
        </div>
    </div>
</template>

<script>
    // Importo el componente

    import Schedule from "./components/Schedule";
    import Days from "./components/Days";

    export default {
        // Defino el componente 'Postres'
        components: {
            Schedule,
            Days,
        },
        data: function () {
          return {
              titulo: "Monitoreo de servicio "
          }
        }
    }
</script>

<style scoped>
    p {
      font-size: 2em;
      text-align: center;
    }
</style>
