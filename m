Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7CBCDB472
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:51 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48053.1781890847371115411
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 10:40:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=kDue8oJO;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0630dc6626=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHPvad3160141;
	Fri, 19 Jun 2026 10:40:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=s78YT/v0mk7/JbAxSsiDXTLvrNjvy2PJH3AEPRtPvlY=; b=
	kDue8oJObt6+zn81XdNOaRZ7W51wwIQaZIbiPoX64dplNfE3Yw45gnQitQiZwTBr
	dG4r98jwLOsck1WB5f4SV75JzUAWyzZ4NYbA5WhalNHQE1U/ZYvRipm41dH655jR
	P9Rfor7x5n8VZZpH4hLhpTaFzTH2BWNIzv0VMn4HARpyaEf/CQoM4WZv2g0JIYvP
	fDTYuEmX8O7D88kuLLKJo024/0HjeabgRCKmxAchYPnVmLKmTISfWZ9Ve0uA/V69
	U2wWYhAhjMSLe2ig+LhWoRJ70e84qBabolAyYti8rgckfig9Qt6qjhieSu+uaSO5
	PcNT6TzScGCzqt21RpC9ZA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbvra8-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jun 2026 10:40:46 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 19 Jun 2026 10:40:45 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 19 Jun 2026 10:40:45 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Fri, 19 Jun 2026 10:39:30 -0700
Subject: [PATCH v4 4/9] bitbake-setup.schema.json: Remove trailing period
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260619-b4-schema-v4-4-1e25a4651b80@windriver.com>
References: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
In-Reply-To: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: xdwO9El0oUo2IJmwNfoi7BT71LDcoon-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfXx6ziMYKFKsd0
 PWm9QcpLctR/SQFyV/0PJUNR9x+pOX7q1rZWa2NRNozPOlgvdIZpKYX2q5+LR3Jvi/MxCyfbDAp
 ObOGNT7GfuZlhMk5f9pfsTWxcqmGOAejF3+IwUV1odojxNO04AUE6wiMyM7TT561Esz0h3eLtgM
 d2N+ZNZIhavzd+sQiBf3bgk6LnMO+4Ah9YHiaIKuOzL5qum47eHkLTd2KVZZwTkMNCqpAVKW1hQ
 5EzY8X10r1JPTv7Q7UirD+KEweh8MNKQvRcll9jA0qx8Opaw51MHGQ9MFkcP6hzD0VcCSvFd0X4
 fcljFMAprqB6Wy8XXMCjblWmCpyFVWPInpeiIbSnGTs4Mw8qiCikvAznEBEBjDcf42JPDAGUoYF
 Z/ao8EQc4XFbRAvcEwwwc506ji8J8fCYUlxoUf6xsT/7IbRfIjWHRPu8TTKXaUCfXTjUos1V0No
 8KsVemOzxh3PpjCx1Qg==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a357f1e cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=5koV8NlHODIScN3rBmcA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: xdwO9El0oUo2IJmwNfoi7BT71LDcoon-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfXwaRLzn4N3FPh
 /c2f8ROn9MSvIApaWkEkX3rnXJ8p3goWKkcf3q5s2zCxMfwuwz0HEztN02jauWB/cRjh6DbYVNI
 IgrOYP4obfdKLP+D55lKKGCEKQqLuA+MUKgccdgRXM4rS8mtLLvh
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
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 17:40:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19756

This resolves the jsonschema linting error:
  Descriptions should not end with a period to give user interfaces
  flexibility in presenting the text (description_trailing_period)

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 056ace37a..177a8dc8c 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -170,7 +170,7 @@
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


