# PM Portfolio Design System v2
> Claude CLI가 `project.md`(기획안)를 읽고 인사담당자용 HTML 슬라이드를 생성할 때 따르는 디자인 규칙서.
> 기준 레퍼런스: `pm스쿨-마케팅팀-포트폴리오.pdf` (김종윤)
> 출력 흐름: design.md + project.md → Claude CLI → HTML → HTML-to-Figma 플러그인 → Figma 수정 → PPT export
> **프린트 환경(흑백 출력 가능성 포함)** 을 고려한 잉크 절약형 디자인.

---

## 0. 디자인 철학

```
1. 흰 배경이 디폴트. 풀블리드 컬러 슬라이드는 표지/챕터 표지/결말에만.
2. 잉크는 강조에만 쓴다. 슬라이드당 컬러 면적 ≤ 30%.
3. 차트는 도구이지 장식이 아니다. 인사담당자에게 임팩트 있는 수치만 차트로.
4. 도형은 단순하게. 둥근 사각형, 원, 직선 화살표만 사용.
5. 폰트 강조는 컬러 변경으로만. 폰트 크기 점프, 그림자, 그라디언트 금지.
6. 슬라이드 1장에 인사이트 1개. 결론은 반드시 하단 풀폭 바로 강제.
```

---

## 1. 컬러 시스템 (프린트 친화)

```css
/* Base — 무조건 흰색 / 검정 */
--bg:              #FFFFFF
--ink:             #111111   /* 본문 텍스트 — pure black보다 살짝 부드럽게 */
--ink-sub:         #555555   /* 서브 텍스트, 캡션 */
--ink-mute:        #999999   /* 출처, 메타 */
--line:            #E5E5E5   /* 보더, 구분선 */
--surface:         #F7F8FA   /* 카드 배경 (옅게) */

/* Brand — 1차 강조 */
--blue:            #2B5CFF   /* 마케팅팀 PDF 블루와 동일 톤 */
--blue-deep:       #1A3FCC   /* 풀블리드 표지 배경 */
--blue-soft:       #EAF0FF   /* 카드 배경, 강조 행 */

/* Accent — 2차 강조 (슬라이드당 1색만 추가 사용) */
--yellow:          #FFD500   /* 키워드 하이라이트 — 검정 위에서만 사용 */
--green:           #00B26A   /* 긍정 변화, TOBE */
--red:             #E63946   /* ASIS, 경고, 비교표 강조 행 테두리 */
--orange:          #F77F00   /* 보조 강조 (드물게) */

/* 차트 전용 */
--chart-primary:   #2B5CFF   /* 강조 막대/선 */
--chart-base:      #C7CDD9   /* 비교용 회색 (잉크 적게) */
```

**컬러 사용 규칙:**

| 요소 | 컬러 |
|------|------|
| 본문, 일반 제목 | `--ink` |
| 슬라이드 메인 키워드 (1-2개) | `--blue` 또는 `--yellow`(다크 배경에서만) |
| 차트 강조 막대/선 | `--blue` |
| 차트 비교군 | `--chart-base` (회색, 잉크 절약) |
| 하단 인사이트 바 | `--blue` 배경 + 흰 텍스트 OR `--ink` 배경 + 흰 텍스트 |
| 비교표 헤더 | `--blue` 배경 + 흰 텍스트 |
| 비교표 강조 행 테두리 | `--red` (1.5px) |

**금지:**
- 그라디언트, 그림자, blur 효과
- 슬라이드당 액센트 컬러 2종 이상 동시 사용
- 컬러 면적 30% 초과
- 흰 배경 위 노란색 텍스트 (가독성)

---

## 2. 타이포그래피

```css
font-family: "Pretendard", "Apple SD Gothic Neo", "Noto Sans KR", sans-serif;

/* Display — 표지에만 */
--display:    72px / 900 / line-height 1.05 / letter-spacing -0.02em

/* Heading */
--h1:         44px / 800 / line-height 1.2     /* 슬라이드 메인 제목 */
--h2:         28px / 700 / line-height 1.3     /* 슬라이드 서브 제목 */
--h3:         20px / 700 / line-height 1.4     /* 카드 제목, 소섹션 */

/* Body */
--body-lg:    18px / 500 / line-height 1.7     /* 본문 강조 */
--body:       15px / 400 / line-height 1.7     /* 일반 본문 */
--small:      13px / 500 / line-height 1.5     /* 캡션, 배지 */
--xs:         11px / 600 / line-height 1.4     /* 출처, 메타 */
```

**핵심 강조 패턴:**

```
✓ 키워드만 컬러 변경:
  "빠르게 증가하는 [고연령 인구]에 따른"
                    └─ --blue, font-weight 700

✓ 핵심 수치 단독 라인 + 큰 사이즈:
  "130조원"  ← 48-56px, weight 800, --blue

✗ 같은 슬라이드에 색깔이 3가지 이상
✗ 폰트 사이즈로 강조 (작은 글씨를 크게 만들기)
```

---

## 3. 레이아웃

