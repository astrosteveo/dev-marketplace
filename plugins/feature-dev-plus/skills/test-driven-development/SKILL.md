---
name: Test-Driven Development
description: This skill should be used when Claude needs to determine what to test, design test structures, follow TDD practices, or decide when to skip tests. Trigger phrases include "write tests", "TDD approach", "test coverage", "what should I test", "testable vs non-testable".
version: 1.0.0
---

# Test-Driven Development Skill

Apply pragmatic TDD principles: test what matters, skip what doesn't, focus on logic over visuals.

## Core Philosophy

**Test business logic, not implementation details. Skip purely visual elements.**

Not all code needs tests. Testing has value when it:
- Catches regressions in logic
- Documents expected behavior
- Enables confident refactoring
- Verifies edge cases and error handling

Testing has low value when it:
- Tests framework behavior (React rendering, DOM updates)
- Tests visual appearance or subjective UX
- Tests third-party library internals
- Creates maintenance burden without catching bugs

## What to Test

### Always Test

**Business Logic**:
- Calculations and algorithms
- Data transformations
- Validation rules
- Business rule enforcement

**Example**:
```typescript
// TEST THIS
function calculateDiscount(price: number, couponCode: string): number {
  if (couponCode === 'SAVE20') return price * 0.8;
  if (couponCode === 'SAVE50') return price * 0.5;
  return price;
}
```

**Data Processing**:
- Parsing and serialization
- Format conversions
- Data normalization
- Filtering and sorting

**Example**:
```typescript
// TEST THIS
function parseCSV(csvString: string): Array<Record<string, string>> {
  const lines = csvString.split('\n');
  const headers = lines[0].split(',');
  return lines.slice(1).map(line => {
    const values = line.split(',');
    return headers.reduce((obj, header, i) => ({
      ...obj,
      [header]: values[i]
    }), {});
  });
}
```

**API Integration**:
- Request/response handling
- Error mapping
- Retry logic
- Data extraction from responses

**Example**:
```typescript
// TEST THIS
async function fetchUserProfile(userId: string): Promise<UserProfile> {
  const response = await api.get(`/users/${userId}`);
  if (!response.ok) {
    throw new APIError(response.status, response.message);
  }
  return mapResponseToProfile(response.data);
}
```

**State Management**:
- Reducers and state updates
- Store selectors
- State validation
- Transaction handling

**Example**:
```typescript
// TEST THIS
function cartReducer(state: Cart, action: CartAction): Cart {
  switch (action.type) {
    case 'ADD_ITEM':
      return {
        ...state,
        items: [...state.items, action.item],
        total: state.total + action.item.price
      };
    case 'REMOVE_ITEM':
      return {
        ...state,
        items: state.items.filter(item => item.id !== action.itemId),
        total: state.total - action.item.price
      };
    default:
      return state;
  }
}
```

**Authentication & Authorization**:
- Token validation
- Permission checks
- Session management
- Role verification

**Error Handling**:
- Error classification
- Error message generation
- Fallback behavior
- Retry strategies

**Edge Cases**:
- Empty inputs ([], "", null, undefined)
- Boundary values (0, -1, MAX_INT)
- Invalid inputs
- Concurrent operations

### Consider Testing (Case-by-Case)

**React Components** (only test logic, not rendering):
- Event handlers with logic
- Conditional rendering logic
- Data fetching on mount
- Form validation

**Skip testing**:
- JSX structure
- CSS classes applied
- Whether text appears
- Component composition

**Example**:
```typescript
// TEST the handler logic
function LoginForm() {
  const handleSubmit = (email, password) => {
    if (!validateEmail(email)) {
      return { error: 'Invalid email' };
    }
    if (password.length < 8) {
      return { error: 'Password too short' };
    }
    return login(email, password);
  };

  // DON'T TEST the JSX rendering
  return <form>...</form>;
}
```

**Database Operations** (with mocks/fixtures):
- Query logic
- Transaction handling
- Constraint validation
- Migration scripts

**Configuration**:
- Config parsing
- Environment variable handling
- Default value application

### Never Test

**Visual Elements**:
- Styling and CSS
- Layout and positioning
- Colors and typography
- Responsive breakpoints
- Animations and transitions

**Subjective UX**:
- "Looks good"
- "Feels smooth"
- "Intuitive to use"
- "Polished experience"

**Game Development**:
- Rendering graphics
- Visual effects
- Particle systems
- Character animations
- Scene composition

**Third-Party Libraries**:
- Library internals
- Framework behavior
- External API contracts (mock instead)

**Manual Workflows**:
- User clicks through wizard
- User explores UI
- Multi-step onboarding

## Test Structure

### Arrange-Act-Assert Pattern

**Arrange**: Set up test data and preconditions

**Act**: Execute the code under test

**Assert**: Verify expected outcomes

```typescript
describe('calculateDiscount', () => {
  it('should apply 20% discount for SAVE20 code', () => {
    // Arrange
    const price = 100;
    const coupon = 'SAVE20';

    // Act
    const result = calculateDiscount(price, coupon);

    // Assert
    expect(result).toBe(80);
  });
});
```

### Test Organization

**Group by component/module**:
```typescript
describe('UserService', () => {
  describe('createUser', () => {
    it('should create user with valid data', () => {});
    it('should reject invalid email', () => {});
    it('should hash password', () => {});
  });

  describe('getUserById', () => {
    it('should return user when exists', () => {});
    it('should return null when not found', () => {});
  });
});
```

### Naming Conventions

