Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 4820269686
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 12:11:09 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2SCB5mE016373 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 12:11:05 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 753AOSrhKLfl for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 12:11:05 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2SCAxgL016366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 12:11:00 GMT
Message-ID: <1396008654.14790.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Mar 2014 12:10:54 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] prserv: Fix exit race issues
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
X-List-Received-Date: Fri, 28 Mar 2014 12:11:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We shouldn't immediately remove the pid file when stopping the server, if we do, this
causes a traceback within the server itself which can then hang. Fix this by removing
the stale pid file as the last thing we do.

Also:

* don't printing a new "waiting" line every 0.5 seconds.
* make the loop more granular since the user can 'feel' the 0.5 seconds

[YOCTO #5984]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index e4c1c2a..1e170ce 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -275,17 +275,13 @@ def stop_daemon(host, port):
         PRServerConnection(host, port).terminate()
     except:
         logger.critical("Stop PRService %s:%d failed" % (host,port))
-    time.sleep(0.5)
 
     try:
         if pid:
-            if os.path.exists(pidfile):
-                os.remove(pidfile)
-
             wait_timeout = 0
-            while is_running(pid) and wait_timeout < 10:
-                print("Waiting for pr-server to exit.")
-                time.sleep(0.5)
+            print("Waiting for pr-server to exit.")
+            while is_running(pid) and wait_timeout < 50:
+                time.sleep(0.1)
                 wait_timeout += 1
 
             if is_running(pid):
@@ -293,6 +289,9 @@ def stop_daemon(host, port):
                 os.kill(pid,signal.SIGTERM)
                 time.sleep(0.1)
 
+            if os.path.exists(pidfile):
+                os.remove(pidfile)
+
     except OSError as e:
         err = str(e)
         if err.find("No such process") <= 0:



