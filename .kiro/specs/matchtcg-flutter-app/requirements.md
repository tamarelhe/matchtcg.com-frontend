# MatchTCG Flutter App - Requirements Document

## Introduction

MatchTCG is a mobile and web application built with Flutter that enables users to discover and create Trading Card Game (TCG) events near their location. The application supports games like Magic: The Gathering (MTG), Lorcana, Pokémon, and others, offering group management, venue management, and calendar integration features.

The application aims to connect the TCG gaming community, facilitating the organization of tournaments, casual matches, and social events, with a focus on user experience in Portuguese (pt-PT) and English (en).

## MVP Scope

### Included Features
- User authentication and registration (email/password + Google/Apple OAuth)
- Interactive map with nearby events
- TCG event search and creation
- Event RSVP system
- Player group management
- Venue search and creation
- Calendar integration (Google Calendar + ICS)
- User profile and settings
- Multi-language support (pt-PT and en)
- Dark mode (Dark Neon theme)

### Excluded Features (Out of Scope)
- Integrated payment system
- Real-time chat
- Game streaming
- Ranking/rating system
- Push notifications (placeholder only)
- Light mode (future)
- Additional languages beyond pt-PT and en
- Advanced moderation features

## Personas and User Stories

### Persona 1: Casual Player (João)
**Profile:** Weekend MTG player, looking for local events
**Goals:** Find nearby events, meet other players

### Persona 2: Event Organizer (Maria)
**Profile:** Game store owner, organizes regular tournaments
**Goals:** Promote events, manage participants, increase visibility

### Persona 3: Group Leader (Pedro)
**Profile:** Experienced player who coordinates local Lorcana group
**Goals:** Organize group, coordinate private events, manage members

## Functional Requirements

### Requirement 1: User Authentication

**User Story:** As a user, I want to register and log into the application, so that I can access personalized features.

#### Acceptance Criteria
1. WHEN the user accesses the application for the first time THEN the system SHALL present registration and login options
2. WHEN the user registers with email and password THEN the system SHALL validate email format and password strength (minimum 8 characters)
3. WHEN the user chooses OAuth (Google/Apple) THEN the system SHALL redirect to OAuth provider and process callback
4. WHEN login is successful THEN the system SHALL store tokens securely and redirect to main screen
5. WHEN token expires THEN the system SHALL automatically refresh using refresh token

### Requirement 2: Event Discovery on Map

**User Story:** As a player, I want to see nearby TCG events on a map, so that I can easily discover activities in my area.

#### Acceptance Criteria
1. WHEN the user accesses the home screen THEN the system SHALL display a map with current location
2. WHEN there are events within 25km radius THEN the system SHALL show pins on the map for each event
3. WHEN the user taps on a pin THEN the system SHALL show a bottom sheet with event summary
4. WHEN the user adjusts search radius THEN the system SHALL update pins on the map
5. IF there are no nearby events THEN the system SHALL display informative message
### Requirement 3: Event Management

**User Story:** As an event organizer, I want to create and manage TCG events, so that I can attract participants and organize successful tournaments.

#### Acceptance Criteria
1. WHEN the user taps the create event FAB THEN the system SHALL display event creation form
2. WHEN creating an event THEN the system SHALL require title, game, visibility, start/end times, and timezone
3. WHEN the user selects a venue THEN the system SHALL allow searching existing venues or creating new ones
4. WHEN the event is created THEN the system SHALL display it in the events list and map
5. WHEN the user is the event host THEN the system SHALL allow editing and deleting the event
6. WHEN the event has capacity limit THEN the system SHALL enforce waitlist when capacity is reached

### Requirement 4: RSVP System

**User Story:** As a player, I want to RSVP to events with different statuses, so that organizers know my attendance intention.

#### Acceptance Criteria
1. WHEN viewing an event THEN the system SHALL display RSVP options (going, interested, declined)
2. WHEN the user changes RSVP status THEN the system SHALL update attendee count immediately
3. WHEN the event has capacity AND user RSVPs "going" THEN the system SHALL add to waitlist if full
4. WHEN the user is waitlisted THEN the system SHALL display waitlist status clearly
5. WHEN viewing attendees THEN the system SHALL show list with RSVP statuses and timestamps

### Requirement 5: Group Management

**User Story:** As a group leader, I want to create and manage player groups, so that I can organize private events and build community.

#### Acceptance Criteria
1. WHEN creating a group THEN the system SHALL require name and allow optional description
2. WHEN the user creates a group THEN the system SHALL assign them as owner with full permissions
3. WHEN the owner adds members THEN the system SHALL allow assigning member or admin roles
4. WHEN viewing group details THEN the system SHALL show member list with roles and join dates
5. WHEN the user has admin+ permissions THEN the system SHALL allow adding/removing members and updating roles
6. WHEN creating group events THEN the system SHALL restrict visibility to group members only

### Requirement 6: Venue Management

**User Story:** As a user, I want to search for and create venues, so that events can be associated with specific locations.

#### Acceptance Criteria
1. WHEN creating an event THEN the system SHALL allow searching venues by name or location
2. WHEN no suitable venue exists THEN the system SHALL allow creating a new venue
3. WHEN creating a venue THEN the system SHALL require name, type (store/home/other), address, city, country
4. WHEN venue address is provided THEN the system SHALL attempt geocoding for map coordinates
5. WHEN viewing venue details THEN the system SHALL show location on map and associated events

