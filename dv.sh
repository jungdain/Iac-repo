#!/bin/bash

# 모든 볼륨 가져오기
VOLUMES=$(openstack volume list -f value -c ID)

# 볼륨 삭제 작업 수행
if [ -z "$VOLUMES" ]; then
  echo "삭제할 볼륨이 없습니다."
  exit 0
fi

echo "다음 볼륨을 삭제합니다:"
echo "$VOLUMES"

for VOLUME_ID in $VOLUMES; do
  echo "볼륨 ID: $VOLUME_ID -> 상태 설정 및 삭제 중..."
  
  # 볼륨을 detached 상태로 설정
  openstack volume set --detached "$VOLUME_ID"
  
  # 볼륨 삭제
  openstack volume delete "$VOLUME_ID"
  
  if [ $? -eq 0 ]; then
    echo "볼륨 $VOLUME_ID 삭제 완료."
  else
    echo "볼륨 $VOLUME_ID 삭제 실패."
  fi
done

echo "모든 볼륨 삭제 작업이 완료되었습니다."

