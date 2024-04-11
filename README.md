# Table of Contents
1. [Description](#description)
2. [Demo](#Demo)
3. [Main Feature](#main-feature)
4. [Requirements](#requirements)
5. [Stacks](#stacks)
6. [Project Structure](#project-structure)
7. [Developer](#developer)

# WishList

내가 원하는 물품을 쉽게 담아두고 확인하는 WishList

## Description

사고싶은 물건이 있다면? 그런데 지금 당장 구입을 할 수 없는 상태일때 가볍게 등록 하고 확인하는 WishList App

## Demo
<p float="left">
    <img src="https://github.com/Haroldfromk/WishListRepo/assets/97341336/552fc68c-d527-4688-91c7-f612e3922db3" alt="simulator-screenshot-6-F1-BD4-AB-229-D-4-BBD-912-C-52-E6-DF831-F88" width="200">
    <img src="https://github.com/Haroldfromk/WishListRepo/assets/97341336/afb912ab-2bb3-454f-a02f-4d5c285ae03b" width="200">
    <img src="https://github.com/Haroldfromk/WishListRepo/assets/97341336/4c3e73ed-648d-4430-a737-411d0ec803d8" width="200">
    <img src="https://github.com/Haroldfromk/WishListRepo/assets/97341336/09bf1811-bede-43f4-b87a-ab6c39c3df05" width="200">
    <img src="https://github.com/Haroldfromk/WishListRepo/assets/97341336/a508c470-1862-4eac-bc01-d76c508c7b24" width="200">
    <img src="https://github.com/Haroldfromk/WishListRepo/assets/97341336/32aea924-c96f-418e-bb04-5be20bb6dc39" width="200">
    <img src="https://github.com/Haroldfromk/WishListRepo/assets/97341336/60d9b96f-657b-4c0a-b93d-27bc0863d767" width="200">
    <img src="https://github.com/Haroldfromk/haroldfromk.github.io/assets/97341336/683481d6-a1f3-4ee6-920f-754246f5d3d2" width="200">
</p>

## Main Feature
### 간편한 검색
- 편하게 원터치로 다음 물건을 확인

### 담기기능
- 직관적인 버튼으로 한번에 담자.

### 간편한 확인
- id순으로 정렬되어 확인도 간편하게

### 신상 정보도 한번에
- 새로나온 상품 더이상 찾아보고 사지 말고 확인도 한번에

### 중복걱정은 No
- 혹시라도 내가 등록한 아이템이 중복이 된다면? 그런 걱정 없이 사전에 알려주는 Alert로 중복걱정X

### Pull to Refresh
- 다음 버튼말고 당겨서도 다음 물품을 확인할 수 있는 요소 추가

### Swipe 로 삭제도 간편하게
- 삭제는 간편하지만 실수를 방지하기위해 센스있는 삭제 전 확인 기능.

### 여러가지 이미지 제공으로 인한 늘어난 선택의 폭
- 기존에는 한장의 이미지만 보여줬다면 이번에는 여러장의 이미지를 제공 (new)

## Requirements
- App requires **iOS 17.4 or above**

## Stacks
- **Environment**

    <img src="https://img.shields.io/badge/-Xcode-147EFB?style=flat&logo=xcode&logoColor=white"/> <img src="https://img.shields.io/badge/-git-F05032?style=flat&logo=git&logoColor=white"/>

- **Language**

    <img src="https://img.shields.io/badge/-swift-F05138?style=flat&logo=swift&logoColor=white"/> 

## Project Structure

```markdown
WishList
├── Model
│   ├── DataManager
│   ├── DataModel
│   ├── LocalModel
│   └── AlertManager
│
├── View
│   └── MainStoryBoard
│
├── controller
│   ├── ViewController
│   └── DBTableViewController
└ 
```

## Developer
*  **송동익** ([Haroldfromk](https://github.com/Haroldfromk/))
