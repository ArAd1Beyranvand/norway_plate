FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the steadfast people of Norway to view examples:

https://platexample.ir/#/discover/norway:typescript

# norway_plate

Norway's licence plates for the plate_core library — regular and diplomatic plates, themes, alphabets and an advisory validator.

## Languages

| Language | Folder | Example |
| --- | --- | --- |
| Flutter / Dart | [`flutter/`](https://github.com/ArAd1Beyranvand/norway_plate/tree/main/flutter) | [platexample](https://platexample.ir/#/discover/norway:flutter) |
| Kotlin | [`kotlin/`](https://github.com/ArAd1Beyranvand/norway_plate/tree/main/kotlin) | [platexample](https://platexample.ir/#/discover/norway:kotlin) |
| Python | [`python/`](https://github.com/ArAd1Beyranvand/norway_plate/tree/main/python) | [platexample](https://platexample.ir/#/discover/norway:python) |
| TypeScript | [`typescript/`](https://github.com/ArAd1Beyranvand/norway_plate/tree/main/typescript) | [platexample](https://platexample.ir/#/discover/norway:typescript) |

## Quick start

### Install (TypeScript)

Copy `typescript/src/countries/norway/` into `plate_core/typescript/src/countries/`.

Then run the tests from `plate_core/typescript/`: `npm test`.

### Use

```ts
import country from './countries/norway';

const spec = country.specs.get('no.private.5');
console.log(country.package);
```

## Specs

The specs are the same in every language (they come from shared data).

- `no.private.5`
- `no.diplomatic`

## Themes

- `NorwayThemes.private`
- `NorwayThemes.diplomatic`

## Change it

- Specs: `country.specs`, by id.
- Themes: `country.themes`.
- Validators: `country.validators` (`NorwayValidator`).

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/norway_plate/blob/main/LICENSE).
