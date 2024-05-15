Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326BBC25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 09:26:41 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.10381.1715765200092440269
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 May 2024 02:26:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5865462aad=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F4rRi8010954
	for <bitbake-devel@lists.openembedded.org>; Wed, 15 May 2024 09:26:39 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y1yn541b5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 15 May 2024 09:26:39 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Wed, 15 May 2024 02:26:37 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.37 via Frontend Transport; Wed, 15 May 2024 02:26:37 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/1] fetch2/git.py: Try without '.git' suffix firstly
Date: Wed, 15 May 2024 02:26:37 -0700
Message-ID: <4a7647c4169ffc0c70858a4a1f1b2eb18ffcfb70.1715765153.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.35.5
In-Reply-To: <cover.1715765153.git.liezhi.yang@windriver.com>
References: <cover.1715765153.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BrVMGUliDXIE7J5uMVM0WjVMMGAAJL2v
X-Proofpoint-ORIG-GUID: BrVMGUliDXIE7J5uMVM0WjVMMGAAJL2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_04,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxlogscore=700 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150063
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 May 2024 09:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16220

From: Robert Yang <liezhi.yang@windriver.com>

If the repo on server is foo.git, both of the following commands
will work:
1) $ git clone <url>/foo.git
2) $ git clone <url>/foo
But only the second command works if the repo server is foo
(without .git suffix), so try without '.git' suffix firstly.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index c7ff769fdfe..0134344cdf3 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -442,11 +442,30 @@ class Git(FetchMethod):
                 objects = os.path.join(repourl_path, 'objects')
                 if os.path.isdir(objects) and not os.path.islink(objects):
                     repourl = repourl_path
-            clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
+            clone_cmd_pre = "LANG=C %s clone --bare --mirror --progress" % ud.basecmd
+            clone_cmd = "%s %s %s" % (clone_cmd_pre, shlex.quote(repourl), ud.clonedir)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
-            runfetchcmd(clone_cmd, d, log=progresshandler)
+            # If the repo on server is foo.git, both of the following commands
+            # will work:
+            # 1) $ git clone <url>/foo.git
+            # 2) $ git clone <url>/foo
+            # But only the second command works if the repo server is foo
+            # (without .git suffix), so try without '.git' suffix firstly
+            cloned_no_git = False
+            if repourl.endswith('.git'):
+                repourl_no_git = repourl[0:-4]
+                clone_cmd_no_git = "%s %s %s" % (clone_cmd_pre, shlex.quote(repourl_no_git), ud.clonedir)
+                try:
+                    runfetchcmd(clone_cmd_no_git, d, log=progresshandler)
+                    cloned_no_git = True
+                except bb.fetch2.FetchError:
+                    # The error messages have already been saved in the log, so
+                    # just pass to next cmd.
+                    pass
+            if not cloned_no_git:
+                runfetchcmd(clone_cmd, d, log=progresshandler)
 
         # Update the checkout if needed
         if self.clonedir_need_update(ud, d):
-- 
2.35.5


