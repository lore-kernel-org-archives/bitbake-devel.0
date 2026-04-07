Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9ADEDB7FE
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 15:03:02 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83590.1775574173006423745
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 08:02:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=jIQxZytk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8557d86685=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637BTJfM4040614
	for <bitbake-devel@lists.openembedded.org>; Tue, 7 Apr 2026 08:02:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=fe1sz4n5YCsfweaVzOlMxPLxJT/9UQguCUffbB5x/fU=; b=jIQxZytk9c1y
	Vy+w8HBk+RgHMGPY673YvQ2iINuJeUzaQWzgzO4dmWYXzxLsvk26LmbbvkkoOvFU
	nF2+KEm8+U77ssFqjTiI+LHrlpZt38ZCWrPkW4MK4/Ksp+b2xd+G/o55pSz9OYmO
	FF/x34+W8zmBZeeZmFjhkIOFJnUi6nOkpKSZcllDx//NmHF6z4XVHpiC+CMf72fO
	4H7DiPypN9UP3fpOpHpg2hgs6T8DPapHxay5MO4S5+o7hqTq5AgkYiHO+HNlL1mh
	YVh9XyxZtAKoWRUuqvi1kXrtJDv46ndWSlLQjw4A7dtl14Uok3T1c9wCd1jWVgS/
	kQsVI9kZ2A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrygvh5-6
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
Subject: [PATCH v2 8/9] layers.schema.json: Remove trailing period
Date: Tue, 7 Apr 2026 08:02:49 -0700
Message-ID: <20260407150250.104135-9-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260407150250.104135-1-rob.woolley@windriver.com>
References: <20260407150250.104135-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8VFuFK-lZL97o8j-0o_AVwfkr7clogL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNyBTYWx0ZWRfX+XRkPNLNMuOa
 L8j3g92lnc0cmdLg04DMTLWZGGV2d7C9z/1CdrVV32e393TQV/5wVcqBSW9JMI8Tdy7MqjWS2oK
 7q5O/EowP06uzxcvPfFlSUNv4ZXoqhmxi8S6+GJFy68nJDBx1Td41FnA3fu+CtdijISrf1HaJTo
 +CjaE50KzDJgCCnq84SFxPynwAG4rLT4Rd5zVvYPCNU4MkBUTudL7iSt5XZx/VbfNgR4gtcFnDG
 HxRPGhL+fWzEGjAE9OlLEcxCTK308AVK4Kii1u4H34lAnN8aBuroId6qYLbyyxwdT2xkC9Qrrxl
 SgoHOxlbqKEcFEZc5DTJOWKSJJdU/DrRFBqWdxb25I7G1nH3tTaGqH7tfk5ge5ROmemprdqSwVn
 fmxqaNmtqeCf5ZpDQ9gUQFqz/7MiqthbnRbwo4iIpS3k2Y/byvWDCy+vUghYIfpbc4BGbug/tLL
 J349w+fOWwVj11OWlhA==
X-Proofpoint-GUID: 8VFuFK-lZL97o8j-0o_AVwfkr7clogL9
X-Authority-Analysis: v=2.4 cv=Wcg8rUhX c=1 sm=1 tr=0 ts=69d51c9c cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8 a=3uTWGShvVuBnwnTlEbcA:9
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19346

This resolves the jsonschema linting error:
  Descriptions should not end with a period to give user interfaces
  flexibility in presenting the text (description_trailing_period)

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/layers.schema.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 5c715f08e..0ab679a6f 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -44,7 +44,7 @@
                         "type": "string"
                     },
                     "contains_this_file": {
-                        "description": "Whether the directory with the layer source also contains this json description. Tools may want to skip the checkout of the source then.",
+                        "description": "Whether the directory with the layer source also contains this json description. Tools may want to skip the checkout of the source then",
                         "type": "boolean"
                     },
                     "git-remote": {
@@ -64,7 +64,7 @@
                                 "type": "string"
                             },
                             "describe": {
-                                "description": "The output of 'git describe' (human readable description of the revision using tags in revision history).",
+                                "description": "The output of 'git describe' (human readable description of the revision using tags in revision history)",
                                 "type": "string"
                             },
                             "uri": {
-- 
2.49.0


