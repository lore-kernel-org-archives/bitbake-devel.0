Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38362D340A4
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14886.1769529916172075486
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=iEXmsqMX;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZB880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=HZnmh1DoO1RQUKcBrz2BjZsGjon5gv84p3593IPKBS4=; b=iEXmsqMX2Byc
	n1L70DZ00DlRlpqaORilF6QVkO8dxS1QG0whgbtK3VwadSURdNyziY9CN8p69j4G
	Ot/16DnwKkZNoY9EiiMlco417X+XSdv+3wOHpPwykG3tk1LZt2IJZKIkTE/wLxMm
	ftz5448Ed1ktgIezCesdz/DyMqm1NjrMwKzDwMkKFZH20kyY3BYcWcSSqCFx45n7
	+s05FLxKTsusdUQfMmPU0kpEnzcZViA2NXlLs1Bc8jaV+5eRqsAHJRMErYqtpkDO
	K1GJMVdX8BSE7IpxQh7uVR6m5wsVKUynmHkcxuyT5GcYuQuKVXD5gtAe6/2Oo5c1
	VVoV4t352A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:15 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 27 Jan 2026 08:05:14 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 27 Jan 2026 08:05:14 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 04/10] bitbake-setup: Sort and format imports
Date: Tue, 27 Jan 2026 08:05:01 -0800
Message-ID: <20260127160508.3392732-5-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gyy0ktMBI06G0OF1Aw8YIgg0NWkmN26R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfX2PmLV4hS36Ze
 5oezsjStBV6gMWuATmOLFG5PBejo1jIp/V1PRmQ87sefo4bk3RzvECBAiaNjCQYvWmiBSWt8kHg
 UJgCFSrtUp/5WegzfUHMH80U+P+65ZLHUWxm8dXl3EDJaWC9WdiL0YX8zo7dwH3t4kz0Y/ExQlR
 Zb2itmM+basDLyfenQziHfZ/sochDhPwjyxLzjG9snFxrWmIs599aydvxeIMf3oQyd4A5zlzC52
 /teTBvJbqkiVci5s9Wiu5Apyt6jzwnJ0UARe+nq7NYBowMvQ24JeYWtIadvU4qtS+Xv9ZN90B9d
 6LW28A5QcWVnvTMaiEcpkbOhyNGJkegcVLZY7oV+n2W+eLTh7KVjeR3NUGjHfGg73PupJlxb+Xm
 ynUchFr2Fvw9ayiSeVWULI6Jt0/zJTj1bcRjKT6PVx7EhYyGSXIy8gEuq7rfUhC7144+bHgNBzj
 LHPi494BIZ2AC0hlqxQ==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23b cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=NhU3BdNfeI68Uu5h_4oA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: gyy0ktMBI06G0OF1Aw8YIgg0NWkmN26R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270131
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 16:05:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18893

The ruff linting tool reported 2 problems:
    I001 Import block is un-sorted or un-formatted
    E402 Module level import not at top of file

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index a52a95b8..2b611864 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -4,29 +4,28 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import logging
-import os
-import sys
 import argparse
-import json
-import shutil
-import time
 import configparser
+import copy
 import datetime
+import functools
 import glob
-import subprocess
-import copy
-import textwrap
+import json
+import logging
+import os
+import shutil
 import signal
-import functools
 import string
-
-bindir = os.path.abspath(os.path.dirname(__file__))
-sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
+import subprocess
+import sys
+import textwrap
+import time
 
 import bb.msg
 import bb.process
 
+bindir = os.path.abspath(os.path.dirname(__file__))
+sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
 logger = bb.msg.logger_create('bitbake-setup', sys.stdout)
 
 # These settings can only be set in the global context
-- 
2.49.0


