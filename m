Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7B04878842
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jan 2018 12:10:12 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w0UCABuK029014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 30 Jan 2018 12:10:12 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1egUjr-0006h2-GF; Tue, 30 Jan 2018 12:10:11 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jan 2018 12:10:08 +0000
Message-Id: <1517314210-25684-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/4] runqueue: Remove unused variables
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
X-List-Received-Date: Tue, 30 Jan 2018 12:10:14 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2543d4e..5f53fe7 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -705,7 +705,6 @@ class RunQueueData:
                         if i not in self.runtaskentries:
                             # Not all recipes might have the recrdeptask task as a task
                             continue
-                        task = self.runtaskentries[i].task
                         for n in self.runtaskentries[i].depends:
                             if n not in seendeps:
                                  generate_recdeps(n)
@@ -716,7 +715,6 @@ class RunQueueData:
                         generate_recdeps(dep)
 
             for tid in self.runtaskentries:
-                task = self.runtaskentries[tid].task
                 # Add in extra dependencies
                 if tid in extradeps:
                      extradeps[tid].difference_update(self.runtaskentries[tid].depends)
-- 
2.7.4


