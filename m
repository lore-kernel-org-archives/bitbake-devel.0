Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA64CD10BE8
	for <webhook@archiver.kernel.org>; Sat, 26 Oct 2024 09:40:04 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.7481.1729935596761489191
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Oct 2024 02:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0029577ea3=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q9duLN015201
	for <bitbake-devel@lists.openembedded.org>; Sat, 26 Oct 2024 02:39:56 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42guq3r3ky-2
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
Subject: [PATCH 1/5] gitsm: Add call_process_submodules() to remove duplicated code
Date: Sat, 26 Oct 2024 02:39:51 -0700
Message-ID: <225e12d3e1e6bce1fec57dddaf98265b12fac6e1.1729933869.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1729933869.git.liezhi.yang@windriver.com>
References: <cover.1729933869.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GcTUAlSA9oFv3mIW83OEEHWZaMQzk7tl
X-Proofpoint-GUID: GcTUAlSA9oFv3mIW83OEEHWZaMQzk7tl
X-Authority-Analysis: v=2.4 cv=T9jeTOKQ c=1 sm=1 tr=0 ts=671cb8ec cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=DAUX931o1VcA:10 a=t7CeM3EgAAAA:8 a=zRjKW--kFAl0N-WWwRgA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=855 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410260080
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Oct 2024 09:40:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16727

From: Robert Yang <liezhi.yang@windriver.com>

There are 14 lines can be removed, and can make it easy to maintain.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index f7f3af721..17aac6357 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -147,6 +147,17 @@ class GitSM(Git):
 
         return submodules != []
 
+    def call_process_submodules(self, ud, d, extra_check, subfunc):
+        # If we're using a shallow mirror tarball it needs to be
+        # unpacked temporarily so that we can examine the .gitmodules file
+        if ud.shallow and os.path.exists(ud.fullshallow) and extra_check:
+            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
+            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
+            self.process_submodules(ud, tmpdir, subfunc, d)
+            shutil.rmtree(tmpdir)
+        else:
+            self.process_submodules(ud, ud.clonedir, subfunc, d)
+
     def need_update(self, ud, d):
         if Git.need_update(self, ud, d):
             return True
@@ -164,15 +175,7 @@ class GitSM(Git):
                 logger.error('gitsm: submodule update check failed: %s %s' % (type(e).__name__, str(e)))
                 need_update_result = True
 
-        # If we're using a shallow mirror tarball it needs to be unpacked
-        # temporarily so that we can examine the .gitmodules file
-        if ud.shallow and os.path.exists(ud.fullshallow) and not os.path.exists(ud.clonedir):
-            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
-            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
-            self.process_submodules(ud, tmpdir, need_update_submodule, d)
-            shutil.rmtree(tmpdir)
-        else:
-            self.process_submodules(ud, ud.clonedir, need_update_submodule, d)
+        self.call_process_submodules(ud, d, not os.path.exists(ud.clonedir), need_update_submodule)
 
         if need_update_list:
             logger.debug('gitsm: Submodules requiring update: %s' % (' '.join(need_update_list)))
@@ -195,16 +198,7 @@ class GitSM(Git):
                 raise
 
         Git.download(self, ud, d)
-
-        # If we're using a shallow mirror tarball it needs to be unpacked
-        # temporarily so that we can examine the .gitmodules file
-        if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
-            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
-            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
-            self.process_submodules(ud, tmpdir, download_submodule, d)
-            shutil.rmtree(tmpdir)
-        else:
-            self.process_submodules(ud, ud.clonedir, download_submodule, d)
+        self.call_process_submodules(ud, d, self.need_update(ud, d), download_submodule)
 
     def unpack(self, ud, destdir, d):
         def unpack_submodules(ud, url, module, modpath, workdir, d):
@@ -263,14 +257,6 @@ class GitSM(Git):
             newfetch = Fetch([url], d, cache=False)
             urldata.extend(newfetch.expanded_urldata())
 
-        # If we're using a shallow mirror tarball it needs to be unpacked
-        # temporarily so that we can examine the .gitmodules file
-        if ud.shallow and os.path.exists(ud.fullshallow) and ud.method.need_update(ud, d):
-            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
-            subprocess.check_call("tar -xzf %s" % ud.fullshallow, cwd=tmpdir, shell=True)
-            self.process_submodules(ud, tmpdir, add_submodule, d)
-            shutil.rmtree(tmpdir)
-        else:
-            self.process_submodules(ud, ud.clonedir, add_submodule, d)
+        self.call_process_submodules(ud, d, ud.method.need_update(ud, d), add_submodule)
 
         return urldata
-- 
2.25.1


