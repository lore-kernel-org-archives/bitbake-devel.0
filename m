Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail.openembedded.org (Postfix) with ESMTP id 60BCC7DA8A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 11:19:11 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id r7so4531265wrr.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 04:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=eZanygI9dqDYnzDrazUiJKhxOhr9LCt3tHKthfPMEyg=;
	b=H4TDb3aWE0G1KNC8Dv5OZuoMHXmezJE+pEdnR+JlbDm0vH/lfUuVLwOF52rZMgYnUe
	NdhSYde6dW/s5gn3+l82ahkwcGAvgUtIs+Vapau1FYsjVKVSVI79b7L0Pd4CY8hon5OO
	KI4cWIz9USTt3kVtam6QRWELIeoO58O/0gLDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=eZanygI9dqDYnzDrazUiJKhxOhr9LCt3tHKthfPMEyg=;
	b=fnB+osfOK9j31KZSIDEK6SMQ/2z0k7ISGYNdOd8i8H81X9kJ21Ss0Aa2Z2A7ciDi16
	s9mKs2GkEyXGsSd3npvzvUR0OVfcy/TFf4zxM5Tx0erbIqzU7DC+NSO16HIo8Gfb+eLn
	LVuOViu3tKBFajFITPLewJrMZGgWo4gnvuZsPK1r4ionFi6QCBBQIgnDNXu8fpIYs52X
	IYfg+8wXgCVa31ZQIVaArmhQiIkvKIld6C1eLc8jr6B77By6elqKEs4Y84rnrNM/8waX
	hrZQ1ZIK6KUr6v5rBD2Ggvzghj/luwPSNrULdFxJSwRqtu7PNx3r6x8NysxiFAHL3dkB
	CYIQ==
X-Gm-Message-State: APjAAAVbhYz5Tyk9uA4n7lya06MQ6R+dViJwi1bD59LYAGTYQXKolQ6r
	6oMvbk6I0QNJSCdXwJpZdkjeBzXOgKk=
X-Google-Smtp-Source: APXvYqxst/KMZvHlumZ+rkWVHaE7gELi9p4upFj7xfTTYlAjPBf3txiyoFdH39d4MAI0om3Uqdu0lw==
X-Received: by 2002:adf:9792:: with SMTP id s18mr20846438wrb.133.1556709549827;
	Wed, 01 May 2019 04:19:09 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j10sm3494597wrb.0.2019.05.01.04.19.05
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 04:19:09 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 May 2019 12:18:57 +0100
Message-Id: <20190501111859.5699-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
References: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 01 May 2019 11:27:53 +0000
Subject: [PATCH 4/6] bitbake: Drop duplicate license boilerplace text
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