```
슬라이드 규격:
  width:   1280px
  height:  720px (16:9)
  padding: 60px 72px

그리드:
  컬럼 12개, gutter 24px

여백 원칙:
  슬라이드 상하단 여백 = 60px 이상 확보
  카드/섹션 간 간격 = 24px 또는 32px
  아이콘과 텍스트 간격 = 12px
```

**기본 레이아웃 패턴 5종:**

```
[A] 헤더 + 풀폭 콘텐츠
┌──────────────────────────┐
│ 라벨 (small)             │
│ 메인 제목 (h1)           │
├──────────────────────────┤
│                          │
│      콘텐츠 영역         │
│                          │
├──────────────────────────┤
│ ▓ 인사이트 바 (블루) ▓   │
└──────────────────────────┘

[B] 좌우 2분할 (5:7 또는 6:6)
┌──────────┬───────────────┐
│ 텍스트   │  차트/이미지  │
│ 영역     │  영역         │
└──────────┴───────────────┘

[C] 상단 헤딩 + 3분할 카드
┌──────────────────────────┐
│       메인 인사이트      │
├──────┬──────┬────────────┤
│ 카드 │ 카드 │ 카드       │
│  1   │  2   │  3         │
└──────┴──────┴────────────┘

[D] 와이어프레임 가로 5분할
┌──────────────────────────┐
│  메인 문장 (강조 키워드) │
├──┬──┬──┬──┬─────────────┤
│📱│📱│📱│📱│📱           │
│캡│캡│캡│캡│캡            │
└──┴──┴──┴──┴──────────────┘

[E] 풀블리드 (표지/결말 전용)
┌──────────────────────────┐
│                          │
│   ▓ 통째로 컬러 배경 ▓   │
│                          │
└──────────────────────────┘
```

---

## 4. 도형 라이브러리

마케팅팀 PDF에서 실제 사용된 도형만 정의. 새로운 형태 추가 금지.

### 4-1. Pill Badge (알약 배지)

```html
<span class="pill pill--blue">벤치마킹 Insight</span>
<span class="pill pill--outline">키워드</span>
```

```css
.pill {
  display: inline-block;
  padding: 6px 16px;
  border-radius: 999px;
  font-size: 13px;
  font-weight: 600;
  letter-spacing: -0.01em;
}
.pill--blue   { background: var(--blue);      color: #fff; }
.pill--soft   { background: var(--blue-soft); color: var(--blue); }
.pill--outline{ border: 1.5px solid var(--blue); color: var(--blue); }
.pill--ink    { background: var(--ink);       color: #fff; }
```

**사용처:**
- 섹션 레이블 ("Research & Analysis", "벤치마킹 Insight")
- 표지의 키워드 그룹 (묻고/답하고/정의하고/실행하는)
- 카드 상단 라벨

---

### 4-2. Rounded Rectangle Card (둥근 카드)

```html
<div class="card">
  <div class="card__title">제목</div>
  <div class="card__body">본문</div>
</div>
```

```css
.card {
  background: var(--bg);
  border: 1px solid var(--line);
  border-radius: 16px;
  padding: 24px 28px;
}
.card--soft  { background: var(--surface); border: none; }
.card--blue  { background: var(--blue-soft); border: none; }
```

**규칙:**
- 모든 카드 radius는 `16px` 또는 `12px` (소형 카드)
- 그림자 사용 안 함 — 보더 또는 배경색으로만 분리
- 카드 안의 카드(중첩) 금지

---

### 4-3. Comparison Table (비교표)

벤치마킹 슬라이드의 시그니처 도형. 마케팅팀 PDF p5, p17 패턴.

```html
<table class="cmp">
  <thead>
    <tr>
      <th>구분</th>
      <th>서비스A</th>
      <th class="cmp__hl">우리 (강조)</th>
      <th>서비스B</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>출시일</td><td>...</td><td class="cmp__hl">...</td><td>...</td></tr>
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
}
/* 강조 행/열 — 빨간 테두리 (마케팅팀 PDF 시그니처) */
.cmp__hl {
  border-left: 1.5px solid var(--red) !important;
  border-right: 1.5px solid var(--red) !important;
}
.cmp__hl-row td {
  border-top: 1.5px solid var(--red);
  border-bottom: 1.5px solid var(--red);
}
```

---

### 4-4. Flow Node (플로우 다이어그램 노드)

마케팅팀 PDF p8, 한은지 PDF p8 IA/유저 플로우 슬라이드의 시그니처.

```html
<!-- 시작/종료 노드 -->
<div class="node node--blue">회원가입</div>
<!-- 분기 노드 -->
<div class="node node--green">친구 찾기</div>
<div class="node node--orange">취미 찾기</div>
<!-- 일반 노드 -->
<div class="node node--ink">프로필 작성</div>
```

```css
.node {
  display: inline-flex;
  align-items: center; justify-content: center;
  padding: 10px 20px;
  border-radius: 12px;
  font-size: 13px;
  font-weight: 700;
  color: #fff;
  min-width: 120px;
}
.node--blue   { background: var(--blue); }
.node--green  { background: var(--green); }
.node--orange { background: var(--orange); }
.node--ink    { background: var(--ink); }
.node--soft   { background: var(--blue-soft); color: var(--blue); }
```

