Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A21C178234
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 13:15:34 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6ODFXJn020367
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 24 Jul 2017 14:15:35 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dZdCv-000423-Vl; Mon, 24 Jul 2017 14:15:33 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Jul 2017 14:15:32 +0100
Message-Id: <1500902132-15461-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Mon, 24 Jul 2017 14:15:35 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] process: Change timeout warning to a note
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
X-List-Received-Date: Mon, 24 Jul 2017 13:15:36 -0000

The warning message currently shown can occur more frequently than previously
if a previous bitbake server is shutting down and we're reconnecting to a new
server. Change it to a note message to match the higher level connection
logging retry messages and so as not to interfer with selftests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 85beaae..1975bd4 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -312,7 +312,7 @@ class ServerCommunicator():
                     if self.recv.poll(1):
                         return self.recv.get()
                     else:
-                        bb.warn("Timeout while attempting to communicate with bitbake server")
+                        bb.note("Timeout while attempting to communicate with bitbake server, retrying...")
                 raise ProcessTimeout("Gave up; Too many tries: timeout while attempting to communicate with bitbake server")
             except KeyboardInterrupt:
                 pass
-- 
2.7.4


