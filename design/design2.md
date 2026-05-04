\# PM Portfolio Design System v4

> Claude CLI가 `project.md`를 읽고 인사담당자용 HTML 슬라이드를 생성할 때 따르는 디자인 규칙서.

> 출력 흐름: design.md + project.md → Claude CLI → HTML → HTML-to-Figma → Figma 수정 → PPT export



\---



\## 0. 디자인 철학 (반드시 첫 작업 전 읽기)



```

1\. 흰 배경이 디폴트. 풀블리드 컬러는 표지/문제재정의/결말에만.

2\. 잉크는 강조에만. 슬라이드당 컬러 면적 ≤ 30%.

3\. 차트는 도구이지 장식이 아니다. 단, 임팩트 있는 데이터는 반드시 차트로.

4\. 슬라이드 1장에 도형/시각요소 최소 3종 이상. 텍스트만 있는 슬라이드 금지.

5\. 폰트 강조는 컬러 변경으로만. 폰트 크기 점프, 그림자, 그라디언트 금지.

6\. 슬라이드 1장에 인사이트 1개. 결론은 반드시 하단 풀폭 인사이트 바로 강제.

7\. 데이터 구조/아키텍처 프로젝트는 반드시 다이어그램 또는 코드 블록 슬라이드 포함.

8\. 슬라이드 유형이 아닌 성과 TYPE으로 레이아웃을 결정한다. (v4 신규)

```



\---



\## 1. ⚠️ 풍부함 강제 규칙 (Anti-단조로움 정책)



CLI가 자주 빠지는 함정: "텍스트 카드만 3개 나열". 이를 방지하기 위한 강제 규칙.



\### 1-1. 슬라이드별 시각요소 최소 개수



```

모든 슬라이드는 다음 중 최소 3종을 포함해야 한다:



&#x20; □ Pill 배지 (섹션 라벨)

&#x20; □ Number Callout (대형 수치)

&#x20; □ 차트 (막대/도넛/꺾은선/프로그레스/비교바)

&#x20; □ 비교표

&#x20; □ 카드 (--soft, --blue, default 중 1종 이상)

&#x20; □ Sub-card (카드 내부의 작은 박스)

&#x20; □ 다이어그램 노드 + 화살표

&#x20; □ 목업 placeholder (모바일/데스크탑)

&#x20; □ 코드 블록 (다크 배경)

&#x20; □ 인사이트 바 (하단 풀폭)

&#x20; □ 좌측 4px 색 막대 + 텍스트 (decision card 패턴)

&#x20; □ 번호 배지 (원형 + 숫자)

&#x20; □ Before/After 플로우 다이어그램

&#x20; □ 수평 스텝 다이어그램

&#x20; □ 의사결정 트리

&#x20; □ 마일스톤 타임라인

&#x20; □ cost-card (비용 절감 전용)



❌ 금지: <p>+<h2>+<ul>만으로 슬라이드 구성

✅ 권장: 카드 안에 sub-card, sub-card 안에 작은 수치/배지가 nested되도록

```



\### 1-2. 카드 내부 패턴 (Nested Pattern)



```html

<!-- ❌ 단조로운 카드 -->

<div class="card">

&#x20; <h3>제목</h3>

&#x20; <p>본문 텍스트만 있음</p>

</div>



<!-- ✅ 풍부한 카드 -->

<div class="card">

&#x20; <span class="pill pill--soft">레이블</span>

&#x20; <h3>카드 제목</h3>

&#x20; <p>본문 설명</p>

&#x20; <div class="sub-card sub-card--blue">

&#x20;   <span class="xs">CASE 1</span>

&#x20;   <div class="num-callout">487,000<span>건</span></div>

&#x20;   <p class="small">실제 영향 텍스트</p>

&#x20; </div>

&#x20; <div class="card\_\_footer">

&#x20;   → <strong class="hl-blue">핵심 인사이트</strong>

&#x20; </div>

</div>

```



```css

.sub-card { background: var(--bg); border-radius: 10px; padding: 12px 16px; margin-top: 12px; }

.sub-card--blue { background: var(--blue-soft); }

.sub-card--ink  { background: var(--ink); color: #fff; }

.card\_\_footer {

&#x20; margin-top: 12px; padding-top: 12px;

&#x20; border-top: 1px solid var(--line);

&#x20; font-size: 13px; font-weight: 600; color: var(--blue);

}

```



\### 1-3. 슬라이드별 시각요소 강제 (요약)



```

RESEARCH  → 차트 2-3개 필수 (Section 8 T4 분기 참조)

OUTCOME   → Section 6-1 TYPE 감지 → Section 8 T11 레이아웃 적용

DATA ARCH → 코드블록 + 레이어다이어그램 동시 필수

WIREFRAME → 목업 placeholder 3-5개 가로 배치 필수

```



\---



\## 2. 컬러 시스템



```css

/\* Base \*/

\--bg:        #FFFFFF;

\--ink:       #111111;

\--ink-sub:   #555555;

\--ink-mute:  #999999;

\--line:      #E5E5E5;

\--surface:   #F7F8FA;



/\* Brand \*/

\--blue:      #2B5CFF;

\--blue-deep: #1A3FCC;

\--blue-soft: #EAF0FF;



/\* Accent — 슬라이드당 1종만 추가 사용 \*/

\--yellow:    #FFD500;   /\* 다크 배경 키워드만 \*/

\--green:     #00B26A;   /\* TOBE, 긍정, 완료 \*/

\--red:       #E63946;   /\* ASIS, 비교표 강조, 문제 \*/

\--orange:    #F77F00;   /\* 트레이드오프, 보조 강조, 경고 \*/



/\* Light variants \*/

\--red-soft:    #FFE5E7;

\--orange-soft: #FFF1DC;

\--green-soft:  #E5F5EE;



/\* Chart \*/

\--chart-primary: #2B5CFF;

\--chart-base:    #C7CDD9;

```



| 요소 | 컬러 |

|------|------|

| 본문, 일반 제목 | `--ink` |

| 슬라이드 메인 키워드 (1-2개) | `--blue` 또는 `--yellow`(다크 배경에서만) |

| 차트 강조 막대/선 | `--blue` |

| 차트 비교군 | `--chart-base` |

| 하단 인사이트 바 | `--blue` 또는 `--ink` 배경 |

| 비교표 헤더 | `--blue` 배경 |

| 비교표 강조 열 테두리 | `--red` (1.5px) |

| 문제/리스크 배지 | `--red-soft` 배경 + `--red` 텍스트 |

| 솔루션/긍정 배지 | `--blue-soft` 배경 + `--blue` 텍스트 |

| 트레이드오프 텍스트 | `--orange` |

| 완료/성공 표시 | `--green` |



\---



\## 3. 타이포그래피



```css

font-family: "Pretendard", "Apple SD Gothic Neo", "Noto Sans KR", sans-serif;



\--display:  72px / 900 / line-height 1.05  /\* 표지 \*/

\--h1:       44px / 800 / line-height 1.2   /\* 슬라이드 메인 제목 \*/

\--h2:       28px / 700 / line-height 1.3   /\* 슬라이드 서브 제목 \*/

\--h3:       20px / 700 / line-height 1.4   /\* 카드 제목 \*/

\--body-lg:  18px / 500 / line-height 1.7

\--body:     15px / 400 / line-height 1.7

\--small:    13px / 500 / line-height 1.5

\--xs:       11px / 600 / line-height 1.4   /\* 라벨, 출처 \*/

```



\*\*핵심 강조 패턴:\*\*



```

✓ 키워드만 컬러 변경:

&#x20; "<span class="hl-blue">3단계 계층</span>이 DB에 구축되어야"



✓ 핵심 수치 + 단위 분리 (num-callout):

&#x20; "<div class='num-callout'>130<span>조원</span></div>"

&#x20;  └ 56px, 800, --blue    └ 24px, 700



✗ 폰트 사이즈 점프 (작은 글씨를 크게)

✗ 한 슬라이드에 색깔 3가지 이상

```



\*\*CDN 임포트:\*\*

```html

<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" rel="stylesheet">

```



\---



\## 4. 레이아웃



```

슬라이드 규격: 1280x720px

패딩: 60px 72px (상하 60, 좌우 72)

그리드: 12 column, gap 24px

```



\*\*핵심 레이아웃 6종:\*\*



