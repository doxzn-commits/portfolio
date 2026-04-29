# AX 포트폴리오 자동화 프로젝트

## 프로젝트 목적
채용 공고(JD)를 입력하면, 저장된 프로젝트 파일들과 매핑하여
최고 평가 점수를 목표로 하는 포트폴리오 HTML을 자동 생성하는 시스템.

---

## 폴더 구조

```
AX 포트폴리오/
├── CLAUDE.md                    ← 이 파일 (프로젝트 컨텍스트)
├── design/
│   └── design.md          ← 디자인 시스템 레퍼런스 (필수 참조)
├── projects/
│   ├── _template.md             ← 프로젝트 파일 작성 템플릿
│   └── *.md                     ← 개별 프로젝트 파일들
├── jds/
│   ├── _template.md             ← JD 파일 템플릿
│   └── *.md                     ← 개별 JD 파일들
├── output/
│   └── *.html                   ← 생성된 포트폴리오 HTML (Figma import용)
└── .claude/
    └── commands/
        ├── new-project.md       ← /new-project 커맨드
        ├── new-jd.md            ← /new-jd 커맨드
        └── generate-portfolio.md ← /generate-portfolio 커맨드
```

---

## 슬래시 커맨드 요약

| 커맨드 | 트리거 | 용도 |
|--------|--------|------|
| `/new-project` | 새 프로젝트 추가 시 | `projects/_template.md` 기반으로 인터뷰 후 파일 생성 |
| `/new-jd` | 지원할 회사 생길 때 | 기업명 + 공고 붙여넣기 → `jds/` 폴더에 파일 생성 |
| `/generate-portfolio` | 포트폴리오 생성 시 | 모든 프로젝트 + 특정 JD → 채점 역추산 → HTML 생성 |

---

## 디자인 규칙 (필수)

포트폴리오 HTML 생성 시 반드시 `design/design.md`를 먼저 읽고 적용할 것.

### 핵심 제약
- 폰트: `SF Pro Display, system-ui, -apple-system, sans-serif`
- 슬라이드 규격: **1280 × 720px** (16:9 가로형 PPT 규격)
- 모든 사이즈: **고정 px** (cqw, vw, % 사용 금지 — Figma HTML to Figma 플러그인 호환)
- 배경 교차: 라이트(#ffffff / #f5f5f7) ↔ 다크(#272729) 타일 교차
- 인터랙티브 색상: `#0066cc` 단일 사용
- 그라디언트 금지 / 카드 shadow 금지 / 이모지 금지
- 각 슬라이드는 `<section class="slide">` 단위로 분리

### 출력 형식
- 파일 1개 = 슬라이드 1개 (HTML 파일명: `slide-01.html`, `slide-02.html` ...)
- 또는 단일 HTML에 모든 슬라이드를 `<section>` 태그로 구성
- Figma HTML to Figma 플러그인 기준: 단일 파일 권장

---

## 포트폴리오 생성 원칙

### 채점 역추산 로직
1. JD에서 평가 기준 키워드를 추출 (기술 스택, 경험 유형, 역량)
2. 각 기준에 프로젝트 파일을 매핑 (coverage score 계산)
3. 커버리지가 높은 프로젝트를 우선 배치
4. 커버리지 gap은 "판단과 구조" 서술로 보완

### 서술 방식
- "무엇을 만들었다" → "어떤 문제를 어떻게 정의했다"
- 수치 없는 항목 → `◯` 플레이스홀더 사용 (임의 수치 생성 금지)
- 핵심 프레임: **"문제를 예방한 구조 설계자"**

---

## 주의사항
- 프로젝트 파일의 `## 7. 포트폴리오 활용 메모` 섹션은 외부 노출 금지
- 수치 미확정 항목은 반드시 `◯` 처리 (절대 추정값 사용 금지)
- 생성된 HTML은 `output/` 폴더에 저장
