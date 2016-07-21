Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3AAE565CBF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 16:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6LGRdhF024018; Thu, 21 Jul 2016 17:27:39 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lrfFNebPiPxD; Thu, 21 Jul 2016 17:27:39 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6LGRZhv024015
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Jul 2016 17:27:36 +0100
Message-ID: <1469118455.23580.46.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Jul 2016 17:27:35 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: "Avery, Brian" <brian.avery@intel.com>
Subject: [PATCH] cache: Correctly handle missing extra caches
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
X-List-Received-Date: Thu, 21 Jul 2016 16:27:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If an "extras" cache file is corrupted, the system would not notice
and later fail with errors about missing entries. Add a test for this
which means we can fall back to re-parsing in those cases.

[YOCTO #9902]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index afd373d..b90d488 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -556,6 +556,9 @@ class Cache(object):
             if virtualfn not in self.depends_cache:
                 logger.debug(2, "Cache: %s is not cached", virtualfn)
                 invalid = True
+            elif len(self.depends_cache[virtualfn]) != len(self.caches_array):
+                logger.debug(2, "Cache: Extra caches missing for %s?" % virtualfn)
+                invalid = True
 
         # If any one of the variants is not present, mark as invalid for all
         if invalid:



