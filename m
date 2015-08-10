Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id B088E73D46
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:20:46 +0000 (UTC)
Received: by wijp15 with SMTP id p15so131309211wij.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=8x6e9dvkzHBZ8HlR5H9fUDad8r6zB+WJUSuvAGkB894=;
	b=B+QHG/GnMQ998iOMiGjE9fWOhbyyRh7xXOoWYT1NEhjUJzNyVLQE9ZnoKa+nXDDLMH
	KTjNkAeRqQILOgHIIM6VwShcSy5sCZq5jZODFeMqqhWPHBn0GB4VWKLOzA1AL5TdC162
	mGZmNvzM/oHR/mQJUy6oq/FxOdzXhKgfPsBinAputfxlOgsYAtx7J1eYRzj/KaFkHY+k
	7RzQtgMh0GUolGQqRws9H8Plf+dK7YQznda1mBHFG1ntLlbntXWRKoavHr3jKySzZLMx
	MGdMSrrsprOeVbs/kXDO8U42nWGBfnA+EV0+nK9VZBjV0ujUNGZbTH8jX0iUnLVZVKJS
	BhYw==
X-Gm-Message-State: ALoCoQkstkgl0rc5DMPS0j9r7HVnZpvoQRAt89BM9srQ1XXEvzjBGcVdaqExp3wxp8y96N60+8eR
X-Received: by 10.194.248.201 with SMTP id yo9mr41174362wjc.31.1439205646328; 
	Mon, 10 Aug 2015 04:20:46 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	r6sm13277201wiy.13.2015.08.10.04.20.45
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:20:45 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:20:17 +0100
Message-Id: <cover.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 00/11] Fixes and clean ups for Toaster ORM unit tests
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
X-List-Received-Date: Mon, 10 Aug 2015 11:20:46 -0000

This patchset contains fixes and code cleanups for Toaster ORM tests.
Some tests were completely rewritten. Reviewed by Michael Wood.

The following changes since commit c75cefe8a382a63f625123c156137782db118f64:

  libpam: Fix patch broken during upgrade (2015-08-09 15:15:33 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib michaelw/toaster/submit/ed/toaster/fix-orm-tests
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=michaelw/toaster/submit/ed/toaster/fix-orm-tests

Ed Bartosh (11):
  toaster: remove prints from the test code
  toaster: fix test_build_layerversion test case
  toaster: rewrite test for LayerSource model
  toaster: rewrite LILSUpdateTestCase
  toaster: reformat LayerVersionEquivalenceTestCase
  toaster: reuse common code
  toaster: remove duplicated code
  toaster: simplify testcase code
  toaster: add header to orm/test.py
  toaster: remove ProjectLVSelectionTestCase
  toaster: move code from setup_lv_tests to setUp

 lib/toaster/orm/tests.py | 272 +++++++++++++++++++++++++----------------------
 1 file changed, 143 insertions(+), 129 deletions(-)

-- 
2.1.4


