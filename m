Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 9647460144
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 22:32:10 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0LMW5Ja004828 for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 22:32:06 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jDWIN3C8_RLx for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 22:32:05 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0LMVxTi004825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 22:32:01 GMT
Message-ID: <1390343512.874.124.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 21 Jan 2014 22:31:52 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Only attempt to print closest matching task if there is a match
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
X-List-Received-Date: Tue, 21 Jan 2014 22:32:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This avoids backtraces some people have been seeing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 4577236..bf2dc54 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1224,12 +1224,11 @@ class RunQueue:
             if match is None:
                 bb.fatal("Can't find a task we're supposed to have written out? (hash: %s)?" % h)
             matches = {k : v for k, v in matches.iteritems() if h not in k}
-            latestmatch = sorted(matches.keys(), key=lambda f: matches[f])[-1]
-            prevh = __find_md5__.search(latestmatch).group(0)
-            output = bb.siggen.compare_sigfiles(latestmatch, match, recursecb)
-            bb.plain("\nTask %s:%s couldn't be used from the cache because:\n  We need hash %s, closest matching task was %s\n  " % (pn, taskname, h, prevh) + '\n  '.join(output))
-             
-
+            if len(matches):
+                latestmatch = sorted(matches.keys(), key=lambda f: matches[f])[-1]
+                prevh = __find_md5__.search(latestmatch).group(0)
+                output = bb.siggen.compare_sigfiles(latestmatch, match, recursecb)
+                bb.plain("\nTask %s:%s couldn't be used from the cache because:\n  We need hash %s, closest matching task was %s\n  " % (pn, taskname, h, prevh) + '\n  '.join(output))
 
 class RunQueueExecute:
 



