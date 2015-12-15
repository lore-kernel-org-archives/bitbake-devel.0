Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CAAA060767
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 17:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBFHgjsX009109 for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 17:42:45 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sfb8ikrt1L3I for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 17:42:44 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBFHgeAg009106
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Dec 2015 17:42:41 GMT
Message-ID: <1450201360.13505.85.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Dec 2015 17:42:40 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] utils: Improve traceback from better_exec internal errors
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
X-List-Received-Date: Tue, 15 Dec 2015 17:42:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you break the internals of better_exec(), you get a very weird 
error about tb_next not being a method of None. Fix this by checking 
we can step back a trace level.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 31ec2b7..4ed7608 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -323,8 +323,10 @@ def _print_exception(t, value, tb, realfile, text, context):
         exception = traceback.format_exception_only(t, value)
         error.append('Error executing a python function in %s:\n' % realfile)
 
-        # Strip 'us' from the stack (better_exec call)
-        tb = tb.tb_next
+        # Strip 'us' from the stack (better_exec call) unless that was where the 
+        # error came from
+        if tb.tb_next is not None:
+            tb = tb.tb_next
 
         textarray = text.split('\n')