**연결선:**
- 1.5px solid `--ink-sub`
- 화살표 방향 표시 (→ ↓)
- 분기는 직각으로 (대각선 금지)

---

### 4-5. Section Divider (섹션 구분 바)

좌측 짧은 막대로 섹션 구분.

```html
<div class="section-tag">
  <span class="section-tag__bar"></span>
  <span class="section-tag__text">서비스 정의</span>
</div>
```

```css
.section-tag { display: flex; align-items: center; gap: 12px; }
.section-tag__bar {
  width: 4px; height: 20px;
  background: var(--blue);
  border-radius: 2px;
}
.section-tag__text {
  font-size: 13px; font-weight: 700; color: var(--ink-sub);
  letter-spacing: 0.06em;
}
```

---

### 4-6. Bottom Insight Bar (하단 풀폭 인사이트 바)

**모든 데이터 슬라이드의 결론 강제 장치.** 슬라이드 하단에 통째로 깔리는 컬러 띠.

```html
<div class="insight-bar">
  빠르게 증가하는 고령령 인구에 따른 자신에게 시간과 돈을 아끼지 않는 '액티브 시니어' 그룹의 등장
</div>
```

```css
.insight-bar {
  width: 100%;
  background: var(--blue);
  color: #fff;
  padding: 20px 32px;
  border-radius: 12px;
  font-size: 16px;
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

**규칙:**
- 데이터 슬라이드 하단에 1개씩 배치 (선택 아님, 거의 필수)
- 텍스트는 1줄 또는 2줄 이내
- 인사이트는 "관찰 → 결론" 형태로

---

### 4-7. Number Callout (대형 수치 강조)

차트 옆 또는 카드 안의 핵심 수치.

```html
<div class="num-callout">
  <div class="num-callout__value">130<span>조원</span></div>
  <div class="num-callout__label">액티브 시니어 자산 규모</div>
  <div class="num-callout__source">출처: 통계청</div>
</div>
```

```css
.num-callout__value {
  font-size: 56px; font-weight: 800;
  color: var(--blue);
  line-height: 1; letter-spacing: -0.03em;
}
.num-callout__value span {
  font-size: 24px; font-weight: 700;
  margin-left: 4px;
}
.num-callout__label {
  font-size: 14px; color: var(--ink-sub);
  margin-top: 8px;
}
.num-callout__source {
  font-size: 11px; color: var(--ink-mute);
  margin-top: 4px;
}
```

**미정 수치는 반드시 ○ 표기:**

```html
<div class="num-callout num-callout--empty">
  <div class="num-callout__value">○○<span>건</span></div>
  <div class="num-callout__label">월 발행량 (수치 미정)</div>
</div>
```

```css
.num-callout--empty .num-callout__value { color: var(--ink-mute); }
```

---

## 5. 차트 라이브러리 + 사용 판단 기준

### 5-1. 차트 사용 판단 (Claude CLI 결정 트리)

```
질문: 이 슬라이드에 차트를 넣을 것인가?

  STEP 1: 표현하려는 데이터가 다음 중 하나인가?
    □ 시장 규모 / 성장률 (외부 검증 가능 데이터)
    □ Before / After 변화 (성과)
    □ 비율 / 점유율 (도넛, 파이)
    □ 추세 / 시계열 (꺾은선)
    □ 비교 (벤치마킹 — 표 권장, 차트 비권장)

  → NO이면 차트 안 씀.

  STEP 2: 인사담당자 입장에서 임팩트 있는가?
    □ "이 사람이 ○억 규모의 시장을 다뤘구나" 가 보이는가
    □ "이 사람이 ○○% 개선했구나" 가 보이는가
    □ 단순 계산식 시각화 (예: 1+1=2)는 아닌가

  → NO이면 차트 안 쓰고 텍스트로 처리.

  STEP 3: 수치가 있는가?
    □ 실제 수치 → 차트 그대로 그림
    □ 수치 미정 → ○ 처리한 차트 + "(수치 미정)" 캡션
    □ 수치 추정 → "추정치" 명시 + 출처 ○ 처리
```

### 5-2. 차트 종류별 규칙

#### 막대 차트 (Bar Chart)

```
용도: 범주별 비교, Before/After

규칙:
  ✓ 강조 막대 1개만 --blue, 나머지는 --chart-base (회색)
  ✓ 수치 레이블은 막대 위에 직접 표기
  ✓ y축 눈금선 최소화 (또는 제거)
  ✓ 막대 간격은 막대 너비의 50%
  ✗ 3D 효과, 그라디언트 금지
  ✗ 5개 이상 막대일 경우 → 막대 크기 축소가 아닌 차트 유형 변경 검토
