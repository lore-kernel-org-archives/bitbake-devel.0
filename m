Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D3DD340B0
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14890.1769529917224937637
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=H8tbTntO;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZE880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=ap34Q+Q4tt+VHNdtJqy4PV2oIzk4Uvv0VG6I2CNx2NI=; b=H8tbTntOVb0t
	ejXw4YrgSKfeQ+XOZOaOWcMQNoZ413x7PYqFX1pKiUkFCTTFLMFHqV7pT8J0iX0w
	zZJhjrku3JlCDfJFPNgfUth5nJzngzzWyB0QPdDRtL5Rfn+1eWDCa8QYqOek2NHT
	fYDe8+igQNTyPlLZRRP2L15j7M6yKD+7h1rXh667IwqkKYFi99wPmtMnneNDfcro
	n29UlC5iIuqqXi/+y5gXMmjB+9p7b1sR+c033uY+H4a/ROTKuvfh+WOxboTisnwe
	5IuEITnpG8lX2NaRTv9RQmpiW07OfGFB7wZfta2TVGB45eL+DNh7GpeX8iA7JpV8
	R0t89Ah7cg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:16 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 27 Jan 2026 08:05:14 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 27 Jan 2026 08:05:14 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 07/10] bitbake-setup: Remove unused stdout variable
Date: Tue, 27 Jan 2026 08:05:04 -0800
Message-ID: <20260127160508.3392732-8-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t8RR6rHzzpV8rMHjiapRVPadFs2VPKUN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfX5NaHYoyM7QWd
 UAyorDWhjVXSVIw6BZM3pg4CWHbRER+vVjW0GAwseeThq/xBxCr5MRYrvOvVcrgfhFPV3LA6i+w
 R9orR5JiPLrpfwUg5sNbbf9YJCDGydW28AiCZn2IHgNfRj2g5Ag97k+6o1cMn0s6xvqr9iYTqb5
 +AD0nFEpmrBQq8moaDZkk2T+h8GlMai8P1ef39GAbqjW/yD0SI9gUPO1u5oLSJ4n/XFqcLWKlQQ
 BDfYsqfhfskf4s9BV4x79ku2Jh2KzVCLqIj8zwgWVUQSgsTk+l/lU9LbM4Ph/xaiKqbYlB0OniZ
 TMKygiac7fPWjn4kFktUQlwEefT7sD3SNPiZT7q2WBU51D6eJSEo44kEpdBV3htQ+Psl9FOkFrp
 A6SgQGbpbBjE6NByziTxNITWVMynZ1UP5sAAQtmWWuFZ5G6mLubwACfYyOLU3/sg7hAc5YjlmXA
 ua0drrMwz2+ONa9iMFA==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23c cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=CQvzJwAhJbFv5xpNHCAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: t8RR6rHzzpV8rMHjiapRVPadFs2VPKUN
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18896

The ruff lint tool reported that stdout was never used:

    F841 Local variable `stdout` is assigned to but never used

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 59412588..e3e577e9 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -583,7 +583,7 @@ def init_config(top_dir, settings, args):
     create_siteconf(top_dir, args.non_interactive, settings)
 
     d = init_bb_cache(top_dir, settings, args)
-    stdout = sys.stdout
+
     def handle_task_progress(event, d):
         rate = event.rate if event.rate else ''
         progress = event.progress if event.progress > 0 else 0
-- 
2.49.0


