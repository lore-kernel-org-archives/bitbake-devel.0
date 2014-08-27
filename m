Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3107162252
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 12:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RC7QgK029205 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 13:07:26 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fW9zFsXIqc5u for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 13:07:26 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RC7NOG029202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 13:07:24 +0100
Message-ID: <1409141244.5772.42.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Aug 2014 13:07:24 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Fix setscene tasks not running
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
X-List-Received-Date: Wed, 27 Aug 2014 12:07:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, if you have hard dependencies between setscene tasks (like avahi on
base-passwd through useradd.bbclass), other dependencies may not be installed
even if these exist in sstate. For example, avahi -> expat -> pigz-native
(and avahi -> base-passwd) yet if you cleansstate base-passwd:

bitbake gzip-native:do_clean avahi:do_clean expat:do_clean pigz-native:do_clean base-passwd:do_cleansstate
bitbake avahi | tee

you will currently see pigz-native being rebuilt even though it was in
sstate. The fix for this is to continue to iterate dependency chains
around hard blocked dependencies as per this patch.

After this patch is applied, you will see pigz-native installed from sstate.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index e13dc57..e32f81a 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1844,6 +1844,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 realtask = self.rqdata.runq_setscene[task]
                 realdep = self.rqdata.runq_setscene[dep]
                 logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (self.rqdata.get_user_idstring(realtask), self.rqdata.get_user_idstring(realdep)))
+                self.scenequeue_updatecounters(dep, fail)
+                continue
+            if task not in self.sq_revdeps2[dep]:
+                # May already have been removed by the fail case above
                 continue
             self.sq_revdeps2[dep].remove(task)
             if len(self.sq_revdeps2[dep]) == 0:



