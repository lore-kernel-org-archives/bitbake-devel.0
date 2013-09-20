Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 9FE176028B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Sep 2013 10:30:00 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8KAiSoV015601 for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Sep 2013 11:44:28 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id y0Y0MeXmG4hB for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Sep 2013 11:44:28 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8KAiNN0015596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Sep 2013 11:44:25 +0100
Message-ID: <1379672987.18603.139.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 20 Sep 2013 11:29:47 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] build: Add BB_TASK_NICE_LEVEL to task code
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
X-List-Received-Date: Fri, 20 Sep 2013 10:30:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Linux its not possible for processes to regain a previous nice level after
it has changed. Its therefore not possible to have a core low priority and
then raise the priorities of individual tasks.

This variable allows us to do something like:

BB_TASK_NICE_LEVEL = "5"
BB_TASK_NICE_LEVEL_task-testimage = "0"

to give priority to specific tasks which the BB_NICE_LEVEL functionality
doesn't give us the option of.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 8aec699..9addd71 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -346,6 +346,13 @@ def _exec_task(fn, task, d, quieterr):
     if not tempdir:
         bb.fatal("T variable not set, unable to build")
 
+    # Change nice level if we're asked to
+    nice = localdata.getVar("BB_TASK_NICE_LEVEL", True)
+    if nice:
+        curnice = os.nice(0)
+        nice = int(nice) - curnice
+        logger.debug(1, "Renice to %s " % os.nice(nice))
+
     bb.utils.mkdirhier(tempdir)
 
     # Determine the logfile to generate



