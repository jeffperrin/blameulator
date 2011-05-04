require 'blameulator'

def single_valid_cvs_entry()
  <<-CVS
RCS file: /u01/cvs/cvsroot/source/source_tree/Source/sql/Create.sql,v
head: 1.2024
branch:
locks: strict
access list:
keyword substitution: o
total revisions: 2072;  selected revisions: 1
description:
----------------------------
revision 1.2024
date: 2011/03/21 17:47:23;  author: cvsuser;  state: Exp;  lines: +42 -42
Fixed a bug
=============================================================================
  CVS
end

def two_valid_cvs_entries_in_two_separate_commits
    <<-CVS

RCS file: /u01/cvs/cvsroot/source/source_tree/Source/sql/Populate.sql,v
head: 1.1286
branch:
locks: strict
access list:
keyword substitution: o
total revisions: 1334;  selected revisions: 1
description:
----------------------------
revision 1.1286
date: 2011/03/21 17:47:24;  author: cvsuser;  state: Exp;  lines: +1 -0
Fixed a bug
=============================================================================

RCS file: /u01/cvs/cvsroot/source/source_tree/Source/sql/Version.sql,v
head: 1.2663
branch:
locks: strict
access list:
keyword substitution: k
total revisions: 4798;  selected revisions: 1
description:
----------------------------
revision 1.2663
date: 2011/03/21 18:12:42;  author: cvsuser;  state: Exp;  lines: +2 -2
Version Id
=============================================================================
  CVS
end

def two_valid_cvs_entries_in_one_commit
  <<-CVS

RCS file: /u01/cvs/cvsroot/source/source_tree/Source/sql/Create.sql,v
head: 1.2024
branch:
locks: strict
access list:
keyword substitution: o
total revisions: 2072;  selected revisions: 1
description:
----------------------------
revision 1.2024
date: 2011/03/21 17:47:23;  author: cvsuser;  state: Exp;  lines: +42 -42
Fixed a bug
=============================================================================

RCS file: /u01/cvs/cvsroot/source/source_tree/Source/sql/Populate.sql,v
head: 1.1286
branch:
locks: strict
access list:
keyword substitution: o
total revisions: 1334;  selected revisions: 1
description:
----------------------------
revision 1.1286
date: 2011/03/21 17:47:24;  author: cvsuser;  state: Exp;  lines: +1 -0
Fixed a bug
=============================================================================
  CVS
end

def multiple_revisions_of_same_file_with_different_comment
      <<-CVS
RCS file: /u01/cvs/cvsroot/source/source_tree/Source/sql/Version.sql,v
head: 1.2663
branch:
locks: strict
access list:
keyword substitution: k
total revisions: 4798;  selected revisions: 1
description:
----------------------------
revision 1.2664
date: 2011/03/22 19:12:42;  author: cvsuser;  state: Exp;  lines: +2 -2
Version Id
----------------------------
revision 1.2663
date: 2011/03/21 18:12:42;  author: cvsuser;  state: Exp;  lines: +2 -2
Foo bar
=============================================================================
  CVS
end

def multiple_revisions_of_same_file_with_same_comment
      <<-CVS
RCS file: /u01/cvs/cvsroot/source/source_tree/Source/sql/Version.sql,v
head: 1.2663
branch:
locks: strict
access list:
keyword substitution: k
total revisions: 4798;  selected revisions: 1
description:
----------------------------
revision 1.2664
date: 2011/03/22 19:12:42;  author: cvsuser;  state: Exp;  lines: +2 -2
Version Id
----------------------------
revision 1.2663
date: 2011/03/21 18:12:42;  author: cvsuser;  state: Exp;  lines: +2 -2
Version Id
=============================================================================
  CVS
end