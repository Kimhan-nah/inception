# Table of Contents
- [Table of Contents](#table-of-contents)
- [Inception](#inception)
- [1. Alpine Linux](#1-alpine-linux)
- [2. Virtualization](#2-virtualization)
		- [가상화란?](#가상화란)
		- [가상화 종류](#가상화-종류)
- [3. Container](#3-container)
- [4. Docker](#4-docker)
	- [Docker Architecture](#docker-architecture)
	- [Docker Daemon (`dockerd`)](#docker-daemon-dockerd)
	- [Docker Client (`docker`)](#docker-client-docker)
	- [Docker Registries](#docker-registries)
	- [Docker Objects](#docker-objects)
		- [**Images**](#images)
		- [**Containers**](#containers)
		- [Networks](#networks)
		- [Volumes](#volumes)
		- [Plugins](#plugins)
	- [PID 1 (`init system`) in Docker](#pid-1-init-system-in-docker)

# Inception 
- Summary: This document is a System Administration related exercise.
- Version: 1


# 1. Alpine Linux

- **리눅스 커널을 기반으로 한 리눅스 배포판**
- **“Small. Simple. Secure.”**
- 타 리눅스 배포판보다 훨씬 가볍고 깔끔한 것이 장점 → 컨테이너에 흔히 사용됨
    
    [왜 컨테이너 환경에서는 Alpine Linux가 선호될까?](https://velog.io/@dry8r3ad/why-alpine-linux)
    
- **가벼운 용량 (Small)**
    - 가벼운 용량을 컨셉으로 잡은 덕분에 패키지 하나하나의 용량이 매우 작고 기본적으로 man 문서를 분리하여 용량에서 더 많은 이점을 가져갔다고 볼 수 있음
    - `Glibc` 아닌 `Musl` 을 사용하여 더더욱 임베디드에서 가볍게 동작
        - `Musl` : C 라이브러리 `Glibc` 대신 사용. 크기, 정확도, 정적 링킹 지원 등의 장점
    - `BusyBox` 기반으로 단일 바이너리 용량 줄임
        - `BusyBox` : 여러 유닉스 도구(ls, cd)을 한 실행파일로 제공하는 소프트웨어 → 용량 측면에서 이점
    
    ⇒ **클라우드 환경에서 용량은 큰 장점으로 작용**
    
    ⇒ AWS, Azure의 Public Cloud에서 제공하는 서비스를 사용하는 경우, **사용량에 따라서 비용 발생 → 컨테이너 환경에서는 지속적인 배포하고 여러 이미지를 받음**
    
    ⇒ 이 과정에서 네트워크 자원을 사용량 줄여야 함
    
    ⇒ But! 이런 요소들이 기존 배포판과 달라서 문제 해결에 어려움
    
- *Docker가 호스트 운영체제의 커널 위에 격리를 시켜주는 반가상화 시스템?*
- **Secure**
    - 알파인 리눅스에서 제공되는 모든 유저 레벨의 바이너리들은 PIE(Position Independent Executables)로 컴파일 되어 Stack Smashing Protection 되어있다.
    - 또한 가벼운 OS를 지향하는 만큼 기본적으로 설치되어 있는 프로그램이 적음
    - 그만큼 취약점 생길 포인트가 적음 (안전)
    - `PIE` : 리눅스 환경에서의 메모리 보호 기법
    - *실제로 2014년, `ShellShock` 취약점이 발견되었고 공격 대상이 되었던 Bash가 기본적으로 설치되어 있던 대부분의 리눅스 배포판은 이 취약점의 영향을 받았지만 Bash를 기본으로 설치하지 않은 알파인 리눅스는 영향이 없었음*
- `init system`으로 `openRC` 사용함
    - `init system`
        - PID 1인, 커널을 시작할 때 실행되는 첫 번째 프로세스. 좀비 프로세스 관리
        - ex) `systemd` , `openRC`
    

# 2. Virtualization

### 가상화란?

### 가상화 종류

![virtualization](./asset/virtualization.png)

- 베어메탈
    - ex) 멀티 부팅
- 호스트형 가상머신
    - ex) Virtual Box, VM ware
- **컨테이너**
    - ex) Docker

# 3. Container

- **VM과 달리, 호스트 커널 공유하면서 프로세스를 격리된 환경에서 실행하는 기술**
- 커널을 공유하는 방식이기 때문에 **실행 속도가 빠르고, 성능 손실 X**
- 커널을 공유하지만, 커널 기능(ex. namespace)을 활용해 격리(독립)
    
    → 호스트 OS 관점에서는 프로세스로 보이나 내부 들여다 보면 하나의 가상환경
    
- 가상화 기술의 종류

# 4. Docker

## Docker Architecture

![img](https://docs.docker.com/engine/images/architecture.svg)

- Docker Daemon ↔ Docker Client 통신
    - 동일한 시스템에서 실행 or 클라이언트를 원격 데몬에 연결 가능
    - UNIX 소켓 or 네트워크 인터페이스를 통해 `REST API` 사용하여 통신

## Docker Daemon (`dockerd`)

- 실제 동작하는 프로세스
- 도커 엔진의 기능을 수행 후 응답하는 프로세스
- API 요청을 수신하고 이미지, 컨테이너, 네트워크 및 볼륨과 같은 도커 객체를 관리

## Docker Client (`docker`)

- 사용자가 Docker와 상호작용하는 기본 방법
- `docker run`과 같은 명령 사용 → 클라이언트가 명령을 API로 `dockerd`로 보내서 실행
- 또다른 도커 클라이언트 is `Docker Compose`

## Docker Registries

- Docker Image 저장소
- 도커는 default로 Docker Hub에서 Image 찾음
- own private registry도 가능
- default 공용 레지스트리 :  Docker Hub

## Docker Objects

### **Images**

- 컨테이너를 빌드하기 위한 read-only 바이너리 파일

### **Containers**

- 실행가능한 이미지의 인스턴스
- 사용자는 컨테이너를 Docker API를 통해 생성, 삭제 수정, 이동

### Networks

### Volumes

- 컨테이너에서 생성되고 사용되는 데이터를 유지하기 위해 선호되는 메커니즘
- 컨테이너와 관련된 특별한 유형의 디렉터리
- 모든 데이터 유형을 저장할 수 있음 (코드, 로그 파일 등)
- 컨테이너 간에 데이터 공유 가능
- 이미지가 업데이트 될 때 데이터 볼륨에 영향 X → 컨테이너가 컴퓨터에서 삭제된 경우에도 데이터 볼륨은 남아서 여전히 제어 가능
- `bind mount`는 호스트 시스템의 디렉토리 구조와 OS에 따라 다르지만 `Volumes`은 도커에서 완전히 관리함
    - `volumes` VS `bind mount`
        
        ### Volumes
        
        ![https://docs.docker.com/storage/images/types-of-mounts-volume.png](https://docs.docker.com/storage/images/types-of-mounts-volume.png)
        
        > volumes (출처 : docker 공식 문서 [Use volumes](https://docs.docker.com/storage/volumes/))
        
        - `volumes`가 `bind mount` 보다 백업 또는 마이그레이션이 쉬움
        - Docker CLI command 또는 Docker API 사용하여 `Volumes` 관리
        - `Volumes`는 Linux, Windows 컨테이너 모두에서 작동함
        - 여러 컨테이너 간에 `Volumes`을 보다 안전하게 공유할 수 있음
        - `Volumes` 드라이버를 사용하면 원격 호스트 또는 클라우드 제공자에 `Volumes`을 저장하거나 `Volumes`의 내용을 암호화하거나 다른 기능을 추가할 수 있음
        - 새 `Volumes`는 컨테이너에 의해 미리 채워진 콘텐츠를 가질 수 있음
        - Docker Desktop의 `Volumes`는 Mac, Windows 호스트의 `bind mount`보다 훨씬 높은 성능 제공
        
        ### bind mount
        
        ![https://docs.docker.com/storage/images/types-of-mounts-bind.png](https://docs.docker.com/storage/images/types-of-mounts-bind.png)
        
        > bind mount (출처 : docker 공식 문서 [Use bind mounts](https://docs.docker.com/storage/bind-mounts/))
        
        - Docker 초기부터 사용됨
        - `Volumes`에 비해 기능 제한
        - 호스트 시스템의 파일 또는 디렉토리가 컨테이너에 마운트 됨

### Plugins

## PID 1 (`init system`) in Docker

- 리눅스 커널의 PID와 마찬가지로 컨테이너에서 실행된 첫 번째 프로세스는 PID 1을 얻는다
- PID 1로 등록된 단 하나의 프로세스만을 컨테이너가 담당하겠다는 의미
- 단 하나의 컨테이너가 곧 단 하나의 서비스(프로세스)를 의미 → 서버 환경 관리 측면에서 일관성
- 분리된 좀비 프로세스를 제거하는 데에 사용됨
    - 분리된 프로세스 (상위 요소가 사라진 프로세스)는 PID 1이 있는 프로세스에 다시 첨부됨
    - 그러나 컨테이너에서는 PID 1을 갖고 있는 프로세스가 이러한 책임
    - 제대로 제거를 하지 못하면 메모리나 다른 리소스가 부족해질 수 있음
