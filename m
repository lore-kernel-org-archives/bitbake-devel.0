Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 99A7A6E786
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2014 10:54:43 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s0MAsjtN008140
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2014 02:54:45 -0800 (PST)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.347.0;
	Wed, 22 Jan 2014 02:54:44 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Jan 2014 18:55:02 +0800
Message-ID: <d944b5d90bd21c920b016db2e71688356a96d68f.1390387902.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1390387902.git.liezhi.yang@windriver.com>
References: <cover.1390387902.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake:cache.py: remove the add()
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
X-List-Received-Date: Wed, 22 Jan 2014 10:54:43 -0000
Content-Type: text/plain

No one uses the add(), so remove it.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cache.py | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 318781b..3486031 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -630,19 +630,6 @@ class Cache(object):
                 self.cacheclean = False
             self.depends_cache[filename] = info_array
 
-    def add(self, file_name, data, cacheData, parsed=None):
-        """
-        Save data we need into the cache
-        """
-
-        realfn = self.virtualfn2realfn(file_name)[0]
-
-        info_array = []
-        for cache_class in self.caches_array:
-            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                info_array.append(cache_class(realfn, data))
-        self.add_info(file_name, info_array, cacheData, parsed)
-
     @staticmethod
     def load_bbfile(bbfile, appends, config):
         """
-- 
1.8.3.1


