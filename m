Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id BCBB56C52B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Dec 2018 01:49:28 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB41n92I008369
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 3 Dec 2018 17:49:20 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Mon, 3 Dec 2018 17:48:59 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 4 Dec 2018 10:06:03 +0800
Message-ID: <91a1144cb2cc61e8d898be9f4fdbdce0ab8f5393.1543889029.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543889029.git.liezhi.yang@windriver.com>
References: <cover.1543889029.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 4/4] bitbake: pysh: Improve error handling for shell code
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
X-List-Received-Date: Tue, 04 Dec 2018 01:49:28 -0000
Content-Type: text/plain

The p_error() is used for printing errors when parse shell code, but it can't
the EOF error correctly

- Add the following lines to quilt.inc
  do_configure_prepend () {
      find ${s} -name "*.in" -exec sed -i -e "1s,^#\!.*@perl@ -w$,#\! @perl@\nuse warnings;," {} \;
      if [ hello ]; then
  }

- Before the patch:
  $ rm -fr cache/ tmp/cache/; bitbake -p
  [snip]
  WARNING: /path/to/quilt/quilt-native_0.65.bb: Error during finalise of /path/to/quilt/quilt-native_0.65.bb
  [snip]
  bb.pysh.sherrors.ShellSyntaxError: None
  followed by:

  We can see that this isn't easy to debug, let p_error() check wheter it is EOF
  and print appropriate errors can improve the error message. And don't let
  codeparser.py except pyshlex.NeedMore (in fact, it never worked since p_error()
  only raise ShellSyntaxError), but make it print the last 5 lines which might be
  useful for debuging.

- After the patch
  $ rm -fr cache/ tmp/cache/; bitbake -p
  [snip]
  ERROR: /path/to/quilt/quilt_0.65.bb: Error during parse shell code, the last 5 lines are:
      find /path/to/quilt/0.65-r0/quilt-0.65 -name "*.in" -exec sed -i -e "1s,^#\!.*@PERL@ -w$,#\! @PERL@\nuse warnings;," {} \;
      if [ hello ]; then
      autotools_do_configure
      sed -e 's,^COMPAT_SYMLINKS.*:=.*,COMPAT_SYMLINKS    :=,' -i /path/to/quilt/0.65-r0/quilt-0.65/Makefile
  [snip]
    File "/path/to/bb/pysh/pyshyacc.py", line 649, in p_error(p=None):
               w('Unexpected EOF')
      >    raise sherrors.ShellSyntaxError(''.join(msg))

  bb.pysh.sherrors.ShellSyntaxError: Unexpected EOF

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/codeparser.py    |  5 +++--
 bitbake/lib/bb/pysh/pyshyacc.py | 17 ++++++++++-------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index ddd1b97..3f8ac1d 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -368,8 +368,9 @@ class ShellParser():
     def _parse_shell(self, value):
         try:
             tokens, _ = pyshyacc.parse(value, eof=True, debug=False)
-        except pyshlex.NeedMore:
-            raise sherrors.ShellSyntaxError("Unexpected EOF")
+        except Exception:
+            bb.error('Error during parse shell code, the last 5 lines are:\n%s' % '\n'.join(value.split('\n')[-5:]))
+            raise
 
         self.process_tokens(tokens)
 
diff --git a/bitbake/lib/bb/pysh/pyshyacc.py b/bitbake/lib/bb/pysh/pyshyacc.py
index ba4cefd..de565dc 100644
--- a/bitbake/lib/bb/pysh/pyshyacc.py
+++ b/bitbake/lib/bb/pysh/pyshyacc.py
@@ -636,13 +636,16 @@ def p_empty(p):
 def p_error(p):
     msg = []
     w = msg.append
-    w('%r\n' % p)
-    w('followed by:\n')
-    for i in range(5):
-        n = yacc.token()
-        if not n:
-            break
-        w('  %r\n' % n)
+    if p:
+        w('%r\n' % p)
+        w('followed by:\n')
+        for i in range(5):
+            n = yacc.token()
+            if not n:
+                break
+            w('  %r\n' % n)
+    else:
+        w('Unexpected EOF')
     raise sherrors.ShellSyntaxError(''.join(msg))
 
 # Build the parser
-- 
2.7.4


