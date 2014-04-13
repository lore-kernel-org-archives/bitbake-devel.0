Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 335B965EBA
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 10:50:03 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s3DAnwnD008127 for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 11:49:58 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ylbXoJg1oeQF for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 11:49:58 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s3DAnogE008119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 11:49:54 +0100
Message-ID: <1397386185.15843.51.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 13 Apr 2014 11:49:45 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bitbake-worker: Drop BBHASH variables
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
X-List-Received-Date: Sun, 13 Apr 2014 10:50:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Iterating through and calling setVar on this number of variables has significant
overhead in the profiling data. By not setting this, we save 3,000 calls
to setVar which gives a noticeable improvement to the speed of task execution.

The BBHASH variables have since been replaced by accessing that data through
the siggen code and going forward, that is the preferred way work with it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 68e2bf4..05e0cf6 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -159,10 +159,6 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
             try:
                 the_data = bb.cache.Cache.loadDataFull(fn, appends, data)
                 the_data.setVar('BB_TASKHASH', workerdata["runq_hash"][task])
-                for h in workerdata["hashes"]:
-                    the_data.setVar("BBHASH_%s" % h, workerdata["hashes"][h])
-                for h in workerdata["hash_deps"]:
-                    the_data.setVar("BBHASHDEPS_%s" % h, workerdata["hash_deps"][h])
 
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 



