<template>
  <div id="app">
    <Navbar />
    <router-view></router-view>
  </div>
</template>

<script>
import { mapActions, mapGetters, mapMutations, mapState } from "vuex";
import Navbar from "./components/Navbar.vue";

const memberStore = "memberStore";

export default {
  name: "App",
  components: {
    Navbar,
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
  },
  created() {
    this.SET_IS_LOGIN(false);
    this.SET_USER_INFO(null);
    sessionStorage.removeItem("access-token");
    console.log(this.userInfo);
  },
  methods: {
    ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    ...mapActions(memberStore, ["getUserInfo"]),
    ...mapGetters(memberStore, ["checkUserInfo"]),
  },
};
</script>

<style>
#app {
  font-family: "Montserrat", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  width: 100%;
}

.parent {
  margin-top: 38px;
  padding-top: 40px;
  position: relative;
}

.pgray {
  color: #535a5e;
}

.pblue {
  color: #759cc9;
}

.text-light {
  color: #d3d2d2 !important;
}

/* To set scrollbar width */
::-webkit-scrollbar {
  width: 5px;
}

/* Track */
::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 9px;
  border: 2px solid white; /* Use your background color instead of White */
  background-clip: content-box;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: #aeaeae;
  border-radius: 9px;
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  background: #949494;
}
</style>
