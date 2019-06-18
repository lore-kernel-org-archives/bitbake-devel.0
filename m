Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by mail.openembedded.org (Postfix) with ESMTP id 5B89B7E912
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 15:41:22 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id p184so7881545pfp.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2019 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=WWag5wTUrrVyE/8pZz3ziG4bsGeRoW2Zoce5S70gSv8=;
	b=b8tnmEX3kouRfvhm9I4gGIgB77cIWmadxwYPfDMGwIxCrp/RdrV5OQhd6yAWnTHv1M
	0JCKXpZgeH0LgQi+syi6RfoEd1HO4vyoq6Mel5p4kdByGbsvYkhlVWQ5xYYj6r5jfiJs
	uPKtD07tyQ6bRBy0odSzCcqpQeTMEJAX4w/tH0hldURSKPS4U7qgdtwTzCNphTcFO/Jq
	FN4AHWTayPU6hk9te4UvvbU4NEkZdRqhY7AEOsZafpKI/0sCxp27yVtHHr/CeKPs4Ztr
	q5E7QtlHNZ7+oO7DWesYrOPbfDw1UCh5xleBVV9DUkr+ZCYkPU/g//z8SlPKpBv0zNy7
	b06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=WWag5wTUrrVyE/8pZz3ziG4bsGeRoW2Zoce5S70gSv8=;
	b=jpOYgxB9Q1F0BoTR0rxq1sPx8nBIQKOmcbdhHFCeA+wZBVxkPxV338O8VOfxuVUdff
	QGd54W938tdVXbQMKFe0mt5/jSd/yoeTjP38nbN0I/xostooKAYNOYrnYlM9wGpc6pK8
	e5bS7K//JT41g4rdkN2HY/ksWlxM19JoUQ3i5W7qLfsShS5ivFN7dBxfsw2xmIqOumGC
	VurHI4BMfFNFOjb1rZ1RKI8qH+3oh4yw/INqHj5jDKev2Llch4JpFKqSF5hCMK1Bl4l4
	eJEg56sVDsEC1qm5uRDqHdyTxtyeJaUVjdcBW6d+46WDspGrhDilehQr6fNyvtqlBu+h
	rVcQ==
X-Gm-Message-State: APjAAAWoO4fbGa5/EGLIXUbfajQuySLaQmPBNgjRFXbLbHFzd1xJxxZ3
	+bsebx8BE9s3RdgueC5CsxJpstWhgL8=
X-Google-Smtp-Source: APXvYqwqGnOGHXatPgzLRuWvDlIY44b33Jmjx+kq0sQQlwa7LzN2moPIm2kR07mElxYcdZd3IA2vkA==
X-Received: by 2002:a62:1d11:: with SMTP id d17mr28978838pfd.249.1560872483141;
	Tue, 18 Jun 2019 08:41:23 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:748c:5242:a62f:a00e])
	by smtp.gmail.com with ESMTPSA id a18sm3028379pjq.0.2019.06.18.08.41.22
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Jun 2019 08:41:22 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jun 2019 08:41:13 -0700
Message-Id: <cover.1560872271.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/3] 1.42 next pull reqest
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
X-List-Received-Date: Tue, 18 Jun 2019 15:41:22 -0000

