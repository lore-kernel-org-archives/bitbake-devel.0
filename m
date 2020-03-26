Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 by mx.groups.io with SMTP id smtpd.web10.30867.1585196611419507530
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2020 21:23:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.146.13, mailfrom: david.reyna@windriver.com)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 02Q4NTjP009261
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2020 21:23:30 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.209.92) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 25 Mar 2020 21:23:12 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/1] toaster:django_2_2_13207
Date: Wed, 25 Mar 2020 21:24:22 -0700
Message-ID: <cover.1585196549.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.209.92]
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Toaster: Patch to move from deprecated Django-1.x to Django-2.2
 * The primary changes are API updated limited to:
   1) Move to "django.urls"
   2) Explicit "on_delete=models.CASCADE", even in migration files
   3) Move from "MIDDLEWARE_CLASSES" to "MIDDLEWARE"
   4) And other minor API paperwork
 * This patch set has been extensively tested at Wind River.

The following changes since commit 1bf1e1539fb72f0bc594b4b2367482dd13c8c633:

  linux-yocto/5.4: configuration tweaks (2020-03-25 10:02:50 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/toaster/django_2_2_13207
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/toaster/django_2_2_13207

David Reyna (1):
  toaster: migrate to Django-2.2

 lib/toaster/bldcollector/views.py                  |   2 +-
 lib/toaster/bldcontrol/migrations/0001_initial.py  |  18 ++--
 lib/toaster/bldcontrol/models.py                   |  18 ++--
 lib/toaster/orm/migrations/0001_initial.py         | 100 ++++++++++-----------
 .../orm/migrations/0002_customimagerecipe.py       |   6 +-
 .../orm/migrations/0003_customimagepackage.py      |   2 +-
 lib/toaster/orm/migrations/0004_provides.py        |   4 +-
 .../migrations/0008_refactor_artifact_models.py    |   4 +-
 .../0012_use_release_instead_of_up_branch.py       |   2 +-
 lib/toaster/orm/migrations/0017_distro_clone.py    |   2 +-
 lib/toaster/orm/migrations/0019_django_2_2.py      |  23 +++++
 lib/toaster/orm/models.py                          |  98 ++++++++++----------
 lib/toaster/tests/browser/test_all_builds_page.py  |   2 +-
 .../tests/browser/test_all_projects_page.py        |   2 +-
 .../tests/browser/test_builddashboard_page.py      |   2 +-
 .../browser/test_builddashboard_page_artifacts.py  |   2 +-
 .../browser/test_builddashboard_page_recipes.py    |   2 +-
 .../browser/test_builddashboard_page_tasks.py      |   2 +-
 lib/toaster/tests/browser/test_js_unit_tests.py    |   2 +-
 lib/toaster/tests/browser/test_landing_page.py     |   2 +-
 .../tests/browser/test_layerdetails_page.py        |   2 +-
 .../browser/test_most_recent_builds_states.py      |   2 +-
 .../tests/browser/test_new_custom_image_page.py    |   2 +-
 lib/toaster/tests/browser/test_new_project_page.py |   2 +-
 .../tests/browser/test_project_builds_page.py      |   2 +-
 .../tests/browser/test_project_config_page.py      |   5 +-
 lib/toaster/tests/browser/test_project_page.py     |   2 +-
 lib/toaster/tests/browser/test_sample.py           |   2 +-
 lib/toaster/tests/browser/test_task_page.py        |   2 +-
 lib/toaster/tests/browser/test_toastertable_ui.py  |   2 +-
 lib/toaster/tests/views/test_views.py              |   2 +-
 lib/toaster/toastergui/api.py                      |   2 +-
 .../toastergui/templatetags/project_url_tag.py     |   2 +-
 lib/toaster/toastergui/templatetags/projecttags.py |   4 +-
 lib/toaster/toastergui/typeaheads.py               |   2 +-
 lib/toaster/toastergui/views.py                    |  16 ++--
 lib/toaster/toastergui/widgets.py                  |   2 +-
 .../toastermain/management/commands/buildimport.py |   2 +-
 lib/toaster/toastermain/settings.py                |  17 ++--
 lib/toaster/toastermain/urls.py                    |   4 +-
 40 files changed, 197 insertions(+), 174 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0019_django_2_2.py

-- 
1.9.1

