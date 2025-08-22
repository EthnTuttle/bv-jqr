// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

JQRAttestation _$JQRAttestationFromJson(Map<String, dynamic> json) {
  return _JQRAttestation.fromJson(json);
}

/// @nodoc
mixin _$JQRAttestation {
  String get itemId => throw _privateConstructorUsedError;
  String get candidateNpub => throw _privateConstructorUsedError;
  String get smeNpub => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get nostrEventId => throw _privateConstructorUsedError;
  AttestationStatus get status => throw _privateConstructorUsedError;
  bool? get isOffline => throw _privateConstructorUsedError;

  /// Serializes this JQRAttestation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JQRAttestation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JQRAttestationCopyWith<JQRAttestation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JQRAttestationCopyWith<$Res> {
  factory $JQRAttestationCopyWith(
    JQRAttestation value,
    $Res Function(JQRAttestation) then,
  ) = _$JQRAttestationCopyWithImpl<$Res, JQRAttestation>;
  @useResult
  $Res call({
    String itemId,
    String candidateNpub,
    String smeNpub,
    DateTime timestamp,
    String? notes,
    String? nostrEventId,
    AttestationStatus status,
    bool? isOffline,
  });
}

/// @nodoc
class _$JQRAttestationCopyWithImpl<$Res, $Val extends JQRAttestation>
    implements $JQRAttestationCopyWith<$Res> {
  _$JQRAttestationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JQRAttestation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? candidateNpub = null,
    Object? smeNpub = null,
    Object? timestamp = null,
    Object? notes = freezed,
    Object? nostrEventId = freezed,
    Object? status = null,
    Object? isOffline = freezed,
  }) {
    return _then(
      _value.copyWith(
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            candidateNpub: null == candidateNpub
                ? _value.candidateNpub
                : candidateNpub // ignore: cast_nullable_to_non_nullable
                      as String,
            smeNpub: null == smeNpub
                ? _value.smeNpub
                : smeNpub // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            nostrEventId: freezed == nostrEventId
                ? _value.nostrEventId
                : nostrEventId // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AttestationStatus,
            isOffline: freezed == isOffline
                ? _value.isOffline
                : isOffline // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JQRAttestationImplCopyWith<$Res>
    implements $JQRAttestationCopyWith<$Res> {
  factory _$$JQRAttestationImplCopyWith(
    _$JQRAttestationImpl value,
    $Res Function(_$JQRAttestationImpl) then,
  ) = __$$JQRAttestationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String itemId,
    String candidateNpub,
    String smeNpub,
    DateTime timestamp,
    String? notes,
    String? nostrEventId,
    AttestationStatus status,
    bool? isOffline,
  });
}

/// @nodoc
class __$$JQRAttestationImplCopyWithImpl<$Res>
    extends _$JQRAttestationCopyWithImpl<$Res, _$JQRAttestationImpl>
    implements _$$JQRAttestationImplCopyWith<$Res> {
  __$$JQRAttestationImplCopyWithImpl(
    _$JQRAttestationImpl _value,
    $Res Function(_$JQRAttestationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JQRAttestation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? candidateNpub = null,
    Object? smeNpub = null,
    Object? timestamp = null,
    Object? notes = freezed,
    Object? nostrEventId = freezed,
    Object? status = null,
    Object? isOffline = freezed,
  }) {
    return _then(
      _$JQRAttestationImpl(
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        candidateNpub: null == candidateNpub
            ? _value.candidateNpub
            : candidateNpub // ignore: cast_nullable_to_non_nullable
                  as String,
        smeNpub: null == smeNpub
            ? _value.smeNpub
            : smeNpub // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        nostrEventId: freezed == nostrEventId
            ? _value.nostrEventId
            : nostrEventId // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AttestationStatus,
        isOffline: freezed == isOffline
            ? _value.isOffline
            : isOffline // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JQRAttestationImpl implements _JQRAttestation {
  const _$JQRAttestationImpl({
    required this.itemId,
    required this.candidateNpub,
    required this.smeNpub,
    required this.timestamp,
    this.notes,
    this.nostrEventId,
    this.status = AttestationStatus.notStarted,
    this.isOffline,
  });

  factory _$JQRAttestationImpl.fromJson(Map<String, dynamic> json) =>
      _$$JQRAttestationImplFromJson(json);

  @override
  final String itemId;
  @override
  final String candidateNpub;
  @override
  final String smeNpub;
  @override
  final DateTime timestamp;
  @override
  final String? notes;
  @override
  final String? nostrEventId;
  @override
  @JsonKey()
  final AttestationStatus status;
  @override
  final bool? isOffline;

  @override
  String toString() {
    return 'JQRAttestation(itemId: $itemId, candidateNpub: $candidateNpub, smeNpub: $smeNpub, timestamp: $timestamp, notes: $notes, nostrEventId: $nostrEventId, status: $status, isOffline: $isOffline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JQRAttestationImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.candidateNpub, candidateNpub) ||
                other.candidateNpub == candidateNpub) &&
            (identical(other.smeNpub, smeNpub) || other.smeNpub == smeNpub) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.nostrEventId, nostrEventId) ||
                other.nostrEventId == nostrEventId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isOffline, isOffline) ||
                other.isOffline == isOffline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    itemId,
    candidateNpub,
    smeNpub,
    timestamp,
    notes,
    nostrEventId,
    status,
    isOffline,
  );

  /// Create a copy of JQRAttestation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JQRAttestationImplCopyWith<_$JQRAttestationImpl> get copyWith =>
      __$$JQRAttestationImplCopyWithImpl<_$JQRAttestationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$JQRAttestationImplToJson(this);
  }
}

