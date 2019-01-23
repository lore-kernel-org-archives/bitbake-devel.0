Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id AD4FB6FFD7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Jan 2019 15:28:21 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0NFSL9S018860
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 23 Jan 2019 07:28:21 -0800 (PST)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Wed, 23 Jan 2019 07:28:21 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 23 Jan 2019 10:28:17 -0500
Message-ID: <20190123152818.63800-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20190123152818.63800-1-mark.hatle@windriver.com>
References: <20190123152818.63800-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] gitsm.py: Fix relative URLs
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 23 Jan 2019 15:28:21 -0000
Content-Type: text/plain

Prior code happened to work with relative URLs, when the code was recently
restructured it caused all relative urls to no longer work.  Restore the prior
code flow for relative support and better comment why that code is there.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 11 ++++++-----
 lib/bb/tests/fetch.py  |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 86198ee..faffb4c 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -98,6 +98,12 @@ class GitSM(Git):
                 uris[m] = md['url']
                 subrevision[m] = module_hash.split()[2]
 
+                # Convert relative to absolute uri based on parent uri
+                if uris[m].startswith('..'):
+                    newud = copy.copy(ud)
+                    newud.path = os.path.realpath(os.path.join(newud.path, uris[m]))
+                    uris[m] = Git._get_repo_url(self, newud)
+
         for module in submodules:
             # Translate the module url into a SRC_URI
 
@@ -120,11 +126,6 @@ class GitSM(Git):
                     # This has to be a file reference
                     proto = "file"
                     url = "gitsm://" + uris[module]
-                    if uris[module].startswith('..'):
-                        # Local on disk relative reference
-                        newud = copy.copy(ud)
-                        newud.path = os.path.realpath(os.path.join(newud.path, md['url']))
-                        url = "gitsm://" + Git._get_repo_url(self, newud)
 
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 1497a3c..de3b0ce 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -894,9 +894,9 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule(self):
         # URL with ssh submodules
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=f53765f515e0eeca569ed385bb1c89ce008bb058"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=049da4a6cb198d7c0302e9e8b243a1443cb809a7"
         # Original URL (comment this if you have ssh access to git.yoctoproject.org)
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=132fea6e4dee56b61bcf5721c94e8b2445c6a017"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=a2885dd7d25380d23627e7544b7bbb55014b16ee"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
-- 
1.8.3.1


