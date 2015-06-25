Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 69426605D2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:33:44 +0000 (UTC)
Received: by wicnd19 with SMTP id nd19so13647207wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=7LeehSI9Ps3FwX3zX9BlCrmJss5rYaX3IdnhginaLqo=;
	b=QxfyG4W/HUnhdAKE9HIUDz39jPHx9ZOCSPYOW3KIn6IvXpsK3gC0N8w30hYH4JeCdA
	xWyQrws/MeZW/wjRZVgcP+fKPQV0v/yYDO0buQhKTTHeHaaC5pufLyPWrSKns0xk+DDJ
	unUAGjeBjExVtWIfIMHPtAxuH2AP6pYT7Bx2jo4Sw4M3/gF91lUSwF2vq8oLyFyKb+mX
	zhhEAB8kUllVzbJXZBWD5z5a4kIJKcx4X9plEu5LOBE2BLe86a7PEWqVNiq3A6iqf/+Z
	M6ZwCYnVYi7Mzb/aV5Y0+P6WXU57ApFoKM8/E6va8Wv8DR/pHkMMO+vEapC8gVj1Vnkm
	Z9bw==
X-Gm-Message-State: ALoCoQn88MBac7BrrBSovyCV5BthO0qfbwbr7araGHilKOq6pHirLp3As2ramXHTVzT4eT2SDRK5
X-Received: by 10.194.83.70 with SMTP id o6mr78936287wjy.44.1435228425131;
	Thu, 25 Jun 2015 03:33:45 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id q2sm45022315wjz.15.2015.06.25.03.33.43
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:33:44 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0B34C56172B; Thu, 25 Jun 2015 11:33:50 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:49 +0100
Message-Id: <cover.1435228175.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 00/23] toaster patchset
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
X-List-Received-Date: Thu, 25 Jun 2015 10:33:45 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This toaster patchset brings in filters for new toaster tables, 
removes the differences between managed and analysis modes
in favour of project types, and more minor fixes.

Can you please cherry-pick ?

Thank you,
Alex