```

```html
<svg viewBox="0 0 400 240" xmlns="http://www.w3.org/2000/svg">
  <!-- 회색 막대 (비교군) -->
  <rect x="40"  y="120" width="50" height="80"  fill="#C7CDD9"/>
  <rect x="120" y="100" width="50" height="100" fill="#C7CDD9"/>
  <rect x="200" y="80"  width="50" height="120" fill="#C7CDD9"/>
  <!-- 블루 막대 (강조) -->
  <rect x="280" y="40"  width="50" height="160" fill="#2B5CFF"/>
  <!-- 수치 레이블 -->
  <text x="65"  y="115" text-anchor="middle" font-size="14" font-weight="700" fill="#111">25%</text>
  <text x="305" y="35"  text-anchor="middle" font-size="14" font-weight="700" fill="#2B5CFF">68.8%</text>
  <!-- x축 라벨 -->
  <text x="65"  y="220" text-anchor="middle" font-size="12" fill="#555">2010</text>
  <text x="305" y="220" text-anchor="middle" font-size="12" fill="#555">2020</text>
</svg>
```

#### 도넛 차트 (Donut Chart)

```
용도: 비율 (전체 중 일부의 점유)

규칙:
  ✓ 2~3 조각만. 4 조각 이상은 가로 막대로 변경
  ✓ 강조 조각 --blue, 나머지 --chart-base
  ✓ 중앙 큰 숫자 (퍼센트 + 단위)
  ✓ 도넛 두께는 외경의 30% 정도 (얇으면 잉크 절약)
```

#### 꺾은선 차트 (Line Chart)

```
용도: 시계열 추세

규칙:
  ✓ 단일 라인은 --blue, 두 번째 라인은 --chart-base
  ✓ 데이터 포인트에 점 표시 (8px 원)
  ✓ 핵심 포인트에만 수치 레이블
  ✓ 영역 채우기(area fill) 사용 가능, 단 opacity 0.1
```

#### 표 (Comparison Table) — 벤치마킹 시 권장

```
용도: 5개 이상 항목 비교

규칙:
  ✓ 차트보다 표가 더 명확한 경우 표를 선택
  ✓ 강조 행/열은 빨간 테두리 (4-3 참고)
  ✓ 우리 회사/서비스가 강조 열에 위치
```

### 5-3. 수치 미정 시 ○ 처리

```
실제 수치 있음:    "130조원"
부분 수치만 있음:  "○○년 ○○조원" (시계열 미정)
완전 미정:        "○○○건" (자릿수만 표기)
미공개:           "—" (대시 1개)
```

차트에서 ○ 처리:

```html
<!-- y축 수치만 미정인 경우 -->
<rect x="40" y="100" width="50" height="100" fill="#C7CDD9"/>
<text x="65" y="95" text-anchor="middle" font-size="14" fill="#999">○○</text>

<!-- 전체 차트가 미정인 경우 → 차트 자리에 placeholder 박스 -->
<div class="chart-placeholder">
  <div class="chart-placeholder__icon">📊</div>
  <div class="chart-placeholder__text">(필요 차트: 채널별 클릭수 막대그래프, 4개 채널 비교)</div>
</div>
```

```css
.chart-placeholder {
  width: 100%; aspect-ratio: 16/10;
  background: repeating-linear-gradient(
    45deg, #F7F8FA, #F7F8FA 10px,
    #FFFFFF 10px, #FFFFFF 20px
  );
  border: 1.5px dashed var(--line);
  border-radius: 12px;
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  gap: 12px;
}
.chart-placeholder__icon { font-size: 32px; opacity: 0.4; }
.chart-placeholder__text {
  font-size: 13px; color: var(--ink-mute);
  font-weight: 500; text-align: center;
  max-width: 80%;
}
```

---

## 6. 이미지/목업 Placeholder 규칙

스크린샷이 있어도 **현재는 도형 placeholder로 영역만 잡는다**. 사용자가 피그마에서 직접 이미지 교체.

### 6-1. 모바일 폰 목업 placeholder

```html
<div class="mockup-phone">
  <div class="mockup-phone__frame">
    <div class="mockup-phone__screen">
      (필요이미지: 회원가입 화면 — 카카오톡 로그인 버튼, 전화번호 가입 버튼 포함)
    </div>
  </div>
  <div class="mockup-phone__caption">회원가입</div>
</div>
```

```css
.mockup-phone {
  display: flex; flex-direction: column; align-items: center; gap: 12px;
}
.mockup-phone__frame {
  width: 180px; aspect-ratio: 9/19.5;
  background: var(--ink);
  border-radius: 24px;
  padding: 6px;
}
.mockup-phone__screen {
  width: 100%; height: 100%;
  background: var(--surface);
  border-radius: 18px;
  display: flex; align-items: center; justify-content: center;
  padding: 16px;
  font-size: 11px; color: var(--ink-mute);
  text-align: center; line-height: 1.5;
}
.mockup-phone__caption {
  font-size: 13px; font-weight: 700; color: var(--ink);
}
```

### 6-2. 데스크탑 대시보드 목업 placeholder

```html
<div class="mockup-desktop">
  <div class="mockup-desktop__bar">
    <span></span><span></span><span></span>
  </div>
  <div class="mockup-desktop__screen">
    (필요이미지: 채널 성과 대시보드 메인 화면 — 좌측 사이드바 + 상단 KPI 카드 4개 + 채널 테이블)
  </div>
