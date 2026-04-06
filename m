Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D28F46C69
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 17:21:17 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60249.1775496072699124277
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2026 10:21:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=C5MRfG1k;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=85563bbf72=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636ASbBt1474696
	for <bitbake-devel@lists.openembedded.org>; Mon, 6 Apr 2026 10:21:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=NSh+jaLnszGiAOK7eyABPkww11a2PYlE/Cr+dRRenlg=; b=C5MRfG1kNVAa
	sYt8jCymcI+cHpPAn8IaS3TBLMrFsKvk6dyxlwTETVLc6Lx2RKJLJ7wLFu+7OYHu
	eWHeFn8FDNHSK8GGoaocQExLGwr57MKGVAdXJtxN5Sg/jrEVD1JIbkbVB96SnkZK
	FhTOa32rPGsEbd1xxpCrs6Quf5T6lqpukRlX9vKSwKp9F1ZvDFWg67cx1Lh7MdYX
	XRSrJgQesJe6/8rXIagWxMsAyExi1jo6+Hl6tDMruPINczrU8DtEb14u3nNKRkb+
	gDo7FP+PZAsKywHp8VW06EPktparYBSTtrrY0cbJm+GYKQoN8ANbbX/KpTYvCezE
	W8TPfwzdyA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dawwx9rha-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 10:21:12 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 6 Apr 2026 10:21:11 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 6 Apr 2026 10:21:11 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 3/8] bitbake-setup.schema.json: Use anyOf for non-disjoint subschemas
Date: Mon, 6 Apr 2026 10:21:05 -0700
Message-ID: <20260406172110.2050236-4-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260406172110.2050236-1-rob.woolley@windriver.com>
References: <20260406172110.2050236-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE3MCBTYWx0ZWRfXwTwle/n2Zujh
 VqKX1cVNmy3LvGVzqqBa/2HCHKj9q07tIouKc6j18Gy284auoqF/ZjF5c8n2zPKMGGtEhSYUeLW
 OhKvMGJcSUwjbnY6QCkeB3joxCYj2rxCEefB9/RCd2NSLrFUpoE+y3TU9qwKAWKcxP3fEL2j0UA
 eMVKcfpgDosJvUUTf6ZbSvJyQyyAlbMwev/bIlmM3zvwNaeCRF5MAK6qgUss7ikzpeFm5K1Mez2
 4aJGCzlfQgUqZ1FUEknCWscJuVEk3aJMaiibnSG2Rre4ihYyXrdW7cQg+3mTPSSjjIeTk8nB9Z7
 NcVqqkbthY8EsQCmxtiwpjRmlJQ7IzSZP0i0Pf7WfuRskSwW4F3NkIIE9s0vrSiQHUUPj8wNXCY
 HxcTf8y79uWgUcxdcyvpAU6fS2zo9WsNxt2B0GyUqRyoa+K97EEUGs3lhibUveKG6KtJU2xen9u
 rDGUcN6snJ//wDvBaSQ==
X-Proofpoint-ORIG-GUID: RNukxxG_LoGpp3mY0uqAvJ0L5gea46Dm
X-Proofpoint-GUID: RNukxxG_LoGpp3mY0uqAvJ0L5gea46Dm
X-Authority-Analysis: v=2.4 cv=AZm83nXG c=1 sm=1 tr=0 ts=69d3eb88 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8 a=jJoEvPsC45Y7O9PwoMIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060170
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 17:21:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19326

The oneOf keyword is for matching exactly one subschema.

However, the 2 possible BitBake configuration fragments
are not disjoint. Since a simple example with type and
description would match both. For this reason, we should
use anyOf instead.

This resolves the following jsonschema linting error:
  A `oneOf` where all branches have disjoint types can be safely
  converted to `anyOf` (oneof_to_anyof_disjoint_types)

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 976e2cdf7..a1d41d228 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -86,7 +86,7 @@
                                 "type": "array",
                                 "description": "List of BitBake configuration fragments to enable",
                                 "items": {
-                                    "oneOf": [
+                                    "anyOf": [
                                         {
                                             "type": "string",
                                             "description": "Configuration fragment name"
-- 
2.49.0


