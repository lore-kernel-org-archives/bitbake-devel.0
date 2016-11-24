Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 280F16011A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:19 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id f82so57223760wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=n5g9aRorr4dHkAU/AUO35TdXj49d9qz0b5ECou8dgzw=;
	b=e5t8sxtWiB8Ch7QLq6Qnbqe+gIDyNsYwx4e8JfftZLBrKRPR//t4XkZ9tpP7KBymZg
	rZmug5CanKhDCumL6fg+dENTAcFpkC5G0h5KGrePrTvnKyY91fw5atYno5IvJFZA7eMw
	Br2Ie4IxRIRWKESIZN2m/VLSYOMMTxNT+9EzF4dH1NdPSK2zWuN1VtAJf7hiwtRTNj1K
	Dpxe/ZUaoRDTLhCBe9teGt4g4xpXg7kY0EialAyvGenmrOoCmwjUMGsp2aOBt/OXgU2z
	HLVPY1iSGe+GZA36LRBSqHGNV7OSTAu6XwO5wLhXHIgZZUcWHh3rHJhKTTZfLOxiSWly
	qgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=n5g9aRorr4dHkAU/AUO35TdXj49d9qz0b5ECou8dgzw=;
	b=Q8xCO3KndP5RBo7i9ENjzRRaG4PpdmmkuPdswVpcamxQwSFK+A2HbCoJBgh5LclHKk
	mflyVBxUb2bzfU8YiTQhqewxZmx/74o+5WbUsKwIciWMzoz3aTolPJJK24ec0mbYeMq1
	NQrEqTV9lmDhCeooFytDSk6AtS4z+orYsAaKxdpYiNrCHf5iZcykTf0VlmkOXDcIje7N
	8/bcFP0pBh2Crw+AprJvNXD44I7foh6b28XJPezpFwRlSeNawAfZ31qzAu1ncA6sk9Lo
	A7E8Vd4e9UcY4L1cP9dvHlzfg2R6zis6WNsiVUaGG8eh7c0S8KTul37I7wDWyqjOwWcP
	eqAg==
X-Gm-Message-State: AKaTC03sKlBFl2xrxNY2hQJON71rIVCp+d2F1vvtl9a2GOhE/uoBZh5xLOIYOL/NwWW68TK8
X-Received: by 10.28.91.143 with SMTP id p137mr1969123wmb.51.1479986420616;
	Thu, 24 Nov 2016 03:20:20 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:20 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:19:51 +0000
Message-Id: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 00/15] Patches for Toaster 22.11.16
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:22 -0000

This is the latest patchset for submission upstream from Toaster.

Branch available at poky-contrib michaelw/toaster/patch_queue_22_11_16
http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=michaelw/toaster/patch_queue_22_11_16

*Note* there are new files added in this patchset 

Thanks

Michael Wood (11):
  toaster: runbuilds Write the pidfile in python rather than shell
    script
  toaster: tests Add management command tests
  toaster: Add an example production settings file
  toaster: customrecipejs Consume click event on 'a' link if disabled
  toaster: buildinfohelper toaster-custom-images layer
  toaster: orm models Project class Fix pyflake errors
  toaster: orm models Handle CustomImageRecipe BRLayer here
  toaster: bldcontrol Move CustomImageRecipe file creation into own
    function
  toaster: buildinfohelper Simplify layer event to toaster layer
    function
  toaster: buildinfohelper fix _get_layer_version_for_dependency
  toaster: buildinfohelper Clarify log message for build history

Reyna, David (2):
  toaster: orm gen_layerdeps Protect against circular Layer dependencies
  toaster: tablejs Fix missing close square bracket

Sujith H (2):
  toaster: localhostbecontroller accept custom init script for build
  toaster: localhostbecontroller write toaster layers for project to
    toaster-bblayers.conf

 bin/toaster                                        |   2 +-
 lib/bb/ui/buildinfohelper.py                       | 112 +++++++--------
 lib/toaster/bldcontrol/localhostbecontroller.py    | 160 +++++++++++----------
 .../bldcontrol/management/commands/runbuilds.py    |  21 ++-
 lib/toaster/orm/management/commands/lsupdates.py   |   1 -
 lib/toaster/orm/models.py                          |  94 +++++++-----
 lib/toaster/tests/commands/__init__.py             |   0
 lib/toaster/tests/commands/test_loaddata.py        |  61 ++++++++
 lib/toaster/tests/commands/test_lsupdates.py       |  45 ++++++
 lib/toaster/tests/commands/test_runbuilds.py       |  88 ++++++++++++
 lib/toaster/toastergui/api.py                      |  16 ++-
 lib/toaster/toastergui/static/js/customrecipe.js   |   6 +
 lib/toaster/toastergui/static/js/table.js          |   2 +-
 .../toastermain/settings_production_example.py     |  58 ++++++++
 14 files changed, 481 insertions(+), 185 deletions(-)
 create mode 100644 lib/toaster/tests/commands/__init__.py
 create mode 100644 lib/toaster/tests/commands/test_loaddata.py
 create mode 100644 lib/toaster/tests/commands/test_lsupdates.py
 create mode 100644 lib/toaster/tests/commands/test_runbuilds.py
 create mode 100644 lib/toaster/toastermain/settings_production_example.py

-- 
2.7.4


