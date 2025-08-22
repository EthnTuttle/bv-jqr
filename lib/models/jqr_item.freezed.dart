// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jqr_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

JQRItem _$JQRItemFromJson(Map<String, dynamic> json) {
  return _JQRItem.fromJson(json);
}

/// @nodoc
mixin _$JQRItem {
  String get id => throw _privateConstructorUsedError; // e.g., "101.1"
  String get section => throw _privateConstructorUsedError; // e.g., "100"
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get studyMaterials => throw _privateConstructorUsedError;
  RequirementType get type => throw _privateConstructorUsedError;
  QualificationLevel get level => throw _privateConstructorUsedError;
  List<String> get prerequisites => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this JQRItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JQRItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JQRItemCopyWith<JQRItem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JQRItemCopyWith<$Res> {
  factory $JQRItemCopyWith(JQRItem value, $Res Function(JQRItem) then) =
      _$JQRItemCopyWithImpl<$Res, JQRItem>;
  @useResult
  $Res call({
    String id,
    String section,
    String title,
    String description,
    List<String> studyMaterials,
    RequirementType type,
    QualificationLevel level,
    List<String> prerequisites,
    String? notes,
  });
}

/// @nodoc
class _$JQRItemCopyWithImpl<$Res, $Val extends JQRItem>
    implements $JQRItemCopyWith<$Res> {
  _$JQRItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JQRItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? section = null,
    Object? title = null,
    Object? description = null,
    Object? studyMaterials = null,
    Object? type = null,
    Object? level = null,
    Object? prerequisites = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            section: null == section
                ? _value.section
                : section // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            studyMaterials: null == studyMaterials
                ? _value.studyMaterials
                : studyMaterials // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as RequirementType,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as QualificationLevel,
            prerequisites: null == prerequisites
                ? _value.prerequisites
                : prerequisites // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JQRItemImplCopyWith<$Res> implements $JQRItemCopyWith<$Res> {
  factory _$$JQRItemImplCopyWith(
    _$JQRItemImpl value,
    $Res Function(_$JQRItemImpl) then,
  ) = __$$JQRItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String section,
    String title,
    String description,
    List<String> studyMaterials,
    RequirementType type,
    QualificationLevel level,
    List<String> prerequisites,
    String? notes,
  });
}

/// @nodoc
class __$$JQRItemImplCopyWithImpl<$Res>
    extends _$JQRItemCopyWithImpl<$Res, _$JQRItemImpl>
    implements _$$JQRItemImplCopyWith<$Res> {
  __$$JQRItemImplCopyWithImpl(
    _$JQRItemImpl _value,
    $Res Function(_$JQRItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JQRItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? section = null,
    Object? title = null,
    Object? description = null,
    Object? studyMaterials = null,
    Object? type = null,
    Object? level = null,
    Object? prerequisites = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$JQRItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        section: null == section
            ? _value.section
            : section // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        studyMaterials: null == studyMaterials
            ? _value._studyMaterials
            : studyMaterials // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as RequirementType,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as QualificationLevel,
        prerequisites: null == prerequisites
            ? _value._prerequisites
            : prerequisites // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JQRItemImpl implements _JQRItem {
  const _$JQRItemImpl({
    required this.id,
    required this.section,
    required this.title,
    required this.description,
    required final List<String> studyMaterials,
    required this.type,
    required this.level,
    final List<String> prerequisites = const [],
    this.notes,
  }) : _studyMaterials = studyMaterials,
       _prerequisites = prerequisites;

  factory _$JQRItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$JQRItemImplFromJson(json);

  @override
  final String id;
  // e.g., "101.1"
  @override
  final String section;
  // e.g., "100"
  @override
  final String title;
  @override
  final String description;
  final List<String> _studyMaterials;
  @override
  List<String> get studyMaterials {
    if (_studyMaterials is EqualUnmodifiableListView) return _studyMaterials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_studyMaterials);
  }

  @override
  final RequirementType type;
  @override
  final QualificationLevel level;
  final List<String> _prerequisites;
  @override
  @JsonKey()
  List<String> get prerequisites {
    if (_prerequisites is EqualUnmodifiableListView) return _prerequisites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prerequisites);
  }

  @override
  final String? notes;

  @override
  String toString() {
    return 'JQRItem(id: $id, section: $section, title: $title, description: $description, studyMaterials: $studyMaterials, type: $type, level: $level, prerequisites: $prerequisites, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JQRItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._studyMaterials,
              _studyMaterials,
            ) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(
              other._prerequisites,
              _prerequisites,
            ) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    section,
    title,
    description,
    const DeepCollectionEquality().hash(_studyMaterials),
    type,
    level,
    const DeepCollectionEquality().hash(_prerequisites),
    notes,
  );

  /// Create a copy of JQRItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JQRItemImplCopyWith<_$JQRItemImpl> get copyWith =>
      __$$JQRItemImplCopyWithImpl<_$JQRItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JQRItemImplToJson(this);
  }
}

