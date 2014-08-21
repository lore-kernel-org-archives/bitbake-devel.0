Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 216BB70F06
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 20:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7LKjuYt021628 for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 21:45:56 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7nxa26Mqtl9H for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 21:45:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7LKjpUE021625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 21:45:52 +0100
Message-ID: <1408653952.1669.115.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Aug 2014 21:45:52 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] command: Trigger updateCache to shut down any active parser threads
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
X-List-Received-Date: Thu, 21 Aug 2014 20:45:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If we trigger a shutdown whilst parsing for whatever reason, in some
cases we were not closing down the parser threads. This change
ensures we do so. The function names are not entirely intuitive
but the behaviour is more correct (and commented). The previous bug
with the stdout failure would trigger this one, if there was a cold
cache and parsing was required (but not otherwise).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index d797fcf..0cfed0a 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -87,6 +87,9 @@ class Command:
     def runAsyncCommand(self):
         try:
             if self.cooker.state in (bb.cooker.state.error, bb.cooker.state.shutdown, bb.cooker.state.forceshutdown):
+                # updateCache will trigger a shutdown of the parser
+                # and then raise BBHandledException triggering an exit
+                self.cooker.updateCache()
                 return False
             if self.currentAsyncCommand is not None:
                 (command, options) = self.currentAsyncCommand



