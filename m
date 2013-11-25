Return-Path: <peter.kjellerstedt@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id C38696DB86
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 11:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 2243B3C26D1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 12:41:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OfD+RQqnNz3q for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 12:41:18 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id D6E263C26C6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 12:41:17 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id C0FA8AFA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 12:41:17 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id B5E989E5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 12:41:17 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id B1CED3404E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 12:41:17 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id rAPBfHCM019884
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 12:41:17 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id rAPBfHpK019883
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Nov 2013 12:41:17 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Nov 2013 12:41:16 +0100
Message-Id: <1385379676-19838-1-git-send-email-pkj@axis.com>
X-Mailer: git-send-email 1.8.4
Subject: [PATCH] fetch2: Correct a few calls to latest_revision()
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
X-List-Received-Date: Mon, 25 Nov 2013 11:41:19 -0000

In 6a48474de9505a3700863f31839a7c53c5e18a8d the url parameter to a
number of functions was removed. However, not all calls to
latest_revision() were fixed...

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 lib/bb/fetch2/bzr.py | 2 +-
 lib/bb/fetch2/git.py | 2 +-
 lib/bb/fetch2/hg.py  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index 3caaa6f..03e9ac4 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -48,7 +48,7 @@ class Bzr(FetchMethod):
         ud.setup_revisons(d)
 
         if not ud.revision:
-            ud.revision = self.latest_revision(ud.url, ud, d)
+            ud.revision = self.latest_revision(ud, d)
 
         ud.localfile = data.expand('bzr_%s_%s_%s.tar.gz' % (ud.host, ud.path.replace('/', '.'), ud.revision), d)
 
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b236631..a9470e4 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -125,7 +125,7 @@ class Git(FetchMethod):
             if not ud.revisions[name] or len(ud.revisions[name]) != 40  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
                 if ud.revisions[name]:
                     ud.branches[name] = ud.revisions[name]
-                ud.revisions[name] = self.latest_revision(ud.url, ud, d, name)
+                ud.revisions[name] = self.latest_revision(ud, d, name)
 
         gitsrcname = '%s%s' % (ud.host.replace(':','.'), ud.path.replace('/', '.').replace('*', '.'))
         # for rebaseable git repo, it is necessary to keep mirror tar ball
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 76810ab..6927f61 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -62,7 +62,7 @@ class Hg(FetchMethod):
         if 'rev' in ud.parm:
             ud.revision = ud.parm['rev']
         elif not ud.revision:
-            ud.revision = self.latest_revision(ud.url, ud, d)
+            ud.revision = self.latest_revision(ud, d)
 
         ud.localfile = data.expand('%s_%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision), d)
 
-- 
1.8.4