```

\[A] 헤더 + 차트 그리드 + 인사이트 바 (RESEARCH)

┌──────────────────────────┐

│ 섹션 라벨 + pill         │

│ 메인 제목 (h1)           │

├─────┬─────┬─────────────┤

│차트1│차트2│차트3         │

├─────┴─────┴─────────────┤

│ ▓ 인사이트 바 ▓          │

└──────────────────────────┘



\[B] 헤더 + 좌우 2분할 (DATA ARCHITECTURE 등)

┌──────────────────────────┐

│ 섹션 라벨                │

│ 메인 제목                │

├─────────────┬────────────┤

│ 코드 블록   │ 다이어그램  │

│ (다크)      │ (노드)     │

└─────────────┴────────────┘



\[C] 헤더 + 3분할 카드 (PROBLEM, SOLUTION)

┌──────────────────────────┐

│ 섹션 라벨 + 메인 제목    │

├──────┬──────┬───────────┤

│카드1 │카드2 │카드3       │

│ +sub │ +sub │ +sub       │

│ +foot│ +foot│ +foot      │

└──────┴──────┴───────────┘



\[D] 와이어프레임 가로 5분할

┌──────────────────────────┐

│ 메인 문장 (강조 키워드)  │

├──┬──┬──┬──┬─────────────┤

│📱│📱│📱│📱│📱            │

│캡│캡│캡│캡│캡            │

├──┴──┴──┴──┴─────────────┤

│ ▓ 인사이트 바 ▓          │

└──────────────────────────┘



\[E] 풀블리드 인사이트 (PROBLEM REFRAMING)

┌──────────────────────────┐

│   ▓ 통째로 다크 배경 ▓   │

│      메인 인사이트       │

│      A안 → B안 비교      │

│      인용 박스           │

└──────────────────────────┘



\[F] Decision Log (좌측 4px 바 + 카드 5-6개)

┌──────────────────────────┐

│ 섹션 라벨 + 메인 제목    │

├──────────────────────────┤

│ ▎01 판단 제목            │

│   판단 근거 + 트레이드오프│

│ ▎02 판단 제목            │

└──────────────────────────┘

```



\---



\## 5. 도형 라이브러리



\### 5-1. Pill Badge



```html

<span class="pill pill--blue">SOLUTION</span>

<span class="pill pill--soft">CASE 1</span>

<span class="pill pill--outline">키워드</span>

<span class="pill pill--problem">PROBLEM 01</span>

<span class="pill pill--success">DONE</span>

<span class="pill pill--ink">AX</span>

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



\### 5-2. Card + Sub-card (Nested Pattern)



```html

<div class="card">

&#x20; <span class="pill pill--soft">CASE 1</span>

&#x20; <h3 class="h3">카드 제목</h3>

&#x20; <p class="body">본문 설명</p>

&#x20; <div class="sub-card">

&#x20;   <div class="xs">실제 사례</div>

&#x20;   <div class="body" style="font-weight:600;">487,000건이 어디서 왔는지 모름</div>

&#x20; </div>

&#x20; <div class="sub-card sub-card--blue">

&#x20;   <div class="xs hl-blue">결과</div>

&#x20;   <div class="body" style="font-weight:700;">측정 가능한 채널 0개</div>

&#x20; </div>

&#x20; <div class="card\_\_footer">

&#x20;   → <strong class="hl-blue">단일 채널로 자동 병합</strong>

&#x20; </div>

</div>

```



\### 5-3. Number Callout



```html

<!-- 일반 -->

<div class="num-callout">

&#x20; <div class="num-callout\_\_value">487,000<span>건</span></div>

&#x20; <div class="num-callout\_\_label">헤이딜러 클릭 (출처 미상)</div>

&#x20; <div class="num-callout\_\_source">출처: 카피아 어드민 (2025.10)</div>

</div>



<!-- ○ 처리 -->

<div class="num-callout num-callout--empty">

&#x20; <div class="num-callout\_\_value">○○<span>%</span></div>

&#x20; <div class="num-callout\_\_label">전환율 개선 (수치 미정)</div>

</div>



<!-- Before/After KPI 카드 -->

<div class="kpi-card">

&#x20; <div class="kpi-card\_\_label">월 발행량</div>

&#x20; <div class="kpi-card\_\_before">25건</div>

&#x20; <div class="kpi-card\_\_after">102건</div>

&#x20; <div class="kpi-card\_\_delta">+308%</div>

</div>

```



```css

.num-callout\_\_value { font-size: 56px; font-weight: 800; color: var(--blue); line-height: 1; letter-spacing: -0.03em; }

.num-callout\_\_value span { font-size: 24px; margin-left: 4px; }

.num-callout--empty .num-callout\_\_value { color: var(--ink-mute); }



.kpi-card { background: var(--surface); border-radius: 16px; padding: 20px; text-align: center; }

.kpi-card\_\_before { font-size: 14px; color: var(--ink-mute); text-decoration: line-through; }

.kpi-card\_\_after  { font-size: 36px; font-weight: 800; color: var(--blue); line-height: 1; margin-top: 4px; }

.kpi-card\_\_delta  { font-size: 12px; font-weight: 700; color: var(--green); margin-top: 4px; }

```



\### 5-4. Comparison Table



```html

<table class="cmp">

&#x20; <thead>

&#x20;   <tr>

&#x20;     <th style="text-align:left;">지표</th>

&#x20;     <th>Before</th>

&#x20;     <th class="cmp\_\_hl-col">After</th>

&#x20;     <th>비고</th>

&#x20;   </tr>

&#x20; </thead>

&#x20; <tbody>

&#x20;   <tr>

&#x20;     <td>채널 성과 확인 시간</td>

&#x20;     <td>2\~3일</td>

&#x20;     <td class="cmp\_\_hl-col"><strong class="hl-blue">실시간</strong></td>

&#x20;     <td>API 연동 완료 시</td>

&#x20;   </tr>

&#x20; </tbody>

</table>

```



```css

.cmp { width: 100%; border-collapse: separate; border-spacing: 0; }

.cmp th, .cmp td { padding: 14px 16px; text-align: center; font-size: 14px; border-bottom: 1px solid var(--line); }

