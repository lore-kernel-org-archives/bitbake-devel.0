Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 1F26260809
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 15:12:13 +0000 (UTC)
Received: by mail-wg0-f48.google.com with SMTP id y19so3878214wgg.35
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 07:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=FdNug2vo8qkfP/CmSKR+3iqljhUreuyOPNTRhvG4VYE=;
	b=fE879NjtlRrHCJIZeV0HIVwWO0kXj8sIaQBoHFx/CjxsdgsoRjtUCtvfyDCMeAkw0D
	reWHrKPFkUBxJbuH/nGDyi/S23kYw+ODSBLyGYFnoPKtTNuSJIaYi3VFUvJBCkJTKWV7
	0SYlu0sLeFeKVC1dWO5d5E61kKaXz9ydMVsGv21kLMzuo94EXVPYaIZfXno3YfXGTjh4
	FAHglbL8pi9n1wD+BBccgXTb+NvDBnyNUy2db9IDZaOm1Al7/SIfip8K3WUhiXX3Xw6N
	EOmFG3QQbNFj7Lqk2PAQM2GONMv3EgZgVvx5UfclcLEdFgXmDdnVT6i7joDd0SKpGgBe
	OhZQ==
X-Gm-Message-State: ALoCoQnLC0dX6y+BBExxYuUuaM82Ngzt4r4/UyNwqTN1fXY+0wO90O+lEGSRl0C8jyz8CZK9tPcA
X-Received: by 10.180.93.37 with SMTP id cr5mr14237119wib.76.1418224333697;
	Wed, 10 Dec 2014 07:12:13 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id j1sm6213026wjw.25.2014.12.10.07.12.12
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Dec 2014 07:12:12 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 2539D561166; Wed, 10 Dec 2014 15:12:12 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Dec 2014 15:12:10 +0000
Message-Id: <cover.1418224064.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 00/11] Toaster patchset with new features and bugfixes
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
X-List-Received-Date: Wed, 10 Dec 2014 15:12:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a patchset with new features and bug fixes. Patches have been individually
reviewed on the toaster mailing list.

Among the features submitted, we have the import layers pages, the download artifacts
patchset, a new command line option for bitbake to write event log files, and corresponding
command to import log files into toaster, as well as new debug options.

We also have fixes around the layout and refactoring to make code cleaner.

Can you please pull at your convenience ?

Thanks,
Alex

The following changes since commit 9e27bb2869e8ec6781d2f68d0585ebbf9ca6f3d8:

  bitbake-user-manual-metadata.xml: Updated do_package_write example (2014-12-09 22:25:11 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20141210-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141210-submission

Alexandru DAMIAN (6):
  add build artifacts table and other improvements
  toastergui: implement UI changes to allow file download
  add option to write offline event log file
  add POST endpoint for uploading eventlog files
  toasterui: add extra debug and development infos
  toasterui: refactor project layer finding logic

Belen Barros Pena (2):
  toaster: base Only show change project icon when > one project
  toaster: Initialise the 'change' icon tooltips

Michael Wood (3):
  toaster: libtoaster Add a error handler to GET in makeTypehead
  toaster: libtoaster Add editProject and getLayerDepsForProject
  toaster: Add import layer feature.

 bin/bitbake                                        |   7 +-
 bin/toaster-eventreplay                            | 179 +++++++++++
 lib/bb/cooker.py                                   |  75 ++++-
 lib/bb/cookerdata.py                               |   1 +
 lib/bb/ui/buildinfohelper.py                       |  83 +++--
 lib/bb/ui/toasterui.py                             |  25 +-
 lib/toaster/bldcontrol/localhostbecontroller.py    |  27 +-
 .../management/commands/checksettings.py           |   2 +-
 .../bldcontrol/management/commands/runbuilds.py    |  13 +-
 lib/toaster/bldcontrol/models.py                   |  10 +-
 .../orm/migrations/0019_auto__add_buildartifact.py | 342 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  50 ++-
 lib/toaster/orm/urls.py                            |  27 ++
 lib/toaster/orm/views.py                           |  60 ++++
 lib/toaster/toastergui/static/js/base.js           |   4 +
 lib/toaster/toastergui/static/js/importlayer.js    | 190 ++++++++++++
 lib/toaster/toastergui/static/js/libtoaster.js     |  57 ++++
 lib/toaster/toastergui/static/js/projectapp.js     |   6 +
 lib/toaster/toastergui/templates/base.html         |  18 +-
 lib/toaster/toastergui/templates/build.html        |  29 +-
 .../toastergui/templates/builddashboard.html       | 131 +++++---
 .../toastergui/templates/configuration.html        |   6 +-
 lib/toaster/toastergui/templates/importlayer.html  |  80 +++--
 .../toastergui/templates/layers_dep_modal.html     |  68 ++++
 .../toastergui/templates/package_detail_base.html  |   3 +
 lib/toaster/toastergui/templates/recipe.html       |  11 +-
 lib/toaster/toastergui/templates/recipes.html      |   7 +-
 lib/toaster/toastergui/templates/target.html       |   8 +-
 lib/toaster/toastergui/templates/task.html         |  18 +-
 lib/toaster/toastergui/templates/tasks.html        |  12 +-
 lib/toaster/toastergui/urls.py                     |   2 +
 lib/toaster/toastergui/views.py                    | 293 ++++++++++++------
 lib/toaster/toastermain/settings.py                |  27 +-
 lib/toaster/toastermain/urls.py                    |  10 +-
 34 files changed, 1630 insertions(+), 251 deletions(-)
 create mode 100755 bin/toaster-eventreplay
 create mode 100644 lib/toaster/orm/migrations/0019_auto__add_buildartifact.py
 create mode 100644 lib/toaster/orm/urls.py
 create mode 100644 lib/toaster/orm/views.py
 create mode 100644 lib/toaster/toastergui/static/js/importlayer.js
 create mode 100644 lib/toaster/toastergui/templates/layers_dep_modal.html

-- 
1.9.1


