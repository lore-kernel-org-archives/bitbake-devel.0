Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 474FB768AA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:48 +0000 (UTC)
Received: by wibhh20 with SMTP id hh20so146011374wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Sm2RjajIyD0Q3mH6pUqePesG6dbg9jF3h6fyo6jzPaI=;
	b=Kq/ttze8z7EHlpWzswhhBFrBDdX3BCp8EptFi+3O4wEXw3gcyLkeTpmRu8BMmSipWm
	tfxW3PFz9Tws/7dRdVre21VDm7ynw1SNcBXwjx5jIT6T6gavyFN1tB0eIonttIn3lWbL
	FiqVNuijUhd51OrDlP78cPeR0oibi1DLBhUW7V5C/7lsqBnKB1dB2PDdozFuVVkad78R
	5oAVwaMDZEpQqeSKX3lYlO4SU2WX/J1w8oy2Gc7FO5UgdeN55a95qXqa1PTomAIc+nvU
	TsUtXH3CgwnbJRKIamnkaAQG4jJ9H2gjalCapBej/PLU4U7e+xQh3fkfbbPpkHILSmA4
	bhNQ==
X-Gm-Message-State: ALoCoQlxXFr0lzWPcGWwh5WpNFoB+3M3pNwT0+kuxH4B4JppAdL8gHrK+yabbBpxy5ExVJR2w7aA
X-Received: by 10.180.74.148 with SMTP id t20mr23739657wiv.31.1439205709094;
	Mon, 10 Aug 2015 04:21:49 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:48 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:31 +0100
Message-Id: <2419ec1dc82f500cbd2ea1dac87c1bd54287872c.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
	<1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 08/11] toaster: simplify testcase code
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:49 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Replaced 2 asserts with one in test_single_layersource method
of ProjectLVSelectionTestCase.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index 6837038..a57a62c 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -162,7 +162,6 @@ class ProjectLVSelectionTestCase(TestCase):
         setup_lv_tests(self)
 
     def test_single_layersource(self):
-        compatible_layerversions = self.project.compatible_layerversions()
-        self.assertTrue(len(compatible_layerversions) == 1)
-        self.assertTrue(compatible_layerversions[0] == self.lver)
+        compat_lv = self.project.compatible_layerversions()
+        self.assertEqual(list(compat_lv), [self.lver])
 
-- 
2.1.4


