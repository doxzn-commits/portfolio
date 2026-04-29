# SENOIR (세누아) — Claude Code 개발 컨텍스트

> **포지션 (절대 변경 불가):** "향기로 기억을 기록하는 앱"
> 향수 추천 앱이 아니다. 기억·감정·상황을 향으로 저장하는 경험 플랫폼이다.

---

## 1. 기술 스택

| 영역 | 선택 | 버전 |
|------|------|------|
| 프레임워크 | React Native + Expo | SDK 51+ |
| 라우팅 | Expo Router (file-based) | v3 |
| 백엔드 | Supabase | latest |
| AI | Anthropic Claude API | claude-sonnet-4-20250514 |
| 상태관리 | Zustand | latest |
| 스타일 | StyleSheet (RN 기본) — NO Tailwind, NO styled-components |
| 이미지 | expo-image | latest |
| 폰트 | expo-font + @expo-google-fonts | — |
| 알림 | expo-notifications | — |
| 공유 | expo-sharing + expo-media-library | — |

---

## 2. 프로젝트 구조

```
senoir/
├── app/                          # Expo Router 라우팅
│   ├── (tabs)/
│   │   ├── index.tsx             # S-03 홈 메인
│   │   ├── memory.tsx            # S-06 기억 일기 목록
│   │   ├── explore.tsx           # S-04 향 찾기
│   │   └── profile.tsx           # S-12 프로필
│   ├── onboarding.tsx            # S-02 온보딩
│   ├── memory/
│   │   ├── new.tsx               # S-07 기억 일기 작성
│   │   └── [id].tsx              # S-08 기억 일기 상세
│   ├── fragrance/
│   │   └── [id].tsx              # S-11 향수 상세
│   ├── quiz/
│   │   ├── index.tsx             # S-09 퀴즈
│   │   └── result.tsx            # S-10 퀴즈 결과
│   ├── search-result.tsx         # S-05 향 찾기 결과
│   └── _layout.tsx
├── components/
│   ├── ui/                       # 공통 원자 컴포넌트
│   │   ├── SenButton.tsx
│   │   ├── SenCard.tsx
│   │   ├── SenTextArea.tsx
│   │   ├── EmotionChip.tsx
│   │   ├── FragranceCard.tsx
│   │   └── LoadingText.tsx
│   ├── layout/
│   │   ├── SenHeader.tsx
│   │   └── TabBar.tsx
│   └── sheets/
│       ├── LoginSheet.tsx
│       └── DatePickerSheet.tsx
├── constants/
│   ├── colors.ts                 # 컬러 토큰 (변경 불가)
│   ├── typography.ts             # 타이포 스펙 (변경 불가)
│   ├── motion.ts                 # 모션 수치
│   └── emotions.ts               # 감정 태그 9종
├── lib/
│   ├── supabase.ts               # Supabase 클라이언트
│   ├── claude.ts                 # Claude API 호출
│   └── shareCard.ts              # 공유 카드 생성
├── stores/
│   ├── authStore.ts              # 로그인 상태
│   └── memoryStore.ts            # 기억 일기 상태
├── types/
│   └── index.ts
└── assets/fonts/
```

---

## 3. 디자인 토큰 (변경 불가)

### constants/colors.ts
```typescript
export const Colors = {
  // 배경
  NoirWarm: '#0F0D0B',   // 앱 배경. 기억의 온기가 스민 어둠
  Ink: '#161310',         // 카드 배경. Noir와의 레이어 분리

  // 포인트
  AmberGold: '#C4A063',  // 핵심 CTA. 아껴 쓴다

  // 텍스트
  Parchment: '#F2EDE3',  // 밝은 배경 / 향수명 강조 텍스트
  Ash: '#A8A298',         // 본문 텍스트
  Dim: '#6A6460',         // 보조 텍스트 / 아이콘 / 날짜
  Fade: '#8C7A5E',        // 오래된 기억 / 메모 / 보조 감정 텍스트

  // 구조
  Rule: '#242018',        // 구분선 / 테두리

  // 감정 태그
  Emotion: {
    슬픔: '#7A6AB8',
    외로움: '#6A5A9A',
    그리움: '#B8965A',
    무덤덤: '#6A6460',
    설렘: '#C4A063',
    행복: '#4A8A5A',
    평온: '#4A7A8A',
    뿌듯함: '#5A8A7A',
    설명하기어려운: '#8A3A3A',
  },

  // 특수
  Parchment_BG: '#F2EDE3', // 온보딩·퀴즈 결과 전용 밝은 배경
} as const;
```

