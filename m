Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id E9448731EC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 08:55:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u0M8tB67013585
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 00:55:11 -0800 (PST)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Fri, 22 Jan 2016 00:55:11 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jan 2016 00:55:10 -0800
Message-ID: <d435c8989fa565a20f57159432fb453c42663657.1453452868.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1453452868.git.liezhi.yang@windriver.com>
References: <cover.1453452868.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] cache.py: check existence before add to cachedata.rproviders
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
X-List-Received-Date: Fri, 22 Jan 2016 08:55:11 -0000
Content-Type: text/plain

The rprovides maybe contain duplicated lines when parse again, we need
check it before add to cachedata.rproviders, similar to what we had done
to cachedata.providers.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cache.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 10b0853..83f2ff1 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -214,7 +214,8 @@ class CoreRecipeInfo(RecipeInfoCommon):
             rprovides += self.rprovides_pkg[package]
 
         for rprovide in rprovides:
-            cachedata.rproviders[rprovide].append(fn)
+            if fn not in cachedata.rproviders[rprovide]:
+                cachedata.rproviders[rprovide].append(fn)
 
         for package in self.packages_dynamic:
             cachedata.packages_dynamic[package].append(fn)
-- 
1.7.9.5


