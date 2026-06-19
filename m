Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE000CDB471
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:51 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48054.1781890848048920447
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 10:40:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ljsGQ9dy;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0630dc6626=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHPvaf3160141;
	Fri, 19 Jun 2026 10:40:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=GcqMeh73/X/YVC4liAxWYHZm2NgrT3wO/r5GMbiungs=; b=
	ljsGQ9dyzo6uwM7YzO3hilF3Kj3bbF15NeSGeQ47xISxlT+zfxupasKlZb/b7tpu
	SSJEc4JczVDx8jVTMPg+V7XvQUXcVaMgsB3Bkq/HUSzOSqlItgHlT3ckmIql3H9v
	f4HrrIMeSgeshOHRKPaaw17k3pR9T4/IrYbTNAD0ym6TPOYTt9RXQv8In8yogDCa
	TOuIIoZ2M+ey3tRbhn0ENpT9yxszBtitAsCbvBZfzDye80b8/qnVNCzMd7WzWH9k
	XY8EG1Gsb39y5S02koPzqHyqFteCF9fY0mfg+hQ6RPk31d9Z5a1vzjaQvbL6PVIz
	vpbgkZBQfzTnNbwztJJwaw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbvra8-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jun 2026 10:40:47 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 19 Jun 2026 10:40:46 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 19 Jun 2026 10:40:46 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Fri, 19 Jun 2026 10:39:32 -0700
Subject: [PATCH v4 6/9] layers.schema.json: Add title for subschema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260619-b4-schema-v4-6-1e25a4651b80@windriver.com>
References: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
In-Reply-To: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: owsGfKzWsxOzknecWLEM2CyYidkvS0sR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX22KU6w0Jeqcf
 G93IQbV9pGEI5LQJZXsQ/8+VtK+jLbUdnmYF0h5qFPnzolpw83fRcd8yh1VcDJjr8cc5l/BFiVk
 GDPZI1N+CzJYH2xxoVR7dtKG3SrTthHNYTr732u3I8xUDwU+XTbhscug8AEnq9ezN0JSVB17PlZ
 Ok/2NSm+YOLsFZygH1fuJ9nvmdY+H9g9ZIQrIBGoj2ySKTNoD0qQMRmGLje4g06ecfg8/KmmuP/
 /ukSxQetjXJ7yXVJ67+XLo8a26tXPeaBCKc8Bvtc4I5kQLx6DSNujEbn7od8d4ftW2PBVyN8CqN
 +hOzBk2eRwZfBv7hgdX8E9HenCVO4LtnMEDBH05t0P8+7xrcBq9/JFtYCCoOj8ONAqvY/Gt1Toz
 qgfeMSQf5Y7kqwPp8Zj2u2RvKmMJYMMPVoP4XF+v/GbmjYNrlUB1f7NTAHAMXbo2PbqCDg/4fVA
 DBTPmOOrRP/fIfSBJhg==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a357f1f cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=eRc3Im3UAAAA:8
 a=t7CeM3EgAAAA:8 a=qdh3cfBW-Hq-pKFaW4EA:9 a=QEXdDO2ut3YA:10
 a=6K7LhGdg8M_A9WyCZdwM:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: owsGfKzWsxOzknecWLEM2CyYidkvS0sR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX+vLTqE+jpeOs
 t6N20JBihxkX28BjEhB2y3aEigB7RehHqlWX639rmcpB3Bt/xP3r3+5LbdODL/lwzngyzfOv/YX
 Wdoqi81xvS0EUr4WDvjlkC79NsWzAqd/xYqrEIYObqXjvUVgKAfz
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19758

Resolves the jsonschema linting error:
  Set a concise non-empty title at the top level of the schema to
  explain what the definition is about (top_level_title)

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
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


