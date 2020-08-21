Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 by mx.groups.io with SMTP id smtpd.web12.125565.1597977567023078163
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Aug 2020 19:39:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.1.11, mailfrom: hongxu.jia@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 07L2dNCo018684
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Thu, 20 Aug 2020 19:39:24 -0700 (PDT)
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 19:39:23 -0700
From: "hongxu" <hongxu.jia@windriver.com>
To: <bitbake-devel@lists.openembedded.org>,
        <richard.purdie@linuxfoundation.org>
Subject: [PATCH] server/process: fix exit racing between process and thread
Date: Fri, 21 Aug 2020 10:39:21 +0800
Message-ID: <20200821023921.9633-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain

Since commit [d214e55c4 server/process: Remove pointless process
forking][1] applied, there is an exit racing between process and
thread which causing bb_cache.dat generation to be broken

Here is a simple way to reproduce on poky

1) Edit poky
[Edit poky]
|--- a/bitbake/lib/bb/cooker.py
|+++ b/bitbake/lib/bb/cooker.py
|@@ -2126,11 +2126,13 @@ class CookerParser(object):
|                 process.join()
|
|         def sync_caches():
|+            time.sleep(2)
|             for c in self.bb_caches.values():
|                 c.sync()
|
|         sync = threading.Thread(target=sync_caches)
|         sync.start()
|+        # While multiprocess exit, it should wait thread to terminate
|         multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
|         bb.codeparser.parser_cache_savemerge()
|         bb.fetch.fetcher_parse_done()
[Edit poky]

2) Run in build
$ rm cache/ sstate-cache/  tmp/* -rf
$ bitbake -p
$ sleep 2
$ ls tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat* -sh
|0 tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat

Only a dying symlink, no real bb_cache.dat file was generated.
When shutdown, it calls sync_caches in a thread to generate
bb_cache.dat, and the thread is broken without finish

Get multiprocessing.Process back, then above multiprocessing.util.Finalize
will work, while process exit, it will wait the thread to terminate

After applying the fix, bb_cache.dat is generated correctly:
$ ls tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat* -sh
|  0 tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat
|16M tmp/cache/default-glibc/qemux86-64/x86_64/bb_cache.dat.d2a12348d0bc9d63f396ffe81c752a4cfa21bc9ef64466305384767f375e052a

[1] http://git.openembedded.org/bitbake/commit/?id=d214e55c45f9733b3289138feec0ae3361a4a48b

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 lib/bb/server/process.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 65e1eab52..63b82458a 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -34,11 +34,12 @@ logger = logging.getLogger('BitBake')
 class ProcessTimeout(SystemExit):
     pass
 
-class ProcessServer():
+class ProcessServer(multiprocessing.Process):
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
 
     def __init__(self, lock, sock, sockname, server_timeout, xmlrpcinterface):
+        multiprocessing.Process.__init__(self)
         self.command_channel = False
         self.command_channel_reply = False
         self.quit = False
@@ -487,7 +488,7 @@ class BitBakeServer(object):
             print("Started bitbake server pid %d" % os.getpid())
             sys.stdout.flush()
 
-            server.run()
+            server.start()
         finally:
             # Flush any ,essages/errors to the logfile before exit
             sys.stdout.flush()
-- 
2.18.2

