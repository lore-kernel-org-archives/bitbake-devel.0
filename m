Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id E390873F4A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 11:14:06 +0000 (UTC)
Received: by wgbhc8 with SMTP id hc8so38034678wgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 04:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=bR2FR5824ayEIoaadf42EJmy0nkAG4Ma3zcdC3Rqbmo=;
	b=PrrS1ZEoIeaCWXUMdADOuN/oPkJ4nMCy7395/iaJkOnXJldvTJ7z+HOv5bQxH1TSJN
	Pq7NFLzE6KScGaLFXoVnjRh8diI3s8hakGep0U5RJXfpLhvVoplG1ErpHljrycBPjKVm
	vzx1dDRRWjkI877sh8/iusy8QNNkD4kJwgzdjq9BN+gMFRhqJ/csKZepTpUEgD6QweJO
	gIdE5rZQwEsDiDtCkOlaMNBxzMCVSjpm6nWE7n5BaZTViMF2mX+hHlwCj0TReq5kFyRL
	0VJfCLkffTbqJSM3+aLVKxc37q0wsI8PQZxB6uNl6dCXreVV6R+svKqoH86Nqo/r8LbS
	i09Q==
X-Gm-Message-State: ALoCoQmi8au3UYP7YghpxU7B9GuFxnSBSU3KymA3GwiAc1i+Qjrbi9iJlzl3OTb7LBPFJLceT2Mh
X-Received: by 10.194.192.72 with SMTP id he8mr7168745wjc.11.1431602046175;
	Thu, 14 May 2015 04:14:06 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	jq3sm37635503wjc.22.2015.05.14.04.14.05
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 May 2015 04:14:05 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 76FB5566CEA; Thu, 14 May 2015 11:11:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 May 2015 11:11:41 +0100
Message-Id: <cover.1431598055.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/8] Toaster patchset
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
X-List-Received-Date: Thu, 14 May 2015 11:14:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This toaster patchset allows brings in refactoring of some of the table
pages, removing the "Simple UI", and bringing in the Toaster Test system
under a contrib/ directory.

Updates are made to bring the project in HTML5 compliance.

Can you please pull when possible ?

Cheers,
Alex


