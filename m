Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id D8A0565E0F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 13:51:42 +0000 (UTC)
Received: by mail-wg0-f50.google.com with SMTP id x13so1255702wgg.33
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 06:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=t1lR2/TKsDal3k4inHPE8gszH+2YirzQ/qY01bO6aM0=;
	b=G3tgNHyuS4FlPv3Sk8q2EB4WL8HOROgrK+yviteusQnBs7dU6vyUIijTtAzr0lsv8v
	Rz3Ui2NVpm8vkqm1DCy1c2eg9FGEwWdmo8uDRHrE2BEV6hCo0qcOlrMAtyJxOtrg67WG
	VMPVXxgBfOt8+GDDEGgag/l4t61mVEdqMAGawrA13nYJ1AYJugvm3mOWI5besiuFMvt7
	FGa0V7C0HxqpXmzyltSEHpwOF39wvBmhIHQxwDYCvJqi2FiVjxdkix8yjW9mwomYHlJC
	EaYn8yXcD2YpKTTVKSt13gu5rkG6J25OGf1fZuhwJzUIVOkr43o4rG6w60FsJKKSmuhp
	t3JQ==
X-Gm-Message-State: ALoCoQnx9XRy94zd8M66jw6CHkrvflw9NLQRWoEtZA2P5T+MEsiD++XcFBtvDDUCodfzV3/CjUuR
X-Received: by 10.180.107.97 with SMTP id hb1mr6974924wib.20.1402581102672;
	Thu, 12 Jun 2014 06:51:42 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id i6sm4197896wiy.17.2014.06.12.06.51.41
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Jun 2014 06:51:41 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 986E15606C5; Thu, 12 Jun 2014 14:51:46 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Thu, 12 Jun 2014 14:51:44 +0100
Message-Id: <cover.1402580802.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/6] toaster patchset: localhost build control
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
X-List-Received-Date: Thu, 12 Jun 2014 13:51:49 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This toaster patchset contains the core of the build control functionality
for running on a localhost backend. Variants of this patchset have
been reviewed on the toaster mailing list.

Please merge at your convenience,

Alex

The following changes since commit 2e742c03e8dfdfa67899e7f5d579ed14bd87e139:

  bb/utils: fix contains_any() (2014-06-11 13:18:20 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140612-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140612-submission-bb

Alexandru DAMIAN (6):
  toaster: initial bldcontrol application
  toaster: create models for bldcontrol and enable it
  toaster: add function to get the database url
  xmlrpc: add support for token reusing
  toastergui: fix built ETA calculation
  toaster: build control functionality

 bin/bitbake                                        |   8 +-
 bin/toaster                                        |   9 +-
 lib/bb/server/xmlrpc.py                            |  19 +-
 lib/bb/ui/buildinfohelper.py                       |  10 +
 lib/bb/ui/toasterui.py                             |   3 +
 lib/toaster/bldcontrol/__init__.py                 |   0
 lib/toaster/bldcontrol/bbcontroller.py             | 239 +++++++++++++++++++++
 lib/toaster/bldcontrol/fixtures/initial_data.json  |   1 +
 lib/toaster/bldcontrol/management/__init__.py      |   0
 .../bldcontrol/management/commands/__init__.py     |   0
 .../bldcontrol/management/commands/runbuilds.py    |  85 ++++++++
 lib/toaster/bldcontrol/migrations/0001_initial.py  | 154 +++++++++++++
 lib/toaster/bldcontrol/migrations/__init__.py      |   0
 lib/toaster/bldcontrol/models.py                   |  83 +++++++
 lib/toaster/bldcontrol/tests.py                    |  81 +++++++
 lib/toaster/bldcontrol/views.py                    |   1 +
 lib/toaster/toastergui/views.py                    |   7 +-
 lib/toaster/toastermain/settings.py                |  20 ++
 18 files changed, 704 insertions(+), 16 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/__init__.py
 create mode 100644 lib/toaster/bldcontrol/bbcontroller.py
 create mode 100644 lib/toaster/bldcontrol/fixtures/initial_data.json
 create mode 100644 lib/toaster/bldcontrol/management/__init__.py
 create mode 100644 lib/toaster/bldcontrol/management/commands/__init__.py
 create mode 100644 lib/toaster/bldcontrol/management/commands/runbuilds.py
 create mode 100644 lib/toaster/bldcontrol/migrations/0001_initial.py
 create mode 100644 lib/toaster/bldcontrol/migrations/__init__.py
 create mode 100644 lib/toaster/bldcontrol/models.py
 create mode 100644 lib/toaster/bldcontrol/tests.py
 create mode 100644 lib/toaster/bldcontrol/views.py

-- 
1.9.1


