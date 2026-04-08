# Undercover Pop Culture — Project Brief

> Référence pour démarrer une nouvelle session. Stack : React Native + Node.js.
> Le fichier SQL `undercover_characters.sql` contient ~200 personnages prêts à importer.

---

## 1. Concept

Jeu mobile multijoueur local "Undercover" sur thème pop culture.  
5 joueurs par défaut (3–10 supportés), 1 undercover parmi eux (2 si ≥ 7 joueurs).  
Chaque joueur reçoit un personnage : les citoyens ont le même, l'undercover a un personnage proche mais différent (même univers ou tags communs).

---

## 2. Fonctionnalités à implémenter

### 2.1 Écrans (flow linéaire)

| Ordre | Écran | Description |
|-------|-------|-------------|
| 1 | **Home / Setup** | Noms des joueurs (éditables), nombre de joueurs, bouton Démarrer |
| 2 | **Waiting** | "Passe le téléphone au joueur N" — écran neutre entre chaque reveal |
| 3 | **Reveal** | Affiche emoji + nom du personnage (rôle caché). Countdown 7s auto. |
| 4 | **Game On** | Ordre de passage randomisé (régénérable), bouton Démarrer le débat |
| 5 | **Debate Timer** | Timer circulaire SVG (2 / 3 / 5 min au choix). Alerte sonore à 0. |
| 6 | **3-2-1** | Compte à rebours animé avec sons avant le vote |
| 7 | **Vote** | Chaque joueur vote pour éliminer quelqu'un |
| 8 | **Results** | Gagnant affiché. Si undercover gagne → révèle son identité + son mot |

### 2.2 Système de personnages

- Base de ~200 personnages (voir `undercover_characters.sql`)
- Champs : `name`, `emoji`, `universe`, `role` (hero/villain/neutral), `tags`
- **Algorithme de pairing dynamique** (pas de table de paires statiques) :
  1. Choisir un personnage A aléatoire
  2. Trouver tous les personnages partageant ≥ 1 tag avec A
  3. Exclure A, choisir B aléatoirement dans ce pool
  4. A = citoyens, B = undercover (ou inversement aléatoirement)

### 2.3 Authentification & Profils

- JWT (access token 15min + refresh token 7j)
- Compte optionnel — on peut jouer sans compte
- Profil : pseudo, avatar (emoji), statistiques personnelles

### 2.4 Statistiques personnelles

- Nombre de parties jouées / gagnées
- Nombre de fois undercover
- Taux de victoire undercover
- Personnages les plus souvent reçus

### 2.5 Sons

- Beep court à chaque seconde du countdown reveal
- Beep urgent (rouge) sur les 3 dernières secondes
- Alarme à la fin du débat
- Son de victoire sur l'écran résultats

---

## 3. Stack Technique

### 3.1 Frontend — React Native

| Outil | Rôle |
|-------|------|
| **Expo SDK** (latest) | Framework React Native managé |
| **NativeWind v4** | Tailwind CSS pour React Native |
| **React Navigation v6** | Navigation entre écrans (Stack + possible Tab) |
| **Orval** | Génération auto des hooks React Query depuis le schéma OpenAPI du back |
| **React Query (TanStack)** | Cache & état serveur (intégré avec Orval) |
| **Zustand** | État local global (partie en cours, joueurs, assignments) |
| **Expo AV** | Sons et audio |
| **React Native Reanimated v3** | Animations fluides (timer, transitions) |
| **Expo Haptics** | Retour haptique sur les actions importantes |
| **AsyncStorage** | Persistance locale (token JWT, préférences) |
| **Zod** | Validation des formulaires côté client |

### 3.2 Backend — Node.js

| Outil | Rôle |
|-------|------|
| **Fastify v4** | Serveur HTTP rapide, plugins natifs |
| **Prisma ORM** | Accès DB type-safe, migrations, seed |
| **MariaDB** | Base de données (importer `undercover_characters.sql`) |
| **@fastify/jwt** | JWT access + refresh tokens |
| **@fastify/rate-limit** | Protection brute force |
| **@fastify/helmet** | Headers HTTP sécurisés |
| **@fastify/cors** | CORS configuré strictement |
| **Zod** | Validation des inputs (body, params, query) |
| **@fastify/swagger** | Génération automatique OpenAPI → utilisé par Orval |
| **bcrypt** | Hash des mots de passe |
| **Vitest** | Tests unitaires et d'intégration |
| **Supertest** | Tests des routes HTTP |

---

## 4. Architecture

### 4.1 Frontend — Structure des dossiers

```
src/
├── components/          # Composants réutilisables UNIQUEMENT
│   ├── ui/              # Button, Card, Badge, Avatar, Timer...
│   ├── game/            # PlayerCard, CharacterReveal, VoteItem...
│   └── layout/          # Screen, SafeArea, KeyboardAvoider...
├── screens/             # Un fichier par écran, LÉGER (délègue aux composants)
│   ├── HomeScreen.tsx
│   ├── WaitingScreen.tsx
│   ├── RevealScreen.tsx
│   ├── GameOnScreen.tsx
│   ├── DebateScreen.tsx
│   ├── CountdownScreen.tsx
│   ├── VoteScreen.tsx
│   └── ResultsScreen.tsx
├── store/               # Zustand stores
│   ├── gameStore.ts     # État de la partie en cours
│   └── authStore.ts     # Utilisateur connecté, tokens
├── api/                 # Généré par Orval (ne pas modifier manuellement)
│   └── generated/
├── hooks/               # Hooks custom métier
│   ├── useGameAudio.ts
│   ├── useCountdown.ts
│   └── usePairingAlgorithm.ts
├── utils/               # Fonctions pures sans effet de bord
├── constants/           # Couleurs, durées, config
└── types/               # Types TypeScript partagés
```

