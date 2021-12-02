# UnitTesting

Проект является демонстрацией подходов, представленных на [презентации](https://docs.google.com/presentation/d/19fvCvELWZeT8qewwn01ypVILcW6r5qqNhZZ9fbjn6l0/edit?usp=sharing).

## Структура проекта
### Папка Schedulers
Содержит реализации scheduler'ов - Immediate и Test

### Папка SimpleModule
Содержит реализацию презентера и интерактора, для которых написаны демонстрационные тесты

### Папка UnitTestingTests/Helpers
Содержит хелперы для асинхронных тестов.

`BackgroundTestable.swift` - реализация подхода с блокировкой текущего потока

`XCTestCase+.swift` - обёртка над expectation

### Папка UnitTestingTests/SimpleModuleTests
Демонстрационные тесты.

В `SimplePresenterTests.swift` лежат тесты с демонстрацией работы Immediate/Test schedulers

В `SimpleModuleInteractorTests.swift` лежат тесты с демонстрацией подходов с блокировкой текущего потока для синхронизации теста и демонстрцией обёртки для expectation
