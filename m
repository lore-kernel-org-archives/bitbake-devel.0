Return-Path: <olof.johansson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8F57D6E37B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 16:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 4A5643F2158
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0N-zeqoA23d1 for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 3282411EB0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 13597BE8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 0825EB4A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 06B8034055
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Dec 2013 17:48:59 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Thu, 12 Dec 2013
	17:48:58 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id D825F9C075; 
	Thu, 12 Dec 2013 17:48:58 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Dec 2013 17:48:54 +0100
Message-ID: <1386866938-5932-2-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.4.rc3
In-Reply-To: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
References: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [RFC 1/5] fetch2/git: Improve handling of unresolved names verses branches
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

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 00a459d..c391b38 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -106,6 +106,7 @@ class Git(FetchMethod):
         if ud.bareclone:
             ud.nocheckout = 1
   
+        ud.unresolvedrev = {}
         branches = ud.parm.get("branch", "master").split(',')
         if len(branches) != len(ud.names):
             raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
@@ -113,6 +114,7 @@ class Git(FetchMethod):
         for name in ud.names:
             branch = branches[ud.names.index(name)]
             ud.branches[name] = branch
+            ud.unresolvedrev[name] = branch
 
         ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
 
@@ -124,7 +126,7 @@ class Git(FetchMethod):
             # Ensure anything that doesn't look like a sha256 checksum/revision is translated into one
             if not ud.revisions[name] or len(ud.revisions[name]) != 40  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
                 if ud.revisions[name]:
-                    ud.branches[name] = ud.revisions[name]
+                    ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
         gitsrcname = '%s%s' % (ud.host.replace(':','.'), ud.path.replace('/', '.').replace('*', '.'))
@@ -300,7 +302,7 @@ class Git(FetchMethod):
         """
         Return a unique key for the url
         """
-        return "git:" + ud.host + ud.path.replace('/', '.') + ud.branches[name]
+        return "git:" + ud.host + ud.path.replace('/', '.') + ud.unresolvedrev[name]
 
     def _latest_revision(self, ud, d, name):
         """
@@ -313,7 +315,7 @@ class Git(FetchMethod):
 
         basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
         cmd = "%s ls-remote %s://%s%s%s %s" % \
-              (basecmd, ud.proto, username, ud.host, ud.path, ud.branches[name])
+              (basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name])
         if ud.proto.lower() != 'file':
             bb.fetch2.check_network_access(d, cmd)
         output = runfetchcmd(cmd, d, True)
-- 
1.8.4.rc3