abstract class _JQRAttestation implements JQRAttestation {
  const factory _JQRAttestation({
    required final String itemId,
    required final String candidateNpub,
    required final String smeNpub,
    required final DateTime timestamp,
    final String? notes,
    final String? nostrEventId,
    final AttestationStatus status,
    final bool? isOffline,
  }) = _$JQRAttestationImpl;

  factory _JQRAttestation.fromJson(Map<String, dynamic> json) =
      _$JQRAttestationImpl.fromJson;

  @override
  String get itemId;
  @override
  String get candidateNpub;
  @override
  String get smeNpub;
  @override
  DateTime get timestamp;
  @override
  String? get notes;
  @override
  String? get nostrEventId;
  @override
  AttestationStatus get status;
  @override
  bool? get isOffline;

  /// Create a copy of JQRAttestation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JQRAttestationImplCopyWith<_$JQRAttestationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProgress _$UserProgressFromJson(Map<String, dynamic> json) {
  return _UserProgress.fromJson(json);
}

/// @nodoc
mixin _$UserProgress {
  String get npub => throw _privateConstructorUsedError;
  String get selectedAuthority =>
      throw _privateConstructorUsedError; // NIP-05 domain
  Map<String, JQRAttestation> get itemAttestations =>
      throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  QualificationLevel get currentLevel => throw _privateConstructorUsedError;
  int get totalItemsCompleted => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;

  /// Serializes this UserProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProgressCopyWith<UserProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProgressCopyWith<$Res> {
  factory $UserProgressCopyWith(
    UserProgress value,
    $Res Function(UserProgress) then,
  ) = _$UserProgressCopyWithImpl<$Res, UserProgress>;
  @useResult
  $Res call({
    String npub,
    String selectedAuthority,
    Map<String, JQRAttestation> itemAttestations,
    DateTime lastUpdated,
    QualificationLevel currentLevel,
    int totalItemsCompleted,
    int totalItems,
  });
}

