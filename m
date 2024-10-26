Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C589AD10BF4
	for <webhook@archiver.kernel.org>; Sat, 26 Oct 2024 09:40:14 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.7515.1729935597086540200
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Oct 2024 02:39:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0029577ea3=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q9duLO015201
	for <bitbake-devel@lists.openembedded.org>; Sat, 26 Oct 2024 02:39:56 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42guq3r3ky-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 26 Oct 2024 02:39:56 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 26 Oct 2024 02:39:55 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sat, 26 Oct 2024 02:39:55 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/5] gitsm: Remove downloads/tmpdir when failed
Date: Sat, 26 Oct 2024 02:39:52 -0700
Message-ID: <c4e94db7e266f90dde06cd7d0e73dd3b035e121f.1729933869.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1729933869.git.liezhi.yang@windriver.com>
References: <cover.1729933869.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZInrphHHaVx6GKJgkuwCFUDwtuN93Yxi
X-Proofpoint-GUID: ZInrphHHaVx6GKJgkuwCFUDwtuN93Yxi
X-Authority-Analysis: v=2.4 cv=T9jeTOKQ c=1 sm=1 tr=0 ts=671cb8ec cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=DAUX931o1VcA:10 a=t7CeM3EgAAAA:8 a=v_V-7ndxxSk5bRTFhjoA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=519 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410260080
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Oct 2024 09:40:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16728

From: Robert Yang <liezhi.yang@windriver.com>

The tmpdir such as downloads/tmplp3cnemv won't be removed without this fix.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 17aac6357..fab4b1164 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -152,9 +152,11 @@ class GitSM(Git):
         # unpacked temporarily so that we can examine the .gitmodules file
         if ud.shallow and os.path.exists(ud.fullshallow) and extra_check:
             tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
-            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
-            self.process_submodules(ud, tmpdir, subfunc, d)
-            shutil.rmtree(tmpdir)
+            try:
+                runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
+                self.process_submodules(ud, tmpdir, subfunc, d)
+            finally:
+                shutil.rmtree(tmpdir)
         else:
             self.process_submodules(ud, ud.clonedir, subfunc, d)
 
-- 
2.25.1


