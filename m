Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E856C76195
	for <webhook@archiver.kernel.org>; Mon, 27 Mar 2023 14:48:40 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.36879.1679928516877707842
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Mar 2023 07:48:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=ZsJ+ifHj;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=24501e850a=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R8AFm0001107
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 07:48:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=/6Lh6uqvN+bnYzUihacNOSn7jKRlPhoHf6k2PFZRJno=;
 b=ZsJ+ifHjaYKlqaeuG7Cr2ZhhlEnw1881T09wETkejetJG3irYpTDPOxTbLIiH/PMMMBa
 HEF3dfK/GkZyEU2LWuCT1SnQ5Sa7m8uAl0vIZrDQ4RWu6gJ1Qd5e1q7WMWGAXXiCK6X8
 Ku4ZsRY9q2D683u1MxYFCf0GLzLQa82BjGrOOINQx9o56nB5YX19duVTw19aLrvbXCOd
 6hFFm+BB9Xy1qmqVxJZUCwOUTYqHIfJO4ybtq6xs4BgH6F6iIxrTOnAC8FghnHSAnh6y
 jb7uaamT9ZVqg7ZgGCTaBvtwAxVScKj3V1W5QRqq+WRaIHGjnPLDTGL7catKoVkAyyJm 8Q== 
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3phv85svkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 07:48:36 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 07:48:35 -0700
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Mon, 27 Mar 2023 07:48:35 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 0/2] cache: Make EXCLUDE_FROM_WORLD boolean
Date: Mon, 27 Mar 2023 07:48:33 -0700
Message-ID: <cover.1679928440.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: y9yvcTP2x0ivscj3g7Ff8bUy55BfZdgD
X-Proofpoint-ORIG-GUID: y9yvcTP2x0ivscj3g7Ff8bUy55BfZdgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxlogscore=895 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270117
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 14:48:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14622

The following changes since commit a94ca827c2066b22c746003f5144b89d28b13a1a:

  yocto-bsp/5.15: update to v5.15.103 (2023-03-26 18:51:03 +0100)

are available in the Git repository at:

  https://github.com/robertlinux/yocto rbt/world
  https://github.com/robertlinux/yocto/tree/rbt/world

Robert Yang (2):
  cache: Make EXCLUDE_FROM_WORLD boolean
  bitbake: bitbake-user-manual: Update EXCLUDE_FROM_WORLD

 .../bitbake-user-manual/bitbake-user-manual-ref-variables.rst   | 2 +-
 bitbake/lib/bb/cache.py                                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.32.0