Please consider these for 1.42
The following changes since commit 2a823584a5dbc2427060352f3b4798dbb2640cfd:

  gitsm: Fix a bug where the wrong path was used for the submodule init (2019-06-18 11:43:03 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.42-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.42-next

Matthias Schiffer (1):
  fetch2: runfetchcmd(): unset _PYTHON_SYSCONFIGDATA_NAME

Richard Purdie (2):
  bitbake: Add initial pass of SPDX license headers to source code
  bitbake: Drop duplicate license boilerplace text

 HEADER                                             | 13 +----
 LICENSE                                            | 12 ++++-
 COPYING => LICENSE.GPL-2.0-only                    | 61 ++--------------------
 LICENSE.MIT                                        | 25 +++++++++
 MANIFEST.in                                        |  4 +-
 bin/bitbake                                        | 12 +----
 bin/bitbake-diffsigs                               | 12 +----
 bin/bitbake-hashserv                               | 13 +----
 bin/bitbake-layers                                 | 12 +----
 bin/bitbake-prserv                                 |  4 ++
 bin/bitbake-selftest                               | 12 +----
 bin/bitbake-worker                                 |  3 ++
 bin/bitdoc                                         | 12 +----
 bin/git-make-shallow                               |  4 ++
 bin/toaster                                        | 12 +----
 bin/toaster-eventreplay                            | 15 +-----
 lib/bb/COW.py                                      | 13 -----
 lib/bb/__init__.py                                 | 12 +----
 lib/bb/build.py                                    | 13 +----
 lib/bb/cache.py                                    | 12 +----
 lib/bb/cache_extra.py                              | 12 +----
 lib/bb/checksum.py                                 | 12 +----
 lib/bb/codeparser.py                               |  4 ++
 lib/bb/command.py                                  | 12 +----
 lib/bb/compat.py                                   |  4 ++
 lib/bb/cooker.py                                   | 13 +----
 lib/bb/cookerdata.py                               | 12 +----
 lib/bb/daemonize.py                                |  4 ++
 lib/bb/data.py                                     | 13 +----
 lib/bb/data_smart.py                               | 12 +----
 lib/bb/event.py                                    | 12 +----
 lib/bb/exceptions.py                               |  3 ++
 lib/bb/fetch2/__init__.py                          | 18 +++----
 lib/bb/fetch2/bzr.py                               | 12 +----
 lib/bb/fetch2/clearcase.py                         | 13 +----
 lib/bb/fetch2/cvs.py                               | 15 +-----
 lib/bb/fetch2/git.py                               | 14 +----
 lib/bb/fetch2/gitannex.py                          | 12 +----
 lib/bb/fetch2/gitsm.py                             | 12 +----
 lib/bb/fetch2/hg.py                                | 14 +----
 lib/bb/fetch2/local.py                             | 14 +----
 lib/bb/fetch2/npm.py                               |  3 ++
 lib/bb/fetch2/osc.py                               |  3 ++
 lib/bb/fetch2/perforce.py                          | 13 +----
 lib/bb/fetch2/repo.py                              | 14 +----
 lib/bb/fetch2/s3.py                                | 13 +----
 lib/bb/fetch2/sftp.py                              | 13 +----
 lib/bb/fetch2/ssh.py                               | 12 +----
 lib/bb/fetch2/svn.py                               | 13 +----
 lib/bb/fetch2/wget.py                              | 13 +----
 lib/bb/main.py                                     | 12 +----
 lib/bb/methodpool.py                               | 12 +----
 lib/bb/monitordisk.py                              | 12 +----
 lib/bb/msg.py                                      | 12 +----
 lib/bb/namedtuple_with_abc.py                      |  3 ++
 lib/bb/parse/__init__.py                           | 14 +----
 lib/bb/parse/ast.py                                | 13 +----
 lib/bb/parse/parse_py/BBHandler.py                 | 13 +----
 lib/bb/parse/parse_py/ConfHandler.py               | 12 +----
 lib/bb/parse/parse_py/__init__.py                  | 14 +----
 lib/bb/persist_data.py                             | 12 +----
 lib/bb/process.py                                  |  4 ++
 lib/bb/progress.py                                 | 12 +----
 lib/bb/providers.py                                | 12 +----
 lib/bb/remotedata.py                               | 12 +----
 lib/bb/runqueue.py                                 | 12 +----
 lib/bb/server/__init__.py                          | 14 +----
 lib/bb/server/process.py                           | 12 +----
 lib/bb/server/xmlrpcclient.py                      | 12 +----
 lib/bb/server/xmlrpcserver.py                      | 12 +----
 lib/bb/siggen.py                                   |  4 ++
 lib/bb/taskdata.py                                 | 12 +----
 lib/bb/tests/codeparser.py                         | 13 +----
 lib/bb/tests/cooker.py                             | 13 +----
 lib/bb/tests/cow.py                                | 15 +-----
 lib/bb/tests/data.py                               | 13 +----
 lib/bb/tests/event.py                              | 13 +----
 lib/bb/tests/fetch.py                              | 13 +----
 lib/bb/tests/parse.py                              | 13 +----
 lib/bb/tests/persist_data.py                       | 13 +----
 lib/bb/tests/utils.py                              | 13 +----
 lib/bb/tinfoil.py                                  | 12 +----
 lib/bb/ui/__init__.py                              | 12 +----
 lib/bb/ui/buildinfohelper.py                       | 12 +----
 lib/bb/ui/knotty.py                                | 12 +----
 lib/bb/ui/ncurses.py                               | 12 +----
 lib/bb/ui/taskexp.py                               | 12 +----
 lib/bb/ui/toasterui.py                             | 12 +----
 lib/bb/ui/uievent.py                               | 13 +----
 lib/bb/ui/uihelper.py                              | 12 +----
 lib/bb/utils.py                                    | 12 +----
 lib/bblayers/__init__.py                           |  4 ++
 lib/bblayers/action.py                             |  4 ++
 lib/bblayers/common.py                             |  4 ++
 lib/bblayers/layerindex.py                         |  4 ++
 lib/bblayers/query.py                              |  4 ++
 lib/hashserv/__init__.py                           | 12 +----
 lib/hashserv/tests.py                              | 12 +----
 lib/layerindexlib/__init__.py                      | 12 +----
 lib/layerindexlib/cooker.py                        | 12 +----
 lib/layerindexlib/plugin.py                        | 13 +----
 lib/layerindexlib/restapi.py                       | 12 +----
 lib/layerindexlib/tests/common.py                  | 12 +----
 lib/layerindexlib/tests/cooker.py                  | 12 +----
 lib/layerindexlib/tests/layerindexobj.py           | 12 +----
 lib/layerindexlib/tests/restapi.py                 | 12 +----
 lib/progressbar/__init__.py                        |  2 +
 lib/progressbar/compat.py                          |  2 +
 lib/progressbar/progressbar.py                     |  2 +
 lib/progressbar/widgets.py                         |  2 +
 lib/prserv/__init__.py                             |  4 ++
 lib/prserv/db.py                                   |  4 ++
 lib/prserv/serv.py                                 |  4 ++
 lib/pyinotify.py                                   | 17 +-----
 lib/toaster/bldcollector/admin.py                  |  4 ++
 lib/toaster/bldcollector/urls.py                   | 13 +----
 lib/toaster/bldcollector/views.py                  | 12 +----
 lib/toaster/bldcontrol/admin.py                    |  4 ++
 lib/toaster/bldcontrol/bbcontroller.py             | 13 +----
 lib/toaster/bldcontrol/localhostbecontroller.py    | 13 +----
 .../management/commands/checksettings.py           |  4 ++
 .../bldcontrol/management/commands/runbuilds.py    |  4 ++
 lib/toaster/bldcontrol/models.py                   |  4 ++
 lib/toaster/bldcontrol/views.py                    |  4 ++
 lib/toaster/manage.py                              |  4 ++
 lib/toaster/orm/management/commands/lsupdates.py   | 12 +----
 lib/toaster/orm/models.py                          | 12 +----
 lib/toaster/tests/browser/selenium_helpers.py      | 13 +----
 lib/toaster/tests/browser/selenium_helpers_base.py | 13 +----
 lib/toaster/tests/browser/test_all_builds_page.py  | 12 +----
 .../tests/browser/test_all_projects_page.py        | 12 +----
 .../tests/browser/test_builddashboard_page.py      | 12 +----
 .../browser/test_builddashboard_page_artifacts.py  | 12 +----
 .../browser/test_builddashboard_page_recipes.py    | 12 +----
 .../browser/test_builddashboard_page_tasks.py      | 12 +----
 lib/toaster/tests/browser/test_js_unit_tests.py    | 12 +----
 lib/toaster/tests/browser/test_landing_page.py     | 14 +----
 .../tests/browser/test_layerdetails_page.py        | 14 +----
 .../browser/test_most_recent_builds_states.py      | 14 +----
 .../tests/browser/test_new_custom_image_page.py    | 12 +----
 lib/toaster/tests/browser/test_new_project_page.py | 12 +----
 .../tests/browser/test_project_builds_page.py      | 12 +----
 .../tests/browser/test_project_config_page.py      | 12 +----
 lib/toaster/tests/browser/test_project_page.py     | 12 +----
 lib/toaster/tests/browser/test_sample.py           | 12 +----
 lib/toaster/tests/browser/test_task_page.py        | 12 +----
 lib/toaster/tests/browser/test_toastertable_ui.py  | 12 +----
 lib/toaster/tests/builds/buildtest.py              | 12 +----
 lib/toaster/tests/builds/test_core_image_min.py    | 13 +----
 lib/toaster/tests/commands/test_loaddata.py        | 12 +----
 lib/toaster/tests/commands/test_lsupdates.py       | 12 +----
 lib/toaster/tests/commands/test_runbuilds.py       | 12 +----
 lib/toaster/tests/db/test_db.py                    |  2 +
 lib/toaster/tests/eventreplay/__init__.py          | 12 +----
 lib/toaster/tests/functional/functional_helpers.py | 12 +----
 .../tests/functional/test_functional_basic.py      | 12 +----
 lib/toaster/tests/views/test_views.py              | 12 +----
 lib/toaster/toastergui/api.py                      | 13 +----
 lib/toaster/toastergui/buildtables.py              | 12 +----
 lib/toaster/toastergui/tablefilter.py              | 12 +----
 lib/toaster/toastergui/tables.py                   | 12 +----
 .../toastergui/templatetags/field_values_filter.py |  4 ++
 .../templatetags/objects_to_dictionaries_filter.py |  4 ++
 .../toastergui/templatetags/project_url_tag.py     |  4 ++
 lib/toaster/toastergui/templatetags/projecttags.py | 12 +----
 lib/toaster/toastergui/typeaheads.py               | 12 +----
 lib/toaster/toastergui/urls.py                     | 12 +----
 lib/toaster/toastergui/views.py                    | 13 +----
 lib/toaster/toastergui/widgets.py                  | 12 +----
 .../toastermain/management/commands/builddelete.py |  4 ++
 .../toastermain/management/commands/buildimport.py | 12 +----
 .../toastermain/management/commands/buildslist.py  |  4 ++
 .../toastermain/management/commands/checksocket.py | 12 +----
 .../toastermain/management/commands/perf.py        |  4 ++
 lib/toaster/toastermain/settings.py                | 12 +----
 .../toastermain/settings_production_example.py     | 12 +----
 lib/toaster/toastermain/settings_test.py           | 12 +----
 lib/toaster/toastermain/urls.py                    | 12 +----
 lib/toaster/toastermain/wsgi.py                    |  4 ++
 179 files changed, 338 insertions(+), 1609 deletions(-)
 rename COPYING => LICENSE.GPL-2.0-only (84%)
 create mode 100644 LICENSE.MIT

-- 
2.7.4