With the introduction of SPDX-License-Identifier headers, we don't need a ton
of header boilerplate in every file. Simplify the files and rely on the top
level for the full licence text.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 HEADER                                          | 13 -------------
 bin/bitbake                                     | 12 ------------
 bin/bitbake-diffsigs                            | 12 ------------
 bin/bitbake-hashserv                            | 13 +------------
 bin/bitbake-layers                              | 12 ------------
 bin/bitbake-selftest                            | 12 ------------
 bin/bitdoc                                      | 12 ------------
 bin/toaster                                     | 12 ------------
 bin/toaster-eventreplay                         | 12 ------------
 lib/bb/COW.py                                   | 13 -------------
 lib/bb/__init__.py                              | 12 ------------
 lib/bb/build.py                                 | 13 -------------
 lib/bb/cache.py                                 | 12 ------------
 lib/bb/cache_extra.py                           | 12 ------------
 lib/bb/checksum.py                              | 12 ------------
 lib/bb/command.py                               | 12 ------------
 lib/bb/cooker.py                                | 13 -------------
 lib/bb/cookerdata.py                            | 12 ------------
 lib/bb/data.py                                  | 13 -------------
 lib/bb/data_smart.py                            | 12 ------------
 lib/bb/event.py                                 | 12 ------------
 lib/bb/fetch2/__init__.py                       | 13 -------------
 lib/bb/fetch2/bzr.py                            | 12 ------------
 lib/bb/fetch2/clearcase.py                      | 13 -------------
 lib/bb/fetch2/cvs.py                            | 15 +--------------
 lib/bb/fetch2/git.py                            | 12 ------------
 lib/bb/fetch2/gitannex.py                       | 12 ------------
 lib/bb/fetch2/gitsm.py                          | 12 ------------
 lib/bb/fetch2/hg.py                             | 14 +-------------
 lib/bb/fetch2/local.py                          | 14 +-------------
 lib/bb/fetch2/perforce.py                       | 13 -------------
 lib/bb/fetch2/repo.py                           | 14 +-------------
 lib/bb/fetch2/s3.py                             | 13 -------------
 lib/bb/fetch2/sftp.py                           | 13 -------------
 lib/bb/fetch2/ssh.py                            | 12 ------------
 lib/bb/fetch2/svn.py                            | 13 -------------
 lib/bb/fetch2/wget.py                           | 13 -------------
 lib/bb/main.py                                  | 12 ------------
 lib/bb/methodpool.py                            | 12 ------------
 lib/bb/monitordisk.py                           | 12 ------------
 lib/bb/msg.py                                   | 12 ------------
 lib/bb/parse/__init__.py                        | 14 +-------------
 lib/bb/parse/ast.py                             | 13 -------------
 lib/bb/parse/parse_py/BBHandler.py              | 13 -------------
 lib/bb/parse/parse_py/ConfHandler.py            | 12 ------------
 lib/bb/parse/parse_py/__init__.py               | 14 +-------------
 lib/bb/persist_data.py                          | 12 ------------
 lib/bb/progress.py                              | 12 ------------
 lib/bb/providers.py                             | 12 ------------
 lib/bb/remotedata.py                            | 12 ------------
 lib/bb/runqueue.py                              | 12 ------------
 lib/bb/server/__init__.py                       | 14 --------------
 lib/bb/server/process.py                        | 12 ------------
 lib/bb/server/xmlrpcclient.py                   | 12 ------------
 lib/bb/server/xmlrpcserver.py                   | 12 ------------
 lib/bb/taskdata.py                              | 12 ------------
 lib/bb/tests/codeparser.py                      | 13 -------------
 lib/bb/tests/cooker.py                          | 13 -------------
 lib/bb/tests/cow.py                             | 13 -------------
 lib/bb/tests/data.py                            | 13 -------------
 lib/bb/tests/event.py                           | 13 -------------
 lib/bb/tests/fetch.py                           | 13 -------------
 lib/bb/tests/parse.py                           | 13 -------------
 lib/bb/tests/persist_data.py                    | 13 -------------
 lib/bb/tests/utils.py                           | 13 -------------
 lib/bb/tinfoil.py                               | 12 ------------
 lib/bb/ui/__init__.py                           | 12 ------------
 lib/bb/ui/buildinfohelper.py                    | 12 ------------
 lib/bb/ui/knotty.py                             | 12 ------------
 lib/bb/ui/ncurses.py                            | 12 ------------
 lib/bb/ui/taskexp.py                            | 12 ------------
 lib/bb/ui/toasterui.py                          | 12 ------------
 lib/bb/ui/uievent.py                            | 13 -------------
 lib/bb/ui/uihelper.py                           | 12 ------------
 lib/bb/utils.py                                 | 12 ------------
 lib/hashserv/__init__.py                        | 12 ------------
 lib/hashserv/tests.py                           | 12 ------------
 lib/layerindexlib/__init__.py                   | 12 ------------
 lib/layerindexlib/cooker.py                     | 12 ------------
 lib/layerindexlib/plugin.py                     | 13 -------------
 lib/layerindexlib/restapi.py                    | 12 ------------
 lib/layerindexlib/tests/common.py               | 12 ------------
 lib/layerindexlib/tests/cooker.py               | 12 ------------
 lib/layerindexlib/tests/layerindexobj.py        | 12 ------------
 lib/layerindexlib/tests/restapi.py              | 12 ------------
 lib/pyinotify.py                                | 17 -----------------
 lib/toaster/bldcollector/urls.py                | 13 -------------
 lib/toaster/bldcollector/views.py               | 12 ------------
 lib/toaster/bldcontrol/bbcontroller.py          | 13 -------------
 lib/toaster/bldcontrol/localhostbecontroller.py | 13 -------------
 .../orm/management/commands/lsupdates.py        | 12 ------------
 lib/toaster/orm/models.py                       | 12 ------------
 lib/toaster/tests/browser/selenium_helpers.py   | 13 -------------
 .../tests/browser/selenium_helpers_base.py      | 13 -------------
 .../tests/browser/test_all_builds_page.py       | 12 ------------
 .../tests/browser/test_all_projects_page.py     | 12 ------------
 .../tests/browser/test_builddashboard_page.py   | 12 ------------
 .../test_builddashboard_page_artifacts.py       | 12 ------------
 .../browser/test_builddashboard_page_recipes.py | 12 ------------
 .../browser/test_builddashboard_page_tasks.py   | 12 ------------
 lib/toaster/tests/browser/test_js_unit_tests.py | 12 ------------
 lib/toaster/tests/browser/test_landing_page.py  | 12 ------------
 .../tests/browser/test_layerdetails_page.py     | 12 ------------
 .../browser/test_most_recent_builds_states.py   | 12 ------------
 .../tests/browser/test_new_custom_image_page.py | 12 ------------
 .../tests/browser/test_new_project_page.py      | 12 ------------
 .../tests/browser/test_project_builds_page.py   | 12 ------------
 .../tests/browser/test_project_config_page.py   | 12 ------------
 lib/toaster/tests/browser/test_project_page.py  | 12 ------------
 lib/toaster/tests/browser/test_sample.py        | 12 ------------
 lib/toaster/tests/browser/test_task_page.py     | 12 ------------
 .../tests/browser/test_toastertable_ui.py       | 12 ------------
 lib/toaster/tests/builds/buildtest.py           | 12 ------------
 lib/toaster/tests/builds/test_core_image_min.py | 13 -------------
 lib/toaster/tests/commands/test_loaddata.py     | 12 ------------
 lib/toaster/tests/commands/test_lsupdates.py    | 12 ------------
 lib/toaster/tests/commands/test_runbuilds.py    | 12 ------------
 lib/toaster/tests/eventreplay/__init__.py       | 12 ------------
 .../tests/functional/functional_helpers.py      | 12 ------------
 .../tests/functional/test_functional_basic.py   | 12 ------------
 lib/toaster/tests/views/test_views.py           | 12 ------------
 lib/toaster/toastergui/api.py                   | 13 -------------
 lib/toaster/toastergui/buildtables.py           | 12 ------------
 lib/toaster/toastergui/tablefilter.py           | 12 ------------
 lib/toaster/toastergui/tables.py                | 12 ------------
 .../toastergui/templatetags/projecttags.py      | 12 ------------
 lib/toaster/toastergui/typeaheads.py            | 12 ------------
 lib/toaster/toastergui/urls.py                  | 12 ------------
 lib/toaster/toastergui/views.py                 | 13 -------------
 lib/toaster/toastergui/widgets.py               | 12 ------------
 .../management/commands/buildimport.py          | 12 ------------
 .../management/commands/checksocket.py          | 12 ------------
 lib/toaster/toastermain/settings.py             | 12 ------------
 .../toastermain/settings_production_example.py  | 12 ------------
 lib/toaster/toastermain/settings_test.py        | 12 ------------
 lib/toaster/toastermain/urls.py                 | 12 ------------
 136 files changed, 7 insertions(+), 1679 deletions(-)

