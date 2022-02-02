<template>

    <div class="table-responsive">
        <table class="table mt-3" :items="data" :fields="fields">
            <thead class="thead-dark">
            <tr>
                <th scope="col">Nombre</th>
                <th scope="col">Precio</th>
                <th scope="col">Stock</th>
                <th scope="col">Imagen</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="producto in data" v-bind:key="producto.id">
                <td>{{ producto.first_name }}</td>
                <td>{{ producto.last_name }}</td>
                <td>{{ producto.profile_picture }}</td>
                <td>
                    <img v-bind:src="producto.img" class="img-fluid" width="30px" v-bind:alt="producto.first_name">
                </td>
            </tr>
            </tbody>
        </table>
    </div>

</template>

<script>

    export default {

        name: 'Postres',

        data: function () {
            return {
                // Campos
                fields: ['nombre', 'precio', 'stock', 'img'],

                // Obtenemos los datos en el array 'data'
                data: []
            }
        },

        // Leemos los datos JSON con axios
        mounted() {
            axios
                // .get("https://raw.githubusercontent.com/collectivecloudperu/integrar_vuejs26_rubyonrails6/main/postres.json")
                .get("api/v1/test")
                .then(response => {
                    this.data = response.data;
                    console.log("data");
                    console.log(this.data);
                });
        },

    }
</script>