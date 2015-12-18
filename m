Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 581FE731A7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Dec 2015 11:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBIB3QRS030958 for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Dec 2015 11:03:26 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eIaVCJMBFPvl for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Dec 2015 11:03:26 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBIB3KQ2030953
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Dec 2015 11:03:22 GMT
Message-ID: <1450436600.8461.31.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 18 Dec 2015 11:03:20 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] knotty: Improve exception error message
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
X-List-Received-Date: Fri, 18 Dec 2015 11:03:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Instead of:
"""
can only concatenate tuple (not "int") to tuple
"""
we now see:

"""
Traceback (most recent call last):
  File "/media/build1/poky/bitbake/lib/bb/ui/knotty.py", line 324, in main
    termfilter.updateFooter()
  File "/media/build1/poky/bitbake/lib/bb/ui/knotty.py", line 210, in updateFooter
    lines = 1 + int(len(content) / (self.columns + 1))
TypeError: can only concatenate tuple (not "int") to tuple
"""

which makes tacking down and fixing the problem much easier.

Also ensure we set an error exit code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 042b79e..053d1e9 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -533,10 +533,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             main.shutdown = main.shutdown + 1
             pass
         except Exception as e:
-            sys.stderr.write(str(e))
+            import traceback
+            sys.stderr.write(traceback.format_exc())
             if not params.observe_only:
                 _, error = server.runCommand(["stateForceShutdown"])
             main.shutdown = 2
+            return_value = 1
     try:
         summary = ""
         if taskfailures:



