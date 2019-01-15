Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 8698B7C136
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2019 21:32:58 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0FLWZJ1028013
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 15 Jan 2019 13:32:36 -0800 (PST)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 15 Jan 2019 13:32:29 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Jan 2019 16:31:33 -0500
Message-ID: <20190115213137.113956-4-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20190115213137.113956-1-mark.hatle@windriver.com>
References: <20190115213137.113956-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/7] tests/fetch.py: Add alternative gitsm test case
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
X-List-Received-Date: Tue, 15 Jan 2019 21:32:58 -0000
Content-Type: text/plain

In order to test the ssh processing in gitsm, we add an alternative
testcase that can be downloaded from git.yoctoproject.org.  However,
this test case requries (read) access, via ssh, to git.yoctoproject.org.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/tests/fetch.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6848095..311c701 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -893,7 +893,11 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule(self):
-        fetcher = bb.fetch.Fetch(["gitsm://git.yoctoproject.org/git-submodule-test;rev=f12e57f2edf0aa534cf1616fa983d165a92b0842"], self.d)
+        # URL with ssh submodules
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=0d3ffc14bce95e8b3a21a0a67bfe4c4a96ba6350"
+        # Original URL (comment this if you have ssh access to git.yoctoproject.org)
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;rev=f12e57f2edf0aa534cf1616fa983d165a92b0842"
+        fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
-- 
1.8.3.1


