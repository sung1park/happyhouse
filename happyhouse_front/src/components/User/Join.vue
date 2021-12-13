<template>
  <b-container class="bv-example-row mt-3" align-v="center">
    <div class="blank"></div>
    <b-row class="mb-3 text-center" align-h="center">
      <b-col cols="7">
        <span class="display-3">Join</span>
      </b-col>
    </b-row>
    <b-row align-h="center">
      <b-col cols="5">
        <b-form class="text-left">
          <b-form-group
            id="input-group-userid"
            label="ID"
            label-for="input-userid"
          >
            <b-form-input
              type="text"
              id="input-userid"
              v-model.lazy="$v.user.userid.$model"
              placeholder="아이디는 5-12자 내입니다."
              :state="validateState('userid')"
              aria-describedby="input-userid-feedback"
            ></b-form-input>
            <b-form-invalid-feedback id="input-userid-feedback">
              아이디는 5-12자 내로 입력해주세요.
            </b-form-invalid-feedback>
          </b-form-group>

          <b-form-group
            id="input-group-password"
            label="Password"
            label-for="input-password"
          >
            <b-form-input
              type="password"
              id="input-password"
              v-model="$v.user.password.$model"
              placeholder="비밀번호를 입력해주세요."
              :state="validateState('password')"
              aria-describedby="input-password-feedback"
            ></b-form-input>
            <b-form-invalid-feedback id="input-password-feedback">
              비밀번호는 8-14자 내로 입력해주세요.
            </b-form-invalid-feedback>
          </b-form-group>

          <b-form-group
            id="input-group-findpwdkey"
            label="당신이 어릴적 살았던 동네는 ?"
            label-for="input-2"
          >
            <b-form-input
              id="input-findpwdkey"
              v-model="$v.user.findpwdkey.$model"
              placeholder="비밀번호를 찾기 위한 질문입니다."
              :state="validateState('findpwdkey')"
              aria-describedby="input-findpwdkey-feedback"
            ></b-form-input>
            <b-form-invalid-feedback id="input-findpwdkey-feedback">
              비밀번호 찾기 답변을 입력해주세요.
            </b-form-invalid-feedback>
          </b-form-group>

          <b-form-group
            id="input-group-name"
            label="Name"
            label-for="input-name"
          >
            <b-form-input
              id="input-name"
              v-model="$v.user.name.$model"
              placeholder="이름을 입력해주세요."
              :state="validateState('name')"
              aria-describedby="input-name-feedback"
            ></b-form-input>
            <b-form-invalid-feedback id="input-name-feedback">
              올바른 이름을 입력해주세요
            </b-form-invalid-feedback>
          </b-form-group>

          <b-form-group
            id="input-group-address"
            label="Address"
            label-for="input-address"
          >
            <b-form-select
              style="width: 30%; margin: 5px"
              id="sidoSelect"
              v-model="user.sidoAddr"
              :options="sidos"
              @change="getGugunList"
            ></b-form-select>
            <b-form-select
              style="width: 30%; margin: 5px"
              id="gugunSelect"
              v-model="user.gugunAddr"
              :options="guguns"
              @change="getDongList"
            ></b-form-select>
            <b-form-select
              style="width: 30%; margin: 5px"
              id="dongSelect"
              v-model="user.addr"
              :options="dongs"
              :state="validateState('addr')"
              aria-describedby="input-address-feedback"
            ></b-form-select>
            <b-form-invalid-feedback id="input-address-feedback">
              거주하고 있는 지역을 입력해주세요.
            </b-form-invalid-feedback>
          </b-form-group>

          <div style="text-align: center">
            <b-button type="button" variant="success" @click="confirm"
              >회원가입</b-button
            >
            <b-form-text id="password-help-block">
              이미 가입한 적이 있다면
              <a><router-link :to="{ name: 'Login' }">로그인</router-link></a>
            </b-form-text>
          </div>
        </b-form>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapActions, mapMutations, mapState } from "vuex";
import { validationMixin } from "vuelidate";
import { required, minLength, maxLength } from "vuelidate/lib/validators";

const memberStore = "memberStore";

export default {
  mixins: [validationMixin],
  data() {
    return {
      user: {
        userid: null,
        password: null,
        name: null,
        findpwdkey: null,
        addrcert: null,
        sidoAddr: null,
        gugunAddr: null,
        addr: null,
      },
      passwordState: false,
      nameState: false,
      addrState: false,
      findpwdkeyState: false,
    };
  },
  computed: {
    ...mapState(memberStore, ["sidos", "guguns", "dongs"]),
  },
  created() {
    this.getSidoList();
  },
  validations: {
    user: {
      userid: { required, minLength: minLength(5), maxLength: maxLength(12) },
      password: { required, minLength: minLength(8), maxLength: maxLength(14) },
      name: { required, minLength: minLength(2) },
      addr: { required },
      findpwdkey: { required },
    },
  },
  methods: {
    ...mapActions(memberStore, [
      "registerUser",
      "getSido",
      "getGugun",
      "getDong",
    ]),
    ...mapMutations(memberStore, [
      "CLEAR_SIDO_LIST",
      "CLEAR_GUGUN_LIST",
      "CLEAR_DONG_LIST",
    ]),
    getSidoList() {
      this.CLEAR_SIDO_LIST();
      this.CLEAR_GUGUN_LIST();
      this.CLEAR_DONG_LIST();
      this.sidoAddr = null;
      this.gugunAddr = null;
      this.addr = null;
      this.getSido();
    },
    // 구군 목록을 불러옵니다
    getGugunList() {
      this.CLEAR_GUGUN_LIST();
      this.CLEAR_DONG_LIST();
      this.gugunAddr = null;
      this.addr = null;
      if (this.user.sidoAddr) this.getGugun(this.user.sidoAddr);
    },
    // 동 목록을 불러옵니다
    getDongList() {
      this.CLEAR_DONG_LIST();
      this.addr = null;
      if (this.user.gugunAddr) this.getDong(this.user.gugunAddr);
    },
    validateState(name) {
      const { $dirty, $error } = this.$v.user[name];
      return $dirty ? !$error : null;
    },

    confirm() {
      this.$v.user.$touch();
      if (this.$v.user.$anyError) {
        return;
      }
      this.registerUser(this.user).then(() => {
        this.$router.push({ name: "Main" });
      });
    },
  },
};
</script>

<style></style>