### constants/typography.ts
```typescript
// 시스템 폰트(SF Pro, Roboto) 절대 금지
export const Fonts = {
  Cormorant: 'CormorantGaramond_400Regular_Italic', // 감성 헤드라인
  NotoSans: 'NotoSansKR_300Light',                  // UI 본문
  DMMono: 'DMMono_400Regular',                       // 레이블·날짜·배지
} as const;

export const Typography = {
  // Cormorant — 감정이 실린 문장에만
  displayLarge: { fontFamily: Fonts.Cormorant, fontSize: 36 },
  displayMedium: { fontFamily: Fonts.Cormorant, fontSize: 28 },
  displaySmall: { fontFamily: Fonts.Cormorant, fontSize: 22 },
  headlineSmall: { fontFamily: Fonts.Cormorant, fontSize: 20 },

  // Noto Sans KR — UI 본문·설명·버튼
  bodyLarge: { fontFamily: Fonts.NotoSans, fontSize: 15 },
  bodyMedium: { fontFamily: Fonts.NotoSans, fontSize: 14 },
  bodySmall: { fontFamily: Fonts.NotoSans, fontSize: 13 },
  buttonLabel: { fontFamily: Fonts.NotoSans, fontSize: 15, fontWeight: '700' as const },

  // DM Mono — 레이블·날짜·배지·태그
  labelMedium: { fontFamily: Fonts.DMMono, fontSize: 13 },
  labelSmall: { fontFamily: Fonts.DMMono, fontSize: 11 },
  labelXSmall: { fontFamily: Fonts.DMMono, fontSize: 10 },
} as const;
```

### constants/motion.ts
```typescript
// 최소 300ms. 빠른 모션 금지. 바운스 금지.
export const Motion = {
  screenTransition: { duration: 350, easing: 'ease-out' },
  cardFade: { duration: 400, easing: 'ease-out' },
  buttonPress: { duration: 120, scale: 0.97 },
  bottomSheet: { duration: 380, damping: 0.85 },
  saveFeedback: { duration: 500, easing: 'ease-out' },
  hintFadeOut: { duration: 300, easing: 'ease-out' },
} as const;
```

### constants/emotions.ts
```typescript
export const EMOTIONS = [
  '슬픔', '외로움', '그리움', '무덤덤',
  '설렘', '행복', '평온', '뿌듯함', '설명하기 어려운',
] as const;

export type Emotion = typeof EMOTIONS[number];

// "설명하기 어려운"은 세누아 시그니처 태그.
// 기억이 항상 선명하지 않다는 철학을 담는다.
```

---

## 4. 마이크로카피 원칙

```typescript
// 기능 상태를 감성 언어로 치환한다. 절대 기술적 문구 사용 금지.
export const Copy = {
  saved: '기억이 담겼어요.',
  loading: '기억을 찾고 있어요...',
  error: '잠시 기억이 흐려졌어요.',
  empty: '조금 더 자세히 써주시면 더 잘 찾을 수 있어요.',
  notificationHint: '잊지 않도록 살짝 알려드릴게요.',
  logout: '잠시 자리를 비울게요.',
  emptyMemory: '첫 향 기억을 남겨보세요.',
  loginNudge: '기록을 시작하면 기억이 쌓여요.',
  saveNudge: '기억으로 남기시겠어요?',
  logoutConfirm: '잠시 자리를 비울게요. 괜찮으신가요?',
} as const;

// 향수 설명은 절대로 노트 나열 금지
// BAD:  "탑 노트: 시트러스, 미들 노트: 플로럴, 베이스: 우디"
// GOOD: "토요일 아침, 갓 세탁한 셔츠에서 날 법한 햇살 냄새"
```

---

## 5. 타입 정의

