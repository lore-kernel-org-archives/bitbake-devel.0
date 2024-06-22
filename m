Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A02EC27C53
	for <webhook@archiver.kernel.org>; Sat, 22 Jun 2024 05:20:15 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.92140.1719033609220619138
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jun 2024 22:20:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6903ff9387=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45M5H916001513
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jun 2024 22:20:09 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yvrmq9et2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jun 2024 22:20:08 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 22:20:07 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 22:20:07 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/1] fetch2/git: Use basename for gitsrcname when ud.proto is file
Date: Fri, 21 Jun 2024 22:20:07 -0700
Message-ID: <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1719033434.git.liezhi.yang@windriver.com>
References: <cover.1719033434.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CoJnm200oU8aO0GGKGRfBkeXXLeo0NW5
X-Proofpoint-GUID: CoJnm200oU8aO0GGKGRfBkeXXLeo0NW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_02,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=836 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2406220032
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Jun 2024 05:20:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16372

From: Robert Yang <liezhi.yang@windriver.com>

The previous code added local path to generated mirror tarball name which had
two potential issues when fetch from local PREMIRROR, for exapmle:

Add github.com.lsof-org.lsof to /path/to/local/PREMIRROR/
$ bitbake lsof -cfetch

* There might be "Fix File name too long error" when the local path is long
  since the path is translated to filename and added to downloads/git2/ as:
  path.to.local.PREMIRROR.github.com.lsof-org.lsof

* When enable BB_GENERATE_MIRROR_TARBALLS:
  The tarball name will be:
  git2_path.to.local.PREMIRROR.github.com.lsof-org.lsof.tar.gz

  The above tarball can't be re-used by do_fetch since bitbake looks for
  'git2_github.com.lsof-org.lsof.tar.gz', but the 'path.to.local.PREMIRROR' in
  the file name breaks the match.

Use os.path.basename(ud.path) as gitsrcname when ud.proto is file can fix the
the above two issues, now the file name in downloads/git2/ is:
github.com.lsof-org.lsof

And the generated tarball is:
git2_github.com.lsof-org.lsof.tar.gz

Or when BB_GIT_SHALLOW is enabled:
gitshallow_github.com.lsof-org.lsof_2e4c7a1-1_master.tar.gz

And the tarballs can be re-used by do_fetch.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index c7ff769fdf..89d3268f7f 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -277,7 +277,10 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
+        if ud.proto == "file":
+            gitsrcname = '%s' % os.path.basename(ud.path)
+        else:
+            gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
         if gitsrcname.startswith('.'):
             gitsrcname = gitsrcname[1:]
 
-- 
2.45.1