**Règles front :**
- Chaque écran fait **≤ 150 lignes** — toute logique complexe va dans un hook ou composant
- Variables explicites : `remainingSeconds` pas `rem`, `isUndercoverWinner` pas `win`
- Composants réutilisables dans `components/ui/` sans logique métier
- Props typées avec des interfaces nommées (`interface RevealCardProps { ... }`)
- Pas de `any`, pas de `// @ts-ignore`

### 4.2 Backend — Structure des dossiers

```
src/
├── routes/              # Déclaration des routes Fastify (thin — délègue aux services)
│   ├── auth.routes.ts
│   ├── characters.routes.ts
│   ├── games.routes.ts
│   └── stats.routes.ts
├── services/            # Logique métier pure, testable unitairement
│   ├── auth.service.ts
│   ├── character.service.ts
│   ├── pairing.service.ts   # Algorithme de pairing dynamique
│   └── stats.service.ts
├── schemas/             # Schémas Zod (validation) + types inférés
├── plugins/             # Plugins Fastify (jwt, cors, helmet, swagger)
├── prisma/
│   ├── schema.prisma
│   └── seed.ts          # Importe les personnages depuis le SQL
└── tests/
    ├── unit/            # Services isolés (mock Prisma)
    └── integration/     # Routes avec DB de test
```

**Règles back :**
- Routes = validation input + appel service + retour réponse (≤ 30 lignes)
- Services = logique pure, facilement mockable
- Toute entrée utilisateur validée avec Zod avant d'entrer dans un service
- **Jamais de requête SQL brute** — tout passe par Prisma

---

## 5. Sécurité — Points à couvrir

| Faille | Mitigation |
|--------|-----------|
| Injection SQL | Prisma ORM (requêtes paramétrées) |
| XSS | Données jamais injectées en HTML brut côté front |
| Brute force login | `@fastify/rate-limit` (5 tentatives / 15min par IP) |
| JWT vol | Access token court (15min), refresh token HttpOnly cookie |
| CORS ouvert | Whitelist explicite des origines (pas `*` en prod) |
| Données sensibles exposées | Ne jamais renvoyer le hash du mot de passe dans les réponses |
| Paramètres non validés | Zod sur **tous** les inputs (body, params, query) |
| Dépendances vulnérables | `npm audit` dans la CI |
| Tokens secrets exposés | `.env` + `.gitignore`, jamais de secrets dans le code |

---

## 6. Tests — Stratégie

### Backend
- **Tests unitaires** (Vitest) : chaque service testé isolément avec Prisma mocké
  - `pairing.service.test.ts` — vérifie que le pairing respecte les règles de tags
  - `auth.service.test.ts` — hash, vérification, génération tokens
- **Tests d'intégration** (Vitest + Supertest) : routes testées avec une DB MariaDB de test
  - `POST /auth/login` — cas valide, mauvais mot de passe, rate limit
  - `GET /characters/pair` — retourne toujours deux personnages distincts avec tags communs
- **Règle** : tout service modifié → test mis à jour ou ajouté

### Frontend
- Tests des hooks custom avec `@testing-library/react-hooks`
- Tests des utils pures (algorithmes, formatters)

---

## 7. API — Endpoints principaux

```
POST   /auth/register
POST   /auth/login
POST   /auth/refresh
DELETE /auth/logout

GET    /characters              # Liste paginée
GET    /characters/pair         # Retourne un pair A/B selon l'algo dynamique
GET    /characters/:id

GET    /stats/me                # Stats du joueur connecté
POST   /games                  # Crée une partie (enregistre le résultat)

GET    /health                  # Healthcheck
```

Le back expose un schéma **OpenAPI** via `@fastify/swagger`.  
Orval consomme ce schéma pour générer les hooks React Query dans `src/api/generated/`.

---

## 8. Données initiales

- Importer `undercover_characters.sql` dans MariaDB
- Ou utiliser le seed Prisma (`prisma/seed.ts`) qui lit le même jeu de données
- ~200 personnages, 40 tags, univers : DC, Marvel, Star Wars, HP, LOTR, Disney, Jeux Vidéo, Manga, Cinéma, BD Franco-Belge, Historique

---

## 9. Environnement

```
# .env (backend)
DATABASE_URL="mysql://user:password@localhost:3306/undercover"
JWT_SECRET="..."
JWT_REFRESH_SECRET="..."
PORT=3000

# .env (frontend / Expo)
EXPO_PUBLIC_API_URL="http://localhost:3000"
```

---

## 10. Checklist de démarrage

- [ ] `npx create-expo-app undercover --template blank-typescript`
- [ ] `npx fastify-cli generate undercover-api`
- [ ] Configurer Prisma + MariaDB + importer le SQL
- [ ] Configurer Swagger côté back → tester avec Orval côté front
- [ ] NativeWind : suivre la doc v4 (config Babel + tailwind.config.js)
- [ ] Zustand store `gameStore` : `players`, `assignments`, `currentPair`, `phase`
- [ ] Implémenter `pairing.service.ts` en premier (cœur du jeu) + le tester

