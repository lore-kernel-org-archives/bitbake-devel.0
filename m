Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50A8D262B8
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 02:47:47 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3863.1768963660275648488
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 18:47:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Wn3bT7BV;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=548130ef9c=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L1hetE858135;
	Wed, 21 Jan 2026 02:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=TyXHnQMtowOeH+mSWRPw8K67JlVvD9aVs5tJuN54dtI=; b=
	Wn3bT7BVDpBNZ4hlwfackRPwEHpgbb2+Vy0lMC3bmNwOF/YbbBxEdD5JoXIiZApN
	EvlVtRoSACW9+F17b/Re1PJr90V0yaTDV/aiPV51iXYTrfUU7hv0Ry/kPhAxOBrf
	jzlUIrFU/EIK63pMN2htzqEIkQp80uwCVlWB0wdwPfpyv6d6HBDn+ClOYWcWLb9P
	y2FSd7Lmq2+bgKLMKqRBcn3rgoJjjxI4BI0lqJu0KPn0DmF5/vvgVLglKlBl8M6U
	mffZCwbQ6E7pBsgaJVcQqpUV2unsS4oYtr68Gmr/G5Mia3XBA5MeWAjgOLF051Cg
	enJyP8VkvQEthMspA89L1w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4btncwg1gg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Jan 2026 02:47:25 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 20 Jan 2026 18:47:24 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 20 Jan 2026 18:47:23 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/5] bitbake-setup: Move into Python module
Date: Tue, 20 Jan 2026 18:47:20 -0800
Message-ID: <20260121024723.2634264-3-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260121024723.2634264-1-rob.woolley@windriver.com>
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: dlt700lpW5JFL0-Km6PQHYQeHsgoKpeT
X-Authority-Analysis: v=2.4 cv=ecwwvrEH c=1 sm=1 tr=0 ts=69703e3d cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=Y9EUy4wyUqtBFR5YDtsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyMiBTYWx0ZWRfXxSbzNVjbqP41
 No4eqSrJhQXm57WhkCwy8rua1A7qif5b7T2gJ+SLMi0FDwNFh37wTe10HqPhtdu9FmaZkxUdO62
 RnbWmXfWNUTAyUEvypidUYPka5e3QLoen53yWxvz1ymxJZiwIBTKBaXLcp4kPqNeN5iBj4VXHtY
 NKcKjYzXtItdLpitvvwA0wFK+xKv1Vsb8FLadZ46ERJaF+2EBcSILunGzWzdEW0oVB9SiW9wqvA
 Fyax3mgGF0Sb4pz2IoXbd0b2sJ+2ozpWvvj1Yqur3WjFLloqO2C3XVNIF/EqMkEJNFzpztavBD1
 Zdzdk/cFX/okPpsi2xnC8vGTeVSoqWfx6oebAz9olPVXpd/cRpMdBoEuNR/ihsCSzjhlTcCXFat
 0OwfRnQDZF/WRVHyyIF1tZ3zdLCkPtDeucowCPOWmQrTLNozcCnprANIdMMqsbOsql0iGSVwNAa
 a6lu5WeoQO865q7cx7w==
X-Proofpoint-ORIG-GUID: dlt700lpW5JFL0-Km6PQHYQeHsgoKpeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601210022
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 02:47:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18824

Create a separate Python module for bitbake_setup to be
invoked from a wrapper script.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 lib/bitbake_setup/__init__.py                      | 0
 bin/bitbake-setup => lib/bitbake_setup/__main__.py | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 lib/bitbake_setup/__init__.py
 rename bin/bitbake-setup => lib/bitbake_setup/__main__.py (100%)

diff --git a/lib/bitbake_setup/__init__.py b/lib/bitbake_setup/__init__.py
new file mode 100644
index 00000000..e69de29b
diff --git a/bin/bitbake-setup b/lib/bitbake_setup/__main__.py
similarity index 100%
rename from bin/bitbake-setup
rename to lib/bitbake_setup/__main__.py
-- 
2.49.0


