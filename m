Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7EEC46CD4
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 06:06:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.140595.1703830004910966330
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Dec 2023 22:06:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=exHfTK0D;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=17273a50bb=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BT5iuJN007303
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 06:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=/D2zE
	R+Sq0cYZxEHXXjZHdsRM97IGzBTIC797lzid0o=; b=exHfTK0D1RH5easMknPKR
	yW8ShLkbGDuo2bQzGK0TlIN1kSBoVNJGSHL6atnZ6hWrc4efwoGp5lI9hScisV9m
	1TvdoB5mwsWzTLe45WRGhk/Kz8KYPHR1rUj2jRybaDFZqlE0Z/Xca4SjY87t4hFb
	OaunLOFZulpQsqre0bjb6VSvYYJRUxBsGWOx2XCx+6TZMo6aOzMd6lvanrI0vgTi
	a6XXwjVAws6h5j8Y/AXZPS13+eIaa31Hyzu/lzLf75NitkKwgQ8iXA7YasJ6lh9l
	BxvXrcphUifmzUfveg6MMI4hxPxQ0TtnSirUd0EiZl96Xn/KiietiVdRKRyywsAG
	g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5mrxw11c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 06:06:43 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 22:06:47 -0800
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 22:06:47 -0800
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v3 0/1] bitbake: event: Inject empty lines to make code match lineno in filename
Date: Thu, 28 Dec 2023 22:06:41 -0800
Message-ID: <cover.1703829627.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iyzSTGDJ6-nJw62jrerV_VzWMbAPPMHC
X-Proofpoint-GUID: iyzSTGDJ6-nJw62jrerV_VzWMbAPPMHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312290045
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 06:06:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15718

From: Robert Yang <liezhi.yang@windriver.com>

* V3: Inject empty lines to make code match lineno in filename as suggested by RP.

// Robert

The following changes since commit 6ce42d73a31bf9b2fc362fa4acad11de97ac96ec:

  scripts: Drop shell sstate-cache-management (2023-12-28 10:57:49 +0000)

are available in the Git repository at:

  https://github.com/robertlinux/yocto rbt/event
  https://github.com/robertlinux/yocto/tree/rbt/event

Robert Yang (1):
  bitbake: event: Inject empty lines to make code match lineno in
    filename

 bitbake/lib/bb/event.py | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.42.0


