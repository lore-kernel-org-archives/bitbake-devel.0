Return-Path: <fredrik.svensson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id C0A9360557
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 14:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 07A451807C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 15:54:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 5G0KLbMAW5Mm for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 15:53:55 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 8EFEE18075
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 15:53:55 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 77B92D21
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 15:53:55 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 6C6DF83E
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 15:53:55 +0100 (CET)
Received: from lnxfredriks.se.axis.com (lnxfredriks.se.axis.com [10.94.158.6])
	by thoth.se.axis.com (Postfix) with ESMTP id 699763404C;
	Mon,  3 Nov 2014 15:53:55 +0100 (CET)
Received: by lnxfredriks.se.axis.com (Postfix, from userid 272)
	id 604CCC069; Mon,  3 Nov 2014 15:53:55 +0100 (CET)
From: Fredrik Svensson <fredrik.svensson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Nov 2014 15:53:52 +0100
Message-Id: <1415026432-19227-1-git-send-email-fredrik.svensson@axis.com>
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
X-List-Received-Date: Mon, 03 Nov 2014 14:54:10 -0000

This makes it possble to fetch Gerrit review references which are
normally stored under refs/changes.

Signed-off-by: Fredrik Svensson <fredrik.svensson@axis.com>
---
 lib/bb/fetch2/git.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 799fb6c..7d9fe7e 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -339,7 +339,10 @@ class Git(FetchMethod):
         """
         Compute the HEAD revision for the url
         """
-        search = "refs/heads/%s refs/tags/%s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
+        if ud.unresolvedrev[name][:5] == "refs/":
+            search = "%s^{}" % ud.unresolvedrev[name]
+        else:
+            search = "refs/heads/%s refs/tags/%s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
         output = self._lsremote(ud, d, search)
         return output.split()[0]
 
-- 
1.7.10.4


