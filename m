Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id E638B737F4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:14:15 +0000 (UTC)
Received: by wgbgq6 with SMTP id gq6so37754533wgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ugHDV0bBLL1WUHgq20gUEwU2IGSXcSXpq7GNRfwjdFI=;
	b=FpVchl4Q3qEn53twJFd2VLBeVX2alZOVx3XpobXnhHictCC0IsCHD8Du0mteLnOOlp
	wKbezj4hinGiIoOrio/xvM9mRTRSEkrM9B3Tskqd68rQeYCyH7TlDG3BHLZKmv7V/sRe
	NnPUW62AGXsmyPSzSsGBSCsHdr1eg2qMeQBhPpqyLJYCz9LTMkafKmF5V66QjyqoZUZn
	CwTMXohI2fHYn7zBfbkTGKdzm5RG8Qc45ise6NbJnaye3tK1so6uU0sqYANAWVsXsf4Z
	C10LiJzLeIX9CHne1DAo+6xBqOV9mxVNyzbTDutwb6Is4HG3Vl5jg+nlSXVc4HwoZYQw
	XzPA==
X-Gm-Message-State: ALoCoQkCAMLSCvV0ddNWE5BOnixrZQle3g958Xb6+oGFVbgy8lf181lHf6eq0KgDo+/eSNq4odl8
X-Received: by 10.180.85.42 with SMTP id e10mr60643286wiz.17.1432822456013;
	Thu, 28 May 2015 07:14:16 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id v3sm4208299wix.8.2015.05.28.07.14.14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:14:15 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id A5B7C561175; Thu, 28 May 2015 15:14:14 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:13 +0100
Message-Id: <cover.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 00/22] Toaster patchset
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
X-List-Received-Date: Thu, 28 May 2015 14:14:17 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hi,

This is a Toaster patches with various fixes, especially in the testing area.

Can you please pull ?

Cheers,
Alex

The following changes since commit 702b42a47904f2378dd819e7463b3206883c2651:

  data: Move warning code to the first loop for performance (2015-05-25 09:00:16 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150528-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150528-submission-bb

Alexandru DAMIAN (12):
  toaster: enable server-side sessions for all usages
  toaster logger: refactor recipe and layer file paths
  toaster logger: assign projects to all builds
  toastergui: table header bring back
  toaster: refactor checksettings command
  toasterui: replace cookie-based preferences with session data
  toastergui: tests for the all-projects API point
  toastergui: add tests for xhr_datatypeahead calls
  toaster: enable no browser start
  bitbake/: toaster tts: fix tests
  toaster tests: enable url check test
  toaster: more HTML5 fixes

Ed Bartosh (3):
  toastergui: show relative paths in configvars view
  toaster-gui: Show task name for the builds in /builds
  toastergui: Consider task name when restarting a build in /builds

Michael Wood (7):
  toaster: Fix build button current project race
  toaster: Fix toastertable header
  toaster: Add a simplified ToasterTable template
  toaster: Port layerdetails to ToasterTables
  toaster: Add an invalidate cache method on data update signal
  bldcontrol: Fix all failing unit tests
  orm: Fix all failing unit test

 bin/toaster                                        |  12 +-
 lib/bb/ui/buildinfohelper.py                       |  84 ++-
 lib/toaster/bldcontrol/localhostbecontroller.py    |   2 +-
 .../management/commands/checksettings.py           |  26 +-
 lib/toaster/bldcontrol/models.py                   |   3 +
 lib/toaster/bldcontrol/sshbecontroller.py          |   5 +-
 lib/toaster/bldcontrol/tests.py                    |  84 ++-
 lib/toaster/contrib/tts/backlog.txt                |   2 -
 lib/toaster/contrib/tts/config.py                  |  21 +
 lib/toaster/contrib/tts/launcher.py                |   2 +-
 lib/toaster/contrib/tts/runner.py                  |   4 +-
 lib/toaster/contrib/tts/tests.py                   |  55 +-
 .../tts/toasteruitest/toaster_automation_test.py   |  14 +-
 lib/toaster/contrib/tts/urlcheck.py                |  41 +-
 ...ion_local_path__add_field_recipe_pathflags__.py | 361 +++++++++++++
 ...ect__chg_field_project_bitbake_version__chg_.py | 368 +++++++++++++
 lib/toaster/orm/models.py                          |  58 +-
 lib/toaster/orm/tests.py                           |  32 +-
 lib/toaster/orm/views.py                           |   2 +-
 lib/toaster/toastergui/static/js/base.js           |   5 +-
 lib/toaster/toastergui/static/js/layerdetails.js   |  70 ++-
 lib/toaster/toastergui/static/js/libtoaster.js     |   3 +
 lib/toaster/toastergui/static/js/table.js          |  79 +--
 lib/toaster/toastergui/tables.py                   |  82 ++-
 .../toastergui/templates/basetable_bottom.html     |   4 -
 .../toastergui/templates/basetable_top.html        |   9 +-
 lib/toaster/toastergui/templates/bpackage.html     |   4 +-
 lib/toaster/toastergui/templates/brtargets.html    |  20 +
 .../toastergui/templates/builddashboard.html       |   2 +-
 .../toastergui/templates/configuration.html        |   2 +-
 lib/toaster/toastergui/templates/configvars.html   |  10 +-
 .../templates/detail_pagination_bottom.html        |   5 -
 .../toastergui/templates/detail_sorted_header.html |   2 +-
 lib/toaster/toastergui/templates/layerdetails.html | 594 +++++++--------------
 .../toastergui/templates/managed_mrb_section.html  |  28 +-
 .../toastergui/templates/package_detail_base.html  |   2 +-
 lib/toaster/toastergui/templates/recipe.html       |   6 +-
 lib/toaster/toastergui/templates/recipes.html      |   4 +-
 lib/toaster/toastergui/templates/runagain.html     |   7 +
 lib/toaster/toastergui/templates/target.html       |   2 +-
 .../toastergui/templates/toastertable-filter.html  |  18 +
 .../toastergui/templates/toastertable-simple.html  |  94 ++++
 lib/toaster/toastergui/templates/toastertable.html |  53 +-
 lib/toaster/toastergui/templatetags/projecttags.py |  83 +--
 lib/toaster/toastergui/tests.py                    |  78 +++
 lib/toaster/toastergui/urls.py                     |   6 +-
 lib/toaster/toastergui/views.py                    | 133 ++---
 lib/toaster/toastergui/widgets.py                  |  23 +-
 lib/toaster/toastermain/settings.py                |  17 +-
 49 files changed, 1778 insertions(+), 843 deletions(-)
 delete mode 100644 lib/toaster/contrib/tts/backlog.txt
 create mode 100644 lib/toaster/orm/migrations/0020_auto__add_field_layer_version_local_path__add_field_recipe_pathflags__.py
 create mode 100644 lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py
 create mode 100644 lib/toaster/toastergui/templates/brtargets.html
 create mode 100644 lib/toaster/toastergui/templates/runagain.html
 create mode 100644 lib/toaster/toastergui/templates/toastertable-filter.html
 create mode 100644 lib/toaster/toastergui/templates/toastertable-simple.html
 create mode 100644 lib/toaster/toastergui/tests.py

-- 
1.9.1


