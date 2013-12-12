Return-Path: <olof.johansson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8CA2F6CEEA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 16:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 6C4BF11EB0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DhpMzDMHiwxC for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 4B5813F215B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 34116B4A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 2788EBE9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 24ED43E06F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Thu, 12 Dec 2013
	17:48:59 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id E8B4C9C07C; 
	Thu, 12 Dec 2013 17:48:58 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Dec 2013 17:48:55 +0100
Message-ID: <1386866938-5932-3-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
References: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [RFC 2/5] bb.fetch2.git: reuse basecmd attribute
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
X-List-Received-Date: Thu, 12 Dec 2013 16:49:01 -0000
Content-Type: text/plain

The basecmd is initialized in urldata_init; there's no need redoing that
work.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/git.py | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index c391b38..bd107db 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -152,7 +152,7 @@ class Git(FetchMethod):
             return True
         os.chdir(ud.clonedir)
         for name in ud.names:
-            if not self._contains_ref(ud.revisions[name], ud.branches[name], d):
+            if not self._contains_ref(ud, d, name):
                 return True
         if ud.write_tarballs and not os.path.exists(ud.fullmirror):
             return True
@@ -199,7 +199,7 @@ class Git(FetchMethod):
         # Update the checkout if needed
         needupdate = False
         for name in ud.names:
-            if not self._contains_ref(ud.revisions[name], ud.branches[name], d):
+            if not self._contains_ref(ud, d, name):
                 needupdate = True
         if needupdate:
             try: 
@@ -217,7 +217,7 @@ class Git(FetchMethod):
             ud.repochanged = True
         os.chdir(ud.clonedir)
         for name in ud.names:
-            if not self._contains_ref(ud.revisions[name], ud.branches[name], d):
+            if not self._contains_ref(ud, d, name):
                 raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
 
     def build_mirror_data(self, ud, d):
@@ -287,9 +287,9 @@ class Git(FetchMethod):
     def supports_srcrev(self):
         return True
 
-    def _contains_ref(self, tag, branch, d):
-        basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
-        cmd =  "%s branch --contains %s --list %s 2> /dev/null | wc -l" % (basecmd, tag, branch)
+    def _contains_ref(self, ud, d, name):
+        cmd =  "%s branch --contains %s --list %s 2> /dev/null | wc -l" % (
+            ud.basecmd, ud.revisions[name], ud.branches[name])
         try:
             output = runfetchcmd(cmd, d, quiet=True)
         except bb.fetch2.FetchError:
@@ -313,9 +313,8 @@ class Git(FetchMethod):
         else:
             username = ""
 
-        basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
         cmd = "%s ls-remote %s://%s%s%s %s" % \
-              (basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name])
+              (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name])
         if ud.proto.lower() != 'file':
             bb.fetch2.check_network_access(d, cmd)
         output = runfetchcmd(cmd, d, True)
-- 
1.8.4.rc3


