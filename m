Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F4A10AB80E
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55638.1774551471653114543
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=epY0niUb;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcT3113430;
	Thu, 26 Mar 2026 18:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=OemejJY6yt0spv6TlaTZRz9HQu+DAng7HIFWVhfOa0s=; b=
	epY0niUbAO06C82V1E5LjSeJcKArp8AJ4hMfGO3GdR2mHdQvx+OKWWRfzh3mL6VL
	b/okxj3efhAySmuXgb2DPQavVzCzvt5vdD0MEeAd53/bjWByVfxA0wZ+ATksmpAF
	rSWCbIa6fhviKKRPqWgSbLk5Jz75eAgDF8X92iIKUyyuNZWi3EKADFc9CCwP6iSt
	lZsQyR+kkiF+BQUJklxM/8vDGNUTgTW803JWl6gkveNctsGcoC7fJi4nqdU/GPaa
	WC02HUgF+joc4jdzLJMD6Uz0N8WfbW3qypPDIGvWJOwPA0VLb/Q5pgdDo+OIo3S8
	8+Y5mGXW/pOxh0wAPES9/A==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 18:57:50 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 11:57:45 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 11:57:45 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 11/11] bitbake-setup: Sort and format imports
Date: Thu, 26 Mar 2026 11:57:42 -0700
Message-ID: <20260326185742.542268-12-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: D9GGGFb_iPY81oDxmve7iDiU24humFo4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfX1cJ3WrzY3Jdx
 UUZMHI6u+PPfkjWEInderSCvm39CaTHmD0RfxBnex9Rk/9ItDdhZuxionIJtJzY8EiXmjp1P4FM
 d23/YUwnSE67HSsrAoqRrrWc4Y6OwKAZT9jPfC5ABBA0KUoUJffF014oo956jBnumko9uOa8roi
 Lov1YANRrGG8EKqpLgMa+/mUlDnEIUTqKYQFnQnSD2JmvbBwi3ldD3BtvzKk7+26J5MfGK+oraz
 Z78YGyfIevpXA6XBvG6o2fLIVRb1jxSZgjGYrAdJEIPFan4yOfKhGjfAD0BHWYhLXdl5RhtuVp9
 aDaPnbbv1gI4mJFpVFTbnjMphgQsLJvHA9ZA3vE3R6fmBdAGEbVFLm/cnRTKJJAWSdhwpLVOBsF
 rMT/Nz/Bujy0cZWx4gnjLYlw5YtMciDXRZz3k3AFN97ZPZn/ifGk9WjlyLe2MW9HufDjF55qTdc
 0OcwRdC13OGn9qJM+Ng==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581ae cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=rW-RdPFMKUCdcBzMzRMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: D9GGGFb_iPY81oDxmve7iDiU24humFo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260136
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 18:57:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19256

The ruff linting tool reported 2 problems:
    I001 Import block is un-sorted or un-formatted
    E402 Module level import not at top of file

An exception is made for sys.path modifications needed to
find the modules.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 6b210cd3e..ce712e517 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -4,28 +4,29 @@
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
+import subprocess
+import sys
+import textwrap
+import time
+
 
 bindir = os.path.abspath(os.path.dirname(__file__))
 sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
 
-import bb.msg
-import bb.process
+import bb.msg  # noqa: E402
+import bb.process  # noqa: E402
 
 logger = bb.msg.logger_create('bitbake-setup', sys.stdout)
 
-- 
2.39.5


