Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C5C05027
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 19:20:36 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.4094.1678821631064285252
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Mar 2023 12:20:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=jbZdP9KT;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=24370a3b27=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EJ0UbL018047
	for <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 12:20:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=kHdz7e/2lY30YaIsUu6tnmcl4eF47j1h0XNIfYpknHE=;
 b=jbZdP9KTZVYJuCFMGRUWZMIX5sl5n7HnH7rl6BuNhkH8RoGwSSIK+SmZHZE/Hl3CMEdk
 r370r+BLMCjYvd56ZuJw05TucJgiQdy/XJu/TmLCCWrDVtY/Ex9spUmelJUnvEjQ3SJj
 /bAWhev1Icc6IZBQu3sBef0zPyjclYKweJTpTEFPhzmnQObHMGDBxAXdiILo8E92wOE9
 XIlEYKmgByWJ9ydIqGbhbhMCktB6QF0cDd4SIn+cc/e2IpbbuQO05pn+FhLNs55jc4ij
 5wab9d5qdBNJ2FqKN5nokF1iK0T4nSmNvZxrnU/iCUdtr6IE3VcPCcsh3l2kOrtCcKkA XA== 
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p8t1r2vum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 12:20:30 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.18; Tue, 14 Mar 2023 12:20:29 -0700
Received: from YOW-MASSELST-L1.corp.ad.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Tue, 14 Mar 2023 12:20:29 -0700
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v3] build: Make python output print to stdout when running with -v (verbose)
Date: Tue, 14 Mar 2023 15:20:27 -0400
Message-ID: <20230314192027.8317-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KbLaDP0_Yr1o3fWlJUnrZuBJXUo66NBq
X-Proofpoint-GUID: KbLaDP0_Yr1o3fWlJUnrZuBJXUo66NBq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_12,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140158
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 19:20:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14555

When tasks are run with -v (verbose) on the bitbake commandline, shell
tasks print their stdout, python tasks do not.

This change redirects the python task's print output to an in memory
buffer. After the task is executed the output is printed to stdout via
the logger. This makes the python task behavior match the shell task
behavior when running with -v. The contents of the task's log files
remain unchanged after this change.

This approach should keep the correct order in most cases, however, if
the python task accesses the logger directly, that content will appear
before other output. On the other hand, this change should negate the
need for python tasks to access the logger directly.

Special care is taken to save/restore the existing stdout and stderr
and preventing sending output directly to the logger when there are
"recursive" calls, for instance when a python function calls a shell
function, avoiding printing things potentially out of order and/or
multiple times.

The logging-test.bb in meta-selftest can be used to review this
change. This has been tested with the full bblogging oeqa tests.

[Yocto #14544]

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---

v3:
 * returned the flush to always be run (see v2). After thinking about
   this there is a slim possibility that the try hits and exception
   before the first set of flush() calls which would result in no
   flush() calls. So it is better to keep them as they were.
 * fixed issues reported by oeqa bblogging tests, this required
   a bit more handling for "recursive" calls. See the commit log
   and code comments for details
 * return "<mem>" when there is no 'name' member, as is the case
   for io.StringIO, in StdoutNoopContextManager
 * ran oeqa bblogging tests to up the confidence in this change
   being in good shape
 * I will follow this change with an update to the bblogging tests
   to turn on the checks currently commented out due to lack of
   python functions supporting -v

v2:
 Richard, per your suggestions, I have added capturing stderr and also
 storing and restoring the previous stdout and stderr. Since we are
 already flushing stdout and stderr when verboseStdoutLogging I have
 skipped the second flushes.

 lib/bb/build.py | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 5a172711..44d08f5c 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -25,6 +25,7 @@ import bb
 import bb.msg
 import bb.process
 import bb.progress
+from io import StringIO
 from bb import data, event, utils
 
 bblogger = logging.getLogger('BitBake')
@@ -177,7 +178,9 @@ class StdoutNoopContextManager:
 
     @property
     def name(self):
-        return sys.stdout.name
+        if "name" in dir(sys.stdout):
+            return sys.stdout.name
+        return "<mem>"
 
 
 def exec_func(func, d, dirs = None):
@@ -296,9 +299,21 @@ def exec_func_python(func, d, runfile, cwd=None):
         lineno = int(d.getVarFlag(func, "lineno", False))
         bb.methodpool.insert_method(func, text, fn, lineno - 1)
 
+        if verboseStdoutLogging:
+            sys.stdout.flush()
+            sys.stderr.flush()
+            currout = sys.stdout
+            currerr = sys.stderr
+            sys.stderr = sys.stdout = execio = StringIO()
         comp = utils.better_compile(code, func, "exec_func_python() autogenerated")
         utils.better_exec(comp, {"d": d}, code, "exec_func_python() autogenerated")
     finally:
+        if verboseStdoutLogging:
+            execio.flush()
+            logger.plain("%s" % execio.getvalue())
+            sys.stdout = currout
+            sys.stderr = currerr
+            execio.close()
         # We want any stdout/stderr to be printed before any other log messages to make debugging
         # more accurate. In some cases we seem to lose stdout/stderr entirely in logging tests without this.
         sys.stdout.flush()
@@ -441,7 +456,11 @@ exit $ret
         if fakerootcmd:
             cmd = [fakerootcmd, runfile]
 
-    if verboseStdoutLogging:
+    # We only want to output to logger via LogTee if stdout is sys.__stdout__ (which will either
+    # be real stdout or subprocess PIPE or similar). In other cases we are being run "recursively",
+    # ie. inside another function, in which case stdout is already being captured so we don't
+    # want to Tee here as output would be printed twice, and out of order.
+    if verboseStdoutLogging and sys.stdout == sys.__stdout__:
         logfile = LogTee(logger, StdoutNoopContextManager())
     else:
         logfile = StdoutNoopContextManager()
-- 
2.30.2


