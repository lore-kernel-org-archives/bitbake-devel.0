Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E49C4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 10:11:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web12.1596.1667988687422641029
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Nov 2022 02:11:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=cocQ7HxH;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8312f29ddf=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9A0knD028845
	for <bitbake-devel@lists.openembedded.org>; Wed, 9 Nov 2022 10:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=DIp01vFdTd1V62vx2xUqUAOqeAh4oaX9/gagxEWjSg4=;
 b=cocQ7HxHvJCuqomUwx9eL18ximYSRWZEL0slcdhvYJfOszjDA9aE215zWzQ449ggiGNN
 /k/6+5MZ2EUOBmaTqE4CS2BcIJYI4eH1jw+6IS2PN3dsy8kvfdKouew54ssK3D7HQmXN
 w/gHiysRMPv5Gb+OtrMuKEMgfGFr7ECbz2eyxzfeUXcaNN5aMuw9IeW/f+ZDqhRc5zSE
 iwLtVdRsgZHkdjWg8ax9Y9WGh2G6jv2KwHuU4o/1jdUNz6c7omknYuVH5QQf8/ieLDGv
 MbllidyQ9ojsq3XewAu0KXaaRrsQgm9uQEmCQ8S+T+4FkeGpqupgbdQulmu+Po0jMtwX kA== 
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3knd21kjgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 10:11:26 +0000
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 9 Nov 2022 02:11:25 -0800
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Wed, 9 Nov 2022 02:11:25 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 0/1] gitsm.py: process_submodules(): Set nobranch=1 for url
Date: Wed, 9 Nov 2022 02:11:24 -0800
Message-ID: <cover.1667988645.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: n9TPYS91W2u7y6caJbZREp9EDiZ3uIdW
X-Proofpoint-ORIG-GUID: n9TPYS91W2u7y6caJbZREp9EDiZ3uIdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_03,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=867 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090078
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 10:11:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14060

The following changes since commit b3d0e068f72b79f868940877b147fcfda67623a7:

  selftest: add a copy of previous mtd-utils version to meta-selftest (2022-11-08 22:47:17 +0000)

are available in the Git repository at:

  https://github.com/robertlinux/yocto rbt/gitsm
  https://github.com/robertlinux/yocto/tree/rbt/gitsm

Robert Yang (1):
  gitsm.py: process_submodules(): Set nobranch=1 for url

 bitbake/lib/bb/fetch2/gitsm.py | 1 +
 1 file changed, 1 insertion(+)

-- 
2.35.1


