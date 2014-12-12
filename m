Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id CE70B724B2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:16 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id l15so2261128wiw.10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=bLEeMG02p7UIUK6sO/wfIeEP9HxIHioLeRtcLawnBr8=;
	b=PhKNKTVwoWmDmDuAXAK0rs0vVprWyXif8RnqnSL3bqiuR8D4arw5v9eFZ4vqEsDyE/
	YZmIAI3rXlKzYP5dYjX+yhh6lJAQM9lZQ25i6Pi0meSPU0gTTpU9l2EJ7m6sPUbhm8q0
	9ie5Jya9qMumqm1sJXfFknHOu+R/Bviu9BZaU1+VhWcLk6P1zs/noVTyqIPZ5Q0R7sNG
	I16BvaRm6tDVYP9xHxbAVVCY+EMCGFkNdempWZE+heohl90MwdqJFCQHuDgsiI1NpNdg
	iXdWbWNNEVbNQJbd5I25xlT+HVCgi44PjQFYoYe7iETaGnQrKLaTiTP9wnhIkSFrBap3
	EyNg==
X-Gm-Message-State: ALoCoQm2wXSFo5l9lOEoYwYHrQ/Ep58+/Ng1oXAIh7ZfxVs/HNDvgkm81aC7VE3Bksm25pMWQZeD
X-Received: by 10.180.82.98 with SMTP id h2mr6947348wiy.7.1418384716395;
	Fri, 12 Dec 2014 03:45:16 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id hz9sm1508726wjb.17.2014.12.12.03.45.14
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:15 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 477315647AA; Fri, 12 Dec 2014 11:45:15 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:13 +0000
Message-Id: <cover.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 00/18 v2] Toaster patchset with new features and bugfixes
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is the v2 patchset with new features and bug fixes. Patches have been individually
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

  git://git.yoctoproject.org/poky-contrib adamian/20141211-submission-1
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141211-submission-1

Alexandru DAMIAN (6):
  add build artifacts table and other improvements
  toasterui: add extra debug and development infos
  add option to write offline event log file
  toastergui: implement UI changes to allow file download
  add POST endpoint for uploading eventlog files
  toasterui: refactor project layer finding logic

Belen Barros Pena (5):
  toaster: base Only show change project icon when > one project
  toaster: Initialise the 'change' icon tooltips
  toaster: tweaking the import layers form
  toaster: Formatting changes to error messages
  toaster: Change the full stop to a colon

Michael Wood (7):
  toaster: libtoaster Add a error handler to GET in makeTypehead
  toaster: libtoaster Add editProject and getLayerDepsForProject
  toaster: Add import layer feature.
  toaster: Importlayer add notify exactly which layers changed
  toaster: importlayer Avoid namespace clash with layer name
  toaster: projectapp Add links to the imported layers notify
  toaster: importlayer Tidy up the page initialisation

 bin/bitbake                                        |  12 +-
 bin/toaster-eventreplay                            | 179 +++++++++++
 lib/bb/cooker.py                                   |  75 ++++-
 lib/bb/cookerdata.py                               |   1 +
 lib/bb/ui/buildinfohelper.py                       |  91 ++++--
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
 lib/toaster/toastergui/static/js/importlayer.js    | 289 +++++++++++++++++
 lib/toaster/toastergui/static/js/libtoaster.js     |  57 ++++
 lib/toaster/toastergui/static/js/projectapp.js     |  40 ++-
 lib/toaster/toastergui/templates/base.html         |  18 +-
 lib/toaster/toastergui/templates/build.html        |  29 +-
 .../toastergui/templates/builddashboard.html       | 131 +++++---
 .../toastergui/templates/configuration.html        |   6 +-
 lib/toaster/toastergui/templates/importlayer.html  | 114 +++++--
 .../toastergui/templates/layers_dep_modal.html     |  90 ++++++
 .../toastergui/templates/package_detail_base.html  |   3 +
 lib/toaster/toastergui/templates/project.html      |   3 +-
 lib/toaster/toastergui/templates/recipe.html       |  11 +-
 lib/toaster/toastergui/templates/recipes.html      |   7 +-
 lib/toaster/toastergui/templates/target.html       |   8 +-
 lib/toaster/toastergui/templates/task.html         |  18 +-
 lib/toaster/toastergui/templates/tasks.html        |  12 +-
 lib/toaster/toastergui/urls.py                     |   2 +
 lib/toaster/toastergui/views.py                    | 325 ++++++++++++++------
 lib/toaster/toastermain/settings.py                |  27 +-
 lib/toaster/toastermain/urls.py                    |  10 +-
 35 files changed, 1853 insertions(+), 265 deletions(-)
 create mode 100755 bin/toaster-eventreplay
 create mode 100644 lib/toaster/orm/migrations/0019_auto__add_buildartifact.py
 create mode 100644 lib/toaster/orm/urls.py
 create mode 100644 lib/toaster/orm/views.py
 create mode 100644 lib/toaster/toastergui/static/js/importlayer.js
 create mode 100644 lib/toaster/toastergui/templates/layers_dep_modal.html

-- 
1.9.1


