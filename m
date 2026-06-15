Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD121CD98E5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 17:38:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.135108.1781545092928585744
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 10:38:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=DcZAkDM4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0626ff78a0=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFej7B1186413
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=dcUrgyyVAe/FH1lujHvh6RFuAjHLMD8jPb/JPIQOL/0=; b=
	DcZAkDM432gLQLhf+lnYGHMelX2kYJBPz+NYFXxZw2rGjORgXuYjmXGK/dSAGSMW
	9UCtXhcW9QcoABm3pLhUJxAFqvEA3VQJ5AAmXkGaDfRIh58ZFoLducNIyA6qms5V
	QfarpMGC+1pEXb9XEEK+ggUBWN6tRKAjzMuk1yR0ZngfiST5MZykRfO0V37e1FT8
	ObcZHdA08ARVprDGoGYmRHGWbXF816ChljXTzsydBFDta1HIHXlLRiAcImosWO04
	2M04heDQhi/liRP5yo/i1ebpoTgZHCC+4G4TH3rdkv0APPOiyVWNSxjZIkcQHFgV
	XyKwypDMjv8RK+PpB2pzgQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ervkp38se-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:11 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 15 Jun 2026 10:38:07 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 15 Jun 2026 10:38:07 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Mon, 15 Jun 2026 10:37:48 -0700
Subject: [PATCH v3 06/10] layers.schema.json: Add title for subschema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-fix-bitbake-schema-v3-6-8dbb07d8765c@windriver.com>
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX63j97noAyVzB
 UiCsEEcMKtlCmJ+7VeTe0JFsPE449qHmva22/AlYyJvGGZXX1UGeOUUXIapKhAT7VvQ+jY1utv5
 MJ5hekryypfYcYZ8DbnJZ7qi558TvvPLr3c16ryWzTqDx0UMRm0GGTzcw/mwHD/XGpVlo6nxQUN
 JGi/iUiyBKgmVYN8nD7Sua87+1Y88Zcz3lhP2Rwd/53pOMse8YDUGStpoVOk8jtMLE3wubdiVYd
 6/v6Noo5NHftCu6+vnKiyvDSlb2r+T2DIK5+nbuXmNM6kuxCwf1YzoJo4JPlbdLjVE8ONCVgldA
 r7U3aWHc1cmwFIWjfdccp1LUHRhzn9F5yzynCgIv1Jm1HiQwrd7UYIiDZJ+Gwme/ykIxoH4QxQc
 uviHaP30lozKpPUAas0g8hoYfDw6emA5dGzt3/j+GNg9fwYRsh1pMlccObFMQLuWuG/H3nKIvdP
 rgBL9Is6lXf/bmlqYVA==
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=6a303883 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=eRc3Im3UAAAA:8
 a=t7CeM3EgAAAA:8 a=qdh3cfBW-Hq-pKFaW4EA:9 a=QEXdDO2ut3YA:10
 a=6K7LhGdg8M_A9WyCZdwM:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX/fAshlyELELr
 lUj08gfHlSNCAuUDpzwQASjPRLC3qBdPlWe7+2KUEir/XzuOQDQEotCFdMJCFfHLPocK15gEO75
 AvrPOFLYH2iZAB+LfEqPLsJz2NPQQxEKxI5fRDciJGR82iaH/MpD
X-Proofpoint-GUID: Mow87R88oi-bG_wUz6onLaP_1mJh6jmW
X-Proofpoint-ORIG-GUID: Mow87R88oi-bG_wUz6onLaP_1mJh6jmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150186
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19695

Resolves the jsonschema linting error:
  Set a concise non-empty title at the top level of the schema to
  explain what the definition is about (top_level_title)

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/layers.schema.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 2c192c8b0..afeac1869 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -1,6 +1,7 @@
 {
     "$schema": "https://json-schema.org/draft/2020-12/schema",
-    "description": "OpenEmbedder Layer Setup Manifest",
+    "description": "A schema for a manifest of layers to setup",
+    "title": "OpenEmbedded Layer Setup Schema",
     "type": "object",
     "additionalProperties": false,
     "required": [

-- 
2.49.0


