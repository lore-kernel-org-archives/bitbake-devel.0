Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C27BC35274
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 04:40:47 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.45243.1703133640521078519
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Dec 2023 20:40:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=XYPac9ok;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0719406ea4=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL4BRTi020664
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Dec 2023 04:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=E4X1E
	0QLcUj+n4Pcpz0LwbK6K2zZeuhUAafTi6vw03M=; b=XYPac9okR0aQI/1ROZcx1
	RnKnOb2lsYVQk/KkxeyKf1VXzBxRl9+HWcbnNWaV6uEtWxJQoaX4ZgSvEeyVuSOX
	oLvTED8/PBllM49bng70FlBIPVGihNeAfFZWc6NeRWYrg8uNsh+c8/BBFy+KjEoE
	rJx109rkLtzWpY7K4iDDNtUq7/f/Bym44JwJxNRt5a+l8fl+iYDkgJwYHacX5eI9
	qiQaOrfzxRf/daMyXXe5w9T5vA1vzyvLM1YChlQnjf7y5kkYqscXLId9EiXAWrza
	6c7HV7g1gJCa7npbsNHlZcaPknebXgD5Bi2qDAu1fIRW363iaAE5s7pVDFn9fhxX
	g==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v113xdssp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Dec 2023 04:40:39 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 20:40:39 -0800
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 20:40:39 -0800
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 0/1] bitbake: event: Improve error message for eventhandler
Date: Wed, 20 Dec 2023 20:40:31 -0800
Message-ID: <cover.1703133461.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QkU0GjPczTtugXyiwAaceugrZaK84o1J
X-Proofpoint-GUID: QkU0GjPczTtugXyiwAaceugrZaK84o1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=627 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312210031
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Dec 2023 04:40:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15698

From: Robert Yang <liezhi.yang@windriver.com>

The following changes since commit baa6b64a946623db4db2d29f29f35ad0fec2b4d7:

  poky.conf: update SANITY_TESTED_DISTROS to match autobuilder (2023-12-20 23:36:00 +0000)

are available in the Git repository at:

  https://github.com/robertlinux/yocto rbt/event
  https://github.com/robertlinux/yocto/tree/rbt/event

Robert Yang (1):
  bitbake: event: Improve error message for eventhandler

 bitbake/lib/bb/event.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.42.0


