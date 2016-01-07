Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6F8096FFCD
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jan 2016 11:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u07B6Eew017153; Thu, 7 Jan 2016 11:06:14 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wko5EfzOLi5A; Thu,  7 Jan 2016 11:06:14 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u07B69S6017147
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Jan 2016 11:06:10 GMT
Message-ID: <1452164769.7598.109.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 07 Jan 2016 11:06:09 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: ulfalizer@gmail.com
Subject: [PATCH] knotty: Use non-interactive mode as fallback for dumb terminals
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
X-List-Received-Date: Thu, 07 Jan 2016 11:06:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

TERM=dumb bitbake X

shows no output fot task status which is suboptimal. Use the non-interactive
mode if the terminal doesn't support what we need for interactive mode giving
a better user experience. Also print a note to the console to say this has
happened.

[YOCTO #8768]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 053d1e9..b42f8eb 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -174,6 +174,10 @@ class TerminalFilter(object):
             self.rows, self.columns = self.getTerminalColumns()
         except:
             self.cuu = None
+        if not self.cuu:
+            self.interactive = False
+            bb.note("Unable to use interactive mode for this terminal, using fallback")
+            return
         console.addFilter(InteractConsoleLogFilter(self, format))
         errconsole.addFilter(InteractConsoleLogFilter(self, format))
 



