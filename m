Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1F5C64EC4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 19:21:43 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.427.1678389700637888473
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Mar 2023 11:21:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=BBzo74Sx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=243240c5d2=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329IrFOv007474
	for <bitbake-devel@lists.openembedded.org>; Thu, 9 Mar 2023 11:21:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=uu45+QpVvR1WgZq/61R5mbZa0QUMpok/G3wkojbm2kc=;
 b=BBzo74Sxf2+qFArE2FR9WtcAq5IUUyon8m6jXzc4cCxTICaOTc2C/JGh8o6Z4VCFnY8E
 8Ohb33SP8WW2lfwheVtmofq9DJqqcqx+5YifGZogCkBOtAzWi9PsIsseWMlaSmp1lPk3
 SLmNc1wSiETGFz4I9R0U9NljeEYWEHpI/WIQMg8dpExL1O8I7Sl99z2MVICA/qA12Bsh
 7qIVXwTKI3o4bsGoYaOwO0Sl+NPUv6ysz/bWal3KSaWjV4MOj3lDXVogWPl3+PXIYQhJ
 jkzRfKQvOOEUwXu95rH+osX2aOtzaRUzd02KvQ8IDy3YfJ4iG6iZcMGcETEzUQsjmedb lQ== 
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p6fffa165-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 11:21:39 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Mar 2023 11:21:39 -0800
Received: from YOW-MASSELST-L1.corp.ad.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Thu, 9 Mar 2023 11:21:39 -0800
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] build: Make python output print to stdout when running with -v (verbose)
Date: Thu, 9 Mar 2023 14:21:38 -0500
Message-ID: <20230309192138.991-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ukhutc6v4kuZTFcdVnqd548HFMavzHAZ
X-Proofpoint-ORIG-GUID: Ukhutc6v4kuZTFcdVnqd548HFMavzHAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_10,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090155
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 19:21:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14531

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

The following example will produce out-of-order output

--
python do_build() {
   print("Start")
   bb.plain("********************");
   bb.plain("*                  *");
   bb.plain("*  Hello, World!   *");
   bb.plain("*                  *");
   bb.plain("********************");
   print("Finish")
}
--
will output
--
********************
*                  *
*  Hello, World!   *
*                  *
********************
Start
Finish
--

The logging-test.bb in meta-selftest or the above 'hello world!' can
be used to review this change.

[Yocto #14544]

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 lib/bb/build.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 5a172711..eb2d5b59 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -25,6 +25,7 @@ import bb
 import bb.msg
 import bb.process
 import bb.progress
+from io import StringIO
 from bb import data, event, utils
 
 bblogger = logging.getLogger('BitBake')
@@ -296,9 +297,17 @@ def exec_func_python(func, d, runfile, cwd=None):
         lineno = int(d.getVarFlag(func, "lineno", False))
         bb.methodpool.insert_method(func, text, fn, lineno - 1)
 
+        if verboseStdoutLogging:
+            sys.stdout.flush()
+            sys.stdout = execio = StringIO()
         comp = utils.better_compile(code, func, "exec_func_python() autogenerated")
         utils.better_exec(comp, {"d": d}, code, "exec_func_python() autogenerated")
     finally:
+        if verboseStdoutLogging:
+            execio.flush()
+            logger.plain("%s" % execio.getvalue())
+            sys.stdout = sys.__stdout__
+            execio.close()
         # We want any stdout/stderr to be printed before any other log messages to make debugging
         # more accurate. In some cases we seem to lose stdout/stderr entirely in logging tests without this.
         sys.stdout.flush()
-- 
2.30.2


