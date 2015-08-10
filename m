Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 5617C7687E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:43 +0000 (UTC)
Received: by wijp15 with SMTP id p15so131340433wij.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=iDK1LMV3XuiPW04gHLFr/hD4ReOADvKlkX0SVxQAiAE=;
	b=BWqw6f/OGkSDojYvvEZBg1Hk3C4oSRSvcve7zQ2PShq+OVJ2e5sFQnz8GXHuF1Ca4f
	X9mJhxUJx820rEGNTjXp42MeWUBdQM+MFNmTGMVAkq/EKSg2SLa5UgcJHhO2bPH0e8J8
	dUDd3P0HGTRsCV9fgSr/K9jl3w42HkSZpXW+Qpba71tQzbZn6/UL/UefU+zX95lXaVIP
	E85txPpHoBv3Mvwb0aOMxhrYwImVeNW1iog2Ja70LJ8xAnx7FDyrBgNeWCAxxUgN+0K1
	OQAajoZKB3ae2NgqDFTmZxv9TtnKt+5ev2YGYxuegz6xnjgXXrR/IvseFmc06yvDnXFT
	wydQ==
X-Gm-Message-State: ALoCoQlIpNcvWLf8ZzebzutiWZ7Y+iIbwe0TtmnKSvLU5K13nkm3wa5djSwBtJBJPpCjQh/7vT9O
X-Received: by 10.180.96.230 with SMTP id dv6mr23995064wib.23.1439205703781;
	Mon, 10 Aug 2015 04:21:43 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.42
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:43 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:25 +0100
Message-Id: <3d34221aec2ff552b10e5a58456fc224ecba4e3e.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
	<1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 02/11] toaster: fix test_build_layerversion test case
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:44 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

The reason of test failure is that Django querysets are
different even if they contain the same objects.

Fixed by converting querysets into lists.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index df9a2a9..8bb5dec 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -117,7 +117,7 @@ class LayerVersionEquivalenceTestCase(TestCase):
         # getting the build layerversion equivalent list must return the same list as the original layer
         build_equivalent_list = self.layerversion_build.get_equivalents_wpriority(self.project)
 
-        self.assertTrue(equivalent_list == build_equivalent_list, "%s is not %s" % (equivalent_list, build_equivalent_list))
+        self.assertEqual(list(equivalent_list), list(build_equivalent_list))
 
 class ProjectLVSelectionTestCase(TestCase):
     def setUp(self):
-- 
2.1.4


