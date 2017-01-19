Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6166271C73
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jan 2017 16:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JGDC2Z002520; Thu, 19 Jan 2017 16:13:29 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3ChCq0aBpnTA; Thu, 19 Jan 2017 16:13:29 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v0JGDQx1002777
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Jan 2017 16:13:27 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cUFL4-0000me-BM; Thu, 19 Jan 2017 16:13:26 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2017 16:13:20 +0000
Message-Id: <1484842404-2960-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 1/5] cooker: Only add universe targets where the task exists
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
X-List-Received-Date: Thu, 19 Jan 2017 16:13:30 -0000

Currently "bitbake universe -c fetch" will error if every task in the system
doesn't have a fetch task. This seems unreasonable so filter the list based
upon whether the task exists. This implementation does assume if a task exits
for a given provider name, it can run, even if the preferred provider that
ends up getting built might be the namespace without the task. This is unlikely
to be a real world issue at this point.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5608845..a7b9745 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1704,6 +1704,15 @@ class BBCooker:
             pkgs_to_build.remove('universe')
             for mc in self.multiconfigs:
                 for t in self.recipecaches[mc].universe_target:
+                    if task:
+                        foundtask = False
+                        for provider_fn in self.recipecaches[mc].providers[t]:
+                            if task in self.recipecaches[mc].task_deps[provider_fn]['tasks']:
+                                foundtask = True
+                                break
+                        if not foundtask:
+                            bb.debug(1, "Skipping %s for universe tasks as task %s doesn't exist" % (t, task))
+                            continue
                     if mc:
                         t = "multiconfig:" + mc + ":" + t
                     pkgs_to_build.append(t)
-- 
2.7.4


