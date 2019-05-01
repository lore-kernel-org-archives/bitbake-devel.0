Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id AAE597DA9A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 11:19:11 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id f7so15754747wrs.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Xm2UH/Yo7FQ3xuiNQ5zDigUHZhn6D8E/kPXhdk25iJU=;
	b=XxgEXJ7TdbHf5l/zeF9efp1x0gcCXjK1rI9Yw9MC+37XNDrYIIikAx9WvMEWS15kup
	cwoqp7VacHf0iFs5DkSOVGZED4dMV8sDckCGL353wPzpxh02W/XTDe2/2uVoIFDrQAK6
	tSMYk7/wXjMvv6po3iadcvYZOStnm/SzUSth4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Xm2UH/Yo7FQ3xuiNQ5zDigUHZhn6D8E/kPXhdk25iJU=;
	b=Jg+lUAXN8XWLp4unwJYcGFBZz5x4YMKmWgiGwvdu3DLVkB9RQ/psWUu52hj5vBCYKk
	L11ruVbdEdDtI5JGSunN1lanviLtsFXLAVVeloKdwWDdTFGCMQiC5PX9LJJlOb+ZH87i
	iqokdtamXhDKWmbm06P2BieVz0U6vypZnhe/Z5thi8E+u9tSl1yHq4OkpbeJ4eySI+1m
	J2hld22iGcVKo9Gi/VGfHnbc/lt2A6bU+vRLL5A+csud0KxGUEiV4AzmjY9pV6NktVt/
	fTp5B3iBpKc7BFGr6/FyNRCbFYy5Ug/ywAr3p7M/hzWP+Ow9VMtlbixxPJEERpqmdyTI
	dTdA==
X-Gm-Message-State: APjAAAXmccOMpQ/XtYPg38quSITtotyBdCMa1aWfUb1kpXUCmwDvu7PB
	uTnzJDwlp9GhudxBFq93GDaCnci4xEg=
X-Google-Smtp-Source: APXvYqxtrxyQ/rg53bTyKPta3VEKB/qIvmst3/M37ItT88IMrRUTlBSlVd6MgSuOUwMi1IPK+wsEPg==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr21275447wrn.175.1556709551493;
	Wed, 01 May 2019 04:19:11 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j10sm3494597wrb.0.2019.05.01.04.19.09
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 04:19:10 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 May 2019 12:18:58 +0100
Message-Id: <20190501111859.5699-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
References: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 5/6] bitbake: Strip old editor directives from file headers
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
X-List-Received-Date: Wed, 01 May 2019 11:19:12 -0000
Content-Transfer-Encoding: 8bit

