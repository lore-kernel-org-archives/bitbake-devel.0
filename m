Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B98E86FF76
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Jan 2016 18:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0AI8I1p007739; Sun, 10 Jan 2016 18:08:18 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TJhlH0SDoBuQ; Sun, 10 Jan 2016 18:08:18 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0AI8CBW007732
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 10 Jan 2016 18:08:13 GMT
Message-ID: <1452449292.7598.169.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 10 Jan 2016 18:08:12 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: "Eggleton, Paul" <paul.eggleton@intel.com>
Subject: [PATCH] runqueue: Fix setscene task dependencies
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
X-List-Received-Date: Sun, 10 Jan 2016 18:08:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Debugging suggests that setscene tasks are being a little greedy about their
dependencies, for example, lsof is insisting that gcc-runtime's do_package
is installed. If it isn't, its requiring gcc to rebuild, which is simply 
wrong. If gcc-runtime do_package_write_xxx and do_packagedata is available, 
there is no reason do_package should be needed.

The reason this is happening appears to be from the batching up of task
dependencies code, rather than setscene tasks stopping when passing over
a setscene task, they were being carried forward. This patch fixes it
so the data is 'zeroed' when passing over a setscene task boundary,
which gives the dependency graph that is expected.

After this patch, lsof will rebuild quite happily without
gcc-runtime:do_package being present, as expected. This should lead to
less dependencies being installed for builds from sstate and generally
better performance in general.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index da7059b..daf4c3d 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1721,6 +1721,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_revdeps_new[point] = set()
                 if point in self.rqdata.runq_setscene:
                     sq_revdeps_new[point] = tasks
+                    tasks = set()
                 for dep in self.rqdata.runq_depends[point]:
                     if point in sq_revdeps[dep]:
                         sq_revdeps[dep].remove(point)



