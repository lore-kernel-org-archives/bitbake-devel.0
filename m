Return-Path: <rpjday@crashcourse.ca>
Received: from smtp684.redcondor.net (smtp684.redcondor.net [208.80.206.84])
	by mail.openembedded.org (Postfix) with ESMTP id B21EF65CA8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Aug 2014 09:18:19 +0000 (UTC)
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by smtp684.redcondor.net ({700db0a8-6fb7-4c8b-9b2a-6812225182d8})
	via TCP (outbound) with ESMTPS id 20140812091819703
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Aug 2014 09:18:19 +0000
X-RC-FROM: <rpjday@crashcourse.ca>
X-RC-RCPT: <bitbake-devel@lists.openembedded.org>
Received: from [99.240.204.5] (port=33491 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1XH8Df-0002D7-CL for bitbake-devel@lists.openembedded.org;
	Tue, 12 Aug 2014 05:18:15 -0400
Date: Tue, 12 Aug 2014 05:18:11 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1408120517160.18587@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-MAG-OUTBOUND: ccj.redcondor.net@64.235.106.9/32
Subject: [PATCH] daemonize.py: Non-functional comment/aesthetic fixes.
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
X-List-Received-Date: Tue, 12 Aug 2014 09:18:21 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index f0714b3..898820b 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -1,5 +1,5 @@
 """
-Python Deamonizing helper
+Python Daemonizing helper

 Configurable daemon behaviors:

@@ -25,7 +25,7 @@ __version__ = "0.2"

 # Standard Python modules.
 import os                    # Miscellaneous OS interfaces.
-import sys                  # System-specific parameters and functions.
+import sys                   # System-specific parameters and functions.

 # Default daemon parameters.
 # File mode creation mask of the daemon.
@@ -128,7 +128,7 @@ def createDaemon(function, logfile):
     # of methods to accomplish this task.  Three are listed below.
     #
     # Try the system configuration variable, SC_OPEN_MAX, to obtain the maximum
-    # number of open file descriptors to close.  If it doesn't exists, use
+    # number of open file descriptors to close.  If it doesn't exist, use
     # the default value (configurable).
     #
     # try:

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


