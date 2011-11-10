Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1ROT59-0002R6-8F
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 Nov 2011 12:46:11 +0100
Received: by opal (Postfix, from userid 111)
	id E813C10332; Thu, 10 Nov 2011 11:40:38 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111110114038.E813C10332@opal>
Date: Thu, 10 Nov 2011 11:40:38 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : Add FAKEROOTNOENV variable
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
X-List-Received-Date: Thu, 10 Nov 2011 11:46:11 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 05c29ab0b2ad3c521414cabb6a92bca15c6e919c
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=05c29ab0b2ad3c521414cabb6a92bca15c6e919c

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Tue Nov  8 22:19:38 2011 +0000

Add FAKEROOTNOENV variable

Add a FAKEROOTNOENV which does the opposite of the FAKEROOTENV variable
and is data loaded into the environment for tasks without the fakeroot
flag.

The intent here is to provide a way to control the environment when we
aren't needing fakeroot context which allows us to unload the preload
from memory entirely and gain a valuable speedup.

I'm not 100% happy with needing this at the bitbake level, particularly
with the cache hit but it does give a valuable speedup.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cache.py    |    3 +++
 lib/bb/runqueue.py |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

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