The following changes since commit c7263096ba31ba45daeeb9de90c1cb9ebef24a28:

  fetch2: Add BB_ALLOWED_NETWORKS support (2015-05-12 12:17:08 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150514-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150514-submission-bb

Alexandru DAMIAN (3):
  toaster: fix html5 compliance
  toaster/contrib: adding TTS squashed patch
  toastergui: tables updates for HTML5 compliance

Belen Barros Pena (1):
  toastergui: change the import layer action help text

Michael Wood (4):
  toaster: Remove old bldviewer application
  toaster: managedcontextprocessor requires Project imported
  toaster: Add toaster table widget
  toaster: Port All recipes, layers and machines to ToasterTables

 lib/toaster/bldviewer/api.py                       |   44 -
 lib/toaster/bldviewer/static/css/bootstrap.css     | 4797 --------------------
 lib/toaster/bldviewer/static/js/bootstrap.js       | 1982 --------
 lib/toaster/bldviewer/static/js/jquery-2.0.3.js    |    6 -
 lib/toaster/bldviewer/templates/simple_base.html   |   30 -
 .../bldviewer/templates/simple_basebuildpage.html  |   17 -
 .../bldviewer/templates/simple_basetable.html      |   64 -
 lib/toaster/bldviewer/templates/simple_bfile.html  |   24 -
 .../bldviewer/templates/simple_bpackage.html       |   44 -
 lib/toaster/bldviewer/templates/simple_build.html  |   43 -
 .../bldviewer/templates/simple_configuration.html  |   22 -
 lib/toaster/bldviewer/templates/simple_layer.html  |   34 -
 .../bldviewer/templates/simple_package.html        |   36 -
 lib/toaster/bldviewer/templates/simple_recipe.html |   50 -
 lib/toaster/bldviewer/templates/simple_task.html   |   71 -
 lib/toaster/bldviewer/templatetags/__init__.py     |    0
 lib/toaster/bldviewer/tests.py                     |  345 --
 lib/toaster/bldviewer/urls.py                      |   35 -
 lib/toaster/bldviewer/views.py                     |  287 --
 lib/toaster/contrib/README                         |    6 +
 lib/toaster/contrib/tts/README                     |   41 +
 lib/toaster/contrib/tts/TODO                       |    9 +
 lib/toaster/contrib/tts/backlog.txt                |    2 +
 lib/toaster/contrib/tts/config.py                  |   70 +
 lib/toaster/contrib/tts/launcher.py                |  100 +
 .../__init__.py => contrib/tts/log/.create}        |    0
 .../simple_projecttags.py => contrib/tts/recv.py}  |   42 +-
 lib/toaster/contrib/tts/runner.py                  |  200 +
 lib/toaster/contrib/tts/scratchpad.py              |   20 +
 lib/toaster/contrib/tts/settings.json              |    5 +
 lib/toaster/contrib/tts/shellutils.py              |  139 +
 lib/toaster/contrib/tts/tests.py                   |   57 +
 .../contrib/tts/toasteruitest/run_toastertests.py  |   87 +
 .../tts/toasteruitest/toaster_automation_test.py   | 1924 ++++++++
 .../contrib/tts/toasteruitest/toaster_test.cfg     |   21 +
 lib/toaster/contrib/tts/urlcheck.py                |   44 +
 lib/toaster/contrib/tts/urllist.py                 |   53 +
 lib/toaster/orm/models.py                          |   13 +-
 lib/toaster/toastergui/static/css/default.css      |    3 +
 lib/toaster/toastergui/static/js/layerBtn.js       |    5 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |    3 +
 lib/toaster/toastergui/static/js/table.js          |  485 ++
 lib/toaster/toastergui/tables.py                   |  279 ++
 lib/toaster/toastergui/templates/base.html         |    8 +-
 .../toastergui/templates/baseprojectpage.html      |    3 +-
 .../toastergui/templates/builddashboard.html       |    2 +-
 .../toastergui/templates/buildrequestdetails.html  |    2 +-
 .../templates/generic-toastertable-page.html       |   25 +
 lib/toaster/toastergui/templates/importlayer.html  |   18 +-
 lib/toaster/toastergui/templates/layer_btn.html    |    9 +
 lib/toaster/toastergui/templates/layerdetails.html |   50 +-
 lib/toaster/toastergui/templates/layers.html       |  132 -
 lib/toaster/toastergui/templates/machine_btn.html  |    8 +
 lib/toaster/toastergui/templates/machines.html     |   88 -
 lib/toaster/toastergui/templates/newproject.html   |    7 +-
 lib/toaster/toastergui/templates/project.html      |  184 +-
 lib/toaster/toastergui/templates/recipe.html       |    6 +-
 lib/toaster/toastergui/templates/recipe_btn.html   |    8 +
 lib/toaster/toastergui/templates/targets.html      |  142 -
 lib/toaster/toastergui/templates/task.html         |   37 +-
 lib/toaster/toastergui/templates/toastertable.html |  116 +
 lib/toaster/toastergui/urls.py                     |   40 +-
 lib/toaster/toastergui/views.py                    |  285 +-
 lib/toaster/toastergui/widgets.py                  |  316 ++
 lib/toaster/toastermain/urls.py                    |    2 -
 65 files changed, 4272 insertions(+), 8755 deletions(-)
 delete mode 100644 lib/toaster/bldviewer/api.py
 delete mode 100644 lib/toaster/bldviewer/static/css/bootstrap.css
 delete mode 100644 lib/toaster/bldviewer/static/js/bootstrap.js
 delete mode 100644 lib/toaster/bldviewer/static/js/jquery-2.0.3.js
 delete mode 100644 lib/toaster/bldviewer/templates/simple_base.html
 delete mode 100644 lib/toaster/bldviewer/templates/simple_basebuildpage.html
 delete mode 100644 lib/toaster/bldviewer/templates/simple_basetable.html
 delete mode 100644 lib/toaster/bldviewer/templates/simple_bfile.html
 delete mode 100644 lib/toaster/bldviewer/templates/simple_bpackage.html
 delete mode 100644 lib/toaster/bldviewer/templates/simple_build.html
 delete mode 100644 lib/toaster/bldviewer/templates/simple_configuration.html
 delete mode 100644 lib/toaster/bldviewer/templates/simple_layer.html
 delete mode 100644 lib/toaster/bldviewer/templates/simple_package.html
 delete mode 100644 lib/toaster/bldviewer/templates/simple_recipe.html
 delete mode 100644 lib/toaster/bldviewer/templates/simple_task.html
 delete mode 100644 lib/toaster/bldviewer/templatetags/__init__.py
 delete mode 100644 lib/toaster/bldviewer/tests.py
 delete mode 100644 lib/toaster/bldviewer/urls.py
 delete mode 100644 lib/toaster/bldviewer/views.py
 create mode 100644 lib/toaster/contrib/README
 create mode 100644 lib/toaster/contrib/tts/README
 create mode 100644 lib/toaster/contrib/tts/TODO
 create mode 100644 lib/toaster/contrib/tts/backlog.txt
 create mode 100644 lib/toaster/contrib/tts/config.py
 create mode 100755 lib/toaster/contrib/tts/launcher.py
 rename lib/toaster/{bldviewer/__init__.py => contrib/tts/log/.create} (100%)
 rename lib/toaster/{bldviewer/templatetags/simple_projecttags.py => contrib/tts/recv.py} (41%)
 mode change 100644 => 100755
 create mode 100755 lib/toaster/contrib/tts/runner.py
 create mode 100644 lib/toaster/contrib/tts/scratchpad.py
 create mode 100644 lib/toaster/contrib/tts/settings.json
 create mode 100644 lib/toaster/contrib/tts/shellutils.py
 create mode 100644 lib/toaster/contrib/tts/tests.py
 create mode 100755 lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
 create mode 100755 lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
 create mode 100644 lib/toaster/contrib/tts/toasteruitest/toaster_test.cfg
 create mode 100644 lib/toaster/contrib/tts/urlcheck.py
 create mode 100644 lib/toaster/contrib/tts/urllist.py
 create mode 100644 lib/toaster/toastergui/static/js/table.js
 create mode 100644 lib/toaster/toastergui/tables.py
 create mode 100644 lib/toaster/toastergui/templates/generic-toastertable-page.html
 create mode 100644 lib/toaster/toastergui/templates/layer_btn.html
 delete mode 100644 lib/toaster/toastergui/templates/layers.html
 create mode 100644 lib/toaster/toastergui/templates/machine_btn.html
 delete mode 100644 lib/toaster/toastergui/templates/machines.html
 create mode 100644 lib/toaster/toastergui/templates/recipe_btn.html
 delete mode 100644 lib/toaster/toastergui/templates/targets.html
 create mode 100644 lib/toaster/toastergui/templates/toastertable.html
 create mode 100644 lib/toaster/toastergui/widgets.py

-- 
1.9.1