**Be descriptive**:
- ✅ `should return 401 when token is expired`
- ❌ `test authentication`

**State the expected behavior**:
- ✅ `should calculate total with tax included`
- ❌ `total works`

**Include the scenario**:
- ✅ `should retry 3 times when API returns 503`
- ❌ `retries`

## Test Cases to Cover

For each testable function:

1. **Happy Path**: Normal, expected usage
   ```typescript
   it('should calculate shipping for US address', () => {})
   ```

2. **Edge Cases**: Boundaries and special values
   ```typescript
   it('should handle empty cart', () => {})
   it('should handle cart with MAX_INT items', () => {})
   ```

3. **Error Cases**: Invalid inputs and failures
   ```typescript
   it('should throw error for negative price', () => {})
   it('should handle network timeout', () => {})
   ```

4. **Integration**: Component interactions
   ```typescript
   it('should update UI when cart state changes', () => {})
   ```

## Mocking Strategy

### When to Mock

**External Dependencies**:
- HTTP API calls
- Database queries
- File system operations
- External services
- Time/date (Date.now())
- Random number generation

**Example**:
```typescript
// Mock external API
jest.mock('./api', () => ({
  fetchUser: jest.fn()
}));

it('should handle API failure', async () => {
  api.fetchUser.mockRejectedValue(new Error('Network error'));
  await expect(getUserData('123')).rejects.toThrow('Network error');
});
```

### When NOT to Mock

**Internal logic**: Test real code paths

**Simple dependencies**: If it's easier to use real than mock

**Data structures**: Use real objects, not mocks

## Test File Organization

### Location Conventions

**Next to source** (common in frontend):
```
src/
  components/
    UserProfile.tsx
    UserProfile.test.tsx
```

**Separate test directory** (common in backend):
```
src/
  services/
    user-service.ts
tests/
  unit/
    services/
      user-service.test.ts
  integration/
    api/
      users.test.ts
```

### File Naming

- `*.test.ts` or `*.spec.ts` for unit tests
- `*.integration.test.ts` for integration tests
- `*.e2e.test.ts` for end-to-end tests

## Testing Anti-Patterns

### ❌ Testing Implementation Details

**Bad**: Test that component calls `setState`
```typescript
// DON'T DO THIS
it('should call setState when button clicked', () => {
  const spy = jest.spyOn(component, 'setState');
  component.find('button').click();
  expect(spy).toHaveBeenCalled();
});
```

**Good**: Test the outcome
```typescript
// DO THIS
it('should update count when button clicked', () => {
  render(<Counter />);
  fireEvent.click(screen.getByText('Increment'));
  expect(screen.getByText('Count: 1')).toBeInTheDocument();
});
```

### ❌ Over-Mocking

**Bad**: Mock everything
```typescript
// TOO MANY MOCKS
jest.mock('./calculator');
jest.mock('./formatter');
jest.mock('./validator');
// ... you're testing mocks, not real code
```

**Good**: Mock only external dependencies
```typescript
// JUST RIGHT
jest.mock('./api'); // External HTTP calls
// Test real calculator, formatter, validator
```

### ❌ Brittle Tests

**Bad**: Test exact DOM structure
```typescript
// BREAKS ON ANY HTML CHANGE
expect(container.querySelector('div > span.user-name')).toBe('John');
```

**Good**: Test behavior
```typescript
// RESILIENT TO REFACTORING
expect(screen.getByRole('heading')).toHaveTextContent('John');
```

### ❌ Testing Framework Behavior

**Bad**:
```typescript
// Testing React's rendering
it('should render component', () => {
  const wrapper = mount(<MyComponent />);
  expect(wrapper).toExist();
});
```

**Good**:
```typescript
// Testing YOUR logic
it('should show error when validation fails', () => {
  render(<MyComponent />);
  fireEvent.submit(screen.getByRole('form'));
  expect(screen.getByText('Invalid input')).toBeInTheDocument();
});
```

## TDD Workflow (When Applicable)

For new features with clear requirements:

1. **Write failing test** for one behavior
2. **Implement minimal code** to pass test
3. **Refactor** if needed
4. **Repeat** for next behavior

**Example**:
```typescript
// 1. Write failing test
it('should calculate tax for US orders', () => {
  expect(calculateTax(100, 'US')).toBe(108); // Fails: function doesn't exist
});

// 2. Implement minimal code
function calculateTax(amount, country) {
  if (country === 'US') return amount * 1.08;
  return amount;
}

// 3. Test passes, refactor if needed
// 4. Next test: EU tax rate
```

## Quick Decision Guide

**"Should I test this?"**

Ask yourself:
1. Is it logic or visual? → Logic = test, visual = skip
2. Would a bug here matter? → Yes = test, no = skip
3. Will this catch real bugs? → Yes = test, no = skip
4. Is it my code or a library? → My code = test, library = trust

**Examples**:

- `calculateShipping(weight, destination)` → **TEST** (logic, bugs matter)
- `<Button color="blue">Submit</Button>` → **SKIP** (visual, framework)
- `validateEmail(email)` → **TEST** (bugs matter, catches regressions)
- `<div className="flex items-center">` → **SKIP** (visual, CSS)
- `async retryWithBackoff(fn, maxAttempts)` → **TEST** (complex logic)

## For More Details

See reference files:
- `references/testing-strategies.md` - Comprehensive testing approaches
- `references/mocking-patterns.md` - When and how to mock

See scripts:
- `scripts/detect-test-framework.sh` - Detect Jest/Mocha/pytest in project
