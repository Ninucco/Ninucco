#!/bin/bash
APP_NAME=ninucco_back
 
# Blue 를 기준으로 현재 떠있는 컨테이너를 체크한다.
EXIST_BLUE=$(docker-compose -p ${APP_NAME}-blue -f docker-compose.blue.yml ps | grep Up)
 
# 컨테이너 스위칭
if [ -z "$EXIST_BLUE" ]; then
    echo "blue up"
    docker-compose -p ${APP_NAME}-blue -f docker-compose.blue.yml up -d
    BEFORE_COMPOSE_COLOR="green"
    AFTER_COMPOSE_COLOR="blue"
else
    echo "green up"
    docker-compose -p ${APP_NAME}-green -f docker-compose.green.yml up -d
    BEFORE_COMPOSE_COLOR="blue"
    AFTER_COMPOSE_COLOR="green"
fi
 
sleep 15
 
# 새로운 컨테이너가 제대로 떴는지 확인
SECONDS=0
while :
do
  EXIST_AFTER=$(docker-compose -p ${APP_NAME}-${AFTER_COMPOSE_COLOR} -f docker-compose.${AFTER_COMPOSE_COLOR}.yml ps | grep Up)
  echo "EXIST_AFTER : ${EXIST_AFTER}"
  if [ -n "$EXIST_AFTER" ]; then
	  TEST_API_STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://k8a605.p.ssafy.io/api/rank/battle)
    echo "TEST_API_STATUS_CODE : ${TEST_API_STATUS_CODE}"
    if [ "$TEST_API_STATUS_CODE" == 200 ]; then
      echo "TEST API SUCCESS !! >> ${AFTER_COMPOSE_COLOR} Container WAS Running!"
      echo "COPY nginx.conf"
      docker cp ../settings/r_proxy/nginx.${AFTER_COMPOSE_COLOR}.conf r_proxy:/etc/nginx/conf.d/default.conf
      echo "restart nginx"
      docker exec r_proxy service nginx reload
      # 이전 컨테이너 종료
      docker-compose -p ${APP_NAME}-${BEFORE_COMPOSE_COLOR} -f docker-compose.${BEFORE_COMPOSE_COLOR}.yml down
      echo "$BEFORE_COMPOSE_COLOR down"
      echo "done"
      break
    fi
  fi
  if [$SECONDS -gt 15]; then
    echo "[server] ERROR: TIMEOUT"
    exit 1
  fi
  sleep 3
  echo "waiting...${SECONDS}"
done
echo "all processes are successfully done"
