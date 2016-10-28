Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id A655A6FF84
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 15:49:36 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 28 Oct 2016 08:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,410,1473145200"; d="scan'208";a="1077265469"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga002.fm.intel.com with ESMTP; 28 Oct 2016 08:49:37 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 4C3A96A4006;
	Fri, 28 Oct 2016 08:49:02 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 18:48:43 +0300
Message-Id: <1e366f26e207182db8c21fe5420d14155c13a544.1477669487.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
References: <9f194bc2e4eb2c366782ae6ac9a111c6157d8b01.1477669486.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1477669486.git.ed.bartosh@linux.intel.com>
References: <cover.1477669486.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 2/8] toaster: Move views tests to main testing module
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
X-List-Received-Date: Fri, 28 Oct 2016 15:49:36 -0000

From: Michael Wood <michael.g.wood@intel.com>

Consolidating all the tests to live in the same place to make them more
discoverable and consistent as well as not cluttering up the django app
directory.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/tests/views/README                                 | 4 ++++
 lib/toaster/tests/views/__init__.py                            | 0
 lib/toaster/{toastergui/tests.py => tests/views/test_views.py} | 0
 3 files changed, 4 insertions(+)
 create mode 100644 bitbake/lib/toaster/tests/views/README
 create mode 100644 bitbake/lib/toaster/tests/views/__init__.py
 rename bitbake/lib/toaster/{toastergui/tests.py => tests/views/test_views.py} (100%)

diff --git a/lib/toaster/tests/views/README b/lib/toaster/tests/views/README
new file mode 100644
index 0000000..950c7c9
--- /dev/null
+++ b/lib/toaster/tests/views/README
@@ -0,0 +1,4 @@
+
+Django unit tests to verify classes and functions based on django Views
+
+To run just these tests use ./manage.py test tests.views
diff --git a/lib/toaster/tests/views/__init__.py b/lib/toaster/tests/views/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/tests/views/test_views.py
similarity index 100%
rename from lib/toaster/toastergui/tests.py
rename to lib/toaster/tests/views/test_views.py
-- 
2.1.4


