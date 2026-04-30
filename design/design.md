# PM Portfolio Design System v3
> Claude CLI가 `project.md`를 읽고 인사담당자용 HTML 슬라이드를 생성할 때 따르는 디자인 규칙서.
> 기준 레퍼런스: `pm스쿨-마케팅팀-포트폴리오.pdf` (김종윤)
> 출력 흐름: design.md + project.md → Claude CLI → HTML → HTML-to-Figma → Figma 수정 → PPT export

---

## 0. 디자인 철학 (반드시 첫 작업 전 읽기)

```
1. 흰 배경이 디폴트. 풀블리드 컬러는 표지/문제재정의/결말에만.
2. 잉크는 강조에만. 슬라이드당 컬러 면적 ≤ 30%.
3. 차트는 도구이지 장식이 아니다. 단, 임팩트 있는 데이터는 반드시 차트로.
4. 슬라이드 1장에 도형/시각요소 최소 3종 이상. 텍스트만 있는 슬라이드 금지.
5. 폰트 강조는 컬러 변경으로만. 폰트 크기 점프, 그림자, 그라디언트 금지.
6. 슬라이드 1장에 인사이트 1개. 결론은 반드시 하단 풀폭 인사이트 바로 강제.
7. 데이터 구조/아키텍처 프로젝트는 반드시 다이어그램 또는 코드 블록 슬라이드 포함.
```

---

## 1. ⚠️ 풍부함 강제 규칙 (Anti-단조로움 정책)

CLI가 자주 빠지는 함정: "텍스트 카드만 3개 나열". 이를 방지하기 위한 강제 규칙.

### 1-1. 슬라이드별 시각요소 최소 개수

```
모든 슬라이드는 다음 중 최소 3종을 포함해야 한다:

  □ Pill 배지 (섹션 라벨)               ← 거의 모든 슬라이드 필수
  □ Number Callout (대형 수치)
  □ 차트 (막대/도넛/꺾은선/비교바)
  □ 비교표
  □ 카드 (--soft, --blue, default 중 1종 이상)
  □ Sub-card (카드 내부의 작은 박스 — 배경색 달라야 함)
  □ 다이어그램 노드 + 화살표
  □ 목업 placeholder (모바일/데스크탑)
  □ 코드 블록 (다크 배경)
  □ 인사이트 바 (하단 풀폭)
  □ 좌측 4px 색 막대 + 텍스트 (decision card 패턴)
  □ 번호 배지 (원형 + 숫자)

❌ 금지: <p>+<h2>+<ul>만으로 슬라이드 구성
✅ 권장: 카드 안에 sub-card, sub-card 안에 작은 수치/배지가 nested되도록
```

### 1-2. 카드 내부 패턴 (Nested Pattern)

CLI 결과물에서 가장 부족했던 부분. 카드 안에 또 다른 시각 요소를 넣어 정보 위계를 만든다.

```html
<!-- ❌ 단조로운 카드 (CLI가 자주 만드는 패턴) -->
<div class="card">
  <h3>제목</h3>
  <p>본문 텍스트만 있음</p>
</div>

<!-- ✅ 풍부한 카드 (마케팅팀 PDF 실제 패턴) -->
<div class="card">
  <span class="pill pill--soft">레이블</span>      <!-- 1. 배지 -->
  <h3>카드 제목</h3>
  <p>본문 설명</p>

  <!-- 2. Sub-card: 배경색 다른 작은 박스 -->
  <div class="sub-card sub-card--blue">
    <span class="xs">CASE 1</span>                  <!-- 3. 작은 라벨 -->
    <div class="num-callout">487,000<span>건</span></div>  <!-- 4. 수치 -->
    <p class="small">실제 영향 텍스트</p>
  </div>

  <!-- 5. 하단 강조 라인 -->
  <div class="card__footer">
    → <strong class="hl-blue">핵심 인사이트</strong>
  </div>
</div>
```

```css
.sub-card {
  background: var(--bg);
  border-radius: 10px;
  padding: 12px 16px;
  margin-top: 12px;
}
.sub-card--blue { background: var(--blue-soft); }
.sub-card--ink  { background: var(--ink); color: #fff; }

.card__footer {
  margin-top: 12px;
  padding-top: 12px;
  border-top: 1px solid var(--line);
  font-size: 13px;
  font-weight: 600;
  color: var(--blue);
}
```

### 1-3. 슬라이드 종류별 차트 강제 사용 규칙

```
RESEARCH 슬라이드 (배경/시장)
  → 반드시 차트 2-3개 (막대/도넛/꺾은선 중 조합)

OUTCOME 슬라이드 (결과)
  → 반드시 다음 중 2개 이상 동시 포함:
    □ 비교표 (Before/After 컬럼, 빨간 강조)
    □ KPI 카드 그리드 (Before 취소선 + After 큰 수치)
    □ Bar 차트 (Before/After 비교)

DATA ARCHITECTURE 슬라이드
  → 반드시 다음 중 2개 이상 동시 포함:
    □ 코드 블록 (DDL/스키마, 다크 배경)
    □ Layer 다이어그램 (노드 + 화살표)
    □ ERD 또는 플로우

WIREFRAME 슬라이드
  → 반드시 목업 placeholder 3-5개 가로 배치
  → 각 목업 하단에 캡션 (화면명 굵게 + 1줄 설명)
```

---

## 2. 컬러 시스템

```css
/* Base */
--bg:        #FFFFFF
--ink:       #111111
--ink-sub:   #555555
--ink-mute:  #999999
--line:      #E5E5E5
--surface:   #F7F8FA

/* Brand */
--blue:      #2B5CFF
--blue-deep: #1A3FCC
--blue-soft: #EAF0FF

/* Accent — 슬라이드당 1종만 추가 사용 */
--yellow:    #FFD500   /* 다크 배경 키워드만 */
--green:     #00B26A   /* TOBE, 긍정 */
--red:       #E63946   /* ASIS, 비교표 강조 */
--orange:    #F77F00   /* 트레이드오프, 보조 강조 */

/* Light variants for problem/risk badges */
--red-soft:    #FFE5E7
--orange-soft: #FFF1DC
--green-soft:  #E5F5EE

/* Chart */
--chart-primary: #2B5CFF
--chart-base:    #C7CDD9
```

**컬러 사용 규칙:**

