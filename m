Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 530646D74B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Jun 2019 06:36:03 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x5R6ZiGc005079
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jun 2019 23:35:54 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Wed, 26 Jun 2019 23:35:33 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 27 Jun 2019 14:59:46 +0800
Message-ID: <cover.1561617701.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/2] bitbake: python2 -> python3
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
X-List-Received-Date: Thu, 27 Jun 2019 06:36:03 -0000
Content-Type: text/plain

Hi RP,

- For bitbake/lib/bb's changes, I removed the line '#! /usr/bin/env python',
  and I've run bitbake-selftest, everything is fine except one test case which
  says can't clone git://git.infradead.org/mtd-utils.git, I can't clone it
  mannually, either.

- For toaster/tests, I read it's README, it needs a web browser to run the test
  cases, but I don't have it on my server, so I didn't run the test cases. I just
  changed python2 -> python3, but kept the line there, I used 2to3 to check these
  files, they are python3 indeed.

// Robert
  

The following changes since commit 67266331b0f557c01cde1cc1b1a1de7197443a6c:

  local.conf.sample.extended: remove redundant RUNTIMETARGET assignment (2019-06-24 17:34:25 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/py3
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/py3

Robert Yang (2):
  bitbake: lib: Cleanup /usr/bin/env python
  bitbake: toaster:tests: python -> python3

 bitbake/lib/bb/cooker.py                                               | 1 -
 bitbake/lib/bb/cookerdata.py                                           | 1 -
 bitbake/lib/bb/main.py                                                 | 1 -
 bitbake/lib/bb/monitordisk.py                                          | 1 -
 bitbake/lib/bb/namedtuple_with_abc.py                                  | 1 -
 bitbake/lib/bb/parse/parse_py/BBHandler.py                             | 1 -
 bitbake/lib/bb/parse/parse_py/ConfHandler.py                           | 1 -
 bitbake/lib/bb/parse/parse_py/__init__.py                              | 1 -
 bitbake/lib/bb/runqueue.py                                             | 1 -
 bitbake/lib/bb/taskdata.py                                             | 1 -
 bitbake/lib/pyinotify.py                                               | 3 +--
 bitbake/lib/toaster/tests/browser/selenium_helpers.py                  | 2 +-
 bitbake/lib/toaster/tests/browser/selenium_helpers_base.py             | 2 +-
 bitbake/lib/toaster/tests/browser/test_all_builds_page.py              | 2 +-
 bitbake/lib/toaster/tests/browser/test_all_projects_page.py            | 2 +-
 bitbake/lib/toaster/tests/browser/test_builddashboard_page.py          | 2 +-
 .../lib/toaster/tests/browser/test_builddashboard_page_artifacts.py    | 2 +-
 bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py  | 2 +-
 bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py    | 2 +-
 bitbake/lib/toaster/tests/browser/test_js_unit_tests.py                | 2 +-
 bitbake/lib/toaster/tests/browser/test_landing_page.py                 | 2 +-
 bitbake/lib/toaster/tests/browser/test_layerdetails_page.py            | 2 +-
 bitbake/lib/toaster/tests/browser/test_most_recent_builds_states.py    | 2 +-
 bitbake/lib/toaster/tests/browser/test_new_custom_image_page.py        | 2 +-
 bitbake/lib/toaster/tests/browser/test_new_project_page.py             | 2 +-
 bitbake/lib/toaster/tests/browser/test_project_builds_page.py          | 2 +-
 bitbake/lib/toaster/tests/browser/test_project_config_page.py          | 2 +-
 bitbake/lib/toaster/tests/browser/test_project_page.py                 | 2 +-
 bitbake/lib/toaster/tests/browser/test_sample.py                       | 2 +-
 bitbake/lib/toaster/tests/browser/test_task_page.py                    | 2 +-
 bitbake/lib/toaster/tests/browser/test_toastertable_ui.py              | 2 +-
 bitbake/lib/toaster/tests/builds/buildtest.py                          | 2 +-
 bitbake/lib/toaster/tests/builds/test_core_image_min.py                | 2 +-
 bitbake/lib/toaster/tests/commands/test_loaddata.py                    | 2 +-
 bitbake/lib/toaster/tests/commands/test_lsupdates.py                   | 2 +-
 bitbake/lib/toaster/tests/commands/test_runbuilds.py                   | 2 +-
 bitbake/lib/toaster/tests/eventreplay/__init__.py                      | 2 +-
 bitbake/lib/toaster/tests/functional/functional_helpers.py             | 2 +-
 bitbake/lib/toaster/tests/functional/test_functional_basic.py          | 2 +-
 bitbake/lib/toaster/tests/views/test_views.py                          | 2 +-
 bitbake/lib/toaster/toastermain/management/commands/checksocket.py     | 2 +-
 41 files changed, 31 insertions(+), 42 deletions(-)

-- 
2.7.4