### Requirement 7: Calendar Integration

**User Story:** As a user, I want to add events to my calendar, so that I don't forget about upcoming TCG events.

#### Acceptance Criteria
1. WHEN viewing event details THEN the system SHALL provide "Add to Google Calendar" and "Download ICS" options
2. WHEN user taps "Add to Google Calendar" THEN the system SHALL open Google Calendar with pre-filled event data
3. WHEN user downloads ICS THEN the system SHALL generate valid calendar file with event information
4. WHEN the user creates calendar token THEN the system SHALL generate personal feed URL (future feature)
5. WHEN accessing calendar feed THEN the system SHALL return ICS format with user's events

### Requirement 8: User Profile Management

**User Story:** As a user, I want to manage my profile and preferences, so that the app experience is personalized to my needs.

#### Acceptance Criteria
1. WHEN viewing profile THEN the system SHALL display user information and preferences
2. WHEN updating profile THEN the system SHALL allow changing display name, locale, timezone, city, country
3. WHEN changing language THEN the system SHALL update UI immediately without restart
4. WHEN updating timezone THEN the system SHALL display all times in new timezone
5. WHEN user requests data export THEN the system SHALL provide complete data in machine-readable format
6. WHEN user deletes account THEN the system SHALL permanently remove all user data (GDPR compliance)

## Non-Functional Requirements

### Performance Requirements
- App startup time: < 3 seconds on mid-range devices
- Map rendering: < 2 seconds for 50 event pins
- API response time: < 1 second for search operations
- Offline capability: Cache last search results for 24 hours
- Memory usage: < 150MB on mobile devices

### Security Requirements
- JWT tokens stored in secure storage (flutter_secure_storage)
- Automatic token refresh on expiration
- Rate limiting: Respect API limits with exponential backoff
- Input validation: All user inputs sanitized and validated
- HTTPS only: All API communications encrypted

### Accessibility Requirements (WCAG AA)
- Minimum contrast ratio: 4.5:1 for normal text, 3:1 for large text
- Touch targets: Minimum 44dp for interactive elements
- Screen reader support: All UI elements properly labeled
- Keyboard navigation: Full app functionality accessible via keyboard
- Text scaling: Support up to 200% text size increase

### Internationalization Requirements
- Support for pt-PT and en locales from day one
- ICU MessageFormat for plurals and variable substitution
- Date/time formatting per locale using intl package
- Number and currency formatting per locale
- RTL readiness: Avoid hardcoded LTR assumptions
- Fallback to English when translation missing

### GDPR Compliance
- Data export functionality via /me/export endpoint
- Account deletion with complete data removal
- Privacy settings for profile visibility
- Clear consent for data processing
- Data retention policies documented

## Data Models

### Core Entities (Mirroring OpenAPI Schemas)

| Entity | Key Fields | Nullable Fields | Enums |
|--------|------------|-----------------|-------|
| AuthUserInfo | id, email, locale | display_name | locale: [en, pt] |
| EventResponse | id, title, game, visibility, start_at, end_at, timezone | description, venue, group, location, capacity, entry_fee | game: [mtg, lorcana, pokemon, other], visibility: [public, private, group] |
| GroupResponse | id, name, member_count, created_at | description, owner, members | user_role: [member, admin, owner] |
| VenueResponse | id, name, type, address, city, country | coordinates, metadata, created_by | type: [store, home, other] |
| RSVPStatus | - | - | [going, interested, declined, waitlisted] |

### Data Handling Rules
- All timestamps stored as UTC ISO8601, displayed in user timezone
- Nullable fields handled gracefully with default values or empty states
- Enum validation on client side before API calls
- Pagination using limit/offset pattern for all list endpoints

## API Integration

### Base Configuration
- Environment-driven base URLs (prod/staging/local)
- Custom header: X-Client: matchtcg-app
- Bearer token authentication for protected endpoints
- Automatic retry with exponential backoff for failed requests

### Key Endpoint Mappings

| Feature | Endpoints | Parameters |
|---------|-----------|------------|
| Authentication | POST /auth/register, /auth/login, /auth/refresh | email, password, timezone, locale |
| Events | GET /events, POST /events, GET /events/{id} | near, radius_km, game, visibility, limit, offset |
| RSVP | POST /events/{id}/rsvp, GET /events/{id}/attendees | status: [going, interested, declined] |
| Groups | GET /me/groups, POST /groups, GET /groups/{id} | include_members boolean |
| Venues | GET /venues, POST /venues | near, radius_km, query, type |
| Calendar | GET /events/{id}/calendar.ics, /events/{id}/google-calendar | - |

## Error Handling

### Standard Error Response Format
```json
{
  "error": "validation_error",
  "message": "Invalid input data"
}
```

### Client-Side Error Handling
- Network errors: Show retry option with offline indicator
- Validation errors: Display field-specific error messages
- Authentication errors: Redirect to login with clear message
- Rate limiting: Show "too many requests" with retry timer
- Server errors: Generic error message with support contact

## Feature Flags

| Flag | Description | Default | Future |
|------|-------------|---------|--------|
| light_mode | Enable light theme toggle | false | true |
| google_maps | Use Google Maps instead of MapLibre | false | configurable |
| additional_languages | Support for more locales | false | true |
| push_notifications | Firebase push notifications | false | true |
| calendar_feed | Personal calendar feed tokens | false | true |

