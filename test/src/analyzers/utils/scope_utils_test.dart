import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/metrics/scope_utils.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/class_type.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/function_type.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/scoped_class_declaration.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/scoped_function_declaration.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class CompilationUnitMemberMock extends Mock {}

class DeclarationMock extends Mock {}

void main() {
  test('classFunctions returns functions only enclosed by passed class', () {
    final firstClass =
        ScopedClassDeclaration(ClassType.generic, CompilationUnitMemberMock() as CompilationUnitMember);
    final secondClass =
        ScopedClassDeclaration(ClassType.mixin, CompilationUnitMemberMock() as CompilationUnitMember);
    final thirdClass = ScopedClassDeclaration(
      ClassType.extension,
      CompilationUnitMemberMock() as CompilationUnitMember,
    );

    final functions = [
      ScopedFunctionDeclaration(
        FunctionType.function,
        DeclarationMock() as Declaration,
        null,
      ),
      ScopedFunctionDeclaration(
        FunctionType.constructor,
        DeclarationMock() as Declaration,
        firstClass,
      ),
      ScopedFunctionDeclaration(
        FunctionType.method,
        DeclarationMock() as Declaration,
        firstClass,
      ),
      ScopedFunctionDeclaration(
        FunctionType.constructor,
        DeclarationMock() as Declaration,
        secondClass,
      ),
      ScopedFunctionDeclaration(
        FunctionType.method,
        DeclarationMock() as Declaration,
        secondClass,
      ),
    ];

    expect(classMethods(firstClass.declaration, functions), hasLength(2));
    expect(classMethods(secondClass.declaration, functions), hasLength(2));
    expect(classMethods(thirdClass.declaration, functions), isEmpty);
  });
}
