Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 78C1A761A2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 14:24:29 +0000 (UTC)
Received: by wibud3 with SMTP id ud3so183236663wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 07:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=eFjKNCaC0RmyBFRV83Y1tyQI5PRMMpNr6sd9+K4HLkk=;
	b=gn70S5M2zixz4vwYd9yVDkvn7uYslwe7F36+AzhglnxdnumUieCdX3sdpBKWoxXuL8
	11jxds0TLVyYfWNmE2U47PwoC1rjPIa8PoRNR+vNYQbvpqPor8faaHtOv997ahKg0ZI7
	+buV61McUu7uEDkpVLnaWX07SKZoHJdKX/9c5+/FTp8ZI0cf6mg6zqIHTR7fheSyxkuQ
	CJbFmqYOBVJzE9LhHM0RzhH2v3UTe7yhhFxYrwbdoMYcE9YOxBUKr6B0HrZ0ibcHPPqk
	q+k+6uh9xVXYILSPGT3yrSC7N6zv78WgX0y6Qoo5u80WXQkwEwmTSIgmolY/pyd583rh
	Qecg==
X-Gm-Message-State: ALoCoQnW913231V+pAp95OBeFFdGB6aJTYNJih7kSmoR7W5Pag02eneFRGa7fmPlGcee8sANA86v
X-Received: by 10.180.84.194 with SMTP id b2mr7537363wiz.24.1438093469945;
	Tue, 28 Jul 2015 07:24:29 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	ck18sm27442342wjb.47.2015.07.28.07.24.28
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 Jul 2015 07:24:28 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 8AC9D561BBB; Tue, 28 Jul 2015 15:24:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Jul 2015 15:24:39 +0100
Message-Id: <cover.1438093379.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/6] toaster patchset
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
X-List-Received-Date: Tue, 28 Jul 2015 14:24:32 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>


Hello,

This is a toaster patchset that is fixing several bugs. It has been code-reviewed
and tested by me.

Can you please pull at your own convenience ?

Cheers,
Alex


The following changes since commit 5196bfa9639eed2b1e6452f45775551203f8eeb4:

  bitbake-selftest: Add -v option for verbosity (2015-07-22 23:33:46 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150728_submission_bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150728_submission_bb

Ed Bartosh (5):
  bitbake: toaster: Wait for toaster gui to come
  bitbake: toaster: Fix usage of wrong variables
  bitbake: toaster: get rid of _createdirpath function
  bitbake: toaster: Uncomment logging messages
  bitbake: toaster: Add is_image field to the Recipe model

Michael Wood (1):
  bitbake: toastergui: Toastertables don't replace dash in cache key

 lib/bb/ui/toasterui.py                             |   1 +
 lib/toaster/bldcontrol/localhostbecontroller.py    |  27 +-
 lib/toaster/bldcontrol/models.py                   |   8 +-
 .../0024_auto__add_field_recipe_is_image.py        | 338 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |   3 +
 lib/toaster/toastergui/widgets.py                  |   4 +-
 6 files changed, 359 insertions(+), 22 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0024_auto__add_field_recipe_is_image.py

-- 
1.9.1


