Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D879FEEF5A
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 15:03:01 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83446.1775574171567135065
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 08:02:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=jBe0NhMr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8557d86685=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637BTJfI4040614
	for <bitbake-devel@lists.openembedded.org>; Tue, 7 Apr 2026 08:02:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=LcNl3q5LRryLwLHWFADVQ30393ogARbV9mKzOVRjcic=; b=jBe0NhMrpEjN
	WkJlSdiTwL/csf1iQHvtuPH4kLlGzjBV47d4IOQRiD1kxgfAfP+Sg4XTVARvNGeP
	RnmWUvrW/+4lBblmDizw0+w1gjgsPlpm3glQmxJlf5JbNkcuJzC9Sff9r3bxiNQW
	j1q4Ha3Ox4/VMXR/C3bFgQBtHrLpXKvqHt4t21f4WXcaqYKGlFtQx+7MzCLUJgFB
	/tnv32o3M5RBILZuw3tT/qe6LbxjlUyFnOGi54I2wi2JYCVKJfVxmn7WqsEuX7Wq
	KEwFBSJwqC4GUKCF4BgmdMBgO3VAWRQTp+0hAV9Gq+ivb0cVPLIdkVZSaMSsGecQ
	KIzUuHYTvQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrygvh5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 08:02:51 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 7 Apr 2026 08:02:50 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 7 Apr 2026 08:02:50 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 4/9] bitbake-setup.schema.json: Remove trailing period
Date: Tue, 7 Apr 2026 08:02:45 -0700
Message-ID: <20260407150250.104135-5-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260407150250.104135-1-rob.woolley@windriver.com>
References: <20260407150250.104135-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 72CNiKaPgJpuUWxs5w_x9UPzJgFLPztD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNyBTYWx0ZWRfX/ymepJZfKKIP
 CNCha6EiszHtYyJ3Zrm+sBdQF2hsN+oXzKGRqw5fAnKgIVy28O8r1vKVesGGHOV0i0ogkMY7CtE
 93XRnFoKqr5/xCK1Eb0XpDHHTz6EAIvZLbnVBKnbAJvkquiDhscJDDsMZDoq10PJLYeiEdizy5m
 k0KFi4t5pgsdCQ5c8QcWfLU2HFtIIxj4uGXBB1YQG76JD8S2Spd+D4q1onpMj6FB4JNCXKeFGlh
 lAEykBErNtAmahUxUX4C+Z2pL6wU4NvIALfFOzruBNY/i3LMIe7yy/D144giZHp1rSRgX5Uo9Ax
 FahvvSmatwYhFWnrPZG1i9M+TKEfY0wyIusGuaJKL6VqK9GE+Bu0bLhAYOISggxL36TMtxIAFhP
 pQuHrCxiaDpiAz9nm5LfYf6sEyoDlVw3KMjmauW6swON96+AZG4BXZX7BYu1jwf/l1kt9mgCUnv
 iiT+szMr2ymQOM/cV0w==
X-Proofpoint-GUID: 72CNiKaPgJpuUWxs5w_x9UPzJgFLPztD
X-Authority-Analysis: v=2.4 cv=Wcg8rUhX c=1 sm=1 tr=0 ts=69d51c9b cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8 a=5koV8NlHODIScN3rBmcA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070137
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:03:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19340

This resolves the jsonschema linting error:
  Descriptions should not end with a period to give user interfaces
  flexibility in presenting the text (description_trailing_period)

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index f2e466c9b..896b0ba4a 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -150,7 +150,7 @@
                             },
                             "setup-dir-name": {
                                 "type": "string",
-                                "description": "A suggestion for the setup directory name, $-prefixed keys from oe-fragments-one-of will be substituted with user selections."
+                                "description": "A suggestion for the setup directory name, $-prefixed keys from oe-fragments-one-of will be substituted with user selections"
                             }
                         },
                         "additionalProperties": false
-- 
2.49.0


