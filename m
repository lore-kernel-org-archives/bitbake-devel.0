Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1A4CD98F6
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 21:31:51 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1857.1781645509060659107
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 14:31:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=V9oK/svE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=062707f644=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLVM0i495812
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=EJhKw9khQLxhdeV3g1Hl8SgJeOOaJ7HYOsjd25bZy20=; b=
	V9oK/svE5qaw9XWj8F2Hbjnux8iH2S3qZvNCbhO9WteX4ZHTTCf0iYh3nvbK5snf
	+x82DnwpmSmSeux10sp62Hnj3yVIzIhZhoHGAkDc2w2Ml0+gS9GunyA2bVtDlVrK
	8LEr9jK9zGsJ5yclLafK6ljZACIrp1xf2KRQrdCGrvIYcyd3XDCJr0F1wWQzTbeh
	I5WlOlV8eY6YwgJnUxJkcnbDzFq7p5V+UnO2qxaUDrFk2gHCXEv3va/khBV1vcb4
	byYdbR+k/6EftCNTRSiI9dNf+oNMkURSPlyNs1i1zjj+aQlGiMxwRfgSi3HbF1l7
	gjCx0bXD4Pe3UXgaCi4M3Q==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eueft0012-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:48 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 16 Jun 2026 14:31:46 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 16 Jun 2026 14:31:46 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Tue, 16 Jun 2026 14:31:29 -0700
Subject: [PATCH v3 09/10] gitignore: Ignore temporary staging directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-add-pypi-v7-v3-9-fe224e3ba878@windriver.com>
References: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
In-Reply-To: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: YRQmnWBNh7r8cPgiEhxLpVgz-s9VJ10E
X-Authority-Analysis: v=2.4 cv=B+2JFutM c=1 sm=1 tr=0 ts=6a31c0c4 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=eOszy7m5RXGtjJtd4NEA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: YRQmnWBNh7r8cPgiEhxLpVgz-s9VJ10E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX5h4Oui6a3tsI
 tsFtRoj3nSQxgIJx7yHhdG+W810mL1FqVr7d7a+D5ngfqYPwTps7pIFVVxlOMKScQrpnLjhzcpu
 letDzLLxzCXWALx1TBVZiPG8x8BvQc0UspPgvul766OcubuaPFb9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX5ZzhAdE0Acxv
 eTNHn0MRsPP0zkhjPiOvHOCDcSRK49u+3Gd/w2ds8f6neO/ifw7sgfMEvFibbnyhQnvCUFIbsyi
 xa5P1iaUV/0ZhPJR6kNIQjK3GtoshYJj2XDpiFv+4V9P0A1+s1FWFJ75sSa/+MN4RYQfSY8ALCz
 NqMW9imd6kf2v6Kko7RrNHkz3f5jc1kzFPM6G+HJevsHU3QsgSDx9r9GuZShfKYPOt++v98I50F
 q5kh6Tsf5P9T5bztHJ4E0lMro5aaHlve7ZZJubvQuYafHcbo1/SFcB2cxA3n0yiebwpHrVVsNpb
 KM92Wl5FEpmIv+9uw3TwLQhse4QXFDuNERal+4doTZr1YvTp2WrtMbevEVIkWqgiu3dLanO2l5h
 DqleBVEiQllUvS+Zc25NiCvnr9Oq7sj9PmM6eqLvyweTE5JNY+OX3aY3SS7tw5VYR2zARoU16kO
 4XmCjtsAlW/byXbufUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606160218
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 21:31:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19722

This directory gets created automatically by package-bitbake-setup.py
when packaging bitbake-setup for PyPI.

It is a temporary staging directory and should not be added to git.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index a6a256b2..9a5c4ec4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,3 +17,4 @@ lib/toaster/contrib/tts/backlog.txt
 lib/toaster/contrib/tts/log/*
 lib/toaster/contrib/tts/.cache/*
 lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log
+packaging_workspace/

-- 
2.49.0