abstract class _JQRItem implements JQRItem {
  const factory _JQRItem({
    required final String id,
    required final String section,
    required final String title,
    required final String description,
    required final List<String> studyMaterials,
    required final RequirementType type,
    required final QualificationLevel level,
    final List<String> prerequisites,
    final String? notes,
  }) = _$JQRItemImpl;

  factory _JQRItem.fromJson(Map<String, dynamic> json) = _$JQRItemImpl.fromJson;

  @override
  String get id; // e.g., "101.1"
  @override
  String get section; // e.g., "100"
  @override
  String get title;
  @override
  String get description;
  @override
  List<String> get studyMaterials;
  @override
  RequirementType get type;
  @override
  QualificationLevel get level;
  @override
  List<String> get prerequisites;
  @override
  String? get notes;

  /// Create a copy of JQRItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JQRItemImplCopyWith<_$JQRItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JQRSection _$JQRSectionFromJson(Map<String, dynamic> json) {
  return _JQRSection.fromJson(json);
}

/// @nodoc
mixin _$JQRSection {
  String get id => throw _privateConstructorUsedError; // e.g., "100"
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<JQRItem> get items => throw _privateConstructorUsedError;
  QualificationLevel get level => throw _privateConstructorUsedError;

  /// Serializes this JQRSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JQRSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JQRSectionCopyWith<JQRSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JQRSectionCopyWith<$Res> {
  factory $JQRSectionCopyWith(
    JQRSection value,
    $Res Function(JQRSection) then,
  ) = _$JQRSectionCopyWithImpl<$Res, JQRSection>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    List<JQRItem> items,
    QualificationLevel level,
  });
}

/// @nodoc
class _$JQRSectionCopyWithImpl<$Res, $Val extends JQRSection>
    implements $JQRSectionCopyWith<$Res> {
  _$JQRSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JQRSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? items = null,
    Object? level = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<JQRItem>,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as QualificationLevel,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JQRSectionImplCopyWith<$Res>
    implements $JQRSectionCopyWith<$Res> {
  factory _$$JQRSectionImplCopyWith(
    _$JQRSectionImpl value,
    $Res Function(_$JQRSectionImpl) then,
  ) = __$$JQRSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    List<JQRItem> items,
    QualificationLevel level,
  });
}

/// @nodoc
class __$$JQRSectionImplCopyWithImpl<$Res>
    extends _$JQRSectionCopyWithImpl<$Res, _$JQRSectionImpl>
    implements _$$JQRSectionImplCopyWith<$Res> {
  __$$JQRSectionImplCopyWithImpl(
    _$JQRSectionImpl _value,
    $Res Function(_$JQRSectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JQRSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? items = null,
    Object? level = null,
  }) {
    return _then(
      _$JQRSectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<JQRItem>,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as QualificationLevel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JQRSectionImpl implements _JQRSection {
  const _$JQRSectionImpl({
    required this.id,
    required this.title,
    required this.description,
    required final List<JQRItem> items,
    required this.level,
  }) : _items = items;

  factory _$JQRSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$JQRSectionImplFromJson(json);

  @override
  final String id;
  // e.g., "100"
  @override
  final String title;
  @override
  final String description;
  final List<JQRItem> _items;
  @override
  List<JQRItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final QualificationLevel level;

  @override
  String toString() {
    return 'JQRSection(id: $id, title: $title, description: $description, items: $items, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JQRSectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    const DeepCollectionEquality().hash(_items),
    level,
  );

  /// Create a copy of JQRSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JQRSectionImplCopyWith<_$JQRSectionImpl> get copyWith =>
      __$$JQRSectionImplCopyWithImpl<_$JQRSectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JQRSectionImplToJson(this);
  }
}

abstract class _JQRSection implements JQRSection {
  const factory _JQRSection({
    required final String id,
    required final String title,
    required final String description,
    required final List<JQRItem> items,
    required final QualificationLevel level,
  }) = _$JQRSectionImpl;

  factory _JQRSection.fromJson(Map<String, dynamic> json) =
      _$JQRSectionImpl.fromJson;

  @override
  String get id; // e.g., "100"
  @override
  String get title;
  @override
  String get description;
  @override
  List<JQRItem> get items;
  @override
  QualificationLevel get level;

  /// Create a copy of JQRSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JQRSectionImplCopyWith<_$JQRSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
