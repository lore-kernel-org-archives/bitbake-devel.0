Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F2CD98F2
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47896.1781890847047234827
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 10:40:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=YlsdJVMO;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0630dc6626=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHPvac3160141;
	Fri, 19 Jun 2026 10:40:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=1R/mVNqjwEwMY702E5CH49u/P8c9a04joIwB/AM+2HQ=; b=
	YlsdJVMOyFAxx0lXi8cxY9URpyeHEOEtIA87N1YgFv4dW3+6yDBi7SgUyOwwPAXk
	KbGzpYNy9YO6j2HwlpHuCTeYir8mYOXvCDj75ow7wFamoRJsT7AiB/sszx8wiT8C
	K+U7UwUfN7SjkzTMknrQlPiS7GrpWBIwZVx6fNoEvAouiFylRDq+pGBr1gJq3PWz
	kienBFxLeA0Be23DlYJunrBlBgd8UFNQT84Sp+gIF6FFgvJwQyB19S3PjCUmSYmo
	Jj2r1MQKQsi11opS1+sWy9UbLyhjiKKheEjybyIq6w2pyZOoF951RX9SzjSUlXVT
	WyEMSZuKckeI6lzabcIivQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbvra8-4
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
Date: Fri, 19 Jun 2026 10:39:29 -0700
Subject: [PATCH v4 3/9] bitbake-setup.schema.json: Use anyOf for
 non-disjoint subschemas
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260619-b4-schema-v4-3-1e25a4651b80@windriver.com>
References: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
In-Reply-To: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 53CN2hMDXlmVhJXe-_SRAQyQVjSN2Jr3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfXwTumCGFd1Eeh
 C6S6NET0VVKq0cVj5C6+qGR+Bzlv6o7onuuZtM56xnt/H5HKqkAwwKkDTsygHXcW7/52T6ZnZYi
 F7FLI8grXgLE6fpe5QbO5uEVcfRZnH1YlOPYTZzsXzqowccOcsupAi7gtAAi8l3uE48NnSZcAgJ
 aJRAlsKF+MZGYyM/WqC4ErG5IAe2eukUsbv9BlQrt5qACzTjKO6szE7pQNKeQ7vHpGUFP0MLaEQ
 mzPmdL5olX5f1aV9ZOflPH/elcOP3x+Jkkh6jHvaRw+VQq6JfjPEMre7fShcJi0dkdecoE0/7wU
 PiTUHcDRIi0lFPoHddn1ZPsOwcnTKyBISmCH39l7lD9SwBN6cvlkSDH56eHyjICGyqUcnMrYWTa
 xMvYmHRqhN4dYypBGBTS6H5AjaVkOXZ9i6BDV2qPhHL8/elZ1+jdxOp2M3KxzEWDey/LI8PHjqs
 DjZ2mepbEEOp5i6KyRQ==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a357f1e cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=WHH8w_UUv7IlS_MSRisA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 53CN2hMDXlmVhJXe-_SRAQyQVjSN2Jr3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfXyEKRKjUiUcKs
 jBcQo/iG7bnan1fns/PlU24tArFMsvuvhubY2rnEiacA3+BgWwuc0F5+FPEkuYfeYSVDBU6DgQO
 bapJrgELbYC2gwrjVebNexgLH/q8nHV3ffBRVQLWGRL2rjhjQTJY
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19754

The oneOf keyword is for matching only one subschema. It is intended
to fail validation if the JSON instance validates against more than 1
or zero subschemas.

In this case the possible BitBake configuration fragments
are disjoint and anyOf may be used instead.

This resolves the following jsonschema linting error:
  A `oneOf` where all branches have disjoint types can be safely
  converted to `anyOf` (oneof_to_anyof_disjoint_types)

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 1830d16df..056ace37a 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -76,7 +76,7 @@
                                 "description": "Human-readable description of the configuration"
                             },
                             "notes": {
-                                "oneOf": [
+                                "anyOf": [
                                     {
                                         "type": "string"
                                     },
@@ -112,7 +112,7 @@
                                 "type": "array",
                                 "description": "List of BitBake configuration fragments to enable",
                                 "items": {
-                                    "oneOf": [
+                                    "anyOf": [
                                         {
                                             "type": "string",
                                             "description": "Configuration fragment name"

-- 
2.49.0


