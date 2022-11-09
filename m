Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D96C433FE
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 10:11:29 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web08.1638.1667988686739072528
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Nov 2022 02:11:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=LjY7zdeQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8312f29ddf=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A98mPBT021672
	for <bitbake-devel@lists.openembedded.org>; Wed, 9 Nov 2022 02:11:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PPS06212021;
 bh=y8kUql2DWWMh3DqHggMMQ6gOzbXJc1yBcfs11Xjj/cc=;
 b=LjY7zdeQTp9q+ABXaZQ28vDTdAMl2UX/vSyGnlF27lBfY5n4RN8Gs7ytQw1evwdP1jBY
 6aM1977iufTOOyVgSynEfRsMI1TTtZMh0Fl/brPwD1QeHS2mN+oQNwSpyNWzxMU6Unjt
 ZkHpsbjtgAqxzPc8z0P34zbYxvvGFG2R2eMbe3f1SXCXmE1oAE+xVR85AzWETvTQ/hkb
 h3gejbZ6px/H2sevcbYpCUGA5qX3deGVeUTpUpVXofMgX74rZlzjV7hzsjxoKdG6CA9u
 8EMhEa16mDNfIT841NFNcGDekLqsIpIx1R91O1G0Qi6HVObRlfKX8Yt49jf+EM9xbr4k hA== 
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3knqbkk7rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 02:11:26 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 9 Nov 2022 02:11:25 -0800
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Wed, 9 Nov 2022 02:11:25 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/1] gitsm.py: process_submodules(): Set nobranch=1 for url
Date: Wed, 9 Nov 2022 02:11:25 -0800
Message-ID: <ae52688eb26799338abf1c6a6a7f29d7acce39dc.1667988645.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1667988645.git.liezhi.yang@windriver.com>
References: <cover.1667988645.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JECDHpUjtrfURD8rD-ugwRCK8mg34w1w
X-Proofpoint-ORIG-GUID: JECDHpUjtrfURD8rD-ugwRCK8mg34w1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_03,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=793
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090078
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 10:11:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14059

Just like download_submodule() does, fixed warings when run
bb.fetch2.Fetch([url], d) in process_submodules' function:

WARNING: grpc-native-1.50.0-r0 do_fetch: URL: gitsm://github.com/abseil/abseil-cpp.git;protocol=https;name=third_party/abseil-cpp;subpath=third_party/abseil-cpp does not set any branch parameter. The future default branch used by tools and repositories is uncertain and we will therefore soon require this is set in all git urls.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/gitsm.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index 25d5db0e5b6..e4bce3d5bef 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -122,6 +122,7 @@ class GitSM(Git):
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
             url += ";subpath=%s" % module
+            url += ";nobranch=1"
 
             ld = d.createCopy()
             # Not necessary to set SRC_URI, since we're passing the URI to
-- 
2.35.1


