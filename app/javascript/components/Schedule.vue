<template>
    <div class="container">
        
        <div class="row">
            <div class="col-1">
                <span>Servicios:</span>
            </div>
            <div class="col-4">
                <select v-model="selectedService" class="row table">

                    <option v-for="service in services" :value="service.id">
                        {{ service.name }}
                    </option>

                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-1">
                <span>Semanas:</span>
            </div>
            <div class="col-4">
                <select v-model="selectedWeek" class="row table">

                    <option v-for="week in weeks" :value="week.number_week">
                        {{ week.name_week }}
                    </option>

                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-2">
                <p class="text-left">Total semana {{number_week}}: </p>
            </div>
            <div class="col-6">
                <p class="text-left">{{range_days}}</p>
            </div>
        </div>

        <div class="row">
            <table class="table mt-3 col-4">
                <thead class="">
                    <tr>
                        <th></th>
                        <th v-for="user in users" v-bind:key="user.id">{{user.first_name}}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="text-left">Horas: </td>
                        <td v-for="user in users" v-bind:key="user.id">{{user.qty_hours}}</td>
                    </tr>
                </tbody>
            </table>
            <div class="col-5"></div>
            <div class="col-3">
                <button v-if="edit_availability" @click="editAvailability()">Editar Disponibilidad</button>
                <button v-if="save_availability" @click="saveAvailability()">Guardar Disponibilidad</button>
            </div>
        </div>


        <div class="row">

            <table class="table mt-3 ml-3 mr-3 col-5" v-for="day in days" v-bind:key="day.id">
                <thead class="">
                <tr>

                </tr>
                </thead>
                <tbody>
                <tr>
                    <table class="table mt-3 d-hours" :items="day.hours" :fields="fields">
                        <thead class="">
                        <tr>
                            <th scope="col" class="d-name">{{ day.name_day }}</th>
                            <th class="col-user" v-for="user in day.users" v-bind:key="user.id" :style="{ 'background-color': user.color }">
                                {{ user.first_name }}
                            </th>

                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="hour in day.hours" v-bind:key="hour.id" v-bind:style= "[hour.bol_available ? {'background-color': 'mistyrose'} : {}]">
                            <td>{{ hour.range_hour }}</td>
                            <td v-if="edit_availability" v-for="user in hour.users" v-bind:key="user.id">
                                <p v-if="user.available">1</p>
                                <img v-if="user.available==false" src="https://www.freeiconspng.com/thumbs/alert-icon/emergency-alert-icon-alert-icon-8.png" alt="Alert"/>
                            </td>

                            <td v-if="save_availability" v-for="user in hour.users" v-bind:key="user.id">
                                <input type="radio" name="user_available" v-model="day.available" v-bind:value="user.available" >
                            </td>
                        </tr>
                        </tbody>
                    </table>

                </tr>
                </tbody>
            </table>

        </div>
    </div>

</template>



<script>
    import Days from "./Days";

    export default {

        name: 'Schedule',
        components: {
            Days
        },
        data: function () {
            return {
                // Campos
                fields: ['nombre'],

                // Obtenemos los datos en el array 'data'
                data: [],
                services: [],
                weeks: [],
                days: [],
                users: [],

                selectedService: "",
                selectedWeek: "",

                number_week: "",
                range_days: "",

                edit_availability: false,
                save_availability: false,

                day: {
                    available: []
                }

            }
        },
        // Leemos los datos JSON con axios
        mounted() {

            axios
                .get("api/v1/services")
                .then(response => {
                    this.services = response.data;
                    console.log("services");
                    console.log(this.services);
                });
        },
        watch: {
            selectedService: function() {
                console.log('selectedService');
                console.log(this.selectedService);
                this.getWeeks();

            },
            selectedWeek: function() {
                console.log('selectedWeek');
                console.log(this.selectedWeek);
                this.number_week = this.selectedWeek;
                this.getDays();
                this.getUsers();

            }
        },
        methods: {
            getWeeks(){
                axios.get("api/v1/weeks", {
                        params: {
                            service_id: this.selectedService
                        }
                    })
                    .then(response => {
                        this.weeks = response.data;
                        console.log("weeks");
                        console.log(this.weeks);
                    });
            },
            getDays(){
                axios.get("api/v1/days", {
                        params: {
                            number_week: this.selectedWeek
                        }
                    })
                    .then(response => {
                        this.days = response.data;
                        this.range_days = response.data[0].range_days;
                        this.edit_availability = true;
                        this.save_availability = false;
                        console.log("days");
                        console.log(this.days);
                    });
            },
            getUsers(){
                axios.get("api/v1/users", {
                    params: {
                        number_week: this.selectedWeek,
                        service_id: this.selectedService
                    }
                })
                    .then(response => {
                        this.users = response.data;
                        console.log("users");
                        console.log(this.users);
                    });
            },
            editAvailability(){
                console.log('editAvailability');
                this.edit_availability = false;
                this.save_availability = true;
            },
            saveAvailability(){
                this.getWeeks();
                this.getDays();
                this.getUsers();
                this.edit_availability = true;
                this.save_availability = false;
            },
            testFunction: function (event) {
                console.log('test clicked')
            }
        }


    }
</script>