Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RRPR5-0002P1-HY
	for bitbake-devel@lists.openembedded.org;
	Fri, 18 Nov 2011 15:29:01 +0100
Received: by opal (Postfix, from userid 111)
	id A94781032F; Fri, 18 Nov 2011 14:24:15 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111118142415.A94781032F@opal>
Date: Fri, 18 Nov 2011 14:24:15 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : parse_py: Use absolute paths for FILE
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 18 Nov 2011 14:29:01 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 658d7daa70e46c2b20973b90ee53f0bbadc8bf5d
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=658d7daa70e46c2b20973b90ee53f0bbadc8bf5d

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Fri Nov 18 14:21:15 2011 +0000

parse_py: Use absolute paths for FILE

Its possible for relative paths to creep into FILE. These confuse the
build system no end as its not clear where they might be releative to.

This patch ensures we always use resolved absolute paths for FILE
so that things behave in a deterministic way.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/parse/parse_py/BBHandler.py   |    2 +-
 lib/bb/parse/parse_py/ConfHandler.py |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 851a7e6..8c1bd60 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -148,7 +148,7 @@ def handle(fn, d, include):
 
     # DONE WITH PARSING... time to evaluate
     if ext != ".bbclass":
-        data.setVar('FILE', fn, d)
+        data.setVar('FILE', abs_fn, d)
 
     statements.eval(d)
 
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 102c0e9..e168d24 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -102,7 +102,7 @@ def handle(fn, data, include):
         feeder(lineno, s, fn, statements)
 
     # DONE WITH PARSING... time to evaluate
-    bb.data.setVar('FILE', fn, data)
+    bb.data.setVar('FILE', abs_fn, data)
     statements.eval(data)
     if oldfile:
         bb.data.setVar('FILE', oldfile, data)



