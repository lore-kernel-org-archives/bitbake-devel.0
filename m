Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E3C761A6
	for <webhook@archiver.kernel.org>; Mon, 27 Mar 2023 14:48:40 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.36881.1679928518155227943
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Mar 2023 07:48:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=S5VeKggF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=24501e850a=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RBmSlo017265
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 14:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PPS06212021;
 bh=mT6bFw7WWUe9Tivc3MNr5cuqEmnTEAZWRSjJH0KLWGA=;
 b=S5VeKggFX49Dze2fL/aj/WJbbr24Jhu2nyA1LNeDSQ0isTNvQ/Wqj2zTo4rfH5Tx1ZXm
 aAAyianbrN5y3w25JROq+d5fdPhLqHDWB3q1mwc1s7WIFC2/WsVHYTMF98KPgdTD/vpe
 RUkvWdeUXVJrLUf5heCC3DMCr7O7GDFwuzRmVOaEJ5/RfOhtVbypaO+G/hXa1aPMNe5p
 MKs/6lT37Ji6fhOdx0ond7Oq+tETdN6hZ0J7LeAunxUTeV5puhBc30tH613tsta6BiGv
 0P5LpLXZuyhdRwuqsmlXv0AagM4BiZz0Mw0vwauenVbQXXE+4teOJ0t1DIM8cUgPgN1S JQ== 
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3php6423mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 14:48:37 +0000
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.18; Mon, 27 Mar 2023 07:48:36 -0700
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Mon, 27 Mar 2023 07:48:36 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/2] cache: Make EXCLUDE_FROM_WORLD boolean
Date: Mon, 27 Mar 2023 07:48:34 -0700
Message-ID: <afe937d03290c1cccaa5b85c0fd5130acf1f14d5.1679928440.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1679928440.git.liezhi.yang@windriver.com>
References: <cover.1679928440.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I-9rhhS1gQoRetBd72cwOqeN5bmQNZSQ
X-Proofpoint-GUID: I-9rhhS1gQoRetBd72cwOqeN5bmQNZSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=927 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270117
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 14:48:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14624

Fixed:
Set EXCLUDE_FROM_WORLD = "0" in recipe_A:
$ bitbake world -g

Check pn-buildlist, the recipe_A won't be built, this patch fixes the problem:
EXCLUDE_FROM_WORLD = "1": Not build in world
EXCLUDE_FROM_WORLD = "0": Add back to world build

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index b309775bb9..10910a6809 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -216,7 +216,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         # Collect files we may need for possible world-dep
         # calculations
-        if not self.not_world:
+        if not bb.utils.to_boolean(self.not_world):
             cachedata.possible_world.append(fn)
         #else:
         #    logger.debug2("EXCLUDE FROM WORLD: %s", fn)
-- 
2.32.0


