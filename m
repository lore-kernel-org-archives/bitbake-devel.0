Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 697A160C03
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jan 2014 14:13:35 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 10 Jan 2014 06:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,638,1384329600"; d="scan'208";a="464702539"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.146])
	by orsmga002.jf.intel.com with ESMTP; 10 Jan 2014 06:13:10 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jan 2014 14:13:04 +0000
Message-Id: <cover.1389362796.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 0/5] Toaster web UI implementation (cover letter only)
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
X-List-Received-Date: Fri, 10 Jan 2014 14:13:35 -0000

These patches start to build the Toaster web UI for build analysis as
specified in the design. Only a couple of pages are complete, but it
provides a basis for other developers to get started on the rest of
the interface (refer to the Yocto Project bugzilla / the toaster mailing
list for details).

I hadn't planned upon doing so, but unfortunately due to the extremely
long line length in some of the minified js/css files git-send-email
refused to deal with the patches themselves so I'm sending this as a
cover letter only.


The following changes since commit e13acb4113ce75226664c3006a9776cc885e860d:

  fetch2/gitannex: Fix function arguments to match bitbake master (2014-01-08 15:26:34 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/toaster-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/toaster-bb

Alexandru DAMIAN (5):
  bitbake: toaster: clone Simple UI as base for Toaster GUI
  bitbake: toaster: update static media for Toaster GUI
  bitbake: toaster: Create the base page navigation structure
  bitbake: toaster: Build dashboard implementation
  bitbake: toaster: Toaster GUI, generic search, filter and order

 .../templates/{base.html => simple_base.html}      |     0
 ...asebuildpage.html => simple_basebuildpage.html} |     2 +-
 .../{basetable.html => simple_basetable.html}      |     2 +-
 lib/toaster/bldviewer/templates/simple_bfile.html  |    24 +
 .../{bpackage.html => simple_bpackage.html}        |     2 +-
 .../templates/{build.html => simple_build.html}    |     2 +-
 ...onfiguration.html => simple_configuration.html} |     2 +-
 lib/toaster/bldviewer/templates/simple_layer.html  |    34 +
 .../bldviewer/templates/simple_package.html        |    36 +
 .../templates/{recipe.html => simple_recipe.html}  |     2 +-
 .../templates/{task.html => simple_task.html}      |     2 +-
 lib/toaster/bldviewer/views.py                     |    16 +-
 lib/toaster/orm/models.py                          |    10 +-
 .../static/css/bootstrap-responsive.min.css        |     9 +
 .../toastergui/static/css/bootstrap.min.css        |     9 +
 lib/toaster/toastergui/static/css/default.css      |   177 +
 .../toastergui/static/css/font-awesome.min.css     |    33 +
 lib/toaster/toastergui/static/css/prettify.css     |     1 +
 .../toastergui/static/fonts/FontAwesome.otf        |   Bin 0 -> 48748 bytes
 .../static/fonts/fontawesome-webfont.eot           |   Bin 0 -> 25395 bytes
 .../static/fonts/fontawesome-webfont.svg           |   284 +
 .../static/fonts/fontawesome-webfont.ttf           |   Bin 0 -> 55096 bytes
 .../static/fonts/fontawesome-webfont.woff          |   Bin 0 -> 29380 bytes
 .../static/fonts/glyphicons-halflings-regular.eot  |   Bin 0 -> 20290 bytes
 .../static/fonts/glyphicons-halflings-regular.svg  |   229 +
 .../static/fonts/glyphicons-halflings-regular.ttf  |   Bin 0 -> 41236 bytes
 .../static/fonts/glyphicons-halflings-regular.woff |   Bin 0 -> 23292 bytes
 lib/toaster/toastergui/static/images/yocto.jpg     |   Bin 6582 -> 0 bytes
 lib/toaster/toastergui/static/img/logo.png         |   Bin 0 -> 3020 bytes
 lib/toaster/toastergui/static/js/bootstrap.min.js  |     7 +
 .../toastergui/static/js/jquery-2.0.3.min.js       |     6 +
 .../toastergui/static/js/jquery-2.0.3.min.map      |     1 +
 lib/toaster/toastergui/static/js/jquery-ui.js      | 15003 +++++++++++++++++++
 lib/toaster/toastergui/static/js/main.js           |   497 +
 lib/toaster/toastergui/static/js/prettify.js       |    28 +
 lib/toaster/toastergui/templates/base.html         |    64 +
 .../toastergui/templates/basebuildpage.html        |    55 +
 .../toastergui/templates/basetable_bottom.html     |    67 +
 .../toastergui/templates/basetable_top.html        |    73 +
 .../{bldviewer => toastergui}/templates/bfile.html |     0
 lib/toaster/toastergui/templates/bpackage.html     |    50 +
 lib/toaster/toastergui/templates/build.html        |   104 +
 .../toastergui/templates/builddashboard.html       |    74 +
 lib/toaster/toastergui/templates/buildtime.html    |     4 +
 .../toastergui/templates/configuration.html        |    57 +
 lib/toaster/toastergui/templates/configvars.html   |    40 +
 lib/toaster/toastergui/templates/cpuusage.html     |     4 +
 lib/toaster/toastergui/templates/diskio.html       |     4 +
 .../toastergui/templates/filtersnippet.html        |    19 +
 lib/toaster/toastergui/templates/index.html        |    13 -
 .../{bldviewer => toastergui}/templates/layer.html |     0
 .../templates/package.html                         |     0
 lib/toaster/toastergui/templates/recipe.html       |    51 +
 lib/toaster/toastergui/templates/target.html       |     8 +
 lib/toaster/toastergui/templates/task.html         |    74 +
 lib/toaster/toastergui/templatetags/__init__.py    |     0
 lib/toaster/toastergui/templatetags/projecttags.py |    56 +
 lib/toaster/toastergui/urls.py                     |    36 +-
 lib/toaster/toastergui/views.py                    |   519 +-
 lib/toaster/toastermain/settings.py                |    11 +
 lib/toaster/toastermain/urls.py                    |     2 +-
 61 files changed, 17761 insertions(+), 42 deletions(-)
 rename lib/toaster/bldviewer/templates/{base.html => simple_base.html} (100%)
 rename lib/toaster/bldviewer/templates/{basebuildpage.html => simple_basebuildpage.html} (94%)
 rename lib/toaster/bldviewer/templates/{basetable.html => simple_basetable.html} (98%)
 create mode 100644 lib/toaster/bldviewer/templates/simple_bfile.html
 rename lib/toaster/bldviewer/templates/{bpackage.html => simple_bpackage.html} (97%)
 rename lib/toaster/bldviewer/templates/{build.html => simple_build.html} (98%)
 rename lib/toaster/bldviewer/templates/{configuration.html => simple_configuration.html} (94%)
 create mode 100644 lib/toaster/bldviewer/templates/simple_layer.html
 create mode 100644 lib/toaster/bldviewer/templates/simple_package.html
 rename lib/toaster/bldviewer/templates/{recipe.html => simple_recipe.html} (97%)
 rename lib/toaster/bldviewer/templates/{task.html => simple_task.html} (98%)
 create mode 100755 lib/toaster/toastergui/static/css/bootstrap-responsive.min.css
 create mode 100755 lib/toaster/toastergui/static/css/bootstrap.min.css
 create mode 100644 lib/toaster/toastergui/static/css/default.css
 create mode 100755 lib/toaster/toastergui/static/css/font-awesome.min.css
 create mode 100755 lib/toaster/toastergui/static/css/prettify.css
 create mode 100644 lib/toaster/toastergui/static/fonts/FontAwesome.otf
 create mode 100644 lib/toaster/toastergui/static/fonts/fontawesome-webfont.eot
 create mode 100644 lib/toaster/toastergui/static/fonts/fontawesome-webfont.svg
 create mode 100644 lib/toaster/toastergui/static/fonts/fontawesome-webfont.ttf
 create mode 100644 lib/toaster/toastergui/static/fonts/fontawesome-webfont.woff
 create mode 100644 lib/toaster/toastergui/static/fonts/glyphicons-halflings-regular.eot
 create mode 100644 lib/toaster/toastergui/static/fonts/glyphicons-halflings-regular.svg
 create mode 100644 lib/toaster/toastergui/static/fonts/glyphicons-halflings-regular.ttf
 create mode 100644 lib/toaster/toastergui/static/fonts/glyphicons-halflings-regular.woff
 delete mode 100644 lib/toaster/toastergui/static/images/yocto.jpg
 create mode 100644 lib/toaster/toastergui/static/img/logo.png
 create mode 100644 lib/toaster/toastergui/static/js/bootstrap.min.js
 create mode 100644 lib/toaster/toastergui/static/js/jquery-2.0.3.min.js
 create mode 100644 lib/toaster/toastergui/static/js/jquery-2.0.3.min.map
 create mode 100644 lib/toaster/toastergui/static/js/jquery-ui.js
 create mode 100755 lib/toaster/toastergui/static/js/main.js
 create mode 100755 lib/toaster/toastergui/static/js/prettify.js
 create mode 100644 lib/toaster/toastergui/templates/base.html
 create mode 100644 lib/toaster/toastergui/templates/basebuildpage.html
 create mode 100644 lib/toaster/toastergui/templates/basetable_bottom.html
 create mode 100644 lib/toaster/toastergui/templates/basetable_top.html
 rename lib/toaster/{bldviewer => toastergui}/templates/bfile.html (100%)
 create mode 100644 lib/toaster/toastergui/templates/bpackage.html
 create mode 100644 lib/toaster/toastergui/templates/build.html
 create mode 100644 lib/toaster/toastergui/templates/builddashboard.html
 create mode 100644 lib/toaster/toastergui/templates/buildtime.html
 create mode 100644 lib/toaster/toastergui/templates/configuration.html
 create mode 100644 lib/toaster/toastergui/templates/configvars.html
 create mode 100644 lib/toaster/toastergui/templates/cpuusage.html
 create mode 100644 lib/toaster/toastergui/templates/diskio.html
 create mode 100644 lib/toaster/toastergui/templates/filtersnippet.html
 delete mode 100644 lib/toaster/toastergui/templates/index.html
 rename lib/toaster/{bldviewer => toastergui}/templates/layer.html (100%)
 rename lib/toaster/{bldviewer => toastergui}/templates/package.html (100%)
 create mode 100644 lib/toaster/toastergui/templates/recipe.html
 create mode 100644 lib/toaster/toastergui/templates/target.html
 create mode 100644 lib/toaster/toastergui/templates/task.html
 create mode 100644 lib/toaster/toastergui/templatetags/__init__.py
 create mode 100644 lib/toaster/toastergui/templatetags/projecttags.py

-- 
1.8.1.2


