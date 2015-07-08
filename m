Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9839575DE6
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExO8Q026688; Wed, 8 Jul 2015 15:59:26 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cMsf5zlp8j1c; Wed,  8 Jul 2015 15:59:26 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExNUH026612
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:24 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqog-0004TH-9Z; Wed, 08 Jul 2015 15:59:18 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:59:09 +0100
Message-Id: <07a601a363dfcb06792d1329e08fe0158690889c.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 15/16] data_smart: Fix appendVar/prependVar
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:28 -0000

Now that overrides get expanded 'on the fly', change appendVar
and prependVar to work using _append and _prepend, else we'd have
to re-implement pieces of getVar and the timing of expansions
becomes problematic.

Using _append/_prepend equivalence gives the behaviour users likley
expect from these functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index b7ccab7..7755f1a 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -540,14 +540,12 @@ class DataSmart(MutableMapping):
     def appendVar(self, var, value, **loginfo):
         loginfo['op'] = 'append'
         self.varhistory.record(**loginfo)
-        newvalue = (self.getVar(var, False) or "") + value
-        self.setVar(var, newvalue, ignore=True)
+        self.setVar(var + "_append", value, ignore=True, parsing=True)
 
     def prependVar(self, var, value, **loginfo):
         loginfo['op'] = 'prepend'
         self.varhistory.record(**loginfo)
-        newvalue = value + (self.getVar(var, False) or "")
-        self.setVar(var, newvalue, ignore=True)
+        self.setVar(var + "_prepend", value, ignore=True, parsing=True)
 
     def delVar(self, var, **loginfo):
         loginfo['detail'] = ""
-- 
2.1.0


