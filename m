Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F25E760124
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Dec 2015 18:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tB7IRB8P021343
	for <bitbake-devel@lists.openembedded.org>; Mon, 7 Dec 2015 18:27:11 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bO8p8wDKWNa3 for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Dec 2015 18:27:11 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tB7IQv8C021335
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 7 Dec 2015 18:27:08 GMT
Message-ID: <1449512817.19730.12.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 07 Dec 2015 18:26:57 +0000
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] knotty: Enforce terminal line limit to stop crazy scrolling
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
X-List-Received-Date: Mon, 07 Dec 2015 18:27:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If there are more tasks running than there are lines on the terminal, the data
scrolls in ways the UI wasn't designed for. This patch adjusts the UI just to
show the processes which fit onto the number of rows in the terminal window.
You can see the total number running from the counter in the top left as usual
and this makes warning and errors messages scrolling from the top of the window
work as designed.

Ultimately, scrolling would be nice but is for another time, this fixes the
biggest UI issue on highly parallel machines.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 1ecf1aa..5164e19 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -120,10 +120,11 @@ class InteractConsoleLogFilter(logging.Filter):
         return True
 
 class TerminalFilter(object):
+    rows = 25
     columns = 80
 
     def sigwinch_handle(self, signum, frame):
-        self.columns = self.getTerminalColumns()
+        self.rows, self.columns = self.getTerminalColumns()
         if self._sigwinch_default:
             self._sigwinch_default(signum, frame)
 
@@ -147,7 +148,7 @@ class TerminalFilter(object):
                 cr = (env['LINES'], env['COLUMNS'])
             except:
                 cr = (25, 80)
-        return cr[1]
+        return cr
 
     def __init__(self, main, helper, console, errconsole, format):
         self.main = main
@@ -223,7 +224,7 @@ class TerminalFilter(object):
             content = "Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
         print(content)
         lines = 1 + int(len(content) / (self.columns + 1))
-        for tasknum, task in enumerate(tasks):
+        for tasknum, task in enumerate(tasks[:(self.rows - 2)]):
             content = "%s: %s" % (tasknum, task)
             print(content)
             lines = lines + 1 + int(len(content) / (self.columns + 1))