### types/index.ts
```typescript
import { Emotion } from '../constants/emotions';

export interface Memory {
  id: string;
  user_id: string;
  fragrance_name: string;
  emotions: Emotion[];
  memo: string;
  photos: string[];       // Supabase Storage URL[]
  recorded_at: string;    // ISO 8601
  created_at: string;
}

export interface Fragrance {
  id: string;
  name: string;
  sensory_description: string;  // 감성 언어만. 노트 나열 금지.
  emotions: Emotion[];
}

export interface QuizAnswer {
  question_id: number;
  selected_option: number;
}

export interface SearchResult {
  fragrances: Fragrance[];
  input_text: string;
}
```

---

## 6. Supabase 스키마

```sql
-- 기억 일기
create table memories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users not null,
  fragrance_name text not null,
  emotions text[] default '{}',
  memo text default '',
  photos text[] default '{}',
  recorded_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table memories enable row level security;
create policy "users own memories"
  on memories for all using (auth.uid() = user_id);

-- 사용자 프로필 (소셜 로그인 후 자동 생성)
create table profiles (
  id uuid primary key references auth.users,
  nickname text,
  avatar_url text,
  created_at timestamptz default now()
);

alter table profiles enable row level security;
create policy "users own profile"
  on profiles for all using (auth.uid() = id);
```

---

## 7. Claude API 연동

### lib/claude.ts
```typescript
const CLAUDE_MODEL = 'claude-sonnet-4-20250514';
const MAX_TOKENS = 1000;

// 향 찾기 — 기억 텍스트 → 향수 3개 추천
export async function findFragrancesByMemory(
  memoryText: string
): Promise<Fragrance[]> {
  const response = await fetch('https://api.anthropic.com/v1/messages', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': process.env.EXPO_PUBLIC_ANTHROPIC_API_KEY!,
      'anthropic-version': '2023-06-01',
    },
    body: JSON.stringify({
      model: CLAUDE_MODEL,
      max_tokens: MAX_TOKENS,
      system: `당신은 SENOIR(세누아) 앱의 향 큐레이터입니다.
사용자의 기억·감정·상황 텍스트를 받아 어울리는 향수 3개를 추천합니다.

규칙:
- 향수 설명은 반드시 감성 언어로만 작성한다.
- 절대 금지: "탑 노트: 시트러스, 미들 노트: 플로럴, 베이스: 우디" 같은 노트 나열
- 반드시 사용: "토요일 아침, 갓 세탁한 셔츠에서 날 법한 햇살 냄새" 같은 감성 묘사
- 응답은 반드시 JSON만. 앞뒤 설명 없음.

JSON 형식:
{
  "fragrances": [
    {
      "name": "향수명",
      "sensory_description": "기억에 녹아드는 감성 묘사 2–3줄",
      "emotions": ["감정1", "감정2"]
    }
  ]
}`,
      messages: [
        { role: 'user', content: memoryText }
      ],
    }),
  });

  const data = await response.json();
  const text = data.content[0].text;
  const parsed = JSON.parse(text);
  return parsed.fragrances;
}

// 퀴즈 결과 → 향수 추천
export async function findFragranceByQuiz(
  answers: QuizAnswer[]
): Promise<Fragrance> {
  // answers를 감성 언어로 변환 후 API 호출
  // findFragrancesByMemory와 동일한 패턴, 1개만 반환
}
```

---

## 8. 공통 UI 컴포넌트 규칙

### SenButton
```typescript
// Amber Gold CTA 버튼 — 핵심 액션에만
interface SenButtonProps {
  label: string;
  onPress: () => void;
  disabled?: boolean;
  variant?: 'primary' | 'ghost';  // primary=AmberGold bg, ghost=AmberGold border
}
// disabled 시 배경: Colors.Rule / 텍스트: Colors.Dim
// press 피드백: 120ms scale 0.97
```

### LoadingText
```typescript
// 스피너 절대 금지. 텍스트 opacity fade만.
// 기본 텍스트: Copy.loading ("기억을 찾고 있어요...")
// 400ms opacity 0→1 loop
```

### EmotionChip
```typescript
interface EmotionChipProps {
  emotion: Emotion;
  selected?: boolean;
  onPress?: () => void;
}
// 배경: Colors.Emotion[emotion] + '1A' (10% opacity)
// 텍스트: Colors.Emotion[emotion]
// 선택 시: 테두리 2px Colors.Emotion[emotion]
```

---

