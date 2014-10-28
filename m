Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id E3C0D601F6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Oct 2014 14:02:28 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id k14so932617wgh.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Oct 2014 07:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=yokcnQV3potJEzZ3m6pG1sUuewxLbVBDUY5Kau6sz4I=;
	b=JokXgTsGL6HFzEoCjvpkdhrEDW9rjFhzh+H5eilc717mL2DVtgCD/1eOMT1IQo5n8i
	TRbsNPKPi8Cr2WJ8wwnvczGq3gupr1Cy+uq1W1ZFnvBroeQddjyhdtwZD1vgfM/xeLRg
	DGoWXiKi4jUZBiaFx8Z3NVlfw5aODXgQE0oM+KSXpGo8ozKQI5LbfnpCqQgcS0gDg00B
	sRZMwmiDajZNqESciJ64xermKeW/9VIQiZlgS3dJOrDaZUhFT702L1RMPoDOPizzgIbW
	JjWHpOxVJJfmlnocWBSYeNcHQfGh7nDZOS/GxdYmTg8trZRxPWD27d2IALVN9BKFdEj6
	9I6w==
X-Gm-Message-State: ALoCoQnjIbU79NqYKnuDrEaCsVwc25tTykgKNTwNmpisVs05t9V0hmAIap8lMIo9Vqd8Ecb69elY
X-Received: by 10.180.212.78 with SMTP id ni14mr5008321wic.2.1414504948394;
	Tue, 28 Oct 2014 07:02:28 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id h8sm1933607wjs.43.2014.10.28.07.02.26
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 Oct 2014 07:02:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 2E980561BD7; Tue, 28 Oct 2014 14:02:27 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Oct 2014 14:02:24 +0000
Message-Id: <cover.1414504737.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 00/25] Toaster build functionality patchset
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
X-List-Received-Date: Tue, 28 Oct 2014 14:02:36 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patchset brings in the toaster build function updates, 
with backend features and new frontend pages.

Can you please pull at your convenience ?

Cheers,
Alex