</div>
```

```css
.mockup-desktop {
  width: 100%;
  background: var(--ink);
  border-radius: 12px;
  overflow: hidden;
}
.mockup-desktop__bar {
  height: 28px; padding: 0 12px;
  display: flex; align-items: center; gap: 6px;
}
.mockup-desktop__bar span {
  width: 8px; height: 8px; border-radius: 50%;
  background: rgba(255,255,255,0.3);
}
.mockup-desktop__screen {
  background: var(--surface);
  aspect-ratio: 16/10;
  display: flex; align-items: center; justify-content: center;
  padding: 24px;
  font-size: 14px; color: var(--ink-mute);
  text-align: center; line-height: 1.6;
}
```

### 6-3. 일반 이미지 placeholder

```html
<div class="img-placeholder" style="aspect-ratio: 4/3">
  (필요이미지: 페르소나 사진 — 60대 남성, 등산복 차림)
</div>
```

```css
.img-placeholder {
  width: 100%;
  background: var(--surface);
  border: 1.5px dashed var(--line);
  border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  padding: 24px;
  font-size: 13px; color: var(--ink-mute);
  text-align: center; line-height: 1.5;
  font-weight: 500;
}
```

### 6-4. (필요이미지 ...) 표기 규칙

```
형식: (필요이미지: 무엇을 / 어떤 구도 / 어떤 요소 포함)

좋은 예:
  (필요이미지: 회원가입 화면 — 카카오톡 로그인 버튼, 전화번호 가입 버튼 포함)
  (필요이미지: 채널 성과 대시보드 메인 — 상단 KPI 4개, 좌측 사이드바, 중앙 테이블)
  (필요이미지: 페르소나 사진 — 60대 남성, 등산복, 야외 배경)

나쁜 예:
  (이미지)
  (스크린샷)
  (대시보드)
```

---

## 7. 말풍선 콜아웃 (Speech Bubble)

마케팅팀 PDF p8, 한은지 PDF p8 카카오 헬스케어 슬라이드 시그니처.

### 7-1. 기본 말풍선

```html
<div class="bubble bubble--yellow bubble--left">
  건강 관리, 이제 카카오톡에서<br>쉽게 기록하고 확인할 수 있어요
