Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id AA50A6F60F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 16:59:36 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s29GxVJW020137
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 16:59:32 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1wL_xTzKmBeU for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 16:59:31 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s29GxPo9020132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 16:59:29 GMT
Message-ID: <1394384359.7883.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 09:59:19 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bitbake-worker: Gracefully handle SIGTERM
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
X-List-Received-Date: Sun, 09 Mar 2014 16:59:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if bitbake-worker handles a SIGTERM, it leaves the child
processes to complete or hang. It shouldn't do this so hook the SIGTERM
event and gracefully shutdown any children.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index bc13b4f..c173dbe 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -242,6 +242,14 @@ class BitbakeWorker(object):
         self.build_pids = {}
         self.build_pipes = {}
     
+        signal.signal(signal.SIGTERM, self.sigterm_exception)
+
+    def sigterm_exception(self, signum, stackframe):
+        bb.warn("Worker recieved SIGTERM, shutting down...")
+        self.handle_finishnow(None)
+        signal.signal(signal.SIGTERM, signal.SIG_DFL)
+        os.kill(os.getpid(), signal.SIGTERM)
+
     def serve(self):        
         while True:
             (ready, _, _) = select.select([self.input] + [i.input for i in self.build_pipes.values()], [] , [], 1)



