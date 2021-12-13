import http from "@/util/http-common.js";

const comuStore = {
  namespaced: true,
  state: {
    articleList: [],
    article: { idx: 0 },
    dongName: null,
  },
  getters: {
    getArticle: (state) => {
      return state.article;
    },
  },
  mutations: {
    SET_ARTICLELIST: (state, articleList) => {
      state.articleList = articleList;
    },
    SEARCH_BY_TITLE: (state, articleList) => {
      state.articleList = articleList;
    },
    SET_ARTICLE: (state, article) => {
      console.log(state.article);
      state.article = article;
    },
    SET_DONGNAME: (state, dongName) => {
      state.dongName = dongName;
    },
    DO_NOTHING() {},
  },
  actions: {
    getArticleList({ commit }, addr) {
      http.get(`/community?addr=${addr}`).then((response) => {
        commit("SET_ARTICLELIST", response.data);
      });
    },
    searchArticleList({ commit }, keyword, addr) {
      http
        .get(`/community/search?key=${keyword}&addr=${addr}`)
        .then((response) => {
          commit("SEARCH_BY_TITLE", response.data);
        });
    },
    getArticleOne({ commit }, idx) {
      http.get(`/community/${idx}`).then((response) => {
        commit("SET_ARTICLE", response.data);
        console.log(response.data);
        console.log(this.state.article);
      });
    },
    registerArticle({ commit }, article) {
      return http.post("/community", article).then((response) => {
        if (response.data === "success") {
          commit("DO_NOTHING");
          alert("글이 등록되었습니다.");
        } else {
          alert("글 등록 실패");
        }
      });
    },
    modifyArticle({ commit }, article) {
      return http.put("/community", article).then((response) => {
        if (response.data === "success") {
          commit("DO_NOTHING");
          alert("글이 수정되었습니다.");
        }
      });
    },
    deleteArticle({ commit }, idx) {
      return http.delete(`/community/${idx}`).then((response) => {
        if (response.data === "success") {
          commit("DO_NOTHING");
          alert("글이 삭제되었습니다.");
        }
      });
    },
    getDongName({ commit }, dong) {
      http
        .get(`/community/dongsearch/${dong}`)
        .then((response) => {
          console.log(response.data);
          commit("SET_DONGNAME", response.data);
        })
        .catch((error) => {
          console.log("response: ", error.response.data);
        });
    },
    addReply({ commit }, reply) {
      return http.post("/community/reply", reply).then((response) => {
        if (response.data === "success") {
          commit("DO_NOTHING");
          alert("댓글이 등록되었습니다.");
        } else {
          alert("댓글 등록을 실패하였습니다.");
        }
      });
    },
    removeReply({ commit }, no) {
      return http.delete(`/community/reply/${no}`).then((response) => {
        if (response.data === "success") {
          commit("DO_NOTHING");
          alert("댓글이 삭제되었습니다.");
        } else {
          alert("댓글 삭제를 실패하였습니다.");
        }
      });
    },
  },
};

export default comuStore;
