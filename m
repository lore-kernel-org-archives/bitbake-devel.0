Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 672FB75EE7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 11:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tAAB9VE1007847 for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 11:09:31 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id B_1hhNrbfnQL for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 11:09:31 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tAAB9FiG007821
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 11:09:28 GMT
Message-ID: <1447149284.3559.212.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Nov 2015 09:54:44 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.12.11-0ubuntu3 
Subject: [PATCH] cache: Don't try to expand __inherit_data
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
X-List-Received-Date: Tue, 10 Nov 2015 11:09:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Trying to expand a variable which isn't a string doesn't make sense.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/cache.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index ab09b08..521f758 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -85,8 +85,8 @@ class RecipeInfoCommon(object):
             return out_dict
 
     @classmethod
-    def getvar(cls, var, metadata):
-        return metadata.getVar(var, True) or ''
+    def getvar(cls, var, metadata, expand = True):
+        return metadata.getVar(var, expand) or ''
 
 
 class CoreRecipeInfo(RecipeInfoCommon):
@@ -142,7 +142,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.rprovides_pkg    = self.pkgvar('RPROVIDES', self.packages, metadata)
         self.rdepends_pkg     = self.pkgvar('RDEPENDS', self.packages, metadata)
         self.rrecommends_pkg  = self.pkgvar('RRECOMMENDS', self.packages, metadata)
-        self.inherits         = self.getvar('__inherit_cache', metadata)
+        self.inherits         = self.getvar('__inherit_cache', metadata, expand=False)
         self.fakerootenv      = self.getvar('FAKEROOTENV', metadata)
         self.fakerootdirs     = self.getvar('FAKEROOTDIRS', metadata)
         self.fakerootnoenv    = self.getvar('FAKEROOTNOENV', metadata)



