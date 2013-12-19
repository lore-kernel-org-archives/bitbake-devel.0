Return-Path: <olof.johansson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5FA7A60DFD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 14:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 771EA11E00
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 15:16:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5LSGa5fqLtJ3 for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 15:16:32 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 55D433F2169
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 15:16:29 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 39B56B67
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 15:16:29 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 2E28EB65
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 15:16:29 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 2C6F634065
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 15:16:29 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Thu, 19 Dec 2013
	15:16:29 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id F02379C079; 
	Thu, 19 Dec 2013 15:16:28 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 19 Dec 2013 15:16:28 +0100
Message-ID: <1387462588-26060-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.4.rc3
MIME-Version: 1.0
Subject: [PATCH] bb.fetch2.git: support resolving both tags and branches
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
X-List-Received-Date: Thu, 19 Dec 2013 14:16:37 -0000
Content-Type: text/plain

Before this change, the resolution of a git reference to a commit sha1,
was done in a way that was prone to bogus matches. Looking for a tag
R1.2.3 would potentially get the SHA1 of a branch ending in R1.2.3, like
refs/heads/foo/bar/R1.2.3, instead of refs/tags/R1.2.3.

But since tags and branches are used somewhat ambiguously, we will fall
back to resolve it as a branch with that exact name, if no tag with the
exact name was found.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>

---
This patch was originally included in a patch series with unit
tests as well. There is some more work needed for the unittests
though. I will resubmit the unittest changes when this has been
merged, and the review comments has been resolved.

---
 lib/bb/fetch2/git.py | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index bd107db..6ba52b1 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -304,23 +304,58 @@ class Git(FetchMethod):
         """
         return "git:" + ud.host + ud.path.replace('/', '.') + ud.unresolvedrev[name]
 
-    def _latest_revision(self, ud, d, name):
+    def _gen_git_url(self, ud, d):
         """
-        Compute the HEAD revision for the url
+        Based on the FetchData object, return a valid remote url that
+        you can pass to git.
         """
         if ud.user:
             username = ud.user + '@'
         else:
             username = ""
 
-        cmd = "%s ls-remote %s://%s%s%s %s" % \
-              (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name])
+        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+
+    def _resolve_ref(self, ud, d, ref):
+        """
+        Try to resolve a reference using git ls-remote. We assume the
+        reference is fully qualified, or otherwise can be uniquely
+        resolved. Will return the commit sha1 of the reference.
+
+        If more than one line of output is returned, we'll raise an
+        FetchError exception. Same if no output is returned.
+        """
+        url = self._gen_git_url(ud, d)
+        cmd = "%s ls-remote %s %s" % (ud.basecmd, url, ref)
+
         if ud.proto.lower() != 'file':
             bb.fetch2.check_network_access(d, cmd)
+
         output = runfetchcmd(cmd, d, True)
         if not output:
-            raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
-        return output.split()[0]
+            raise bb.fetch2.FetchError(
+                "The command %s gave empty output unexpectedly" % cmd, ud.url)
+
+        output = output.split()
+        if len(output) > 2:
+            raise bb.fetch2.FetchError(
+                "The command %s gave more than one result" % cmd, ud.url)
+
+        return output[0]
+
+    def _latest_revision(self, ud, d, name):
+        """
+        Compute the HEAD revision for the url. The reference is first
+        tried as refs/tags/<ref>^{}, which should return a sha1 of the
+        commit object pointed to by the tag. If nothing is found, we'll
+        try to resolve it as refs/heads/<tag> instead.
+        """
+        ref = ud.unresolvedrev[name]
+
+        try:
+            return self._resolve_ref(ud, d, "refs/tags/%s^{}" % ref)
+        except:
+            return self._resolve_ref(ud, d, "refs/heads/%s" % ref)
 
     def _build_revision(self, ud, d, name):
         return ud.revisions[name]
-- 
1.8.4.rc3