diff --git a/HEADER b/HEADER
index 113872d469..323892ecac 100644
--- a/HEADER
+++ b/HEADER
@@ -6,16 +6,3 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
diff --git a/bin/bitbake b/bin/bitbake
index 0205b67f99..e425f70a58 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -11,18 +11,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import sys
diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index de4e3786e9..19420a2df6 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -7,18 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import sys
diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index 924e602592..848a0ca39f 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -4,18 +4,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
 import os
 import sys
 import logging
diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index da52990515..a884dc1f8d 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -9,18 +9,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import logging
 import os
diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 5b2a5e1d15..20553e9814 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -4,18 +4,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import sys, logging
diff --git a/bin/bitdoc b/bin/bitdoc
index cfe54a9236..4839a6489f 100755
--- a/bin/bitdoc
+++ b/bin/bitdoc
@@ -6,18 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import optparse, os, sys
 
diff --git a/bin/toaster b/bin/toaster
index 9da2a2649c..c3472dfee8 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -6,18 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see http://www.gnu.org/licenses/.
 
 HELP="
 Usage: source toaster start|stop [webport=<address:port>] [noweb] [nobuild] [toasterdir]
diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index abd91fe8b2..3f01a3cc00 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -9,18 +9,6 @@
 # This file re-uses code spread throughout other Bitbake source files.
 # As such, all other copyrights belong to their own right holders.
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 """
 This command takes a filename as a single parameter. The filename is read
diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index 7817473ab8..06678a9bf8 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -5,19 +5,6 @@
 #
 # Copyright (C) 2006 Tim Ansell
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 #Please Note:
 # Be careful when using mutable types (ie Dict and Lists) - operations involving these are SLOW.
 # Assign a file to __warn__ to get warnings about slow operations.
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index b013cbb896..d57ebad90a 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -10,18 +10,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 __version__ = "1.43.0"
 
diff --git a/lib/bb/build.py b/lib/bb/build.py
index ca41632ff6..88c69b399d 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -12,19 +12,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 42193dc9d6..af410aac39 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -17,18 +17,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import sys
diff --git a/lib/bb/cache_extra.py b/lib/bb/cache_extra.py
index 108d55d16f..d282601134 100644
--- a/lib/bb/cache_extra.py
+++ b/lib/bb/cache_extra.py
@@ -14,18 +14,6 @@
 
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from bb.cache import RecipeInfoCommon
 
diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 9ac07a6a84..5bc8a8fcb6 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -4,18 +4,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import glob
 import operator
diff --git a/lib/bb/command.py b/lib/bb/command.py
index 9ebaac643a..378f389b3a 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -8,18 +8,6 @@ Provide an interface to interact with the bitbake server through 'commands'
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 """
 The bitbake server takes 'commands' from its UI/commandline.
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fe812653fa..db08150d85 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -11,19 +11,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
 
 import sys, os, glob, os.path, re, time
 import atexit
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 3b074b2f3a..50b6b6bd3a 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -11,18 +11,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import logging
 import os
