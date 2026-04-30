#!/bin/bash
# ============================================================
# AX 포트폴리오 자동화 시스템 — 초기 설정 스크립트
# 실행: bash setup.sh
# ============================================================

set -e

echo "🚀 AX 포트폴리오 자동화 시스템 초기 설정 시작..."

# 필요한 폴더 생성
mkdir -p projects jds output design .claude/commands

echo "📁 폴더 구조 생성 완료"

# .gitignore 생성
cat > .gitignore << 'EOF'
# 생성된 포트폴리오 (선택적으로 제외)
# output/

# OS 파일
.DS_Store
Thumbs.db

# 민감 정보가 포함될 수 있는 파일 (필요 시 주석 해제)
# projects/*.md
# jds/*.md
EOF

echo "📝 .gitignore 생성 완료"

# Git 초기화 (아직 안 된 경우)
if [ ! -d ".git" ]; then
  git init
  echo "🔧 Git 저장소 초기화 완료"
fi

echo ""
echo "✅ 설정 완료!"
echo ""
echo "다음 단계:"
echo "  1. design/ 폴더에 DESIGN-apple.md 복사 (이미 있으면 건너뜀)"
echo "  2. claude 명령어로 Claude Code 실행: claude"
echo "  3. /new-project 로 첫 번째 프로젝트 추가"
echo "  4. /new-jd 로 지원할 JD 등록"
echo "  5. /generate-portfolio 로 포트폴리오 생성"
echo ""
echo "GitHub 업로드:"
echo "  git add ."
echo "  git commit -m 'feat: AX 포트폴리오 자동화 시스템 초기 설정'"
echo "  git remote add origin https://github.com/{your-username}/{repo-name}.git"
echo "  git push -u origin main"
