Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E6CD98E8
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 17:38:22 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.135104.1781545091423047270
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 10:38:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=WXNIoTJN;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0626ff78a0=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFej781186413;
	Mon, 15 Jun 2026 17:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=fqPIIKaZPIDkD1IyVEMyFN3DyymLD+3eooSV+t4Yy5g=; b=
	WXNIoTJNSTUDy9ZdVEpho0JiR/LPKKbfItNNmE3xUGswan1ULapREDWWUTXI42Ds
	yZhE+0LVs4uNoZdYTCWHcEA+z+PRnRp39HBy5XkvjN8+0sGYfJfXKdwNcFy8nPqq
	DZQkbvPccpFN2ss47VOyX+J3ZiJ9EJ+IzJI+Nh44HkttWc/EQ4bGMRPApi/NnpEh
	ooaUjcJyoLBw3qvCP+Wl6AXA/uDmuJp7jxvqC8Z/Iy+ecz0e1Esqk9fJEUG9Orgj
	yX9IeZBFF01fVxRqjaftbgNfreGxCWeEddRcP8Sj/bXGmwOJBHxWQeu1LEha5hY8
	S94MkVeByEVymKpGGckP9g==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ervkp38se-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 17:38:10 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 15 Jun 2026 10:38:06 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 15 Jun 2026 10:38:06 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Mon, 15 Jun 2026 10:37:45 -0700
Subject: [PATCH v3 03/10] bitbake-setup.schema.json: Use anyOf for
 non-disjoint subschemas
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-fix-bitbake-schema-v3-3-8dbb07d8765c@windriver.com>
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfXyQRjBFbhMyUi
 U/zahef2r8GjXtQdFtB9PteMvoV7D4wvEVLY2YpThLJ7I9rbdkE5fgZxRezTodAXL3mu8TIKe4K
 sZ7VTkXo/oPgLADlj0nd11rnrTsyhj5Ch/3+eMeYduXFqeJBNn5yzy4cC22PKQdbUbbn7+f8dRq
 9tUzWksXu6wZxoQqULycB9aRRLghkixMZcGk6LeP/m56ylLwfCHtPHh1ro0g1RI+LxL1lodHO66
 uoFrsTuO33K6e6tDOyT557Chanafxmciol77wdIqeduKOW8CLvvPa1wumga+AmysfoenQq821AQ
 H/m8lp522A3y3mbcRaocUT8SHa4nbfg33m3wtSmzyzbx2U2roUNMvhR5YV/Gcf97eYepHDkjSya
 TIyhL+qRvEFBsz14anNhOx7PCq0W/ZlDi9wxO4fVqqkp7GuuQqr+pHGq3GLh0uf/Psm0cPbLDtf
 pjt4e59aVJqUOi6/nDQ==
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=6a303882 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=jJoEvPsC45Y7O9PwoMIA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX1bq0gNa86gMw
 W07XFvxkhXPzIxS1+kAmXtpz3d1qSh9eScwSeArP+2w2lna8UxAn7Om4SRU/D5G1rwUqwwLEdjZ
 889Uo54W6wk20Ucfqw822dzGe00uPU7TcyPIa1LuwkyT3RRyefc7
X-Proofpoint-GUID: Z_OPzAp8LgbGK7BSahS5sbuK-ogUucHI
X-Proofpoint-ORIG-GUID: Z_OPzAp8LgbGK7BSahS5sbuK-ogUucHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150186
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19694

The oneOf keyword is for matching exactly one subschema.

However, the 2 possible BitBake configuration fragments
are not disjoint. Since a simple example with type and
description would match both. For this reason, we should
use anyOf instead.

This resolves the following jsonschema linting error:
  A `oneOf` where all branches have disjoint types can be safely
  converted to `anyOf` (oneof_to_anyof_disjoint_types)

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 1830d16df..314b5f78e 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
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


