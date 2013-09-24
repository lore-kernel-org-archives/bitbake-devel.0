Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id DE7876C99C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:47:29 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="408440225"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:47:30 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 699255604B0; Tue, 24 Sep 2013 17:47:33 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:47:25 +0100
Message-Id: <cover.1380040677.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 00/94] Webhob modules DSI and Web
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
X-List-Received-Date: Tue, 24 Sep 2013 16:47:30 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Patches for the DSI and Web modules of Webhob, in the order of development.

DSI is the DataStore Interface, the component that records information
derived from a Bitbake build into the data backend.

Web module consists of the Simple UI interface, and the API interface available
to application for data query.

External components jQuery and Bootstrap are included in the sources,
and respective licenses documented (APACHE-2.0 and MIT).


The following changes since commit 0fc8317c6385eb1ed69ca4522ee6424c456dbb92:

  yocto-bsp: add 3.10/remove 3.8 kernel from templates (2013-09-24 12:01:47 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib webhob-poky/webhob-master-1_5_upstream_2509
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=webhob-poky/webhob-master-1_5_upstream_2509

Alexandru DAMIAN (72):
  webhob: add system start/stop script
  bitbake: webhob: set sane default settings
  bitbake: webhob: adds dsi support for observer mode
  bitbake: dsi: Translate runQueue events into Task data
  bitbake: webhob: disable synchronous sqlite connection
  bitbake: buildinfohelper: clean-up the imports
  bitbake: buildinfohelper: clearing up task order
  bitbake: dsi: saving prebuild task detailed information
  bitbake: dsi: clear up the state on build completion
  bitbake: dsi: event data change
  bitbake: webhob: fix and cleanup start script
  bitbake: dsi: refactor the BuildInfoHelper code
  bitbake: webhob: record dependency info
  bitbake: webhob: use defined constants for models
  bitbake: dsi: fix the reading of task event information
  bitbake: webhob: orm change to remove Target
  bitbake: webhob: clear up ORM relations
  bitbake: dsi: save detailed recipe information
  bitbake: webhob: determine if a build is an image
  bitbake: webhob: clean up URL structure
  bitbake: webhob: add simple pages for Recipes
  bitbake: webhob: enhance Simple browser navigation
  bitbake: webhob: improve startup script
  bitbake: webhob: extend search for multiple terms
  bitbake: webhob: force bitbake server stop
  bitbake: webhob: simple interface dependency list
  bitbake: dsi: add feature to store package information
  bitbake: webhob: add simple viewer for package information
  bitbake: dsi: fix build stats data gathering
  bitbake: dsi: update build object on command end
  bitbake: dsi: fix sstate task information gathering
  bitbake: webhob: clean up starting script
  bitbake: dsi: store log information
  bitbake: webhob: add simple visualisation for build errors
  bitbake: webhob: store logfile and message for Tasks
  bitbake: webhob: display proper information in Simple
  bitbake: dsi: clear up global variables between builds
  bitbake: dsi: small bugfixes in data collection
  bitbake: bldviewer: add jquery and bootstrap frameworks
  bitbake: webhob: add toggle column functionality to build page
  bitbake: webhob: add search functionality to the Simple interface
  bitbake: webhob: refactor column hiding code
  bitbake: webhob: improve search functionality
  bitbake: webhob: refactor Simple web interface
  bitbake: webhob: simple interface CSS
  bitbake: dsi: use get vars command to store configuration
  bitbake: webhob: refactor CSS display in Simple
  bitbake: webhob: add Configuration visualisation in Simple
  bitbake: webhob: add navigation links Simple interface
  bitbake: webhob: startup script fixing
  bitbake: webhob: change database models and related
  bitbake: webhob: navigation in the Simple interface
  bitbake: dsi: save build-time package information
  bitbake: webhob: Simple visualisation for the build-time packages
  bitbake: webhob: store file size information
  bitbake: webhob: simple visualisation for package files
  bitbake: dsi: record recipe dependency
  bitbake: dsi: add exception dumping code
  bitbake: webhob: better help message in startup script
  bitbake: dsi: add build package dependency recording
  bitbake: webhob: clean up Machine table
  bitbake: webhob: update API endpoints
  bitbake: webhob: record task hash information
  bitbake: cooker: add the inherits attribute to the dependency tree
  bitbake: webhob: Clean up links in Simple UI
  bitbake: dsi: read correct recipe description field
  bitbake: cooker: send layer information with dependency tree
  bitbake: webhob: store and display layer priorities
  bitbake: webhob: collect recipe licensing info
  bitbake: webhob: Simple UI interface CSS fix
  bitbake: dsi: fix typos
  bitbake: webhob: do not set timezones

Calin Dragomir (22):
  webhob: create main WEBHOB project
  webhob: create Django models for webhob
  bitbake: create Data Store Interface (DSI) file
  bitbake: webhob: updates to Django models
  bitbake: webhob: make DSI store build information
  bitbake: webhob: make DSI store task information
  bitbake: webhob: view a table with all builds
  bitbake: webhob: view a table with all the tasks of a build
  bitbake: webhob: use buildcompleted event as the end of a build
    operation
  bitbake: webhob: changes to build information table
  bitbake: webhob: gather buildstats for each executed task
  bitbake: webhob: add layer information to the database
  bitbake: webhob: mark private methods inside DSI
  bitbake: webhob: create basic structure for static files
  bitbake: webhob: Setup API for build model
  bitbake: webhob: add ordering capabilities to build api
  bitbake: webhob: validate inputs for build api
  bitbake: webhob: generic view for multiple models
  bitbake: webhob: improve validation code flow
  bitbake: webhob: add more models to webhob API
  bitbake: webhob: add search for build model
  bitbake: webhob: fix ordering issue

 bitbake/bin/webhob                                 |  145 +
 bitbake/lib/bb/cooker.py                           |    2 +
 bitbake/lib/bb/ui/buildinfohelper.py               |  678 ++
 bitbake/lib/bb/ui/dsi.py                           |  569 ++
 bitbake/lib/webhob/__init__.py                     |    0
 bitbake/lib/webhob/bldviewer/__init__.py           |    0
 bitbake/lib/webhob/bldviewer/api.py                |   19 +
 .../lib/webhob/bldviewer/static/css/bootstrap.css  | 4797 +++++++++++
 .../webhob/bldviewer/static/css/bootstrap.min.css  |    9 +
 .../lib/webhob/bldviewer/static/js/bootstrap.js    | 1982 +++++
 .../webhob/bldviewer/static/js/bootstrap.min.js    |    6 +
 .../lib/webhob/bldviewer/static/js/jquery-2.0.3.js | 8829 ++++++++++++++++++++
 bitbake/lib/webhob/bldviewer/templates/base.html   |   30 +
 .../webhob/bldviewer/templates/basebuildpage.html  |   17 +
 .../lib/webhob/bldviewer/templates/basetable.html  |   46 +
 bitbake/lib/webhob/bldviewer/templates/bfile.html  |   24 +
 .../lib/webhob/bldviewer/templates/bpackage.html   |   44 +
 bitbake/lib/webhob/bldviewer/templates/build.html  |   45 +
 .../webhob/bldviewer/templates/configuration.html  |   20 +
 bitbake/lib/webhob/bldviewer/templates/layer.html  |   34 +
 .../lib/webhob/bldviewer/templates/package.html    |   36 +
 bitbake/lib/webhob/bldviewer/templates/recipe.html |   54 +
 bitbake/lib/webhob/bldviewer/templates/task.html   |   63 +
 .../lib/webhob/bldviewer/templatetags/__init__.py  |    0
 .../webhob/bldviewer/templatetags/projecttags.py   |    8 +
 bitbake/lib/webhob/bldviewer/urls.py               |   14 +
 bitbake/lib/webhob/bldviewer/views.py              |  220 +
 bitbake/lib/webhob/manage.py                       |   10 +
 bitbake/lib/webhob/orm/__init__.py                 |    0
 bitbake/lib/webhob/orm/models.py                   |  242 +
 bitbake/lib/webhob/orm/tests.py                    |   16 +
 bitbake/lib/webhob/orm/views.py                    |    1 +
 bitbake/lib/webhob/whbgui/__init__.py              |    0
 bitbake/lib/webhob/whbgui/static/images/yocto.jpg  |  Bin 0 -> 6582 bytes
 bitbake/lib/webhob/whbgui/templates/index.html     |   13 +
 bitbake/lib/webhob/whbgui/tests.py                 |   16 +
 bitbake/lib/webhob/whbgui/urls.py                  |    9 +
 bitbake/lib/webhob/whbgui/views.py                 |    8 +
 bitbake/lib/webhob/whbmain/__init__.py             |    0
 bitbake/lib/webhob/whbmain/settings.py             |  173 +
 bitbake/lib/webhob/whbmain/urls.py                 |   22 +
 bitbake/lib/webhob/whbmain/wsgi.py                 |   32 +
 42 files changed, 18233 insertions(+)
 create mode 100755 bitbake/bin/webhob
 create mode 100644 bitbake/lib/bb/ui/buildinfohelper.py
 create mode 100644 bitbake/lib/bb/ui/dsi.py
 create mode 100644 bitbake/lib/webhob/__init__.py
 create mode 100644 bitbake/lib/webhob/bldviewer/__init__.py
 create mode 100644 bitbake/lib/webhob/bldviewer/api.py
 create mode 100644 bitbake/lib/webhob/bldviewer/static/css/bootstrap.css
 create mode 100644 bitbake/lib/webhob/bldviewer/static/css/bootstrap.min.css
 create mode 100644 bitbake/lib/webhob/bldviewer/static/js/bootstrap.js
 create mode 100644 bitbake/lib/webhob/bldviewer/static/js/bootstrap.min.js
 create mode 100644 bitbake/lib/webhob/bldviewer/static/js/jquery-2.0.3.js
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/base.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/basebuildpage.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/basetable.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/bfile.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/bpackage.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/build.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/configuration.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/layer.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/package.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/recipe.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templates/task.html
 create mode 100644 bitbake/lib/webhob/bldviewer/templatetags/__init__.py
 create mode 100644 bitbake/lib/webhob/bldviewer/templatetags/projecttags.py
 create mode 100644 bitbake/lib/webhob/bldviewer/urls.py
 create mode 100644 bitbake/lib/webhob/bldviewer/views.py
 create mode 100755 bitbake/lib/webhob/manage.py
 create mode 100644 bitbake/lib/webhob/orm/__init__.py
 create mode 100644 bitbake/lib/webhob/orm/models.py
 create mode 100644 bitbake/lib/webhob/orm/tests.py
 create mode 100644 bitbake/lib/webhob/orm/views.py
 create mode 100644 bitbake/lib/webhob/whbgui/__init__.py
 create mode 100644 bitbake/lib/webhob/whbgui/static/images/yocto.jpg
 create mode 100644 bitbake/lib/webhob/whbgui/templates/index.html
 create mode 100644 bitbake/lib/webhob/whbgui/tests.py
 create mode 100644 bitbake/lib/webhob/whbgui/urls.py
 create mode 100644 bitbake/lib/webhob/whbgui/views.py
 create mode 100644 bitbake/lib/webhob/whbmain/__init__.py
 create mode 100644 bitbake/lib/webhob/whbmain/settings.py
 create mode 100644 bitbake/lib/webhob/whbmain/urls.py
 create mode 100644 bitbake/lib/webhob/whbmain/wsgi.py

-- 
1.8.1.2


