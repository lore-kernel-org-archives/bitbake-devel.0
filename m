Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFEECDB46F
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47897.1781890847805260405
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 10:40:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AJxnHc+7;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0630dc6626=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHPvae3160141;
	Fri, 19 Jun 2026 10:40:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=tCvU4/4OpR49Byz4B0/Z3Ijz3q31PWpc5EsvsSqZIHc=; b=
	AJxnHc+7a0j5oELLixMZmbb+9U+JdhcRgclHsieN2WIsZLX0jtZbKUtmnxnKpEdp
	d5gi/LFyL1+3gsny2spSa5jCDk3aD32xAtztpxcotbRoLiv7bDbhRct4S5aquhgE
	7+I4tkBJWaH/hCohjmJHyjYI8k8S7QlCV2+4yUTVLpxLIpp2Bd+G4VE98LjAqWfW
	TTkEPA0AoEnUITsf0Sx86CJIAd2FpQFROI4TujDmMg4rc4cG/v0pE+M6ku9ysGML
	QcQux/2hf3ceFB7Zx1p3giAx2kNFfEIiEswhzkIFIw9sYbWXrymgo+RvGfgWlK4h
	tSpj26LJVzcdwtztc+NAQQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbvra8-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jun 2026 10:40:47 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 19 Jun 2026 10:40:45 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 19 Jun 2026 10:40:45 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Fri, 19 Jun 2026 10:39:31 -0700
Subject: [PATCH v4 5/9] layers.schema.json: Add missing schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260619-b4-schema-v4-5-1e25a4651b80@windriver.com>
References: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
In-Reply-To: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: EGSdYlSlY5a8Q0nS58CsPxeRwLdUr9Wl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX6dfjNTtr127r
 OAc1/8I0w7LbSIZzFklXVGvbb2/V8JlGEOI3jdcPfqLWmJjtudCqp8Q+5CVTOkgI14idoCSThdy
 yfVmhk/hKLx5Jb35CcLv/kX4PsP49m5E55JBN5w+BrgU/duZn+Whgt9QI/yfaqgd8CsMxZJmYWl
 7452lMp0Fhb36D/zgl4xV2pQiigh4zGzbBb6XNRmYuBShGRCA+L0fsgZo5lTZxzHGDGxwMKJQ1a
 syAfTDpSdKy9z01uUNY4jbpEEk7mWbaete3cPDDFVP1lK23LEhD8oclyb3Qq3xUy0kKLxEFcliX
 mmG/berWnoitNT3/WF+pn8k5IQ9DIOq4p1zN34BL3MiP70NxcU19QnxnUatzZBuBRHPlt9enDZ3
 UXBgLvjTz51OFXUf+iL+P1kGk7vJ0gbncH7faUqVZdYKqJxCEUeiFuLIbd+CPa+S0DVjJRdv0U1
 TyuX1FzLcM7flprDH0w==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a357f1f cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=eRc3Im3UAAAA:8
 a=t7CeM3EgAAAA:8 a=K-jijRQM6WG3fweZ8bcA:9 a=QEXdDO2ut3YA:10
 a=6K7LhGdg8M_A9WyCZdwM:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: EGSdYlSlY5a8Q0nS58CsPxeRwLdUr9Wl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX6R9maPKRR87h
 sZIY6f9d7o8mC+YZIqwDs6kI3Nh+snNdF0mseBQ82NwEcSoXlhDhEPK1m4ILCcak3seTZErXdpd
 rIwLjr5lBWPIFXYMFjz2U6yX/hHa3d1qZw6YQVB8DXYp2OL7JEuc
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19757

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


