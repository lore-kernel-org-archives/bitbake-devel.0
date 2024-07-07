Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C043CC41513
	for <webhook@archiver.kernel.org>; Sun,  7 Jul 2024 07:20:49 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.54131.1720336842959007072
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Jul 2024 00:20:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7918799487=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4677BQK1015672;
	Sun, 7 Jul 2024 07:20:41 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 406u4x0t31-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 07 Jul 2024 07:20:41 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 7 Jul 2024 00:20:38 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 7 Jul 2024 00:20:38 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <andre.draszik@linaro.org>, <kergoth@gmail.com>
Subject: [PATCH v2 2/2] bitbake: tests/fetch: Update GitShallowTest for clone_shallow_local()
Date: Sun, 7 Jul 2024 00:20:38 -0700
Message-ID: <17ce72286d39ecf3d25f43e7db9f9c2082ded505.1720336551.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720336551.git.liezhi.yang@windriver.com>
References: <cover.1720336551.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4ML36ACDCv5hxR8943UQcvO39r4p-TEu
X-Proofpoint-GUID: 4ML36ACDCv5hxR8943UQcvO39r4p-TEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=939
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407070058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 07 Jul 2024 07:20:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16396

From: Robert Yang <liezhi.yang@windriver.com>

Update the test cases since the implementation is changed:

* test_shallow_multi_one_uri()
  The a_branch and v0.0 had the same revision, and it required fetch a_branch
  and remove histories of v0.0 which were conflicted, and bitbake reported:
  fatal: no commits selected for shallow requests

  Make a_branch and v0.0 have different revs to fix the problem.

  And now the 'rev^' is not needed, so update self.assertRevCount() as well.

* test_shallow_multi_one_uri_depths()
  Update self.assertRevCount(), now git only fetches the required revs.

* test_shallow_fetch_missing_revs()
  The command is:
  $ git fetch --shallow-exclude=v0.0 master

  But master and v0.0 uses the same revision, so there is no commit to fetch.

* test_shallow_fetch_missing_revs_fails()
  Two unneeded committs are not fetched now:
  - rev^
  - One not specified or required tag.

  So update self.assertRevCount()

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/tests/fetch.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 701129d138..2ef2063436 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2034,9 +2034,9 @@ class GitShallowTest(FetcherTest):
         self.add_empty_file('b')
         self.git('checkout -b a_branch', cwd=self.srcdir)
         self.add_empty_file('c')
+        self.git('tag v0.0 HEAD', cwd=self.srcdir)
         self.add_empty_file('d')
         self.git('checkout master', cwd=self.srcdir)
-        self.git('tag v0.0 a_branch', cwd=self.srcdir)
         self.add_empty_file('e')
         self.git('merge --no-ff --no-edit a_branch', cwd=self.srcdir)
         self.add_empty_file('f')
@@ -2052,7 +2052,7 @@ class GitShallowTest(FetcherTest):
 
         self.fetch_shallow(uri)
 
-        self.assertRevCount(5)
+        self.assertRevCount(4)
         self.assertRefs(['master', 'origin/master', 'origin/a_branch'])
 
     def test_shallow_multi_one_uri_depths(self):
@@ -2199,7 +2199,7 @@ class GitShallowTest(FetcherTest):
 
         self.fetch_shallow()
 
-        self.assertRevCount(5)
+        self.assertRevCount(2)
 
     def test_shallow_invalid_revs(self):
         self.add_empty_file('a')
@@ -2218,7 +2218,10 @@ class GitShallowTest(FetcherTest):
         self.git('tag v0.0 master', cwd=self.srcdir)
         self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
         self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
-        self.fetch_shallow()
+
+        with self.assertRaises(bb.fetch2.FetchError), self.assertLogs("BitBake.Fetcher", level="ERROR") as cm:
+            self.fetch_shallow()
+        self.assertIn("fatal: no commits selected for shallow requests", cm.output[0])
 
     def test_shallow_fetch_missing_revs_fails(self):
         self.add_empty_file('a')
@@ -2249,7 +2252,7 @@ class GitShallowTest(FetcherTest):
         revs = len(self.git('rev-list master').splitlines())
         self.assertNotEqual(orig_revs, revs)
         self.assertRefs(['master', 'origin/master'])
-        self.assertRevCount(orig_revs - 1758)
+        self.assertRevCount(orig_revs - 1760)
 
     def test_that_unpack_throws_an_error_when_the_git_clone_nor_shallow_tarball_exist(self):
         self.add_empty_file('a')
-- 
2.25.1