| 요소 | 컬러 |
|------|------|
| 본문, 일반 제목 | `--ink` |
| 슬라이드 메인 키워드 (1-2개) | `--blue` 또는 `--yellow`(다크 배경에서만) |
| 차트 강조 막대/선 | `--blue` |
| 차트 비교군 | `--chart-base` (회색) |
| 하단 인사이트 바 | `--blue` 또는 `--ink` 배경 |
| 비교표 헤더 | `--blue` 배경 |
| 비교표 강조 행/열 테두리 | `--red` (1.5px) |
| 문제/리스크 배지 | `--red-soft` 배경 + `--red` 텍스트 |
| 솔루션/긍정 배지 | `--blue-soft` 배경 + `--blue` 텍스트 |
| 트레이드오프 텍스트 | `--orange` |

---

## 3. 타이포그래피

```css
font-family: "Pretendard", "Apple SD Gothic Neo", "Noto Sans KR", sans-serif;

--display:  72px / 900 / line-height 1.05  /* 표지 */
--h1:       44px / 800 / line-height 1.2   /* 슬라이드 메인 제목 */
--h2:       28px / 700 / line-height 1.3   /* 슬라이드 서브 제목 */
--h3:       20px / 700 / line-height 1.4   /* 카드 제목 */
--body-lg:  18px / 500 / line-height 1.7
--body:     15px / 400 / line-height 1.7
--small:    13px / 500 / line-height 1.5
--xs:       11px / 600 / line-height 1.4   /* 라벨, 출처 */
```

**핵심 강조 패턴:**

```
✓ 키워드만 컬러 변경:
  "<span class="hl-blue">3단계 계층</span>이 DB에 구축되어야"

✓ 핵심 수치 + 단위 분리 (num-callout):
  "<div class='num-callout'>130<span>조원</span></div>"
   └ 56px, 800, --blue    └ 24px, 700

✗ 폰트 사이즈 점프 (작은 글씨를 크게)
✗ 한 슬라이드에 색깔 3가지 이상
```

---

## 4. 레이아웃

```
슬라이드 규격: 1280x720px
패딩: 60px 72px (상하 60, 좌우 72)
그리드: 12 column, gap 24px
```

**핵심 레이아웃 6종:**

```
[A] 헤더 + 차트 그리드 + 인사이트 바 (RESEARCH)
┌──────────────────────────┐
│ 섹션 라벨 + pill         │
│ 메인 제목 (h1)           │
├─────┬─────┬─────────────┤
│차트1│차트2│차트3         │ ← 각각 num-callout + mini chart
├─────┴─────┴─────────────┤
│ ▓ 인사이트 바 ▓          │
└──────────────────────────┘

[B] 헤더 + 좌우 2분할 (DATA ARCHITECTURE 등)
┌──────────────────────────┐
│ 섹션 라벨                │
│ 메인 제목                │
├─────────────┬────────────┤
│ 코드 블록   │ 다이어그램  │
│ (다크)      │ (노드)     │
└─────────────┴────────────┘

[C] 헤더 + 3분할 카드 (PROBLEM, SOLUTION)
┌──────────────────────────┐
│ 섹션 라벨 + 메인 제목    │
├──────┬──────┬───────────┤
│카드1 │카드2 │카드3       │
│ +sub │ +sub │ +sub       │ ← 각 카드 안에 sub-card 필수
│ +foot│ +foot│ +foot      │
└──────┴──────┴───────────┘

[D] 와이어프레임 가로 5분할
┌──────────────────────────┐
│ 메인 문장 (강조 키워드)  │
├──┬──┬──┬──┬─────────────┤
│📱│📱│📱│📱│📱            │ ← (필요이미지: ...) placeholder
│캡│캡│캡│캡│캡            │
├──┴──┴──┴──┴─────────────┤
│ ▓ 인사이트 바 ▓          │
└──────────────────────────┘

[E] 풀블리드 인사이트 (PROBLEM REFRAMING, INSIGHT)
┌──────────────────────────┐
│   ▓ 통째로 다크 배경 ▓   │
│      메인 인사이트       │
│      A안 → B안 비교      │
│      인용 박스           │
└──────────────────────────┘

[F] Decision Log (좌측 4px 바 + 카드 5-6개)
┌──────────────────────────┐
│ 섹션 라벨 + 메인 제목    │
├──────────────────────────┤
│ ▎01 판단 제목            │
│   판단 근거 + 트레이드오프│
│ ▎02 판단 제목            │
│ ...                      │
└──────────────────────────┘
```

---

## 5. 도형 라이브러리 (10종 + 패턴)

### 5-1. Pill Badge

```html
<span class="pill pill--blue">SOLUTION</span>
<span class="pill pill--soft">CASE 1</span>
<span class="pill pill--outline">키워드</span>
<span class="pill pill--problem">PROBLEM 01</span>  <!-- 빨강 -->
```

```css
.pill { padding: 6px 16px; border-radius: 999px; font-size: 13px; font-weight: 600; }
.pill--blue    { background: var(--blue); color: #fff; }
.pill--soft    { background: var(--blue-soft); color: var(--blue); }
.pill--outline { border: 1.5px solid var(--blue); color: var(--blue); }
.pill--problem { background: var(--red-soft); color: var(--red); }
.pill--success { background: var(--green-soft); color: var(--green); }
.pill--ink     { background: var(--ink); color: #fff; }
```

### 5-2. Card + Sub-card (Nested Pattern)

```html
<div class="card">
  <span class="pill pill--soft">CASE 1</span>
  <h3 class="h3">카드 제목</h3>
  <p class="body">본문 설명</p>

  <!-- Sub-card 1 — 데이터/사례 -->
  <div class="sub-card">
    <div class="xs">실제 사례</div>
    <div class="body" style="font-weight:600;">487,000건이 어디서 왔는지 모름</div>
  </div>

  <!-- Sub-card 2 — 강조 결론 -->
  <div class="sub-card sub-card--blue">
    <div class="xs hl-blue">결과</div>
    <div class="body" style="font-weight:700;">측정 가능한 채널 0개</div>
  </div>

  <!-- 카드 푸터 -->
  <div class="card__footer">
    → <strong class="hl-blue">단일 채널로 자동 병합</strong>
  </div>
</div>
```

### 5-3. Number Callout

