# HappyHouse🏡

> 첫번째 웹 프로젝트, SSAFY(삼성 청년 소프트웨어 아카데미) 1학기 마지막 프로젝트, 우수 프로젝트 수상작

<u>아파트 거래 정보</u> 제공 사이트를 주제로 한 프로젝트입니다. 자녀 교육을 염두해두고 아파트를 고르는 부모들이 참고할만한 <u>학군이나 주변 환경 정보</u>들을 함께 보여주도록 하였으며, 인증된 사용자만 사용할 수 있는 <u>동네별 커뮤니티 서비스</u>를 제공하여 사이트 이용자간의 교류가 발생하는 것을 목표로 만들었습니다. [**시연 영상**](https://youtu.be/zkH_b0ycTug)



## Team

- 김유진
- 박성일



## 기술 및 구조도

![02_structure](https://user-images.githubusercontent.com/82884242/145828734-80ff22d5-95e7-4c71-95a7-6f9dd98c9365.png)

##### Front-End

- Vue.js
- Bootstrap Vue

##### Back-End

- Spring Boot
- MySQL



## Database Schema Diagram

![03_erd](https://user-images.githubusercontent.com/82884242/145827076-97eb5c9a-740d-4b7f-b469-c382b425a7e6.png)



## 핵심 기능

- 아파트 거래 정보
  - 지도의 움직임에 따라 아파트 마커와 목록 표시
  - 지도 상의 마커나 목록 클릭 시 아파트 거래 정보와 주변 환경 정보 표시
  - 거래 정보는 공공 데이터에서, 주변 환경 정보는 카카오맵 API에서 불러옴
  - 카테고리 클릭 시 카테고리별 마커 표시, 마커 클릭 시 상세 페이지로 이동
  - 법정동 선택 시 지도 이동하도록 구현 
- 아파트 관련 정보
  - 조회수가 높은 10개의 매물을 차트(Chart.js 이용)와 함께 표시
  - 네이버 검색 API에서 아파트 관련 기사들을 가져와 표시

- 사용자 관리
  - JWT(JSON Web Token) 이용
  - 회원가입 및 로그인, 로그아웃
  - 회원 정보 조회 및 수정
  - 비밀번호 찾기

- 공지사항
  - 관리자만 작성 가능
  - 공지사항 등록, 수정, 삭제

- 커뮤니티
  - 동별 커뮤니티 게시판
  - 게시글 등록, 수정, 삭제
  - 댓글 등록, 수정, 삭제
- QnA 게시판
  - 로그인한 사용자만 작성 가능, 관리자만 답글 작성 및 수정 가능



## 주요 화면

#### 메인 페이지

![01_main](https://user-images.githubusercontent.com/82884242/145827127-3d98e653-62e6-413d-86d2-e5a07ec58aa1.jpg)

![05_main-2](https://user-images.githubusercontent.com/82884242/145827156-9d5d0191-7cbb-4026-b364-518ddb982f1c.png)

![06_main-3](https://user-images.githubusercontent.com/82884242/145827199-75807bad-7ea1-4645-a7be-1819e1aef69a.png)

![07_main-4](https://user-images.githubusercontent.com/82884242/145827237-b399a1fa-8525-461c-9356-a090df6ce943.png)

![08_main-5](https://user-images.githubusercontent.com/82884242/145827273-42758506-f355-4781-8f2c-fe39e82842a6.png)

---

#### 공지사항

![09_notice-1](https://user-images.githubusercontent.com/82884242/145827301-42450a54-f04f-40cc-a32e-2f25a4a75f19.png)

![10_notice-2](https://user-images.githubusercontent.com/82884242/145827339-9b11307b-ab82-412c-84a1-405e3813e656.png)

---

#### 커뮤니티

![11_community-1](https://user-images.githubusercontent.com/82884242/145827353-616b7f7f-0406-4a2d-aaa2-a7eab83d5573.png)

![12_community-2](https://user-images.githubusercontent.com/82884242/145827398-c2655816-3125-44f8-8d2c-bd677a1b6ad8.png)

---

#### QnA

![13_QnA](https://user-images.githubusercontent.com/82884242/145827425-9940878a-a8e2-49ec-ad74-e268dc7852ad.png)

---

#### 로그인/회원가입, 회원정보, 비밀번호 찾기
![14_signin](https://user-images.githubusercontent.com/82884242/145827447-aeb0032f-3f64-412b-a232-1f2e23a0d049.png)

![15_signup](https://user-images.githubusercontent.com/82884242/145827463-a820ca44-fe4b-4191-8627-0fa4c11d9a1f.png)

![16_authorization](https://user-images.githubusercontent.com/82884242/145830191-a9c149a5-4190-4c8f-99cc-335d04eeefc5.png)


