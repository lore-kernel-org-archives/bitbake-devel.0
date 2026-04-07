Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC66BF46C7F
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 15:03:02 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83587.1775574172671547851
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 08:02:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=F1ThWEq8;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8557d86685=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637BTJfL4040614
	for <bitbake-devel@lists.openembedded.org>; Tue, 7 Apr 2026 08:02:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=Uf0kseuE73vy2MV/ttnYsy8pDQSDd3S2G4bEFuvOhd8=; b=F1ThWEq8qS5p
	/3F82QnAg4oX9fZHgnOBOIoCnpYDuC9IN4GV1mgv/Brjjq5Lz1zIwahjf1SQX4ST
	TUMhXtynuA+aLo9SPLZIQI6hpzAyHblwVmAGs+VTMFDRSwoZkNTSaHYmvPS0anVF
	hB6Zzom88SP6q5C0Us99TJjIwVIj07s7ehzq8PE0fk8qNnWd2Uqs/gQyRdUrTn4j
	2RpKFM1Efj/SqOK5qefyhaMLAReiMVGKbWVyz314nLMOiRGKFE/MDJ+BJjlQPpaH
	LF2SG3hztRq1McFBGUxmQOh+MdzYOLra39euFvoIXtyarCNKB5yzBCn1tIPonQpK
	Zf38wVrO/g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrygvh5-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 08:02:52 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 7 Apr 2026 08:02:51 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 7 Apr 2026 08:02:51 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 7/9] layers.schema.json: Add examples property
Date: Tue, 7 Apr 2026 08:02:48 -0700
Message-ID: <20260407150250.104135-8-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260407150250.104135-1-rob.woolley@windriver.com>
References: <20260407150250.104135-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: K_hQqG0fugnsF0rujId5thwNbljvwJO-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNyBTYWx0ZWRfX3Vz82ywuhfNU
 irTBkqnDreKjxAAHBl0e+2C0IfSkmTZOfQe9X6AU9luObEoK3EI5q3i0fsr/KCVhaDAotDw9OwN
 6xwnTU05W2UyxeRJI4J+V2yAl8oXHAOyMQrOY2Z3/HnbUxSzMTCPSon9QUCURzc7i8cBvinSb2h
 oXZXijnPqxyzRfpQf9+ktIk3YipQrNc7Xp/k5PGutFeGreBd/bllLGbX0efU1C00T72hIGfbvke
 StcnAwxA0mEJ5NQscZldSjJ4iXtoeTc3CkeeeGwPtrs9sG2Q2Ufkna0ADZO1U0Dua+xdFOHY0XI
 Zut5TyL/A/x35Wx7BD8nWFy1Rjnu0TRsSG2NUx2fJ35gdlKWFfGVVjsJN6cLjYBKDNMaUFh70K4
 izLR72CVQg1VeDR49BI3NmEBQFMDhL8GMBnkAwbkdBRWFfnXQVd/IcsQQT+Mmyh0w9Syq2NqoXB
 HyxMl8K7J3CMvGJNlhQ==
X-Proofpoint-GUID: K_hQqG0fugnsF0rujId5thwNbljvwJO-
X-Authority-Analysis: v=2.4 cv=Wcg8rUhX c=1 sm=1 tr=0 ts=69d51c9c cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=eRc3Im3UAAAA:8 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8
 a=yuxia205wHo5Zu8et1wA:9 a=6K7LhGdg8M_A9WyCZdwM:22 a=9H3Qd4_ONW2Ztcrla5EB:22
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
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:03:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19344

This resolves the jsonschema linting error:
    Set a non-empty examples array at the top level of the schema
    to illustrate the expected data (top_level_examples)

This example intentionally only references bitbake as a minimal
example that focuses on the tool itself.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/layers.schema.json | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 8bc74a533..5c715f08e 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -1,6 +1,25 @@
 {
     "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "OpenEmbedder Layer Setup Manifest",
+    "examples" : [
+        {
+            "version": "1.0",
+            "sources": {
+                "bitbake": {
+                    "git-remote": {
+                        "remotes": {
+                            "origin": {
+                                "uri": "https://git.openembedded.org/bitbake"
+                            }
+                        },
+                        "branch": "master",
+                        "rev": "master"
+                    },
+                    "path": "bitbake"
+                }
+            }
+        }
+    ],
     "title": "bitbake-setup layer subschema",
     "type": "object",
     "additionalProperties": false,
-- 
2.49.0