```html
<!-- 일반 -->
<div class="num-callout">
  <div class="num-callout__value">487,000<span>건</span></div>
  <div class="num-callout__label">헤이딜러 클릭 (출처 미상)</div>
  <div class="num-callout__source">출처: 카피아 어드민 (2025.10)</div>
</div>

<!-- ○ 처리 -->
<div class="num-callout num-callout--empty">
  <div class="num-callout__value">○○<span>%</span></div>
  <div class="num-callout__label">전환율 개선 (수치 미정)</div>
</div>

<!-- Before/After 결합형 (KPI 카드) -->
<div class="kpi-card">
  <div class="kpi-card__label">월 발행량</div>
  <div class="kpi-card__before">25건</div>  <!-- 취소선 -->
  <div class="kpi-card__after">102건</div>  <!-- 큰 블루 -->
  <div class="kpi-card__delta">+308%</div>  <!-- 그린 -->
</div>
```

```css
.num-callout__value {
  font-size: 56px; font-weight: 800;
  color: var(--blue);
  line-height: 1; letter-spacing: -0.03em;
}
.num-callout__value span { font-size: 24px; margin-left: 4px; }
.num-callout--empty .num-callout__value { color: var(--ink-mute); }

.kpi-card {
  background: var(--surface);
  border-radius: 16px;
  padding: 20px;
  text-align: center;
}
.kpi-card__before {
  font-size: 14px;
  color: var(--ink-mute);
  text-decoration: line-through;
}
.kpi-card__after {
  font-size: 36px; font-weight: 800;
  color: var(--blue);
  line-height: 1;
  margin-top: 4px;
}
.kpi-card__delta {
  font-size: 12px; font-weight: 700;
  color: var(--green);
  margin-top: 4px;
}
```

### 5-4. Comparison Table (벤치마킹/결과)

```html
<table class="cmp">
  <thead>
    <tr>
      <th style="text-align:left;">지표</th>
      <th>Before</th>
      <th class="cmp__hl-col">After</th>
      <th>비고</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>채널 성과 확인 시간</td>
      <td>2~3일</td>
      <td class="cmp__hl-col"><strong class="hl-blue">실시간</strong></td>
      <td>API 연동 완료 시</td>
    </tr>
    <tr>
      <td>○○ 비용 (수치 미정)</td>
      <td>○○만원</td>
      <td class="cmp__hl-col">○○만원</td>
      <td>(추후 측정)</td>
    </tr>
  </tbody>
</table>
```

```css
.cmp { width: 100%; border-collapse: separate; border-spacing: 0; }
.cmp th, .cmp td {
  padding: 14px 16px;
  text-align: center;
  font-size: 14px;
  border-bottom: 1px solid var(--line);
}
.cmp thead th {
  background: var(--blue);
  color: #fff;
  font-weight: 700;
}
.cmp tbody td:first-child {
  background: var(--surface);
  font-weight: 600;
  text-align: left;
}
.cmp__hl-col {
  border-left: 1.5px solid var(--red) !important;
  border-right: 1.5px solid var(--red) !important;
}
```

### 5-5. Decision Card (좌측 4px 바)

```html
<div class="decision-row">
  <div class="decision-row__num">01</div>
  <div class="decision-row__content">
    <h3 class="h3" style="font-size:16px;">판단 제목</h3>
    <p class="small">판단 근거 + <span class="hl-blue">핵심 키워드</span></p>
    <p class="decision-row__trade">트레이드오프: 자동화율 일부 희생</p>
  </div>
</div>
```

```css
.decision-row {
  display: flex;
  gap: 16px;
  border-left: 4px solid var(--blue);
  padding: 14px 0 14px 20px;
}
.decision-row__num {
  flex: 0 0 28px;
  height: 28px;
  border-radius: 8px;
  background: var(--blue-soft);
  color: var(--blue);
  font-weight: 800;
  font-size: 13px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.decision-row__trade {
  color: var(--orange);
  font-size: 12px;
  font-weight: 600;
  margin-top: 4px;
}
```

### 5-6. Code Block (DDL, 스키마)

```html
<div class="code-block">
  <div class="code-block__title">channel_master DDL (신설)</div>
  <div class="code-block__body">
    <div><span class="code-key">channel_id</span>    <span class="code-type">VARCHAR(20)</span> <span class="code-comment">PK</span></div>
    <div><span class="code-key">channel_name</span>  <span class="code-type">VARCHAR(50)</span></div>
    <div><span class="code-key">group_id</span>      <span class="code-type">VARCHAR(20)</span> <span class="code-comment">FK</span></div>
    <div><span class="code-key">is_active</span>     <span class="code-type">BOOLEAN</span></div>
  </div>
</div>
```

```css
.code-block {
  background: #1A1A1A;
  border-radius: 12px;
  padding: 18px 20px;
  font-family: 'SF Mono', 'JetBrains Mono', Consolas, monospace;
}
.code-block__title {
  font-size: 11px;
  font-weight: 700;
  color: #7BA7FF;
  margin-bottom: 10px;
  letter-spacing: 0.1em;
}
.code-block__body {
  font-size: 12px;
  color: #fff;
  line-height: 1.9;
}
.code-key     { color: #7BA7FF; }
.code-type    { color: var(--yellow); }
.code-comment { color: #888; }
```

### 5-7. Flow Node + Layer Diagram

```html
<!-- 단일 노드 -->
<div class="node node--blue">채널 (Channel)</div>

<!-- 레이어 다이어그램 (3-Layer 계층 등) -->
<div class="layer-row">
  <div class="node node--blue">채널</div>
  <div class="layer-row__info">
    <div class="xs">channel_master · 신설</div>
    <div class="layer-row__num">33<span>개</span></div>
  </div>
</div>
<div class="layer-arrow">↓</div>  <!-- 노드 사이 화살표 -->
<div class="layer-row">
  <div class="node node--ink">UTM 그룹</div>
  ...
</div>
```

```css
.node {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 10px 20px;
  border-radius: 12px;
  font-size: 13px;
  font-weight: 700;
  color: #fff;
  min-width: 120px;
  text-align: center;
}
.node--blue   { background: var(--blue); }
.node--green  { background: var(--green); }
.node--orange { background: var(--orange); }
.node--ink    { background: var(--ink); }
.node--soft   { background: var(--blue-soft); color: var(--blue); }

.layer-row {
  display: flex;
  align-items: center;
  gap: 16px;
  width: 100%;
}
.layer-arrow {
  width: 2px;
  height: 24px;
  background: var(--ink);
  margin-left: 70px;
}
```

