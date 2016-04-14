Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5E88273195
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 13:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3EDU9hE012747 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 14:30:09 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FG0xs0rO2bJY for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 14:30:09 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3EDU4Hh012718
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Apr 2016 14:30:05 +0100
Message-ID: <1460640604.9308.173.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Apr 2016 14:30:04 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] providers: We don't depend on previous build results
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
X-List-Received-Date: Thu, 14 Apr 2016 13:30:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Back in history the code did depend on previous build results. This was
bad for determinism and we no longer do that. Update comments to match
the current behaviour.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index ffa532c..8195d62 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -226,7 +226,7 @@ def findBestProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
 def _filterProviders(providers, item, cfgData, dataCache):
     """
     Take a list of providers and filter/reorder according to the
-    environment variables and previous build results
+    environment variables
     """
     eligible = []
     preferred_versions = {}
@@ -283,7 +283,7 @@ def _filterProviders(providers, item, cfgData, dataCache):
 def filterProviders(providers, item, cfgData, dataCache):
     """
     Take a list of providers and filter/reorder according to the
-    environment variables and previous build results
+    environment variables
     Takes a "normal" target item
     """
 
@@ -311,7 +311,7 @@ def filterProviders(providers, item, cfgData, dataCache):
 def filterProvidersRunTime(providers, item, cfgData, dataCache):
     """
     Take a list of providers and filter/reorder according to the
-    environment variables and previous build results
+    environment variables
     Takes a "runtime" target item
     """
 



