# 니,누꼬? (𝑵𝒊𝒏𝒖𝒄𝒄𝒐)

![타이틀 이미지](https://github.com/Ninucco/.github/blob/main/profile/images/preview.png?raw=true)

<br />

<div align="center">
	<h3 align="center">
		<a href="https://play.google.com/store/apps/details?id=com.slsnrndi.ninucco">
			<img src="https://github.com/Ninucco/.github/assets/31383362/75766b8e-7a24-45c2-a019-d06bd5180a09" alt="ninucco" width="120" height="23">
	에서 다운로드
		</a>
    </h3>
</div>

<br />

> [0. 프로젝트 개요](#0-프로젝트-개요)
>
> [1. 서비스 및 기능 소개](#1-서비스-및-기능-소개)
>
> [2. 서비스 화면](#2-서비스-화면)
>
> - [로그인 화면](#1-로그인-화면)
> - [메인 화면](#2-메인-화면)
> - [랭킹 화면](#3-랭킹-화면)
> - [닮은꼴 테스트 화면](#4-닮은꼴-테스트-화면)
> - [배틀 화면](#5-배틀-화면)
> - [프로필 화면](#6-프로필-화면)
>
> [3. 시스템 아키텍처](#3-시스템-아키텍처)
>
> [4. 개발 환경](#4-개발-환경)
>
> [5. 이미지 생성 과정](#5-이미지-생성-과정)
>
> [6. ERD](#6-erd)
>
> [7. 서비스 및 기술 특장점](#7-서비스-및-기술-특장점)
>
> [8. 멤버 및 역할](#8-멤버-및-역할)

<br />

## 0. 프로젝트 개요

✔ 프로젝트명 : 니, 누꼬? (Ninucco)

✔ 한줄 소개 : 얼굴 사진을 분석해 다양한 결과와 프로필 사진을 제공하고, 다른 사용자와 얼굴 배틀을 할 수 있는 Android·IOS 하이브리드 앱 서비스

✔ 개발 기간 : 23.04.10 ~ 23.05.19 (6주)

✔ 팀원 : 하훈목, 이홍주, 박이령, 김희준, 장인혁, 송승현

✔ 사용 기술스택 : Flutter, SpringBoot, FastAPI, React, MariaDB, MongoDB, Redis, Docker, AWS(S3), Nginx + (3. 시스템 아키텍처 참고)

## 1. 서비스 및 기능 소개

✔ 얼굴 사진 분석

- 사용자가 등록한 얼굴 사진을 분석합니다.
- 현재 5가지 분석 주제(동물, 직업, 과일, 학창시절, 개발언어)를 제공합니다.
- Stable Diffusion 모델을 사용하여 분석 결과를 이미지화시켜서 사용자에게 제공합니다.
- 생성된 이미지를 다운로드, 카카오톡 공유하기, 앱 내 프로필 사진 변경에 이용할 수 있습니다.

✔ 사진 배틀

- 배틀 질문을 선택하여 유저 간 사진 배틀을 할 수 있습니다.
- 상대로 지목된 유저는 배틀을 거절하거나 사진을 올리며 수락할 수 있습니다.
- 배틀을 수락한 시점을 기준으로 익일 자정이 되면 배틀이 종료됩니다.
- 배틀의 결과는 베팅 인원수로 결정됩니다.

✔ 베팅

- 진행중인 배틀에 포인트를 베팅할 수 있습니다.
- 승패 예측 성공 시 베팅한 포인트\*배당만큼의 포인트를 획득할 수 있습니다.

✔ Elo Rating System

- Elo 레이팅 시스템을 도입해 승패에 따라 Elo score를 변경하며 두 유저 간 배당이 산정됩니다.

✔ 마이페이지

- 사진 분석 결과 내역을 조회할 수 있습니다.
- 진행했거나 진행중인 배틀 내역을 조회할 수 있습니다.

## 2. 서비스 화면

### 1. 로그인 화면

![서비스화면](https://github.com/Ninucco/Ninucco/assets/31383362/a4bd4d7a-d4b2-43a8-9843-07f90ce2434b)

### 2. 메인 화면

![서비스화면](https://github.com/Ninucco/Ninucco/assets/31383362/0ef2d58c-27c3-4ce0-b8f4-066a70cec1db)

### 3. 랭킹 화면

![서비스화면](https://github.com/Ninucco/Ninucco/assets/31383362/1576b7ba-a21d-4d79-bcac-a6de0d7a80b6)

### 4. 닮은꼴 테스트 화면

![서비스화면](https://github.com/Ninucco/Ninucco/assets/31383362/e95af251-696b-4e3b-ab27-baa84813e11d)
![서비스화면](https://github.com/Ninucco/Ninucco/assets/31383362/adf4e23d-498f-40fe-a7c5-c3a1f914dc5b)

### 5. 배틀 화면

![서비스화면](https://github.com/Ninucco/Ninucco/assets/31383362/fa7a1457-2c6e-469a-8eb4-7d30914f3859)

### 6. 프로필 화면

![서비스화면](https://github.com/Ninucco/Ninucco/assets/31383362/2ada0eb3-3b7e-4f69-9f11-9c2496e38c21)

## 3. 시스템 아키텍처

![structure_diagram](https://github.com/Ninucco/.github/blob/main/profile/images/structure_diagram.png?raw=true)

## 4. 개발 환경

### :earth_africa: Environment

<div>
  <img src="https://img.shields.io/badge/Visual Studio Code-FFFFFF?style=flat&logo=Visual Studio Code&logoColor=007ACC">
  <img src="https://img.shields.io/badge/Android Studio-FFFFFF?style=flat&logo=androidstudio&logoColor=3DDC84">
	<img src="https://img.shields.io/badge/InteliJ-FFFFFF?style=flat&logo=intellijidea&logoColor=000000">
  <img src="https://img.shields.io/badge/Xcode-FFFFFF?style=flat&logo=xcode&logoColor=#147EFB">
  <img src="https://img.shields.io/badge/AWS EC2-FFFFFF?style=flat&logo=amazonec2&logoColor=FF9900">
  <img src="https://img.shields.io/badge/AWS S3-FFFFFF?style=flat&logo=amazons3&logoColor=569A31">
  <img src="https://img.shields.io/badge/Git-FFFFFF?style=flat&logo=Git&logoColor=F05032">
  <img src="https://img.shields.io/badge/GitLab-FFFFFF?style=flat&logo=GitLab&logoColor=FC6D26">
</div>
<br />

### :pick: Development

<div>
  <img src="https://img.shields.io/badge/Spring Boot-FFFFFF?style=flat&logo=springboot&logoColor=6DB33F">
  <img src="https://img.shields.io/badge/Flutter-FFFFFF?style=flat&logo=flutter&logoColor=02569B">
  <img src="https://img.shields.io/badge/FastAPI-FFFFFF?style=flat&logo=fastapi&logoColor=009688">
  <img src="https://img.shields.io/badge/Firebase-FFFFFF?style=flat&logo=firebase&logoColor=FFCA28">
  <img src="https://img.shields.io/badge/TensorFlow-FFFFFF?style=flat&logo=tensorflow&logoColor=FF6F00">
  <img src="https://img.shields.io/badge/Redis-FFFFFF?style=flat&logo=redis&logoColor=DC382D">
  <img src="https://img.shields.io/badge/MongoDB-FFFFFF?style=flat&logo=mongodb&logoColor=47A248">
  <img src="https://img.shields.io/badge/MariaDB-FFFFFF?style=flat&logo=mariadb&logoColor=003545">
  <img src="https://img.shields.io/badge/Docker-FFFFFF?style=flat&logo=docker&logoColor=2496ED">
  <img src="https://img.shields.io/badge/Jenkins-FFFFFF?style=flat&logo=jenkins&logoColor=D24939">
  <img src="https://img.shields.io/badge/Nginx-FFFFFF?style=flat&logo=nginx&logoColor=009639">
</div>
<br />

### :mega: Communication

<div>
  <img src="https://img.shields.io/badge/Mattermost-FFFFFF?style=flat&logo=Mattermost&logoColor=0058CC">
  <img src="https://img.shields.io/badge/Notion-FFFFFF?style=flat&logo=Notion&logoColor=000000">
	<img src="https://img.shields.io/badge/Jira-FFFFFF?style=flat&logo=Jira&logoColor=0052CC">
</div>
<br />

## 5. 이미지 생성 과정

1. 모델을 돌려서 키워드 리스트를 획득

2. 각 키워드마다 선 생성한 프롬프트를 받아오고 이미지와 합성한 프롬프트를 통해 stable diffusion모델로 이미지 생성

3. 각 키워드마다 선 생성한 제목 키워드 리스트에서 랜덤하게 제목 단어들, 내용 문단들을 가져와 분석 결과의 제목과 내용 생성

<img src="https://github.com/Ninucco/.github/blob/main/profile/images/image_gen.png?raw=true">

## 6. ERD

![MariaDB ERD](https://github.com/Ninucco/Ninucco/assets/31383362/e5b61729-6bbc-4846-a33d-5afb33def313)

## 7. 서비스 및 기술 특장점

1. 얼굴 분석을 통해 분석 결과와 새로운 프로필 이미지를 제공합니다.

2. 다양한 질문과 사진으로 유저 간 대결이 가능합니다.

3. AI을 통해 사용자에게 차별화된 서비스를 제공합니다.

   - Keras 분석 모델을 통해 키워드를 추출하고, 해당 키워드를 기반으로 프롬프트를 생성합니다.

   - Stable Diffusion 이미지 생성 모델을 사용해 이미지와 프롬프트를 기반으로 프로필 이미지와 분석 결과를 생성합니다.

4. 설계한 데이터베이스를 RDB와 NoSQL DB을 통해 구현했습니다.(기본: MariaDB, 검사 결과: MongoDB, 키워드-프롬프트, 한글 키워드, 제목과 내용 맵핑: Redis)

5. Firebase를 통해 유저 보안을 꾀했습니다. 또한 익명 로그인 기능을 통해 로그인하지 않고도 일부 기능을 이용할 수 있습니다.

6. 검사 결과를 카카오톡을 통해서 공유할 수 있습니다.

7. 생성된 이미지를 통해서 다른 유저와 배틀을 할 수 있고, 배틀을 통해서 코인을 획득할 수 있습니다.

## 8. 멤버 및 역할

<table>
  <tr>
    <td align="center"><a href="https://github.com/TraceofLight"><img src="https://avatars.githubusercontent.com/u/98262849?v=4?s=100" width="100px;" alt=""/><br /><sub><b>김희준 (FE)</b></sub></a></td>
    <td align="center"><a href="https://github.com/IRyeong"><img src="https://avatars.githubusercontent.com/u/31383362?v=4?s=100" width="100px;" alt=""/><br /><sub><b>박이령 (FE)</b></sub></a></td>
    <td align="center"><a href="https://github.com/S2Hyeon"><img src="https://avatars.githubusercontent.com/u/58657060?v=4?s=100" width="100px;" alt=""/><br /><sub><b>송승현 (BE)</b></sub></a></td>
    <td align="center"><a href="https://github.com/developerhongjulee"><img src="https://avatars.githubusercontent.com/u/70627908?v=4?s=100" width="100px;" alt=""/><br /><sub><b>이홍주 (BE)</b></sub></a></td>
    <td align="center"><a href="https://github.com/v7153623"><img src="https://avatars.githubusercontent.com/u/71223238?v=4?s=100" width="100px;" alt=""/><br /><sub><b>장인혁 (BE)</b></sub></a></td>
    <td align="center"><a href="https://github.com/hi6724"><img src="https://avatars.githubusercontent.com/u/68803719?v=4?s=100" width="100px;" alt=""/><br /><sub><b>하훈목 (FE, 팀장)</b></sub></a></td>
  </tr>
</table>
