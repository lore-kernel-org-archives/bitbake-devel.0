Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1UeSBy-0006Ia-Ri
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 May 2013 17:40:09 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 20 May 2013 08:20:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,707,1363158000"; d="scan'208";a="244169588"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.168])
	by AZSMGA002.ch.intel.com with ESMTP; 20 May 2013 08:20:20 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 May 2013 16:20:15 +0100
Message-Id: <ec6e0381208ab753502586f6ba84bcaa81d6b686.1369063091.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1369063091.git.paul.eggleton@linux.intel.com>
References: <cover.1369063091.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1369063091.git.paul.eggleton@linux.intel.com>
References: <cover.1369063091.git.paul.eggleton@linux.intel.com>
Subject: [1.18][PATCH 2/3] prserv/cooker: Handle PRService errors cleanly
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
X-List-Received-Date: Mon, 20 May 2013 15:40:26 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Current if the PR Service fails to start, bitbake carries on regardless or
hangs with no error message. This adds an exception and then handles it correctly
so the UIs correctly handle the error and exit cleanly.

[YOCTO #4010]

(Bitbake master rev: 949c01228a977c3b92bfc0802f6c71b40d8e05b3)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/cooker.py   | 5 ++++-
 bitbake/lib/prserv/serv.py | 9 ++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index c7c2ca6..2c54209 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1486,7 +1486,10 @@ class BBCooker:
         # Empty the environment. The environment will be populated as
         # necessary from the data store.
         #bb.utils.empty_environment()
-        prserv.serv.auto_start(self.configuration.data)
+        try:
+            prserv.serv.auto_start(self.configuration.data)
+        except prserv.serv.PRServiceConfigError:
+            bb.event.fire(CookerExit(), self.configuration.event_data)
         return
 
     def post_serve(self):
diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 3489200..6132100 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -263,6 +263,9 @@ def is_local_special(host, port):
     else:
         return False
 
+class PRServiceConfigError(Exception):
+    pass
+
 def auto_start(d):
     global singleton
 
@@ -273,14 +276,14 @@ def auto_start(d):
     if len(host_params) != 2:
         logger.critical('\n'.join(['PRSERV_HOST: incorrect format',
                 'Usage: PRSERV_HOST = "<hostname>:<port>"']))
-        return True
+        raise PRServiceConfigError
 
     if is_local_special(host_params[0], int(host_params[1])) and not singleton:
         import bb.utils
         cachedir = (d.getVar("PERSISTENT_DIR", True) or d.getVar("CACHE", True))
         if not cachedir:
             logger.critical("Please set the 'PERSISTENT_DIR' or 'CACHE' variable")
-            sys.exit(1)
+            raise PRServiceConfigError
         bb.utils.mkdirhier(cachedir)
         dbfile = os.path.join(cachedir, "prserv.sqlite3")
         logfile = os.path.join(cachedir, "prserv.log")
@@ -296,7 +299,7 @@ def auto_start(d):
         return PRServerConnection(host,port).ping()
     except Exception:
         logger.critical("PRservice %s:%d not available" % (host, port))
-    return False
+        raise PRServiceConfigError
 
 def auto_shutdown(d=None):
     global singleton
-- 
1.8.1.2