### 5-8. Insight Bar (하단 풀폭 결론)

```html
<div class="insight-bar">
  데이터가 <span style="color:var(--yellow);">없는 게 아니라</span>, 데이터를 읽는 구조가 없었다
</div>
<div class="insight-bar insight-bar--ink">검정 버전</div>
<div class="insight-bar insight-bar--outline">아웃라인 버전</div>
```

```css
.insight-bar {
  width: 100%;
  background: var(--blue);
  color: #fff;
  padding: 18px 32px;
  border-radius: 12px;
  font-size: 15px;
  font-weight: 600;
  text-align: center;
  line-height: 1.5;
}
.insight-bar--ink { background: var(--ink); }
.insight-bar--outline {
  background: transparent;
  border: 1.5px solid var(--blue);
  color: var(--ink);
}
```

### 5-9. Mockup Placeholder

```html
<!-- 데스크탑 -->
<div class="mockup-desktop">
  <div class="mockup-desktop__bar">
    <span></span><span></span><span></span>
  </div>
  <div class="mockup-desktop__screen">
    (필요이미지: 채널 성과 대시보드 메인 — 상단 KPI 4개, 좌측 사이드바, 중앙 채널 테이블)
  </div>
</div>

<!-- 모바일 -->
<div class="mockup-phone">
  <div class="mockup-phone__frame">
    <div class="mockup-phone__screen">
      (필요이미지: 회원가입 화면 — 카카오 로그인 버튼 포함)
    </div>
  </div>
  <div class="mockup-phone__caption">회원가입</div>
</div>
```

**(필요이미지: ...) 형식 강제:**

```
형식: (필요이미지: 무엇을 / 어떤 구도 / 어떤 요소 포함)

✅ 좋은 예:
  (필요이미지: 채널 성과 대시보드 — 상단 KPI 카드 4개, 좌측 사이드바, 중앙 33개 채널 테이블)
  (필요이미지: 회원가입 화면 — 카카오 로그인 / 전화번호 가입 / 약관 동의 영역)

❌ 나쁜 예:
  (이미지)
  (스크린샷)
  (대시보드 화면)
```

### 5-10. A/B Compare (3분할 도형)

문제 재정의, 솔루션 결정에서 자주 쓰임. 좌(미채택) → 화살표 → 우(채택) 3분할.

```html
<div class="ab-compare">
  <!-- A안 (미채택) -->
  <div class="ab-box ab-box--rejected">
    <span class="pill pill--problem">A안 · 미채택</span>
    <h3 class="h3">기존 인식</h3>
    <p>대시보드가 없어서 불편</p>
    <p style="color:var(--red); font-weight:600;">→ 화면 만들어도 집계 불가</p>
  </div>

  <!-- 화살표 -->
  <div class="ab-arrow">→</div>

  <!-- B안 (채택) -->
  <div class="ab-box ab-box--accepted">
    <span class="pill pill--blue">B안 · 채택</span>
    <h3 class="h3">재정의한 문제</h3>
    <p>데이터 구조가 없어서 집계 불가</p>
    <p style="color:var(--blue); font-weight:600;">→ 구조부터 설계</p>
  </div>
</div>
```

```css
.ab-compare {
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  gap: 24px;
  align-items: center;
}
.ab-box {
  border-radius: 16px;
  padding: 24px 28px;
}
.ab-box--rejected {
  background: rgba(255,255,255,0.04);
  border: 1px solid rgba(230,57,70,0.2);
}
.ab-box--accepted {
  background: var(--blue-soft);
  border: 1.5px solid var(--blue);
}
.ab-arrow {
  font-size: 32px;
  color: var(--blue);
  font-weight: 700;
}
```

---

## 6. 차트 라이브러리

### 6-1. 차트 사용 결정 트리

```
이 슬라이드에 차트를 넣을 것인가?

  STEP 1: 표현하려는 데이터가 다음 중 하나인가?
    □ 시장 규모 / 성장률 (외부 검증 데이터)
    □ Before / After 변화 (성과)
    □ 비율 / 점유율 (도넛, 파이)
    □ 추세 / 시계열 (꺾은선)
    → NO이면 차트 안 씀.

  STEP 2: 인사담당자에게 임팩트 있는가?
    □ "○억 규모 시장을 다뤘구나"가 보이는가
    □ "○○% 개선했구나"가 보이는가
    → NO이면 텍스트로 처리.

  STEP 3: 수치가 있는가?
    □ 실제 수치 → 차트 그대로 그림
    □ 수치 미정 → ○ 처리한 차트 + "(수치 미정)" 캡션
```

### 6-2. 차트 인라인 SVG 패턴

#### Mini Bar Chart (수치 + 막대 동시)

```html
<svg viewBox="0 0 280 120" style="width:100%;">
  <!-- 비교군 (회색) -->
  <rect x="20"  y="40"  width="100" height="60" fill="#C7CDD9" rx="4"/>
  <text x="70" y="35" text-anchor="middle" font-size="14" font-weight="700" fill="#555">33</text>
  <text x="70" y="115" text-anchor="middle" font-size="11" fill="#999">측정 불가</text>

  <!-- 강조 (빨강 또는 블루) -->
  <rect x="160" y="98" width="100" height="2" fill="#E63946" rx="1"/>
  <text x="210" y="93" text-anchor="middle" font-size="14" font-weight="700" fill="#E63946">0</text>
  <text x="210" y="115" text-anchor="middle" font-size="11" fill="#999">측정 가능</text>
</svg>
```

#### Mini Donut Chart (비율)

```html
<svg viewBox="0 0 200 120" style="width:100%;">
  <!-- 배경 원 -->
  <circle cx="60" cy="60" r="40" fill="none" stroke="#C7CDD9" stroke-width="14"/>
  <!-- 강조 부분 (stroke-dasharray로 비율 표현) -->
  <circle cx="60" cy="60" r="40" fill="none" stroke="#2B5CFF" stroke-width="14"
          stroke-dasharray="75 251" stroke-dashoffset="0"
          transform="rotate(-90 60 60)"/>
  <!-- 중앙 수치 -->
  <text x="60" y="56" text-anchor="middle" font-size="18" font-weight="800" fill="#2B5CFF">○○%</text>
  <text x="60" y="72" text-anchor="middle" font-size="9" fill="#999">분류 가능</text>

  <!-- 우측 범례 -->
  <text x="120" y="50" font-size="11" fill="#555">■ 분류 가능</text>
  <text x="120" y="68" font-size="11" fill="#999">■ 혼재</text>
  <text x="120" y="86" font-size="11" fill="#999">■ 미식별</text>
</svg>
```

