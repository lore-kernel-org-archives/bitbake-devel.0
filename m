Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4C26260DD7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 17:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LHi5ix006600 for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 17:44:05 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7WduSSehJ_Sm for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 17:44:05 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LHhpdW006593
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 17:44:02 GMT
Message-ID: <1421862231.19798.3.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 Jan 2015 17:43:51 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] server/process: Fix select call
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
X-List-Received-Date: Wed, 21 Jan 2015 17:44:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There was a report that bitbake -e | less would use 100% cpu when it shouldn't
really. The issue appears to be a bogus file descriptor in the select call. We
shouldn't be blocking if there is event data pending to a *reader* from server
context.

[YOCTO #7138]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index d362f8d..7671b26 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -115,7 +115,7 @@ class ProcessServer(Process, BaseImplServer):
                     self.quitout.recv()
                     self.quit = True
 
-                self.idle_commands(.1, [self.event_queue._reader, self.command_channel, self.quitout])
+                self.idle_commands(.1, [self.command_channel, self.quitout])
             except Exception:
                 logger.exception('Running command %s', command)
 



