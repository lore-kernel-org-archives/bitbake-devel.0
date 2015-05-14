Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DDBCF65DA3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 09:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4E9YHC8015465 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 10:34:17 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gcay_Ae19TMX for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 10:34:17 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4E9Y46j015456
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 10:34:15 +0100
Message-ID: <1431596044.30971.192.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 May 2015 10:34:04 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Handle cases where siginfo is now a parameter to the hashvadlidate function
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
X-List-Received-Date: Thu, 14 May 2015 09:34:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

In some cases we need to check specifically for siginfo files, in
some cases we need to check for the actual sstate objects themselves.

Therefore make this a parameter to the function. A fallback to the
previous function style is maintained for now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 4a1992a..52bb12f 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1205,9 +1205,14 @@ class RunQueue:
             sq_hash.append(self.rqdata.runq_hash[task])
             sq_taskname.append(taskname)
             sq_task.append(task)
-        call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
         locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.expanded_data }
-        valid = bb.utils.better_eval(call, locs)
+        try:
+            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=True)"
+            valid = bb.utils.better_eval(call, locs)
+        # Handle version with no siginfo parameter
+        except TypeError:
+            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
+            valid = bb.utils.better_eval(call, locs)
         for v in valid:
             valid_new.add(sq_task[v])
 