There are much better ways to handle this and most editors shouldn't need this
in modern times, drop the noise from the files. Its not consitently applied
anyway.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 HEADER                                                         | 3 ---
 bin/bitbake                                                    | 2 --
 bin/bitdoc                                                     | 2 --
 bin/toaster-eventreplay                                        | 2 --
 contrib/dump_cache.py                                          | 2 --
 lib/bb/COW.py                                                  | 2 --
 lib/bb/__init__.py                                             | 2 --
 lib/bb/build.py                                                | 2 --
 lib/bb/cache.py                                                | 2 --
 lib/bb/cache_extra.py                                          | 2 --
 lib/bb/cooker.py                                               | 2 --
 lib/bb/cookerdata.py                                           | 2 --
 lib/bb/data.py                                                 | 2 --
 lib/bb/data_smart.py                                           | 2 --
 lib/bb/event.py                                                | 2 --
 lib/bb/fetch2/__init__.py                                      | 2 --
 lib/bb/fetch2/clearcase.py                                     | 2 --
 lib/bb/fetch2/cvs.py                                           | 2 --
 lib/bb/fetch2/git.py                                           | 2 --
 lib/bb/fetch2/gitannex.py                                      | 2 --
 lib/bb/fetch2/gitsm.py                                         | 2 --
 lib/bb/fetch2/hg.py                                            | 2 --
 lib/bb/fetch2/local.py                                         | 2 --
 lib/bb/fetch2/npm.py                                           | 2 --
 lib/bb/fetch2/osc.py                                           | 2 --
 lib/bb/fetch2/perforce.py                                      | 2 --
 lib/bb/fetch2/repo.py                                          | 2 --
 lib/bb/fetch2/s3.py                                            | 2 --
 lib/bb/fetch2/sftp.py                                          | 2 --
 lib/bb/fetch2/ssh.py                                           | 2 --
 lib/bb/fetch2/svn.py                                           | 2 --
 lib/bb/fetch2/wget.py                                          | 2 --
 lib/bb/main.py                                                 | 2 --
 lib/bb/methodpool.py                                           | 3 ---
 lib/bb/monitordisk.py                                          | 2 --
 lib/bb/msg.py                                                  | 2 --
 lib/bb/parse/ast.py                                            | 2 --
 lib/bb/parse/parse_py/BBHandler.py                             | 2 --
 lib/bb/parse/parse_py/ConfHandler.py                           | 2 --
 lib/bb/parse/parse_py/__init__.py                              | 2 --
 lib/bb/providers.py                                            | 2 --
 lib/bb/runqueue.py                                             | 2 --
 lib/bb/taskdata.py                                             | 2 --
 lib/bb/tests/codeparser.py                                     | 2 --
 lib/bb/tests/cooker.py                                         | 2 --
 lib/bb/tests/cow.py                                            | 2 --
 lib/bb/tests/data.py                                           | 2 --
 lib/bb/tests/event.py                                          | 2 --
 lib/bb/tests/fetch.py                                          | 2 --
 lib/bb/tests/parse.py                                          | 2 --
 lib/bb/tests/persist_data.py                                   | 2 --
 lib/bb/tests/utils.py                                          | 2 --
 lib/bb/ui/uievent.py                                           | 2 --
 lib/bb/ui/uihelper.py                                          | 2 --
 lib/bb/utils.py                                                | 2 --
 lib/toaster/bldcontrol/bbcontroller.py                         | 3 ---
 lib/toaster/bldcontrol/localhostbecontroller.py                | 3 ---
 lib/toaster/orm/management/commands/lsupdates.py               | 3 ---
 lib/toaster/orm/models.py                                      | 3 ---
 lib/toaster/tests/browser/selenium_helpers.py                  | 2 --
 lib/toaster/tests/browser/selenium_helpers_base.py             | 2 --
 lib/toaster/tests/browser/test_all_builds_page.py              | 2 --
 lib/toaster/tests/browser/test_all_projects_page.py            | 2 --
 lib/toaster/tests/browser/test_builddashboard_page.py          | 2 --
 .../tests/browser/test_builddashboard_page_artifacts.py        | 2 --
 lib/toaster/tests/browser/test_builddashboard_page_recipes.py  | 2 --
 lib/toaster/tests/browser/test_builddashboard_page_tasks.py    | 2 --
 lib/toaster/tests/browser/test_js_unit_tests.py                | 2 --
 lib/toaster/tests/browser/test_landing_page.py                 | 2 --
 lib/toaster/tests/browser/test_layerdetails_page.py            | 2 --
 lib/toaster/tests/browser/test_most_recent_builds_states.py    | 2 --
 lib/toaster/tests/browser/test_new_custom_image_page.py        | 2 --
 lib/toaster/tests/browser/test_new_project_page.py             | 2 --
 lib/toaster/tests/browser/test_project_builds_page.py          | 2 --
 lib/toaster/tests/browser/test_project_config_page.py          | 2 --
 lib/toaster/tests/browser/test_project_page.py                 | 2 --
 lib/toaster/tests/browser/test_sample.py                       | 2 --
 lib/toaster/tests/browser/test_task_page.py                    | 2 --
 lib/toaster/tests/browser/test_toastertable_ui.py              | 2 --
 lib/toaster/tests/builds/buildtest.py                          | 2 --
 lib/toaster/tests/builds/test_core_image_min.py                | 2 --
 lib/toaster/tests/commands/test_loaddata.py                    | 2 --
 lib/toaster/tests/commands/test_lsupdates.py                   | 2 --
 lib/toaster/tests/commands/test_runbuilds.py                   | 2 --
 lib/toaster/tests/eventreplay/__init__.py                      | 2 --
 lib/toaster/tests/functional/functional_helpers.py             | 2 --
 lib/toaster/tests/functional/test_functional_basic.py          | 2 --
 lib/toaster/tests/views/test_views.py                          | 2 --
 lib/toaster/toastergui/buildtables.py                          | 3 ---
 lib/toaster/toastergui/tablefilter.py                          | 3 ---
 lib/toaster/toastergui/tables.py                               | 3 ---
 lib/toaster/toastergui/templatetags/projecttags.py             | 3 ---
 lib/toaster/toastergui/views.py                                | 3 ---
 lib/toaster/toastergui/widgets.py                              | 3 ---
 lib/toaster/toastermain/management/commands/buildimport.py     | 3 ---
 lib/toaster/toastermain/management/commands/checksocket.py     | 2 --
 lib/toaster/toastermain/settings.py                            | 3 ---
 lib/toaster/toastermain/settings_production_example.py         | 3 ---
 lib/toaster/toastermain/settings_test.py                       | 3 ---
 lib/toaster/toastermain/urls.py                                | 3 ---
 lib/toaster/toastermain/wsgi.py                                | 3 ---
 101 files changed, 220 deletions(-)

diff --git a/HEADER b/HEADER
index 323892ecac..5f9e745ff4 100644
--- a/HEADER
+++ b/HEADER
@@ -1,6 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # <one line to give the program's name and a brief idea of what it does.>
 # Copyright (C) <year>  <name of author>
 #
diff --git a/bin/bitbake b/bin/bitbake
index e425f70a58..b219d362e7 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -1,6 +1,4 @@
 #!/usr/bin/env python3
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
diff --git a/bin/bitdoc b/bin/bitdoc
index 4839a6489f..9bd02be69c 100755
--- a/bin/bitdoc
+++ b/bin/bitdoc
@@ -1,6 +1,4 @@
 #!/usr/bin/env python3
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2005 Holger Hans Peter Freyther
 #
diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index 3f01a3cc00..8fa4ab7116 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -1,6 +1,4 @@
 #!/usr/bin/env python3
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2014        Alex Damian
 #
diff --git a/contrib/dump_cache.py b/contrib/dump_cache.py
index 8963ca4b06..c6723cbf0a 100755
--- a/contrib/dump_cache.py
+++ b/contrib/dump_cache.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python3
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2012, 2018 Wind River Systems, Inc.
 #
diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index 06678a9bf8..d26e981951 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # This is a copy on write dictionary and set which abuses classes to try and be nice and fast.
 #
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index d57ebad90a..7579a893b6 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Build System Python Library
 #
diff --git a/lib/bb/build.py b/lib/bb/build.py
index 88c69b399d..ef46647f7b 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake 'Build' implementation
 #
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index af410aac39..060758e0c4 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Cache implementation
 #
diff --git a/lib/bb/cache_extra.py b/lib/bb/cache_extra.py
index d282601134..bf4226d168 100644
--- a/lib/bb/cache_extra.py
+++ b/lib/bb/cache_extra.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Extra RecipeInfo will be all defined in this file. Currently,
 # Only Hob (Image Creator) Requests some extra fields. So
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index db08150d85..c8e14042d6 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 50b6b6bd3a..f8ae41093b 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 2dcb16e56a..92ef405304 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Data' implementations
 
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index da67998b10..dd5c618564 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake Smart Dictionary Implementation
 
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 656491494e..7cbb5ca47e 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Event' implementation
 
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 164c1a0ad4..0126e0d7c7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' implementations
 
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 09c9d0c33c..9ed0d9beaa 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' clearcase implementation
 
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
index c780a6a45d..1b35ba4cf0 100644
--- a/lib/bb/fetch2/cvs.py
+++ b/lib/bb/fetch2/cvs.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' implementations
 
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 80caf109b1..e171aa7eb1 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' git implementation
 
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index 939e058127..1d497dcb0f 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' git annex implementation
 """
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index b13b2c7888..1f03ba7a0d 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' git submodules implementation
 
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 289fcd14bf..15d729e7b2 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' implementation for mercurial DRCS (hg).
 
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index b04476fe48..01d9ff9f8f 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' implementations
 
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 7235f899f4..f08bdee739 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -1,8 +1,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' NPM implementation
 
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 19c0d9dcaa..3e567155dc 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -1,8 +1,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 Bitbake "Fetch" implementation for osc (Opensuse build service client).
 Based on the svn "Fetch" implementation.
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index a03a36d340..54d001ec81 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' implementation for perforce
 
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index cd752d5283..2bdbbd4097 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake "Fetch" repo (git) implementation
 
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 479528f926..ffca73c8e4 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' implementation for Amazon AWS S3.
 
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index f4a979197a..f87f292e5d 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake SFTP Fetch implementation
 
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index be2427cf9a..f5be060c43 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 '''
 BitBake 'Fetch' implementations
 
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 6a82da9d52..baeb0e7eea 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' implementation for svn.
 
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 143db1b361..0f71ee4eac 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'Fetch' implementations
 
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 3c8746d2bd..8d1978f986 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
diff --git a/lib/bb/methodpool.py b/lib/bb/methodpool.py
index 2f383c229c..51783acc1b 100644
--- a/lib/bb/methodpool.py
+++ b/lib/bb/methodpool.py
@@ -1,6 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 #
 # Copyright (C)       2006 Holger Hans Peter Freyther
 #
diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 855452d2b4..69b25c7720 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2012 Robert Yang
 #
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index a116444fa1..6216eb3bc4 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'msg' implementation
 
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 71ee49b8ce..f0911e6fb7 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
  AbstractSyntaxTree classes for the Bitbake language
 """
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 55fd1cb6c3..889f230f79 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
    class for handling .bb files
 
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index cc70da0db6..71bf61b761 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
    class for handling configuration data files
 
diff --git a/lib/bb/parse/parse_py/__init__.py b/lib/bb/parse/parse_py/__init__.py
index 696c71b458..cdebe440dd 100644
--- a/lib/bb/parse/parse_py/__init__.py
+++ b/lib/bb/parse/parse_py/__init__.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake Parsers
 
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 78445d6a72..f80963cb40 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 3dfa391c31..d573ed460e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'RunQueue' implementation
 
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 5c49739da3..c7de3db38d 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake 'TaskData' implementation
 
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index 742ccc2c27..826a2d2f6d 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Test for codeparser.py
 #
diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index 70b18598e1..090916e949 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Tests for cooker.py
 #
diff --git a/lib/bb/tests/cow.py b/lib/bb/tests/cow.py
index 59ad242183..b4af4bbcbf 100644
--- a/lib/bb/tests/cow.py
+++ b/lib/bb/tests/cow.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Tests for Copy-on-Write (cow.py)
 #
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 8bd472a8be..3cf5abec70 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Tests for the Data Store (data.py/data_smart.py)
 #
diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index e6254c7a1e..b6e40c6ae9 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Tests for the Event implementation (event.py)
 #
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c0ee308e12..97656dff63 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Tests for the Fetcher (fetch2/)
 #
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 3875fbbd41..e333232ec0 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Test for lib/bb/parse/
 #
diff --git a/lib/bb/tests/persist_data.py b/lib/bb/tests/persist_data.py
index dbb3ce183d..f641b5acbc 100644
--- a/lib/bb/tests/persist_data.py
+++ b/lib/bb/tests/persist_data.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Test for lib/bb/persist_data/
 #
diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 1f01447bbb..4d788281a7 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Tests for utils.py
 #
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index 7276bdaf9d..fedb05064d 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
 # Copyright (C) 2006 - 2007  Richard Purdie
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 45519c8afd..db7f0ca08b 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
 # Copyright (C) 2006 - 2007  Richard Purdie
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index e438694082..ed19825faf 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1,5 +1,3 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
 BitBake Utility Functions
 """
diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 9b92207937..301df1880a 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2014        Intel Corporation
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 41e5629ae0..39ea736b58 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2014        Intel Corporation
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index a6ab6e8046..5b5abbb295 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2016-2017   Intel Corporation
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 7174e85582..41a9f819df 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2013        Intel Corporation
diff --git a/lib/toaster/tests/browser/selenium_helpers.py b/lib/toaster/tests/browser/selenium_helpers.py
index 56621096b5..6d9bb80928 100644
--- a/lib/toaster/tests/browser/selenium_helpers.py
+++ b/lib/toaster/tests/browser/selenium_helpers.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 8c25740b64..8417aa3b25 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toaster/tests/browser/test_all_builds_page.py
index f895028686..f4021614bf 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/toaster/tests/browser/test_all_projects_page.py
index 1c46258641..f86d19d283 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py b/lib/toaster/tests/browser/test_builddashboard_page.py
index 350e5e0a95..53c125ec58 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
index a4f2f0c71a..c560d7de17 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_recipes.py b/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
index ebf1f99083..e4f3d685ee 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_tasks.py b/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
index c136fe3bf9..bdb0c27be4 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_js_unit_tests.py b/lib/toaster/tests/browser/test_js_unit_tests.py
index 76c3495e8c..63f3f4a74e 100644
--- a/lib/toaster/tests/browser/test_js_unit_tests.py
+++ b/lib/toaster/tests/browser/test_js_unit_tests.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
index 85529b2921..0a00fccc1a 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index 0a9fd85091..e34aa13dbd 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_most_recent_builds_states.py b/lib/toaster/tests/browser/test_most_recent_builds_states.py
index e2601017b1..d52b18429c 100644
--- a/lib/toaster/tests/browser/test_most_recent_builds_states.py
+++ b/lib/toaster/tests/browser/test_most_recent_builds_states.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/lib/toaster/tests/browser/test_new_custom_image_page.py
index f2f5e7104e..3b47a497e8 100644
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toaster/tests/browser/test_new_project_page.py
index d715d3a842..d250bd143e 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_project_builds_page.py b/lib/toaster/tests/browser/test_project_builds_page.py
index 0a8a38b2c8..065f3ebe64 100644
--- a/lib/toaster/tests/browser/test_project_builds_page.py
+++ b/lib/toaster/tests/browser/test_project_builds_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_project_config_page.py b/lib/toaster/tests/browser/test_project_config_page.py
index 5ae3a0a20c..48508dff3b 100644
--- a/lib/toaster/tests/browser/test_project_config_page.py
+++ b/lib/toaster/tests/browser/test_project_config_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_project_page.py b/lib/toaster/tests/browser/test_project_page.py
index aa984237fb..5cb607ddd3 100644
--- a/lib/toaster/tests/browser/test_project_page.py
+++ b/lib/toaster/tests/browser/test_project_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_sample.py b/lib/toaster/tests/browser/test_sample.py
index 219f00cec4..008ba14a26 100644
--- a/lib/toaster/tests/browser/test_sample.py
+++ b/lib/toaster/tests/browser/test_sample.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_task_page.py b/lib/toaster/tests/browser/test_task_page.py
index 993f081d93..47c8c1aeea 100644
--- a/lib/toaster/tests/browser/test_task_page.py
+++ b/lib/toaster/tests/browser/test_task_page.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/browser/test_toastertable_ui.py b/lib/toaster/tests/browser/test_toastertable_ui.py
index f22239c482..b4f83447f6 100644
--- a/lib/toaster/tests/browser/test_toastertable_ui.py
+++ b/lib/toaster/tests/browser/test_toastertable_ui.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/builds/buildtest.py
index fce7b62144..9f40f978d0 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/builds/test_core_image_min.py b/lib/toaster/tests/builds/test_core_image_min.py
index 63f62c8e5a..3d3aa2a8a2 100644
--- a/lib/toaster/tests/builds/test_core_image_min.py
+++ b/lib/toaster/tests/builds/test_core_image_min.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/commands/test_loaddata.py b/lib/toaster/tests/commands/test_loaddata.py
index 27a0eca8f3..b633d9774d 100644
--- a/lib/toaster/tests/commands/test_loaddata.py
+++ b/lib/toaster/tests/commands/test_loaddata.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/commands/test_lsupdates.py b/lib/toaster/tests/commands/test_lsupdates.py
index 854bb7ebab..23a84a248b 100644
--- a/lib/toaster/tests/commands/test_lsupdates.py
+++ b/lib/toaster/tests/commands/test_lsupdates.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/commands/test_runbuilds.py b/lib/toaster/tests/commands/test_runbuilds.py
index 3180e96dba..29bc7c9005 100644
--- a/lib/toaster/tests/commands/test_runbuilds.py
+++ b/lib/toaster/tests/commands/test_runbuilds.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/eventreplay/__init__.py b/lib/toaster/tests/eventreplay/__init__.py
index 941531461c..3606cba4f5 100644
--- a/lib/toaster/tests/eventreplay/__init__.py
+++ b/lib/toaster/tests/eventreplay/__init__.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toaster/tests/functional/functional_helpers.py
index 9de6fbcf04..6a3f74baae 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster functional tests implementation
 #
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
index e58045d3e2..2b3a2886cc 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster functional tests implementation
 #
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/views/test_views.py
index f4273367cd..477654ea5e 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -1,6 +1,4 @@
 #! /usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/toastergui/buildtables.py b/lib/toaster/toastergui/buildtables.py
index 4332107fc8..327059d00d 100644
--- a/lib/toaster/toastergui/buildtables.py
+++ b/lib/toaster/toastergui/buildtables.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2016 Intel Corporation
diff --git a/lib/toaster/toastergui/tablefilter.py b/lib/toaster/toastergui/tablefilter.py
index 04220cf24d..ffef7955f0 100644
--- a/lib/toaster/toastergui/tablefilter.py
+++ b/lib/toaster/toastergui/tablefilter.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2015        Intel Corporation
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index a3de22a359..b3ea2227e0 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2015        Intel Corporation
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index d2ee11d2f6..1dbab3bdb9 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2013        Intel Corporation
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 5ef4f40da7..d7acaff892 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2013        Intel Corporation
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index fb03337498..645f4587e8 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2015        Intel Corporation
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index a6340575a9..408ad44e6e 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2018        Wind River Systems
diff --git a/lib/toaster/toastermain/management/commands/checksocket.py b/lib/toaster/toastermain/management/commands/checksocket.py
index 822373011c..c1758f3402 100644
--- a/lib/toaster/toastermain/management/commands/checksocket.py
+++ b/lib/toaster/toastermain/management/commands/checksocket.py
@@ -1,6 +1,4 @@
 #!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Toaster Implementation
 #
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 457ed0da10..74501fa26b 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2013        Intel Corporation
diff --git a/lib/toaster/toastermain/settings_production_example.py b/lib/toaster/toastermain/settings_production_example.py
index d06841fcce..6cd0f52dd7 100644
--- a/lib/toaster/toastermain/settings_production_example.py
+++ b/lib/toaster/toastermain/settings_production_example.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2016        Intel Corporation
diff --git a/lib/toaster/toastermain/settings_test.py b/lib/toaster/toastermain/settings_test.py
index 599cc186a6..6538d9e453 100644
--- a/lib/toaster/toastermain/settings_test.py
+++ b/lib/toaster/toastermain/settings_test.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2016        Intel Corporation
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index d3a95923f5..ac77bc3632 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -1,7 +1,4 @@
 #
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 # BitBake Toaster Implementation
 #
 # Copyright (C) 2013        Intel Corporation
diff --git a/lib/toaster/toastermain/wsgi.py b/lib/toaster/toastermain/wsgi.py
index 5ad22aea18..4c31283279 100644
--- a/lib/toaster/toastermain/wsgi.py
+++ b/lib/toaster/toastermain/wsgi.py
@@ -3,9 +3,6 @@
 #
 
 """
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
 WSGI config for Toaster project.
 
 This module contains the WSGI application used by Django's development server
-- 
2.20.1


