Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 6012E6D8F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2013 17:17:29 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAIHHOTg010615 for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2013 17:17:25 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DvVFntMSeX48 for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2013 17:17:24 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAIHHKt1010608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2013 17:17:21 GMT
Message-ID: <1384795036.6460.247.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 Nov 2013 17:17:16 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] git: Use merge-base instead of log for testing if a commit is present
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
X-List-Received-Date: Mon, 18 Nov 2013 17:17:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The current use of git log to check if a given revision is present can be
a little fragile.

For example if revision X was on branch A, and then later added to branch
B, the update checks would not notice this since they just check for X
being in the repository.

We also had some autobuilder corruption where an older packed-refs file
was copied over a new repository containing newer pack files. There
was no update to the refs file since the revision was present but
not accessible in any branch.

The correct fix is to check that the required revisions are present
on the specific branches. This patch does this using merge-base.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 6175e4c..99230c1 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -150,7 +150,7 @@ class Git(FetchMethod):
             return True
         os.chdir(ud.clonedir)
         for name in ud.names:
-            if not self._contains_ref(ud.revisions[name], d):
+            if not self._contains_ref(ud.revisions[name], ud.branches[name], d):
                 return True
         if ud.write_tarballs and not os.path.exists(ud.fullmirror):
             return True
@@ -197,7 +197,7 @@ class Git(FetchMethod):
         # Update the checkout if needed
         needupdate = False
         for name in ud.names:
-            if not self._contains_ref(ud.revisions[name], d):
+            if not self._contains_ref(ud.revisions[name], ud.branches[name], d):
                 needupdate = True
         if needupdate:
             try: 
@@ -281,13 +281,14 @@ class Git(FetchMethod):
     def supports_srcrev(self):
         return True
 
-    def _contains_ref(self, tag, d):
+    def _contains_ref(self, tag, branch, d):
         basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
-        cmd = "%s log --pretty=oneline -n 1 %s -- 2> /dev/null | wc -l" % (basecmd, tag)
-        output = runfetchcmd(cmd, d, quiet=True)
-        if len(output.split()) > 1:
-            raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
-        return output.split()[0] != "0"
+        cmd = "%s merge-base --is-ancestorlog %s %s" % (basecmd, tag, branch)
+        try:
+            output = runfetchcmd(cmd, d, quiet=True)
+        except bb.fetch2.FetchError:
+            return False
+        return True
 
     def _revision_key(self, url, ud, d, name):
         """