## Testing Requirements

### Unit Tests
- All business logic and data models
- API service layer with mocked responses
- Utility functions and validators
- State management (Riverpod providers)

### Widget Tests
- All custom widgets and screens
- User interaction flows
- Form validation
- Navigation between screens

### Integration Tests
- Complete user journeys (register → login → create event → RSVP)
- API integration with test backend
- Offline functionality
- Multi-language switching

### Accessibility Tests
- Screen reader compatibility
- Keyboard navigation
- Color contrast validation
- Touch target size verification

## Appendix: OpenAPI 3.0.3 Specification

```yaml
openapi: 3.0.3
info:
  title: MatchTCG Backend API
  description: |
    MatchTCG is a backend API for Trading Card Game event management. It enables users to create, discover, and manage tournaments and casual matches with features like geospatial search, group management, calendar integration, and GDPR compliance.
    
    ## Authentication
    Most endpoints require authentication using Bearer tokens. Include the token in the Authorization header:
    ```
    Authorization: Bearer <your-access-token>
    ```
    
    ## Rate Limiting
    - Authenticated users: 1000 requests/hour
    - Anonymous users: 100 requests/hour
    - Geospatial search: 60 requests/hour
    
    ## Error Handling
    All errors follow a consistent format with HTTP status codes and structured error responses.
  version: 1.0.0
  contact:
    name: MatchTCG API Support
    url: https://matchtcg.com/support
  license:
    name: MIT
    url: https://opensource.org/licenses/MIT

servers:
  - url: https://api.matchtcg.com/api/v1
    description: Production server
  - url: https://staging-api.matchtcg.com/api/v1
    description: Staging server
  - url: http://localhost:8080/api/v1
    description: Local development server

security:
  - BearerAuth: []
  - {}

tags:
  - name: System
    description: System health and status endpoints
  - name: Authentication
    description: User authentication and authorization
  - name: User Management
    description: User profile and account management
  - name: Event Management
    description: Event creation, search, and RSVP management
  - name: Group Management
    description: Group creation and member management
  - name: Venue Management
    description: Venue creation and location management
  - name: Calendar Integration
    description: Calendar export and integration features 

paths:
  # Health Check
  /health:
    get:
      tags:
        - System
      summary: Health check endpoint
      description: Returns the health status of the API
      security: []
      responses:
        '200':
          description: Service is healthy
          content:
            application/json:
              schema:
                type: object
                properties:
                  status:
                    type: string
                    example: healthy
                  service:
                    type: string
                    example: matchtcg-backend

  # Authentication Endpoints
  /auth/register:
    post:
      tags:
        - Authentication
      summary: Register a new user
      description: Create a new user account with email and password
      security: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/RegisterRequest'
      responses:
        '201':
          description: User successfully registered
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/AuthResponse'
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '409':
          description: Email already exists
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /auth/login:
    post:
      tags:
        - Authentication
      summary: Login user
      description: Authenticate user with email and password
      security: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/LoginRequest'
      responses:
        '200':
          description: User successfully authenticated
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/AuthResponse'
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Invalid credentials
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /auth/refresh:
    post:
      tags:
        - Authentication
      summary: Refresh access token
      description: Get a new access token using a refresh token
      security: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/RefreshRequest'
      responses:
        '200':
          description: Token successfully refreshed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/AuthResponse'
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Invalid or expired refresh token
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /auth/logout:
    post:
      tags:
        - Authentication
      summary: Logout user
      description: Invalidate the current access token
      requestBody:
        required: false
      responses:
        '200':
          description: User successfully logged out
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: Successfully logged out
        '400':
          description: Invalid token format
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /auth/oauth/google:
    get:
      tags:
        - Authentication
      summary: Google OAuth authentication
      description: Initiate Google OAuth flow or handle callback
      security: []
      parameters:
        - name: code
          in: query
          description: OAuth authorization code (callback only)
          schema:
            type: string
        - name: state
          in: query
          description: OAuth state parameter (callback only)
          schema:
            type: string
      responses:
        '200':
          description: OAuth URL generated or callback processed
          content:
            application/json:
              schema:
                oneOf:
                  - type: object
                    properties:
                      auth_url:
                        type: string
                        format: uri
                      state:
                        type: string
                  - $ref: '#/components/schemas/AuthResponse'
        '400':
          description: Invalid OAuth parameters
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /auth/oauth/apple:
    get:
      tags:
        - Authentication
      summary: Apple OAuth authentication
      description: Initiate Apple OAuth flow or handle callback
      security: []
      parameters:
        - name: code
          in: query
          description: OAuth authorization code (callback only)
          schema:
            type: string
        - name: state
          in: query
          description: OAuth state parameter (callback only)
          schema:
            type: string
      responses:
        '200':
          description: OAuth URL generated or callback processed
          content:
            application/json:
              schema:
                oneOf:
                  - type: object
                    properties:
                      auth_url:
                        type: string
                        format: uri
                      state:
                        type: string
                  - $ref: '#/components/schemas/AuthResponse'
        '400':
          description: Invalid OAuth parameters
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  # User Management Endpoints
  /me:
    get:
      tags:
        - User Management
      summary: Get current user profile
      description: Retrieve the authenticated user's profile information
      responses:
        '200':
          description: User profile retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UserProfileResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: User or profile not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    put:
      tags:
        - User Management
      summary: Update current user profile
      description: Update the authenticated user's profile information
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UpdateProfileRequest'
      responses:
        '200':
          description: Profile updated successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UserProfileResponse'
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    delete:
      tags:
        - User Management
      summary: Delete user account
      description: Permanently delete the authenticated user's account (GDPR compliance)
      responses:
        '200':
          description: Account deleted successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: Account successfully deleted
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /me/export:
    get:
      tags:
        - User Management
      summary: Export user data
      description: Export all user data in machine-readable format (GDPR compliance)
      responses:
        '200':
          description: User data exported successfully
          content:
            application/json:
              schema:
                type: object
                description: Complete user data export
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /users/{id}:
    get:
      tags:
        - User Management
      summary: Get public user profile
      description: Retrieve a user's public profile information
      security:
        - BearerAuth: []
        - {}
      parameters:
        - name: id
          in: path
          required: true
          description: User ID
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Public user profile retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PublicUserProfileResponse'
        '404':
          description: User not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  # Event Management Endpoints
  /events:
    get:
      tags:
        - Event Management
      summary: Search events
      description: Search for events with various filters including geospatial search
      security:
        - BearerAuth: []
        - {}
      parameters:
        - name: near
          in: query
          description: Search near coordinates lat,lon)
          schema:
            type: string
            example: "38.7223,-9.1393"
        - name: radius_km
          in: query
          description: Search radius in kilometers (5-100)
          schema:
            type: integer
            minimum: 5
            maximum: 100
            example: 25
        - name: start_from
          in: query
          description: Events starting from this date
          schema:
            type: string
            format: date
            example: "2024-01-01"
        - name: days
          in: query
          description: Number of days to search ahead
          schema:
            type: integer
            minimum: 1
            maximum: 365
            example: 30
        - name: game
          in: query
          description: Filter by game type
          schema:
            type: string
            enum: [mtg, lorcana, pokemon, other]
        - name: format
          in: query
          description: Filter by game format
          schema:
            type: string
            example: "standard"
        - name: visibility
          in: query
          description: Filter by event visibility
          schema:
            type: string
            enum: [public, private, group]
        - name: group_id
          in: query
          description: Filter by group ID
          schema:
            type: string
            format: uuid
        - name: limit
          in: query
          description: Number of results per page
          schema:
            type: integer
            minimum: 1
            maximum: 100
            default: 20
        - name: offset
          in: query
          description: Pagination offset
          schema:
            type: integer
            minimum: 0
            default: 0
      responses:
        '200':
          description: Events retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/EventListResponse'
        '400':
          description: Invalid search parameters
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    post:
      tags:
        - Event Management
      summary: Create event
      description: Create a new event
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateEventRequest'
      responses:
        '201':
          description: Event created successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/EventResponse'
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /events/{id}:
    get:
      tags:
        - Event Management
      summary: Get event details
      description: Retrieve detailed information about a specific event
      security:
        - BearerAuth: []
        - {}
      parameters:
        - name: id
          in: path
          required: true
          description: Event ID
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Event details retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/EventResponse'
        '404':
          description: Event not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Access denied to private event
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    put:
      tags:
        - Event Management
      summary: Update event
      description: Update an existing event (host only)
      parameters:
        - name: id
          in: path
          required: true
          description: Event ID
          schema:
            type: string
            format: uuid
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UpdateEventRequest'
      responses:
        '200':
          description: Event updated successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/EventResponse'
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Only event host can update
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Event not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    delete:
      tags:
        - Event Management
      summary: Delete event
      description: Delete an existing event (host only)
      parameters:
        - name: id
          in: path
          required: true
          description: Event ID
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Event deleted successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: Event successfully deleted
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Only event host can delete
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Event not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /events/{id}/rsvp:
    post:
      tags:
        - Event Management
      summary: RSVP to event
      description: RSVP to an event with status (going, interested, declined)
      parameters:
        - name: id
          in: path
          required: true
          description: Event ID
          schema:
            type: string
            format: uuid
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/RSVPRequest'
      responses:
        '200':
          description: RSVP successful
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: RSVP successful
                  status:
                    type: string
                    enum: [going, interested, declined, waitlisted]
                  waitlisted:
                    type: boolean
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Access denied to private event
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Event not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /events/{id}/attendees:
    get:
      tags:
        - Event Management
      summary: Get event attendees
      description: Retrieve list of event attendees
      security:
        - BearerAuth: []
        - {}
      parameters:
        - name: id
          in: path
          required: true
          description: Event ID
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Attendees retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/AttendeesResponse'
        '403':
          description: Access denied to attendee list
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Event not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
   
  /groups:
    post:
      tags:
        - Group Management
      summary: Create group
      description: Create a new group
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateGroupRequest'
      responses:
        '201':
          description: Group created successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/GroupResponse'
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /groups/{id}:
    get:
      tags:
        - Group Management
      summary: Get group details
      description: Retrieve detailed information about a specific group
      parameters:
        - name: id
          in: path
          required: true
          description: Group ID
          schema:
            type: string
            format: uuid
        - name: include_members
          in: query
          description: Include member list in response
          schema:
            type: boolean
            default: false
      responses:
        '200':
          description: Group details retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/GroupResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Access denied to private group
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Group not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    put:
      tags:
        - Group Management
      summary: Update group
      description: Update an existing group (owner/admin only)
      parameters:
        - name: id
          in: path
          required: true
          description: Group ID
          schema:
            type: string
            format: uuid
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UpdateGroupRequest'
      responses:
        '200':
          description: Group updated successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/GroupResponse'
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Only group owner or admin can update
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Group not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    delete:
      tags:
        - Group Management
      summary: Delete group
      description: Delete an existing group (owner only)
      parameters:
        - name: id
          in: path
          required: true
          description: Group ID
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Group deleted successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: Group successfully deleted
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Only group owner can delete
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Group not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /groups/{id}/members:
    post:
      tags:
        - Group Management
      summary: Add group member
      description: Add a new member to the group (owner/admin only)
      parameters:
        - name: id
          in: path
          required: true
          description: Group ID
          schema:
            type: string
            format: uuid
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/AddMemberRequest'
      responses:
        '201':
          description: Member added successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: Member successfully added to group
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Only group owner or admin can add members
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Group or user not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /groups/{id}/members/{userId}:
    delete:
      tags:
        - Group Management
      summary: Remove group member
      description: Remove a member from the group
      parameters:
        - name: id
          in: path
          required: true
          description: Group ID
          schema:
            type: string
            format: uuid
        - name: userId
          in: path
          required: true
          description: User ID to remove
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Member removed successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: Member successfully removed from group
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Insufficient permissions to remove member
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Group or user not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    put:
      tags:
        - Group Management
      summary: Update member role
      description: Update a member's role in the group
      parameters:
        - name: id
          in: path
          required: true
          description: Group ID
          schema:
            type: string
            format: uuid
        - name: userId
          in: path
          required: true
          description: User ID to update
          schema:
            type: string
            format: uuid
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UpdateMemberRoleRequest'
      responses:
        '200':
          description: Member role updated successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: Member role successfully updated
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Insufficient permissions to update member role
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Group or user not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /me/groups:
    get:
      tags:
        - Group Management
      summary: Get user's groups
      description: Retrieve all groups the authenticated user belongs to
      responses:
        '200':
          description: User's groups retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/GroupListResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  # Venue Management Endpoints
  /venues:
    get:
      tags:
        - Venue Management
      summary: Search venues
      description: Search for venues with various filters including geospatial search
      security:
        - BearerAuth: []
        - {}
      parameters:
        - name: near
          in: query
          description: Search near coordinates ("lat,lon")
          schema:
            type: string
            example: "38.7223,-9.1393"
        - name: radius_km
          in: query
          description: Search radius in kilometers
          schema:
            type: integer
            minimum: 1
            maximum: 100
            example: 25
        - name: query
          in: query
          description: Text search in venue name
          schema:
            type: string
            example: "game store"
        - name: type
          in: query
          description: Filter by venue type
          schema:
            type: string
            enum: [store, home, other]
        - name: city
          in: query
          description: Filter by city
          schema:
            type: string
            example: "Lisbon"
        - name: country
          in: query
          description: Filter by country
          schema:
            type: string
            example: "Portugal"
        - name: limit
          in: query
          description: Number of results per page
          schema:
            type: integer
            minimum: 1
            maximum: 100
            default: 20
        - name: offset
          in: query
          description: Pagination offset
          schema:
            type: integer
            minimum: 0
            default: 0
      responses:
        '200':
          description: Venues retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/VenueListResponse'
        '400':
          description: Invalid search parameters
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    post:
      tags:
        - Venue Management
      summary: Create venue
      description: Create a new venue
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateVenueRequest'
      responses:
        '201':
          description: Venue created successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/VenueResponse'
        '400':
          description: Invalid request data or geocoding failed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /venues/{id}:
    get:
      tags:
        - Venue Management
      summary: Get venue details
      description: Retrieve detailed information about a specific venue
      security:
        - BearerAuth: []
        - {}
      parameters:
        - name: id
          in: path
          required: true
          description: Venue ID
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Venue details retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/VenueResponse'
        '404':
          description: Venue not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    put:
      tags:
        - Venue Management
      summary: Update venue
      description: Update an existing venue (creator only)
      parameters:
        - name: id
          in: path
          required: true
          description: Venue ID
          schema:
            type: string
            format: uuid
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UpdateVenueRequest'
      responses:
        '200':
          description: Venue updated successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/VenueResponse'
        '400':
          description: Invalid request data or geocoding failed
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Only venue creator can update
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Venue not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

    delete:
      tags:
        - Venue Management
      summary: Delete venue
      description: Delete an existing venue (creator only)
      parameters:
        - name: id
          in: path
          required: true
          description: Venue ID
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Venue deleted successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
                    example: Venue successfully deleted
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '403':
          description: Only venue creator can delete
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '404':
          description: Venue not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  # Calendar Integration Endpoints
  /events/{id}/calendar.ics:
    get:
      tags:
        - Calendar Integration
      summary: Download event ICS file
      description: Download an ICS calendar file for a specific event
      security:
        - BearerAuth: []
        - {}
      parameters:
        - name: id
          in: path
          required: true
          description: Event ID
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: ICS file generated successfully
          content:
            text/calendar:
              schema:
                type: string
                format: binary
          headers:
            Content-Disposition:
              description: Attachment filename
              schema:
                type: string
                example: 'attachment; filename="event.ics"'
        '404':
          description: Event not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /events/{id}/google-calendar:
    get:
      tags:
        - Calendar Integration
      summary: Get Google Calendar link
      description: Get a deep link to add event to Google Calendar
      security:
        - BearerAuth: []
        - {}
      parameters:
        - name: id
          in: path
          required: true
          description: Event ID
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Google Calendar link generated successfully
          content:
            application/json:
              schema:
                type: object
                properties:
                  google_calendar_url:
                    type: string
                    format: uri
                    example: "https://calendar.google.com/calendar/render?action=TEMPLATE&text=..."
        '404':
          description: Event not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /calendar/tokens:
    post:
      tags:
        - Calendar Integration
      summary: Create calendar token
      description: Create a new token for personal calendar feed access
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CalendarTokenRequest'
      responses:
        '201':
          description: Calendar token created successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/CalendarTokenResponse'
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '401':
          description: Authentication required
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'

  /calendar/feed/{token}:
    get:
      tags:
        - Calendar Integration
      summary: Personal calendar feed
      description: Get personal calendar feed with user's events
      security: []
      parameters:
        - name: token
          in: path
          required: true
          description: Calendar access token
          schema:
            type: string
        - name: limit
          in: query
          description: Number of events to include
          schema:
            type: integer
            minimum: 1
            maximum: 100
            default: 50
        - name: offset
          in: query
          description: Pagination offset
          schema:
            type: integer
            minimum: 0
            default: 0
      responses:
        '200':
          description: Personal calendar feed generated successfully
          content:
            text/calendar:
              schema:
                type: string
                format: binary
          headers:
            Content-Disposition:
              description: Inline filename
              schema:
                type: string
                example: 'inline; filename="matchtcg-events.ics"'
            Cache-Control:
              description: Cache control header
              schema:
                type: string
                example: 'public, max-age=3600'
        '401':
          description: Invalid or expired calendar token
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
        '501':
          description: Feature not yet implemented
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'  

components:
  securitySchemes:
    BearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
      description: JWT access token obtained from authentication endpoints

  schemas:
    # Common Types
    ErrorResponse:
      type: object
      required:
        - error
        - message
      properties:
        error:
          type: string
          description: Error code
          example: validation_error
        message:
          type: string
          description: Human-readable error message
          example: Invalid input data

    Coordinates:
      type: object
      required:
        - latitude
        - longitude
      properties:
        latitude:
          type: number
          format: double
          minimum: -90
          maximum: 90
          example: 38.7223
        longitude:
          type: number
          format: double
          minimum: -180
          maximum: 180
          example: -9.1393

    UserInfo:
      type: object
      required:
        - id
      properties:
        id:
          type: string
          format: uuid
        display_name:
          type: string
          nullable: true
          example: "John Doe"

    AuthUserInfo:
      type: object
      required:
        - id
        - email
        - locale
      properties:
        id:
          type: string
          format: uuid
        email:
          type: string
          format: email
        display_name:
          type: string
          nullable: true
          example: "John Doe"
        locale:
          type: string
          enum: [en, pt]
          example: pt

    GroupInfo:
      type: object
      required:
        - id
        - name
      properties:
        id:
          type: string
          format: uuid
        name:
          type: string
          example: "Lisbon MTG Players"

    # Authentication Schemas
    RegisterRequest:
      type: object
      required:
        - email
        - password
        - timezone
      properties:
        email:
          type: string
          format: email
          example: "user@example.com"
        password:
          type: string
          format: password
          minLength: 8
          example: "securepassword123"
        display_name:
          type: string
          maxLength: 100
          example: "John Doe"
        locale:
          type: string
          enum: [en, pt]
          example: pt
        timezone:
          type: string
          example: "Europe/Lisbon"
        country:
          type: string
          example: "Portugal"
        city:
          type: string
          example: "Lisbon"

    LoginRequest:
      type: object
      required:
        - email
        - password
      properties:
        email:
          type: string
          format: email
          example: "user@example.com"
        password:
          type: string
          format: password
          example: "securepassword123"

    RefreshRequest:
      type: object
      required:
        - refresh_token
      properties:
        refresh_token:
          type: string
          example: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9..."

    AuthResponse:
      type: object
      required:
        - access_token
        - refresh_token
        - expires_at
        - user
      properties:
        access_token:
          type: string
          example: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9..."
        refresh_token:
          type: string
          example: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9..."
        expires_at:
          type: string
          format: date-time
          example: "2024-01-01T15:30:00Z"
        user:
          $ref: '#/components/schemas/AuthUserInfo'

    # User Management Schemas
    UpdateProfileRequest:
      type: object
      properties:
        display_name:
          type: string
          maxLength: 100
          nullable: true
          example: "John Doe"
        locale:
          type: string
          enum: [en, pt]
          nullable: true
          example: pt
        timezone:
          type: string
          nullable: true
          example: "Europe/Lisbon"
        country:
          type: string
          nullable: true
          example: "Portugal"
        city:
          type: string
          nullable: true
          example: "Lisbon"
        preferred_games:
          type: array
          items:
            type: string
          example: ["mtg", "lorcana"]
        communication_preferences:
          type: object
          additionalProperties: true
          example:
            email_notifications: true
            event_reminders: true
        visibility_settings:
          type: object
          additionalProperties: true
          example:
            show_real_name: true
            show_location: false

    UserProfileResponse:
      type: object
      required:
        - id
        - email
        - locale
        - timezone
        - created_at
        - updated_at
      properties:
        id:
          type: string
          format: uuid
        email:
          type: string
          format: email
        display_name:
          type: string
          nullable: true
        locale:
          type: string
          enum: [en, pt]
        timezone:
          type: string
        country:
          type: string
          nullable: true
        city:
          type: string
          nullable: true
        preferred_games:
          type: array
          items:
            type: string
        communication_preferences:
          type: object
          additionalProperties: true
        visibility_settings:
          type: object
          additionalProperties: true
        created_at:
          type: string
          format: date-time
        updated_at:
          type: string
          format: date-time

    PublicUserProfileResponse:
      type: object
      required:
        - id
      properties:
        id:
          type: string
          format: uuid
        display_name:
          type: string
          nullable: true
        country:
          type: string
          nullable: true
        city:
          type: string
          nullable: true
        preferred_games:
          type: array
          items:
            type: string

    # Event Management Schemas
    CreateEventRequest:
      type: object
      required:
        - title
        - game
        - visibility
        - start_at
        - end_at
        - timezone
      properties:
        title:
          type: string
          minLength: 1
          maxLength: 200
          example: "Friday Night Magic"
        description:
          type: string
          maxLength: 2000
          example: "Weekly Standard tournament"
        game:
          type: string
          enum: [mtg, lorcana, pokemon, other]
          example: mtg
        format:
          type: string
          maxLength: 100
          example: "standard"
        rules:
          type: string
          maxLength: 1000
          example: "Standard format, best of 3"
        visibility:
          type: string
          enum: [public, private, group]
          example: public
        capacity:
          type: integer
          minimum: 2
          maximum: 1000
          nullable: true
          example: 32
        start_at:
          type: string
          format: date-time
          example: "2024-01-05T19:00:00Z"
        end_at:
          type: string
          format: date-time
          example: "2024-01-05T23:00:00Z"
        timezone:
          type: string
          example: "Europe/Lisbon"
        tags:
          type: array
          items:
            type: string
          example: ["competitive", "standard"]
        entry_fee:
          type: number
          format: double
          minimum: 0
          nullable: true
          example: 5.00
        language:
          type: string
          enum: [en, pt]
          example: pt
        group_id:
          type: string
          format: uuid
          nullable: true
        venue_id:
          type: string
          format: uuid
          nullable: true
        address:
          type: string
          example: "123 Main St, Lisbon"

    UpdateEventRequest:
      type: object
      properties:
        title:
          type: string
          minLength: 1
          maxLength: 200
          nullable: true
        description:
          type: string
          maxLength: 2000
          nullable: true
        format:
          type: string
          maxLength: 100
          nullable: true
        rules:
          type: string
          maxLength: 1000
          nullable: true
        visibility:
          type: string
          enum: [public, private, group]
          nullable: true
        capacity:
          type: integer
          minimum: 2
          maximum: 1000
          nullable: true
        start_at:
          type: string
          format: date-time
          nullable: true
        end_at:
          type: string
          format: date-time
          nullable: true
        tags:
          type: array
          items:
            type: string
        entry_fee:
          type: number
          format: double
          minimum: 0
          nullable: true

    RSVPRequest:
      type: object
      required:
        - status
      properties:
        status:
          type: string
          enum: [going, interested, declined]
          example: going

    EventResponse:
      type: object
      required:
        - id
        - title
        - game
        - visibility
        - attendee_count
        - start_at
        - end_at
        - timezone
        - language
        - created_at
        - updated_at
      properties:
        id:
          type: string
          format: uuid
        title:
          type: string
        description:
          type: string
        game:
          type: string
          enum: [mtg, lorcana, pokemon, other]
        format:
          type: string
        rules:
          type: string
        visibility:
          type: string
          enum: [public, private, group]
        capacity:
          type: integer
          nullable: true
        attendee_count:
          type: integer
        start_at:
          type: string
          format: date-time
        end_at:
          type: string
          format: date-time
        timezone:
          type: string
        tags:
          type: array
          items:
            type: string
        entry_fee:
          type: number
          format: double
          nullable: true
        language:
          type: string
        host:
          $ref: '#/components/schemas/UserInfo'
        group:
          allOf:
            - $ref: '#/components/schemas/GroupInfo'
            - nullable: true
        venue:
          allOf:
            - $ref: '#/components/schemas/VenueInfo'
            - nullable: true
        location:
          allOf:
            - $ref: '#/components/schemas/LocationInfo'
            - nullable: true
        rsvp_status:
          type: string
          enum: [going, interested, declined, waitlisted]
          nullable: true
        created_at:
          type: string
          format: date-time
        updated_at:
          type: string
          format: date-time

    EventListResponse:
      type: object
      required:
        - events
        - total
        - limit
        - offset
      properties:
        events:
          type: array
          items:
            $ref: '#/components/schemas/EventResponse'
        total:
          type: integer
          example: 150
        limit:
          type: integer
          example: 20
        offset:
          type: integer
          example: 0

    AttendeeResponse:
      type: object
      required:
        - user
        - status
        - rsvp_at
      properties:
        user:
          $ref: '#/components/schemas/UserInfo'
        status:
          type: string
          enum: [going, interested, declined, waitlisted]
        rsvp_at:
          type: string
          format: date-time

    AttendeesResponse:
      type: object
      required:
        - attendees
        - total
      properties:
        attendees:
          type: array
          items:
            $ref: '#/components/schemas/AttendeeResponse'
        total:
          type: integer

    VenueInfo:
      type: object
      required:
        - id
        - name
        - type
        - address
        - city
        - country
      properties:
        id:
          type: string
          format: uuid
        name:
          type: string
        type:
          type: string
          enum: [store, home, other]
        address:
          type: string
        city:
          type: string
        country:
          type: string
        coordinates:
          allOf:
            - $ref: '#/components/schemas/Coordinates'
            - nullable: true

    LocationInfo:
      type: object
      required:
        - address
      properties:
        address:
          type: string
        coordinates:
          allOf:
            - $ref: '#/components/schemas/Coordinates'
            - nullable: true

    CreateGroupRequest:
      type: object
      required:
        - name
      properties:
        name:
          type: string
          minLength: 1
          maxLength: 100
          example: "Lisbon MTG Players"
        description:
          type: string
          maxLength: 1000
          example: "A group for Magic: The Gathering players in Lisbon"

    UpdateGroupRequest:
      type: object
      properties:
        name:
          type: string
          minLength: 1
          maxLength: 100
          nullable: true
          example: "Lisbon MTG Players"
        description:
          type: string
          maxLength: 1000
          nullable: true
          example: "A group for Magic: The Gathering players in Lisbon"

    AddMemberRequest:
      type: object
      required:
        - user_id
        - role
      properties:
        user_id:
          type: string
          format: uuid
        role:
          type: string
          enum: [member, admin]
          example: member

    UpdateMemberRoleRequest:
      type: object
      required:
        - role
      properties:
        role:
          type: string
          enum: [member, admin, owner]
          example: admin

    GroupMemberResponse:
      type: object
      required:
        - user
        - role
        - joined_at
      properties:
        user:
          $ref: '#/components/schemas/UserInfo'
        role:
          type: string
          enum: [member, admin, owner]
        joined_at:
          type: string
          format: date-time

    GroupResponse:
      type: object
      required:
        - id
        - name
        - description
        - member_count
        - created_at
        - updated_at
      properties:
        id:
          type: string
          format: uuid
        name:
          type: string
        description:
          type: string
        owner:
          allOf:
            - $ref: '#/components/schemas/UserInfo'
            - nullable: true
        member_count:
          type: integer
        user_role:
          type: string
          enum: [member, admin, owner]
          nullable: true
        members:
          type: array
          items:
            $ref: '#/components/schemas/GroupMemberResponse'
          nullable: true
        created_at:
          type: string
          format: date-time
        updated_at:
          type: string
          format: date-time

    GroupListResponse:
      type: object
      required:
        - groups
        - total
      properties:
        groups:
          type: array
          items:
            $ref: '#/components/schemas/GroupResponse'
        total:
          type: integer

    # Venue Management Schemas
    CreateVenueRequest:
      type: object
      required:
        - name
        - type
        - address
        - city
        - country
      properties:
        name:
          type: string
          minLength: 1
          maxLength: 200
          example: "Local Game Store"
        type:
          type: string
          enum: [store, home, other]
          example: store
        address:
          type: string
          minLength: 1
          maxLength: 500
          example: "123 Main St"
        city:
          type: string
          minLength: 1
          maxLength: 100
          example: "Lisbon"
        country:
          type: string
          minLength: 1
          maxLength: 100
          example: "Portugal"
        metadata:
          type: object
          additionalProperties: true
          example:
            phone: "+351 123 456 789"
            website: "https://example.com"

    UpdateVenueRequest:
      type: object
      properties:
        name:
          type: string
          minLength: 1
          maxLength: 200
          nullable: true
        type:
          type: string
          enum: [store, home, other]
          nullable: true
        address:
          type: string
          minLength: 1
          maxLength: 500
          nullable: true
        city:
          type: string
          minLength: 1
          maxLength: 100
          nullable: true
        country:
          type: string
          minLength: 1
          maxLength: 100
          nullable: true
        metadata:
          type: object
          additionalProperties: true

    VenueResponse:
      type: object
      required:
        - id
        - name
        - type
        - address
        - city
        - country
        - created_at
      properties:
        id:
          type: string
          format: uuid
        name:
          type: string
        type:
          type: string
          enum: [store, home, other]
        address:
          type: string
        city:
          type: string
        country:
          type: string
        coordinates:
          allOf:
            - $ref: '#/components/schemas/Coordinates'
            - nullable: true
        metadata:
          type: object
          additionalProperties: true
        created_by:
          allOf:
            - $ref: '#/components/schemas/UserInfo'
            - nullable: true
        created_at:
          type: string
          format: date-time

    VenueListResponse:
      type: object
      required:
        - venues
        - total
        - limit
        - offset
      properties:
        venues:
          type: array
          items:
            $ref: '#/components/schemas/VenueResponse'
        total:
          type: integer
        limit:
          type: integer
        offset:
          type: integer

    # Calendar Integration Schemas
    CalendarTokenRequest:
      type: object
      required:
        - name
      properties:
        name:
          type: string
          minLength: 1
          maxLength: 100
          example: "My Calendar Feed"

    CalendarTokenResponse:
      type: object
      required:
        - token
        - name
      properties:
        token:
          type: string
          example: "cal_1234567890abcdef"
        name:
          type: string
          example: "My Calendar Feed"