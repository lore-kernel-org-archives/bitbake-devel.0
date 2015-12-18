Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1D40A731A6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Dec 2015 11:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBIB2ihM030903 for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Dec 2015 11:02:44 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lhhNafCo_ECi for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Dec 2015 11:02:44 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBIB2ffQ030879
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Dec 2015 11:02:42 GMT
Message-ID: <1450436561.8461.30.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 18 Dec 2015 11:02:41 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] knotty: Fix row/column function return value issue
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
X-List-Received-Date: Fri, 18 Dec 2015 11:02:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When the row handling was introduced, one of the callbacks was
missed resulting in:

TypeError: can only concatenate tuple (not "int") to tuple

Fix it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index c3d73b9..042b79e 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -171,7 +171,7 @@ class TerminalFilter(object):
                 signal.signal(signal.SIGWINCH, self.sigwinch_handle)
             except:
                 pass
-            self.columns = self.getTerminalColumns()
+            self.rows, self.columns = self.getTerminalColumns()
         except:
             self.cuu = None
         console.addFilter(InteractConsoleLogFilter(self, format))



