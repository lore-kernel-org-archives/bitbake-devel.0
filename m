Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CBBCD98E2
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 17:38:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.135402.1781545094032925137
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 10:38:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=kMIlMTU9;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0626ff78a0=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFej7D1186413;
	Mon, 15 Jun 2026 17:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=DAPkhQI6FbrnPtOP9L+dQaHsDUMpLFJgawQ1j4td8wk=; b=
	kMIlMTU9/5NtX5eGzvIDntpIFtLP94RqSa4gdxdDAiWt8ATOjs9b0j76qlajxUxg
	EDNoyxeSvOS5rJ9uFlg/U5UkbNlDo5oAVDgj1/KU+NpYVzBkd6C/fqF8czl+Q3Vh
	I3UoxQ9rQ5rdPIVje0sueaXV/oOwGE7ITKXAO+pIT1y85m+O/NM/iTenq4AtpcQw
	V7ERqQ5tQv7R3+dl/smTfKHJC/DizRDlt3vqRLj7vAAzFN9nKzGIX+dtqki/b8Gr
	00PAZcK9+6c1FPo9VTBQmmSDWYd0LZBwCjp9j55SppIk0LJ7L6t9yStSj93qmdF1
	72JvKsQpb9NksSAWy8Qhtg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ervkp38se-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 17:38:12 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 15 Jun 2026 10:38:07 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 15 Jun 2026 10:38:07 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Mon, 15 Jun 2026 10:37:50 -0700
Subject: [PATCH v3 08/10] layers.schema.json: Remove trailing period
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-fix-bitbake-schema-v3-8-8dbb07d8765c@windriver.com>
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX1LAWMvzSAPUa
 aZdlW8pKEnkOYGZdxx9W08LwUKRQ/srJMw3Ml3xz6UdHLwJQPLZu7Qy58lmlKFpLZtBtnayDdDt
 F/Yze+7oVJ67frl1bFzgfYklENlz0YLGk2hIfShGwgwOYNnUJNqifjSqf2yfOhcDWQPjl+hxJP7
 l5yUajZAbICGodEmyoJzDbs7XXLo/SVFpFkcODQGSviVxcu5C9b1xmLwhD9vd0TUTHLd108uGbD
 ce6knR+h9uXwDz3i6gtznS2NpCfi2oLa3Nu7aNpA+txiepo0xcEUQzZu3NXfEEnm1QoIQXBrFw3
 kcCNfxX2EXzrP/mADJRDH9xSJ/dCbB3w/i7cbMx/4QbF2b6Q0s5qstDjyzyTbBvGwNlFDKnW+Yj
 +LllPXE6INGmeG+wuUvq/HowERgmviKVL5iZweU0FevdcN7L5G1bZGWe9zS0VibzG9b8Ij7fQnt
 Jr7PieuIt0fnWTATwxg==
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=6a303884 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=3uTWGShvVuBnwnTlEbcA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX/7FFHKY9eqlc
 xjlZpP+tOZdFSeWlV6SD/8ANmZMcMxVYJScktVQTnbZBSwtcKFMQhVhekAT+l1ovAzDDmEvN2tQ
 PGm6SN8ejNfFvEjhMi0QQDcGRB4Mzl7vwRIGcN0XJSVU12TCksPB
X-Proofpoint-GUID: Oi-imZf71ttw6rM7VQmT14gdbIIFYw2Y
X-Proofpoint-ORIG-GUID: Oi-imZf71ttw6rM7VQmT14gdbIIFYw2Y
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19697

This resolves the jsonschema linting error:
  Descriptions should not end with a period to give user interfaces
  flexibility in presenting the text (description_trailing_period)

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/layers.schema.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index e75380be8..4b70f6f3e 100644
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


