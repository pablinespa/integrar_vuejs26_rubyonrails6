import Vue from "vue";
import VueRouter from "vue-router";
import Schedule from "../components/Schedule";
import Days from "../components/Days";

Vue.use(VueRouter)

const routes = [
    {
        path: "/",
        name: "home",
        component: Schedule
    },
    {
        path: "/demo-1",
        name: "Days",
        component: Days
    }
];

const router = new VueRouter({
    mode: "history",
    routes
});

export default router;

// Vue.use(Router);
//
// export default new Router({
//     mode: "history",
//     routes: [
//         {
//             path: "/",
//             name: "Schedule",
//             component: Schedule
//         },
//         {
//             path: "/demo-1",
//             name: "Days",
//             component: Days
//         }
//     ]
// });
