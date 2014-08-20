Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D10A965E14
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Aug 2014 22:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7KMeZKi015569 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Aug 2014 23:40:35 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lbJ8K2S5aAYi for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Aug 2014 23:40:35 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7KMeU2Q015566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Aug 2014 23:40:31 +0100
Message-ID: <1408574430.1669.97.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Aug 2014 23:40:30 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] process: Deal with infinite looping of the server
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
X-List-Received-Date: Wed, 20 Aug 2014 22:40:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if an exception occurs, we just run the idle handler again and
again, usually looping indefinitely. Chances are the exception that occurred
will keep occurring and this is not a good place to be.

This was breaking the autobuilders with gigabytes of logs.

At least improve things so the cooker shuts down gracefully when this happens.
Some trace of the original problem may still be present on the console too!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index a0bcbfa..7fdf964 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -139,6 +139,8 @@ class ProcessServer(Process, BaseImplServer):
                 raise
             except Exception:
                 logger.exception('Running idle function')
+                del self._idlefuns[function]
+                self.quit = True
 
         if nextsleep is not None:
             select.select(fds,[],[],nextsleep)



