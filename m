Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CF0D340AF
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14891.1769529917691352126
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ho1Mf2Av;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZG880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=B+RNrQBMcKVNsCo4vT3lFqa8nW8mKWcCXqzkFYn0x6Y=; b=ho1Mf2Av9umr
	11Q7vzaSVOfGcmHD5EYrrPLArgEZv91mULCd0qfCtiQB+NUmFzCbAI+Hdcio/+Ck
	zoDb6tsCwhMXMzH2uC32YR6Vh++rhgInjOXLpX7RrSHq4/13yFcA0DLcBS4QcTlR
	RrWZ0FIeBY6ccKEPdErynGbxCSCQHr5hZY7ulZUvKOftuzw6jNbH7rbIkF1mCQur
	w91q08bNFmi8noyJXC2EX4f0b+iwxvf3liFSKBHjn/Nx7Xen1MN4UKT4WQ4jGiOR
	zKVZv6qs0Qy4yL/2QiX6HaiQzQ4T1m+4jusIhzOBg26jrlCCH0nk6SHV7VjCwXaa
	vxh4sqe5hg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:17 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 27 Jan 2026 08:05:14 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 27 Jan 2026 08:05:14 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 08/10] bitbake-setup: Replace f-string without placeholders
Date: Tue, 27 Jan 2026 08:05:05 -0800
Message-ID: <20260127160508.3392732-9-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iJgzE4j3pVUPOLsFEWuEeitdAeqRawx8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfX1pGeJhQxXI/w
 lKqYlLE0tEV6lpFaGBslas7RMDbtjA8KM8Uf/APqRs9CAV06oxnzJvkjAPPCB+N0WAhbZCmV2JF
 aL/LnXvrQpZnbdUlmeJjvlmtfUKhdkJAm4afAK1DGRB1sc9DKpKynFW4FsMzaHH6n7C5Q8b1gZ7
 GAjlsQI32X5NDjOOUzKffbo2YQxjz67hhhTJCPOx7EUSapK79nVPJDbQ0D79JQ/57LtNyNUeCT6
 yH4zmfNahiBGl6pCPswo42tiBjpb+6jI95drpy6ajwL14JqvBTzIebO7+88YSG0ybuHR45IFmFW
 C6p9w1GHRSM+7rEt7+oQIh+WGj+qy+5NIBNdBFsYdrXASueolxHcC7Iw5AJU70EqA1hlLYhNXTC
 saMNqBU1CtN5DHzp/P2XfefQ6yCdOCKidiYgKrg9u8MLaGvp84z/kO5R1ag07OU+yXvgpkWsD7E
 cn/kQWQ267d95hBAusA==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23d cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=DX4I7EJYZ07sDsrzdd8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: iJgzE4j3pVUPOLsFEWuEeitdAeqRawx8
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18897

The ruff lint tool reported an f-string that didn't include any
placeholders:

    F541 f-string without any placeholders

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index e3e577e9..d19b5394 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -957,7 +957,7 @@ def merge_settings(builtin_settings, global_settings, topdir_settings, cmdline_s
     return all_settings
 
 def sigint_handler(sig, frame, func, top_dir):
-    logger.plain(f'\nShutting down...')
+    logger.plain('\nShutting down...')
     if isinstance(top_dir, str) and os.path.exists(top_dir):
         if func in [init_config, build_update]:
             logger.warning(f'{top_dir} may contain an incomplete setup!')
-- 
2.49.0


