# 포트폴리오 HTML 생성

JD 채점 기준과 프로젝트 파일들을 매핑하여 최적화된 포트폴리오 HTML을 생성합니다.
생성물은 Figma의 "HTML to Figma" 플러그인으로 바로 import 가능합니다.

## 실행 방법

```
/generate-portfolio jd=channeltalk-ai-po-202504
```

jd 파라미터를 생략하면 `jds/` 폴더의 최신 파일을 자동으로 사용합니다.

## 커맨드 지침

### STEP 1 — 파일 로드
반드시 이 순서로 파일을 읽을 것:

1. `design/design.md` ← **디자인 시스템 (필수 선행 로드)**
2. `jds/{jd-id}.md` ← 채점 기준 역추산 결과
3. `projects/*.md` ← 전체 프로젝트 파일 (단, `_template.md` 제외)

### STEP 2 — 커버리지 매핑
JD의 채점 기준 × 프로젝트 목록으로 매핑 테이블 생성:

```
평가 기준        | 가중치 | 매핑 프로젝트          | 커버 강도
─────────────────|--------|------------------------|──────────
AI 도구 활용     | 상     | content-automation     | ★★★
데이터 기반 의사결정 | 상  | dashboard-redesign     | ★★★
프로세스 자동화  | 중     | content-automation     | ★★★
B2B 도메인 이해  | 중     | b2b-admin             | ★★
PO 경험         | 상     | personal-mvp          | ★★
...
```

이 분석을 사용자에게 먼저 보여주고 확인 받은 후 HTML 생성 진행.

### STEP 3 — 슬라이드 구성 설계
커버리지 분석 기반으로 최적 슬라이드 순서를 설계:

**기본 슬라이드 구성 (11슬라이드 기준):**
1. 커버 (이름, 직무 타겟, 핵심 태그라인)
2. 나를 한 문장으로 + 커리어 요약
3. 핵심 역량 3가지 (JD 가중치 상 기준 선별)
4~9. 개별 프로젝트 슬라이드 (커버리지 높은 순 배치)
10. 기술 스택 & 도구 맵
11. 마무리 (지원 동기 또는 포지션 연결 메시지)

슬라이드 수는 프로젝트 개수에 따라 조정 (최소 8, 최대 14).
사용자에게 구성안 확인 후 생성 진행.

### STEP 4 — HTML 생성

#### 필수 기술 규격
- 슬라이드 크기: **1280 × 720px** (고정, 반응형 아님)
- 모든 수치: **px 단위만** 사용 (%, vw, cqw, em, rem 사용 금지)
- 폰트: `SF Pro Display, system-ui, -apple-system, sans-serif`
- 각 슬라이드: `<section class="slide" style="width:1280px; height:720px; position:relative; overflow:hidden;">`

#### 디자인 적용 원칙 (design.md 기반)
- 라이트 슬라이드: `background: #ffffff` 또는 `#f5f5f7`
- 다크 슬라이드: `background: #272729` (텍스트: `#ffffff`)
- 라이트/다크 교차 배치로 리듬감 생성
- 유일한 인터랙티브 색상: `#0066cc`
- 헤드라인: weight 600, letter-spacing -0.28px ~ -0.374px
- 보디카피: 17px, weight 400, line-height 1.47
- 그라디언트 완전 금지 / 카드 그림자 금지 / 이모지 금지
- 수치 플레이스홀더 `◯`는 그대로 출력 (임의 수치 생성 금지)

#### 프로젝트 슬라이드 구조 (슬라이드당)
```
[문제 태그라인 — 한 줄, 21px/600]
[프로젝트명 — 40px/600, letter-spacing -0.28px]
─────────────────────────────────────────
[배경: 어떤 구조적 문제였나 — 2~3줄]
[내가 만든 변화: 핵심 설계 결정 — 2~3줄]
[결과: 핵심 수치 또는 ◯ — 강조 표시]
─────────────────────────────────────────
[사용 도구 태그들 — caption 사이즈]
```

### STEP 5 — 파일 저장
- 저장 경로: `output/{jd-id}-portfolio.html`
- 단일 HTML 파일에 모든 슬라이드를 `<section>` 태그로 구성
- 파일 상단 주석에 생성 정보 기록:
  ```html
  <!-- 
    Portfolio: {기업명} {직무명}
    Generated: {YYYY.MM.DD}
    JD: {jd-id}
    Projects: {사용된 프로젝트 목록}
    Design: design.md
  -->
  ```

### STEP 6 — Figma 사용 안내
생성 완료 후 출력:
```
✅ 포트폴리오 HTML 생성 완료
📁 경로: output/{filename}.html
📐 규격: 1280×720px × {N}슬라이드
🎯 타겟 JD: {기업명} {직무명}

── Figma Import 방법 ──
1. Figma 열기 → 새 FigJam 또는 Design 파일
2. 플러그인: "HTML to Figma" 실행
3. 생성된 HTML 파일 내용을 플러그인에 붙여넣기
4. Import 클릭

── 수치(◯) 확정 후 ──
해당 프로젝트 파일(projects/*.md)의 결과 테이블 수정 후
/generate-portfolio 재실행하면 업데이트된 버전 생성
```
