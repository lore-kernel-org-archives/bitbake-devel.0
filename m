Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE9C6FD20
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 07:09:15 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.95057.1679641745615118474
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Mar 2023 00:09:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=tJOwlXMR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=244794046a=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O718UM023370;
	Fri, 24 Mar 2023 00:09:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=C0HU+Ae75gRhZKzc7mGVSJSqlNJGt4K7R6wkGOFjiFE=;
 b=tJOwlXMRD3HKaIYRFGH/mkHmxEhE9BM96OsQ6K01JO1weOsP/Wdnha8MqYnJRqBP4naZ
 jJzQrkkgAsIqsx/3jtBpDLQVIxRnZvgp2Wywurg1hgv2n5khPg3Mas7VvbQk4oQXnXZE
 6rgHKgiOJJfFC2HUUMoH0sSp6kzVQy8SkaXq5ME7TG5W9L4NNe7KjDa9ZtZ7U99JZjP2
 r6qpcl4+u3K0Q9hK6qfCJewVRPyz1HhCmtm9NtZaAaKvh8PvrIx8GmrIFF3gFBKMiovW
 zSqIDlpubAy4DP1TOzaeQ36XGDj7Ue3FOoDguF3vQ51xR37XFNi3B6LU3tlHVrh0/XWi oQ== 
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pgxhurdrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Mar 2023 00:09:03 -0700
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Mar 2023 00:09:02 -0700
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.18 via Frontend Transport; Fri, 24 Mar 2023 00:09:03 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <sam@liddicott.com>, <troth@openavr.org>
Subject: [PATCH 0/1] fetch/git: Fix local clone url to make it work with repo
Date: Fri, 24 Mar 2023 00:09:01 -0700
Message-ID: <cover.1679641659.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: u9QRvIim4KqT45vMd7S1dUggT1JBu30W
X-Proofpoint-GUID: u9QRvIim4KqT45vMd7S1dUggT1JBu30W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_03,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=673 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 07:09:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14614

The following changes since commit 92993b4f77ec49b7f04458b722ede0f8a218e0e8:

  bitbake: fetch2/sftp: Fix fetching URIs with spaces (2023-03-23 22:41:32 +0000)

are available in the Git repository at:

  https://github.com/robertlinux/yocto rbt/git
  https://github.com/robertlinux/yocto/tree/rbt/git

Robert Yang (1):
  fetch/git: Fix local clone url to make it work with repo

 bitbake/lib/bb/fetch2/git.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.33.1


