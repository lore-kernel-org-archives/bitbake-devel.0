Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 7CE766F7B2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 15:49:48 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id n12so10397804wgh.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 08:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=/gppmCNfW/k+gb9CxJPAdovnRGG+NSMxQAFPQ/bJGA8=;
	b=JymhGaWngKNJKRMavKjBozSU4nMZRJBwURn/8qx2qaH2/tUtXMsfH8Va1DHcst0jzz
	5lFKxfVuKZiTTs3tTNNRtz/UibwUngXxo2XZgZZQTi9HwcegZvBTSrIV0CLnisPsQd4/
	gLSwW8zGIaL6F2ju/8vseF4qhrqmmK4KNMabLhK1jqqrACWxvc7JIJU8yVPDzYip//K+
	4A2iFT98BWpCKv7sChRd8mvoy7l9c7kc9AdvO2xK6pxfD8R/kuIJOr9LiSrB+VtX1L24
	uMxzruL14QCHWlTdKtfbk5UPgVWgVhClTKGnGT4x69UEJXiBmLYvBb+aSINdeMU+wcQw
	1OCw==
X-Gm-Message-State: ALoCoQl8oro76/RsKKFhF8yS98i8ED6Aa8B6fgvADnWiQaBajPu0MDdzquGDoROamExvLITlqd22
X-Received: by 10.194.243.68 with SMTP id ww4mr2329102wjc.58.1394552988989;
	Tue, 11 Mar 2014 08:49:48 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id g5sm62431404wjs.8.2014.03.11.08.49.47
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 11 Mar 2014 08:49:48 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id A7D525605BD; Tue, 11 Mar 2014 15:49:48 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Mar 2014 15:49:47 +0000
Message-Id: <cover.1394552757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/8] Bugfixes for Toaster
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
X-List-Received-Date: Tue, 11 Mar 2014 15:49:49 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a set of bugfixes for Toaster.

Patches were reviewed on the toaster@yoctoproject.org mailing list.

Can you please pull them into bitbake master ?

Thank you,
Alex

The following changes since commit 76029d08ad56a0a264ff9738a0336971a455b7f5:

  runqueue: Use SIGCHLD instead of polling waitpid (2014-03-09 18:58:49 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/submission-11032014
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/submission-11032014

Alexandru DAMIAN (4):
  toaster: update database schema
  toaster: write files-in-image to the database
  toaster: add commands to list and delete builds
  toaster: erase checks for stop command

Belen Barros Pena (1):
  toaster: Fix help text for task details outcome

David Reyna (3):
  toaster: add empty outcome support to task page
  toaster: add 'bblayers.conf' files to local config filter
  toaster: fix 'show all' labels for tasks and variables

 bin/toaster                                        |  17 +-
 lib/bb/ui/buildinfohelper.py                       | 115 +++++++++-
 ...ge_size__add_field_target_license_manifest_p.py | 235 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  32 +--
 .../toastergui/templates/basetable_top.html        |   2 +-
 lib/toaster/toastergui/templates/task.html         |   6 +-
 lib/toaster/toastergui/views.py                    |   6 +-
 lib/toaster/toastermain/management/__init__.py     |   0
 .../toastermain/management/commands/__init__.py    |   0
 .../toastermain/management/commands/builddelete.py |  33 +++
 .../toastermain/management/commands/buildslist.py  |  13 ++
 11 files changed, 423 insertions(+), 36 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0006_auto__add_field_target_image_size__add_field_target_license_manifest_p.py
 create mode 100644 lib/toaster/toastermain/management/__init__.py
 create mode 100644 lib/toaster/toastermain/management/commands/__init__.py
 create mode 100644 lib/toaster/toastermain/management/commands/builddelete.py
 create mode 100644 lib/toaster/toastermain/management/commands/buildslist.py

-- 
1.8.3.2


