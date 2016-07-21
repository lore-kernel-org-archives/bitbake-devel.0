Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D716265CBF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 16:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6LGPODt023900 for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 17:25:24 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id E-SUuQsOrvlw for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 17:25:24 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6LGPJfZ023897
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 17:25:20 +0100
Message-ID: <1469118319.23580.44.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Jul 2016 17:25:19 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cache: Move the parsing message to a more logical place
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
X-List-Received-Date: Thu, 21 Jul 2016 16:25:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Otherwise you can look at the log and wonder why parsing isn't happening
when it really is due to other code paths.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 96abd71..afd373d 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -395,6 +395,7 @@ class Cache(object):
     @classmethod
     def parse(cls, filename, appends, configdata, caches_array):
         """Parse the specified filename, returning the recipe information"""
+        logger.debug(1, "Parsing %s", filename)
         infos = []
         datastores = cls.load_bbfile(filename, appends, configdata)
         depends = []
@@ -432,7 +433,6 @@ class Cache(object):
                 virtualfn = self.realfn2virtual(filename, variant)
                 infos.append((virtualfn, self.depends_cache[virtualfn]))
         else:
-            logger.debug(1, "Parsing %s", filename)
             return self.parse(filename, appends, configdata, self.caches_array)
 
         return cached, infos



