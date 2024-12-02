class geminiapi {
  List<Candidates>? candidates;
  UsageMetadata? usageMetadata;
  String? modelVersion;

  geminiapi({this.candidates, this.usageMetadata, this.modelVersion});

  geminiapi.fromJson(Map<String, dynamic> json) {
    if (json['candidates'] != null) {
      candidates = <Candidates>[];
      json['candidates'].forEach((v) {
        candidates!.add(Candidates.fromJson(v));
      });
    }
    usageMetadata = json['usageMetadata'] != null
        ? UsageMetadata.fromJson(json['usageMetadata'])
        : null;
    modelVersion = json['modelVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (candidates != null) {
      data['candidates'] = candidates!.map((v) => v.toJson()).toList();
    }
    if (usageMetadata != null) {
      data['usageMetadata'] = usageMetadata!.toJson();
    }
    data['modelVersion'] = modelVersion;
    return data;
  }
}

class Candidates {
  Content? content;
  String? finishReason;
  double? avgLogprobs;

  Candidates({this.content, this.finishReason, this.avgLogprobs});

  Candidates.fromJson(Map<String, dynamic> json) {
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    finishReason = json['finishReason'];
    avgLogprobs = json['avgLogprobs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['finishReason'] = finishReason;
    data['avgLogprobs'] = avgLogprobs;
    return data;
  }
}

class Content {
  List<Parts>? parts;
  String? role;

  Content({this.parts, this.role});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['parts'] != null) {
      parts = <Parts>[];
      json['parts'].forEach((v) {
        parts!.add(Parts.fromJson(v));
      });
    }
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (parts != null) {
      data['parts'] = parts!.map((v) => v.toJson()).toList();
    }
    data['role'] = role;
    return data;
  }
}

class Parts {
  String? text;

  Parts({this.text});

  Parts.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class UsageMetadata {
  int? promptTokenCount;
  int? candidatesTokenCount;
  int? totalTokenCount;

  UsageMetadata(
      {this.promptTokenCount, this.candidatesTokenCount, this.totalTokenCount});

  UsageMetadata.fromJson(Map<String, dynamic> json) {
    promptTokenCount = json['promptTokenCount'];
    candidatesTokenCount = json['candidatesTokenCount'];
    totalTokenCount = json['totalTokenCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promptTokenCount'] = promptTokenCount;
    data['candidatesTokenCount'] = candidatesTokenCount;
    data['totalTokenCount'] = totalTokenCount;
    return data;
  }
}
