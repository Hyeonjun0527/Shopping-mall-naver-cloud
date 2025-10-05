#!/bin/bash

# 스크립트가 위치한 디렉토리로 이동합니다.
# 이를 통해 바탕화면 등 다른 위치에서 실행해도 정상적으로 작동합니다.
cd "$(dirname "$0")"

# Myshop12 프로젝트의 전체 배포 과정을 관리하는 스크립트
# 사용법: ./deploy.sh {start|stop}

# 사용자가 입력한 첫번째 인자 (start 또는 stop)
ACTION=$1

# 배포 시작 함수
start_deployment() {
    echo ">>> Step 1: 프로젝트 클린 (mvnw clean)"
    ./mvnw clean
    
    echo ">>> Step 2: 기존 Docker 컨테이너 종료 및 삭제 (docker-compose down -v)"
    docker-compose down -v

    echo ">>> Step 3: Docker 컨테이너 신규 빌드 및 백그라운드 실행 (docker-compose up --build -d)"
    docker-compose up --build -d

    # docker-compose 실행 성공 여부 확인
    if [ $? -ne 0 ]; then
        echo "### 오류: Docker 컨테이너 실행에 실패했습니다. 로그를 확인해주세요."
        exit 1
    fi
    echo ">>> Docker 컨테이너가 성공적으로 시작되었습니다."

    echo ">>> Step 4: Cloudflare Tunnel 백그라운드 실행"
    # 이전에 실행중인 cloudflared 프로세스가 있다면 종료
    pkill cloudflared
    sleep 1 # 잠시 대기
    # nohup과 &를 사용하여 터널을 백그라운드로 실행하고, 로그는 cloudflared.log 파일에 저장
    nohup cloudflared tunnel run myshop-tunnel > cloudflared.log 2>&1 &
    
    echo ""
    echo "==========================================================="
    echo "Myshop12 배포가 백그라운드에서 성공적으로 시작되었습니다"
    echo "이제 이 터미널을 종료해도 배포는 유지됩니다."
    echo ""
    echo "잠시 후 아래 주소로 접속하여 확인할 수 있습니다:"
    echo "https://hyeonjun-project-1.shop"
    echo ""
    echo "터널 연결 상태는 'tail -f cloudflared.log' 명령으로 확인할 수 있습니다."
    echo "==========================================================="
}

# 배포 중지 함수
stop_deployment() {
    echo ">>> Step 1: Docker 컨테이너 종료 및 삭제 (docker-compose down -v)"
    docker-compose down -v

    echo ">>> Step 2: Cloudflare Tunnel 종료"
    pkill cloudflared
    
    echo ""
    echo " Myshop12 배포가 성공적으로 중지되었습니다."
}

# 메인 로직: 사용자의 입력에 따라 start 또는 stop 함수를 실행
case "$ACTION" in
    start)
        start_deployment
        ;;
    stop)
        stop_deployment
        ;;
    *)
        echo "사용법: $0 {start|stop}"
        exit 1
        ;;
esac

exit 0
