Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B620671C8D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 16:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JGDC2a002520; Thu, 19 Jan 2017 16:13:30 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rZJLcXu-CSn9; Thu, 19 Jan 2017 16:13:30 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JGDQ2d002778
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Jan 2017 16:13:27 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cUFL4-0000mh-Bu; Thu, 19 Jan 2017 16:13:26 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2017 16:13:21 +0000
Message-Id: <1484842404-2960-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1484842404-2960-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1484842404-2960-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/5] runqueue: Fix traceback when using -b
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
X-List-Received-Date: Thu, 19 Jan 2017 16:13:31 -0000

Without this, bitbake -b of image recipes cause tracebacks since
the list of providers is empty.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index d42eb81..7e651a4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -567,6 +567,8 @@ class RunQueueData:
                 for (depname, idependtask) in irdepends:
                     if depname in taskData[mc].run_targets:
                         # Won't be in run_targets if ASSUME_PROVIDED
+                        if not taskData[mc].run_targets[depname]:
+                            continue
                         depdata = taskData[mc].run_targets[depname][0]
                         if depdata is not None:
                             t = depdata + ":" + idependtask
-- 
2.7.4


