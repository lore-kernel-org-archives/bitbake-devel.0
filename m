Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5636E75E05
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMv5026633; Wed, 8 Jul 2015 15:59:25 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZDOEltaWUGOT; Wed,  8 Jul 2015 15:59:25 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMpr026605
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:23 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqof-0004Si-Mt; Wed, 08 Jul 2015 15:59:17 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:59:02 +0100
Message-Id: <c43bf9cc38287f7aedc498c716fc7eb2a8b44199.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 08/16] data_smart: VariableHistory: Ignore override duplicates and overlap with CoW functions
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:27 -0000

Trying to look up a variable called 'copy' in COW is problematic due
to internal implmentation details, at least avoid tracebacks from this.

Also don't duplicate override history (which is an atrifact of changed
override behviour) as otherwise the bitbake -e output is convoluted.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 68efc7b..d414bf4 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -231,6 +231,10 @@ class VariableHistory(object):
 
         if var not in self.variables:
             self.variables[var] = []
+        if not isinstance(self.variables[var], list):
+            return
+        if 'nodups' in loginfo and loginfo in self.variables[var]:
+            return
         self.variables[var].append(loginfo.copy())
 
     def variable(self, var):
@@ -460,6 +464,7 @@ class DataSmart(MutableMapping):
                 loginfo = event.copy()
                 loginfo['variable'] = shortvar
                 loginfo['op'] = 'override[%s]:%s' % (override, loginfo['op'])
+                loginfo['nodups'] = True
                 self.varhistory.record(**loginfo)
 
             override = None
-- 
2.1.0


