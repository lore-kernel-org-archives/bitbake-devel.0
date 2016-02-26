Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 93FAF7742C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QHtPwq009294 for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:55:25 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IVGScg1rWSSF for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:55:25 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QHtKIc009290
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:55:21 GMT
Message-ID: <1456509320.11498.105.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 26 Feb 2016 17:55:20 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] providers: Fix PREFERRED_VERSION lookup for '_' in PN
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
X-List-Received-Date: Fri, 26 Feb 2016 17:55:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

PN can contain '_', e.g. gcc-cross-x86_64 and an override cannot 
hence we do this manually rather than use OVERRIDES.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 68c8d59..ffa532c 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -121,11 +121,14 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
     preferred_file = None
     preferred_ver = None
 
-    localdata = data.createCopy(cfgData)
-    localdata.setVar('OVERRIDES', "%s:pn-%s:%s" % (data.getVar('OVERRIDES', localdata), pn, pn))
-    bb.data.update_data(localdata)
+    # pn can contain '_', e.g. gcc-cross-x86_64 and an override cannot
+    # hence we do this manually rather than use OVERRIDES
+    preferred_v = cfgData.getVar("PREFERRED_VERSION_pn-%s" % pn, True)
+    if not preferred_v:
+        preferred_v = cfgData.getVar("PREFERRED_VERSION_%s" % pn, True)
+    if not preferred_v:
+        preferred_v = cfgData.getVar("PREFERRED_VERSION", True)
 
-    preferred_v = localdata.getVar('PREFERRED_VERSION', True)
     if preferred_v:
         m = re.match('(\d+:)*(.*)(_.*)*', preferred_v)
         if m:



