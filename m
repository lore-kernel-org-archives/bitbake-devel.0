Return-Path: <kergoth@gmail.com>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
	[209.85.160.44])
	by mail.openembedded.org (Postfix) with ESMTP id 477AF65E3D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 15:27:37 +0000 (UTC)
Received: by mail-pb0-f44.google.com with SMTP id jt11so4246928pbb.31
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id;
	bh=tuuCCe15ybYfN9dDZ8jORSA7I3zv/t7vzPHO6/pIWho=;
	b=bpK3DMDRO5GULf+3PoTysLlG8kdha6EiQcWVkxwMaz1dm+SDcVel6S8ELoM9ECVi1R
	APeyobGqHA0Sw3h4zrGHU0A1F8sVZ+OLlVGWGJFjbFQnCobgPr9swW+zPDDhjUtAP2Ln
	sGM3A8YcTPbB9WEYm2Ty/nA3Pf/O/RrT5eb+5pg01B5fAto3yqaWEX0mbDsk+8DpMEaZ
	3tV0JoE7z6zs7tze7V7OYyM/k4wQfznu72q4HYXziNK5DHCiIVNEMa885bYzPpKslG/Q
	HSd//jlIVwoRtvAG1M+WnW8KaKtqw588amlz2/hprObXRzkTWTUcd2whVcDvqtp45Xqt
	Qksg==
X-Received: by 10.66.250.161 with SMTP id zd1mr4631663pac.136.1398698858815;
	Mon, 28 Apr 2014 08:27:38 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPSA id
	ov4sm35707889pbc.46.2014.04.28.08.27.36
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 28 Apr 2014 08:27:37 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Apr 2014 08:27:34 -0700
Message-Id: <1398698854-15713-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Subject: [PATCH] codeparser: don't interact with the cache for subshells
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 28 Apr 2014 15:27:40 -0000

Doing so was causing leakage between the execs of the main value and that of
the subshell value, and was causing the cached subshell value to be used for
the overall variable. At the least this could cause execs contamination
between two variables that while differing, run the same subshell. Beyond
that, it's possible we could have been using an incomplete cached value of
a subshell for that of the main value.

Before this, bb_codeparser.dat would change between parses with differing
bbfile parse order. After, it does not change.

The codeparser cache version is bumped, to ensure we don't use potentially
incorrect cached values from previous runs.

This should hopefully resolve the difficult-to-reproduce issues we've seen at
Mentor Graphics where bitbake emits a script to run a task and misses
dependent functions, resulting in 'command not found' failures. This issue has
also been mentioned on the oe devel list, where someone hit a case where
oe_runmake was missing from a do_install task (IIRC). Adding debug information
showed that bitbake's information about the variable dependencies for this
task is inaccurate in the failure cases.

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/codeparser.py | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index a50b9f2..de8d2eb 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -35,7 +35,7 @@ def check_indent(codestr):
 
 class CodeParserCache(MultiProcessCache):
     cache_file_name = "bb_codeparser.dat"
-    CACHE_VERSION = 4
+    CACHE_VERSION = 5
 
     def __init__(self):
         MultiProcessCache.__init__(self)
@@ -217,6 +217,15 @@ class ShellParser():
             self.execs = codeparsercache.shellcacheextras[h]["execs"]
             return self.execs
 
+        self._parse_shell(value)
+        self.execs = set(cmd for cmd in self.allexecs if cmd not in self.funcdefs)
+
+        codeparsercache.shellcacheextras[h] = {}
+        codeparsercache.shellcacheextras[h]["execs"] = self.execs
+
+        return self.execs
+
+    def _parse_shell(self, value):
         try:
             tokens, _ = pyshyacc.parse(value, eof=True, debug=False)
         except pyshlex.NeedMore:
@@ -224,12 +233,6 @@ class ShellParser():
 
         for token in tokens:
             self.process_tokens(token)
-        self.execs = set(cmd for cmd in self.allexecs if cmd not in self.funcdefs)
-
-        codeparsercache.shellcacheextras[h] = {}
-        codeparsercache.shellcacheextras[h]["execs"] = self.execs
-
-        return self.execs
 
     def process_tokens(self, tokens):
         """Process a supplied portion of the syntax tree as returned by
@@ -303,7 +306,7 @@ class ShellParser():
 
                 if part[0] in ('`', '$('):
                     command = pyshlex.wordtree_as_string(part[1:-1])
-                    self.parse_shell(command)
+                    self._parse_shell(command)
 
                     if word[0] in ("cmd_name", "cmd_word"):
                         if word in words:
@@ -322,7 +325,7 @@ class ShellParser():
                     self.log.debug(1, self.unhandled_template % cmd)
                 elif cmd == "eval":
                     command = " ".join(word for _, word in words[1:])
-                    self.parse_shell(command)
+                    self._parse_shell(command)
                 else:
                     self.allexecs.add(cmd)
                 break
-- 
1.8.3.4


