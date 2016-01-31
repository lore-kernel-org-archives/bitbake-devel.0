Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8DF51771D8
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 31 Jan 2016 13:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0VDVhtn016007 for <bitbake-devel@lists.openembedded.org>;
	Sun, 31 Jan 2016 13:31:43 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KaeJHi27mzj9 for <bitbake-devel@lists.openembedded.org>;
	Sun, 31 Jan 2016 13:31:43 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0VDVfLA016004
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 31 Jan 2016 13:31:42 GMT
Message-ID: <1454247101.27087.19.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 31 Jan 2016 13:31:41 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Only start as many parse threads as we need
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
X-List-Received-Date: Sun, 31 Jan 2016 13:31:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If we're only going to parse one recipe, no point in starting 
a large number of threads.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index a1182ef..1f4174f 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1986,8 +1986,6 @@ class CookerParser(object):
         self.total = len(filelist)
 
         self.current = 0
-        self.num_processes = int(self.cfgdata.getVar("BB_NUMBER_PARSE_THREADS", True) or
-                                 multiprocessing.cpu_count())
         self.process_names = []
 
         self.bb_cache = bb.cache.Cache(self.cfgdata, self.cfghash, cooker.caches_array)
@@ -2002,6 +2000,9 @@ class CookerParser(object):
         self.toparse = self.total - len(self.fromcache)
         self.progress_chunk = max(self.toparse / 100, 1)
 
+        self.num_processes = min(int(self.cfgdata.getVar("BB_NUMBER_PARSE_THREADS", True) or
+                                 multiprocessing.cpu_count()), len(self.willparse))
+
         self.start()
         self.haveshutdown = False
 



