Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D20D2606A8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2016 15:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6KF8KuO015425; Wed, 20 Jul 2016 16:08:20 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AULS2xHfY38x; Wed, 20 Jul 2016 16:08:20 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6KF8Hkr015411
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Jul 2016 16:08:18 +0100
Message-ID: <1469027297.23580.17.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Jul 2016 16:08:17 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Fix incorrect dot file generation
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
X-List-Received-Date: Wed, 20 Jul 2016 15:08:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

In the runqueue cleanup/conversion, "dep" was mistakenly used where "tid" should
be leading to incorrect task-depends.dot files and causing general confusion. 
Fix this, its clearly incorrect looking at the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9bd3460..a73a55d 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -744,7 +744,7 @@ class BBCooker:
             for dep in rq.rqdata.runtaskentries[tid].depends:
                 depfn = bb.runqueue.fn_from_tid(dep)
                 deppn = self.recipecache.pkg_fn[depfn]
-                dotname = "%s.%s" % (pn, bb.runqueue.taskname_from_tid(dep))
+                dotname = "%s.%s" % (pn, bb.runqueue.taskname_from_tid(tid))
                 if not dotname in depend_tree["tdepends"]:
                     depend_tree["tdepends"][dotname] = []
                 depend_tree["tdepends"][dotname].append("%s.%s" % (deppn, bb.runqueue.taskname_from_tid(dep)))

