Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1DF61731F7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Aug 2016 10:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7VAYOhG016474 for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Aug 2016 11:34:24 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id F8HMw7npWvl0 for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Aug 2016 11:34:24 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7VAYNDo016470
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Aug 2016 11:34:24 +0100
Message-ID: <1472639663.29583.72.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 31 Aug 2016 11:34:23 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Handle multiconfig fetcher issues
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
X-List-Received-Date: Wed, 31 Aug 2016 10:34:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We need a separate fetcher cache per multiconfig as the revisions and other 
SRC_URI data can potentially be different. For now, this is the simplest way 
to achieve that and avoids linux-yocto kernel build failures when targeting
multiple machines for example.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 65c426f..11c75cc 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1506,8 +1506,9 @@ class Fetch(object):
         self.connection_cache = connection_cache
 
         fn = d.getVar('FILE', True)
-        if cache and fn and fn in urldata_cache:
-            self.ud = urldata_cache[fn]
+        mc = d.getVar('__BBMULTICONFIG', True) or ""
+        if cache and fn and mc + fn in urldata_cache:
+            self.ud = urldata_cache[mc + fn]
 
         for url in urls:
             if url not in self.ud:
@@ -1519,7 +1520,7 @@ class Fetch(object):
                         pass
 
         if fn and cache:
-            urldata_cache[fn] = self.ud
+            urldata_cache[mc + fn] = self.ud
 
     def localpath(self, url):
         if url not in self.urls:



