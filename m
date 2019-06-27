Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 54F1F7E65E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Jun 2019 06:35:56 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x5R6ZveC026090
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jun 2019 23:35:57 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Wed, 26 Jun 2019 23:35:56 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 27 Jun 2019 14:59:48 +0800
Message-ID: <360239d4eed93a97a1dfd06d662a34dac1d70dab.1561617701.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561617701.git.liezhi.yang@windriver.com>
References: <cover.1561617701.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake: toaster:tests: python -> python3
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
X-List-Received-Date: Thu, 27 Jun 2019 06:35:56 -0000
Content-Type: text/plain

---
 bitbake/lib/toaster/tests/browser/selenium_helpers.py                   | 2 +-
 bitbake/lib/toaster/tests/browser/selenium_helpers_base.py              | 2 +-
 bitbake/lib/toaster/tests/browser/test_all_builds_page.py               | 2 +-
 bitbake/lib/toaster/tests/browser/test_all_projects_page.py             | 2 +-
 bitbake/lib/toaster/tests/browser/test_builddashboard_page.py           | 2 +-
 bitbake/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py | 2 +-
 bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py   | 2 +-
 bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py     | 2 +-
 bitbake/lib/toaster/tests/browser/test_js_unit_tests.py                 | 2 +-
 bitbake/lib/toaster/tests/browser/test_landing_page.py                  | 2 +-
 bitbake/lib/toaster/tests/browser/test_layerdetails_page.py             | 2 +-
 bitbake/lib/toaster/tests/browser/test_most_recent_builds_states.py     | 2 +-
 bitbake/lib/toaster/tests/browser/test_new_custom_image_page.py         | 2 +-
 bitbake/lib/toaster/tests/browser/test_new_project_page.py              | 2 +-
 bitbake/lib/toaster/tests/browser/test_project_builds_page.py           | 2 +-
 bitbake/lib/toaster/tests/browser/test_project_config_page.py           | 2 +-
 bitbake/lib/toaster/tests/browser/test_project_page.py                  | 2 +-
 bitbake/lib/toaster/tests/browser/test_sample.py                        | 2 +-
 bitbake/lib/toaster/tests/browser/test_task_page.py                     | 2 +-
 bitbake/lib/toaster/tests/browser/test_toastertable_ui.py               | 2 +-
 bitbake/lib/toaster/tests/builds/buildtest.py                           | 2 +-
 bitbake/lib/toaster/tests/builds/test_core_image_min.py                 | 2 +-
 bitbake/lib/toaster/tests/commands/test_loaddata.py                     | 2 +-
 bitbake/lib/toaster/tests/commands/test_lsupdates.py                    | 2 +-
 bitbake/lib/toaster/tests/commands/test_runbuilds.py                    | 2 +-
 bitbake/lib/toaster/tests/eventreplay/__init__.py                       | 2 +-
 bitbake/lib/toaster/tests/functional/functional_helpers.py              | 2 +-
 bitbake/lib/toaster/tests/functional/test_functional_basic.py           | 2 +-
 bitbake/lib/toaster/tests/views/test_views.py                           | 2 +-
 bitbake/lib/toaster/toastermain/management/commands/checksocket.py      | 2 +-
 30 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/bitbake/lib/toaster/tests/browser/selenium_helpers.py b/bitbake/lib/toaster/tests/browser/selenium_helpers.py
index 6d9bb80..02d4f4b 100644
--- a/bitbake/lib/toaster/tests/browser/selenium_helpers.py
+++ b/bitbake/lib/toaster/tests/browser/selenium_helpers.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py b/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
index 8417aa3..6c94684 100644
--- a/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_all_builds_page.py b/bitbake/lib/toaster/tests/browser/test_all_builds_page.py
index f402161..fba627b 100644
--- a/bitbake/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_all_builds_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_all_projects_page.py b/bitbake/lib/toaster/tests/browser/test_all_projects_page.py
index f86d19d..afd2d35 100644
--- a/bitbake/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_all_projects_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_builddashboard_page.py b/bitbake/lib/toaster/tests/browser/test_builddashboard_page.py
index 53c125e..d972aff 100644
--- a/bitbake/lib/toaster/tests/browser/test_builddashboard_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_builddashboard_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py b/bitbake/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
index c560d7d..e2623e8 100644
--- a/bitbake/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
+++ b/bitbake/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py b/bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
index e4f3d68..c542d45 100644
--- a/bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
+++ b/bitbake/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py b/bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
index bdb0c27..22acb47 100644
--- a/bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
+++ b/bitbake/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_js_unit_tests.py b/bitbake/lib/toaster/tests/browser/test_js_unit_tests.py
index 63f3f4a..e8b4295 100644
--- a/bitbake/lib/toaster/tests/browser/test_js_unit_tests.py
+++ b/bitbake/lib/toaster/tests/browser/test_js_unit_tests.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_landing_page.py b/bitbake/lib/toaster/tests/browser/test_landing_page.py
index 0a00fcc..0790198 100644
--- a/bitbake/lib/toaster/tests/browser/test_landing_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_landing_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py b/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
index e34aa13..f81e696 100644
--- a/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_most_recent_builds_states.py b/bitbake/lib/toaster/tests/browser/test_most_recent_builds_states.py
index d52b184..15d25dc 100644
--- a/bitbake/lib/toaster/tests/browser/test_most_recent_builds_states.py
+++ b/bitbake/lib/toaster/tests/browser/test_most_recent_builds_states.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_new_custom_image_page.py b/bitbake/lib/toaster/tests/browser/test_new_custom_image_page.py
index 3b47a49..0aa3b7a 100644
--- a/bitbake/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_new_project_page.py b/bitbake/lib/toaster/tests/browser/test_new_project_page.py
index d250bd1..8e56bb0 100644
--- a/bitbake/lib/toaster/tests/browser/test_new_project_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_new_project_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_project_builds_page.py b/bitbake/lib/toaster/tests/browser/test_project_builds_page.py
index 065f3eb..47fb10b 100644
--- a/bitbake/lib/toaster/tests/browser/test_project_builds_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_project_builds_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_project_config_page.py b/bitbake/lib/toaster/tests/browser/test_project_config_page.py
index 48508df..2816eb9 100644
--- a/bitbake/lib/toaster/tests/browser/test_project_config_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_project_config_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_project_page.py b/bitbake/lib/toaster/tests/browser/test_project_page.py
index 5cb607d..8b5e1b6 100644
--- a/bitbake/lib/toaster/tests/browser/test_project_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_project_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_sample.py b/bitbake/lib/toaster/tests/browser/test_sample.py
index 008ba14..f4ad670 100644
--- a/bitbake/lib/toaster/tests/browser/test_sample.py
+++ b/bitbake/lib/toaster/tests/browser/test_sample.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_task_page.py b/bitbake/lib/toaster/tests/browser/test_task_page.py
index 47c8c1a..26f3dca 100644
--- a/bitbake/lib/toaster/tests/browser/test_task_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_task_page.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/browser/test_toastertable_ui.py b/bitbake/lib/toaster/tests/browser/test_toastertable_ui.py
index b4f8344..ef78cbb 100644
--- a/bitbake/lib/toaster/tests/browser/test_toastertable_ui.py
+++ b/bitbake/lib/toaster/tests/browser/test_toastertable_ui.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/builds/buildtest.py b/bitbake/lib/toaster/tests/builds/buildtest.py
index 9f40f97..872bbd3 100644
--- a/bitbake/lib/toaster/tests/builds/buildtest.py
+++ b/bitbake/lib/toaster/tests/builds/buildtest.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/builds/test_core_image_min.py b/bitbake/lib/toaster/tests/builds/test_core_image_min.py
index 3d3aa2a..44b6cbe 100644
--- a/bitbake/lib/toaster/tests/builds/test_core_image_min.py
+++ b/bitbake/lib/toaster/tests/builds/test_core_image_min.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/commands/test_loaddata.py b/bitbake/lib/toaster/tests/commands/test_loaddata.py
index b633d97..9e8d555 100644
--- a/bitbake/lib/toaster/tests/commands/test_loaddata.py
+++ b/bitbake/lib/toaster/tests/commands/test_loaddata.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/commands/test_lsupdates.py b/bitbake/lib/toaster/tests/commands/test_lsupdates.py
index 23a84a2..3c4fbe0 100644
--- a/bitbake/lib/toaster/tests/commands/test_lsupdates.py
+++ b/bitbake/lib/toaster/tests/commands/test_lsupdates.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/commands/test_runbuilds.py b/bitbake/lib/toaster/tests/commands/test_runbuilds.py
index 29bc7c9..e223b95 100644
--- a/bitbake/lib/toaster/tests/commands/test_runbuilds.py
+++ b/bitbake/lib/toaster/tests/commands/test_runbuilds.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/eventreplay/__init__.py b/bitbake/lib/toaster/tests/eventreplay/__init__.py
index 3606cba..8ed6792 100644
--- a/bitbake/lib/toaster/tests/eventreplay/__init__.py
+++ b/bitbake/lib/toaster/tests/eventreplay/__init__.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/tests/functional/functional_helpers.py b/bitbake/lib/toaster/tests/functional/functional_helpers.py
index 6a3f74b..455c408 100644
--- a/bitbake/lib/toaster/tests/functional/functional_helpers.py
+++ b/bitbake/lib/toaster/tests/functional/functional_helpers.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster functional tests implementation
 #
diff --git a/bitbake/lib/toaster/tests/functional/test_functional_basic.py b/bitbake/lib/toaster/tests/functional/test_functional_basic.py
index 2b3a288..56c84fb 100644
--- a/bitbake/lib/toaster/tests/functional/test_functional_basic.py
+++ b/bitbake/lib/toaster/tests/functional/test_functional_basic.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster functional tests implementation
 #
diff --git a/bitbake/lib/toaster/tests/views/test_views.py b/bitbake/lib/toaster/tests/views/test_views.py
index 477654e..68d9e9d 100644
--- a/bitbake/lib/toaster/tests/views/test_views.py
+++ b/bitbake/lib/toaster/tests/views/test_views.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python
+#! /usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
diff --git a/bitbake/lib/toaster/toastermain/management/commands/checksocket.py b/bitbake/lib/toaster/toastermain/management/commands/checksocket.py
index c1758f3..811fd5d 100644
--- a/bitbake/lib/toaster/toastermain/management/commands/checksocket.py
+++ b/bitbake/lib/toaster/toastermain/management/commands/checksocket.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # BitBake Toaster Implementation
 #
-- 
2.7.4