The following changes since commit 32166ac3c85ff3c04081580ae76bd63590d6ff3e:

  runqueue: Sanity check BB_NUMBER_THREADS (2015-06-19 22:43:48 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150625-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150625-submission-bb

Alexandru DAMIAN (16):
  toastergui: fix angular error
  toaster: improve the buildenvironment API
  toastergui: enable strict variable checking
  toaster: fixing undefined variables
  toaster: remove MANAGED references
  toaster: remove BuildRequest references
  toaster: refactor the builds pages
  toaster: fill in build data from buildrequest
  toaster: fixes after replacing BuildRequest with Build
  toaster: add django-aggregate-if
  toaster: bring django-aggregate-if into the project
  toaster: refactor build model
  toastergui: select project types
  toaster: delete multiple builds
  toasterui: verify variable before usage
  toasterui: fixes after html5 compliance testing

Michael Wood (7):
  toaster: Enable toastertable cache
  toaster: toastertable Pass up the kwargs for setup_filter
  toaster: table.js fix filter visual indicator and interaction
  toaster: Restore 'in project' filters to main tables
  toaster: bldcontrol Ignore toasterconf files in own directories
  toaster: split orm app into it's own module and app
  toaster: Add url pattern for backward compatibility

 lib/bb/ui/buildinfohelper.py                       |  73 ++-
 lib/bb/ui/toasterui.py                             |  27 +-
 lib/toaster/bldcollector/__init__.py               |   0
 lib/toaster/{orm => bldcollector}/admin.py         |   3 +-
 lib/toaster/{orm => bldcollector}/urls.py          |   3 +-
 lib/toaster/{orm => bldcollector}/views.py         |   0
 lib/toaster/bldcontrol/bbcontroller.py             |   3 +
 lib/toaster/bldcontrol/localhostbecontroller.py    |  24 +-
 .../management/commands/checksettings.py           |   2 +
 .../bldcontrol/management/commands/runbuilds.py    |  69 ++-
 lib/toaster/bldcontrol/models.py                   |   3 +
 lib/toaster/bldcontrol/sshbecontroller.py          |  21 +
 .../contrib/django-aggregate-if-master/.gitignore  |  10 +
 .../contrib/django-aggregate-if-master/.travis.yml |  50 ++
 .../contrib/django-aggregate-if-master/LICENSE     |  21 +
 .../contrib/django-aggregate-if-master/README.rst  | 156 +++++
 .../django-aggregate-if-master/aggregate_if.py     | 164 ++++++
 .../contrib/django-aggregate-if-master/runtests.py |  48 ++
 .../contrib/django-aggregate-if-master/setup.py    |  33 ++
 .../contrib/django-aggregate-if-master/tox.ini     | 198 +++++++
 ...ect__chg_field_project_bitbake_version__chg_.py |   5 +-
 ...k__add_field_layer_version_local_path__del_f.py | 343 +++++++++++
 ...ings_no__del_field_build_errors_no__del_fiel.py | 353 ++++++++++++
 lib/toaster/orm/models.py                          |  67 ++-
 lib/toaster/toastergui/static/js/base.js           |   2 +-
 lib/toaster/toastergui/static/js/projectapp.js     |  20 +-
 lib/toaster/toastergui/static/js/table.js          |  59 +-
 lib/toaster/toastergui/tables.py                   |  75 ++-
 lib/toaster/toastergui/templates/base.html         |  20 +-
 .../toastergui/templates/basebuilddetailpage.html  |   4 +-
 .../toastergui/templates/basebuildpage.html        |   7 +-
 .../toastergui/templates/basetable_top.html        |  11 +-
 .../templates/basetable_top_buildprojects.html     |   2 -
 .../templates/basetable_top_projectbuilds.html     |   2 -
 lib/toaster/toastergui/templates/bpackage.html     |   3 -
 .../toastergui/templates/builddashboard.html       |  39 +-
 .../templates/{build.html => builds.html}          |  35 +-
 .../toastergui/templates/configuration.html        |   6 -
 lib/toaster/toastergui/templates/configvars.html   |   6 +-
 .../toastergui/templates/detail_search_header.html |   2 +-
 .../toastergui/templates/detail_sorted_header.html |   2 +-
 .../toastergui/templates/filtersnippet.html        |   4 +-
 .../templates/generic-toastertable-page.html       |   2 +
 lib/toaster/toastergui/templates/importlayer.html  |  15 +-
 lib/toaster/toastergui/templates/landing.html      |  37 +-
 .../toastergui/templates/managed_builds.html       | 167 ------
 .../toastergui/templates/managed_mrb_section.html  | 193 -------
 lib/toaster/toastergui/templates/mrb_section.html  |  70 ++-
 lib/toaster/toastergui/templates/newproject.html   |  99 ++--
 .../toastergui/templates/package_detail_base.html  |   7 -
 lib/toaster/toastergui/templates/project.html      |  39 +-
 .../toastergui/templates/projectbuilds.html        |  30 +-
 lib/toaster/toastergui/templates/projects.html     |  27 +-
 lib/toaster/toastergui/templates/recipe.html       |   9 +-
 lib/toaster/toastergui/templates/recipes.html      |   7 +-
 lib/toaster/toastergui/templates/runagain.html     |   7 -
 lib/toaster/toastergui/templates/target.html       |   7 +-
 lib/toaster/toastergui/templates/task.html         |  36 +-
 lib/toaster/toastergui/templates/tasks.html        |   7 +-
 .../toastergui/templates/toastertable-simple.html  |   4 +-
 lib/toaster/toastergui/templates/toastertable.html |   4 +-
 lib/toaster/toastergui/urls.py                     |   3 -
 lib/toaster/toastergui/views.py                    | 633 +++++----------------
 lib/toaster/toastergui/widgets.py                  |  19 +-
 .../toastermain/management/commands/builddelete.py |  56 +-
 lib/toaster/toastermain/settings.py                |  18 +-
 lib/toaster/toastermain/urls.py                    |   4 +
 67 files changed, 2191 insertions(+), 1284 deletions(-)
 create mode 100644 lib/toaster/bldcollector/__init__.py
 rename lib/toaster/{orm => bldcollector}/admin.py (92%)
 rename lib/toaster/{orm => bldcollector}/urls.py (95%)
 rename lib/toaster/{orm => bldcollector}/views.py (100%)
 create mode 100644 lib/toaster/contrib/django-aggregate-if-master/.gitignore
 create mode 100644 lib/toaster/contrib/django-aggregate-if-master/.travis.yml
 create mode 100644 lib/toaster/contrib/django-aggregate-if-master/LICENSE
 create mode 100644 lib/toaster/contrib/django-aggregate-if-master/README.rst
 create mode 100644 lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py
 create mode 100755 lib/toaster/contrib/django-aggregate-if-master/runtests.py
 create mode 100644 lib/toaster/contrib/django-aggregate-if-master/setup.py
 create mode 100644 lib/toaster/contrib/django-aggregate-if-master/tox.ini
 create mode 100644 lib/toaster/orm/migrations/0022_auto__add_field_target_task__add_field_layer_version_local_path__del_f.py
 create mode 100644 lib/toaster/orm/migrations/0023_auto__del_field_build_warnings_no__del_field_build_errors_no__del_fiel.py
 rename lib/toaster/toastergui/templates/{build.html => builds.html} (75%)
 delete mode 100644 lib/toaster/toastergui/templates/managed_builds.html
 delete mode 100644 lib/toaster/toastergui/templates/managed_mrb_section.html
 delete mode 100644 lib/toaster/toastergui/templates/runagain.html

-- 
1.9.1


