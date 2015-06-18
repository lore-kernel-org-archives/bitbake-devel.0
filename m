Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id ED51073306;
	Thu, 18 Jun 2015 14:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5IEHhMr027850; Thu, 18 Jun 2015 15:17:43 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PIgW0ms89NVd; Thu, 18 Jun 2015 15:17:43 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5IEHSK7027844
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Jun 2015 15:17:39 +0100
Message-ID: <1434637048.14710.99.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 18 Jun 2015 15:17:28 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: openembedded-core <openembedded-core@lists.openembedded.org>
Subject: [RFC PATCH] data_smart: Drop expand parameter default
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
X-List-Received-Date: Thu, 18 Jun 2015 14:17:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Rather than just d.getVar(X), force the use of the more explict d.getVar(X, False)
since at some point in the future, having the default of expansion would
be nice. This is the first step towards that.

Layers can update to this calling convention with a command along the lines of:

sed -e 's:\(getVar([^,()]*\)\s*):\1, False):g' -i `grep -ril getVar *`

Patches for OE-Core and Bitbake are on the mailing lists. Its an open question
whether we want to do this, on what timescale and whether we do the same
with getVarFLag at the same time?

Paul confirmed that other layers don't have too many of these unexpanded
getVar calls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 9384ffd..1316671 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -516,7 +516,7 @@ class DataSmart(MutableMapping):
                 if len(shortvar) == 0:
                     override = None
 
-    def getVar(self, var, expand=False, noweakdefault=False, parsing=False):
+    def getVar(self, var, expand, noweakdefault=False, parsing=False):
         return self.getVarFlag(var, "_content", expand, noweakdefault, parsing)
 
     def _clearOverrides(self, key):