.cmp thead th { background: var(--blue); color: #fff; font-weight: 700; }

.cmp tbody td:first-child { background: var(--surface); font-weight: 600; text-align: left; }

.cmp\_\_hl-col { border-left: 1.5px solid var(--red) !important; border-right: 1.5px solid var(--red) !important; }

```



\### 5-5. Decision Card (좌측 4px 바)



```html

<div class="decision-row">

&#x20; <div class="decision-row\_\_num">01</div>

&#x20; <div class="decision-row\_\_content">

&#x20;   <h3 style="font-size:16px;">판단 제목</h3>

&#x20;   <p class="small">판단 근거 + <span class="hl-blue">핵심 키워드</span></p>

&#x20;   <p class="decision-row\_\_trade">트레이드오프: 자동화율 일부 희생</p>

&#x20; </div>

</div>

```



```css

.decision-row { display: flex; gap: 16px; border-left: 4px solid var(--blue); padding: 14px 0 14px 20px; }

.decision-row\_\_num { flex: 0 0 28px; height: 28px; border-radius: 8px; background: var(--blue-soft); color: var(--blue); font-weight: 800; font-size: 13px; display: flex; align-items: center; justify-content: center; }

.decision-row\_\_trade { color: var(--orange); font-size: 12px; font-weight: 600; margin-top: 4px; }

```



\### 5-6. Code Block



```html

<div class="code-block">

&#x20; <div class="code-block\_\_title">channel\_master DDL (신설)</div>

&#x20; <div class="code-block\_\_body">

&#x20;   <div><span class="code-key">channel\_id</span>    <span class="code-type">VARCHAR(20)</span> <span class="code-comment">-- PK</span></div>

&#x20;   <div><span class="code-key">channel\_name</span>  <span class="code-type">VARCHAR(50)</span></div>

&#x20;   <div><span class="code-key">group\_id</span>      <span class="code-type">VARCHAR(20)</span> <span class="code-comment">-- FK</span></div>

&#x20;   <div><span class="code-key">is\_active</span>     <span class="code-type">BOOLEAN</span></div>

&#x20; </div>

</div>

```



```css

.code-block { background: #1A1A1A; border-radius: 12px; padding: 18px 20px; font-family: 'SF Mono', 'JetBrains Mono', Consolas, monospace; }

.code-block\_\_title { font-size: 11px; font-weight: 700; color: #7BA7FF; margin-bottom: 10px; letter-spacing: 0.1em; }

.code-block\_\_body  { font-size: 12px; color: #fff; line-height: 1.9; }

.code-key     { color: #7BA7FF; }

.code-type    { color: var(--yellow); }

.code-comment { color: #888; }

```



\### 5-7. Flow Node + Layer Diagram



```html

<div class="layer-row">

&#x20; <div class="node node--blue">채널</div>

&#x20; <div class="layer-row\_\_info">

&#x20;   <div class="xs">channel\_master · 신설</div>

&#x20;   <div class="layer-row\_\_num">33<span>개</span></div>

&#x20; </div>

</div>

<div class="layer-arrow"></div>

<div class="layer-row">

&#x20; <div class="node node--ink">UTM 그룹</div>

</div>

```



```css

.node { display: inline-flex; align-items: center; justify-content: center; padding: 10px 20px; border-radius: 12px; font-size: 13px; font-weight: 700; color: #fff; min-width: 120px; text-align: center; }

.node--blue   { background: var(--blue); }

.node--green  { background: var(--green); }

.node--orange { background: var(--orange); }

.node--ink    { background: var(--ink); }

.node--soft   { background: var(--blue-soft); color: var(--blue); }

.layer-arrow  { width: 2px; height: 24px; background: var(--line); margin-left: 70px; }

```



\### 5-8. Insight Bar



```html

<div class="insight-bar">

&#x20; 데이터가 <span style="color:var(--yellow);">없는 게 아니라</span>, 구조가 없었다

</div>

<div class="insight-bar insight-bar--ink">검정 버전</div>

<div class="insight-bar insight-bar--outline">아웃라인 버전</div>

```



```css

.insight-bar { width: 100%; background: var(--blue); color: #fff; padding: 18px 32px; border-radius: 12px; font-size: 15px; font-weight: 600; text-align: center; line-height: 1.5; }

.insight-bar--ink { background: var(--ink); }

.insight-bar--outline { background: transparent; border: 1.5px solid var(--blue); color: var(--ink); }

```



\### 5-9. Mockup Placeholder



```html

<!-- 데스크탑 -->

<div class="mockup-desktop">

&#x20; <div class="mockup-desktop\_\_bar"><span></span><span></span><span></span></div>

&#x20; <div class="mockup-desktop\_\_screen">

&#x20;   (필요이미지: 채널 성과 대시보드 — 상단 KPI 4개, 좌측 사이드바, 중앙 채널 테이블)

&#x20; </div>

</div>



<!-- 모바일 -->

<div class="mockup-phone">

&#x20; <div class="mockup-phone\_\_frame">

&#x20;   <div class="mockup-phone\_\_screen">

&#x20;     (필요이미지: 회원가입 화면 — 카카오 로그인 버튼 포함)

&#x20;   </div>

&#x20; </div>

&#x20; <div class="mockup-phone\_\_caption">회원가입</div>

</div>

```



\*\*placeholder 형식 강제:\*\*

```

형식: (필요이미지: 무엇을 / 어떤 구도 / 어떤 요소 포함)

✅ (필요이미지: 채널 성과 대시보드 — 상단 KPI 카드 4개, 좌측 사이드바)

❌ (이미지) / (스크린샷) / (대시보드 화면)

```



\### 5-10. A/B Compare



```html

<div class="ab-compare">

&#x20; <div class="ab-box ab-box--rejected">

&#x20;   <span class="pill pill--problem">A안 · 미채택</span>

&#x20;   <h3>기존 인식</h3>

&#x20;   <p>대시보드가 없어서 불편</p>

&#x20;   <p style="color:var(--red); font-weight:600;">→ 화면 만들어도 집계 불가</p>

&#x20; </div>

&#x20; <div class="ab-arrow">→</div>

&#x20; <div class="ab-box ab-box--accepted">

&#x20;   <span class="pill pill--blue">B안 · 채택</span>

&#x20;   <h3>재정의한 문제</h3>

&#x20;   <p>데이터 구조가 없어서 집계 불가</p>

&#x20;   <p style="color:var(--blue); font-weight:600;">→ 구조부터 설계</p>

&#x20; </div>

</div>

```



```css

.ab-compare { display: grid; grid-template-columns: 1fr auto 1fr; gap: 24px; align-items: center; }

.ab-box { border-radius: 16px; padding: 24px 28px; }

.ab-box--rejected { background: rgba(255,255,255,0.04); border: 1px solid rgba(230,57,70,0.2); }

.ab-box--accepted { background: var(--blue-soft); border: 1.5px solid var(--blue); }

.ab-arrow { font-size: 32px; color: var(--blue); font-weight: 700; }

```



\---



\### 5-11. Before/After 플로우 (ba-flow) — TYPE E-1 자동화



Figma에서 텍스트 개별 수정 가능. HTML div 방식.



```html

<div class="ba-flow">

&#x20; <!-- Before 컬럼 -->

&#x20; <div class="ba-flow\_\_col ba-flow\_\_col--before">

&#x20;   <div class="ba-flow\_\_col-label">

&#x20;     <span class="pill pill--problem">BEFORE</span>

&#x20;   </div>

&#x20;   <div class="ba-flow\_\_node ba-flow\_\_node--mute">수동 키워드 입력</div>

&#x20;   <div class="ba-flow\_\_vline"></div>

&#x20;   <div class="ba-flow\_\_node ba-flow\_\_node--mute">개별 파일 저장</div>

&#x20;   <div class="ba-flow\_\_vline"></div>

&#x20;   <div class="ba-flow\_\_node ba-flow\_\_node--mute">수동 업로드</div>

&#x20;   <div class="ba-flow\_\_stat">

&#x20;     <span class="ba-flow\_\_stat-value" style="color:var(--red);">3시간</span>

&#x20;     <span class="ba-flow\_\_stat-label">/ 건당 소요</span>

&#x20;   </div>

&#x20; </div>



&#x20; <!-- 중앙 화살표 -->

&#x20; <div class="ba-flow\_\_divider">

&#x20;   <div class="ba-flow\_\_divider-arrow">→</div>

&#x20; </div>



&#x20; <!-- After 컬럼 -->

&#x20; <div class="ba-flow\_\_col ba-flow\_\_col--after">

&#x20;   <div class="ba-flow\_\_col-label">

&#x20;     <span class="pill pill--blue">AFTER</span>

&#x20;   </div>

&#x20;   <div class="ba-flow\_\_node ba-flow\_\_node--blue">Claude API 호출</div>

&#x20;   <div class="ba-flow\_\_vline ba-flow\_\_vline--blue"></div>

&#x20;   <div class="ba-flow\_\_node ba-flow\_\_node--blue">Python 자동 처리</div>

&#x20;   <div class="ba-flow\_\_vline ba-flow\_\_vline--blue"></div>

&#x20;   <div class="ba-flow\_\_node ba-flow\_\_node--blue">자동 발행</div>

&#x20;   <div class="ba-flow\_\_stat">

&#x20;     <span class="ba-flow\_\_stat-value" style="color:var(--blue);">3분</span>

&#x20;     <span class="ba-flow\_\_stat-label">/ 건당 소요</span>

&#x20;   </div>

&#x20; </div>

</div>

```



```css

.ba-flow { display: grid; grid-template-columns: 1fr 48px 1fr; gap: 0; align-items: center; width: 100%; }

.ba-flow\_\_col { display: flex; flex-direction: column; align-items: center; gap: 0; padding: 20px; border-radius: 16px; }

.ba-flow\_\_col--before { background: var(--surface); }

.ba-flow\_\_col--after  { background: var(--blue-soft); }

.ba-flow\_\_col-label   { margin-bottom: 16px; }

.ba-flow\_\_node { width: 100%; padding: 10px 16px; border-radius: 10px; font-size: 13px; font-weight: 600; text-align: center; }

.ba-flow\_\_node--mute { background: #fff; color: var(--ink-mute); border: 1px solid var(--line); }

.ba-flow\_\_node--blue { background: #fff; color: var(--blue); border: 1.5px solid var(--blue); }

.ba-flow\_\_vline { width: 2px; height: 20px; background: var(--line); margin: 0 auto; }

.ba-flow\_\_vline--blue { background: var(--blue); }

.ba-flow\_\_stat { margin-top: 16px; display: flex; align-items: baseline; gap: 4px; }

.ba-flow\_\_stat-value { font-size: 28px; font-weight: 800; line-height: 1; }

.ba-flow\_\_stat-label { font-size: 12px; color: var(--ink-mute); }

.ba-flow\_\_divider { display: flex; flex-direction: column; align-items: center; }

.ba-flow\_\_divider-arrow { font-size: 24px; font-weight: 700; color: var(--blue); }

```



\### 5-12. 수평 스텝 다이어그램 (step-flow) — TYPE E-4 파이프라인



```html

<div class="step-flow">

&#x20; <div class="step-flow\_\_item">

&#x20;   <div class="step-flow\_\_circle step-flow\_\_circle--done">01</div>

&#x20;   <div class="step-flow\_\_label">데이터 수집</div>

&#x20;   <div class="step-flow\_\_sub">Claude API</div>

&#x20; </div>

&#x20; <div class="step-flow\_\_arrow">→</div>

&#x20; <div class="step-flow\_\_item">

&#x20;   <div class="step-flow\_\_circle step-flow\_\_circle--done">02</div>

&#x20;   <div class="step-flow\_\_label">전처리</div>

&#x20;   <div class="step-flow\_\_sub">Python CLI</div>

&#x20; </div>

&#x20; <div class="step-flow\_\_arrow">→</div>

&#x20; <div class="step-flow\_\_item">

&#x20;   <div class="step-flow\_\_circle step-flow\_\_circle--active">03</div>

&#x20;   <div class="step-flow\_\_label">자동 발행</div>

&#x20;   <div class="step-flow\_\_sub">Gemini</div>

&#x20; </div>

&#x20; <div class="step-flow\_\_arrow">→</div>

&#x20; <div class="step-flow\_\_item">

&#x20;   <div class="step-flow\_\_circle step-flow\_\_circle--pending">04</div>

&#x20;   <div class="step-flow\_\_label">성과 측정</div>

&#x20;   <div class="step-flow\_\_sub">대시보드</div>

&#x20; </div>

</div>

```



```css

.step-flow { display: flex; align-items: flex-start; gap: 8px; width: 100%; }

.step-flow\_\_item { flex: 1; display: flex; flex-direction: column; align-items: center; gap: 8px; }

.step-flow\_\_circle { width: 40px; height: 40px; border-radius: 50%; font-size: 13px; font-weight: 800; display: flex; align-items: center; justify-content: center; }

.step-flow\_\_circle--done    { background: var(--blue); color: #fff; }

.step-flow\_\_circle--active  { background: var(--ink); color: #fff; outline: 3px solid var(--blue); outline-offset: 2px; }

.step-flow\_\_circle--pending { background: var(--surface); color: var(--ink-mute); border: 1.5px solid var(--line); }

.step-flow\_\_label { font-size: 13px; font-weight: 700; color: var(--ink); text-align: center; }

.step-flow\_\_sub   { font-size: 11px; color: var(--ink-mute); text-align: center; }

.step-flow\_\_arrow { flex: 0 0 24px; font-size: 18px; color: var(--ink-mute); margin-top: 10px; }

```



\### 5-13. 의사결정 트리 (dtree) — TYPE E-3 AI 로직



```html

<div class="dtree">

&#x20; <!-- 루트 노드 -->

&#x20; <div class="dtree\_\_row">

&#x20;   <div class="dtree\_\_node dtree\_\_node--root">입력 데이터 수신</div>

&#x20; </div>

&#x20; <div class="dtree\_\_vline" style="height:16px; margin:0 auto; width:2px; background:var(--line);"></div>

&#x20; <div class="dtree\_\_hline"></div>



&#x20; <!-- 조건 분기 -->

&#x20; <div class="dtree\_\_row dtree\_\_row--branches">

&#x20;   <div class="dtree\_\_branch">

&#x20;     <div class="dtree\_\_condition">

&#x20;       <span class="dtree\_\_condition-label">조건 A</span>

&#x20;       신뢰도 ≥ 90%

&#x20;     </div>

&#x20;     <div class="dtree\_\_vline-short"></div>

&#x20;     <div class="dtree\_\_node dtree\_\_node--yes">자동 처리</div>

&#x20;     <div class="dtree\_\_result dtree\_\_result--green">→ 개입 없음</div>

&#x20;   </div>

&#x20;   <div class="dtree\_\_branch">

&#x20;     <div class="dtree\_\_condition">

&#x20;       <span class="dtree\_\_condition-label">조건 B</span>

&#x20;       신뢰도 60\~89%

&#x20;     </div>

&#x20;     <div class="dtree\_\_vline-short"></div>

&#x20;     <div class="dtree\_\_node dtree\_\_node--warn">검토 요청</div>

&#x20;     <div class="dtree\_\_result dtree\_\_result--orange">→ 담당자 확인</div>

&#x20;   </div>

&#x20;   <div class="dtree\_\_branch">

&#x20;     <div class="dtree\_\_condition">

&#x20;       <span class="dtree\_\_condition-label">조건 C</span>

&#x20;       신뢰도 \&lt; 60%

&#x20;     </div>

&#x20;     <div class="dtree\_\_vline-short"></div>

&#x20;     <div class="dtree\_\_node dtree\_\_node--no">수동 처리</div>

&#x20;     <div class="dtree\_\_result dtree\_\_result--red">→ 전체 재작성</div>

&#x20;   </div>

&#x20; </div>

</div>

```



```css

.dtree { display: flex; flex-direction: column; align-items: center; width: 100%; }

.dtree\_\_row { display: flex; justify-content: center; width: 100%; }

.dtree\_\_row--branches { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; width: 100%; margin-top: 0; }

.dtree\_\_hline { width: 66%; height: 2px; background: var(--line); margin: 0 auto; }

.dtree\_\_node { padding: 10px 16px; border-radius: 10px; font-size: 13px; font-weight: 700; text-align: center; width: 100%; box-sizing: border-box; }

.dtree\_\_node--root { background: var(--ink); color: #fff; width: auto; padding: 12px 32px; }

.dtree\_\_node--yes  { background: var(--blue); color: #fff; }

.dtree\_\_node--warn { background: var(--orange); color: #fff; }

.dtree\_\_node--no   { background: var(--surface); color: var(--ink); border: 1.5px solid var(--line); }

.dtree\_\_branch { display: flex; flex-direction: column; align-items: center; gap: 8px; }

.dtree\_\_condition { background: var(--surface); border: 1px solid var(--line); border-radius: 8px; padding: 8px 12px; font-size: 12px; color: var(--ink-sub); text-align: center; width: 100%; box-sizing: border-box; }

.dtree\_\_condition-label { display: block; font-size: 10px; font-weight: 700; color: var(--ink-mute); margin-bottom: 2px; letter-spacing: 0.05em; }

.dtree\_\_vline-short { width: 2px; height: 16px; background: var(--line); }

.dtree\_\_result { font-size: 12px; font-weight: 600; }

.dtree\_\_result--green  { color: var(--green); }

.dtree\_\_result--orange { color: var(--orange); }

.dtree\_\_result--red    { color: var(--red); }

```



\### 5-14. 마일스톤 타임라인 (milestone) — TYPE G, H



```html

<div class="milestone">

&#x20; <div class="milestone\_\_track">

&#x20;   <div class="milestone\_\_item">

&#x20;     <div class="milestone\_\_dot milestone\_\_dot--done">✓</div>

&#x20;     <div class="milestone\_\_content">

&#x20;       <div class="milestone\_\_date">2025.01</div>

&#x20;       <div class="milestone\_\_title">팀 구성</div>

&#x20;       <div class="milestone\_\_sub">3명</div>

&#x20;     </div>

&#x20;   </div>

&#x20;   <div class="milestone\_\_line milestone\_\_line--done"></div>

&#x20;   <div class="milestone\_\_item">

&#x20;     <div class="milestone\_\_dot milestone\_\_dot--active">●</div>

&#x20;     <div class="milestone\_\_content">

&#x20;       <div class="milestone\_\_date">2025.07</div>

&#x20;       <div class="milestone\_\_title">정식 출시</div>

&#x20;       <div class="milestone\_\_sub" style="color:var(--blue);">NOW</div>

&#x20;     </div>

&#x20;   </div>

&#x20;   <div class="milestone\_\_line milestone\_\_line--pending"></div>

&#x20;   <div class="milestone\_\_item">

&#x20;     <div class="milestone\_\_dot milestone\_\_dot--pending"></div>

&#x20;     <div class="milestone\_\_content">

&#x20;       <div class="milestone\_\_date">2025.12</div>

&#x20;       <div class="milestone\_\_title">시리즈 A</div>

&#x20;       <div class="milestone\_\_sub">목표</div>

&#x20;     </div>

&#x20;   </div>

&#x20; </div>

</div>

```



```css

.milestone { width: 100%; padding: 24px 0; }

.milestone\_\_track { display: flex; align-items: flex-start; width: 100%; }

.milestone\_\_item { display: flex; flex-direction: column; align-items: center; gap: 10px; flex: 0 0 auto; }

.milestone\_\_dot { width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 13px; font-weight: 800; flex-shrink: 0; }

.milestone\_\_dot--done    { background: var(--blue); color: #fff; }

.milestone\_\_dot--active  { background: var(--ink); color: #fff; outline: 3px solid var(--blue); outline-offset: 3px; }

.milestone\_\_dot--pending { background: var(--surface); border: 2px solid var(--line); }

.milestone\_\_line { flex: 1; height: 2px; margin-top: 17px; }

.milestone\_\_line--done    { background: var(--blue); }

.milestone\_\_line--pending { background: var(--line); }

.milestone\_\_content { text-align: center; }

.milestone\_\_date  { font-size: 10px; color: var(--ink-mute); }

.milestone\_\_title { font-size: 13px; font-weight: 700; color: var(--ink); }

.milestone\_\_sub   { font-size: 11px; color: var(--ink-sub); margin-top: 2px; }

```



\### 5-15. Cost Card (비용 절감 전용) — TYPE F



Big Callout + 수평 비교 바를 하나의 카드에 결합.



```html

<div class="cost-card">

&#x20; <div class="cost-card\_\_callout">

&#x20;   <div class="cost-card\_\_label">연간 절감액</div>

&#x20;   <div class="cost-card\_\_value">○○<span>만원</span></div>

&#x20; </div>

&#x20; <svg viewBox="0 0 240 80" style="width:100%; margin-top:12px;">

&#x20;   <text x="0" y="18" font-size="11" fill="#999">Before</text>

&#x20;   <rect x="0" y="24" width="200" height="12" rx="4" fill="#C7CDD9"/>

&#x20;   <text x="208" y="34" font-size="12" font-weight="700" fill="#555">○○만원</text>

&#x20;   <text x="0" y="58" font-size="11" fill="#999">After</text>

&#x20;   <rect x="0" y="64" width="80" height="12" rx="4" fill="#2B5CFF"/>

&#x20;   <text x="88" y="74" font-size="12" font-weight="700" fill="#2B5CFF">○○만원</text>

&#x20; </svg>

</div>

```



```css

.cost-card { background: var(--surface); border-radius: 16px; padding: 20px 24px; }

.cost-card\_\_label { font-size: 11px; font-weight: 600; color: var(--ink-mute); letter-spacing: 0.05em; }

.cost-card\_\_value { font-size: 48px; font-weight: 800; color: var(--blue); line-height: 1; letter-spacing: -0.03em; margin-top: 4px; }

.cost-card\_\_value span { font-size: 20px; font-weight: 700; margin-left: 4px; }

```



\---



\## 6. 차트 라이브러리



\### 6-1. 성과 TYPE 마스터 테이블 ← CLI의 유일한 TYPE 판단 기준



> Section 10 STEP 2의 결과 TYPE 감지는 이 테이블만 참조한다.



```

키워드 스캔: ## 4 (결과) 섹션 전체에서 아래 키워드 검색.

복합 히트(2개 TYPE 이상): T11-COMPLEX.  단일 히트: 해당 행 적용.



TYPE  │ 감지 키워드                              │ 핵심 컴포넌트            │ T11

──────┼──────────────────────────────────────────┼──────────────────────────┼──────────

A     │ 단축 빠르게 실시간 즉시 ○분 ○시간       │ 수평비교바SVG + Callout  │ T11-A

B     │ 증가 늘었 성장 건수 건 개 배             │ 꺾은선상승SVG + KPI카드  │ T11-B

C     │ % 전환율 달성률 개선율 점유율            │ 프로그레스SVG + 도넛SVG  │ T11-C

D     │ 감소 제거 0건 없앴 오류 버그             │ 꺾은선하락SVG + Callout  │ T11-D

E-1   │ 자동화 수동→자동 스크립트 봇             │ ba-flow (div)            │ T11-E1

E-2   │ 구축 DB 스키마 DDL 테이블 아키텍처       │ 레이어다이어그램 + 코드블록│ T11-E2

E-3   │ AI판단 분류 임계값 LLM 자동결정          │ dtree (div)              │ T11-E3

E-4   │ 파이프라인 프로세스수립 배포 릴리즈       │ step-flow (div)          │ T11-E4

F     │ 절감 원 억 비용 ROI 예산                 │ cost-card                │ T11-F

G     │ 명 팀 확장 온보딩 채용                   │ milestone (div)          │ T11-G

H     │ Phase 완료율 진행중 N/M                  │ 프로그레스스택SVG        │ T11-H

복합  │ 위 TYPE 2개 이상 히트                    │ cmp + KPI카드 + 정성카드 │ T11-COMPLEX



레이아웃 grid-template-columns (가용폭 1136px = 1280 - 좌우패딩 144px):

&#x20; TYPE A, D : grid-template-columns: 682px 1fr;   /\* 비교바:Callout = 60:40 \*/

&#x20; TYPE B    : grid-template-columns: 738px 1fr;   /\* 꺾은선:KPI = 65:35    \*/

&#x20; TYPE E-2  : grid-template-columns: 454px 1fr;   /\* 코드:다이어그램 = 40:60 \*/

&#x20; TYPE G    : grid-template-columns: 795px 1fr;   /\* 타임라인:BigNum = 70:30 \*/

&#x20; 나머지    : width:100% 단일 컬럼

```



\### 6-2. 차트 사용 판단 (요약)



```

수치/비율 데이터 있음  → Section 6-1 TYPE 감지 → 해당 컴포넌트 사용

구조/프로세스 변화만   → TYPE E div 다이어그램 (SVG 불필요)

정성 변화만           → 카드 + sub-card

수치 미정             → ○ 처리. TYPE E는 수치 없어도 다이어그램 사용.

```



\### 6-3. 차트 SVG 패턴



\#### 기존 패턴 ① — Mini Bar Chart (수직)

```html

<svg viewBox="0 0 280 120" style="width:100%;">

&#x20; <rect x="20"  y="40"  width="100" height="60" fill="#C7CDD9" rx="4"/>

&#x20; <text x="70"  y="35"  text-anchor="middle" font-size="14" font-weight="700" fill="#555">33</text>

&#x20; <text x="70"  y="115" text-anchor="middle" font-size="11" fill="#999">측정 불가</text>

&#x20; <rect x="160" y="98"  width="100" height="2"  fill="#E63946" rx="1"/>

&#x20; <text x="210" y="93"  text-anchor="middle" font-size="14" font-weight="700" fill="#E63946">0</text>

&#x20; <text x="210" y="115" text-anchor="middle" font-size="11" fill="#999">측정 가능</text>

</svg>

```



\#### 기존 패턴 ② — Mini Donut Chart (비율)

```html

<svg viewBox="0 0 200 120" style="width:100%;">

&#x20; <circle cx="60" cy="60" r="40" fill="none" stroke="#C7CDD9" stroke-width="14"/>

&#x20; <circle cx="60" cy="60" r="40" fill="none" stroke="#2B5CFF" stroke-width="14"

&#x20;         stroke-dasharray="75 251" stroke-dashoffset="0"

&#x20;         transform="rotate(-90 60 60)"/>

&#x20; <text x="60" y="56" text-anchor="middle" font-size="18" font-weight="800" fill="#2B5CFF">○○%</text>

&#x20; <text x="60" y="72" text-anchor="middle" font-size="9"  fill="#999">분류 가능</text>

&#x20; <text x="120" y="50" font-size="11" fill="#555">■ 강조</text>

&#x20; <text x="120" y="68" font-size="11" fill="#999">■ 비교군</text>

</svg>

```



\#### 기존 패턴 ③ — Mini Comparison Bar (수평 Before/After)

```html

<svg viewBox="0 0 280 120" style="width:100%;">

&#x20; <text x="20"  y="22"  font-size="11" fill="#999">기존</text>

&#x20; <rect x="20"  y="30"  width="180" height="20" fill="#C7CDD9" rx="3"/>

&#x20; <text x="208" y="44"  font-size="13" font-weight="700" fill="#555">2\~3일</text>

&#x20; <text x="20"  y="70"  font-size="11" fill="#999">목표</text>

&#x20; <rect x="20"  y="78"  width="6"   height="20" fill="#2B5CFF" rx="3"/>

&#x20; <text x="34"  y="92"  font-size="13" font-weight="700" fill="#2B5CFF">실시간</text>

</svg>

```



\#### SVG 좌표 스케일링 가이드 (꺾은선/프로그레스 공통)

```

차트 영역: x=32\~270(데이터), y=10\~110(값) — viewBox="0 0 280 140" 기준

데이터 포인트 N개일 때 x좌표: 32 + (238 / (N-1)) \* i  (i=0\~N-1)

y좌표 계산: y = 110 - ((값 - 최솟값) / (최댓값 - 최솟값)) \* 100

&#x20; 예) 5개 포인트, 값=\[25,40,60,85,102], 최솟값=25, 최댓값=102

&#x20;     i=0: x=52,  y=110-((25-25)/(102-25))\*100 = 110

&#x20;     i=4: x=252, y=110-((102-25)/(102-25))\*100 = 10

아래 SVG는 이 공식으로 생성된 예시. 데이터 바뀌면 points와 circle cy 재계산.

```



\#### 신규 패턴 ④ — 꺾은선 차트 상승형 (TYPE B)

```html

<svg viewBox="0 0 280 140" style="width:100%;">

&#x20; <line x1="32" y1="10" x2="32"  y2="110" stroke="#E5E5E5" stroke-width="1"/>

&#x20; <line x1="32" y1="110" x2="270" y2="110" stroke="#E5E5E5" stroke-width="1"/>

&#x20; <path d="M52,95 L102,78 L152,58 L202,35 L252,18 L252,110 L52,110 Z"

&#x20;       fill="#2B5CFF" opacity="0.06"/>

&#x20; <polyline points="52,95 102,78 152,58 202,35 252,18"

&#x20;           fill="none" stroke="#2B5CFF" stroke-width="2.5"

&#x20;           stroke-linecap="round" stroke-linejoin="round"/>

&#x20; <circle cx="52"  cy="95" r="4" fill="#fff" stroke="#2B5CFF" stroke-width="2"/>

&#x20; <circle cx="102" cy="78" r="4" fill="#fff" stroke="#2B5CFF" stroke-width="2"/>

&#x20; <circle cx="152" cy="58" r="4" fill="#fff" stroke="#2B5CFF" stroke-width="2"/>

&#x20; <circle cx="202" cy="35" r="4" fill="#fff" stroke="#2B5CFF" stroke-width="2"/>

&#x20; <circle cx="252" cy="18" r="5" fill="#2B5CFF" stroke="#2B5CFF" stroke-width="2"/>

&#x20; <text x="252" y="12" text-anchor="middle" font-size="12" font-weight="700" fill="#2B5CFF">102건</text>

&#x20; <text x="52"  y="124" text-anchor="middle" font-size="10" fill="#999">1월</text>

&#x20; <text x="102" y="124" text-anchor="middle" font-size="10" fill="#999">2월</text>

&#x20; <text x="152" y="124" text-anchor="middle" font-size="10" fill="#999">3월</text>

&#x20; <text x="202" y="124" text-anchor="middle" font-size="10" fill="#999">4월</text>

&#x20; <text x="252" y="124" text-anchor="middle" font-size="10" fill="#999">5월</text>

&#x20; <rect x="190" y="50" width="72" height="20" rx="10" fill="#E5F5EE"/>

&#x20; <text x="226" y="64" text-anchor="middle" font-size="11" font-weight="700" fill="#00B26A">+308%</text>

</svg>

```



\#### 신규 패턴 ⑤ — 꺾은선 차트 하락형 (TYPE D)

```html

<svg viewBox="0 0 280 140" style="width:100%;">

&#x20; <line x1="32" y1="10" x2="32"  y2="110" stroke="#E5E5E5" stroke-width="1"/>

&#x20; <line x1="32" y1="110" x2="270" y2="110" stroke="#E5E5E5" stroke-width="1"/>

&#x20; <path d="M52,20 L102,38 L152,58 L202,80 L252,100 L252,110 L52,110 Z"

&#x20;       fill="#E63946" opacity="0.05"/>

&#x20; <polyline points="52,20 102,38 152,58 202,80 252,100"

&#x20;           fill="none" stroke="#C7CDD9" stroke-width="2.5"

&#x20;           stroke-linecap="round" stroke-linejoin="round"/>

&#x20; <circle cx="52"  cy="20"  r="4" fill="#fff" stroke="#C7CDD9" stroke-width="2"/>

&#x20; <circle cx="102" cy="38"  r="4" fill="#fff" stroke="#C7CDD9" stroke-width="2"/>

&#x20; <circle cx="152" cy="58"  r="4" fill="#fff" stroke="#C7CDD9" stroke-width="2"/>

&#x20; <circle cx="202" cy="80"  r="4" fill="#fff" stroke="#C7CDD9" stroke-width="2"/>

&#x20; <circle cx="252" cy="100" r="5" fill="#00B26A" stroke="#00B26A" stroke-width="2"/>

&#x20; <text x="52"  y="14"  text-anchor="middle" font-size="12" font-weight="700" fill="#E63946">487건</text>

&#x20; <text x="252" y="94"  text-anchor="middle" font-size="12" font-weight="700" fill="#00B26A">0건</text>

&#x20; <text x="52"  y="124" text-anchor="middle" font-size="10" fill="#999">도입 전</text>

&#x20; <text x="252" y="124" text-anchor="middle" font-size="10" fill="#999">도입 후</text>

</svg>

```



\#### 신규 패턴 ⑥ — 수평 프로그레스 바 단일형 (TYPE C)

```html

<svg viewBox="0 0 280 60" style="width:100%;">

&#x20; <text x="0"   y="14" font-size="12" font-weight="600" fill="#111">전환율 개선</text>

&#x20; <text x="280" y="14" text-anchor="end" font-size="14" font-weight="800" fill="#2B5CFF">○○%</text>

&#x20; <rect x="0" y="22" width="280" height="10" rx="5" fill="#E5E5E5"/>

&#x20; <rect x="0" y="22" width="196" height="10" rx="5" fill="#2B5CFF"/>

</svg>

```



\#### 신규 패턴 ⑦ — 수평 프로그레스 바 스택형 (TYPE H)

```html

<svg viewBox="0 0 280 100" style="width:100%;">

&#x20; <text x="0"   y="14" font-size="11" font-weight="600" fill="#111">Phase 1 · 기획</text>

&#x20; <text x="280" y="14" text-anchor="end" font-size="11" font-weight="700" fill="#00B26A">완료</text>

&#x20; <rect x="0" y="20" width="280" height="8" rx="4" fill="#E5E5E5"/>

&#x20; <rect x="0" y="20" width="280" height="8" rx="4" fill="#00B26A"/>



&#x20; <text x="0"   y="46" font-size="11" font-weight="600" fill="#111">Phase 2 · 개발</text>

&#x20; <text x="280" y="46" text-anchor="end" font-size="11" font-weight="700" fill="#2B5CFF">진행 중</text>

&#x20; <rect x="0" y="52" width="280" height="8" rx="4" fill="#E5E5E5"/>

&#x20; <rect x="0" y="52" width="140" height="8" rx="4" fill="#2B5CFF"/>



&#x20; <text x="0"   y="78" font-size="11" font-weight="600" fill="#999">Phase 3 · 배포</text>

&#x20; <text x="280" y="78" text-anchor="end" font-size="11" font-weight="700" fill="#999">예정</text>

&#x20; <rect x="0" y="84" width="280" height="8" rx="4" fill="#E5E5E5"/>

</svg>

```



\---



\## 7. ○ 처리 규칙 (수치 미정)



```

실제 수치 있음:     "130조원"

부분 수치만 있음:   "○○년 ○○조원"

완전 미정:         "○○○건" (자릿수만)

미공개:            "—"

추정:              "(추정치)" 명시

구조 변화:         수치 없어도 TYPE E 다이어그램 사용 — ○ 처리 불필요

```



\---



\## 8. 슬라이드 템플릿 + 분기 로직 (v4 업데이트)



\### TEMPLATE 1 — 표지 (Cover)



```

배경: --blue-deep 풀블리드

구성:

&#x20; 좌측 라벨: "PROJECT 01" (--xs, opacity 0.4)

&#x20; 메인 타이포: display 텍스트 (3줄)

&#x20; 서브 설명: 2줄

&#x20; 하단 메타 4줄: Process / Role / Period / Tools

&#x20; 우상단: 키워드 pill 4-6개

&#x20; 하단 row: 좌하단 조직명 / 우하단 "PM PORTFOLIO"

```



\### TEMPLATE 2 — 목차 (Index)



```

배경: 흰색

구성:

&#x20; 좌상단: 블루 라벨 "Portfolio"

&#x20; 큰 타이포: "Index." (h1, 끝에 블루 점)

&#x20; 하단 리스트: 번호 + 제목 (최대 5개)

```



\### TEMPLATE 3 — 프로젝트 표지 (Project Cover)



```

배경: --blue-deep 풀블리드

좌측 (42%): PROJECT 번호 / 프로젝트명 / Overview / 메타 4줄

우측 (58%): 목업 placeholder

&#x20; - 모바일 앱         → 폰 목업

&#x20; - B2B 대시보드      → 데스크탑 목업

&#x20; - 자동화/AI 프로젝트 → 코드 블록 또는 step-flow 다이어그램

```



\### TEMPLATE 4 — 배경 (Background / Research) ★ 분기 추가



```

배경: 흰색

헤더: section-tag "BACKGROUND" + pill



★ 데이터 스토리 유형별 분기:



\[T4-A] 수치 중심 (시장 규모, 성장률, 사용량)

&#x20; → 3분할 차트 카드 그리드 (기존 패턴 유지)

&#x20; 각 카드: pill + num-callout + mini chart SVG + 출처

&#x20; 사용 차트: Bar / Donut / Comparison Bar 조합

&#x20; 하단: 인사이트 바



\[T4-B] 구조/카테고리 중심 (프로세스, 시스템 구성)

&#x20; → 좌우 2분할

&#x20; 좌 (45%): 텍스트 카드 2-3개 (문제 배경 설명)

&#x20; 우 (55%): 레이어 다이어그램 또는 step-flow



\[T4-C] 시간 흐름 중심 (연도별 추이, 단계별 변화)

&#x20; → 꺾은선 차트 (와이드, 60%) + 우측 Callout 열 (40%)

&#x20; Callout: 시작값 / 현재값 / 변화율



\[T4-D] 비교 중심 (경쟁사, AS-IS vs TO-BE, 옵션 비교)

&#x20; → 비교표 (cmp) 전체 너비

&#x20; 강조 컬럼: cmp\_\_hl-col (빨간 테두리)

&#x20; 하단: 인사이트 바

```



\### TEMPLATE 5 — 3가지 구조적 문제 (Problem Cards) ★ 분기 추가



```

배경: 흰색

헤더: section-tag "PROBLEM"



★ 문제 성격별 분기:



\[T5-A] 문제 3개가 독립적

&#x20; → 3분할 카드 그리드 (기존 패턴 유지)

&#x20; 각 카드: 번호 배지 (red-soft) + pill (red) + 제목 + 본문 + sub-card



\[T5-B] 문제가 연쇄적 (A → B → C 원인-결과 구조)

&#x20; → step-flow 세로 배치 (3단계)

&#x20; 각 단계: 문제 노드 + 화살표 + 영향 설명 카드



\[T5-C] 문제가 Before 상태 하나로 수렴

&#x20; → T6(문제 재정의)과 병합

&#x20; T5 생략 후 T6에서 ab-compare로 처리

```



\### TEMPLATE 6 — 문제 재정의 (Problem Reframing)



```

배경: --ink 풀블리드

상단 라벨: "PROBLEM REFRAMING" (--xs, opacity 0.4)

도입 문장: 32px, opacity 0.5, 취소선

메인 재정의: display, 흰색, 가운데 정렬

&#x20; "○○ 문제가 아니라 \[노란 키워드] 문제였다"

하단 인용 박스: 좌측 노란 테두리 3px + 인용 텍스트



선택: A/B Compare 박스 추가 (더 풍부)

```



\### TEMPLATE 7 — 솔루션 핵심 결정 (Solution Decisions) ★ 분기 추가



```

배경: 흰색

헤더: section-tag "SOLUTION"



★ 결정 구조별 분기:



\[T7-A] 결정 3개가 독립적

&#x20; → 3분할 카드 그리드 (기존 패턴 유지)

&#x20; 각 카드: pill (--blue) + sub-card 2개 (대안/채택) + 카드 푸터



\[T7-B] 결정이 순차적 (1→2→3 의존 관계)

&#x20; → 수평 step-flow (step-flow 컴포넌트)

&#x20; + 각 스텝 하단 카드 (근거 + 트레이드오프)



\[T7-C] 결정이 AI/자동화 판단 기준 설계

&#x20; → 의사결정 트리 (dtree 컴포넌트)

&#x20; + 하단 결과 카드 3개 (각 조건별 처리 방식)

```



\### TEMPLATE 8 — 데이터 아키텍처 (Data Architecture)



```

배경: 흰색

헤더: section-tag "DATA ARCHITECTURE"

좌우 분할 (1 : 1.2):

&#x20; 좌 (코드 블록): DDL 2개 (다크 배경)

&#x20; 우 (Layer 다이어그램):

&#x20;   Layer 1: node--blue + 수치

&#x20;   Layer 2: node--ink  + 수치

&#x20;   Layer 3: node--soft + 수치

&#x20;   하단 확장성 박스 (--blue-soft)

```



\### TEMPLATE 9 — 와이어프레임 (Wireframe)



```

배경: --surface 또는 흰색

목업 3-5개 가로 배치

각 목업 하단 캡션: h3 블루 + 화면명 1줄

하단: 인사이트 바



분기:

&#x20; 모바일 앱         → 폰 목업 4-5개

&#x20; B2B 대시보드      → 데스크탑 목업 3개

&#x20; 자동화/파이프라인  → step-flow + 코드 블록 (목업 없음)

```



\### TEMPLATE 10 — Decision Log (AX/PO 핵심)



```

배경: 흰색

헤더: section-tag "DECISION LOG" + pill --ink ("AI 활용 · AX")

Decision Row 5-6개:

&#x20; 좌측 4px 블루 바 + 번호 배지 (--blue-soft)

&#x20; 제목 (h3) + 본문 (small, 키워드 hl-blue) + 트레이드오프 (--orange)



규칙:

&#x20; - tags에 "AI 활용" / "AX" / "PO" 포함되면 필수

&#x20; - 각 row 100자 이내

```



\### TEMPLATE 11 — Outcome (결과) ★ TYPE 분기 핵심



```

배경: 흰색

헤더: section-tag "OUTCOMES"



★ STEP 0: 복합 TYPE 판별

&#x20; → 성과 항목이 2개 TYPE 이상 혼재: T11-COMPLEX 사용

&#x20; → 단일 TYPE: 해당 TYPE 레이아웃 사용



★ TYPE별 레이아웃:



\[T11-A] TYPE A — 시간/속도

&#x20; 상단 (70%): 수평 비교 바 SVG (와이드)

&#x20; 우측 (30%): Big Callout (Before → After 수치)

&#x20; 하단: 인사이트 바



\[T11-B] TYPE B — 수량/볼륨

&#x20; 좌측 (65%): 꺾은선 차트 상승형 SVG

&#x20; 우측 (35%): KPI 카드 2개 (Before/After + 델타)

&#x20; 하단: 인사이트 바



\[T11-C] TYPE C — 비율/전환

&#x20; 좌 (55%): 수평 프로그레스 바 2-3개 (적층)

&#x20; 우 (45%): 도넛 차트 SVG

&#x20; 하단: 인사이트 바



\[T11-D] TYPE D — 오류/리스크

&#x20; 좌측 (60%): 꺾은선 차트 하락형 SVG

&#x20; 우측 (40%): 0 Callout 또는 취소선 수치 쌍

&#x20; 하단: 인사이트 바



\[T11-E1] TYPE E-1 — 자동화

&#x20; 전체: ba-flow (Before/After 플로우) 전체 너비

&#x20; 하단: 인사이트 바



\[T11-E2] TYPE E-2 — 구조/DB

&#x20; 좌 (40%): 코드 블록 2개

&#x20; 우 (60%): 레이어 다이어그램

&#x20; ※ 수치 없어도 레이아웃 그대로 사용



\[T11-E3] TYPE E-3 — AI 로직

&#x20; 전체: dtree 의사결정 트리

&#x20; 하단: 결과 카드 3개



\[T11-E4] TYPE E-4 — 파이프라인

&#x20; 상단: step-flow 전체 너비

&#x20; 하단: 카드 3개 (단계별 도구/시간)



\[T11-F] TYPE F — 비용/금액

&#x20; cost-card 2개 그리드 (절감 전/후)

&#x20; 하단: 인사이트 바



\[T11-G] TYPE G — 인원/규모

&#x20; 좌 (70%): 마일스톤 타임라인

&#x20; 우 (30%): Big Number (현재 규모)



\[T11-H] TYPE H — 진행/단계

&#x20; 상단: 프로그레스 바 스택형 SVG

&#x20; 하단: 마일스톤 타임라인



\[T11-COMPLEX] 복합 TYPE

&#x20; 상단: KPI 카드 4-5개 그리드

&#x20; 중단: 비교표 (cmp, 전체 지표)

&#x20; 하단: 정성 변화 카드 3개 (--blue-soft)

```



\### TEMPLATE 12 — 한계 및 다음 단계 (Limits \& Next Steps)



```

배경: 흰색

좌우 분할:

&#x20; 좌 "현재 한계": pill --problem + 한계 카드 2-3개 (좌측 빨간 보더)

&#x20; 우 "개선 방향": pill --blue + 개선 카드 3개 (--blue-soft 배경)

하단 인사이트 바 (선택)

```



\### TEMPLATE 13 — 결말 (Closing)



```

배경: --blue-deep 풀블리드

중앙: display 흰색 타이포

&#x20; "도전했습니다."

&#x20; 구분선

&#x20; "감사합니다."

하단: "CHALLENGE TO BE USEFUL." + 이름 (opacity 0.6)

```



\---



\## 9. 슬라이드 시퀀스 (프로젝트 1개 = 9-11 슬라이드)



```

필수 슬라이드 (모든 프로젝트):

&#x20; 1. PROJECT COVER             \[T3]

&#x20; 2. BACKGROUND                \[T4] — 데이터 스토리 유형으로 분기

&#x20; 3. PROBLEM CARDS             \[T5] — 문제 성격으로 분기

&#x20; 4. PROBLEM REFRAMING         \[T6]

&#x20; 5. SOLUTION DECISIONS        \[T7] — 결정 구조로 분기

&#x20; 9. OUTCOME                   \[T11] — TYPE 감지로 분기



조건부 슬라이드:

&#x20; 6. DATA ARCHITECTURE         \[T8]   ※ "DB" / "스키마" / "DDL" / "테이블" 언급 시

&#x20; 7. WIREFRAME                 \[T9]   ※ 시각 결과물 있을 때

&#x20; 8. DECISION LOG              \[T10]  ※ tags에 "AI 활용" / "AX" / "PO" 시

&#x20; 10. LIMITS \& NEXT STEPS      \[T12]  ※ 한계 섹션 있을 때



전체: 표지(T1) + 목차(T2) + 프로젝트별 9-11장 + 결말(T13)

```



\---



\## 10. CLI 작업 프로토콜



\### STEP 1: project.md 파싱



```

\- YAML frontmatter 추출 (id, title, period, role, tags, tools, organization, status)

\- ## 1 \~ ## 7 섹션 분리

\- ## 7 (활용 메모)는 외부 노출 금지 (참고용)

```



\### STEP 2: 슬라이드 계획 수립 (결정 트리)



```

□ tags에 "AI 활용" / "AX" / "PO" 포함?

&#x20; YES → DECISION LOG (T10) 필수



□ 본문에 "DB" / "스키마" / "DDL" / "테이블" / "API" / "아키텍처" 언급?

&#x20; YES → DATA ARCHITECTURE (T8) 필수



□ ## 1 (배경)의 데이터 스토리 유형 판별:

&#x20; 수치 중심        → T4-A

&#x20; 구조/카테고리    → T4-B

&#x20; 시간 흐름        → T4-C

&#x20; 비교 중심        → T4-D



□ ## 3 (문제)의 문제 성격 판별:

&#x20; 독립적 3개       → T5-A

&#x20; 연쇄적 구조      → T5-B

&#x20; 하나로 수렴      → T5 생략, T6 ab-compare 처리



□ ## 2 (솔루션)의 결정 구조 판별:

&#x20; 독립적 결정      → T7-A

&#x20; 순차 의존        → T7-B

&#x20; AI/자동화 판단   → T7-C



□ ## 4 (결과) TYPE 감지:

&#x20;   → Section 6-1 마스터 테이블의 키워드 열 스캔으로 TYPE 결정

&#x20;   → 복합 히트(2개+): T11-COMPLEX / 단일 히트: 해당 T11 레이아웃

&#x20;   → 수치 미정: ○ 처리 / TYPE E 구조변화: 수치 없어도 다이어그램 사용



□ project type 판별:

&#x20; "모바일/앱"                → 폰 목업

&#x20; "대시보드/어드민/B2B"      → 데스크탑 목업

&#x20; "자동화/파이프라인/스크립트" → 코드 블록 + step-flow

```



\### STEP 3: 시각요소 풍부함 검증



```

각 슬라이드 생성 후 자가 점검:



&#x20; □ 시각요소 종류가 3종 이상인가?

&#x20; □ 카드가 있다면 sub-card 또는 내부 위계가 있는가?

&#x20; □ TYPE 감지가 정확한가? (키워드 재확인)

&#x20; □ TYPE에 맞는 핵심 시각요소가 사용됐는가?

&#x20; □ TYPE E는 수치 없어도 다이어그램 사용했는가?

&#x20; □ 하단 인사이트 바 있는가? (T6/T13 제외)



미충족 시 → 재생성

```



\### STEP 4: HTML 생성



```

\- 단일 HTML 파일

\- <style> 블록은 head에 통합

\- 각 슬라이드 = <section class="slide"> 단위

\- 1280x720 viewport 기준

\- Pretendard CDN 임포트



Figma 친화 규칙:

&#x20; ✓ flex / grid 위주 (absolute positioning 최소화)

&#x20; ✓ SVG는 inline (외부 파일 X)

&#x20; ✓ 외부 이미지 URL 사용 안 함

&#x20; ✓ rem이 아닌 px 사용

&#x20; ✓ box-shadow 사용 안 함

```



\### STEP 5: 품질 체크



```

□ 슬라이드당 컬러 면적 ≤ 30%

□ 액센트 컬러 슬라이드당 1색만

□ 모든 차트에 출처 표기 또는 (출처 미정)

□ 수치 미정은 모두 ○ 처리

□ 이미지 placeholder는 모두 (필요이미지: ...) 형식

□ TYPE 감지 결과와 사용된 시각요소가 매핑 테이블과 일치하는가

□ TYPE E 슬라이드에 수치 없다고 비교표로 대체하지 않았는가

□ 흰 배경 : 컬러 풀블리드 = 7:3 이내

□ 시각요소 3종 미만 슬라이드 = 0개

□ "텍스트만 있는 카드" = 0개

```



\---



\## 11. ⛔ 절대 금지 / ✅ 절대 준수



\### 금지



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

✗ absolute positioning 남용

✗ 외부 이미지 URL

✗ 흰 배경 위 노란색 글자

✗ TYPE 무시하고 항상 비교표 + KPI 카드만 사용 (v4 금지 추가)

✗ TYPE E 성과를 수치 없다는 이유로 다이어그램 없이 처리 (v4 금지 추가)

✗ 모든 T4 배경 슬라이드를 3분할 차트 카드로만 처리 (v4 금지 추가)

✗ 모든 T5 문제 슬라이드를 3분할 카드로만 처리 (v4 금지 추가)

```



\### 준수



```

✓ 흰 배경이 디폴트

✓ 슬라이드당 시각요소 3종 이상

✓ 카드는 sub-card 또는 수치 callout과 결합

✓ 성과 항목 키워드 스캔 → TYPE 감지 → 레이아웃 선택 순서 준수

✓ TYPE별 핵심 시각요소 우선 사용

✓ TYPE E는 수치 없어도 다이어그램 사용

✓ 데이터 스토리 유형으로 T4 분기

✓ 문제 성격으로 T5 분기

✓ 결정 구조로 T7 분기

✓ 수치는 실제 또는 ○

✓ HTML은 flex/grid 위주 (Figma 친화)

✓ SVG는 데이터 차트에만, 다이어그램은 HTML div

```



\---



\## 12. 참고 — 카피아 마케팅 대시보드 TYPE 판단 결과



> 각 슬라이드에서 어떤 분기가 선택됐는지만 기록. 상세 내용은 Section 8 참조.



```

슬라이드 2 — T4-A  (수치 중심: 채널수 33개, 링크수 296개, 소요시간 2\~3일)

슬라이드 3 — T5-A  (독립적 문제 3개: 채널부재 / 목적혼재 / 사업부분리불가)

슬라이드 4 — T6    (문제 재정의: 대시보드 부재 → 데이터 구조 부재)

슬라이드 5 — T7-A  (독립적 결정 3개: 정규화 / 계층설계 / 실시간연동)

슬라이드 6 — T8    (E-2: DDL 코드블록 + 3-Layer 다이어그램)

슬라이드 7 — T9    (데스크탑 목업 3개: Layer 1/2/3)

슬라이드 8 — T10   (Decision Log: AX 태그 감지)

슬라이드 9 — T11-COMPLEX (A+B+E-2 복합: cmp + KPI카드 + 정성카드)

슬라이드 10 — T12  (한계 3 / 개선 3 좌우 분할)

```



\## 13. 변경 이력



```

v4.0 (2026-05-04)

&#x20; - 핵심 철학 추가: "슬라이드 유형이 아닌 성과 TYPE으로 레이아웃 결정"

&#x20; - Section 5 확장: 신규 도형 5-11\~5-15 추가 (ba-flow / step-flow / dtree / milestone / cost-card)

&#x20;     5-11 Before/After 플로우 (ba-flow) — TYPE E-1

&#x20;     5-12 수평 스텝 다이어그램 (step-flow) — TYPE E-4

&#x20;     5-13 의사결정 트리 (dtree) — TYPE E-3

&#x20;     5-14 마일스톤 타임라인 (milestone) — TYPE G, H

&#x20;     5-15 Cost Card — TYPE F

&#x20; - Section 6 재편:

&#x20;     6-1 성과 TYPE × 시각요소 매핑 테이블 신설 (TYPE A\~H, E 4분기)

&#x20;     6-3 SVG 차트 패턴 4종 추가 (꺾은선 상승/하락, 프로그레스 단일/스택)

&#x20; - Section 8 전면 업데이트:

&#x20;     T4 데이터 스토리 유형별 4분기 (T4-A/B/C/D)

&#x20;     T5 문제 성격별 3분기 (T5-A/B/C)

&#x20;     T7 결정 구조별 3분기 (T7-A/B/C)

&#x20;     T11 TYPE별 12분기 (T11-A/B/C/D/E1/E2/E3/E4/F/G/H/COMPLEX)

&#x20; - Section 10 STEP 2 전면 업데이트: TYPE 감지 결정 트리 통합

&#x20; - Section 11 금지 항목 3개 추가 (TYPE 관련)

&#x20; - SVG vs HTML div 원칙 명시: 데이터 차트=SVG, 구조 다이어그램=HTML div



v3.0 (2026-04-30)

&#x20; - Anti-단조로움 정책 신설

&#x20; - Card + Sub-card Nested Pattern 필수화

&#x20; - DATA ARCHITECTURE 템플릿 신설

&#x20; - 시각요소 풍부함 검증 단계 추가



v2.0 (2026-04-30)

&#x20; - 흰 배경 디폴트 + 프린트 친화

&#x20; - 도형 라이브러리 7종

&#x20; - 차트 사용 결정 트리

&#x20; - ○ 처리 규칙



v1.0 (폐기) — AI 스러운 다크/그라디언트 테마

```

