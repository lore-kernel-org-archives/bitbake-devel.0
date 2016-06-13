Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f178.google.com (mail-pf0-f178.google.com
	[209.85.192.178])
	by mail.openembedded.org (Postfix) with ESMTP id 725076014F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 14:08:58 +0000 (UTC)
Received: by mail-pf0-f178.google.com with SMTP id c2so46686025pfa.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=to:from:subject:message-id:date:user-agent:mime-version
	:content-transfer-encoding;
	bh=DzkxBWOfbXt6A+OQmvIWc/b9EqhuB1ubzWiMKMfzDVs=;
	b=D0DsHanLQvC/ZMAsDSHqUKsjXB5arOi4Tm5o9Xof8+ZzTZD5bs23YNTd1kAQrM/b5E
	s5T6wr/xXDOhBYPfUPguV3CgjSzmHWniXU2PYBQiBINr1mQctgeGL8g0Bt7dR553WwYl
	Ttnk5NulhFanQehxL90fEy3RR34UuSRcxvkpIqKcndn6DNQpSSV1fL0EOq0Il/6B+xup
	j5IeVZRi/65tSWmsZm12DWC5Y3HJGIpqw3KTLgrJXi5QtzNMXeipROEdSNwOqWKU3z4m
	nB9nkXbHZ9BtWWo0pLPT1KPzdCB3S6r611nF463/lBD7UAuiw5heVZZs71N158MxhfD4
	EjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:to:from:subject:message-id:date:user-agent
	:mime-version:content-transfer-encoding;
	bh=DzkxBWOfbXt6A+OQmvIWc/b9EqhuB1ubzWiMKMfzDVs=;
	b=CPH2dVP2grZZ1sJEvijQUQBmOUyTKmCWREy+ZPR6qzEKiAKPS0t43q82UWWeIstbOs
	+cUq27pBivLdwpi38JqoDWknz0Hq7Qlw0FCcryFDqfxoWr5eWxcAkkAqS/07ddB451V/
	1ll0CTIIetX50GlF0gPK6vIvsO+YlRGTaf0xOyBCDNO86S2rTAGkOhiAWaECOA3xGCuR
	OmfEXnm/3N7tWGATNN7ZqdbRUizFH9sR220n24AY+mDXg0DDqJXJj9pvv3we2elPYlVY
	6L2IDMoGnixAiKEtltUrGRxlqSG+hey9N1GBfnBUmcYMVZ/Fo5G8KP4jit/LoD/VLjgq
	hgdw==
X-Gm-Message-State: ALyK8tLyl+i+cPQ73N+3/+iH6zbu8dr5+OBpkptrnBr/XNTqNBHKzKzFzT1nqbfq+DWh/ZRj
X-Received: by 10.98.48.198 with SMTP id w189mr18836762pfw.125.1465826938504; 
	Mon, 13 Jun 2016 07:08:58 -0700 (PDT)
Received: from [192.168.0.78]
	(host109-150-165-138.range109-150.btcentralplus.com.
	[109.150.165.138]) by smtp.googlemail.com with ESMTPSA id
	y63sm11689642pfb.13.2016.06.13.07.08.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 13 Jun 2016 07:08:57 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org
From: Michael Wood <michael.g.wood@intel.com>
Message-ID: <575EBE76.8060601@intel.com>
Date: Mon, 13 Jun 2016 15:08:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
Subject: [pull-request] michaelw/toaster/sync-toaster-next
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
X-List-Received-Date: Mon, 13 Jun 2016 14:09:03 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


Pull request for syncing up toaster-next with bitbake master. Bitbake 
based branch is located on poky-contrib michaelw/toaster/sync-toaster-next.

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=michaelw/toaster/sync-toaster-next

This is the work to:
  - Fix a number of regressions caused by switch to python 3
  - Port Toaster to use Bootstrap 3
  - Fix a number of regressions in the tests caused by switch to Bootstrap 3
  - Add a new typeahead library after Bootstrap deprecated theirs
  - Add event handling to capture failed build targets


