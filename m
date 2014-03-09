Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 65C4F6F60F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 16:58:21 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s29GwHPv020108
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 16:58:17 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id y3RdTHXdwI9T for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 16:58:16 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s29Gw7Vd020102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 16:58:11 GMT
Message-ID: <1394384281.7883.5.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 09:58:01 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: knotty: Deal with exceptions not resetting terminal configuration
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
X-List-Received-Date: Sun, 09 Mar 2014 16:58:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When an exception occurred, the terminal parameters (such as echo)
may not be reset correctly. This change ensures they do get
atexit time in all cases, avoiding the terminal corruption issues
that could sometimes occur.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index c1ee9f52..3dada8e 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -31,6 +31,7 @@ import time
 import fcntl
 import struct
 import copy
+import atexit
 from bb.ui import uihelper
 
 logger = logging.getLogger("BitBake")
@@ -303,6 +304,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     taskfailures = []
 
     termfilter = tf(main, helper, console, format)
+    atexit.register(termfilter.finish)
 
     while True:
         try:
@@ -536,6 +538,4 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if return_value == 0:
             return_value = 1
 
-    termfilter.finish()
-
     return return_value



