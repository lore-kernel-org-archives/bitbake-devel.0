Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UXv3Q-00018L-6b for bitbake-devel@lists.openembedded.org;
	Thu, 02 May 2013 17:04:21 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r42EmBIC016520 for <bitbake-devel@lists.openembedded.org>;
	Thu, 2 May 2013 15:48:11 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WC6hjZKcgxMa for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 May 2013 15:48:10 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r42Em7Ba016515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 2 May 2013 15:48:09 +0100
Message-ID: <1367505971.5379.127.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 02 May 2013 15:46:11 +0100
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Subject: [PATCH] prserv/cooker: Handle PRService errors cleanly
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
X-List-Received-Date: Thu, 02 May 2013 15:04:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Current if the PR Service fails to start, bitbake carries on regardless or
hangs with no error message. This adds an exception and then handles it correctly
so the UIs correctly handle the error and exit cleanly.

[YOCTO #4010]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
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