Belen Barros Pena (8):
   toaster: tweaks to recipe file downloads
   toaster: Migrate project configuration from bootstrap 2 to bootstrap 3
   toaster: toaster tables Enable complex empty states
   toaster: buildtables Remove links from non name fields
   toaster: port all build analysis pages to bootstrap 3
   toaster: build data Fix left navigation
   toaster: BuiltPackagesTable format empty state in packages table
   toaster: BuildTasksTable filters remove outcome NA option

Ed Bartosh (7):
   toaster: replace viewkeys() -> keys()
   toaster: fix migrations
   toaster: decode response content
   toaster: fix incorrect file mode
   toaster: fix test_toaster_tables
   toaster: changed python version in shebang
   toaster: fix wrong usage of print_exc and format_exc

Elliot Smith (9):
   toaster: migrate typeahead library
   toaster: work-around our lack of a synchronous fetch for typeaheads
   toaster-tests: maximize browser window when running UI tests
   cooker: add BuildInit event
   toasterui: use BuildInit to capture builds with bad targets
   toaster: fix typo which prevents filters from working
   toaster: fix broken reference to urllib
   toaster-tests: fix tests for latest Selenium version
   toaster: open image files in binary mode when sending in response

Michael Wood (18):
   toaster: testsjs Add call back to append elements on completion of
     tests
   toaster: tests Add a BuildTest helper class
   toaster: ToasterTable widget add an 'a' to Name in Exception class
   toaster: port table for Built packages to ToasterTable
   toaster: port Built recipes table to toastertables
   toaster: port Task tables to ToasterTables widget
   toaster: port Installed packages table to ToasterTable
   toaster: table.js Add the ability to highlight a particular row
   toaster: tests Add new build tables to tests
   toaster: widgets ToasterTable Catch template rendering exceptions
   toaster: Rework displaying package dependencies across Toaster
   toaster: bin Use python 3 for our django modules check
   toaster: toastergui tests Use new BeautifulSoup syntax
   toaster: js tests Twitter typeahead library object is now ttTypeahead
   toaster: selenium tests Update unique custom image string and fix
     import
   toaster: selenium tests Fix all_projects page and sample tests
   toaster: tests Rename test settings to python compliant name and fix
     import
   toaster: tests browser Fix selenium tests after bootstrap3 breakage

  LICENSE                                            |    5 +-
  bin/toaster                                        |    2 +-
  lib/bb/cooker.py                                   |    6 +
  lib/bb/event.py                                    |    6 +-
  lib/bb/ui/buildinfohelper.py                       |   19 +-
  lib/bb/ui/toasterui.py                             |   19 +-
  .../management/commands/checksettings.py           |    2 +-
  .../bldcontrol/management/commands/runbuilds.py    |    4 +-
  .../migrations/0004_auto_20160523_1446.py          |   34 +
  lib/toaster/contrib/tts/runner.py                  |    4 +-
  lib/toaster/manage.py                              |    2 +-
  .../orm/migrations/0007_auto_20160523_1446.py      |   89 +
  lib/toaster/orm/models.py                          |   63 +-
  lib/toaster/tests/browser/README                   |    7 +-
  lib/toaster/tests/browser/selenium_helpers.py      |    1 +
  lib/toaster/tests/browser/test_all_builds_page.py  |   15 +-
  .../tests/browser/test_all_projects_page.py        |   13 +-
  .../tests/browser/test_builddashboard_page.py      |   33 +-
  lib/toaster/tests/browser/test_js_unit_tests.py    |    8 +-
  .../tests/browser/test_new_custom_image_page.py    |    3 +-
  .../tests/browser/test_project_config_page.py      |    5 +-
  lib/toaster/tests/browser/test_sample.py           |    2 +-
  lib/toaster/tests/builds/README                    |    4 +-
  lib/toaster/toastergui/buildtables.py              |  568 ++
  .../fixtures/toastergui-unittest-data.xml          |   91 +-
  lib/toaster/toastergui/static/css/bootstrap.css    | 6760 
++++++++++++++++++++
  .../toastergui/static/css/bootstrap.css.map        |    1 +
  .../toastergui/static/css/bootstrap.min.css        |   13 +-
  .../toastergui/static/css/bootstrap.min.css.map    |    1 +
  .../static/css/bootstrap3-transition.css           |  238 +
  lib/toaster/toastergui/static/css/default.css      |  585 +-
  .../static/fonts/glyphicons-halflings-regular.eot  |  Bin 20290 -> 
