List<Code> codeFromJson(Map<String, dynamic> mapper) {
  List<Code> codes = [];
  mapper.forEach((key, value) {
    codes.add(Code.fromJson(key, value));
  });
  return codes;
}

class Code {
  Code({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory Code.fromJson(dynamic jcode, dynamic jname) => Code(
        code: jcode,
        name: jname,
      );
}
