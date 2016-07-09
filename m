Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id 38ECA607A4
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Jul 2016 00:52:45 +0000 (UTC)
Received: by mail-pa0-f68.google.com with SMTP id ts6so9075902pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jul 2016 17:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=I4C0z3V/WiqkOr+61BT13u0sCPqot7PSSBe9yfEw0gk=;
	b=jSDJ0KjW4F5O/s8rB2tF5+NIV+jYLuNvFTLW+HKZ7BuoGZaEIfJMqAuV5rAb4YWPSC
	7vda2H+vKB1AgMYLz1FcDHJR6yQssY2hnwO96KHFDp2FaHLEFthQIIMKm8gSPxn9SSxq
	Nwpw6MNPhqCQv6u8gqCPx6Cso2Lrech9F3gzKoaqN1NIsnOl3o1TJEbt4CZNb5BF68EM
	kqBeWSMFflPWmNUqBSGLKXO8TYx+CvViocDRiN1ndJm8MaWdzE7nyJ6lxOuyYlP/OMBv
	sa4/HXDv8x6GRKoCERO2MI9V9tNIGzx0X8Q38MIkCO0rL6Mhv9Cj+c0zfBbXB6K0PLUI
	3DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=I4C0z3V/WiqkOr+61BT13u0sCPqot7PSSBe9yfEw0gk=;
	b=T2zxRvqW1C+2YqIfmb+szsFm2yXDYXgso1WMai2hz1WOB7NYSneKGSQWvDBCo2usTM
	r3POyoPoGodFmrXu89e5Y7daK3VhPG3MKnP8KPYf4QFljI1tNOvgNpxEU3Xb1AfC1lbx
	Qrl4xfovtj9t0AvaiLrT2N2OCNQlk6OYzGgtILr2EmGnJKiCqdqjgis+WK8BH+7upeLo
	IA0KLDm+UMjqeocntU4fp3OZ0oIZAiwOQUOUr5Dup7j98ZwMv0uxWe9G27fG0kMPm3fQ
	6zr40B7f91OHQenlvu/SXWBfK55Lu8aXFohhN4o3KCdZy8vbfGCE8S2Haqfz5yM7bzf/
	fYaQ==
X-Gm-Message-State: ALyK8tL0Bm1ZLzNHliIf8UeFbaHA1Un6DK5hel7qxLEsW6XNo5Ang2F4CSyFAOMhzVIJ5g==
X-Received: by 10.66.134.20 with SMTP id pg20mr14340168pab.98.1468025566649;
	Fri, 08 Jul 2016 17:52:46 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id 6sm966pfx.68.2016.07.08.17.52.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 08 Jul 2016 17:52:46 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jul 2016 17:52:41 -0700
Message-Id: <cover.1468024992.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 0/7] toaster: Artifact Selection Improvement
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
X-List-Received-Date: Sat, 09 Jul 2016 00:52:46 -0000

This is part of a patch set that is split over the openembedded-core and
bitbake-devel mailing lists.

This patch removes complexity from toaster.bbclass in order to move those
functions to bitbake/lib/toaster.

The intent of this set is to improve Toaster's ability to locate artifacts such as
kernel images, rootfs, and sdk tar files.

-Brian Avery
an Intel employee

The following changes since commit 308d0a8f1d06b22a9be8e5d55194544a2ee764ef:

  toaster: fix typo in arguments for libtoaster.js function (2016-07-08 16:25:39 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib poky-contrib/bavery/submit/elliot/toaster/8556-image_fstypes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/elliot/toaster/8556-image_fstypes

Ed Bartosh (1):
  runqueue: improve exception logging

Elliot Smith (6):
  toaster: display Target targets in build dashboard
  toaster: do image and artifact scan on BuildCompleted
  toaster: improve image file suffix retrieval
  toaster: attach kernel artifacts to targets
  buildinfohelper: fix retrieval of targets
  toaster: improve scan for SDK artifacts

 lib/bb/runqueue.py                                 |   6 +-
 lib/bb/ui/buildinfohelper.py                       | 370 ++++++++++++++++++---
 lib/bb/ui/toasterui.py                             |  11 +-
 .../migrations/0008_refactor_artifact_models.py    |  39 +++
 lib/toaster/orm/models.py                          | 243 ++++++++++----
 .../toastergui/templates/builddashboard.html       |  84 +++--
 .../toastergui/templatetags/field_values_filter.py |  18 +
 lib/toaster/toastergui/views.py                    |  18 +-
 8 files changed, 645 insertions(+), 144 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0008_refactor_artifact_models.py
 create mode 100644 bitbake/lib/toaster/toastergui/templatetags/field_values_filter.py

--
1.9.1

