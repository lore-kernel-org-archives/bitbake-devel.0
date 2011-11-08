Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RNu7A-0003WC-FE for bitbake-devel@lists.openembedded.org;
	Tue, 08 Nov 2011 23:25:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pA8MJgvg007362
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Nov 2011 22:19:42 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06833-08 for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Nov 2011 22:19:38 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pA8MJaAO007356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Nov 2011 22:19:37 GMT
Message-ID: <1320790778.10843.123.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 08 Nov 2011 22:19:38 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] Add FAKEROOTNOENV variable
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
X-List-Received-Date: Tue, 08 Nov 2011 22:25:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Add a FAKEROOTNOENV which does the opposite of the FAKEROOTENV variable
and is data loaded into the environment for tasks without the fakeroot
flag. 

The intent here is to provide a way to control the environment when we
aren't needing fakeroot context which allows us to unload the preload
from memory entirely and gain a valuable speedup.

I'm not 100% happy with needing this at the bitbake level, particularly
with the cache hit but it does give a valuable speedup.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index d495f9e..fe35e13 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -143,6 +143,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.section          = self.getvar('SECTION', metadata)
         self.fakerootenv      = self.getvar('FAKEROOTENV', metadata)
         self.fakerootdirs     = self.getvar('FAKEROOTDIRS', metadata)
+        self.fakerootnoenv    = self.getvar('FAKEROOTNOENV', metadata)
 
     @classmethod
     def init_cacheData(cls, cachedata):
@@ -178,6 +179,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.license = {}
         cachedata.section = {}
         cachedata.fakerootenv = {}
+        cachedata.fakerootnoenv = {}
         cachedata.fakerootdirs = {}
 
     def add_cacheData(self, cachedata, fn):
@@ -243,6 +245,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.license[fn] = self.license
         cachedata.section[fn] = self.section
         cachedata.fakerootenv[fn] = self.fakerootenv
+        cachedata.fakerootnoenv[fn] = self.fakerootnoenv
         cachedata.fakerootdirs[fn] = self.fakerootdirs
 
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9a1bad7..7a39d89 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1096,6 +1096,12 @@ class RunQueueExecute:
 
             logger.debug(2, 'Running %s:%s under fakeroot, fakedirs: %s' %
                             (fn, taskname, ', '.join(fakedirs)))
+        else:
+            envvars = (self.rqdata.dataCache.fakerootnoenv[fn] or "").split()
+            for key, value in (var.split('=') for var in envvars):
+                envbackup[key] = os.environ.get(key)
+                os.environ[key] = value
+                fakeenv[key] = value
 
         sys.stdout.flush()
         sys.stderr.flush()



