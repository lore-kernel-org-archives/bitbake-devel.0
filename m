Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D501CD98F8
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47898.1781890848602437568
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 10:40:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=n2qIucJe;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0630dc6626=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHPvag3160141
	for <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 10:40:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=rZMmARguJDpc1b91sI+UY5lsDz9cchvjctgHP9n+sYc=; b=
	n2qIucJeMIXDTfGzWXwjON6SCLfulVHiXSO6mhpZSqApgbqcqwmqw99mGfRvSodX
	q8JfJh8g0mXc6Vqabh/+KXbej2vDQ/BRNpa6FZdYOe40Imjt7v16eJ2EB3U72kvZ
	Otdsj7VPQRr14UhC9sXHdewBwPj+g69yrCAWhO0qbeUS9Osqm+pUVbLoqWUgNUQA
	+zAXDPdJPKRzP+5BkBqa+ZSlVq3IduxbDUAr3/CajeB6HLIYvYEno8ls7xQjhm6c
	aGKt3fCJT7GnuokGqrzaleRFyZ0qPjLU+9nhi9cfSAU5bUlrD0VzT+XOk0/xtbZw
	DEaKZonFBjJ9rRmjfIv42w==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbvra8-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 10:40:47 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 19 Jun 2026 10:40:46 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 19 Jun 2026 10:40:46 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Fri, 19 Jun 2026 10:39:33 -0700
Subject: [PATCH v4 7/9] layers.schema.json: Add examples property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260619-b4-schema-v4-7-1e25a4651b80@windriver.com>
References: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
In-Reply-To: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: wNJvO4vx42EiYTDclQP_mBxrsfFafgX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX7HVd/uL1ABk2
 s04a1el2oZmLoVoezEh76KxMDvFOFXSVK3bc1+rCfK0TPnvg/xIVdUhNb1ZZ8wiU/d9W4mcioEB
 peLjl7xDRD0wuQPltv05aarA1MkKxJ4xDbsaAeLHW1qHHbeLT/DSGzxiWEBs0EG1U2o5tCUV5Jq
 roTZxKvtFFhH+qobZ5dxIRrwan45QqKzKJRXtjU23sxNAfB2jIKAVrMaYl8g3rq0yS75aw1p9bS
 nCNCueNZnAzCCLFBjZC1AYzoAwB61iTrDoTLEIYkldOHZ7WCOdOnboMmgZAzvdWYJBydoWALgcA
 31yl4SXcekzYwMwiNof243UY1DLsc9vbTodqwCecJ7YJj/TC07tATgKFnnsgK0ArDinM4G8EJFx
 t5xLJn+xHWSTPT9b3aqPVBdxX/fZo1yyIFcFG/AIG7cSRrnyeLZtysXgZbLFUsFjsPf8hURjtWd
 ATK1t4wXjhN/hpoZ5mg==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a357f20 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=eRc3Im3UAAAA:8
 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=t9p6cdMu2i1p4WqHfg8A:9 a=QEXdDO2ut3YA:10
 a=6K7LhGdg8M_A9WyCZdwM:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: wNJvO4vx42EiYTDclQP_mBxrsfFafgX1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfXyP6Oh0SRO0FA
 rNVgd/r2c/1+yc5edoh0Fg72wrE3NXXoQpQRR2NqMY2e6AVi5XHnVEG/bGTI1ru6fl9tG+jZlfd
 sY3xO7c5pTKCvUfUF051D+1Sfat0sk1pnBObwu3MTbTOQoqoD4k4
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19759

This resolves the jsonschema linting error:
    Set a non-empty examples array at the top level of the schema
    to illustrate the expected data (top_level_examples)

This example intentionally only references the bitbake layer
to provide an example of a single layer schema.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/layers.schema.json | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index afeac1869..26a0f842a 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -2,6 +2,20 @@
     "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "A schema for a manifest of layers to setup",
     "title": "OpenEmbedded Layer Setup Schema",
+    "examples" : [
+        {
+            "sources": {
+                "bitbake": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/bitbake",
+                        "rev": "master"
+                    },
+                    "path": "bitbake"
+                }
+            },
+            "version": "1.0"
+        }
+    ],
     "type": "object",
     "additionalProperties": false,
     "required": [

-- 
2.49.0


