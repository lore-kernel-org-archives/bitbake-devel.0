Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40762C77B61
	for <webhook@archiver.kernel.org>; Mon, 27 Mar 2023 14:48:40 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.36984.1679928517083968074
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Mar 2023 07:48:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=FqhS0vNm;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=24501e850a=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R8AFm1001107
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 07:48:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PPS06212021;
 bh=dXxd0FrgLtB5jeZSFs7C5a24aal/u2zAi/KK5A8OI7E=;
 b=FqhS0vNmBBtmp8D2C91YHA4yQ4aGNtzgQ930KLBOss/i/sOJvgdF4Uw7VPlHOjyBzkgI
 TQt2f7ALqYgTxj4+BKdf5sTyPWeK96Sx+OxWMIqjML2VET7OSWRCCM+8ALryWS/LAyXN
 2+mW1VMt9Z/tPvIi9HFq8OaceGMXjLNzyQeQtBsHrlNbvgY7eheWui3CdLAGD6cPkZJw
 NHNys7XsZxtP1UGT8KyIGL2bTyyScnYgi7TDezDk5POnjSPfr5LGdo84n5aQgAgtlnkX
 vMMWmhUcQZC8zjY6+DmXuZNc45qx24nT0N258SGPZ7J4+KC665ErXqnBhfhNLMjEB6FS vw== 
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3phv85svkc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 07:48:36 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 07:48:36 -0700
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Mon, 27 Mar 2023 07:48:36 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/2] bitbake: bitbake-user-manual: Update EXCLUDE_FROM_WORLD
Date: Mon, 27 Mar 2023 07:48:35 -0700
Message-ID: <396b8a343a5ad6b5ddfdc42bb54d83396080ca4a.1679928440.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1679928440.git.liezhi.yang@windriver.com>
References: <cover.1679928440.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yOJ6CZ77Ml_MSiRKuer2NnGjUkCOtqtk
X-Proofpoint-ORIG-GUID: yOJ6CZ77Ml_MSiRKuer2NnGjUkCOtqtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270117
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Mar 2023 14:48:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14623

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 .../bitbake-user-manual/bitbake-user-manual-ref-variables.rst   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index a48e700030..25620fdda1 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -990,7 +990,7 @@ overview of their function and contents.
       ``bblayers.conf`` configuration file.
 
       To exclude a recipe from a world build using this variable, set the
-      variable to "1" in the recipe.
+      variable to "1" in the recipe. Set it to "0" to add it back to world build.
 
       .. note::
 
-- 
2.32.0


