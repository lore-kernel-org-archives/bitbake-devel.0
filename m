Return-Path: <fredrik.svensson@axis.com>
X-Greylist: delayed 461 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 04 Nov 2014 11:37:21 UTC
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id A5C7265DEB
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 11:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 6470F2E40D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 12:29:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id vUgX-2zXai0w for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 12:29:35 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id E60D82E40E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 12:29:34 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id CBB20C94
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 12:29:34 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id BE087C6C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 12:29:34 +0100 (CET)
Received: from lnxfredriks.se.axis.com (lnxfredriks.se.axis.com [10.94.158.6])
	by seth.se.axis.com (Postfix) with ESMTP id BB2DE166001;
	Tue,  4 Nov 2014 12:29:34 +0100 (CET)
Received: by lnxfredriks.se.axis.com (Postfix, from userid 272)
	id B134EC069; Tue,  4 Nov 2014 12:29:34 +0100 (CET)
From: Fredrik Svensson <fredrik.svensson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Nov 2014 12:29:32 +0100
Message-Id: <1415100572-2314-1-git-send-email-fredrik.svensson@axis.com>
X-Mailer: git-send-email 1.7.10.4
Cc: Fredrik Svensson <fredriks@axis.com>
Subject: [PATCH] fetch2/git: Allow other namespaces than refs/heads to be searched.
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
X-List-Received-Date: Tue, 04 Nov 2014 11:37:27 -0000

This makes it possble to fetch Gerrit review references which are
normally stored under refs/changes.

Please disregard previous patch with the same topic.

Signed-off-by: Fredrik Svensson <fredrik.svensson@axis.com>
---
 lib/bb/fetch2/git.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 799fb6c..66a77a8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -339,7 +339,10 @@ class Git(FetchMethod):
         """
         Compute the HEAD revision for the url
         """
-        search = "refs/heads/%s refs/tags/%s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
+        if ud.unresolvedrev[name][:5] == "refs/":
+            search = "%s %s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
+        else:
+            search = "refs/heads/%s refs/tags/%s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
         output = self._lsremote(ud, d, search)
         return output.split()[0]
 
-- 
1.7.10.4


