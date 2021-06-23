import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moncli/src/models/node/i_bool_node.dart';
import 'package:moncli/src/models/node/i_double_node.dart';
import 'package:moncli/src/models/node/i_dynamic_node.dart';
import 'package:moncli/src/models/node/i_int_node.dart';
import 'package:moncli/src/models/node/i_iterable_node.dart';
import 'package:moncli/src/models/node/i_map_node.dart';
import 'package:moncli/src/models/node/i_node.dart';
import 'package:moncli/src/models/node/i_node_factory.dart';
import 'package:moncli/src/models/node/i_null_node.dart';
import 'package:moncli/src/models/node/i_string_node.dart';
import 'package:test/test.dart';

import 'i_node_test.mocks.dart';

class DummyClass {
  final String name;
  final String lastName;

  const DummyClass(this.name, this.lastName);
}

@GenerateMocks([
  INodeFactory,
  IMapNode,
  IIterableNode,
  IStringNode,
  IIntNode,
  IDoubleNode,
  IBoolNode,
  INullNode,
  IDynamicNode
])
void main() {
  group("INode", () {
    group("create", () {
      test("iNode param, should return received data as it is", () {
        // Arrange
        final iNodeFactoryMock = MockINodeFactory();
        final iNodeParam = MockIStringNode();

        // Act
        final createdINode = INode.create(iNodeParam, iNodeFactoryMock);

        // Assert
        expect(createdINode, equals(iNodeParam));
      });

      test(
          "map param, should call createMapNode from INodeFactory with received data",
          () {
        // Arrange
        final iNodeFactoryMock = MockINodeFactory();
        final map = {"oneKey": "oneValue", "anotherKey": "anotherValue"};
        when(iNodeFactoryMock.createMapNode(map)).thenReturn(MockIMapNode());

        // Act
        INode.create(map, iNodeFactoryMock);

        // Assert
        verify(iNodeFactoryMock.createMapNode(map));
        verifyNoMoreInteractions(iNodeFactoryMock);
      });

      test(
          "iterable param, should call createIterableNode from INodeFactory with received data",
          () {
        // Arrange
        final iNodeFactoryMock = MockINodeFactory();
        final iterable = ["oneKey", "oneValue", "anotherKey", "anotherValue"];
        when(iNodeFactoryMock.createIterableNode(iterable))
            .thenReturn(MockIIterableNode());

        // Act
        INode.create(iterable, iNodeFactoryMock);

        // Assert
        verify(iNodeFactoryMock.createIterableNode(iterable));
        verifyNoMoreInteractions(iNodeFactoryMock);
      });

      test(
          "string param, should call createStringNode from INodeFactory with received data",
          () {
        // Arrange
        final iNodeFactoryMock = MockINodeFactory();
        const string = "oneKey";
        when(iNodeFactoryMock.createStringNode(string))
            .thenReturn(MockIStringNode());

        // Act
        INode.create(string, iNodeFactoryMock);

        // Assert
        verify(iNodeFactoryMock.createStringNode(string));
        verifyNoMoreInteractions(iNodeFactoryMock);
      });

      test(
          "int param, should call createIntNode from INodeFactory with received data",
          () {
        // Arrange
        final iNodeFactoryMock = MockINodeFactory();
        const number = 20;
        when(iNodeFactoryMock.createIntNode(number)).thenReturn(MockIIntNode());

        // Act
        INode.create(number, iNodeFactoryMock);

        // Assert
        verify(iNodeFactoryMock.createIntNode(number));
        verifyNoMoreInteractions(iNodeFactoryMock);
      });

      test(
          "double param, should call createDoubleNode from INodeFactory with received data",
          () {
        // Arrange
        final iNodeFactoryMock = MockINodeFactory();
        const number = 20.0;
        when(iNodeFactoryMock.createDoubleNode(number))
            .thenReturn(MockIDoubleNode());

        // Act
        INode.create(number, iNodeFactoryMock);

        // Assert
        verify(iNodeFactoryMock.createDoubleNode(number));
        verifyNoMoreInteractions(iNodeFactoryMock);
      });

      test(
          "bool param, should call createBoolNode from INodeFactory with received data",
          () {
        // Arrange
        final iNodeFactoryMock = MockINodeFactory();
        const bool = false;
        when(iNodeFactoryMock.createBoolNode(bool)).thenReturn(MockIBoolNode());

        // Act
        INode.create(bool, iNodeFactoryMock);

        // Assert
        verify(iNodeFactoryMock.createBoolNode(bool));
        verifyNoMoreInteractions(iNodeFactoryMock);
      });

      test(
          "null param, should call createNullNode from INodeFactory with no param",
          () {
        // Arrange
        final iNodeFactoryMock = MockINodeFactory();
        const nullParam = null;
        when(iNodeFactoryMock.createNullNode()).thenReturn(MockINullNode());

        // Act
        INode.create(nullParam, iNodeFactoryMock);

        // Assert
        verify(iNodeFactoryMock.createNullNode());
        verifyNoMoreInteractions(iNodeFactoryMock);
      });

      test(
          "dynamic param, should call createDynamicNode from INodeFactory with received data",
          () {
        // Arrange
        final iNodeFactoryMock = MockINodeFactory();
        const dynamicParam = DummyClass("John", "Quintero");
        when(iNodeFactoryMock.createDynamicNode(dynamicParam))
            .thenReturn(MockIDynamicNode());

        // Act
        INode.create(dynamicParam, iNodeFactoryMock);

        // Assert
        verify(iNodeFactoryMock.createDynamicNode(dynamicParam));
        verifyNoMoreInteractions(iNodeFactoryMock);
      });
    });
  });
}