The following changes since commit afa2431c21b8271b05dc4cca4265f98d9f338007:

  toastergui fix size rendering in dirinfo page (2014-09-29 14:11:20 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20141028-bb-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141028-bb-submission

Alexandru DAMIAN (16):
  toasterbld: update checksettings command
  toasterui: save build id in build request on first chance
  toastergui: update breadcrumb in analysis pages
  toaster: we add static copies of AngularJS and related libraries
  toaster: fix layer source update code
  toaster: fix Project page in order to trigger builds
  toastergui: project edit capabilities in all layers page
  toastergui: refactor objects get in views.py
  toastergui: protect variable value reads
  toaster: changes to the landing page
  toaster: use modified validators for git url fields
  toaster: improvements for admin pages
  toaster: change startup parameter passing to avoid race
  toastergui: provide download file capability
  toaster: update web vcs fields for layers
  bitbake: clarify startup message

Belen Barros (1):
  toastergui: Amend show rows options

Belen Barros Pena (8):
  toastergui: Fix help text in packages 'Reverse runtime dependencies'
    tab
  toastergui: Add missing task descriptions
  toastergui: Fix reverse dependencies tab for packages included
  toastergui: Fix blue highlight for failed tasks
  toastergui: Remove sorting from "Size over total" column
  toastergui: Remove extra <div> from build dashboard
  toastergui: Tiny change to help text
  toastergui: Show failed tasks in the build dashboard

 bin/bitbake                                        |   2 +-
 bin/toaster                                        |  15 +-
 lib/bb/ui/buildinfohelper.py                       |  16 +-
 lib/bb/ui/toasterui.py                             |   5 +-
 lib/toaster/bldcontrol/bbcontroller.py             |   6 +-
 lib/toaster/bldcontrol/localhostbecontroller.py    |  39 +-
 .../management/commands/checksettings.py           |  47 +-
 .../bldcontrol/management/commands/runbuilds.py    |  19 +-
 ...st_environment__chg_field_buildrequest_build.py | 145 +++++
 lib/toaster/bldcontrol/models.py                   |  16 +-
 lib/toaster/bldcontrol/sshbecontroller.py          |   4 +-
 lib/toaster/bldcontrol/tests.py                    |  10 +-
 lib/toaster/orm/admin.py                           |  23 +-
 ...mmary__chg_field_layer_summary__chg_field_re.py | 336 +++++++++++
 ...web_url__add_field_layer_vcs_web_tree_base_u.py | 336 +++++++++++
 lib/toaster/orm/models.py                          | 180 ++++--
 lib/toaster/toastergui/static/css/default.css      |  65 +-
 .../toastergui/static/js/angular-cookies.min.js    |   8 +
 lib/toaster/toastergui/static/js/angular.min.js    | 215 +++++++
 .../toastergui/static/js/angular.min.js.map        |   8 +
 lib/toaster/toastergui/static/js/projectapp.js     | 531 +++++++++++++++++
 .../static/js/ui-bootstrap-tpls-0.11.0.js          |  10 +
 .../static/js/ui-bootstrap-tpls-0.11.0.min.js      |  10 +
 lib/toaster/toastergui/templates/base.html         |  12 -
 .../toastergui/templates/basebuilddetailpage.html  |   5 +-
 .../toastergui/templates/basebuildpage.html        |   7 +-
 .../toastergui/templates/baseprojectpage.html      |   8 +-
 .../toastergui/templates/basetable_bottom.html     |   2 +-
 .../toastergui/templates/basetable_top.html        |   3 +-
 .../templates/basetable_top_buildprojects.html     |  16 +
 .../toastergui/templates/basetable_top_layers.html |   5 +
 .../templates/basetable_top_projectbuilds.html     |  16 +
 lib/toaster/toastergui/templates/build.html        |  85 +--
 .../toastergui/templates/builddashboard.html       |  27 +-
 lib/toaster/toastergui/templates/landing.html      |  66 +++
 lib/toaster/toastergui/templates/layers.html       | 290 +++++----
 lib/toaster/toastergui/templates/mrb_section.html  | 102 ++++
 lib/toaster/toastergui/templates/newproject.html   |   7 -
 .../package_included_reverse_dependencies.html     |   4 +-
 lib/toaster/toastergui/templates/project.html      | 652 ++++++++++-----------
 lib/toaster/toastergui/templates/projects.html     |  36 ++
 lib/toaster/toastergui/templates/task.html         |   9 +-
 lib/toaster/toastergui/templatetags/projecttags.py |  11 +
 lib/toaster/toastergui/urls.py                     |  12 +-
 lib/toaster/toastergui/views.py                    | 516 +++++++++++++---
 45 files changed, 3198 insertions(+), 739 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/migrations/0007_auto__add_field_buildrequest_environment__chg_field_buildrequest_build.py
 create mode 100644 lib/toaster/orm/migrations/0014_auto__chg_field_package_summary__chg_field_layer_summary__chg_field_re.py
 create mode 100644 lib/toaster/orm/migrations/0015_auto__add_field_layer_vcs_web_url__add_field_layer_vcs_web_tree_base_u.py
 create mode 100644 lib/toaster/toastergui/static/js/angular-cookies.min.js
 create mode 100644 lib/toaster/toastergui/static/js/angular.min.js
 create mode 100644 lib/toaster/toastergui/static/js/angular.min.js.map
 create mode 100644 lib/toaster/toastergui/static/js/projectapp.js
 create mode 100644 lib/toaster/toastergui/static/js/ui-bootstrap-tpls-0.11.0.js
 create mode 100644 lib/toaster/toastergui/static/js/ui-bootstrap-tpls-0.11.0.min.js
 create mode 100644 lib/toaster/toastergui/templates/basetable_top_buildprojects.html
 create mode 100644 lib/toaster/toastergui/templates/basetable_top_layers.html
 create mode 100644 lib/toaster/toastergui/templates/basetable_top_projectbuilds.html
 create mode 100644 lib/toaster/toastergui/templates/landing.html
 create mode 100644 lib/toaster/toastergui/templates/mrb_section.html
 create mode 100644 lib/toaster/toastergui/templates/projects.html

-- 
1.9.1


