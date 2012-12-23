Received: from mail-ee0-f44.google.com ([74.125.83.44])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TmsIs-0003B2-4i
	for bitbake-devel@lists.openembedded.org;
	Sun, 23 Dec 2012 21:37:46 +0100
Received: by mail-ee0-f44.google.com with SMTP id b47so3355242eek.3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Dec 2012 12:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=SWWrKyq2JmMJknABur1Mz9Ia6IfxTjVgxLDFKz6u3f8=;
	b=RJcMNwM5f46K7yaabwqqvsMBpGcP3308uLX8hoQhsvdPBAwciq88waSJrp4zllaTNy
	4/ya99XEc0Tzi1qCE0ECfIi+5y9Arztm36J09Ywld36Y6vUQRMfd76VYylJafTTjKkL1
	V+wpcBNyv+4Qhxl9uax8biIHpztpsGI1fDvJiHM4CnS+XyzITEFylNVIaaTNBLQZk2DE
	7x44Q/CseKEQS7zTN2wucBfyOgPxdT9g5bmIFoNOz/FHzECM7iwsCxUgkJxcYrlw4X08
	6CHHZpdMCuFQwdwaShHt1teI7zgzN5fPylWvXIe7RBhUD/3OhDkz+UQpQV3uidz832Np
	VH9Q==
X-Received: by 10.14.0.3 with SMTP id 3mr50001481eea.16.1356294177223;
	Sun, 23 Dec 2012 12:22:57 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id k4sm36902124eep.15.2012.12.23.12.22.56
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sun, 23 Dec 2012 12:22:56 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 23 Dec 2012 21:22:56 +0100
Message-Id: <1356294176-12058-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.0.2
Subject: [PATCH] cache: allow to set EXCLUDE_FROM_WORLD outside recipe
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 23 Dec 2012 20:37:46 -0000

* sometimes it's useful for distro/builder to set EXCLUDE_FROM_WORLD_foo = "1"
  to exclude recipes not supported by distro/builder in some include file

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index a3c073a..3486f39 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -128,7 +128,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.pr = self.getvar('PR', metadata)
         self.defaultpref = self.intvar('DEFAULT_PREFERENCE', metadata)
         self.broken = self.getvar('BROKEN', metadata)
-        self.not_world = self.getvar('EXCLUDE_FROM_WORLD', metadata)
+        self.not_world = self.getvar('EXCLUDE_FROM_WORLD', metadata) or self.getVar("EXCLUDE_FROM_WORLD_" + self.pn, metadata)
         self.stamp = self.getvar('STAMP', metadata)
         self.stampclean = self.getvar('STAMPCLEAN', metadata)        
         self.stamp_base = self.flaglist('stamp-base', self.tasks, metadata)
-- 
1.8.0.2



