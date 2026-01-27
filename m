Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55866D340AA
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15114.1769529915105075590
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=grlmB4Cu;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZ8880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=QeSdJdSAJDn/TYYD0RfRnNOFhR3Zj+VeZDyDLHrZNeU=; b=grlmB4CutQSY
	zI09zuDXMcCFAaajt+Pelb4Q5x232ZNN1cfgbq8WkemJmFsQW09C65FSn1dbfCul
	p8Fvz/R+5UOnsDbetaPRz/wVH/efNJM8XymHWwlauzDX+18QoZLkOp3zHzMm8oWi
	In9l5X8k7UarKKI41riR2i/nArvQtA0wL/JZcB9J9Yo7/XwicnJkdOJWv7ahpNON
	So4KMnWxyOC474HdKVyEu5m7go1q/fI0PYrgEqRatXeG8UuUqq6I95hncTzjcOsF
	9RSUlAwiUH5Cro+uQ8ja5mezobsB58wC8/KSnkTxkdn6PP7l+2lSj49Hh1JJc7vk
	vGXMAQlyEg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:14 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 27 Jan 2026 08:05:13 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 27 Jan 2026 08:05:13 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 01/10] bitbake-setup: Add the conditional script stanza
Date: Tue, 27 Jan 2026 08:04:58 -0800
Message-ID: <20260127160508.3392732-2-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vufpZrQBmWl0SyHmcYbJGBraWZ3gRoB9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfX6TkDp5+sXhqc
 +E2aSJ5PGP410mjOWt3fqT6vBMACWYBiGpL0IfFQ0SpDSEGLsJEIqIrmMpWSNIR+J65eSXsTFr5
 ZBeJavJ78QUfsliLf2OmfXP3GvgS6gOLINLUbxEPDKTVX56W1FXlMbGFkdBrK2c0MnV0GdXmjle
 flZVwcOgOJvGiySrc6JIE70lZlZ1ZzRJ4XkhnGBPx8SeK9eyHsVfboioU/LWJmwTJXrsAjhxxDz
 xw2gQBF3JOsescYovoakQoLntNSA2gupWphYO64QgReBL7QqgkJCWoHXHEPuLuTQslueeMPWq/N
 O6IxZP8XTfgtI+LR6vofL7zezPPWvdwzoKDZVT2dw7LUVSv7S2RwYxWStHOxr0bsGi3T4gEyHOB
 zZQTZ4ejKhdRb+yKPrgw1dj8P+s4w/ldSpumApP4Xg0SqWoC9kmGOZkffd50wICOQaiMlbIkUEV
 AVqMEC59sC+UG1XXbIg==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23a cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=_k73aZGFW5cUGM1rhHsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: vufpZrQBmWl0SyHmcYbJGBraWZ3gRoB9
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18890

This ensures that the main function is only executed if
the module is executed in the top-level environment.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index a69dc750..d23582dd 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1106,4 +1106,5 @@ def main():
         from argparse import Namespace
         parser.print_help()
 
-main()
+if __name__ == '__main__':
+    main()
-- 
2.49.0