#### Mini Comparison Bar (Before/After)

```html
<svg viewBox="0 0 280 120" style="width:100%;">
  <!-- 기존 (긴 회색 막대) -->
  <rect x="20" y="30" width="180" height="20" fill="#C7CDD9" rx="3"/>
  <text x="208" y="44" font-size="13" font-weight="700" fill="#555">2~3일</text>
  <text x="20" y="22" font-size="11" fill="#999">기존: 개발팀 요청</text>

  <!-- 목표 (짧은 블루 막대) -->
  <rect x="20" y="78" width="6" height="20" fill="#2B5CFF" rx="3"/>
  <text x="34" y="92" font-size="13" font-weight="700" fill="#2B5CFF">실시간</text>
  <text x="20" y="70" font-size="11" fill="#999">목표: 직접 조회</text>
</svg>
```

### 6-3. 차트 사용 강제 규칙 (재강조)

```
RESEARCH 슬라이드:
  → 슬라이드 1장에 차트 카드 3개 (각 카드 = num-callout + mini chart + 출처)
  → 차트 카드 안에 num-callout과 SVG가 함께 있어야 함

OUTCOME 슬라이드:
  → 비교표(전체 지표) + KPI 카드(핵심 3-5개) + 정성 변화 카드 3개
  → 한 슬라이드에 시각요소 4종 이상

DATA ARCHITECTURE 슬라이드:
  → 좌측 코드 블록(다크) 2개 + 우측 Layer 다이어그램 + 우측 하단 확장성 박스
```

---

## 7. ○ 처리 규칙 (수치 미정)

```
실제 수치 있음:    "130조원"
부분 수치만 있음:  "○○년 ○○조원" (시계열 미정)
완전 미정:        "○○○건" (자릿수만 표기)
미공개:           "—" (대시 1개)
추정:            "(추정치)" 명시
```

차트에서 ○ 처리:

```html
<!-- y축 수치 미정 -->
<rect x="40" y="100" width="50" height="100" fill="#C7CDD9"/>
<text x="65" y="95" text-anchor="middle" font-size="14" fill="#999">○○</text>
```

KPI 카드에서 ○ 처리:

```html
<div class="kpi-card kpi-card--empty">
  <div class="kpi-card__label">○○ 운영 비용</div>
  <div class="kpi-card__before">○○만원</div>
  <div class="kpi-card__after" style="color:var(--ink-mute);">○○만원</div>
  <div class="kpi-card__delta">(수치 미정 · API 연동 후 측정)</div>
</div>
```

---

## 8. 슬라이드 템플릿 (실제 패턴 명시)

각 템플릿은 **마케팅팀 PDF + 내가 만든 카피아 포트폴리오**의 실제 패턴을 1:1 복기.

### TEMPLATE 1 — 표지 (Cover)

```
배경: --blue-deep 풀블리드
구성:
  좌측 라벨: "PROJECT 01" (--xs, opacity 0.4)
  메인 타이포: 큰 display 텍스트 (3줄로 줄바꿈)
  서브 설명: 2줄
  하단 메타 4줄: Process / Role / Period / Tools
    (Process는 현재 단계만 굵게, 나머지는 opacity 0.5)

  (선택) 우측: 데스크탑 또는 폰 목업 (project가 시각 결과물이 있을 때)

규칙:
  - 우상단 키워드 pill 4-6개 (project tags 활용)
  - 하단 row: 좌하단 조직명 / 우하단 "PM PORTFOLIO"
```

### TEMPLATE 2 — 목차 (Index)

```
배경: 흰색
구성:
  좌상단: 작은 블루 라벨 "Portfolio"
  큰 타이포: "Index." (h1, 끝에 블루 점)
  하단 리스트: 번호 + 제목 (최대 5개)

규칙:
  - 구분선 사용 안 함, 여백으로 구분
  - 각 항목 사이 16px 여백
```

### TEMPLATE 3 — 프로젝트 표지 (Project Cover)

```
배경: --blue-deep 풀블리드
구성:
  좌측 (42%):
    PROJECT 01 라벨
    프로젝트명 (h1, 흰색, 3줄)
    [Overview] 라벨 + 개요 (2-3줄)
    메타 4줄 (Process / Role / Period / Tools)

  우측 (58%):
    데스크탑/모바일 목업 placeholder (큰 사이즈)
    내부 텍스트: (필요이미지: ...)

규칙:
  - 모바일 앱 → 폰 목업
  - B2B 대시보드/어드민 → 데스크탑 목업
  - 둘 다 없는 자동화/AI 프로젝트 → 코드 블록 또는 다이어그램
```

### TEMPLATE 4 — 배경 (Background, RESEARCH 형식)

```
배경: 흰색
구성:
  헤더: section-tag "BACKGROUND" + pill (페이지 번호 또는 카테고리)
  메인 인사이트 (h1, 가운데 또는 좌측 정렬, 키워드 컬러 강조)
  서브 한 줄

  ★ 핵심: 3분할 차트 카드 그리드
    각 카드:
      pill (작은 라벨, 예: "현재 운영 규모")
      num-callout (대형 수치, 예: "33개")
      라벨 (예: "운영 중인 마케팅 채널")
      mini chart (SVG inline, 16:10 비율)
      출처 (xs, ink-mute)

  하단 인사이트 바 (--blue 풀폭)

규칙:
  - 차트 카드 3개 모두 동일 사이즈
  - 각 카드 안에 시각요소 3종 이상 (pill + 수치 + 차트)
  - 인사이트 바 키워드 1-2개 --yellow
```

### TEMPLATE 5 — 3가지 구조적 문제 (Problem Cards)

