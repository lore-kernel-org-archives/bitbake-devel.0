Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 4A38A6FFCD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 15:58:57 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP; 21 Jul 2016 08:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,399,1464678000"; d="scan'208";a="999882833"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga001.jf.intel.com with ESMTP; 21 Jul 2016 08:58:45 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 1662A6A4006
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 08:58:34 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 18:58:37 +0300
Message-Id: <cover.1469116389.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH 0/3] Prevent removal of all columns on tasks and recipe tables
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
X-List-Received-Date: Thu, 21 Jul 2016 15:59:01 -0000

All of the columns for the tasks and recipes tables (sub-pages of the
build-dashboard) are optional. This means you can remove all the columns for
those tables and make them disappear from the page.

Set the non-hideable columns and add some UI tests to check that those columns
are disabled in the edit columns drop-down.

The following changes since commit 0bf1a5a6c8d731a0f4f75091621dc999ee6d5ce1:

  toaster: fix download URL for task logs (2016-07-20 17:05:57 +0300)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/submit/elliot/toaster/9833-remove_columns
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/submit/elliot/toaster/9833-remove_columns

Elliot Smith (3):
  toaster: set non-hideable columns for build tasks table
  toaster: set non-hideable columns for built recipes table
  toaster-tests: add tasks and recipes sub-page tests

 .../browser/test_builddashboard_page_recipes.py    | 66 ++++++++++++++++++++++
 .../browser/test_builddashboard_page_tasks.py      | 65 +++++++++++++++++++++
 bitbake/lib/toaster/toastergui/buildtables.py      |  7 ++-
 3 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
 create mode 100644 bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py

--
Regards,
Ed


