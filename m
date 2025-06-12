Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A907DC61CE8
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 09:32:23 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.8668.1749720733836569792
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Jun 2025 02:32:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=825815661b=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C6ZhO9002962;
	Thu, 12 Jun 2025 02:32:11 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 474gq45a1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Jun 2025 02:32:11 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 12 Jun 2025 02:32:06 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 12 Jun 2025 02:32:06 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex@linutronix.de>
Subject: [PATCH v3] bitbake-getvar: skip info output of bitbake for quiet
Date: Thu, 12 Jun 2025 02:32:06 -0700
Message-ID: <20250612093206.168888-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Qrde3Uyd c=1 sm=1 tr=0 ts=684a9e9b cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=6IFa9wvqVegA:10 a=t7CeM3EgAAAA:8 a=YSxngP-ukz8ntoBYxa0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: qiHFuViSJx6BqXoFcdacX7q8JzPvHFsf
X-Proofpoint-ORIG-GUID: qiHFuViSJx6BqXoFcdacX7q8JzPvHFsf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA3MyBTYWx0ZWRfX/GHtgsts82sT oTsnzFLzsIIGauIR691pMdUuXuGwJr4ombCezjtWT9hDPmtOm0DJmtlI4DZPeTeKkBsHYmfZgIu bFKJfCk9sanBWukoRPGEqpwd1AYKbImLttywqwgRg+hKjZ2alhBZNCjZZr0z9/u6N0DNhnjJZFv
 sdjP3GmlbKK9NKLQPH+jUN0CKkgYYzzf+B6NHLhhnDQfKlx+URqCMbpNh+zDO4tzICbXzrOjeXq Kkcf5U0tDqqKezn+3oFxQRZ9cq8+qwBKOX18C2UGTSNcqNzIO1IfRXCmQum/Nyvjc10zauSR25W xs1qtX/myA5wl8RcjVAHKT8fV4OBsCbGZn2brQplJMHGcj+rXpUVEKtH5wkV5YcDNzUJZE09HVp
 3CUxZrv45qiLcyxYm2mhVtcuu0nSQeywb2RZd0nstEyYjKEDmIugUG4xroJ9tfetCUpq+qFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506120073
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jun 2025 09:32:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17698

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
output of bitbake-getvar was mixed with info output of bitbake
...
NOTE: Reconnecting to bitbake server...
NOTE: Retrying server connection (#1)... (18:55:53.009687)
...

Set logger level to logging.WARNING to skip info output
for quiet

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 bin/bitbake-getvar | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 1719824d9..378fb1357 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -10,6 +10,7 @@ import io
 import os
 import sys
 import warnings
+import logging
 warnings.simplefilter("default")
 
 bindir = os.path.dirname(__file__)
@@ -38,6 +39,10 @@ if __name__ == "__main__":
             sys.exit("--flag only makes sense with --value")
 
     quiet = args.quiet or args.value
+    if quiet:
+        logger = logging.getLogger("BitBake")
+        logger.setLevel(logging.WARNING)
+
     with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not quiet) as tinfoil:
         if args.recipe:
             tinfoil.prepare(quiet=3 if quiet else 2)
-- 
2.49.0


