Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C64BD782E8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Aug 2017 10:19:58 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7OAJuTr003980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 24 Aug 2017 11:19:58 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dkpEy-000694-VA; Thu, 24 Aug 2017 11:19:56 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Aug 2017 11:19:55 +0100
Message-Id: <1503569995-23575-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1503569995-23575-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1503569995-23575-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 24 Aug 2017 11:19:58 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/2] main: Attempt to gain bitbake.lock rather than just waiting
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
X-List-Received-Date: Thu, 24 Aug 2017 10:19:59 -0000

Rather than just waiting for 5s, try and get the lockfile. If we gain
the lock, we know we're ready to retry and can skip any remaining timeout.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 07972f6..6e6a346 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -446,7 +446,15 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
                     logger.info("Reconnecting to bitbake server...")
                     if not os.path.exists(sockname):
                         print("Previous bitbake instance shutting down?, waiting to retry...")
-                        time.sleep(5)
+                        i = 0
+                        lock = None
+                        # Wait for 5s or until we can get the lock
+                        while not lock and i < 50:
+                            time.sleep(0.1)
+                            _, lock = lockBitbake()
+                            i += 1
+                        if lock:
+                            bb.utils.unlockfile(lock)
                         raise bb.server.process.ProcessTimeout("Bitbake still shutting down as socket exists but no lock?")
                 if not configParams.server_only:
                     try:
-- 
2.7.4


