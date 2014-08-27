Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id E54056FE3B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:38 +0000 (UTC)
Received: by mail-wg0-f46.google.com with SMTP id m15so511501wgh.17
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=OwNjP8cEGs9ejTIbZrFyqHUjHjqGtRcYuNd3mtioWRU=;
	b=FKofNoE8DB0yi4ioa9pqzycxI7PXgWltZvkVt7R9l0dPLXlYmpRJtLuSPHX1iZcW9c
	jF1V4rEqZFATY28RzJunhV+Oqu8FWcvQo2dvaYR2Etc7xs70E5unH3oTazxmO1XkbUwS
	YaOqJlRx3XbD0QBwGMbWHdtl030tdEiYx1u56PiOyNnlzNWspAnxNOuhGt+0eI2MJ28z
	Md7izBAGK6fgkr2SzsEVtTTv2loy0jQW5S6/v6Aby9G9Ycq6HoiAXJoEEoEQMkEK6ybL
	PIPN0K1wS3qJf67Sxgu+5ijPcMaGGYQXvkCStEVND1aDyPM5cP6HL30RIFEfJtKyhXmr
	Uzkg==
X-Gm-Message-State: ALoCoQl7XdDFF2+DYMWgWrpgf6VyRGDCW6+Xre7jUTNj0IZwHi0AGTvPjs2dBpeRNfBsYzThYzSQ
X-Received: by 10.180.219.37 with SMTP id pl5mr30528035wic.26.1409160215272;
	Wed, 27 Aug 2014 10:23:35 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	cy9sm25833444wib.18.2014.08.27.10.23.33 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:34 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 4583E560F4F; Wed, 27 Aug 2014 18:23:32 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:30 +0100
Message-Id: <cover.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 00/11] toaster update database models patchset
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:41 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patchset adds changes to the database that allow compatibility with
the layerindex application. The functionality include:

 * update layer information from the layer index application
 * loading poky configuration file
 * updates to UI to allow use of the new data

The information contained in this model suffices for displaying data
in the designed 1.7 version.

Can you please review and pull at your convenience ?

Cheers,
Alex


The following changes since commit 5d858e23de8b15badc3ab7f56ad5160a76a89de1:

  bitbake.conf: Drop unused MKTEMP* variables (2014-08-24 10:09:53 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140827-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140827-submission-bb

Alexandru DAMIAN (11):
  toasterui: refactor log saving and save out-of-build errors
  toaster: fix application discovery in settings.py
  toaster: update orm models for layerindex compatibility
  toaster: enable admin interface on select models
  toaster: create project section navigation structure
  toaster: add all layers page
  toaster: update checksettings command for auto-detection
  toaster: update the bldcontrol to the new orm models
  toatergui:  update pages to match project models
  buildinfohelper: BuildRequest project file update soft linked
  toaster: create Build methods for calculating progress and ETA

 bin/toaster                                        |   9 +-
 lib/bb/ui/buildinfohelper.py                       |  81 ++-
 lib/bb/ui/toasterui.py                             |  10 +-
 lib/toaster/bldcontrol/admin.py                    |   8 +
 lib/toaster/bldcontrol/bbcontroller.py             |  35 +-
 .../management/commands/checksettings.py           | 190 +++++-
 .../bldcontrol/management/commands/runbuilds.py    |   2 +-
 .../migrations/0006_auto__add_brbitbake.py         | 128 ++++
 lib/toaster/bldcontrol/models.py                   |   5 +
 lib/toaster/orm/admin.py                           |  17 +
 lib/toaster/orm/management/__init__.py             |   0
 lib/toaster/orm/management/commands/__init__.py    |   0
 lib/toaster/orm/management/commands/lsupdates.py   |  12 +
 ...erversiondependency__add_unique_layerversion.py | 710 +++++++++++++++++++++
 lib/toaster/orm/models.py                          | 395 ++++++++++--
 lib/toaster/orm/tests.py                           |  33 +
 lib/toaster/toastergui/templates/layers.html       | 173 +++++
 lib/toaster/toastergui/templates/newproject.html   |   5 +-
 lib/toaster/toastergui/templates/project.html      |  51 +-
 lib/toaster/toastergui/urls.py                     |  11 +-
 lib/toaster/toastergui/views.py                    | 138 +++-
 lib/toaster/toastermain/settings.py                |  16 +-
 lib/toaster/toastermain/urls.py                    |  18 +-
 23 files changed, 1891 insertions(+), 156 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/admin.py
 create mode 100644 lib/toaster/bldcontrol/migrations/0006_auto__add_brbitbake.py
 create mode 100644 lib/toaster/orm/admin.py
 create mode 100644 lib/toaster/orm/management/__init__.py
 create mode 100644 lib/toaster/orm/management/commands/__init__.py
 create mode 100644 lib/toaster/orm/management/commands/lsupdates.py
 create mode 100644 lib/toaster/orm/migrations/0013_auto__add_release__add_layerversiondependency__add_unique_layerversion.py
 create mode 100644 lib/toaster/orm/tests.py
 create mode 100755 lib/toaster/toastergui/templates/layers.html

-- 
1.9.1


