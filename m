Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 335F07002B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 22:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4BM6tU2000453 for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:06:56 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Q24Pi6q1KD4t for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:06:56 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4BLtr84032716
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 22:55:54 +0100
Message-ID: <1463003753.21831.294.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 11 May 2016 22:55:53 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] knotty: Ensure consolelog file handle is closed
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
X-List-Received-Date: Wed, 11 May 2016 22:06:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If we don't close the console log file handle, python prints a warning
about unclosed file handles upon exit which is annoying.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 903d72b..85a71f4 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -278,6 +278,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         server.terminateServer()
         return
 
+    consolelog = None
     if consolelogfile and not params.options.show_environment and not params.options.show_versions:
         bb.utils.mkdirhier(os.path.dirname(consolelogfile))
         conlogformat = bb.msg.BBLogFormatter(format_str)
@@ -591,4 +592,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if e.errno == errno.EPIPE:
             pass
 
+    if consolelog:
+        logger.removeHandler(consolelog)
+        consolelog.close()
+
     return return_value



