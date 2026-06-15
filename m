Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76623CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 17:38:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.135400.1781545090965655906
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 10:38:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=a+87FzIT;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0626ff78a0=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFej771186413
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=uEEA9WqUuofz0W3Y1k1XvR0vgUauS96BZGEjYjCkVxE=; b=
	a+87FzIT6pPFBta7ybyXIO6Eew+z0j5Xg5JxWpKU/ReKebeGY+0J89RBbrssUUoJ
	Y7cOl6k+/XP0YQ7aPxBG64mmHTc/ngioRCQY0m3Qm/PFwNd9skpknhugtWxk9Azj
	3vBthgl7NqzLRAl43ZMy4wFAEAAo9q0STdFvmsa84Npkdif4LP4J+fjlAnhKtUEh
	0KQg33qmfxbhS9lmbhqppaO1yWt9DTWbkCIj6P6mL/nfFYY5VAL/OwdTyD/yRVhn
	2YfMhp+EPAghaS2j1VKTb6IdtFU/cXTdSdhMUyn4KOeRJAwcyITCf379MG3FARAA
	XVYngKa+c1KjUiOiTWRtTQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ervkp38se-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:09 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 15 Jun 2026 10:38:06 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 15 Jun 2026 10:38:06 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Mon, 15 Jun 2026 10:37:44 -0700
Subject: [PATCH v3 02/10] bitbake-setup.schema.json: Add examples property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-fix-bitbake-schema-v3-2-8dbb07d8765c@windriver.com>
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX4ydu7wIgt0iV
 YfzcCBp8VXENteOkpCRrGxY5W7qt65vW6qppzP/IDrIUy0zWEhrWLqsvDvCyLZJl0M0oQ5Xsv2I
 gGJY3CDQ/36O8qFcf61eiW149o55d0f4W0u3EypC35PwW57QCounvCk8tdsfFOaeQr4A3c466M8
 zi7UYPG68UIHCDbCOraqZj3xd0HmTTX4AIxIGHKpPVGOUdC+NcbYOQXxe1Ky1uskvJNdpz0cRyQ
 78Dn0s6EcaBQyFkDoF98Cf/zLwtbkqts5SEgmRP5Z1aL1SbbZXTkHB7xH84pLaCD2nqaHnk3nrJ
 IJZtcZ6ansYY/dHAwegPurBoX6BXiBAaTTk5j+iJPgICnik83aC0SxtjUqUItOt7q4PAQ4GIG8L
 b3EGL4jXtQm1bTxYVen0ONZczkdywA3+NU/J6kHOvqGUqe7gRxoIdfs2YTW9Dy9PDse9SuhHYgV
 5CQk/kE2QfFyH28dLig==
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=6a303881 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=eRc3Im3UAAAA:8
 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=WF-jE9nQbA8QGb6MljoA:9 a=QEXdDO2ut3YA:10
 a=6K7LhGdg8M_A9WyCZdwM:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfXw+uCIgYLWNEp
 /4guNTESCymIR9bLL19uavYGTzn82+pBPmUHt8tY51jCZ0FEpLYnKT/b79bzClOjobnHJDymIEW
 ywAMYD3xk3LsEK1jnHX/KqgEVGDSTZRCPDKVaTJWZzzLKt33zpEX
X-Proofpoint-GUID: YvPKwnmVGEvXiHCoYthpL9Qr9kuu5QsB
X-Proofpoint-ORIG-GUID: YvPKwnmVGEvXiHCoYthpL9Qr9kuu5QsB
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
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19689

This resolves the jsonschema linting error:
    Set a non-empty examples array at the top level of the schema
    to illustrate the expected data (top_level_examples)

This example intentionally only references bitbake as a minimal
example that focuses on the tool itself.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 309088348..1830d16df 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -1,6 +1,39 @@
 {
     "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "Schema for bitbake-setup configuration files",
+    "examples" : [
+        {
+            "description": "Example bitbake-setup configuration file",
+            "sources": {
+                "bitbake": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/bitbake",
+                        "rev": "master"
+                    },
+                    "path": "bitbake"
+                },
+                "openembedded-core": {
+                    "git-remote": {
+                        "uri": "https://git.openembedded.org/openembedded-core",
+                        "rev": "master"
+                    },
+                    "path": "openembedded-core"
+                }
+            },
+            "bitbake-setup": {
+                "configurations": [
+                    {
+                        "name" : "qemux86-64-nodistro",
+                        "description": "OpenEmbedded 'nodistro' build for qemux86-64",
+                        "setup-dir-name": "oe-nodistro-master",
+                        "bb-layers": ["openembedded-core/meta"],
+                        "oe-fragments": ["machine/qemux86-64"]
+                    }
+                ]
+            },
+            "version": "1.0"
+        }
+    ],
     "title": "bitbake-setup configuration file",
     "type": "object",
     "required": [

-- 
2.49.0