```
배경: 흰색
구성:
  헤더: section-tag "PROBLEM"
  메인 인사이트 (h2)

  3분할 카드 그리드:
    각 카드:
      ① 원형 번호 배지 (red-soft 배경) + pill (red 라벨)
      ② 카드 제목 (h3)
      ③ 본문 (small)
      ④ Sub-card (--soft 배경)
        - "실제 영향" 라벨
        - 영향 텍스트 (강조 키워드 hl-red)

규칙:
  - 카드 배경은 흰색, 단 sub-card는 --surface
  - 번호 배지 컬러: red-soft / orange-soft / blue-soft 순으로 그라데이션
```

### TEMPLATE 6 — 문제 재정의 (Problem Reframing)

```
배경: --ink (검정 풀블리드) 또는 --blue-deep
구성:
  상단 라벨: "PROBLEM REFRAMING" (--xs, opacity 0.4)

  도입 문장 (32px, opacity 0.5, 취소선 처리):
    "처음에는 ~ 요청이었다."

  메인 재정의 (display, 흰색, 가운데 정렬):
    "○○ 문제가 아니라 [노란 키워드] 문제였다"

  하단 인용 박스:
    좌측 노란/블루 테두리 (3px)
    인용 텍스트 (body-lg)
    핵심 문장 (--yellow 강조)

규칙:
  - 텍스트만, 차트/이미지 없음
  - A/B Compare 박스를 추가하면 더 풍부 (선택)
  - 슬라이드 결론은 "→ ~다음 슬라이드로"
```

### TEMPLATE 7 — 솔루션 핵심 결정 (Solution Decisions)

```
배경: 흰색
구성:
  헤더: section-tag "SOLUTION"
  메인 (h1, 키워드 컬러 강조)

  3분할 카드 (각각 결정 1, 2, 3):
    각 카드:
      pill (--blue, "결정 01 · 데이터 정규화")
      카드 제목 (h3)

      ★ Sub-card 패턴 (필수):
        Sub-card 1: "고려한 대안" (--bg, 취소선 텍스트)
        Sub-card 2: "선택한 방식" (--blue-soft, 강조)

      또는 A/B 비교 row 패턴:
        2칸 분할 (A안 / B안)
        각 칸에 라벨 + 본문 + 결과 (red/green)

      카드 푸터: → 핵심 결과 (--blue 강조)

규칙:
  - 카드 안에 sub-card 또는 비교 row 필수
  - 카드 상단 border 3px 컬러 라인 (decision별로 색 다르게)
```

### TEMPLATE 8 — 데이터 아키텍처 (Data Architecture) ⭐ 새로 추가

```
배경: 흰색
구성:
  헤더: section-tag "DATA ARCHITECTURE"
  메인 (h2, 키워드 강조)

  좌우 분할 (1 : 1.2):
    좌측 (코드 블록):
      "신설 테이블" 라벨 + DDL 코드 블록 (다크)
      "기존 테이블 컬럼 추가" 라벨 + ALTER 코드 블록 (다크)

    우측 (Layer 다이어그램):
      Layer 1: 노드 (--blue) + 라벨 + 큰 수치 ("33개")
      ↓ 화살표 (수직선)
      Layer 2: 노드 (--ink) + 라벨 + 수치 ("44개")
      ↓ 화살표
      Layer 3: 노드 (--soft) + 라벨 + 수치 ("296개")

      하단 확장성 박스 (card--blue):
        라벨 "EXPANSION · 확장성 설계"
        설명 + 강조 키워드

규칙:
  - 코드 블록은 반드시 다크 배경
  - 코드 색상: 키 #7BA7FF / 타입 --yellow / 코멘트 #888
  - Layer 다이어그램 노드 컬러는 위계별로 진하기 다르게
```

### TEMPLATE 9 — 와이어프레임 (Wireframe)

```
배경: --surface (회색 옅게) 또는 흰색
구성:
  헤더: section-tag "WIREFRAME"
  메인 (h2, 가운데, 키워드 강조)

  목업 placeholder 3-5개 가로 배치:
    각 목업:
      mockup-desktop 또는 mockup-phone
      내부 텍스트: (필요이미지: Layer N — 화면 설명)
      하단 캡션:
        - h3 컬러 텍스트 (예: "Layer 1")
        - 화면명 1줄 (예: "채널 성과 메인 테이블")

  하단 인사이트 바

규칙:
  - 데스크탑 프로젝트 → 데스크탑 목업 3개
  - 모바일 프로젝트 → 폰 목업 4-5개
  - 자동화/AI 프로젝트 → 파이프라인 다이어그램 + 코드 블록 (목업 없는 경우)
```

### TEMPLATE 10 — Decision Log (AX/PO 핵심)

```
배경: 흰색
구성:
  헤더: section-tag "DECISION LOG" + pill --ink ("AI 활용 · AX")
  메인 (h2, 키워드 강조)

  Decision Row 5-6개 (세로 또는 2x3 그리드):
    각 row:
      좌측 4px 블루 바 (border-left)
      번호 배지 (28x28, --blue-soft 배경)
      우측 콘텐츠:
        제목 (h3, 16px)
        본문 (small, 키워드 hl-blue)
        트레이드오프 (있으면, --orange)

규칙:
  - tags에 "AI 활용" / "AX" / "PO" 포함되면 필수 슬라이드
  - 각 row 100자 이내
  - 트레이드오프는 모든 row에 있을 필요 없음 (있는 것만)
```

### TEMPLATE 11 — Outcome (결과)

```
배경: 흰색
구성:
  헤더: section-tag "OUTCOMES"
  메인 (h1, 키워드 강조 + 취소선 활용 가능)

  ★ 옵션 A: 비교표 (수치 미정 시 권장)
    cmp 테이블:
      컬럼: 지표 / Before / After (강조 열) / 비고
      ○ 처리는 회색 텍스트로

  ★ 옵션 B: KPI 카드 그리드 (수치 있을 때)
    4-5개 KPI 카드:
      각 카드:
        라벨 (작게)
        Before (회색 취소선)
        After (큰 블루 수치)
        델타 (% 또는 변화량, --green)

  ★ 옵션 C: 옵션 A + B 동시 (가장 풍부, 권장)
    상단: KPI 카드 4개 + 우측 Bar 차트
    하단: 비교표 (전체 지표)

  하단 정성 변화 카드 3개 (card--blue):
    각 카드:
      "구조적 변화 N" 라벨
      변화 설명 (1-2줄)

규칙:
  - 수치 미정 → ○ 처리 (절대 추측 금지)
  - 비교표 After 컬럼은 빨간 테두리 (cmp__hl-col)
  - 시각요소 최소 3종 (표 + KPI + 카드)
```

