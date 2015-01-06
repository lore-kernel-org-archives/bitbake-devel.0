Return-Path: <fredrik.svensson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 69A6F65D19
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Jan 2015 08:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id AB032180A9;
	Tue,  6 Jan 2015 09:30:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 3pPTcVrax3N2; Tue,  6 Jan 2015 09:30:17 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 39937180AB;
	Tue,  6 Jan 2015 09:30:17 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 22EE810AE;
	Tue,  6 Jan 2015 09:30:17 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 17CF9109B;
	Tue,  6 Jan 2015 09:30:17 +0100 (CET)
Received: from vb-lnxfredriks1.se.axis.com (unknown [10.14.208.6])
	by seth.se.axis.com (Postfix) with ESMTP id 9FE283E236;
	Tue,  6 Jan 2015 09:30:16 +0100 (CET)
Received: by vb-lnxfredriks1.se.axis.com (Postfix, from userid 272)
	id 48B541EA; Tue,  6 Jan 2015 10:30:15 +0200 (SAST)
From: Fredrik Svensson <fredrik.svensson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Jan 2015 10:30:11 +0200
Message-Id: <1420533011-16384-1-git-send-email-fredrik.svensson@axis.com>
X-Mailer: git-send-email 1.7.10.4
Cc: Fredrik Svensson <fredriks@axis.com>, akuster808@gmail.com
Subject: [1.24][PATCH] fetch2/git: Allow other namespaces than refs/heads to be searched.
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
X-List-Received-Date: Tue, 06 Jan 2015 08:30:32 -0000

This makes it possble to fetch Gerrit review references which are
normally stored under refs/changes.

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


