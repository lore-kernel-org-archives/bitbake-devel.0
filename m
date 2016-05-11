Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3275E7001D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 22:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4BM6o3V000365 for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:06:56 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nwfU0AsxuFlZ for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:06:56 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4BLtEuI032706
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 22:55:15 +0100
Message-ID: <1463003714.21831.293.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 11 May 2016 22:55:14 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Improve timestamp comparisons
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
X-List-Received-Date: Wed, 11 May 2016 22:06:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

python3 cares more about invalid type comparisons. Add break statements
and better tests to make the code paths clearer and avoid type issues
in python3. No code functionality change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 8b3fe5a..aaaafc5 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1085,15 +1085,19 @@ class RunQueue:
                 stampfile3 = bb.build.stampfile(taskname2 + "_setscene", self.rqdata.dataCache, fn2)
                 t2 = get_timestamp(stampfile2)
                 t3 = get_timestamp(stampfile3)
+                if t3 and not t2:
+                    continue
                 if t3 and t3 > t2:
-                   continue
+                    continue
                 if fn == fn2 or (fulldeptree and fn2 not in stampwhitelist):
                     if not t2:
                         logger.debug(2, 'Stampfile %s does not exist', stampfile2)
                         iscurrent = False
+                        break
                     if t1 < t2:
                         logger.debug(2, 'Stampfile %s < %s', stampfile, stampfile2)
                         iscurrent = False
+                        break
                     if recurse and iscurrent:
                         if dep in cache:
                             iscurrent = cache[dep]