### TEMPLATE 12 — 한계 및 다음 단계 (Limits & Next Steps)

```
배경: 흰색
구성:
  헤더: section-tag "LIMITS & NEXT STEPS"
  메인 (h2)

  좌우 분할:
    좌측 "현재 한계":
      pill --problem (red)
      한계 카드 2-3개:
        좌측 빨간 보더 + 제목 + 설명

    우측 "개선 방향":
      pill --blue
      개선 카드 3개 (배경 --blue-soft):
        제목 + 설명

  하단 인사이트 바 (선택)

규칙:
  - 한계 카드와 개선 카드 1:1 또는 2:3 비율
  - 한계는 솔직하게, 개선은 구체적으로
```

### TEMPLATE 13 — 결말 (Closing)

```
배경: --blue-deep 풀블리드
구성:
  중앙 큰 타이포 (display, 흰색):
    "도전했습니다."
    구분선 (작은 가로선)
    "감사합니다."

  하단 (절대 위치):
    "CHALLENGE TO BE USEFUL." (--xs, opacity 0.4)
    "끈질긴 관찰로 성장하는 [본인 이름]" (--small, opacity 0.6)

규칙:
  - 표지(T1)와 동일 톤 (수미상관)
```

---

## 9. 슬라이드 시퀀스 (프로젝트 1개 = 9-11 슬라이드)

```
필수 슬라이드 (모든 프로젝트):
  1. PROJECT COVER             [T3]
  2. BACKGROUND (3분할 차트)    [T4]
  3. PROBLEM CARDS (3가지)      [T5]
  4. PROBLEM REFRAMING          [T6]
  5. SOLUTION DECISIONS         [T7]
  9. OUTCOME                    [T11]

조건부 슬라이드:
  6. DATA ARCHITECTURE          [T8]    ※ "데이터 구조" / "DB" / "스키마" 언급 시 필수
  7. WIREFRAME                  [T9]    ※ 시각 결과물 있을 때
  8. DECISION LOG               [T10]   ※ tags에 "AI 활용" / "AX" / "PO" 시 필수
  10. LIMITS & NEXT STEPS       [T12]   ※ ## 6 한계 섹션이 비어있지 않을 때

선택 슬라이드:
  - 인사이트 도출 (T6 변형)
  - 페르소나 (B2B는 보통 생략)

전체 포트폴리오:
  표지(T1) + 목차(T2) + 프로젝트별 9-11장 + 결말(T13)
```

---

## 10. CLI 작업 프로토콜

### STEP 1: project.md 파싱

```
- YAML frontmatter 추출 (id, title, period, role, tags, tools, organization, status)
- ## 1 ~ ## 7 섹션 분리
- ## 7 (활용 메모)는 외부 노출 금지 (참고용)
```

### STEP 2: 슬라이드 계획 수립 (결정 트리)

```
□ tags에 "AI 활용" / "AX" / "PO" / "AI" 포함?
  YES → DECISION LOG 슬라이드 (T10) 필수

□ 본문에 "데이터 구조" / "DB" / "스키마" / "DDL" / "테이블" / "API" 언급?
  YES → DATA ARCHITECTURE 슬라이드 (T8) 필수

□ ## 1 (배경)에 외부 시장 데이터 / 수치 비교 있음?
  YES → RESEARCH 슬라이드 (T4) 차트 3개 포함
  NO  → 텍스트 기반 BACKGROUND이지만 여전히 시각요소 3종 필수

□ ## 4 (결과)에 수치 비교 있음?
  YES → OUTCOME 옵션 B (KPI + 차트)
  NO  → OUTCOME 옵션 A (비교표 + ○)

□ tools에 "React" / "Figma" 또는 본문에 "프로토타입" / "와이어프레임" 언급?
  YES → WIREFRAME 슬라이드 (T9)
  NO  → 자동화 프로젝트면 코드 블록/다이어그램으로 대체

□ project type 판별:
  "모바일" / "앱" / "iOS" / "Android" → 폰 목업
  "대시보드" / "어드민" / "B2B" / "SaaS" → 데스크탑 목업
  "자동화" / "파이프라인" / "스크립트" / "API" → 코드 블록 + 플로우
```

### STEP 3: 시각요소 풍부함 검증 (슬라이드별)

```
각 슬라이드 생성 후 자가 점검:

  □ 시각요소 종류가 3종 이상인가?
    (pill / 카드 / 수치 / 차트 / 코드 / 노드 / 표 / 목업 등)

  □ 카드가 있다면 sub-card 또는 카드 내부 위계가 있는가?
    "단순 텍스트 카드 3개"는 실패 — sub-card 또는 num-callout 추가

  □ 핵심 슬라이드별 강제 요소 충족?
    - RESEARCH → 차트 카드 3개
    - OUTCOME → 표 + KPI + 정성 카드
    - DATA ARCHITECTURE → 코드 블록 + 다이어그램
    - WIREFRAME → 목업 3-5개

  □ 하단 인사이트 바 있는가? (텍스트만 있는 슬라이드 제외)

미충족 시 → 재생성
```

### STEP 4: HTML 생성

```
- 단일 HTML 파일
- <style> 블록은 head에 통합
- 각 슬라이드 = <section class="slide"> 단위
- 1280x720 viewport 기준
- Pretendard CDN 임포트:
  <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" rel="stylesheet">

피그마 친화 규칙:
  ✓ flex / grid 위주 (absolute positioning 최소화)
  ✓ SVG는 inline (외부 파일 X)
  ✓ 외부 이미지 URL 사용 안 함 (placeholder만)
  ✓ rem이 아닌 px 사용 (Figma import 친화)
  ✓ box-shadow 사용 안 함
```

### STEP 5: 품질 체크 (출력 전 필수)

