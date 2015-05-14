Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 196D37412D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 13:34:01 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 14 May 2015 06:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,427,1427785200"; d="scan'208";a="710148909"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com) ([10.252.30.48])
	by fmsmga001.fm.intel.com with ESMTP; 14 May 2015 06:34:01 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 May 2015 14:33:50 +0100
Message-Id: <71b885bed64a20eb321cf732ba516a55cbcb5f7d.1431610370.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1431610370.git.paul.eggleton@linux.intel.com>
References: <cover.1431610370.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1431610370.git.paul.eggleton@linux.intel.com>
References: <cover.1431610370.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] tests/fetch: ensure fetch tests preserve current dir
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
X-List-Received-Date: Thu, 14 May 2015 13:34:01 -0000

The fetcher calls os.chdir() in a number of places, which can affect
other tests (since the directory it changes into gets deleted) - let's
just put the current directory back to where it was when we're done.

(This fixes bb.tests.Path.test_unsafe_delete_path failing if it was run
as part of a full bitbake-selftest run, where the fetcher tests get to
run before it.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tests/fetch.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d3f7b6a..3575468 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -315,6 +315,7 @@ class URITest(unittest.TestCase):
 class FetcherTest(unittest.TestCase):
 
     def setUp(self):
+        self.origdir = os.getcwd()
         self.d = bb.data.init()
         self.tempdir = tempfile.mkdtemp()
         self.dldir = os.path.join(self.tempdir, "download")
@@ -326,6 +327,7 @@ class FetcherTest(unittest.TestCase):
         self.d.setVar("PERSISTENT_DIR", persistdir)
 
     def tearDown(self):
+        os.chdir(self.origdir)
         bb.utils.prunedir(self.tempdir)
 
 class MirrorUriTest(FetcherTest):
-- 
2.1.0


