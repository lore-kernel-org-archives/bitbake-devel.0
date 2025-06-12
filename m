Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4621FC71136
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 05:07:12 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.5645.1749704830573470408
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Jun 2025 22:07:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=825815661b=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C4GFdB018053
	for <bitbake-devel@lists.openembedded.org>; Wed, 11 Jun 2025 22:07:10 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 474mxm4x4c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 11 Jun 2025 22:07:09 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Wed, 11 Jun 2025 22:07:09 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 11 Jun 2025 22:07:09 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] bb/main.py: skip noisy output for bitbake-getvar
Date: Wed, 11 Jun 2025 22:07:09 -0700
Message-ID: <20250612050709.3588563-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zbI0TqDuOHQPm1rN8V3KyonHQEOavWsK
X-Authority-Analysis: v=2.4 cv=L74dQ/T8 c=1 sm=1 tr=0 ts=684a607d cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=6IFa9wvqVegA:10 a=t7CeM3EgAAAA:8 a=2V6DY6BgAAAA:8 a=Fw7Cb76GGXH5t5FYty0A:9 a=FdTzh2GWekK77mhwV6Dw:22
 a=ldqKKs2zR4t-S6fqr-1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDAzNiBTYWx0ZWRfX4AAkmJx51Ofd /AO0plhEk1I3L3KN0tJdGZ3d0f8sZd2yVUfubs4w+RRZPhewHBaFx0ZQefNUQ7klBFBNpBZA1Bj zgnXdRrZ53c1bP40cbTENkKcUCgFrSVXiwE9Bh97aFZqlstHf1QZSYYIKshcm3UYT4epZwkVnZa
 PQ0dSMzk6waoUdtRSI/adV5T3MPYhFUqtua143y2x6W2lIYFgrL5BT0v0mcXeDHswIpuQYvNkZ4 Ly7x3F1HWFIJ0iQHKWIGaLlF/gYYAq0Y5n1DEna2FRmHYeV/TKXicycQ1cIl8QCwjKTOxOQ86G3 KyCDIxeDPV0hfMxxo4bzUZjlEKZ18GbMkhxadcyYoCFc8lgEcheJZG3MAYG/KgPNpdsNEHvG3yr
 RDtkBV0e8x9HKkC9nAi3wmC0NQ/DdHuBJTMYaKnEZmyzML0gmTzGE9fip03VTBZROJ79azsh
X-Proofpoint-ORIG-GUID: zbI0TqDuOHQPm1rN8V3KyonHQEOavWsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_02,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506120036
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jun 2025 05:07:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17694

Calling oe-debuginfod in a build failed:
...
$ oe-debuginfod
|Getting sysroot...
|Error: NOTE: Reconnecting to bitbake server...
|NOTE: Retrying server connection (#1)... (18:55:53.009687)
|path-to-build/tmp/work/x86_64-linux/elfutils-native/0.192/recipe-sysroot-native doesn't exist.
|Have you run 'bitbake elfutils-native -caddto_recipe_sysroot'?
...

The script oe-debuginfod calls bitbake-getvar to get sysroot, the
output of bitbake-getvar was mixed with output of bitbake
...
NOTE: Reconnecting to bitbake server...
NOTE: Retrying server connection (#1)... (18:55:53.009687)
...

Because script bitbake-getvar sets 2 or 3 to quiet level, improve
the output of bitbake, skip reconnect output if quiet < 2

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 lib/bb/main.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index bca8ebfa0..a2285e507 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -468,7 +468,8 @@ def setup_bitbake(configParams, extrafeatures=None):
                     server = bb.server.process.BitBakeServer(lock, sockname, featureset, configParams.server_timeout, configParams.xmlrpcinterface, configParams.profile)
 
                 else:
-                    logger.info("Reconnecting to bitbake server...")
+                    if configParams.quiet < 2:
+                        logger.info("Reconnecting to bitbake server...")
                     if not os.path.exists(sockname):
                         logger.info("Previous bitbake instance shutting down?, waiting to retry... (%s)" % timestamp())
                         procs = bb.server.process.get_lockfile_process_msg(lockfile)
@@ -499,9 +500,11 @@ def setup_bitbake(configParams, extrafeatures=None):
                 retries -= 1
                 tryno = 8 - retries
                 if isinstance(e, (bb.server.process.ProcessTimeout, BrokenPipeError, EOFError, SystemExit)):
-                    logger.info("Retrying server connection (#%d)... (%s)" % (tryno, timestamp()))
+                    if configParams.quiet < 2:
+                        logger.info("Retrying server connection (#%d)... (%s)" % (tryno, timestamp()))
                 else:
-                    logger.info("Retrying server connection (#%d)... (%s, %s)" % (tryno, traceback.format_exc(), timestamp()))
+                    if configParams.quiet < 2:
+                        logger.info("Retrying server connection (#%d)... (%s, %s)" % (tryno, traceback.format_exc(), timestamp()))
 
             if not retries:
                 bb.fatal("Unable to connect to bitbake server, or start one (server startup failures would be in bitbake-cookerdaemon.log).")
-- 
2.49.0


