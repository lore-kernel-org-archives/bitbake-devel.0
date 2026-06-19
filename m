Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1D7CDB46D
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48056.1781890849274450257
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 10:40:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Z4Pl1Tkx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0630dc6626=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHPvah3160141;
	Fri, 19 Jun 2026 10:40:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=e5/o7FjSdrYFluCjTaG6Jk8oLXbrqAMlipPhybvfLcI=; b=
	Z4Pl1TkxTwWaLRiLWvc6T/QNACYmphZ/D1anj5MyEBz6WotG1hl9UsrFYbkO9nxX
	S9SvjvMcTJEH6fj+MFNBN4NUd8Li6TLFCYXXIwEBjVPclH1mN7SznFdDxV7col5u
	f5b4Ru6EEbOax6nonen8k1S3lS+EswEtCW6vrjuNHZaPMkntDoOMnt8bbmAeefGo
	tomPPv0R3CqDNk/Erc4qZM2FVERfmE4M3yjvwID9uhUs31pzbY4r80WLpiGR/2Dh
	ozS21OLh36jHKO8s4QeOAdNSMbFjna/dC385C6ymBWfpt0Q/W0Hex9VlJQkBR0rj
	K6MBw8vAEjbxfXP4lUN/dw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbvra8-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jun 2026 10:40:48 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 19 Jun 2026 10:40:46 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 19 Jun 2026 10:40:46 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Fri, 19 Jun 2026 10:39:34 -0700
Subject: [PATCH v4 8/9] layers.schema.json: Remove trailing period
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260619-b4-schema-v4-8-1e25a4651b80@windriver.com>
References: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
In-Reply-To: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: -HIMNDuigWMnEx996iRg0d46ZX2ojcnO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX8N/HuVNG9uUE
 8Az1u0VbRifrnDNhqLLjJdJZaEV29yttmNljg9MhpeOyn9JkfBxq0DdFz1mdK8IVkVMQl3NyvlI
 UuO3HSxA/YrtHQnwN9WsvCA1Lam9sVsruoTgmoePzwYFmBkcn9lImuQeXae1ncMYj3jMKesOztO
 3I7ufINQgZ2iKn9eWI7g+KYFLYPAVr+0lnh5BjA42SwsCPhQxwDIaUxrEFlipioYhVGkImP/SbA
 Fe6SvTUqpGl90wxKHskVOheQX+ZyDAHNycMhdHl1ZsJqQ8qMmexS3+/5R205bswG+XknsK9y3OA
 szZfiqXf1HoRLWVJL2sTtdPTDrpQVArTlAZM+D0Jmw/7CGxlYmqP0urmEe4tZcaTf4Lzn9ywSJA
 5UMfRwxR/G36RGrgUuj48svo6LT3BZ9lPvoDdS/Nk/wO7ex2kJSgfkF3SmouErfWQ1+gowI8Jz8
 IFCTa3NQM/TC68ma9rw==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a357f20 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=3uTWGShvVuBnwnTlEbcA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: -HIMNDuigWMnEx996iRg0d46ZX2ojcnO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfXw/TVPhJFEtf0
 f0RK5dX5Qn3zUU3l23gIwRjtRni0CUG4ieSDFNG9PHgcKGveLJ2uwsT0ELakAoQazJEYfDfvdg9
 FuvCLw0wTwKMTZNN5BylHrUcSQF67nwleGlWZAfL+cfVIyL3TWkN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190167
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 17:40:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19760

This resolves the jsonschema linting error:
  Descriptions should not end with a period to give user interfaces
  flexibility in presenting the text (description_trailing_period)

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/layers.schema.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 26a0f842a..f9a26dc15 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -39,7 +39,7 @@
                         "type": "string"
                     },
                     "contains_this_file": {
-                        "description": "Whether the directory with the layer source also contains this json description. Tools may want to skip the checkout of the source then.",
+                        "description": "Whether the directory with the layer source also contains this json description. Tools may want to skip the checkout of the source then",
                         "type": "boolean"
                     },
                     "git-remote": {
@@ -59,7 +59,7 @@
                                 "type": "string"
                             },
                             "describe": {
-                                "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
+                                "description": "The output of 'git describe' (human readable description of the revision using tags in revision history)",
                                 "type": "string"
                             },
                             "uri": {

-- 
2.49.0


