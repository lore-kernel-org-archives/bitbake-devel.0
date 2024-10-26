Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BD0D10BF2
	for <webhook@archiver.kernel.org>; Sat, 26 Oct 2024 09:40:04 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.7516.1729935598368227302
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Oct 2024 02:39:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0029577ea3=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q9duLS015201
	for <bitbake-devel@lists.openembedded.org>; Sat, 26 Oct 2024 02:39:58 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42guq3r3ky-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 26 Oct 2024 02:39:57 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 26 Oct 2024 02:39:56 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sat, 26 Oct 2024 02:39:56 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 5/5] git: Clean broken symlink
Date: Sat, 26 Oct 2024 02:39:55 -0700
Message-ID: <e0f7bc3c5f28bf27b17bd1ef39a9abea18011976.1729933869.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1729933869.git.liezhi.yang@windriver.com>
References: <cover.1729933869.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9NR13Hfj2QDaGr_lA12cWCfSsWSFawYh
X-Proofpoint-GUID: 9NR13Hfj2QDaGr_lA12cWCfSsWSFawYh
X-Authority-Analysis: v=2.4 cv=T9jeTOKQ c=1 sm=1 tr=0 ts=671cb8ee cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=DAUX931o1VcA:10 a=t7CeM3EgAAAA:8 a=i-pdAb-jyaQ2gLOA71kA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=721 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410260080
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Oct 2024 09:40:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16731

From: Robert Yang <liezhi.yang@windriver.com>

The file may be a symlink when mirror from local disk, and the symlink will be
broken when the linked file is removed, use os.path.islink() to check and
remove the broken symlink.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0ea55e139..6badda597 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -733,7 +733,7 @@ class Git(FetchMethod):
             to_remove.append(ud.fullshallow + ".done")
 
         for r in to_remove:
-            if os.path.exists(r):
+            if os.path.exists(r) or os.path.islink(r):
                 bb.note('Removing %s' % r)
                 bb.utils.remove(r, True)
 
-- 
2.25.1


