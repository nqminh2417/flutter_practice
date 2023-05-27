import 'dart:convert';

class ProgressSummertimeSaga {
  final String version;
  final Totals totals;
  final Issues issues;
  final Depts depts;
  ProgressSummertimeSaga({
    required this.version,
    required this.totals,
    required this.issues,
    required this.depts,
  });

  ProgressSummertimeSaga copyWith({
    String? version,
    Totals? totals,
    Issues? issues,
    Depts? depts,
  }) {
    return ProgressSummertimeSaga(
      version: version ?? this.version,
      totals: totals ?? this.totals,
      issues: issues ?? this.issues,
      depts: depts ?? this.depts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version,
      'totals': totals.toMap(),
      'issues': issues.toMap(),
      'depts': depts.toMap(),
    };
  }

  factory ProgressSummertimeSaga.fromMap(Map<String, dynamic> map) {
    return ProgressSummertimeSaga(
      version: map['version'] as String,
      totals: Totals.fromMap(map['totals'] as Map<String,dynamic>),
      issues: Issues.fromMap(map['issues'] as Map<String,dynamic>),
      depts: Depts.fromMap(map['depts'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProgressSummertimeSaga.fromJson(String source) => ProgressSummertimeSaga.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProgressSummertimeSaga(version: $version, totals: $totals, issues: $issues, depts: $depts)';
  }

  @override
  bool operator ==(covariant ProgressSummertimeSaga other) {
    if (identical(this, other)) return true;
  
    return 
      other.version == version &&
      other.totals == totals &&
      other.issues == issues &&
      other.depts == depts;
  }

  @override
  int get hashCode {
    return version.hashCode ^
      totals.hashCode ^
      issues.hashCode ^
      depts.hashCode;
  }
}

class Totals {
  final int nNew;
  final int closed;
  final int working;
  final int total;
  final Percent percent;
  Totals({
    required this.nNew,
    required this.closed,
    required this.working,
    required this.total,
    required this.percent,
  });

  Totals copyWith({
    int? nNew,
    int? closed,
    int? working,
    int? total,
    Percent? percent,
  }) {
    return Totals(
      nNew: nNew ?? this.nNew,
      closed: closed ?? this.closed,
      working: working ?? this.working,
      total: total ?? this.total,
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new': nNew,
      'closed': closed,
      'working': working,
      'total': total,
      'percent': percent.toMap(),
    };
  }

  factory Totals.fromMap(Map<String, dynamic> map) {
    return Totals(
      nNew: map['new'].toInt() as int,
      closed: map['closed'].toInt() as int,
      working: map['working'].toInt() as int,
      total: map['total'].toInt() as int,
      percent: Percent.fromMap(map['percent'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Totals.fromJson(String source) => Totals.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Totals(nNew: $nNew, closed: $closed, working: $working, total: $total, percent: $percent)';
  }

  @override
  bool operator ==(covariant Totals other) {
    if (identical(this, other)) return true;
  
    return 
      other.nNew == nNew &&
      other.closed == closed &&
      other.working == working &&
      other.total == total &&
      other.percent == percent;
  }

  @override
  int get hashCode {
    return nNew.hashCode ^
      closed.hashCode ^
      working.hashCode ^
      total.hashCode ^
      percent.hashCode;
  }
}

class Percent {
  final String completed;
  final String working;
  Percent({
    required this.completed,
    required this.working,
  });

  Percent copyWith({
    String? completed,
    String? working,
  }) {
    return Percent(
      completed: completed ?? this.completed,
      working: working ?? this.working,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'completed': completed,
      'working': working,
    };
  }

  factory Percent.fromMap(Map<String, dynamic> map) {
    return Percent(
      completed: map['completed'] as String,
      working: map['working'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Percent.fromJson(String source) => Percent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Percent(completed: $completed, working: $working)';

  @override
  bool operator ==(covariant Percent other) {
    if (identical(this, other)) return true;
  
    return 
      other.completed == completed &&
      other.working == working;
  }

  @override
  int get hashCode => completed.hashCode ^ working.hashCode;
}

class Issues {
  final int open;
  final int closed;
  final int total;
  Issues({
    required this.open,
    required this.closed,
    required this.total,
  });

  Issues copyWith({
    int? open,
    int? closed,
    int? total,
  }) {
    return Issues(
      open: open ?? this.open,
      closed: closed ?? this.closed,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'open': open,
      'closed': closed,
      'total': total,
    };
  }

  factory Issues.fromMap(Map<String, dynamic> map) {
    return Issues(
      open: map['open'].toInt() as int,
      closed: map['closed'].toInt() as int,
      total: map['total'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Issues.fromJson(String source) => Issues.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Issues(open: $open, closed: $closed, total: $total)';

  @override
  bool operator ==(covariant Issues other) {
    if (identical(this, other)) return true;
  
    return 
      other.open == open &&
      other.closed == closed &&
      other.total == total;
  }

  @override
  int get hashCode => open.hashCode ^ closed.hashCode ^ total.hashCode;
}

class Depts {
  final Art art;
  final Posing posing;
  final Dialogue dialogue;
  final Code code;
  final Audio audio;
  Depts({
    required this.art,
    required this.posing,
    required this.dialogue,
    required this.code,
    required this.audio,
  });

  Depts copyWith({
    Art? art,
    Posing? posing,
    Dialogue? dialogue,
    Code? code,
    Audio? audio,
  }) {
    return Depts(
      art: art ?? this.art,
      posing: posing ?? this.posing,
      dialogue: dialogue ?? this.dialogue,
      code: code ?? this.code,
      audio: audio ?? this.audio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'art': art.toMap(),
      'posing': posing.toMap(),
      'dialogue': dialogue.toMap(),
      'code': code.toMap(),
      'audio': audio.toMap(),
    };
  }

  factory Depts.fromMap(Map<String, dynamic> map) {
    return Depts(
      art: Art.fromMap(map['art'] as Map<String,dynamic>),
      posing: Posing.fromMap(map['posing'] as Map<String,dynamic>),
      dialogue: Dialogue.fromMap(map['dialogue'] as Map<String,dynamic>),
      code: Code.fromMap(map['code'] as Map<String,dynamic>),
      audio: Audio.fromMap(map['audio'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Depts.fromJson(String source) => Depts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Depts(art: $art, posing: $posing, dialogue: $dialogue, code: $code, audio: $audio)';
  }

  @override
  bool operator ==(covariant Depts other) {
    if (identical(this, other)) return true;
  
    return 
      other.art == art &&
      other.posing == posing &&
      other.dialogue == dialogue &&
      other.code == code &&
      other.audio == audio;
  }

  @override
  int get hashCode {
    return art.hashCode ^
      posing.hashCode ^
      dialogue.hashCode ^
      code.hashCode ^
      audio.hashCode;
  }
}

class Art {
  final int nNew;
  final int closed;
  final int working;
  final int total;
  final Percent percent;
  Art({
    required this.nNew,
    required this.closed,
    required this.working,
    required this.total,
    required this.percent,
  });

  Art copyWith({
    int? nNew,
    int? closed,
    int? working,
    int? total,
    Percent? percent,
  }) {
    return Art(
      nNew: nNew ?? this.nNew,
      closed: closed ?? this.closed,
      working: working ?? this.working,
      total: total ?? this.total,
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new': nNew,
      'closed': closed,
      'working': working,
      'total': total,
      'percent': percent.toMap(),
    };
  }

  factory Art.fromMap(Map<String, dynamic> map) {
    return Art(
      nNew: map['new'].toInt() as int,
      closed: map['closed'].toInt() as int,
      working: map['working'].toInt() as int,
      total: map['total'].toInt() as int,
      percent: Percent.fromMap(map['percent'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Art.fromJson(String source) => Art.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Art(nNew: $nNew, closed: $closed, working: $working, total: $total, percent: $percent)';
  }

  @override
  bool operator ==(covariant Art other) {
    if (identical(this, other)) return true;
  
    return 
      other.nNew == nNew &&
      other.closed == closed &&
      other.working == working &&
      other.total == total &&
      other.percent == percent;
  }

  @override
  int get hashCode {
    return nNew.hashCode ^
      closed.hashCode ^
      working.hashCode ^
      total.hashCode ^
      percent.hashCode;
  }
}

class Posing {
  final int nNew;
  final int closed;
  final int working;
  final int total;
  final Percent percent;
  Posing({
    required this.nNew,
    required this.closed,
    required this.working,
    required this.total,
    required this.percent,
  });

  Posing copyWith({
    int? nNew,
    int? closed,
    int? working,
    int? total,
    Percent? percent,
  }) {
    return Posing(
      nNew: nNew ?? this.nNew,
      closed: closed ?? this.closed,
      working: working ?? this.working,
      total: total ?? this.total,
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new': nNew,
      'closed': closed,
      'working': working,
      'total': total,
      'percent': percent.toMap(),
    };
  }

  factory Posing.fromMap(Map<String, dynamic> map) {
    return Posing(
      nNew: map['new'].toInt() as int,
      closed: map['closed'].toInt() as int,
      working: map['working'].toInt() as int,
      total: map['total'].toInt() as int,
      percent: Percent.fromMap(map['percent'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Posing.fromJson(String source) => Posing.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Posing(nNew: $nNew, closed: $closed, working: $working, total: $total, percent: $percent)';
  }

  @override
  bool operator ==(covariant Posing other) {
    if (identical(this, other)) return true;
  
    return 
      other.nNew == nNew &&
      other.closed == closed &&
      other.working == working &&
      other.total == total &&
      other.percent == percent;
  }

  @override
  int get hashCode {
    return nNew.hashCode ^
      closed.hashCode ^
      working.hashCode ^
      total.hashCode ^
      percent.hashCode;
  }
}

class Dialogue {
  final int nNew;
  final int closed;
  final int working;
  final int total;
  final Percent percent;
  Dialogue({
    required this.nNew,
    required this.closed,
    required this.working,
    required this.total,
    required this.percent,
  });

  Dialogue copyWith({
    int? nNew,
    int? closed,
    int? working,
    int? total,
    Percent? percent,
  }) {
    return Dialogue(
      nNew: nNew ?? this.nNew,
      closed: closed ?? this.closed,
      working: working ?? this.working,
      total: total ?? this.total,
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new': nNew,
      'closed': closed,
      'working': working,
      'total': total,
      'percent': percent.toMap(),
    };
  }

  factory Dialogue.fromMap(Map<String, dynamic> map) {
    return Dialogue(
      nNew: map['new'].toInt() as int,
      closed: map['closed'].toInt() as int,
      working: map['working'].toInt() as int,
      total: map['total'].toInt() as int,
      percent: Percent.fromMap(map['percent'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dialogue.fromJson(String source) => Dialogue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Dialogue(nNew: $nNew, closed: $closed, working: $working, total: $total, percent: $percent)';
  }

  @override
  bool operator ==(covariant Dialogue other) {
    if (identical(this, other)) return true;
  
    return 
      other.nNew == nNew &&
      other.closed == closed &&
      other.working == working &&
      other.total == total &&
      other.percent == percent;
  }

  @override
  int get hashCode {
    return nNew.hashCode ^
      closed.hashCode ^
      working.hashCode ^
      total.hashCode ^
      percent.hashCode;
  }
}

class Code {
  final int nNew;
  final int closed;
  final int working;
  final int total;
  final Percent percent;
  Code({
    required this.nNew,
    required this.closed,
    required this.working,
    required this.total,
    required this.percent,
  });

  Code copyWith({
    int? nNew,
    int? closed,
    int? working,
    int? total,
    Percent? percent,
  }) {
    return Code(
      nNew: nNew ?? this.nNew,
      closed: closed ?? this.closed,
      working: working ?? this.working,
      total: total ?? this.total,
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new': nNew,
      'closed': closed,
      'working': working,
      'total': total,
      'percent': percent.toMap(),
    };
  }

  factory Code.fromMap(Map<String, dynamic> map) {
    return Code(
      nNew: map['new'].toInt() as int,
      closed: map['closed'].toInt() as int,
      working: map['working'].toInt() as int,
      total: map['total'].toInt() as int,
      percent: Percent.fromMap(map['percent'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Code.fromJson(String source) => Code.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Code(nNew: $nNew, closed: $closed, working: $working, total: $total, percent: $percent)';
  }

  @override
  bool operator ==(covariant Code other) {
    if (identical(this, other)) return true;
  
    return 
      other.nNew == nNew &&
      other.closed == closed &&
      other.working == working &&
      other.total == total &&
      other.percent == percent;
  }

  @override
  int get hashCode {
    return nNew.hashCode ^
      closed.hashCode ^
      working.hashCode ^
      total.hashCode ^
      percent.hashCode;
  }
}

class Audio {
  final int nNew;
  final int closed;
  final int working;
  final int total;
  final Percent percent;
  Audio({
    required this.nNew,
    required this.closed,
    required this.working,
    required this.total,
    required this.percent,
  });

  Audio copyWith({
    int? nNew,
    int? closed,
    int? working,
    int? total,
    Percent? percent,
  }) {
    return Audio(
      nNew: nNew ?? this.nNew,
      closed: closed ?? this.closed,
      working: working ?? this.working,
      total: total ?? this.total,
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new': nNew,
      'closed': closed,
      'working': working,
      'total': total,
      'percent': percent.toMap(),
    };
  }

  factory Audio.fromMap(Map<String, dynamic> map) {
    return Audio(
      nNew: map['new'].toInt() as int,
      closed: map['closed'].toInt() as int,
      working: map['working'].toInt() as int,
      total: map['total'].toInt() as int,
      percent: Percent.fromMap(map['percent'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Audio.fromJson(String source) => Audio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Audio(nNew: $nNew, closed: $closed, working: $working, total: $total, percent: $percent)';
  }

  @override
  bool operator ==(covariant Audio other) {
    if (identical(this, other)) return true;
  
    return 
      other.nNew == nNew &&
      other.closed == closed &&
      other.working == working &&
      other.total == total &&
      other.percent == percent;
  }

  @override
  int get hashCode {
    return nNew.hashCode ^
      closed.hashCode ^
      working.hashCode ^
      total.hashCode ^
      percent.hashCode;
  }
}