import 'package:analyzer/dart/ast/ast.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/metrics/models/class_metric.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/metrics/models/metric_documentation.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/metrics/models/metric_value_level.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/class_type.dart';
import 'package:dart_code_metrics/src/analyzers/lint_analyzer/models/scoped_class_declaration.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';


class CompilationUnitMemberMock extends Mock {}

class DocumentationMock extends Mock implements MetricDocumentation {}

class ClassMetricTest extends ClassMetric<int> {
  ClassMetricTest()
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
  test('ClassMetric nodeType returns type of passed node', () {
    final firstNode = CompilationUnitMemberMock();
    final secondNode = CompilationUnitMemberMock();
    final thirdNode = CompilationUnitMemberMock();
    final fourthNode = CompilationUnitMemberMock();

    final classes = [
      ScopedClassDeclaration(ClassType.generic, firstNode as CompilationUnitMember),
      ScopedClassDeclaration(ClassType.mixin, secondNode as CompilationUnitMember),
      ScopedClassDeclaration(ClassType.extension, thirdNode as CompilationUnitMember),
    ];

    expect(ClassMetricTest().nodeType(firstNode as AstNode, classes, []), equals('class'));
    expect(
      ClassMetricTest().nodeType(secondNode as AstNode, classes, []),
      equals('mixin'),
    );
    expect(
      ClassMetricTest().nodeType(thirdNode as AstNode, classes, []),
      equals('extension'),
    );
    expect(ClassMetricTest().nodeType(fourthNode as AstNode, classes, []), isNull);
  });
}