## 9. 화면별 핵심 구현 포인트

### S-03 홈 메인 (app/(tabs)/index.tsx)
- 날씨 감성 문구: 시간대 기반 정적 문구 배열로 MVP 구현 (API 불필요)
  - 06–09시: "이른 아침, 기억이 깨어나는 시간이에요."
  - 12–14시: "한낮의 햇살 속에 어떤 향이 스치나요?"
  - 18–21시: "하루가 저무는 향이 있나요?"
  - 22–06시: "오늘의 기억을 향으로 남겨보세요."
- 비로그인 시 기억 카드 영역 → 로그인 유도 배너로 대체

### S-04 향 찾기 (app/(tabs)/explore.tsx)
- 텍스트 입력 10자 이상 → CTA 버튼 활성화
- API 호출 중: `<LoadingText />` (스피너 금지)
- 오류 시: Copy.error 인라인 표시 + 재시도 버튼

### S-05 향 찾기 결과 (app/search-result.tsx)
- 카드 3개 순차 등장: 카드별 +80ms delay, fade-in 400ms
- 비로그인 "이거예요" → LoginSheet 바텀시트
- 로그인 "이거예요" → /memory/new?fragrance={name} 딥링크

### S-07 기억 일기 작성 (app/memory/new.tsx)
- 향수명 필수. 없으면 저장 버튼 비활성
- 저장 완료: Copy.saved fade-in 500ms → 0.8초 후 /memory로 이동

### S-10 퀴즈 결과 (app/quiz/result.tsx)
- 결과 확인 즉시 공유 버튼 노출 (감동 고조 시점, 지연 없음)
- 공유 카드 스펙: 9:16 / Noir Warm 배경 / Amber Gold Glow / Cormorant Italic 72px
- expo-sharing으로 이미지 공유

---

## 10. 인증 (Supabase Auth)

```typescript
// 소셜 로그인만 지원 (MVP)
// Apple: expo-apple-authentication
// Google: expo-auth-session + Google OAuth

// 로그인 필요 화면: S-06, S-07, S-08, S-12
// 비로그인 접근 시 → LoginSheet 바텀시트 노출 (화면 이동 금지)
```

---

## 11. 네비게이션 구조

```
바텀 탭 (4개):
  홈    → app/(tabs)/index.tsx        (S-03)
  기억   → app/(tabs)/memory.tsx       (S-06) — 로그인 필요
  탐색   → app/(tabs)/explore.tsx      (S-04)
  나    → app/(tabs)/profile.tsx      (S-12) — 로그인 필요

모달/스택:
  /onboarding          (S-02) — 최초 실행 시
  /memory/new          (S-07) — 로그인 필요
  /memory/[id]         (S-08) — 로그인 필요
  /fragrance/[id]      (S-11)
  /quiz                (S-09)
  /quiz/result         (S-10)
  /search-result       (S-05)
```

---

## 12. 환경변수 (.env)

```
EXPO_PUBLIC_SUPABASE_URL=
EXPO_PUBLIC_SUPABASE_ANON_KEY=
EXPO_PUBLIC_ANTHROPIC_API_KEY=
```

> ⚠️ Claude API Key는 클라이언트 직접 호출 구조로 MVP 구현.
> 베타 이후 Supabase Edge Function으로 이전 예정.

---

## 13. MVP 제외 항목 (구현 금지)

- 팔로우·팔로워 / 소셜 피드
- 실시간 채팅
- 향수 노트 분석기 (성분 분석)
- 지도 기능
- 구독 결제 (인앱 결제 전체)
- Fragrantica 스크래핑 (C&D 선례로 절대 금지)

---

## 14. 절대 원칙 요약

1. "향기로 기억을 기록하는 앱" 포지션 훼손 금지
2. 시스템 폰트 (SF Pro, Roboto) 사용 금지
3. 스피너 사용 금지 → LoadingText opacity fade만
4. Amber Gold는 CTA·포인트에만 — 헤더·본문 텍스트 사용 금지
5. Parchment 배경은 온보딩·퀴즈 결과에만
6. 향수 설명에 노트 나열 절대 금지 → 감성 묘사만
7. 모션 최소 300ms — 빠른 모션·바운스 금지
8. Fragrantica 스크래핑 절대 금지
