Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD8BCDB470
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:51 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48052.1781890846705062145
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 10:40:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=kEwxFwEA;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0630dc6626=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHPvab3160141;
	Fri, 19 Jun 2026 10:40:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=pSt/QXOcIu5pdBDTyehiHCYvxu7p7mBlAeL40NfNbBg=; b=
	kEwxFwEAKcvbTfE/e+UBlTBEi/UVRiV7sibi9wbbSEWdkbu3amePYeMhhqlewzvI
	B20VPCdnbHczLzADdJqMTvim/+q7NyCUSkEucjGZT1FaaVAUQXC5sDxGTZtpXt3r
	vDkyzyYJhPVzDHg/C1Q9DowxI+0CbVEUOkEiQ2wmFL7PC90JbOOKzenyiv1pApk+
	tahS04sUWFX30FfspoGuHHljQ898T/hXVFPjhCBklJEV1oMgzvqSfXOtLFytrsTk
	Rs6un4NdxaEamXVn/jtd5VRzjw4Ggt/m1G/6SMreT1CEVUJZ8O2R4/CL4kGmIpQF
	DvgShbQK8VcipQ+8fRu2qQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbvra8-3
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
Date: Fri, 19 Jun 2026 10:39:28 -0700
Subject: [PATCH v4 2/9] bitbake-setup.schema.json: Add examples property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260619-b4-schema-v4-2-1e25a4651b80@windriver.com>
References: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
In-Reply-To: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: skdKS-U1-jUJCDE1asw0DXSu2X7JU4fN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX1QYoF0ntK3fj
 CyMkaWyX90m8lgk7rF62rI7pwuIF2yCY8zeR+lMLHYSYy6w/iHgW0YnpWp+6RCdRyvDRP1C+WcX
 twurBtAmAJRkTFNhoR8qAqgv9zryWdbovyg0yK0jrs8fgrTFxvDfIr34/OcIyzmfqE5L5Q6Ihj4
 shD8nNzJvj+eUOSazmvA/V7PLav2FlMfRzLz2ioKS+30MDm0OPqd3y9/TCVSnySKbKdvpFcwtZE
 +JHgWxKVbnC7DnbXh6PcKYNhSUxDxgqVPiYSBUbjLdXd4pfuBvCLMZ5JFqWDp3/1K7DVJS+FPZW
 AiuXNmYkChHB0A7hpncVrZ02AopN40f7B57xYRpPRKpZRmIHhB8LZuwmgja7WHON7NWaufbzRNH
 C/FSSXHUnqcZo2NvAmR0qCFNHApMzGjpcu503/4xf/9vz6VJHKNPoGbqB2vA8EZIBMa04spL27C
 UTpjHqT6zURYq1OUQ9Q==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a357f1e cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=eRc3Im3UAAAA:8
 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=WF-jE9nQbA8QGb6MljoA:9 a=QEXdDO2ut3YA:10
 a=6K7LhGdg8M_A9WyCZdwM:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: skdKS-U1-jUJCDE1asw0DXSu2X7JU4fN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX+oJMKZ2wxZyB
 qLeqoJdnmSqnBgelywEMPgCNJQUDxdv3kwYTe1X+gGw1K4aqwudX6WFmDLoqw/hOk+r/5Isu0jK
 3Na6A4Z8uQwGoraH06R9Rh8ihi9mWDuIuUTZGcTrvaauc2dluXXX
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19755

This resolves the jsonschema linting error:
    Set a non-empty examples array at the top level of the schema
    to illustrate the expected data (top_level_examples)

This example is for a development build of OpenEmbedded targeting
a qemux86-64 machine without a defined distro.

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
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


