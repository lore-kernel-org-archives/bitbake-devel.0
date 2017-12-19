Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E587F71A70
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Dec 2017 12:47:22 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	vBJClLoC013839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 19 Dec 2017 12:47:22 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1eRHIn-0004ZJ-74; Tue, 19 Dec 2017 12:47:21 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Dec 2017 12:47:20 +0000
Message-Id: <1513687640-17523-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] build.py: Don't return dependencies for tasks which don't exist
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
X-List-Received-Date: Tue, 19 Dec 2017 12:47:23 -0000

If for example you deltask do_build but it has recrdeps set, its confusing
to have that list returned when the task no longer exists (same would apply
to deps too  if it was set after the deltask).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 0d0100a..4631abd 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -872,6 +872,12 @@ def preceedtask(task, with_recrdeptasks, d):
     that this may lead to the task itself being listed.
     """
     preceed = set()
+
+    # Ignore tasks which don't exist
+    tasks = d.getVar('__BBTASKS', False)
+    if task not in tasks:
+        return preceed
+
     preceed.update(d.getVarFlag(task, 'deps') or [])
     if with_recrdeptasks:
         recrdeptask = d.getVarFlag(task, 'recrdeptask')
-- 
2.7.4


