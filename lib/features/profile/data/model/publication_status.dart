enum PublicationStatus {
  published,
  draft,
}

extension PublicationStatusExtension on PublicationStatus {
  String get value {
    switch (this) {
      case PublicationStatus.published:
        return 'PUBLISHED';
      case PublicationStatus.draft:
        return 'DRAFT';
    }
  }

  String get displayName {
    switch (this) {
      case PublicationStatus.published:
        return 'Posts';
      case PublicationStatus.draft:
        return 'Drafts';
    }
  }
}
