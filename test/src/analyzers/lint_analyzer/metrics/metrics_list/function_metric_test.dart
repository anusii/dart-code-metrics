import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/metrics/models/function_metric.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/metrics/models/metric_documentation.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/metrics/models/metric_value_level.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/function_type.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/scoped_function_declaration.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class CompilationUnitMemberMock extends Mock {}

class DocumentationMock extends Mock implements MetricDocumentation {}

class FunctionMetricTest extends FunctionMetric<int> {
  FunctionMetricTest()
      : super(
          id: '0',
          documentation: DocumentationMock(),
          threshold: 0,
          levelComputer: (_, __) => MetricValueLevel.none,
        );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('FunctionMetric nodeType returns type of passed node', () {
    final firstNode = CompilationUnitMemberMock();
    final secondNode = CompilationUnitMemberMock();
    final thirdNode = CompilationUnitMemberMock();
    final fourthNode = CompilationUnitMemberMock();
    final fifthNode = CompilationUnitMemberMock();
    final sixthNode = CompilationUnitMemberMock();

    final functions = [
      ScopedFunctionDeclaration(FunctionType.constructor, firstNode as Declaration, null),
      ScopedFunctionDeclaration(FunctionType.method, secondNode as Declaration, null),
      ScopedFunctionDeclaration(FunctionType.function, thirdNode as Declaration, null),
      ScopedFunctionDeclaration(FunctionType.getter, fourthNode as Declaration, null),
      ScopedFunctionDeclaration(FunctionType.setter, fifthNode as Declaration, null),
    ];

    expect(
      FunctionMetricTest().nodeType(firstNode as AstNode, [], functions),
      equals('constructor'),
    );
    expect(
      FunctionMetricTest().nodeType(secondNode as AstNode, [], functions),
      equals('method'),
    );
    expect(
      FunctionMetricTest().nodeType(thirdNode as AstNode, [], functions),
      equals('function'),
    );
    expect(
      FunctionMetricTest().nodeType(fourthNode as AstNode, [], functions),
      equals('getter'),
    );
    expect(
      FunctionMetricTest().nodeType(fifthNode as AstNode, [], functions),
      equals('setter'),
    );
    expect(FunctionMetricTest().nodeType(sixthNode as AstNode, [], functions), isNull);
  });
}
