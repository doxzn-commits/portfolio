# AX 포트폴리오 자동화 시스템

채용 공고(JD)를 입력하면 저장된 프로젝트와 매핑하여  
최적화된 포트폴리오 HTML을 자동 생성하는 Claude Code 기반 시스템.

---

## 폴더 구조

```
├── CLAUDE.md                    ← Claude Code 프로젝트 컨텍스트
├── design/
│   └── DESIGN-apple.md          ← 디자인 시스템 레퍼런스
├── projects/
│   ├── _template.md             ← 프로젝트 파일 템플릿
│   └── *.md                     ← 개별 프로젝트 파일
├── jds/
│   ├── _template.md             ← JD 파일 템플릿
│   └── *.md                     ← 분석된 JD 파일
├── output/                      ← 생성된 포트폴리오 HTML
└── .claude/
    └── commands/
        ├── new-project.md
        ├── new-jd.md
        └── generate-portfolio.md
```

---

## 사용 방법

### 1. 프로젝트 추가
```
/new-project
```
Claude가 인터뷰 방식으로 정보를 수집하여 `projects/` 폴더에 파일 생성.

### 2. JD 등록
```
/new-jd
기업명: Channel Talk
공고 내용:
[채용공고 전문 붙여넣기]
```

### 3. 포트폴리오 생성
```
/generate-portfolio jd=channeltalk-ai-po-202504
```
→ `output/` 폴더에 Figma import용 HTML 생성.

### 4. Figma에 붙여넣기
Figma → 플러그인 → "HTML to Figma" → 생성된 HTML 붙여넣기

---

## 디자인 기준
`design/DESIGN-apple.md` 기반. 1280×720px 고정 규격 (16:9 PPT).