</div>
```

```css
.bubble {
  position: relative;
  padding: 16px 20px;
  border-radius: 14px;
  font-size: 14px; font-weight: 600;
  line-height: 1.5;
  max-width: 240px;
}
.bubble--yellow { background: var(--yellow); color: var(--ink); }
.bubble--blue   { background: var(--blue);   color: #fff; }
.bubble--soft   { background: var(--blue-soft); color: var(--ink); }

/* 꼬리 (tail) — 위치별 */
.bubble--left::after {
  content: "";
  position: absolute;
  right: -8px; top: 24px;
  border-left: 8px solid currentColor;
  border-top: 6px solid transparent;
  border-bottom: 6px solid transparent;
}
.bubble--right::after {
  content: "";
  position: absolute;
  left: -8px; top: 24px;
  border-right: 8px solid currentColor;
  border-top: 6px solid transparent;
  border-bottom: 6px solid transparent;
}
```

### 7-2. 말풍선 사용 시점

```
✓ 서비스 컨셉 슬라이드 — 폰 목업 좌우에 4개 배치, 핵심 기능 설명
✓ 페르소나 슬라이드 — 페르소나 사진 옆 인용구 ("매일의 운동 데이터를 기록하고 싶은데...")
✓ 인터뷰 인사이트 — 사용자 발화 인용

✗ 일반 본문 텍스트 (그냥 본문으로 작성)
✗ 한 슬라이드에 5개 이상 (시각 노이즈)
```

---

## 8. 슬라이드 템플릿 (마케팅팀 PDF 정확 복기)

각 템플릿은 마케팅팀 PDF의 실제 슬라이드 1페이지에 1:1 대응.

### TEMPLATE 1 — 표지 (Cover)

```
배경: --blue-deep (풀블리드)
구성:
  좌측: 작은 라벨 "CHALLENGE TO BE USEFUL." (12px, opacity 0.6)
        큰 타이포 "Product Manager Portfolio" (display, 흰색)
  우측: 키워드 pill 그룹 (4-6개, 흰색 테두리)
       예: 묻고 / YES. / 답하고 / → / 정의하고 / 실행하는

규칙:
  - 본인 이름은 표지에 넣지 않거나 우하단에 작게
  - 이미지/일러스트 사용 안 함 (타이포만으로 임팩트)
```

### TEMPLATE 2 — 목차 (Index)

```
배경: 흰색
구성:
  좌측 상단: 작은 블루 라벨 "Portfolio"
  큰 타이포: "Index." (h1 크기, 끝에 블루 점)
  하단: 프로젝트 리스트 (번호 + 제목)
    1. 손쉬운 5060 건강관리, 카카오톡 헬스케어
    2. K-애슬레저 라이프를 이끄는 안다르 커뮤니티

규칙:
  - 최대 5개 프로젝트
  - 번호와 제목 사이 공백 충분히 (16px)
  - 구분선 사용 안 함, 여백으로만 구분
```

### TEMPLATE 3 — 프로젝트 표지 (Project Cover)

```
배경: --blue-deep (풀블리드)
구성:
  좌측 (40%):
    - 큰 타이포 "프로젝트 제목" (h1 또는 display, 흰색)
    - [Overview] 라벨 + 개요 텍스트 (--body, 흰색 opacity 0.85)
    - 메타:
      Process: [단계1]-[단계2 굵게]-[단계3]-[단계4]-[단계5]  ← 현재 단계만 굵게
      Project Role: 단독 기획 / AI 협업 구현
  우측 (60%):
    - 폰 목업 또는 데스크탑 목업 placeholder (큰 사이즈)

규칙:
  - 우측 목업은 (필요이미지: 메인 화면 — ...) 텍스트로 placeholder
  - 모바일 앱이 아닌 경우 데스크탑 목업 사용
```

### TEMPLATE 4 — 리서치/배경 (Research)

가장 자주 쓰이는 템플릿. 데이터 기반 슬라이드의 표준.

```
배경: 흰색
구성:
  상단 가운데: pill "Research & Analysis" (회색)
  메인 인사이트 문장 (h2, 가운데 정렬):
    "5060이 뜬다, 액티브 시니어(Active Senior)"
    핵심 키워드만 --blue 또는 --yellow(다크 위)
  서브: 한 줄 부연 (--body-lg, --ink-sub)

  3분할 영역:
    [차트 1] [차트 2] [차트 3]
    각 차트 하단: 출처 (--xs, --ink-mute)

  하단 풀폭 인사이트 바: --blue 배경 + 흰 텍스트
    "빠르게 증가하는 인구에 따른 ○○ 그룹의 등장"

규칙:
  - 차트 3개 모두 동일 사이즈
  - 강조 막대만 --blue, 나머지 --chart-base
  - 출처는 반드시 명시 (없으면 "(출처 미정)")
```

### TEMPLATE 5 — 인사이트 도출 (Insight)

```
배경: --ink (검정 풀블리드) 또는 --blue-deep
구성:
  중앙 정렬 텍스트:
    상단 캡션 (출처 또는 섹션명, --xs, opacity 0.5)
    메인 인사이트 (h1, 흰색)
       핵심 키워드만 --yellow 또는 --blue
    서브 (--body, opacity 0.7)

규칙:
  - 텍스트만, 차트/이미지 없음
  - 한 슬라이드 인사이트 1-2개
  - 인사담당자가 5초 안에 읽을 수 있는 길이
```

### TEMPLATE 6 — 서비스 정의 / 컨셉 (Service Concept)

```
배경: 흰색 또는 옅은 그라디언트(--surface)
구성:
  상단: 메인 헤딩 (h1)
    "손쉽게 내 건강을 관리할 수 있는 카카오톡 헬스케어"

  중앙: 폰 목업 1개 (큰 사이즈, 가운데)

  좌우: 말풍선 콜아웃 4개
    상단 좌: "건강 관리, 이제 카카오톡에서 쉽게 기록하고 확인할 수 있어요"
    상단 우: "다양한 건강 관리 방법을 추천하는 콘텐츠!"
    하단 좌: "복약 관리와 나에게 지금 필요한 건강기능식품도 바로:)"
    하단 우: "운동, 어떻게 할 지 모를 때는 맞춤형 도전!"

규칙:
  - 말풍선 색은 통일 (모두 yellow 또는 모두 blue-soft)
  - 꼬리 방향이 폰 목업을 향하도록
  - 말풍선 텍스트는 1-2줄 이내
```

### TEMPLATE 7 — 와이어프레임 (Wireframe)

```
배경: --surface 또는 흰색
구성:
  상단: 메인 문장 (h2, 가운데 정렬)
    "쉽게 할 수 있는 내 건강 관리 기록 및 입력 + 흥미를 유발하는 콘텐츠"
    "이해하기 쉬운 직관적인 용어와 기능 단순화" ← 핵심 키워드 노란/블루

  중앙: 폰 목업 4-5개 가로 배치
    각각 (필요이미지: ○○ 화면 — ...) placeholder
    하단 캡션: 화면명 (굵게, 13px, 가운데)

규칙:
  - 폰 목업 사이 간격 동일
  - 캡션은 화면명만 (1-3 단어)
  - 데스크탑 대시보드 프로젝트는 폰 목업 대신 데스크탑 목업 3개
```

### TEMPLATE 8 — 페르소나 (Persona)

```
배경: 흰색
구성:
  상단: pill "타겟 Persona" + 박스
    [Target] (--surface 박스):
    · 핵심 타겟 정의 1
    · 핵심 타겟 정의 2

  하단 3분할 카드:
    각 카드:
      원형 이미지 placeholder (--surface, 110px)
        (필요이미지: 60대 남성, 등산복)
      이름, 나이, 거주지, 특이사항 (4줄 메타)
      페르소나 스토리 (이탤릭 또는 일반, 3줄)

규칙:
  - 3개 페르소나로 통일 (적으면 빈 카드, 많으면 다음 슬라이드)
  - 원형 이미지는 카드 상단 가운데
  - 메타는 좌측 정렬
```

### TEMPLATE 9 — 유저 플로우 / IA

```
배경: 흰색
구성:
  좌우 2분할:
    좌: pill "유저 프로세스"
       플로우 다이어그램 (4-3 노드 사용)
    우: pill "IA (정보구조도)"
       트리 구조 다이어그램

규칙:
  - 노드 색상은 의미별로 통일
    - 시작/종료: --blue
    - 분기 1: --green
    - 분기 2: --orange
    - 일반: --ink 또는 --soft
  - 화살표는 직선 또는 직각만 (대각선 금지)
  - 노드당 텍스트 최대 6자
```

### TEMPLATE 10 — 벤치마킹 (Benchmarking)

```
배경: 흰색
구성:
  상단:
    pill "벤치마킹 Insight"
    좌측: "국내외 데이팅 앱 / 커뮤니티 앱을 분석"
    우측 박스 (--blue-soft):
      · 인사이트 1
      · 인사이트 2 (핵심 키워드 --blue)
      · 인사이트 3

  하단: 비교표 (4-3 도형)
    헤더: --blue 배경
    강조 행: --red 테두리

규칙:
  - 비교표 컬럼 3-5개
  - 우리 회사가 들어갈 자리는 --red 강조 (없으면 "기회 영역")
  - 차트보다 표가 명확한 경우 표 사용
```

### TEMPLATE 11 — 시장 진입 / 전략 (Strategy)

```
배경: 흰색
구성:
  상단: 섹션 라벨

  좌우 2분할 카드:
    좌 카드:
      pill "요금제" (또는 "전략 1")
      전략 설명 + 대형 수치 callout
    우 카드:
      pill "온라인 마케팅" (또는 "전략 2")
      차트 + 인사이트

  하단 풀폭 인사이트 바:
    "전체 전략의 핵심 메시지 1줄"
```

### TEMPLATE 12 — 결과 / 성과 (Outcome)

**핵심 변경: ○ 처리 + Before/After 표 또는 막대 차트**

```
배경: 흰색
구성:
  상단: 섹션 라벨 + 메인 헤딩

  중앙 옵션 A — 비교표 (수치 미정 시):
    | 지표 | 변화 전 | 변화 후 | 비고 |
    | ○○ 시간 | ○○시간 | ○○분 | |

  중앙 옵션 B — KPI 카드 그리드 (수치 있을 때):
    각 카드:
      Before 수치 (회색, 취소선)
      ↓
      After 수치 (--blue, 큼)
      라벨 (--ink-sub)

  하단:
    정성적 변화 (불렛 3개)
    또는 인사이트 바

규칙:
  - 수치 없으면 ○ 처리 (절대 추측 금지)
  - 단위 명확히 (시간/분/초/건/%)
  - Before → After 화살표 명시
```

### TEMPLATE 13 — 핵심 판단 로그 (Decision Log) [AX/PO 특화]

```
배경: 흰색
구성:
  상단: 섹션 라벨 "핵심 판단 & 의사결정"

  중앙: 판단 카드 3-5개 (세로 또는 2-3 컬럼 그리드)
    각 카드:
      좌측 4px 세로 바 (--blue)
      판단 번호 + 제목 (h3)
      상황 (--ink-sub, --body)
      선택 이유 (--blue 키워드 강조)
      트레이드오프 (있으면 --orange 텍스트)

규칙:
  - tags에 "AI 활용" / "AX" / "PO" 포함되면 이 슬라이드 필수
  - "왜" 중심 서술
  - 한 카드 당 100자 이내
```

### TEMPLATE 14 — 결말 (Closing)

```
배경: --blue-deep (풀블리드)
구성:
  중앙 큰 타이포 (display, 흰색):
    "도전했습니다."
    빈 줄
    "감사합니다."

  하단:
    "CHALLENGE TO BE USEFUL."
    "끈질긴 관찰로 성장하는 [본인 이름]"

규칙:
  - 표지와 동일한 톤 유지 (수미상관)
```

---

## 9. 슬라이드 시퀀스 (프로젝트 1개 = 8-10 슬라이드)

```
1. 프로젝트 표지              [TEMPLATE 3]
2. 배경 (구조적 문제)         [TEMPLATE 4 — 차트 없으면 4 변형]
3. 리서치 / 데이터             [TEMPLATE 4]    ※ 차트 임팩트 있을 때만
4. 인사이트 도출               [TEMPLATE 5]
5. 문제 재정의                 [TEMPLATE 5 또는 4 변형]
6. 솔루션 구조                 [TEMPLATE 6 또는 9 (다이어그램)]
7. 와이어프레임 / 결과물       [TEMPLATE 7]
8. 핵심 판단 로그              [TEMPLATE 13]   ※ AX/PO 포지션 필수
9. 결과 / 성과                 [TEMPLATE 12]
10. 한계 및 다음 단계 (선택)   [TEMPLATE 4 변형]

전체 포트폴리오 = 표지(1) + 목차(2) + 프로젝트별 8-10장 + 결말(1)
```

---

## 10. CLI 작업 프로토콜

Claude CLI가 `project.md`를 받으면 따를 순서.

```
STEP 1: project.md 파싱
  - YAML frontmatter에서 메타 추출 (title, period, role, tags, tools, organization)
  - ## 1 ~ ## 7 섹션 콘텐츠 분리
  - ## 7 (활용 메모)는 외부 노출 안 함 (CLI 참고용)

STEP 2: 슬라이드 계획 수립 (결정 트리)

  □ tags에 "AI 활용" / "AX" / "PO" 있는가?
    YES → DECISION LOG 슬라이드 (TEMPLATE 13) 필수 포함
    NO  → 선택

  □ ## 1 (배경)에 외부 시장/데이터 수치가 있는가?
    YES → RESEARCH 슬라이드 (TEMPLATE 4) 차트 포함
    NO  → 텍스트 기반 BACKGROUND 슬라이드

  □ ## 4 (결과)에 수치 비교가 있는가?
    YES → OUTCOME 슬라이드 옵션 B (KPI 카드)
    NO  → OUTCOME 슬라이드 옵션 A (비교표 + ○ 처리)

  □ project.md에 모바일/데스크탑 언급?
    "앱" / "모바일" → 폰 목업 사용
    "대시보드" / "어드민" / "B2B" → 데스크탑 목업 사용

STEP 3: 차트 사용 검증 (섹션 5-1 결정 트리 적용)
  각 슬라이드별로 차트 사용할지 판단:
    - 인사담당자 임팩트 있는가?
    - 수치 있는가? (없으면 ○ 처리한 차트 또는 placeholder)

STEP 4: 슬라이드별 HTML 생성
  - 각 템플릿 (섹션 8) 그대로 사용
  - inline-style 또는 단일 <style> 블록
  - 슬라이드 = <section class="slide"> 단위로 분리
  - 1280x720 viewport 기준
  - 폰트는 Pretendard CDN 임포트

STEP 5: 파일 출력
  파일명: {project-id}-portfolio.html
  단일 HTML 파일 (외부 의존성 최소화)
  HTML-to-Figma 플러그인 호환 우선
    → absolute positioning 최소화
    → flex / grid 위주
    → SVG는 inline
    → 외부 이미지 URL 사용 안 함 (placeholder만)

STEP 6: 품질 체크
  □ 슬라이드당 컬러 면적 ≤ 30%
  □ 액센트 컬러 슬라이드당 1색만
  □ 본문 폰트 종류 = Pretendard 1종
  □ 모든 차트에 출처 표기 또는 (출처 미정)
  □ 수치 미정은 모두 ○ 처리
  □ 이미지 placeholder는 모두 (필요이미지: ...) 형식
  □ 슬라이드 마지막에 인사이트 바 또는 결론 문장
  □ 흰 배경 슬라이드와 컬러 풀블리드 슬라이드 비율 = 7:3 이내
```

---

## 11. 절대 금지 / 절대 준수

```
✗ 금지
- 그라디언트, 그림자, blur 효과
- 풀블리드 컬러 슬라이드 50% 초과
- 추측 수치 작성 (반드시 ○ 처리)
- 출처 누락 차트
- 한 슬라이드 액센트 컬러 2색 동시 사용
- 폰트 4종 이상 혼용
- 한 슬라이드 텍스트 200자 초과 (한글 기준)
- 절대 위치 (absolute) 남용 → Figma import 시 깨짐
- 외부 이미지 URL → 반드시 placeholder
- 흰 배경 위 노란색 글자

✓ 준수
- 흰 배경이 디폴트
- 차트는 필요할 때만, 인사담당자 임팩트 우선
- 수치는 실제 또는 ○
- 출처는 반드시
- 슬라이드 결론은 하단 풀폭 인사이트 바로 강제
- 액센트 컬러는 1색만, 키워드에만
- HTML 구조는 피그마 친화적 (flex/grid 위주)
```

---

## 12. 변경 이력

```
v2.0 (2026-04-30)
  - v1 폐기 (과한 다크 테마, AI 스러운 그라디언트, 인터랙션 과잉)
  - 마케팅팀 PDF 시각 문법 정밀 재분석
  - 흰 배경 디폴트 + 프린트 친화 정책
  - 도형 라이브러리 7종으로 한정 (마케팅팀 PDF 실사용 도형만)
  - 차트 사용 결정 트리 추가 (섹션 5-1)
  - ○ 처리 규칙 명시 (수치 미정)
  - (필요이미지: ...) placeholder 표준화
  - HTML-to-Figma 호환성 우선 (absolute 최소화, flex/grid)
  - 슬라이드 템플릿 14종 (마케팅팀 PDF 1:1 매핑)
```
