Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF1C7EE23
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 20:43:52 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.29825.1677271427972643630
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Feb 2023 12:43:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=YQ4fp3CK;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1419724ccc=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OKLAfn006192
	for <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 20:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=vvPEw5j8qway4kX0AEckLEkNoepn+PpFtKuj5P/5NPs=;
 b=YQ4fp3CKdEc4shfsczFEg66wrYl7fGd6gXl+7Qszh4S3O8dF2l2aojXyT++r6RMRbZy0
 uKjQl8LgW8aeybyyhnSrF6n0NOQaHlG+oLRERrzXAjcQLAai/dxI1SZFZNiwcBn2xllY
 78RrgYuiZNoEhMh3Bryu4TOBa1dZV/oxHhjLqi9lRHGIJD1Zz3nmHOGQxDwJQFd9E2OB
 0/cdAhLsmWYRv/twaGhh8iMicAIwi6PfY/VlVs9hQ+sbnDM1ykA66wavKzLwxxqjoRUQ
 AWi9V/gtXkvoI9US7vSlbIYUEWTsq9mdY5ex6m6Dwkqb1ZbxU0P4TW1tz4M8LQHZ0Dkj jw== 
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ntpd3x608-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 20:43:46 +0000
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.18; Fri, 24 Feb 2023 12:43:45 -0800
Received: from YOW-MASSELST-L1.corp.ad.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Fri, 24 Feb 2023 12:43:45 -0800
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetcher: npmsw: add more short forms for git operations
Date: Fri, 24 Feb 2023 15:43:44 -0500
Message-ID: <20230224204344.1919-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -roeJGhaJva5QnDo04IIsOM6BLCqnnff
X-Proofpoint-ORIG-GUID: -roeJGhaJva5QnDo04IIsOM6BLCqnnff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_15,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=906 clxscore=1011 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240165
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 20:43:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14490

From the npm-install documentation [1] the CLI provides a set of
short forms when the install fetches from git. These include

"github:"
example: npm install github:mygithubuser/myproject

"gist:"
example: npm install gist:101a11beef

"gitlab:"
example: npm install gitlab:mygitlabuser/myproject

"bitbucket:"
example: npm install bitbucket:mybitbucketuser/myproject

Commit 1d8af6aed0a9 [fetch2: npmsw: Add support for github prefix in
npm shrinkwrap version] by Stefan Herbrechtsmeier added support for
the "github:" but the others would marked as 'Unsupported dependency'.

The other prefixes are added in this commit, along with extending the
tests to cover some of these.

However, there is one more short form for github which npm-install
allows which forgoes the prefix altogether.

example: npm install mygithubuser/myproject

Unfortunately this format is a bit problematic as it lacks any easily
identifiable 'marker' to match against, and it could be either the
github short form or install from folder format. Experimentation shows
that the folder format requires a leading './' or '/', so we use this
to rule out the ambiguity.

If this approach to folder and github formats disambiguation is
incorrect it won't matter anyways as the folder format is unrecognized
by the code as-is and thus with this change or without, things would
fail.

Since we have to be less strict in the check for git operations we
move it to be the last install format which we check, such that the
less ambiguous formats can be sorted out first.

[1] https://docs.npmjs.com/cli/v9/commands/npm-install

[Yocto #14236]

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 lib/bb/fetch2/npmsw.py | 26 +++++++++++++++++++-------
 lib/bb/tests/fetch.py  | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index a8c4d352..36fcbfba 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -129,10 +129,28 @@ class NpmShrinkWrap(FetchMethod):
 
                 localpath = os.path.join(d.getVar("DL_DIR"), localfile)
 
+            # Handle local tarball and link sources
+            elif version.startswith("file"):
+                localpath = version[5:]
+                if not version.endswith(".tgz"):
+                    unpack = False
+
             # Handle git sources
-            elif version.startswith("git"):
+            elif version.startswith(("git", "bitbucket","gist")) or (
+                not version.endswith((".tgz", ".tar", ".tar.gz"))
+                and not version.startswith((".", "@", "/"))
+                and "/" in version
+            ):
                 if version.startswith("github:"):
                     version = "git+https://github.com/" + version[len("github:"):]
+                elif version.startswith("gist:"):
+                    version = "git+https://gist.github.com/" + version[len("gist:"):]
+                elif version.startswith("bitbucket:"):
+                    version = "git+https://bitbucket.org/" + version[len("bitbucket:"):]
+                elif version.startswith("gitlab:"):
+                    version = "git+https://gitlab.com/" + version[len("gitlab:"):]
+                elif not version.startswith(("git+","git:")):
+                    version = "git+https://github.com/" + version
                 regex = re.compile(r"""
                     ^
                     git\+
@@ -158,12 +176,6 @@ class NpmShrinkWrap(FetchMethod):
 
                 url = str(uri)
 
-            # Handle local tarball and link sources
-            elif version.startswith("file"):
-                localpath = version[5:]
-                if not version.endswith(".tgz"):
-                    unpack = False
-
             else:
                 raise ParameterError("Unsupported dependency: %s" % name, ud.url)
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 54148b3f..73eefc59 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2664,6 +2664,45 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_modules', 'array-flatten', 'node_modules', 'content-type', 'package.json')))
         self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_modules', 'array-flatten', 'node_modules', 'content-type', 'node_modules', 'cookie', 'package.json')))
 
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npmsw_git(self):
+        swfile = self.create_shrinkwrap_file({
+            'dependencies': {
+                'cookie': {
+                    'version': 'github:jshttp/cookie.git#aec1177c7da67e3b3273df96cf476824dbc9ae09',
+                    'from': 'github:jshttp/cookie.git'
+                }
+            }
+        })
+        fetcher = bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'github.com.jshttp.cookie.git')))
+
+        swfile = self.create_shrinkwrap_file({
+            'dependencies': {
+                'cookie': {
+                    'version': 'jshttp/cookie.git#aec1177c7da67e3b3273df96cf476824dbc9ae09',
+                    'from': 'jshttp/cookie.git'
+                }
+            }
+        })
+        fetcher = bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'github.com.jshttp.cookie.git')))
+
+        swfile = self.create_shrinkwrap_file({
+            'dependencies': {
+                'nodejs': {
+                    'version': 'gitlab:gitlab-examples/nodejs.git#892a1f16725e56cc3a2cb0d677be42935c8fc262',
+                    'from': 'gitlab:gitlab-examples/nodejs'
+                }
+            }
+        })
+        fetcher = bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'gitlab.com.gitlab-examples.nodejs.git')))
+
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
-- 
2.30.2


