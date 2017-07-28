Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F267E784C3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 14:55:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6SEtUl3005837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 28 Jul 2017 15:55:31 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1db6fq-0005br-RM; Fri, 28 Jul 2017 15:55:30 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Jul 2017 15:55:24 +0100
Message-Id: <1501253729-21511-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 28 Jul 2017 15:55:32 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/7] process: Ensure ConnectionReader/Writer have fileno() and close() methods
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
X-List-Received-Date: Fri, 28 Jul 2017 14:55:33 -0000

Expose the underlying close() and fileno() methods which allow connection
monitoring and cleanup.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 1975bd4..8a7c431 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -523,6 +523,10 @@ class ConnectionReader(object):
     def fileno(self):
         return self.reader.fileno()
 
+    def close(self):
+        return self.reader.close()
+
+
 class ConnectionWriter(object):
 
     def __init__(self, fd):
@@ -536,3 +540,8 @@ class ConnectionWriter(object):
         with self.wlock:
             self.writer.send_bytes(obj)
 
+    def fileno(self):
+        return self.writer.fileno()
+
+    def close(self):
+        return self.writer.close()
-- 
2.7.4