diff --git a/lib/bb/data.py b/lib/bb/data.py
index ba50b9ff1b..2dcb16e56a 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -24,19 +24,6 @@ the speed is more critical here.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import sys, os, re
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 441bb3001b..da67998b10 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -16,18 +16,6 @@ BitBake build tools.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import copy, re, sys, traceback
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 48f8e73847..656491494e 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -11,18 +11,6 @@ BitBake build tools.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os, sys
 import warnings
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index c92844da5c..164c1a0ad4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -12,19 +12,6 @@ BitBake build tools.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os, re
diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index 891fef9b9d..c56d875300 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -12,18 +12,6 @@ BitBake 'Fetch' implementation for bzr.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import sys
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index ff181bb78b..09c9d0c33c 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -49,19 +49,6 @@ User credentials:
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 
 import os
 import sys
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
index 666f4be2bc..c780a6a45d 100644
--- a/lib/bb/fetch2/cvs.py
+++ b/lib/bb/fetch2/cvs.py
@@ -12,20 +12,7 @@ BitBake build tools.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-#Based on functions from the base bb module, Copyright 2003 Holger Schurig
+# Based on functions from the base bb module, Copyright 2003 Holger Schurig
 #
 
 import os
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 78ad18cc7a..80caf109b1 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -59,18 +59,6 @@ Supported SRC_URI options are:
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import collections
 import errno
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index 3a32c85a83..939e058127 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -9,18 +9,6 @@ BitBake 'Fetch' git annex implementation
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import bb
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index e910a08390..b13b2c7888 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -18,18 +18,6 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your r
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import bb
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index c9eeaaefca..289fcd14bf 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -9,22 +9,10 @@ BitBake 'Fetch' implementation for mercurial DRCS (hg).
 # Copyright (C) 2004        Marcin Juszkiewicz
 # Copyright (C) 2007        Robert Schuster
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
+#
 
 import os
 import sys
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 13e6d80b5b..b04476fe48 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -12,20 +12,8 @@ BitBake build tools.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
+#
 
 import os
 import urllib.request, urllib.parse, urllib.error
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 366da99eab..a03a36d340 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -10,19 +10,6 @@ BitBake 'Fetch' implementation for perforce
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 066ab08fc3..cd752d5283 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -8,22 +8,10 @@ BitBake "Fetch" repo (git) implementation
 # Copyright (C) 2009 Tom Rini <trini@embeddedalley.com>
 #
 # Based on git.py which is:
-#Copyright (C) 2005 Richard Purdie
+# Copyright (C) 2005 Richard Purdie
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import bb
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index fae7c8b0f0..479528f926 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -15,19 +15,6 @@ The aws tool must be correctly installed and configured prior to use.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 6dea6ad6b2..f4a979197a 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -46,19 +46,6 @@ SRC_URI = "sftp://user@host.example.com/dir/path.file.txt"
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index d416a9db87..be2427cf9a 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -31,18 +31,6 @@ IETF secsh internet draft:
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import re, os
 from   bb.fetch2 import FetchMethod
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 4249e34c49..6a82da9d52 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -10,19 +10,6 @@ BitBake 'Fetch' implementation for svn.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import os
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 89dfd4a7b2..143db1b361 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -12,19 +12,6 @@ BitBake build tools.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import re
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 215c63ef9f..3c8746d2bd 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -11,18 +11,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import sys
diff --git a/lib/bb/methodpool.py b/lib/bb/methodpool.py
index 2f899098e6..2f383c229c 100644
--- a/lib/bb/methodpool.py
+++ b/lib/bb/methodpool.py
@@ -6,18 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from bb.utils import better_compile, better_exec
 
diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index c243add540..855452d2b4 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -6,18 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os, logging, re, sys
 import bb
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 64662079a4..a116444fa1 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -11,18 +11,6 @@ Message handling infrastructure for bitbake
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import sys
 import copy
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 8ff1b8a24a..76e180b411 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -11,20 +11,8 @@ File parsers for the BitBake build tools.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
+#
 
 handlers = []
 
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index cf76dadbaa..71ee49b8ce 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -10,19 +10,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
 
 import re
 import string
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 297ab77909..55fd1cb6c3 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -14,19 +14,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
 
 import re, bb, os
 import logging
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index d1784b6c5b..cc70da0db6 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -13,18 +13,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import errno
 import re
diff --git a/lib/bb/parse/parse_py/__init__.py b/lib/bb/parse/parse_py/__init__.py
index a8f78dba76..696c71b458 100644
--- a/lib/bb/parse/parse_py/__init__.py
+++ b/lib/bb/parse/parse_py/__init__.py
@@ -13,20 +13,8 @@ File parsers for the BitBake build tools.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
+#
 
 from __future__ import absolute_import
 from . import ConfHandler
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index cac56728a9..de8f87a8bf 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -10,18 +10,6 @@ currently, providing a key/value store accessed by 'domain'.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import collections
 import logging
diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index 00dddabbb8..e9b72e28b9 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -6,18 +6,6 @@ BitBake progress handling code
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import sys
 import re
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 856f0de76f..78445d6a72 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -10,18 +10,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import re
 import logging
diff --git a/lib/bb/remotedata.py b/lib/bb/remotedata.py
index 05c6fabdf8..7391e1b45c 100644
--- a/lib/bb/remotedata.py
+++ b/lib/bb/remotedata.py
@@ -8,18 +8,6 @@ Provides support for using a datastore from the bitbake client
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import bb.data
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ddd2fde0ac..3dfa391c31 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -11,18 +11,6 @@ Handles preparation and execution of a queue of tasks
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import copy
 import os
diff --git a/lib/bb/server/__init__.py b/lib/bb/server/__init__.py
index 5ec7a75601..b6f7513181 100644
--- a/lib/bb/server/__init__.py
+++ b/lib/bb/server/__init__.py
@@ -7,17 +7,3 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index bac94fcc2d..f901fe505a 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -5,18 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 """
     This module implements a multiprocessing.Process based server for bitbake.
diff --git a/lib/bb/server/xmlrpcclient.py b/lib/bb/server/xmlrpcclient.py
index fc2fddd54b..c054c3c89d 100644
--- a/lib/bb/server/xmlrpcclient.py
+++ b/lib/bb/server/xmlrpcclient.py
@@ -6,18 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import sys
diff --git a/lib/bb/server/xmlrpcserver.py b/lib/bb/server/xmlrpcserver.py
index b885f9a79c..54fa32f573 100644
--- a/lib/bb/server/xmlrpcserver.py
+++ b/lib/bb/server/xmlrpcserver.py
@@ -6,18 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import sys
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 5316d1b42f..5c49739da3 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -12,18 +12,6 @@ Task data collection and handling
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import logging
 import re
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index 00ee6de533..742ccc2c27 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -8,19 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 
 import unittest
 import logging
diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index 850dde4f6e..70b18598e1 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -5,19 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 
 import unittest
 import tempfile
diff --git a/lib/bb/tests/cow.py b/lib/bb/tests/cow.py
index 5051e4ed73..59ad242183 100644
--- a/lib/bb/tests/cow.py
+++ b/lib/bb/tests/cow.py
@@ -7,19 +7,6 @@
 #
 # Copyright 2006 Holger Freyther <freyther@handhelds.org>
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 
 import unittest
 import os
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index b584edee54..8bd472a8be 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -8,19 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 
 import unittest
 import bb
diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index 4822dc7bca..e6254c7a1e 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -7,19 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 
 import unittest
 import bb
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 559b4892e3..c0ee308e12 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -7,19 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 
 import unittest
 import hashlib
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 20d09c00a0..3875fbbd41 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -7,19 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 
 import unittest
 import tempfile
diff --git a/lib/bb/tests/persist_data.py b/lib/bb/tests/persist_data.py
index 6aee9f1ca8..dbb3ce183d 100644
--- a/lib/bb/tests/persist_data.py
+++ b/lib/bb/tests/persist_data.py
@@ -7,19 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 
 import unittest
 import bb.data
diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 13351068d7..1f01447bbb 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -7,19 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 
 import unittest
 import bb
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index da049b6e59..0a1b913055 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -6,18 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import logging
 import os
diff --git a/lib/bb/ui/__init__.py b/lib/bb/ui/__init__.py
index 669dc86fc3..4b7ac36ca6 100644
--- a/lib/bb/ui/__init__.py
+++ b/lib/bb/ui/__init__.py
@@ -5,15 +5,3 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 37b94cd071..f2151c2d47 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -5,18 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import sys
 import bb
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index cf1e59e463..3d9e2031b3 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -7,18 +7,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from __future__ import division
 
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index 713a4a4163..c422732b26 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 """
     We have the following windows:
diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 3ea0a242bf..50a943cd05 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -6,18 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import sys
 import gi
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index d2517edbb2..51892c9a09 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -9,18 +9,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from __future__ import division
 import time
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index e96454404b..7276bdaf9d 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -6,19 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
 
 """
 Use this class to fork off a thread to recieve event callbacks from the bitbake
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 000a7cf41f..45519c8afd 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -6,18 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import bb.build
 import time
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 69e01519b0..e438694082 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -8,18 +8,6 @@ BitBake Utility Functions
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import re, fcntl, os, string, stat, shutil, time
 import sys
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 6f4a046966..fdc9ced9f2 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -2,18 +2,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from http.server import BaseHTTPRequestHandler, HTTPServer
 import contextlib
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index b022195183..8300a25599 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -4,18 +4,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import unittest
 import threading
diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
index 2854f6d0da..d231cf6a99 100644
--- a/lib/layerindexlib/__init__.py
+++ b/lib/layerindexlib/__init__.py
@@ -2,18 +2,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-# See the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 
 import datetime
 
diff --git a/lib/layerindexlib/cooker.py b/lib/layerindexlib/cooker.py
index 87c7c8cc9a..604a9611dd 100644
--- a/lib/layerindexlib/cooker.py
+++ b/lib/layerindexlib/cooker.py
@@ -2,18 +2,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-# See the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 
 import logging
 import json
diff --git a/lib/layerindexlib/plugin.py b/lib/layerindexlib/plugin.py
index e7adae7ac0..7015a1af26 100644
--- a/lib/layerindexlib/plugin.py
+++ b/lib/layerindexlib/plugin.py
@@ -2,19 +2,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-# See the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
-
 # The file contains:
 #   LayerIndex exceptions
 #   Plugin base class
diff --git a/lib/layerindexlib/restapi.py b/lib/layerindexlib/restapi.py
index 89092fe34e..21fd144143 100644
--- a/lib/layerindexlib/restapi.py
+++ b/lib/layerindexlib/restapi.py
@@ -2,18 +2,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-# See the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 
 import logging
 import json
diff --git a/lib/layerindexlib/tests/common.py b/lib/layerindexlib/tests/common.py
index f4e04aacc1..077382f11d 100644
--- a/lib/layerindexlib/tests/common.py
+++ b/lib/layerindexlib/tests/common.py
@@ -2,18 +2,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-# See the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 
 import unittest
 import tempfile
diff --git a/lib/layerindexlib/tests/cooker.py b/lib/layerindexlib/tests/cooker.py
index 648c7ba9f4..1fa102e602 100644
--- a/lib/layerindexlib/tests/cooker.py
+++ b/lib/layerindexlib/tests/cooker.py
@@ -2,18 +2,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-# See the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 
 import unittest
 import tempfile
diff --git a/lib/layerindexlib/tests/layerindexobj.py b/lib/layerindexlib/tests/layerindexobj.py
index 7de1338d78..0c5ec8881b 100644
--- a/lib/layerindexlib/tests/layerindexobj.py
+++ b/lib/layerindexlib/tests/layerindexobj.py
@@ -2,18 +2,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-# See the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 
 import unittest
 import tempfile
diff --git a/lib/layerindexlib/tests/restapi.py b/lib/layerindexlib/tests/restapi.py
index fc4ff939bb..6d8dc0058e 100644
--- a/lib/layerindexlib/tests/restapi.py
+++ b/lib/layerindexlib/tests/restapi.py
@@ -2,18 +2,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-# See the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 
 import unittest
 import tempfile
diff --git a/lib/pyinotify.py b/lib/pyinotify.py
index 8fe4041fae..9dcfd0d2ee 100644
--- a/lib/pyinotify.py
+++ b/lib/pyinotify.py
@@ -5,23 +5,6 @@
 #
 # SPDX-License-Identifier: MIT
 #
-# Permission is hereby granted, free of charge, to any person obtaining a copy
-# of this software and associated documentation files (the "Software"), to deal
-# in the Software without restriction, including without limitation the rights
-# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-# copies of the Software, and to permit persons to whom the Software is
-# furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-# THE SOFTWARE.
 """
 pyinotify
 
diff --git a/lib/toaster/bldcollector/urls.py b/lib/toaster/bldcollector/urls.py
index 182a7a6159..8eb1e34a53 100644
--- a/lib/toaster/bldcollector/urls.py
+++ b/lib/toaster/bldcollector/urls.py
@@ -5,19 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
 
 from django.conf.urls import include, url
 
diff --git a/lib/toaster/bldcollector/views.py b/lib/toaster/bldcollector/views.py
index 132e44c681..c708b415e1 100644
--- a/lib/toaster/bldcollector/views.py
+++ b/lib/toaster/bldcollector/views.py
@@ -5,18 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.views.decorators.cache import cache_control
 from django.core.urlresolvers import reverse
diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index d182a36e9e..9b92207937 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -8,19 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
 
 import os
 import sys
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 4d4afafd4d..41e5629ae0 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -8,19 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
 
 import os
 import sys
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index b15b9ce4af..a6ab6e8046 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.management.base import BaseCommand
 
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 68ca0bcfed..7174e85582 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from __future__ import unicode_literals
 
diff --git a/lib/toaster/tests/browser/selenium_helpers.py b/lib/toaster/tests/browser/selenium_helpers.py
index 66e700c842..56621096b5 100644
--- a/lib/toaster/tests/browser/selenium_helpers.py
+++ b/lib/toaster/tests/browser/selenium_helpers.py
@@ -8,19 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # The Wait class and some of SeleniumDriverHelper and SeleniumTestCase are
 # modified from Patchwork, released under the same licence terms as Toaster:
 # https://github.com/dlespiau/patchwork/blob/master/patchwork/tests.browser.py
diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 48a0488e19..8c25740b64 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -8,19 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # The Wait class and some of SeleniumDriverHelper and SeleniumTestCase are
 # modified from Patchwork, released under the same licence terms as Toaster:
 # https://github.com/dlespiau/patchwork/blob/master/patchwork/tests.browser.py
diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toaster/tests/browser/test_all_builds_page.py
index bab44e9cc2..f895028686 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import re
 
diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/toaster/tests/browser/test_all_projects_page.py
index b0b3aec1fa..1c46258641 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import re
 
diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py b/lib/toaster/tests/browser/test_builddashboard_page.py
index 5d2dcd066b..350e5e0a95 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from django.utils import timezone
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
index f92b642e95..a4f2f0c71a 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from django.utils import timezone
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_recipes.py b/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
index 7f96288156..ebf1f99083 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from django.utils import timezone
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_tasks.py b/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
index d0c4ec33e5..c136fe3bf9 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from django.utils import timezone
diff --git a/lib/toaster/tests/browser/test_js_unit_tests.py b/lib/toaster/tests/browser/test_js_unit_tests.py
index ceea71342c..76c3495e8c 100644
--- a/lib/toaster/tests/browser/test_js_unit_tests.py
+++ b/lib/toaster/tests/browser/test_js_unit_tests.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 """
 Run the js unit tests
diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
index 06aa5693eb..85529b2921 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -8,18 +8,6 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from django.utils import timezone
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index a39bb9ac18..0a9fd85091 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -8,18 +8,6 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
diff --git a/lib/toaster/tests/browser/test_most_recent_builds_states.py b/lib/toaster/tests/browser/test_most_recent_builds_states.py
index 7d44638bc1..e2601017b1 100644
--- a/lib/toaster/tests/browser/test_most_recent_builds_states.py
+++ b/lib/toaster/tests/browser/test_most_recent_builds_states.py
@@ -8,18 +8,6 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from django.utils import timezone
diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/lib/toaster/tests/browser/test_new_custom_image_page.py
index f865e3272c..f2f5e7104e 100644
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toaster/tests/browser/test_new_project_page.py
index 92d414d8d6..d715d3a842 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
diff --git a/lib/toaster/tests/browser/test_project_builds_page.py b/lib/toaster/tests/browser/test_project_builds_page.py
index 2202d937d6..0a8a38b2c8 100644
--- a/lib/toaster/tests/browser/test_project_builds_page.py
+++ b/lib/toaster/tests/browser/test_project_builds_page.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import re
 
diff --git a/lib/toaster/tests/browser/test_project_config_page.py b/lib/toaster/tests/browser/test_project_config_page.py
index a0d5bcd348..5ae3a0a20c 100644
--- a/lib/toaster/tests/browser/test_project_config_page.py
+++ b/lib/toaster/tests/browser/test_project_config_page.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import re
 
diff --git a/lib/toaster/tests/browser/test_project_page.py b/lib/toaster/tests/browser/test_project_page.py
index 7b544ed966..aa984237fb 100644
--- a/lib/toaster/tests/browser/test_project_page.py
+++ b/lib/toaster/tests/browser/test_project_page.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from django.utils import timezone
diff --git a/lib/toaster/tests/browser/test_sample.py b/lib/toaster/tests/browser/test_sample.py
index 4cdd19f3d1..219f00cec4 100644
--- a/lib/toaster/tests/browser/test_sample.py
+++ b/lib/toaster/tests/browser/test_sample.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 """
 A small example test demonstrating the basics of writing a test with
diff --git a/lib/toaster/tests/browser/test_task_page.py b/lib/toaster/tests/browser/test_task_page.py
index 97708a765e..993f081d93 100644
--- a/lib/toaster/tests/browser/test_task_page.py
+++ b/lib/toaster/tests/browser/test_task_page.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.core.urlresolvers import reverse
 from django.utils import timezone
diff --git a/lib/toaster/tests/browser/test_toastertable_ui.py b/lib/toaster/tests/browser/test_toastertable_ui.py
index 0780ef9fe4..f22239c482 100644
--- a/lib/toaster/tests/browser/test_toastertable_ui.py
+++ b/lib/toaster/tests/browser/test_toastertable_ui.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from datetime import datetime
 
diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/builds/buildtest.py
index 129c9fe401..fce7b62144 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import sys
diff --git a/lib/toaster/tests/builds/test_core_image_min.py b/lib/toaster/tests/builds/test_core_image_min.py
index 8964071990..63f62c8e5a 100644
--- a/lib/toaster/tests/builds/test_core_image_min.py
+++ b/lib/toaster/tests/builds/test_core_image_min.py
@@ -8,19 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
 # Tests were part of openembedded-core oe selftest Authored by: Lucian Musat
 # Ionut Chisanovici, Paul Eggleton and Cristian Iorga
 
