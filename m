Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5679E6B5DA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 0583B1858B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 16:32:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id CxoNqElDcqVg for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 16:32:03 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id C3EE918701
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:55:53 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id AD2FEAC4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:55:53 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id A21FDAC0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:55:53 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id A00D934005
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:55:53 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id s1KEtr5f021103
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Feb 2014 15:55:53 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id s1KEtrA0021100
	for bitbake-devel@lists.openembedded.org;
	Thu, 20 Feb 2014 15:55:53 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Feb 2014 15:55:51 +0100
Message-Id: <c7f06c48293a2d7edc3894fe5259a8704afd1e17.1392908060.git.pkj@axis.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <cover.1392908060.git.pkj@axis.com>
References: <cover.1392908060.git.pkj@axis.com>
In-Reply-To: <cover.1392908060.git.pkj@axis.com>
References: <cover.1392908060.git.pkj@axis.com>
Subject: [PATCH 1/1] bitbake: Disable pseudo in runfetchcmd()
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
X-List-Received-Date: Thu, 20 Feb 2014 15:32:12 -0000

If a fetcher, e.g., git, is run when pseudo is active it will think it
is running as root. If it in turn uses ssh (as git does), ssh too will
think it is running as root. This will cause it to try to read root's
ssh configuration from /root/.ssh which will fail. If ssh then needs to
ask for credentials it will hang indefinitely as there is nowhere for it
to ask the user for them (and even if there was it would not access the
correct private keys).

The solution to the above is to temporarily disable pseudo while
executing any fetcher commands. There should be no reason for them to be
executed under pseudo anyway so this should not be a problem.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index de95074..1c3ee4f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -680,6 +680,9 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
         if val:
             cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
 
+    # Disable pseudo as it may affect ssh, potentially causing it to hang.
+    cmd = 'export PSEUDO_DISABLED=1; ' + cmd
+
     logger.debug(1, "Running %s", cmd)
 
     success = False
-- 
1.8.4