```
□ 슬라이드당 컬러 면적 ≤ 30%
□ 액센트 컬러 슬라이드당 1색만
□ 모든 차트에 출처 표기 또는 (출처 미정)
□ 수치 미정은 모두 ○ 처리
□ 이미지 placeholder는 모두 (필요이미지: 무엇/구도/요소) 형식
□ 슬라이드 마지막에 인사이트 바 또는 결론 문장 (T6/T13 제외)
□ 흰 배경 슬라이드와 컬러 풀블리드 슬라이드 비율 = 7:3 이내
□ 시각요소 3종 미만 슬라이드 = 0개
□ "텍스트만 있는 카드" = 0개 (sub-card 또는 수치 강제)
□ DATA ARCHITECTURE 슬라이드 (해당 시) 있는가?
□ DECISION LOG 슬라이드 (해당 시) 있는가?
```

---

## 11. ⛔ 절대 금지 / ✅ 절대 준수

### 금지

```
✗ 텍스트만 있는 카드 (sub-card 또는 수치 강제)
✗ 슬라이드당 시각요소 2종 이하
✗ 그라디언트, 그림자, blur 효과
✗ 풀블리드 컬러 슬라이드 50% 초과
✗ 추측 수치 작성 (반드시 ○)
✗ 출처 누락 차트
✗ 한 슬라이드 액센트 컬러 2색 이상
✗ 폰트 4종 이상 혼용
✗ 한 슬라이드 텍스트 200자 초과
✗ absolute positioning 남용 → Figma import 시 깨짐
✗ 외부 이미지 URL → 반드시 (필요이미지: ...) placeholder
✗ 흰 배경 위 노란색 글자
✗ DATA ARCHITECTURE 슬라이드 누락 (조건 충족 시)
```

### 준수

```
✓ 흰 배경이 디폴트
✓ 슬라이드당 시각요소 3종 이상
✓ 카드는 sub-card 또는 수치 callout과 결합
✓ RESEARCH는 반드시 차트 3개
✓ OUTCOME은 표 + KPI + 카드 3종
✓ DATA ARCHITECTURE는 코드 + 다이어그램 동시
✓ 수치는 실제 또는 ○
✓ 출처는 반드시
✓ 슬라이드 결론은 하단 풀폭 인사이트 바
✓ 액센트 컬러 1색만, 키워드에만
✓ HTML은 flex/grid 위주 (피그마 친화)
✓ 9-11 슬라이드 시퀀스 준수
```

---

## 12. 참고 패턴 — 카피아 마케팅 대시보드 (베스트 프랙티스)

이 디자인 시스템이 만들어내야 할 결과물의 실제 예시.

```
슬라이드 1 — 프로젝트 표지 [T3]
  좌측: PROJECT 01 라벨 / 카피아 마케팅 성과 대시보드 (3줄) / Overview / 메타 4줄
  우측: 데스크탑 목업 placeholder
  하단: CAPIA · 카피아 / PM PORTFOLIO

슬라이드 2 — 배경 [T4]
  메인: "데이터가 없는 게 아니라 데이터를 읽는 구조가 없었다"
  3분할 차트 카드:
    카드 1: 33개 채널 (num-callout) + Bar 차트 (33 vs 0) + 출처
    카드 2: 296개 링크 (num-callout) + Donut 차트 (○○% 분류 가능) + 출처
    카드 3: 2~3일 (num-callout) + 비교 Bar (2~3일 vs 실시간) + 출처
  하단 인사이트 바: "수작업 없으면 클릭수 외에 아무것도 볼 수 없었다"

슬라이드 3 — 3가지 구조적 문제 [T5]
  3분할 카드 (각각 채널 부재 / 목적 혼재 / 사업부 분리 불가):
    번호 배지 (red-soft) + pill (red) + 제목 + 본문
    Sub-card "실제 영향" + 강조 수치 (487,000건)

슬라이드 4 — 문제 재정의 [T6]
  배경: --ink
  도입 (취소선): "처음에는 '대시보드 부재' 요청이었다"
  메인: "○○ 문제가 아니라 [노란] 문제였다"
  하단 인용 박스: "화면보다 구조가 먼저다"

슬라이드 5 — 솔루션 핵심 결정 [T7]
  3분할 카드 (결정 1, 2, 3):
    pill --blue + 제목 + Sub-card 2개 (대안 / 선택안) + 푸터

슬라이드 6 — 데이터 아키텍처 [T8] ⭐
  좌측: DDL 코드 블록 2개 (channel_master / utm_groups ALTER)
  우측: 3-Layer 다이어그램 (노드 + 화살표 + 수치)
  우측 하단: 확장성 박스 (--blue-soft)

슬라이드 7 — 와이어프레임 [T9]
  3개 데스크탑 목업 가로 배치 (Layer 1, 2, 3)
  각 목업 하단 캡션 (h3 블루)
  하단 인사이트 바 (--ink)

슬라이드 8 — Decision Log [T10] ⭐
  5-6개 Decision Row (좌측 4px 바 + 번호 + 제목 + 본문)

슬라이드 9 — 결과 [T11]
  비교표 (5-6 row, 빨간 강조 열) + 정성 변화 카드 3개

슬라이드 10 — 한계 / 다음 단계 [T12]
  좌우 분할 (한계 3개 / 개선 3개)
  하단 인사이트 바 (핵심 한 문장)
```

---

## 13. 변경 이력

```
v3.0 (2026-04-30)
  - v2 한계 보완: CLI가 단조로운 결과물 생성하는 문제 해결
  - 섹션 1 신설: ⚠️ 풍부함 강제 규칙 (Anti-단조로움 정책)
  - 섹션 5-2 신설: Card + Sub-card Nested Pattern (필수)
  - 섹션 5-10 신설: A/B Compare 도형
  - 섹션 6-3 강화: 차트 사용 강제 규칙
  - TEMPLATE 8 신설: DATA ARCHITECTURE (코드 + 다이어그램)
  - 섹션 10 STEP 3 신설: 시각요소 풍부함 검증 단계
  - 섹션 12 신설: 카피아 베스트 프랙티스 예시
  - 모든 카드는 sub-card 또는 num-callout 결합 강제
  - 슬라이드당 시각요소 3종 이상 강제

v2.0 (2026-04-30)
  - 마케팅팀 PDF 시각 문법 정밀 분석
  - 흰 배경 디폴트 + 프린트 친화
  - 도형 라이브러리 7종 한정
  - 차트 사용 결정 트리
  - ○ 처리 규칙
  - HTML-to-Figma 호환성 우선

v1.0 (폐기) — AI 스러운 다크/그라디언트 테마
```