diff --git a/lib/toaster/tests/commands/test_loaddata.py b/lib/toaster/tests/commands/test_loaddata.py
index b4b53d0919..27a0eca8f3 100644
--- a/lib/toaster/tests/commands/test_loaddata.py
+++ b/lib/toaster/tests/commands/test_loaddata.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.test import TestCase
 from django.core import management
diff --git a/lib/toaster/tests/commands/test_lsupdates.py b/lib/toaster/tests/commands/test_lsupdates.py
index 2d34f211b9..854bb7ebab 100644
--- a/lib/toaster/tests/commands/test_lsupdates.py
+++ b/lib/toaster/tests/commands/test_lsupdates.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.test import TestCase
 from django.core import management
diff --git a/lib/toaster/tests/commands/test_runbuilds.py b/lib/toaster/tests/commands/test_runbuilds.py
index 2c9fcf0f20..3180e96dba 100644
--- a/lib/toaster/tests/commands/test_runbuilds.py
+++ b/lib/toaster/tests/commands/test_runbuilds.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 
diff --git a/lib/toaster/tests/eventreplay/__init__.py b/lib/toaster/tests/eventreplay/__init__.py
index f10ea89ae1..941531461c 100644
--- a/lib/toaster/tests/eventreplay/__init__.py
+++ b/lib/toaster/tests/eventreplay/__init__.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 # Tests were part of openembedded-core oe selftest Authored by: Lucian Musat
 # Ionut Chisanovici, Paul Eggleton and Cristian Iorga
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toaster/tests/functional/functional_helpers.py
index 8eb2e963f6..9de6fbcf04 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import os
 import logging
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
index 817bcde333..e58045d3e2 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import time
 import re
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/views/test_views.py
index d5b00288bd..f4273367cd 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 """Test cases for Toaster GUI and ReST."""
 
diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 99e9768ae7..8b49b3ee3f 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -5,19 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
 # Please run flake8 on this file before sending patches
 
 import os
diff --git a/lib/toaster/toastergui/buildtables.py b/lib/toaster/toastergui/buildtables.py
index 6a20d60752..4332107fc8 100644
--- a/lib/toaster/toastergui/buildtables.py
+++ b/lib/toaster/toastergui/buildtables.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from orm.models import Build, Task, Target, Package
 from django.db.models import Q, Sum
diff --git a/lib/toaster/toastergui/tablefilter.py b/lib/toaster/toastergui/tablefilter.py
index 1f9016beff..04220cf24d 100644
--- a/lib/toaster/toastergui/tablefilter.py
+++ b/lib/toaster/toastergui/tablefilter.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.db.models import Q, Max, Min
 from django.utils import dateparse, timezone
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 855861a869..a3de22a359 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from toastergui.widgets import ToasterTable
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 80652edd49..d2ee11d2f6 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from datetime import datetime, timedelta
 from os.path import relpath
diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
index 3921435584..fd750ffb74 100644
--- a/lib/toaster/toastergui/typeaheads.py
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -5,18 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import subprocess
 
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 3d0be61faa..673d9ae967 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -5,18 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.conf.urls import include, url
 from django.views.generic import RedirectView, TemplateView
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 6aad55b7c8..5ef4f40da7 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -8,19 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
 
 import re
 
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index e8aabdd9fa..fb03337498 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.views.generic import View, TemplateView
 from django.views.decorators.cache import cache_control
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index 2f99c6d556..a6340575a9 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 # buildimport: import a project for project specific configuration
 #
diff --git a/lib/toaster/toastermain/management/commands/checksocket.py b/lib/toaster/toastermain/management/commands/checksocket.py
index d9cdb555df..822373011c 100644
--- a/lib/toaster/toastermain/management/commands/checksocket.py
+++ b/lib/toaster/toastermain/management/commands/checksocket.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 """Custom management command checksocket."""
 
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 6373559190..457ed0da10 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 # Django settings for Toaster project.
 
diff --git a/lib/toaster/toastermain/settings_production_example.py b/lib/toaster/toastermain/settings_production_example.py
index 2067624358..d06841fcce 100644
--- a/lib/toaster/toastermain/settings_production_example.py
+++ b/lib/toaster/toastermain/settings_production_example.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 # See Django documentation for more information about deployment
 # https://docs.djangoproject.com/en/1.8/howto/deployment/checklist/
diff --git a/lib/toaster/toastermain/settings_test.py b/lib/toaster/toastermain/settings_test.py
index 963d77f280..599cc186a6 100644
--- a/lib/toaster/toastermain/settings_test.py
+++ b/lib/toaster/toastermain/settings_test.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 # Django settings for Toaster project.
 
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 1a98754ed4..d3a95923f5 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -8,18 +8,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.conf.urls import include, url
 from django.views.generic import RedirectView, TemplateView
-- 
2.20.1


