Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E734FF5102
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 15:03:03 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83588.1775574172671803394
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 08:02:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=eyTPUEBx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8557d86685=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376LvYm2986663
	for <bitbake-devel@lists.openembedded.org>; Tue, 7 Apr 2026 15:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=+AWa84/yvIs5zIgFbHutINL0kc5JVeD8qdQY962gXBM=; b=eyTPUEBxUHhC
	1P0S9y0YQI+2sCjDcZh2oUAlB5bcbSz0sZTKHIlyQKr1WaPEAXeuKo67Wy9hJsYO
	HiIo3US3jL1ZTF8KJVVXBYipV89upE45LAOScGwQzekXptL/zBFpguDjYMBVKzmf
	7BoB4tkAK/tyqSPMUq14UtNiqMW4tFW7ciQlYcfkIgKGs7zMJ3A1U6cZ+AgkHs5E
	y/+QMA5n5W0KgPG90rzlBw5KAXKrujb4DWzCqpcKqaCazwBnogSOj181MkxU7jgY
	WFzfvDYYAeasEZn2sC03fbg6+Z7G+hv4qKIdtiarmGyFOKdcgzIE8/dnxAFIAEoB
	y2QWlB/T/w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrqgx3g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:02:51 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 7 Apr 2026 08:02:50 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 7 Apr 2026 08:02:50 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 1/9] bitbake-setup.schema.json: Add title for schema
Date: Tue, 7 Apr 2026 08:02:42 -0700
Message-ID: <20260407150250.104135-2-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260407150250.104135-1-rob.woolley@windriver.com>
References: <20260407150250.104135-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RPCD2Yi+ c=1 sm=1 tr=0 ts=69d51c9b cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=eRc3Im3UAAAA:8 a=t7CeM3EgAAAA:8
 a=HJ-jhe7wTB9-2I0lzokA:9 a=6K7LhGdg8M_A9WyCZdwM:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: e2RnCzRTs6I5JBvf0cvfhpgOqOhy7iSB
X-Proofpoint-GUID: e2RnCzRTs6I5JBvf0cvfhpgOqOhy7iSB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNyBTYWx0ZWRfX3SwUWJ4Wngyg
 7pPFmjHdKNlZdJTNpC6zzIr0iKuIPo/wNKVah3bJ1iHIRLGD/lqfvbmbY2BuXTgfCxgIHzbXtc4
 ZT+veyrWiEfTktS5saAOwU5PipFrDeGXF1EpwTtOTl4R3YuGzBFRsw6FFNxMxRdM76Gs3AaV2Xo
 NvMBzbA4VuO1Ym9WzoXTIYBhuwklC079XIhJom0ylRXB0YpApXokOXwKNctb7SH2EgCc02yBL1L
 AIxRA4CWVzLd8+y6y89otQqYaKX5+eEmCPxFWcnHicAOD3cHq1pyWnsJAaCeOHGjFV2wZd8/QK6
 7gUk9GpM2nFIml9387iK6jz8j3SXjS8hsnBexNeUUx7PvCNiPae0NxVWsfBJYwzC57DKOPCs04I
 9GyVg+xUkSFN0o79ifG32xQ28C9dO5jmxkGwBr4L1y66UY0sDdonsEHdYXviB97KYayLDHtFvVF
 l4U6JCqoKzx1N9Fes0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070137
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:03:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19345

Resolves the jsonschema linting error:
  Set a concise non-empty title at the top level of the schema to
  explain what the definition is about (top_level_title)

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index be8772db1..d340c9785 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -1,6 +1,7 @@
 {
     "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "Schema for bitbake-setup configuration files",
+    "title": "bitbake-setup configuration file",
     "type": "object",
     "required": [
         "description",
-- 
2.49.0


