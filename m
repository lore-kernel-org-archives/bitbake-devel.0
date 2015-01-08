Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 41ECF609B2
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 20:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t08KvMBr022708
	for <bitbake-devel@lists.openembedded.org>; Thu, 8 Jan 2015 20:57:22 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ivBKokVDYg9k for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 20:57:22 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t08Kv8mi022696
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 8 Jan 2015 20:57:20 GMT
Message-ID: <1420750665.25779.90.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 08 Jan 2015 20:57:45 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch/git: Improve ls-remote handling for latest_revision
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
X-List-Received-Date: Thu, 08 Jan 2015 20:58:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently the code ignores lightweight tags which has caused some user
complaints. We can't put the right search list in place easily since
the results don't come back in a good order, head happens to sort
before tags.

In the end I refactored the function so we get the complete list of
remotes and then we can filter it ourselves in the order we chose,
including checking for light weight tags, preferring the proper ones.

Hopefully this resolves the issues people have been seeing.

[YOCTO #6881]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index f771fd0..44fc271 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -340,12 +340,19 @@ class Git(FetchMethod):
         """
         Compute the HEAD revision for the url
         """
+        output = self._lsremote(ud, d, "")
+        # Tags of the form ^{} may not work, need to fallback to other form
         if ud.unresolvedrev[name][:5] == "refs/":
-            search = "%s %s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
+            head = ud.unresolvedrev[name]
+            tag = ud.unresolvedrev[name]
         else:
-            search = "refs/heads/%s refs/tags/%s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
-        output = self._lsremote(ud, d, search)
-        return output.split()[0]
+            head = "refs/heads/%s" % ud.unresolvedrev[name]
+            tag = "refs/tags/%s" % ud.unresolvedrev[name]
+        for s in [head, tag + "^{}", tag]:
+            for l in output.split('\n'):
+                if s in l:
+                    return l.split()[0]
+        raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output" % ud.unresolvedrev[name])
 
     def latest_versionstring(self, ud, d):
         """