20127 bytes
  .../static/fonts/glyphicons-halflings-regular.svg  |  487 +-
  .../static/fonts/glyphicons-halflings-regular.ttf  |  Bin 41236 -> 
45404 bytes
  .../static/fonts/glyphicons-halflings-regular.woff |  Bin 23292 -> 
23424 bytes
  .../fonts/glyphicons-halflings-regular.woff2       |  Bin 0 -> 18028 bytes
  .../toastergui/static/html/layer_deps_modal.html   |   38 +-
  .../static/img/glyphicons-halflings-white.png      |  Bin 8777 -> 0 bytes
  .../toastergui/static/img/glyphicons-halflings.png |  Bin 12799 -> 0 bytes
  lib/toaster/toastergui/static/js/bootstrap.js      | 2363 +++++++
  lib/toaster/toastergui/static/js/bootstrap.min.js  |   11 +-
  lib/toaster/toastergui/static/js/customrecipe.js   |    4 +-
  lib/toaster/toastergui/static/js/importlayer.js    |   11 +-
  lib/toaster/toastergui/static/js/layerDepsModal.js |    4 +-
  lib/toaster/toastergui/static/js/layerdetails.js   |   67 +-
  lib/toaster/toastergui/static/js/libtoaster.js     |  146 +-
  .../toastergui/static/js/newcustomimage_modal.js   |   76 +-
  lib/toaster/toastergui/static/js/projectpage.js    |    8 +-
  lib/toaster/toastergui/static/js/table.js          |   92 +-
  lib/toaster/toastergui/static/js/tests/test.js     |    9 +-
  .../toastergui/static/js/typeahead.jquery.js       | 1551 +++++
  lib/toaster/toastergui/tables.py                   |  201 +-
  lib/toaster/toastergui/templates/base.html         |   90 +-
  .../toastergui/templates/basebuilddetailpage.html  |   47 +-
  .../toastergui/templates/basebuildpage.html        |  118 +-
  .../toastergui/templates/baseprojectpage.html      |   38 +-
  .../toastergui/templates/basetable_bottom.html     |   26 +-
  .../toastergui/templates/basetable_top.html        |  121 +-
  lib/toaster/toastergui/templates/bpackage.html     |  108 -
  .../toastergui/templates/builddashboard.html       |  194 +-
  .../templates/buildinfo-toastertable.html          |   25 +
  .../toastergui/templates/buildrequestdetails.html  |    8 +-
  .../toastergui/templates/builds-toastertable.html  |    8 +-
  lib/toaster/toastergui/templates/buildtime.html    |    4 -
  .../toastergui/templates/configuration.html        |   57 +-
  lib/toaster/toastergui/templates/configvars.html   |  150 +-
  .../toastergui/templates/customise_btn.html        |    6 +-
  lib/toaster/toastergui/templates/customrecipe.html |  205 +-
  .../templates/detail_pagination_bottom.html        |   22 +-
  .../toastergui/templates/detail_search_header.html |   78 +-
  .../toastergui/templates/detail_sorted_header.html |    8 +-
  lib/toaster/toastergui/templates/dirinfo.html      |   38 +-
  .../templates/editcustomimage_modal.html           |   67 +-
  .../toastergui/templates/filtersnippet.html        |   93 +-
  .../templates/generic-toastertable-page.html       |    2 +-
  lib/toaster/toastergui/templates/importlayer.html  |  260 +-
  lib/toaster/toastergui/templates/landing.html      |   23 +-
  .../toastergui/templates/landing_not_managed.html  |    4 +-
  lib/toaster/toastergui/templates/layer_btn.html    |   12 +-
  lib/toaster/toastergui/templates/layerdetails.html |  457 +-
  lib/toaster/toastergui/templates/machine_btn.html  |   10 +-
  lib/toaster/toastergui/templates/mrb_section.html  |  121 +-
  .../toastergui/templates/newcustomimage.html       |   15 +-
  .../toastergui/templates/newcustomimage_modal.html |   63 +-
  lib/toaster/toastergui/templates/newproject.html   |   51 +-
  .../templates/package_built_dependencies.html      |   16 +-
  .../toastergui/templates/package_built_detail.html |    8 +-
  .../toastergui/templates/package_detail_base.html  |   44 +-
  .../templates/package_included_dependencies.html   |   20 +-
  .../templates/package_included_tabs.html           |    8 +-
  .../toastergui/templates/pkg_add_rm_btn.html       |   12 +-
  lib/toaster/toastergui/templates/project.html      |  102 +-
  .../templates/projectbuilds-toastertable.html      |   67 +-
  .../toastergui/templates/projectbuilds.html        |    4 +-
  lib/toaster/toastergui/templates/projectconf.html  | 1969 +++---
  .../templates/projects-toastertable.html           |   58 +-
  .../toastergui/templates/projecttopbar.html        |   86 +-
  lib/toaster/toastergui/templates/recipe.html       |  115 +-
  lib/toaster/toastergui/templates/recipe_btn.html   |   13 +-
  .../toastergui/templates/recipe_packages.html      |   38 +-
  .../toastergui/templates/recipedetails.html        |  154 +-
  lib/toaster/toastergui/templates/recipes.html      |  113 -
  .../templates/snippets/gitrev_popover.html         |    8 +
  .../snippets/pkg_dependencies_popover.html         |   44 +-
  .../snippets/pkg_revdependencies_popover.html      |   46 +-
  lib/toaster/toastergui/templates/target.html       |  131 +-
  lib/toaster/toastergui/templates/task.html         |  171 +-
  lib/toaster/toastergui/templates/tasks.html        |  143 -
  .../toastergui/templates/toastertable-filter.html  |   32 +-
  .../toastergui/templates/toastertable-simple.html  |   94 +-
  lib/toaster/toastergui/templates/toastertable.html |  122 +-
  .../toastergui/templates/unavailable_artifact.html |   10 +-
  lib/toaster/toastergui/templatetags/projecttags.py |   20 +-
  lib/toaster/toastergui/tests.py                    |   90 +-
  lib/toaster/toastergui/urls.py                     |   46 +-
  lib/toaster/toastergui/views.py                    |  661 +-
  lib/toaster/toastergui/widgets.py                  |   36 +-
  lib/toaster/toastermain/settings-test.py           |   41 -
  lib/toaster/toastermain/settings_test.py           |   41 +
  119 files changed, 15944 insertions(+), 4819 deletions(-)
  create mode 100644 
