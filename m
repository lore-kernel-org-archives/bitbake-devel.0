Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 28C4471C73
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 16:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JGDC2b002520; Thu, 19 Jan 2017 16:13:30 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id l9VXglKZCTsB; Thu, 19 Jan 2017 16:13:30 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JGDQfH002781
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Jan 2017 16:13:27 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cUFL4-0000mw-E4; Thu, 19 Jan 2017 16:13:26 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2017 16:13:24 +0000
Message-Id: <1484842404-2960-5-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1484842404-2960-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1484842404-2960-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 5/5] fetch2: Avoid recursive errors
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
X-List-Received-Date: Thu, 19 Jan 2017 16:13:31 -0000

If PATH contains WORKDIR which contains PV which contains SRCPV we can end
up in circular recursion within the fetcher. This code change allows for the recursion
to be broken by giving PV a temporary dummy value in a data store copy.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d6d7850..525f47e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -819,6 +819,15 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
     if not cleanup:
         cleanup = []
 
+    # If PATH contains WORKDIR which contains PV which contains SRCPV we
+    # can end up in circular recursion here so give the option of breaking it
+    # in a data store copy.
+    try:
+        d.getVar("PV")
+    except bb.data_smart.ExpansionError:
+        d = bb.data.createCopy(d)
+        d.setVar("PV", "fetcheravoidrecurse")
+
     origenv = d.getVar("BB_ORIGENV", False)
     for var in exportvars:
         val = d.getVar(var) or (origenv and origenv.getVar(var))
-- 
2.7.4


