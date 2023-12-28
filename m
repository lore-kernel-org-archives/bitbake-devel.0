Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C5C3DA6E
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 21:01:31 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.131933.1703797282489990935
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Dec 2023 13:01:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=HHqTKo3V;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=1726e0f95c=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BSKxQZB017931;
	Thu, 28 Dec 2023 13:01:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=5D7ekZFYnqQL5BKMOGYnGjsp0t50v7wzVeKjj0Vauyw=; b=
	HHqTKo3VUAOw4c8qcEHQEcwjq0gCw9oqyrtUrUvM/CcK8wZtrFq2xhgCPbXv8KP2
	jNsD+onxMYxy3KRznwnEFYSxgUeU86ZUJoWfdCShsZdI3ePx232KFGjFW4XO8nNS
	KlWiU6vP4jTuAufLt3mUOY7K2q5FFq3bh5lPwgMjdjAJ2hgUGLsPOqAm5vazCz6F
	VDCtzohqlC73tMMBDl50SQ6PPyrMmb79hnhpFHI1drGS6amcpQBP6q0O5aKiLJdZ
	6KvmLkuPBtQEwvbentWAtECaz6fnD2XST1LGMZjNTNnKXVM8DvBu5AariBjpUH+i
	yesb0kHyyIDKQqnR7P4D1g==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5yxm4ax0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 28 Dec 2023 13:01:21 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 13:01:24 -0800
Received: from YOW-MASSELST-L1.corp.ad.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 13:01:24 -0800
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <mark.asselstine@windriver.com>, <bitbake-devel@lists.openembedded.org>,
        <richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/2] ui/knotty: properly handle exceptions when calling runCommand()
Date: Thu, 28 Dec 2023 16:01:18 -0500
Message-ID: <20231228210118.9273-2-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231228210118.9273-1-mark.asselstine@windriver.com>
References: <20231228210118.9273-1-mark.asselstine@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6MohT8Q7V7D8HAnj2y5bk928JdFmIT2f
X-Proofpoint-ORIG-GUID: 6MohT8Q7V7D8HAnj2y5bk928JdFmIT2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=931
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312280167
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Dec 2023 21:01:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15714

In runCommand() the send() and recv() can fail and raise
BrokenPipeError and EOFError exceptions when the bitbake-server is
unexpectedly terminated. In these cases a python traceback is
currently dumped. Similarly updateFromServer() which calls
runCommand() can also raise these and other exceptions, and currently
lacks proper exception handling resulting in python traceback.

We wrap calls to runCommand() and updateFromServer() in a try/except
block as well as improve the exception handling for updateToServer().

This along with the earlier commit which added text to the
BrokenPipeError and EOFError exceptions in runCommand() to indicate a
bitbake-server termination may have occurred, should improve the user's
ability to understand and handle these errors.

An easy way to trigger each of the runCommand() exceptions is to
'kill -9' bitbake-server before (causes EOFError) or after
(causes BrokenPipeError) the "Loading Cache" stage.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 lib/bb/ui/knotty.py | 62 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 431baa15..5a97d040 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -420,6 +420,11 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     except bb.BBHandledException:
         drain_events_errorhandling(eventHandler)
         return 1
+    except Exception as e:
+        # bitbake-server comms failure
+        early_logger = bb.msg.logger_create('bitbake', sys.stdout)
+        early_logger.fatal("Attempting to set server environment: %s", e)
+        return 1
 
     if params.options.quiet == 0:
         console_loglevel = loglevel
@@ -585,7 +590,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         return
 
     llevel, debug_domains = bb.msg.constructLogOptions()
-    server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
+    try:
+        server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
+    except (BrokenPipeError, EOFError) as e:
+        # bitbake-server comms failure
+        logger.fatal("Attempting to set event mask: %s", e)
+        return 1
 
     # The logging_tree module is *extremely* helpful in debugging logging
     # domains. Uncomment here to dump the logging tree when bitbake starts
@@ -594,7 +604,11 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
     universe = False
     if not params.observe_only:
-        params.updateFromServer(server)
+        try:
+            params.updateFromServer(server)
+        except Exception as e:
+            logger.fatal("Fetching command line: %s", e)
+            return 1
         cmdline = params.parseActions()
         if not cmdline:
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
@@ -605,7 +619,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if cmdline['action'][0] == "buildTargets" and "universe" in cmdline['action'][1]:
             universe = True
 
-        ret, error = server.runCommand(cmdline['action'])
+        try:
+            ret, error = server.runCommand(cmdline['action'])
+        except (BrokenPipeError, EOFError) as e:
+            # bitbake-server comms failure
+            logger.fatal("Command '{}' failed: %s".format(cmdline), e)
+            return 1
         if error:
             logger.error("Command '%s' failed: %s" % (cmdline, error))
             return 1
@@ -854,15 +873,26 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             logger.error("Unknown event: %s", event)
 
+        except (BrokenPipeError, EOFError) as e:
+            # bitbake-server comms failure, don't attempt further comms and exit
+            logger.fatal("Executing event: %s", e)
+            return_value = 1
+            errors = errors + 1
+            main.shutdown = 3
         except EnvironmentError as ioerror:
             termfilter.clearFooter()
             # ignore interrupted io
             if ioerror.args[0] == 4:
                 continue
             sys.stderr.write(str(ioerror))
-            if not params.observe_only:
-                _, error = server.runCommand(["stateForceShutdown"])
             main.shutdown = 2
+            if not params.observe_only:
+                try:
+                    _, error = server.runCommand(["stateForceShutdown"])
+                except (BrokenPipeError, EOFError) as e:
+                    # bitbake-server comms failure, don't attempt further comms and exit
+                    logger.fatal("Unable to force shutdown: %s", e)
+                    main.shutdown = 3
         except KeyboardInterrupt:
             termfilter.clearFooter()
             if params.observe_only:
@@ -871,9 +901,13 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             def state_force_shutdown():
                 print("\nSecond Keyboard Interrupt, stopping...\n")
-                _, error = server.runCommand(["stateForceShutdown"])
-                if error:
-                    logger.error("Unable to cleanly stop: %s" % error)
+                try:
+                    _, error = server.runCommand(["stateForceShutdown"])
+                    if error:
+                        logger.error("Unable to cleanly stop: %s" % error)
+                except (BrokenPipeError, EOFError) as e:
+                    # bitbake-server comms failure
+                    logger.fatal("Unable to cleanly stop: %s", e)
 
             if not params.observe_only and main.shutdown == 1:
                 state_force_shutdown()
@@ -886,6 +920,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     _, error = server.runCommand(["stateShutdown"])
                     if error:
                         logger.error("Unable to cleanly shutdown: %s" % error)
+                except (BrokenPipeError, EOFError) as e:
+                    # bitbake-server comms failure
+                    logger.fatal("Unable to cleanly shutdown: %s", e)
                 except KeyboardInterrupt:
                     state_force_shutdown()
 
@@ -893,9 +930,14 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         except Exception as e:
             import traceback
             sys.stderr.write(traceback.format_exc())
-            if not params.observe_only:
-                _, error = server.runCommand(["stateForceShutdown"])
             main.shutdown = 2
+            if not params.observe_only:
+                try:
+                    _, error = server.runCommand(["stateForceShutdown"])
+                except (BrokenPipeError, EOFError) as e:
+                    # bitbake-server comms failure, don't attempt further comms and exit
+                    logger.fatal("Unable to force shutdown: %s", e)
+                    main.shudown = 3
             return_value = 1
     try:
         termfilter.clearFooter()
-- 
2.30.2


