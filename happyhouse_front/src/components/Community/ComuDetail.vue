<template>
  <b-container class="bv-example-row mt-3" align-v="center">
    <b-table-simple class="mt-3" outlined>
      <template #table-busy>
        <div class="text-center text-danger my-2">
          <b-spinner class="align-middle"></b-spinner>
          <strong>Loading...</strong>
        </div>
      </template>
      <b-thead>
        <b-tr>
          <b-th width="10%" class="text-center" colspan="2">
            {{ article.title }}
          </b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr>
          <b-td class="text-left">
            <strong style="color: gray">작성자</strong>
            <strong class="ml-2">{{ article.userid }}</strong>
          </b-td>
          <b-td class="text-right">{{ changeRegtime(article.regitime) }}</b-td>
        </b-tr>
        <b-tr rowspan="8">
          <b-td colspan="2">{{ article.content }}</b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
    <b-table-simple class="mt-3" outlined>
      <b-tr variant="secondary">
        <b-th colspan="1">댓글쓰기</b-th>
        <b-td colspan="3">
          <b-form-textarea
            v-model="newreple.content"
            placeholder="댓글 내용을 입력해주세요."
        /></b-td>
        <b-td class="align-middle" colspan="1">
          <b-button
            size="sm"
            variant="outline-secondary"
            @click="addNewReply()"
          >
            등록
          </b-button>
        </b-td>
      </b-tr>
    </b-table-simple>
    <b-table-simple
      v-for="(rep, index) in this.article.reply"
      :key="index"
      class="mt-3"
      outlined
    >
      <b-tr style="height: 5px">
        <b-th colspan="8" style="border-bottom: hidden">
          {{ rep.iduser }}
          <b-badge variant="danger" v-if="badgevalid(rep.iduser)">
            글쓴이
          </b-badge>
          <br />
          <span style="font-size: 14px; color: grey; padding-left: 5px">{{
            rep.regitime
          }}</span>
        </b-th>
      </b-tr>
      <b-tr>
        <b-td>{{ rep.content }}</b-td>
        <b-td class="text-right" v-if="replyremovevalid(rep.iduser)">
          <b-button
            size="sm"
            variant="outline-secondary"
            @click="mvremoveReply(rep.no)"
          >
            삭제
          </b-button>
        </b-td>
      </b-tr>
    </b-table-simple>

    <div style="text-align: center">
      <b-button variant="secondary" @click="mvlist" style="margin: 10px">
        목록</b-button
      >
      <b-button
        variant="secondary"
        @click="articledelete"
        style="margin: 10px"
        v-if="valid()"
        >삭제</b-button
      ><b-button
        variant="secondary"
        @click="mvmodify"
        style="margin: 10px"
        v-if="valid()"
        >수정</b-button
      >
    </div>
  </b-container>
</template>

<script>
import { mapActions, mapState } from "vuex";
import moment from "moment";

const comuStore = "comuStore";
const memberStore = "memberStore";

export default {
  data() {
    return {
      newreple: {
        content: "",
        iduser: "",
        idx: "",
      },
      reply: null,
    };
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
    ...mapState(comuStore, ["article"]),
  },
  created() {
    this.getArticleOne(this.$route.params.idx);
  },
  methods: {
    ...mapActions(comuStore, [
      "deleteArticle",
      "getArticleList",
      "addReply",
      "removeReply",
      "getArticleOne",
    ]),
    changeRegtime(regitime) {
      return moment(new Date(regitime)).format("YYYY-MM-DD hh:mm:ss");
    },
    articledelete() {
      this.deleteArticle(this.$route.params.idx).then(() => {
        this.getArticleList();
        this.$router.push({ name: "ComuList" });
      });
    },
    mvmodify() {
      this.$router.push({
        name: "ComuModify",
        params: { idx: this.$route.params.idx },
      });
    },
    mvlist() {
      this.$router.push({ name: "ComuList" });
    },
    // 현재 로그인유저와 글쓴이가 같은지 확인하는 메소드
    valid() {
      if (this.userInfo) {
        if (this.userInfo.userid == this.article.userid) {
          return true;
        }
        return false;
      }
      return false;
    },
    // 댓글쓴이가 글쓴이인지 확인하는 메소드
    badgevalid(id) {
      if (id == this.article.userid) {
        return true;
      }
      return false;
    },
    replyremovevalid(id) {
      if (id == this.userInfo.userid) {
        return true;
      }
      return false;
    },
    addNewReply() {
      if (this.newreple.content.length == 0) {
        alert("댓글 내용을 입력해주세요.");
        return;
      }

      this.newreple.iduser = this.userInfo.userid;
      this.newreple.idx = this.$route.params.idx;

      this.addReply(this.newreple).then(() => {
        this.getArticleOne(this.$route.params.idx);
        this.newreple.content = "";
      });
    },
    mvremoveReply(no) {
      this.$bvModal
        .msgBoxConfirm("삭제하시겠습니까?", {
          okTitle: "네",
          cancelTitle: "아니오",
        })
        .then((value) => {
          if (value == true) {
            this.removeReply(no).then(() => {
              this.getArticleOne(this.$route.params.idx);
            });
          }
        });
    },
  },
};
</script>

<style></style>