lib/toaster/bldcontrol/migrations/0004_auto_20160523_1446.py
  create mode 100644 lib/toaster/orm/migrations/0007_auto_20160523_1446.py
  create mode 100644 lib/toaster/toastergui/buildtables.py
  create mode 100644 lib/toaster/toastergui/static/css/bootstrap.css
  create mode 100644 lib/toaster/toastergui/static/css/bootstrap.css.map
  create mode 100644 lib/toaster/toastergui/static/css/bootstrap.min.css.map
  create mode 100644 
lib/toaster/toastergui/static/css/bootstrap3-transition.css
  create mode 100644 
lib/toaster/toastergui/static/fonts/glyphicons-halflings-regular.woff2
  delete mode 100644 
lib/toaster/toastergui/static/img/glyphicons-halflings-white.png
  delete mode 100644 
lib/toaster/toastergui/static/img/glyphicons-halflings.png
  create mode 100644 lib/toaster/toastergui/static/js/bootstrap.js
  create mode 100644 lib/toaster/toastergui/static/js/typeahead.jquery.js
  delete mode 100644 lib/toaster/toastergui/templates/bpackage.html
  create mode 100644 
lib/toaster/toastergui/templates/buildinfo-toastertable.html
  delete mode 100644 lib/toaster/toastergui/templates/buildtime.html
  delete mode 100644 lib/toaster/toastergui/templates/recipes.html
  create mode 100644 
lib/toaster/toastergui/templates/snippets/gitrev_popover.html
  delete mode 100644 lib/toaster/toastergui/templates/tasks.html
  delete mode 100644 lib/toaster/toastermain/settings-test.py
  create mode 100644 lib/toaster/toastermain/settings_test.py



