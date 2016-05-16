Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 73C5762132
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 21:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4GLq1ui020900 for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 22:52:01 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uFUsrS7zhn1O for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 22:52:01 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4GLq0B8020897
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 May 2016 22:52:01 +0100
Message-ID: <1463435520.9746.163.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 16 May 2016 22:52:00 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] knotty: Fix output buffering issues
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
X-List-Received-Date: Mon, 16 May 2016 21:52:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We need to flush the footer removal, else it may not be outputted until
the buffer is flushed as part of StreamHandler and this would lead to
it removing the ERROR output just printed which is extremely confusing.

Also ensure the footer is cleared before printing a summary as in
some cases it wasn't being removed, also leading to user confusion.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index d6813f5..9605c8e 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -186,6 +186,7 @@ class TerminalFilter(object):
             lines = self.footer_present
             sys.stdout.buffer.write(self.curses.tparm(self.cuu, lines))
             sys.stdout.buffer.write(self.curses.tparm(self.ed))
+            sys.stdout.flush()
         self.footer_present = False
 
     def updateFooter(self):
@@ -568,6 +569,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             main.shutdown = 2
             return_value = 1
     try:
+        termfilter.clearFooter()
         summary = ""
         if taskfailures:
             summary += pluralise("\nSummary: %s task failed:",



