Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 81180615A9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Oct 2013 16:35:47 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 16 Oct 2013 09:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,508,1378882800"; d="scan'208";a="375628219"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.8])
	by azsmga001.ch.intel.com with ESMTP; 16 Oct 2013 09:35:28 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 16 Oct 2013 17:35:20 +0100
Message-Id: <cover.1381940678.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 0/3] Add initial version of Toaster web UI
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
X-List-Received-Date: Wed, 16 Oct 2013 16:35:47 -0000

This adds the initial implementation of Toaster, a web frontend for
BitBake (formerly known as Web Hob).

Note: 2/3 is omitted because it contains files with lines longer than
998 characters that git send-email chokes on. You can still see it
in the branch using the web link below.


The following changes (against poky, but apply cleanly to bitbake master
with -p2) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/toaster
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/toaster

Alexandru DAMIAN (3):
  toaster: add toaster code to bitbake
  toaster: adding frameworks for the Simple UI
  toaster: add Toaster UI interface

 bitbake/LICENSE                                    |   10 +
 bitbake/bin/toaster                                |  145 +
 bitbake/lib/bb/ui/buildinfohelper.py               |  719 +++
 bitbake/lib/bb/ui/toasterui.py                     |  273 ++
 bitbake/lib/toaster/__init__.py                    |    0
 bitbake/lib/toaster/bldviewer/__init__.py          |    0
 bitbake/lib/toaster/bldviewer/api.py               |   37 +
 .../lib/toaster/bldviewer/static/css/bootstrap.css | 4797 ++++++++++++++++++++
 .../lib/toaster/bldviewer/static/js/bootstrap.js   | 1982 ++++++++
 .../toaster/bldviewer/static/js/jquery-2.0.3.js    |    6 +
 bitbake/lib/toaster/bldviewer/templates/base.html  |   30 +
 .../toaster/bldviewer/templates/basebuildpage.html |   17 +
 .../lib/toaster/bldviewer/templates/basetable.html |   46 +
 bitbake/lib/toaster/bldviewer/templates/bfile.html |   24 +
 .../lib/toaster/bldviewer/templates/bpackage.html  |   44 +
 bitbake/lib/toaster/bldviewer/templates/build.html |   43 +
 .../toaster/bldviewer/templates/configuration.html |   20 +
 bitbake/lib/toaster/bldviewer/templates/layer.html |   34 +
 .../lib/toaster/bldviewer/templates/package.html   |   36 +
 .../lib/toaster/bldviewer/templates/recipe.html    |   54 +
 bitbake/lib/toaster/bldviewer/templates/task.html  |   63 +
 .../lib/toaster/bldviewer/templatetags/__init__.py |    0
 .../toaster/bldviewer/templatetags/projecttags.py  |   26 +
 bitbake/lib/toaster/bldviewer/urls.py              |   32 +
 bitbake/lib/toaster/bldviewer/views.py             |  260 ++
 bitbake/lib/toaster/manage.py                      |   10 +
 bitbake/lib/toaster/orm/__init__.py                |    0
 bitbake/lib/toaster/orm/models.py                  |  258 ++
 bitbake/lib/toaster/toastergui/__init__.py         |    0
 .../lib/toaster/toastergui/static/images/yocto.jpg |  Bin 0 -> 6582 bytes
 .../lib/toaster/toastergui/templates/index.html    |   13 +
 bitbake/lib/toaster/toastergui/urls.py             |   27 +
 bitbake/lib/toaster/toastergui/views.py            |   26 +
 bitbake/lib/toaster/toastermain/__init__.py        |    0
 bitbake/lib/toaster/toastermain/settings.py        |  190 +
 bitbake/lib/toaster/toastermain/urls.py            |   41 +
 bitbake/lib/toaster/toastermain/wsgi.py            |   32 +
 37 files changed, 9295 insertions(+)
 create mode 100644 bitbake/LICENSE
 create mode 100755 bitbake/bin/toaster
 create mode 100644 bitbake/lib/bb/ui/buildinfohelper.py
 create mode 100644 bitbake/lib/bb/ui/toasterui.py
 create mode 100644 bitbake/lib/toaster/__init__.py
 create mode 100644 bitbake/lib/toaster/bldviewer/__init__.py
 create mode 100644 bitbake/lib/toaster/bldviewer/api.py
 create mode 100644 bitbake/lib/toaster/bldviewer/static/css/bootstrap.css
 create mode 100644 bitbake/lib/toaster/bldviewer/static/js/bootstrap.js
 create mode 100644 bitbake/lib/toaster/bldviewer/static/js/jquery-2.0.3.js
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/base.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/basebuildpage.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/basetable.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/bfile.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/bpackage.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/build.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/configuration.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/layer.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/package.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/recipe.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templates/task.html
 create mode 100644 bitbake/lib/toaster/bldviewer/templatetags/__init__.py
 create mode 100644 bitbake/lib/toaster/bldviewer/templatetags/projecttags.py
 create mode 100644 bitbake/lib/toaster/bldviewer/urls.py
 create mode 100644 bitbake/lib/toaster/bldviewer/views.py
 create mode 100755 bitbake/lib/toaster/manage.py
 create mode 100644 bitbake/lib/toaster/orm/__init__.py
 create mode 100644 bitbake/lib/toaster/orm/models.py
 create mode 100644 bitbake/lib/toaster/toastergui/__init__.py
 create mode 100644 bitbake/lib/toaster/toastergui/static/images/yocto.jpg
 create mode 100644 bitbake/lib/toaster/toastergui/templates/index.html
 create mode 100644 bitbake/lib/toaster/toastergui/urls.py
 create mode 100644 bitbake/lib/toaster/toastergui/views.py
 create mode 100644 bitbake/lib/toaster/toastermain/__init__.py
 create mode 100644 bitbake/lib/toaster/toastermain/settings.py
 create mode 100644 bitbake/lib/toaster/toastermain/urls.py
 create mode 100644 bitbake/lib/toaster/toastermain/wsgi.py

-- 
1.8.1.2