/// @nodoc
class _$UserProgressCopyWithImpl<$Res, $Val extends UserProgress>
    implements $UserProgressCopyWith<$Res> {
  _$UserProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? npub = null,
    Object? selectedAuthority = null,
    Object? itemAttestations = null,
    Object? lastUpdated = null,
    Object? currentLevel = null,
    Object? totalItemsCompleted = null,
    Object? totalItems = null,
  }) {
    return _then(
      _value.copyWith(
            npub: null == npub
                ? _value.npub
                : npub // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedAuthority: null == selectedAuthority
                ? _value.selectedAuthority
                : selectedAuthority // ignore: cast_nullable_to_non_nullable
                      as String,
            itemAttestations: null == itemAttestations
                ? _value.itemAttestations
                : itemAttestations // ignore: cast_nullable_to_non_nullable
                      as Map<String, JQRAttestation>,
            lastUpdated: null == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            currentLevel: null == currentLevel
                ? _value.currentLevel
                : currentLevel // ignore: cast_nullable_to_non_nullable
                      as QualificationLevel,
            totalItemsCompleted: null == totalItemsCompleted
                ? _value.totalItemsCompleted
                : totalItemsCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            totalItems: null == totalItems
                ? _value.totalItems
                : totalItems // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProgressImplCopyWith<$Res>
    implements $UserProgressCopyWith<$Res> {
  factory _$$UserProgressImplCopyWith(
    _$UserProgressImpl value,
    $Res Function(_$UserProgressImpl) then,
  ) = __$$UserProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String npub,
    String selectedAuthority,
    Map<String, JQRAttestation> itemAttestations,
    DateTime lastUpdated,
    QualificationLevel currentLevel,
    int totalItemsCompleted,
    int totalItems,
  });
}

/// @nodoc
class __$$UserProgressImplCopyWithImpl<$Res>
    extends _$UserProgressCopyWithImpl<$Res, _$UserProgressImpl>
    implements _$$UserProgressImplCopyWith<$Res> {
  __$$UserProgressImplCopyWithImpl(
    _$UserProgressImpl _value,
    $Res Function(_$UserProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? npub = null,
    Object? selectedAuthority = null,
    Object? itemAttestations = null,
    Object? lastUpdated = null,
    Object? currentLevel = null,
    Object? totalItemsCompleted = null,
    Object? totalItems = null,
  }) {
    return _then(
      _$UserProgressImpl(
        npub: null == npub
            ? _value.npub
            : npub // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedAuthority: null == selectedAuthority
            ? _value.selectedAuthority
            : selectedAuthority // ignore: cast_nullable_to_non_nullable
                  as String,
        itemAttestations: null == itemAttestations
            ? _value._itemAttestations
            : itemAttestations // ignore: cast_nullable_to_non_nullable
                  as Map<String, JQRAttestation>,
        lastUpdated: null == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        currentLevel: null == currentLevel
            ? _value.currentLevel
            : currentLevel // ignore: cast_nullable_to_non_nullable
                  as QualificationLevel,
        totalItemsCompleted: null == totalItemsCompleted
            ? _value.totalItemsCompleted
            : totalItemsCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        totalItems: null == totalItems
            ? _value.totalItems
            : totalItems // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProgressImpl implements _UserProgress {
  const _$UserProgressImpl({
    required this.npub,
    required this.selectedAuthority,
    final Map<String, JQRAttestation> itemAttestations = const {},
    required this.lastUpdated,
    this.currentLevel = QualificationLevel.basic,
    this.totalItemsCompleted = 0,
    this.totalItems = 0,
  }) : _itemAttestations = itemAttestations;

  factory _$UserProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProgressImplFromJson(json);

  @override
  final String npub;
  @override
  final String selectedAuthority;
  // NIP-05 domain
  final Map<String, JQRAttestation> _itemAttestations;
  // NIP-05 domain
  @override
  @JsonKey()
  Map<String, JQRAttestation> get itemAttestations {
    if (_itemAttestations is EqualUnmodifiableMapView) return _itemAttestations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_itemAttestations);
  }

  @override
  final DateTime lastUpdated;
  @override
  @JsonKey()
  final QualificationLevel currentLevel;
  @override
  @JsonKey()
  final int totalItemsCompleted;
  @override
  @JsonKey()
  final int totalItems;

  @override
  String toString() {
    return 'UserProgress(npub: $npub, selectedAuthority: $selectedAuthority, itemAttestations: $itemAttestations, lastUpdated: $lastUpdated, currentLevel: $currentLevel, totalItemsCompleted: $totalItemsCompleted, totalItems: $totalItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProgressImpl &&
            (identical(other.npub, npub) || other.npub == npub) &&
            (identical(other.selectedAuthority, selectedAuthority) ||
                other.selectedAuthority == selectedAuthority) &&
            const DeepCollectionEquality().equals(
              other._itemAttestations,
              _itemAttestations,
            ) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            (identical(other.totalItemsCompleted, totalItemsCompleted) ||
                other.totalItemsCompleted == totalItemsCompleted) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    npub,
    selectedAuthority,
    const DeepCollectionEquality().hash(_itemAttestations),
    lastUpdated,
    currentLevel,
    totalItemsCompleted,
    totalItems,
  );

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProgressImplCopyWith<_$UserProgressImpl> get copyWith =>
      __$$UserProgressImplCopyWithImpl<_$UserProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProgressImplToJson(this);
  }
}

abstract class _UserProgress implements UserProgress {
  const factory _UserProgress({
    required final String npub,
    required final String selectedAuthority,
    final Map<String, JQRAttestation> itemAttestations,
    required final DateTime lastUpdated,
    final QualificationLevel currentLevel,
    final int totalItemsCompleted,
    final int totalItems,
  }) = _$UserProgressImpl;

  factory _UserProgress.fromJson(Map<String, dynamic> json) =
      _$UserProgressImpl.fromJson;

  @override
  String get npub;
  @override
  String get selectedAuthority; // NIP-05 domain
  @override
  Map<String, JQRAttestation> get itemAttestations;
  @override
  DateTime get lastUpdated;
  @override
  QualificationLevel get currentLevel;
  @override
  int get totalItemsCompleted;
  @override
  int get totalItems;

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProgressImplCopyWith<_$UserProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JQRAuthority _$JQRAuthorityFromJson(Map<String, dynamic> json) {
  return _JQRAuthority.fromJson(json);
}

/// @nodoc
mixin _$JQRAuthority {
  String get nip05Domain =>
      throw _privateConstructorUsedError; // e.g., "bitcoinveterans.org"
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get authorizedSMEs =>
      throw _privateConstructorUsedError; // List of npubs
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this JQRAuthority to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JQRAuthority
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JQRAuthorityCopyWith<JQRAuthority> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JQRAuthorityCopyWith<$Res> {
  factory $JQRAuthorityCopyWith(
    JQRAuthority value,
    $Res Function(JQRAuthority) then,
  ) = _$JQRAuthorityCopyWithImpl<$Res, JQRAuthority>;
  @useResult
  $Res call({
    String nip05Domain,
    String name,
    String description,
    List<String> authorizedSMEs,
    bool isActive,
  });
}

/// @nodoc
class _$JQRAuthorityCopyWithImpl<$Res, $Val extends JQRAuthority>
    implements $JQRAuthorityCopyWith<$Res> {
  _$JQRAuthorityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JQRAuthority
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nip05Domain = null,
    Object? name = null,
    Object? description = null,
    Object? authorizedSMEs = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            nip05Domain: null == nip05Domain
                ? _value.nip05Domain
                : nip05Domain // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            authorizedSMEs: null == authorizedSMEs
                ? _value.authorizedSMEs
                : authorizedSMEs // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JQRAuthorityImplCopyWith<$Res>
    implements $JQRAuthorityCopyWith<$Res> {
  factory _$$JQRAuthorityImplCopyWith(
    _$JQRAuthorityImpl value,
    $Res Function(_$JQRAuthorityImpl) then,
  ) = __$$JQRAuthorityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String nip05Domain,
    String name,
    String description,
    List<String> authorizedSMEs,
    bool isActive,
  });
}

/// @nodoc
class __$$JQRAuthorityImplCopyWithImpl<$Res>
    extends _$JQRAuthorityCopyWithImpl<$Res, _$JQRAuthorityImpl>
    implements _$$JQRAuthorityImplCopyWith<$Res> {
  __$$JQRAuthorityImplCopyWithImpl(
    _$JQRAuthorityImpl _value,
    $Res Function(_$JQRAuthorityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JQRAuthority
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nip05Domain = null,
    Object? name = null,
    Object? description = null,
    Object? authorizedSMEs = null,
    Object? isActive = null,
  }) {
    return _then(
      _$JQRAuthorityImpl(
        nip05Domain: null == nip05Domain
            ? _value.nip05Domain
            : nip05Domain // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        authorizedSMEs: null == authorizedSMEs
            ? _value._authorizedSMEs
            : authorizedSMEs // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JQRAuthorityImpl implements _JQRAuthority {
  const _$JQRAuthorityImpl({
    required this.nip05Domain,
    required this.name,
    required this.description,
    required final List<String> authorizedSMEs,
    this.isActive = true,
  }) : _authorizedSMEs = authorizedSMEs;

  factory _$JQRAuthorityImpl.fromJson(Map<String, dynamic> json) =>
      _$$JQRAuthorityImplFromJson(json);

  @override
  final String nip05Domain;
  // e.g., "bitcoinveterans.org"
  @override
  final String name;
  @override
  final String description;
  final List<String> _authorizedSMEs;
  @override
  List<String> get authorizedSMEs {
    if (_authorizedSMEs is EqualUnmodifiableListView) return _authorizedSMEs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authorizedSMEs);
  }

  // List of npubs
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'JQRAuthority(nip05Domain: $nip05Domain, name: $name, description: $description, authorizedSMEs: $authorizedSMEs, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JQRAuthorityImpl &&
            (identical(other.nip05Domain, nip05Domain) ||
                other.nip05Domain == nip05Domain) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._authorizedSMEs,
              _authorizedSMEs,
            ) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    nip05Domain,
    name,
    description,
    const DeepCollectionEquality().hash(_authorizedSMEs),
    isActive,
  );

  /// Create a copy of JQRAuthority
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JQRAuthorityImplCopyWith<_$JQRAuthorityImpl> get copyWith =>
      __$$JQRAuthorityImplCopyWithImpl<_$JQRAuthorityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JQRAuthorityImplToJson(this);
  }
}

abstract class _JQRAuthority implements JQRAuthority {
  const factory _JQRAuthority({
    required final String nip05Domain,
    required final String name,
    required final String description,
    required final List<String> authorizedSMEs,
    final bool isActive,
  }) = _$JQRAuthorityImpl;

  factory _JQRAuthority.fromJson(Map<String, dynamic> json) =
      _$JQRAuthorityImpl.fromJson;

  @override
  String get nip05Domain; // e.g., "bitcoinveterans.org"
  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get authorizedSMEs; // List of npubs
  @override
  bool get isActive;

  /// Create a copy of JQRAuthority
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JQRAuthorityImplCopyWith<_$JQRAuthorityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
