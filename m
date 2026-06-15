Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080B6CD98E6
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 17:38:22 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.135106.1781545092343260513
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 10:38:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=PqpxwJZ1;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0626ff78a0=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFej7A1186413;
	Mon, 15 Jun 2026 17:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=tCvU4/4OpR49Byz4B0/Z3Ijz3q31PWpc5EsvsSqZIHc=; b=
	PqpxwJZ1aKAfOB1n0rqnB564QctNZ5tVkjI4pFTMaQJR9BkdcC8RNUAg4FzHpynS
	bVI5KnGFOjDwSoyfKWX4XTmATGYCGnjK90ChyqHTQAnDwcNItTepiiOvrtN2iDGi
	rPzjEZXhoYUvjMOTAOE+rNh1L/rGaotWcoizHblZN9pJCwcs61kzecfgOmwGnIjB
	FCgXucd3H7l0wyA4kKenww6OHdB8KIB6l2bKS3wZSE14HL26MRP8dhoxH+4avTvg
	FGsrMPilkAYoAlLWMAERCwtYyNGS/hcpx8ts0yhhfCewY6AYL6UoFG5UcZKgUl09
	Jb7e3T64ttyWttk4UyYbgg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ervkp38se-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 17:38:11 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 15 Jun 2026 10:38:07 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 15 Jun 2026 10:38:07 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Mon, 15 Jun 2026 10:37:47 -0700
Subject: [PATCH v3 05/10] layers.schema.json: Add missing schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-fix-bitbake-schema-v3-5-8dbb07d8765c@windriver.com>
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX7aJSAUzO274g
 1e/8/7PXOUQ7FmMz30ZTrd6I0hhcyTGAcuycYBvbDokn136oQBA06E9t0equWM5WUClogaaoBXn
 nk0E+eqNTQNlcS+BzcaKbIcK8LWlm887rYWGjF1SYawFc33FAgJXbIKVpxVHtmyHsw1c0tgJ2PE
 CCVHu9Q0Igr0hiFaOPe4EsH817APbuagZoYHYKnXpQ0xArQCnVIuPASezypykqKtseDaQSfQKgD
 n7o4ZEb/L0/zqHVson59qWvmCk8+ebOBV3VMnk3ogKaTmIzQtpptt53IirPYMOV1yj7aLbZxBgK
 Znau3MqrHnoVJ/PL55T6qkjfT6/ReQTTRL2fUdhkYYcyMGdd9kQVLsKt8cVcs2rWKdm7JEEIpOF
 TLkpjFD2w8UdapTOR/sL7OID6sSbKmrP29ycTrdka+GqZcz9Bsi32JAwLXFsRAzPVug6gSI/H6U
 ILXsMV0fmvkU6OFqkjw==
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=6a303883 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=eRc3Im3UAAAA:8
 a=t7CeM3EgAAAA:8 a=K-jijRQM6WG3fweZ8bcA:9 a=QEXdDO2ut3YA:10
 a=6K7LhGdg8M_A9WyCZdwM:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfXwMulmEI5Vozx
 XXI/HQbbmbSaCmcmlwovkrqm83FPc0G3mCEiU3m+1uloFZqveeDxTZijK+awlnA6ge7WAZhLXFQ
 r/yMj/ftX+kDdLO8SSH3WVvWSQppUHXbcAgp9XanVp0DmGmMyVLC
X-Proofpoint-GUID: fOujiaWgCoLmyPb4elMJyneFaTwF_8EF
X-Proofpoint-ORIG-GUID: fOujiaWgCoLmyPb4elMJyneFaTwF_8EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150186
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19693

This resolves the jsonschema error:
  error: The JSON document is not a valid JSON Schema

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/layers.schema.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index f42606941..2c192c8b0 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -1,4 +1,5 @@
 {
+    "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "OpenEmbedder Layer Setup Manifest",
     "type": "object",
     "additionalProperties": false,

-- 
2.49.0


