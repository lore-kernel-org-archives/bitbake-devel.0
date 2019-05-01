Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id F299B7D9CE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 11:19:06 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id l2so8611758wrb.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=KddPGwl468KW7aGDUuuh5QO4Cm/xaKr8T0a+u8yGLwg=;
	b=R05LQpdm6oD0DTmV9rTP+pzG2qYU87mvd1P3q/bNBQeS53nGuvqgLPq2woXV/4DosD
	39Oaq07eMqLPHYUGvYh2WKqWmYIU3SYy5wQddWsLpbCGzJZSPB8TxraQgEoqTdmKo5Oi
	dLBujwv6DT4arx+v829IqNjhaV2LeDwpp6Vn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=KddPGwl468KW7aGDUuuh5QO4Cm/xaKr8T0a+u8yGLwg=;
	b=d+0fRssAKB0umO9zsrLZUhNcWULXI1yrqyRfrbTzik4X7TM4jBQX5KdbwnklDJP6mP
	AkD4HnqIGO67UlxgCcesO+7hp8lKpRZ3IhZSRYfKhPOA3avCIiGdcUzlI1HFq0PvswFH
	hhyzSFp870PRI+6cpA1u7xW8Pr6VCGlDxa1wPFa0T4xSdF+a3FUsQ+TvvgN58jrleRxf
	SG2cr2Enw1tCWu6ID/DpN+99OlP0JZl9y+oHxljzxTTcga05w5F4mq5FAljSZ6Sid0ZU
	4EBYSmas4Uf5hR+HzjLUH8jP0jyTFTMVU+C5GiZcwL/tHzHM0ZzHhCl9fRLn1i+POT+N
	IpPQ==
X-Gm-Message-State: APjAAAWKP8Gfr/sLzGp0MkOQdR77nPVXc00fjboK+h94ciXK1ekSIIW0
	l4DlF0pL376hxkoWT43meKSpZVuRgsw=
X-Google-Smtp-Source: APXvYqyebqiadZvopw+GgR52KWXsYgZWJFs0HArakhuQHLLZ9t/U8f9itPGwyTElPEIhydU/fecfQw==
X-Received: by 2002:adf:8b0b:: with SMTP id n11mr10719419wra.149.1556709545828;
	Wed, 01 May 2019 04:19:05 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j10sm3494597wrb.0.2019.05.01.04.19.02
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 04:19:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 May 2019 12:18:56 +0100
Message-Id: <20190501111859.5699-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
References: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 01 May 2019 11:27:53 +0000
Subject: [PATCH 3/6] bitbake: Add initial pass of SPDX license headers to source code
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
X-List-Received-Date: Wed, 01 May 2019 11:19:07 -0000
Content-Transfer-Encoding: 8bit

This adds the SPDX-License-Identifier license headers to the majority of
our source files to make it clearer exactly which license files are under.

The bulk of the files are under GPL v2.0 with one found to be under V2.0
or later, some under MIT and some have dual license. There are some files
which are potentially harder to classify where we've imported upstream code
and those can be handled specifically in later commits.

The COPYING file is replaced with LICENSE.X files which contain the full
license texts.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 HEADER                                        |  2 +
 LICENSE                                       | 12 +++-
 COPYING => LICENSE.GPL-2.0-only               | 61 ++-----------------
 LICENSE.MIT                                   | 25 ++++++++
 MANIFEST.in                                   |  4 +-
 bin/bitbake                                   |  2 +
 bin/bitbake-diffsigs                          |  2 +
 bin/bitbake-hashserv                          |  2 +
 bin/bitbake-layers                            |  2 +
 bin/bitbake-prserv                            |  4 ++
 bin/bitbake-selftest                          |  2 +
 bin/bitbake-worker                            |  3 +
 bin/bitdoc                                    |  2 +
 bin/git-make-shallow                          |  4 ++
 bin/toaster                                   |  4 +-
 bin/toaster-eventreplay                       |  3 +-
 lib/bb/__init__.py                            |  2 +
 lib/bb/build.py                               |  2 +
 lib/bb/cache.py                               |  2 +
 lib/bb/cache_extra.py                         |  2 +
 lib/bb/checksum.py                            |  2 +
 lib/bb/codeparser.py                          |  4 ++
 lib/bb/command.py                             |  2 +
 lib/bb/compat.py                              |  4 ++
 lib/bb/cooker.py                              |  2 +
 lib/bb/cookerdata.py                          |  2 +
 lib/bb/daemonize.py                           |  4 ++
 lib/bb/data.py                                |  2 +
 lib/bb/data_smart.py                          |  2 +
 lib/bb/event.py                               |  2 +
 lib/bb/exceptions.py                          |  3 +
 lib/bb/fetch2/__init__.py                     |  2 +
 lib/bb/fetch2/bzr.py                          |  2 +
 lib/bb/fetch2/clearcase.py                    |  2 +
 lib/bb/fetch2/cvs.py                          |  2 +
 lib/bb/fetch2/git.py                          |  4 +-
 lib/bb/fetch2/gitannex.py                     |  2 +
 lib/bb/fetch2/gitsm.py                        |  2 +
 lib/bb/fetch2/hg.py                           |  2 +
 lib/bb/fetch2/local.py                        |  2 +
 lib/bb/fetch2/npm.py                          |  3 +
 lib/bb/fetch2/osc.py                          |  3 +
 lib/bb/fetch2/perforce.py                     |  2 +
 lib/bb/fetch2/repo.py                         |  2 +
 lib/bb/fetch2/s3.py                           |  2 +
 lib/bb/fetch2/sftp.py                         |  2 +
 lib/bb/fetch2/ssh.py                          |  2 +
 lib/bb/fetch2/svn.py                          |  2 +
 lib/bb/fetch2/wget.py                         |  2 +
 lib/bb/main.py                                |  2 +
 lib/bb/methodpool.py                          |  2 +
 lib/bb/monitordisk.py                         |  2 +
 lib/bb/msg.py                                 |  2 +
 lib/bb/namedtuple_with_abc.py                 |  3 +
 lib/bb/parse/__init__.py                      |  2 +
 lib/bb/parse/ast.py                           |  2 +
 lib/bb/parse/parse_py/BBHandler.py            |  2 +
 lib/bb/parse/parse_py/ConfHandler.py          |  2 +
 lib/bb/parse/parse_py/__init__.py             |  2 +
 lib/bb/persist_data.py                        |  2 +
 lib/bb/process.py                             |  4 ++
 lib/bb/progress.py                            |  2 +
 lib/bb/providers.py                           |  2 +
 lib/bb/remotedata.py                          |  2 +
 lib/bb/runqueue.py                            |  2 +
 lib/bb/server/__init__.py                     |  2 +
 lib/bb/server/process.py                      |  2 +
 lib/bb/server/xmlrpcclient.py                 |  2 +
 lib/bb/server/xmlrpcserver.py                 |  2 +
 lib/bb/siggen.py                              |  4 ++
 lib/bb/taskdata.py                            |  2 +
 lib/bb/tests/codeparser.py                    |  2 +
 lib/bb/tests/cooker.py                        |  2 +
 lib/bb/tests/cow.py                           |  2 +
 lib/bb/tests/data.py                          |  2 +
 lib/bb/tests/event.py                         |  2 +
 lib/bb/tests/fetch.py                         |  2 +
 lib/bb/tests/parse.py                         |  2 +
 lib/bb/tests/persist_data.py                  |  2 +
 lib/bb/tests/utils.py                         |  2 +
 lib/bb/tinfoil.py                             |  2 +
 lib/bb/ui/__init__.py                         |  2 +
 lib/bb/ui/buildinfohelper.py                  |  2 +
 lib/bb/ui/knotty.py                           |  2 +
 lib/bb/ui/ncurses.py                          |  2 +
 lib/bb/ui/taskexp.py                          |  2 +
 lib/bb/ui/toasterui.py                        |  2 +
 lib/bb/ui/uievent.py                          |  2 +
 lib/bb/ui/uihelper.py                         |  2 +
 lib/bb/utils.py                               |  2 +
 lib/bblayers/__init__.py                      |  4 ++
 lib/bblayers/action.py                        |  4 ++
 lib/bblayers/common.py                        |  4 ++
 lib/bblayers/layerindex.py                    |  4 ++
 lib/bblayers/query.py                         |  4 ++
 lib/hashserv/__init__.py                      |  2 +
 lib/hashserv/tests.py                         |  2 +
 lib/layerindexlib/__init__.py                 |  2 +
 lib/layerindexlib/cooker.py                   |  2 +
 lib/layerindexlib/plugin.py                   |  2 +
 lib/layerindexlib/restapi.py                  |  2 +
 lib/layerindexlib/tests/common.py             |  2 +
 lib/layerindexlib/tests/cooker.py             |  2 +
 lib/layerindexlib/tests/layerindexobj.py      |  2 +
 lib/layerindexlib/tests/restapi.py            |  2 +
 lib/progressbar/__init__.py                   |  2 +
 lib/progressbar/compat.py                     |  2 +
 lib/progressbar/progressbar.py                |  2 +
 lib/progressbar/widgets.py                    |  2 +
 lib/prserv/__init__.py                        |  4 ++
 lib/prserv/db.py                              |  4 ++
 lib/prserv/serv.py                            |  4 ++
 lib/pyinotify.py                              |  2 +
 lib/toaster/bldcollector/admin.py             |  4 ++
 lib/toaster/bldcollector/urls.py              |  2 +
 lib/toaster/bldcollector/views.py             |  2 +
 lib/toaster/bldcontrol/admin.py               |  4 ++
 lib/toaster/bldcontrol/bbcontroller.py        |  2 +
 .../bldcontrol/localhostbecontroller.py       |  2 +
 .../management/commands/checksettings.py      |  4 ++
 .../management/commands/runbuilds.py          |  4 ++
 lib/toaster/bldcontrol/models.py              |  4 ++
 lib/toaster/bldcontrol/views.py               |  4 ++
 lib/toaster/manage.py                         |  4 ++
 .../orm/management/commands/lsupdates.py      |  2 +
 lib/toaster/orm/models.py                     |  2 +
 lib/toaster/tests/browser/selenium_helpers.py |  2 +
 .../tests/browser/selenium_helpers_base.py    |  2 +
 .../tests/browser/test_all_builds_page.py     |  2 +
 .../tests/browser/test_all_projects_page.py   |  2 +
 .../tests/browser/test_builddashboard_page.py |  2 +
 .../test_builddashboard_page_artifacts.py     |  2 +
 .../test_builddashboard_page_recipes.py       |  2 +
 .../browser/test_builddashboard_page_tasks.py |  2 +
 .../tests/browser/test_js_unit_tests.py       |  2 +
 .../tests/browser/test_landing_page.py        |  2 +
 .../tests/browser/test_layerdetails_page.py   |  2 +
 .../browser/test_most_recent_builds_states.py |  2 +
 .../browser/test_new_custom_image_page.py     |  2 +
 .../tests/browser/test_new_project_page.py    |  2 +
 .../tests/browser/test_project_builds_page.py |  2 +
 .../tests/browser/test_project_config_page.py |  2 +
 .../tests/browser/test_project_page.py        |  2 +
 lib/toaster/tests/browser/test_sample.py      |  2 +
 lib/toaster/tests/browser/test_task_page.py   |  2 +
 .../tests/browser/test_toastertable_ui.py     |  2 +
 lib/toaster/tests/builds/buildtest.py         |  2 +
 .../tests/builds/test_core_image_min.py       |  2 +
 lib/toaster/tests/commands/test_loaddata.py   |  2 +
 lib/toaster/tests/commands/test_lsupdates.py  |  2 +
 lib/toaster/tests/commands/test_runbuilds.py  |  2 +
 lib/toaster/tests/db/test_db.py               |  2 +
 lib/toaster/tests/eventreplay/__init__.py     |  2 +
 .../tests/functional/functional_helpers.py    |  2 +
 .../tests/functional/test_functional_basic.py |  2 +
 lib/toaster/tests/views/test_views.py         |  2 +
 lib/toaster/toastergui/api.py                 |  2 +
 lib/toaster/toastergui/buildtables.py         |  2 +
 lib/toaster/toastergui/tablefilter.py         |  2 +
 lib/toaster/toastergui/tables.py              |  2 +
 .../templatetags/field_values_filter.py       |  4 ++
 .../objects_to_dictionaries_filter.py         |  4 ++
 .../templatetags/project_url_tag.py           |  4 ++
 .../toastergui/templatetags/projecttags.py    |  2 +
 lib/toaster/toastergui/typeaheads.py          |  2 +
 lib/toaster/toastergui/urls.py                |  2 +
 lib/toaster/toastergui/views.py               |  2 +
 lib/toaster/toastergui/widgets.py             |  2 +
 .../management/commands/builddelete.py        |  4 ++
 .../management/commands/buildimport.py        |  2 +
 .../management/commands/buildslist.py         |  4 ++
 .../management/commands/checksocket.py        |  2 +
 .../toastermain/management/commands/perf.py   |  4 ++
 lib/toaster/toastermain/settings.py           |  2 +
 .../settings_production_example.py            |  2 +
 lib/toaster/toastermain/settings_test.py      |  2 +
 lib/toaster/toastermain/urls.py               |  2 +
 lib/toaster/toastermain/wsgi.py               |  4 ++
 178 files changed, 457 insertions(+), 61 deletions(-)
 rename COPYING => LICENSE.GPL-2.0-only (84%)
 create mode 100644 LICENSE.MIT

diff --git a/HEADER b/HEADER
index 9859255df3..113872d469 100644
--- a/HEADER
+++ b/HEADER
@@ -4,6 +4,8 @@
 # <one line to give the program's name and a brief idea of what it does.>
 # Copyright (C) <year>  <name of author>
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/LICENSE b/LICENSE
index 7d4e5f44b5..8206c3ac71 100644
--- a/LICENSE
+++ b/LICENSE
@@ -1,4 +1,13 @@
-BitBake is licensed under the GNU General Public License version 2.0. See COPYING for further details.
+BitBake is licensed under the GNU General Public License version 2.0. See 
+COPYING.GPL-2.0-only for further details.
+
+Individual files contain the following style tags instead of the full license text:
+
+    SPDX-License-Identifier:	GPL-2.0-only
+
+This enables machine processing of license information based on the SPDX
+License Identifiers that are here available: http://spdx.org/licenses/
+
 
 The following external components are distributed with this software:
 
@@ -17,3 +26,4 @@ Foundation and individual contributors.
 * Font Awesome fonts redistributed under the SIL Open Font License 1.1
 
 * simplediff is distributed under the zlib license.
+
diff --git a/COPYING b/LICENSE.GPL-2.0-only
similarity index 84%
rename from COPYING
rename to LICENSE.GPL-2.0-only
index d511905c16..5db3c0a21c 100644
--- a/COPYING
+++ b/LICENSE.GPL-2.0-only
@@ -279,61 +279,10 @@ POSSIBILITY OF SUCH DAMAGES.
 
 		     END OF TERMS AND CONDITIONS
 
-	    How to Apply These Terms to Your New Programs
+Note:
+Individual files contain the following tag instead of the full license text.
 
-  If you develop a new program, and you want it to be of the greatest
-possible use to the public, the best way to achieve this is to make it
-free software which everyone can redistribute and change under these terms.
+    SPDX-License-Identifier: GPL-2.0-only
 
-  To do so, attach the following notices to the program.  It is safest
-to attach them to the start of each source file to most effectively
-convey the exclusion of warranty; and each file should have at least
-the "copyright" line and a pointer to where the full notice is found.
-
-    <one line to give the program's name and a brief idea of what it does.>
-    Copyright (C) <year>  <name of author>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License along
-    with this program; if not, write to the Free Software Foundation, Inc.,
-    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-Also add information on how to contact you by electronic and paper mail.
-
-If the program is interactive, make it output a short notice like this
-when it starts in an interactive mode:
-
-    Gnomovision version 69, Copyright (C) year name of author
-    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
-    This is free software, and you are welcome to redistribute it
-    under certain conditions; type `show c' for details.
-
-The hypothetical commands `show w' and `show c' should show the appropriate
-parts of the General Public License.  Of course, the commands you use may
-be called something other than `show w' and `show c'; they could even be
-mouse-clicks or menu items--whatever suits your program.
-
-You should also get your employer (if you work as a programmer) or your
-school, if any, to sign a "copyright disclaimer" for the program, if
-necessary.  Here is a sample; alter the names:
-
-  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
-  `Gnomovision' (which makes passes at compilers) written by James Hacker.
-
-  <signature of Ty Coon>, 1 April 1989
-  Ty Coon, President of Vice
-
-This General Public License does not permit incorporating your program into
-proprietary programs.  If your program is a subroutine library, you may
-consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Lesser General
-Public License instead of this License.
+This enables machine processing of license information based on the SPDX
+License Identifiers that are here available: http://spdx.org/licenses/
diff --git a/LICENSE.MIT b/LICENSE.MIT
new file mode 100644
index 0000000000..a6919eb7e1
--- /dev/null
+++ b/LICENSE.MIT
@@ -0,0 +1,25 @@
+Permission is hereby granted, free of charge, to any person obtaining a copy
+of this software and associated documentation files (the "Software"), to deal
+in the Software without restriction, including without limitation the rights
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+copies of the Software, and to permit persons to whom the Software is
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+SOFTWARE.
+
+Note:
+Individual files contain the following tag instead of the full license text.
+
+    SPDX-License-Identifier: MIT
+
+This enables machine processing of license information based on the SPDX
+License Identifiers that are here available: http://spdx.org/licenses/
diff --git a/MANIFEST.in b/MANIFEST.in
index b197378120..82552390b4 100644
--- a/MANIFEST.in
+++ b/MANIFEST.in
@@ -1,6 +1,8 @@
-include COPYING
 include ChangeLog
 include AUTHORS
+include LICENSE
+include LICENSE.GPL-2.0-only
+include LICENSE.MIT
 include contrib/*
 include contrib/vim/*/*
 include conf/*
diff --git a/bin/bitbake b/bin/bitbake
index 716cb55546..0205b67f99 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -9,6 +9,8 @@
 # Copyright (C) 2005        ROAD GmbH
 # Copyright (C) 2006        Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 73229b7735..de4e3786e9 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -5,6 +5,8 @@
 #
 # Copyright (C) 2012-2013, 2017 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index c49397b73a..924e602592 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -2,6 +2,8 @@
 #
 # Copyright (C) 2018 Garmin Ltd.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index d184011ea6..da52990515 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -7,6 +7,8 @@
 # Copyright (C) 2011 Mentor Graphics Corporation
 # Copyright (C) 2011-2015 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index f38d2dd882..1e9b6cbc1b 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -1,4 +1,8 @@
 #!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 import os
 import sys,logging
 import optparse
diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 99f1af910f..5b2a5e1d15 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -2,6 +2,8 @@
 #
 # Copyright (C) 2012 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index a9e997e1f6..f63f060c57 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -1,4 +1,7 @@
 #!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
 
 import os
 import sys
diff --git a/bin/bitdoc b/bin/bitdoc
index 2744678824..cfe54a9236 100755
--- a/bin/bitdoc
+++ b/bin/bitdoc
@@ -4,6 +4,8 @@
 #
 # Copyright (C) 2005 Holger Hans Peter Freyther
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/bin/git-make-shallow b/bin/git-make-shallow
index 296d3a3dbd..57069f7edf 100755
--- a/bin/git-make-shallow
+++ b/bin/git-make-shallow
@@ -1,4 +1,8 @@
 #!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 """git-make-shallow: make the current git repository shallow
 
 Remove the history of the specified revisions, then optionally filter the
diff --git a/bin/toaster b/bin/toaster
index ecf66fa51f..9da2a2649c 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -3,7 +3,9 @@
 # toaster - shell script to start Toaster
 
 # Copyright (C) 2013-2015 Intel Corp.
-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index 80967a0934..abd91fe8b2 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -4,10 +4,11 @@
 #
 # Copyright (C) 2014        Alex Damian
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This file re-uses code spread throughout other Bitbake source files.
 # As such, all other copyrights belong to their own right holders.
 #
-#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 8d0cef0d69..b013cbb896 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -8,6 +8,8 @@
 #
 # Based on Gentoo's portage.py.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/build.py b/lib/bb/build.py
index 8ad9f5de2a..ca41632ff6 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -10,6 +10,8 @@
 #
 # Based on Gentoo's portage.py.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 65c514b908..42193dc9d6 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -15,6 +15,8 @@
 # Copyright (C) 2005        Holger Hans Peter Freyther
 # Copyright (C) 2005        ROAD GmbH
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/cache_extra.py b/lib/bb/cache_extra.py
index 83f4959d6c..108d55d16f 100644
--- a/lib/bb/cache_extra.py
+++ b/lib/bb/cache_extra.py
@@ -12,6 +12,8 @@
 
 # Copyright (C) 2011, Intel Corporation. All rights reserved.
 
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 4e1598fe83..9ac07a6a84 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -2,6 +2,8 @@
 #
 # Copyright (C) 2012 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index ac995a6a1d..fd2c4734f0 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 """
 BitBake code parser
 
diff --git a/lib/bb/command.py b/lib/bb/command.py
index 6c966e3dbc..9ebaac643a 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -6,6 +6,8 @@ Provide an interface to interact with the bitbake server through 'commands'
 
 # Copyright (C) 2006-2007  Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/compat.py b/lib/bb/compat.py
index de1923d28a..49356681ab 100644
--- a/lib/bb/compat.py
+++ b/lib/bb/compat.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 """Code pulled from future python versions, here for compatibility"""
 
 from collections import MutableMapping, KeysView, ValuesView, ItemsView, OrderedDict
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9ccaa79f57..fe812653fa 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -9,6 +9,8 @@
 # Copyright (C) 2005        ROAD GmbH
 # Copyright (C) 2006 - 2007 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 09412e28cf..3b074b2f3a 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -9,6 +9,8 @@
 # Copyright (C) 2005        ROAD GmbH
 # Copyright (C) 2006        Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index c937675eb6..f01e6ec7cc 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 """
 Python Daemonizing helper
 
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 29c2388038..ba50b9ff1b 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -22,6 +22,8 @@ the speed is more critical here.
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2005        Holger Hans Peter Freyther
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 07db7be97a..441bb3001b 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -14,6 +14,8 @@ BitBake build tools.
 # Copyright (C) 2005        Uli Luckas
 # Copyright (C) 2005        ROAD GmbH
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 5b1b094a80..48f8e73847 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -9,6 +9,8 @@ BitBake build tools.
 
 # Copyright (C) 2003, 2004  Chris Larson
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/exceptions.py b/lib/bb/exceptions.py
index cd713439ea..ecbad59970 100644
--- a/lib/bb/exceptions.py
+++ b/lib/bb/exceptions.py
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
 
 import inspect
 import traceback
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 8fecc809d4..c92844da5c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -10,6 +10,8 @@ BitBake build tools.
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2012  Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index 658502f9a6..891fef9b9d 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -10,6 +10,8 @@ BitBake 'Fetch' implementation for bzr.
 #   BitBake build tools.
 #   Copyright (C) 2003, 2004  Chris Larson
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 3a6573d0b2..ff181bb78b 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -47,6 +47,8 @@ User credentials:
 """
 # Copyright (C) 2014 Siemens AG
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/cvs.py b/lib/bb/fetch2/cvs.py
index 0e0a3196f8..666f4be2bc 100644
--- a/lib/bb/fetch2/cvs.py
+++ b/lib/bb/fetch2/cvs.py
@@ -10,6 +10,8 @@ BitBake build tools.
 
 # Copyright (C) 2003, 2004  Chris Larson
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index c69d25c914..78ad18cc7a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -55,7 +55,9 @@ Supported SRC_URI options are:
 
 """
 
-#Copyright (C) 2005 Richard Purdie
+# Copyright (C) 2005 Richard Purdie
+#
+# SPDX-License-Identifier: GPL-2.0-only
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index a9b69caab4..3a32c85a83 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -7,6 +7,8 @@ BitBake 'Fetch' git annex implementation
 # Copyright (C) 2014 Otavio Salvador
 # Copyright (C) 2014 O.S. Systems Software LTDA.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 32389130bd..e910a08390 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -16,6 +16,8 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your r
 
 # Copyright (C) 2013 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 5a2985e16c..c9eeaaefca 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -13,6 +13,8 @@ BitBake 'Fetch' implementation for mercurial DRCS (hg).
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index a114ac12e5..13e6d80b5b 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -10,6 +10,8 @@ BitBake build tools.
 
 # Copyright (C) 2003, 2004  Chris Larson
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 65bf5a3644..7235f899f4 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 6c60456b53..19c0d9dcaa 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 903a8e61ae..366da99eab 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -8,6 +8,8 @@ BitBake 'Fetch' implementation for perforce
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2016 Kodak Alaris, Inc.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 8c7e81853a..066ab08fc3 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -10,6 +10,8 @@ BitBake "Fetch" repo (git) implementation
 # Based on git.py which is:
 #Copyright (C) 2005 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 1629288622..fae7c8b0f0 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -13,6 +13,8 @@ The aws tool must be correctly installed and configured prior to use.
 # Based in part on bb.fetch2.wget:
 #    Copyright (C) 2003, 2004  Chris Larson
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 81884a6aa4..6dea6ad6b2 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -44,6 +44,8 @@ SRC_URI = "sftp://user@host.example.com/dir/path.file.txt"
 # Based in part on bb.fetch2.wget:
 #    Copyright (C) 2003, 2004  Chris Larson
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 6047ee417a..d416a9db87 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -29,6 +29,8 @@ IETF secsh internet draft:
 #            Copyright 2003 Holger Schurig
 #
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 9dcf3eb090..4249e34c49 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -8,6 +8,8 @@ BitBake 'Fetch' implementation for svn.
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2004        Marcin Juszkiewicz
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 3bb3e3bb0c..89dfd4a7b2 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -10,6 +10,8 @@ BitBake build tools.
 
 # Copyright (C) 2003, 2004  Chris Larson
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 41dd3b9e03..215c63ef9f 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -9,6 +9,8 @@
 # Copyright (C) 2005        ROAD GmbH
 # Copyright (C) 2006        Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/methodpool.py b/lib/bb/methodpool.py
index 49aed3338b..2f899098e6 100644
--- a/lib/bb/methodpool.py
+++ b/lib/bb/methodpool.py
@@ -4,6 +4,8 @@
 #
 # Copyright (C)       2006 Holger Hans Peter Freyther
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 2ad1e61562..c243add540 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -4,6 +4,8 @@
 #
 # Copyright (C) 2012 Robert Yang
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 96f077ec49..64662079a4 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -9,6 +9,8 @@ Message handling infrastructure for bitbake
 
 # Copyright (C) 2006        Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/namedtuple_with_abc.py b/lib/bb/namedtuple_with_abc.py
index 32f2fc642c..c8e1d55c15 100644
--- a/lib/bb/namedtuple_with_abc.py
+++ b/lib/bb/namedtuple_with_abc.py
@@ -1,6 +1,9 @@
 # http://code.activestate.com/recipes/577629-namedtupleabc-abstract-base-class-mix-in-for-named/
 #!/usr/bin/env python
 # Copyright (c) 2011 Jan Kaliszewski (zuo). Available under the MIT License.
+#
+# SPDX-License-Identifier: MIT
+#
 
 """
 namedtuple_with_abc.py:
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 5397d57a51..8ff1b8a24a 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -9,6 +9,8 @@ File parsers for the BitBake build tools.
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 6d7c80b34f..cf76dadbaa 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -8,6 +8,8 @@
 # Copyright (C) 2003, 2004 Phil Blundell
 # Copyright (C) 2009 Holger Hans Peter Freyther
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 314e8021f9..297ab77909 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -12,6 +12,8 @@
 #  Copyright (C) 2003, 2004  Chris Larson
 #  Copyright (C) 2003, 2004  Phil Blundell
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index ea49f8ca93..d1784b6c5b 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -11,6 +11,8 @@
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/parse/parse_py/__init__.py b/lib/bb/parse/parse_py/__init__.py
index 3e658d0de9..a8f78dba76 100644
--- a/lib/bb/parse/parse_py/__init__.py
+++ b/lib/bb/parse/parse_py/__init__.py
@@ -11,6 +11,8 @@ File parsers for the BitBake build tools.
 # Copyright (C) 2003, 2004  Chris Larson
 # Copyright (C) 2003, 2004  Phil Blundell
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index 0d44100f10..cac56728a9 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -8,6 +8,8 @@ currently, providing a key/value store accessed by 'domain'.
 # Copyright (C) 2007        Richard Purdie
 # Copyright (C) 2010        Chris Larson <chris_larson@mentor.com>
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/process.py b/lib/bb/process.py
index e69697cb68..2dc472a86f 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 import logging
 import signal
 import subprocess
diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index f54d1c76f8..00dddabbb8 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -4,6 +4,8 @@ BitBake progress handling code
 
 # Copyright (C) 2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index f496d84d12..856f0de76f 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -8,6 +8,8 @@
 # Copyright (C) 2005        ROAD GmbH
 # Copyright (C) 2006        Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/remotedata.py b/lib/bb/remotedata.py
index 68ecffc198..05c6fabdf8 100644
--- a/lib/bb/remotedata.py
+++ b/lib/bb/remotedata.py
@@ -6,6 +6,8 @@ Provides support for using a datastore from the bitbake client
 
 # Copyright (C) 2016  Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 524c85d7d3..ddd2fde0ac 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -9,6 +9,8 @@ Handles preparation and execution of a queue of tasks
 
 # Copyright (C) 2006-2007  Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/server/__init__.py b/lib/bb/server/__init__.py
index 5a3fba968f..5ec7a75601 100644
--- a/lib/bb/server/__init__.py
+++ b/lib/bb/server/__init__.py
@@ -5,6 +5,8 @@
 # Copyright (C) 2006 - 2008  Richard Purdie
 # Copyright (C) 2013         Alexandru Damian
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 80a7875ad9..bac94fcc2d 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -3,6 +3,8 @@
 #
 # Copyright (C) 2010 Bob Foerster <robert@erafx.com>
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/server/xmlrpcclient.py b/lib/bb/server/xmlrpcclient.py
index 4661a9e5a0..fc2fddd54b 100644
--- a/lib/bb/server/xmlrpcclient.py
+++ b/lib/bb/server/xmlrpcclient.py
@@ -4,6 +4,8 @@
 # Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
 # Copyright (C) 2006 - 2008  Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/server/xmlrpcserver.py b/lib/bb/server/xmlrpcserver.py
index 875b1282e5..b885f9a79c 100644
--- a/lib/bb/server/xmlrpcserver.py
+++ b/lib/bb/server/xmlrpcserver.py
@@ -4,6 +4,8 @@
 # Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
 # Copyright (C) 2006 - 2008  Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 7b9f3debc2..e0a66e68d5 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 import hashlib
 import logging
 import os
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 94e822c485..5316d1b42f 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -10,6 +10,8 @@ Task data collection and handling
 
 # Copyright (C) 2006  Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index 3fd76a8f9f..00ee6de533 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -6,6 +6,8 @@
 # Copyright (C) 2010 Chris Larson
 # Copyright (C) 2012 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index 2b44236506..850dde4f6e 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -3,6 +3,8 @@
 #
 # BitBake Tests for cooker.py
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/tests/cow.py b/lib/bb/tests/cow.py
index d149d84d0d..5051e4ed73 100644
--- a/lib/bb/tests/cow.py
+++ b/lib/bb/tests/cow.py
@@ -3,6 +3,8 @@
 #
 # BitBake Tests for Copy-on-Write (cow.py)
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # Copyright 2006 Holger Freyther <freyther@handhelds.org>
 #
 # This program is free software; you can redistribute it and/or modify
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 3c511f214b..b584edee54 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -6,6 +6,8 @@
 # Copyright (C) 2010 Chris Larson
 # Copyright (C) 2012 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index d3a5f6269f..4822dc7bca 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -5,6 +5,8 @@
 #
 # Copyright (C) 2017 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 429998b34f..559b4892e3 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -5,6 +5,8 @@
 #
 # Copyright (C) 2012 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 4467d17997..20d09c00a0 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -5,6 +5,8 @@
 #
 # Copyright (C) 2015 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/tests/persist_data.py b/lib/bb/tests/persist_data.py
index 812bcbd7b8..6aee9f1ca8 100644
--- a/lib/bb/tests/persist_data.py
+++ b/lib/bb/tests/persist_data.py
@@ -5,6 +5,8 @@
 #
 # Copyright (C) 2018 Garmin Ltd.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index f1cd83a419..13351068d7 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -5,6 +5,8 @@
 #
 # Copyright (C) 2012 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 368264f39a..da049b6e59 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -4,6 +4,8 @@
 # Copyright (C) 2011 Mentor Graphics Corporation
 # Copyright (C) 2006-2012 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/ui/__init__.py b/lib/bb/ui/__init__.py
index a4805ed028..669dc86fc3 100644
--- a/lib/bb/ui/__init__.py
+++ b/lib/bb/ui/__init__.py
@@ -3,6 +3,8 @@
 #
 # Copyright (C) 2006-2007 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 31323d281f..37b94cd071 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -3,6 +3,8 @@
 #
 # Copyright (C) 2013        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 4567c148c8..cf1e59e463 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -5,6 +5,8 @@
 #
 # Copyright (C) 2006-2012 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index 8690c529cc..713a4a4163 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -6,6 +6,8 @@
 # Copyright (C) 2006 Michael 'Mickey' Lauer
 # Copyright (C) 2006-2007 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 8305d70f41..3ea0a242bf 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -4,6 +4,8 @@
 # Copyright (C) 2007        Ross Burton
 # Copyright (C) 2007 - 2008 Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 88cec37592..d2517edbb2 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -7,6 +7,8 @@
 # Copyright (C) 2006-2012 Richard Purdie
 # Copyright (C) 2013      Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index 9542b911ca..e96454404b 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -4,6 +4,8 @@
 # Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
 # Copyright (C) 2006 - 2007  Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 963c1ea2df..000a7cf41f 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -4,6 +4,8 @@
 # Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
 # Copyright (C) 2006 - 2007  Richard Purdie
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index a3f75fbe9d..69e01519b0 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -6,6 +6,8 @@ BitBake Utility Functions
 
 # Copyright (C) 2004 Michael Lauer
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/bblayers/__init__.py b/lib/bblayers/__init__.py
index 3ad9513f40..4e7c09da04 100644
--- a/lib/bblayers/__init__.py
+++ b/lib/bblayers/__init__.py
@@ -1,2 +1,6 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from pkgutil import extend_path
 __path__ = extend_path(__path__, __name__)
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index a3f658f931..d6459d6617 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 import fnmatch
 import logging
 import os
diff --git a/lib/bblayers/common.py b/lib/bblayers/common.py
index 98515ced4f..c5657d3819 100644
--- a/lib/bblayers/common.py
+++ b/lib/bblayers/common.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 import argparse
 import logging
 import os
diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index b2ff2268ea..57cd9027f6 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 import layerindexlib
 
 import argparse
diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index 9294dfa884..993589de94 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 import collections
 import fnmatch
 import logging
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 46bca7cab3..6f4a046966 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -1,5 +1,7 @@
 # Copyright (C) 2018 Garmin Ltd.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 806b54c5eb..b022195183 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -2,6 +2,8 @@
 #
 # Copyright (C) 2018 Garmin Ltd.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
index cb79cb37d7..2854f6d0da 100644
--- a/lib/layerindexlib/__init__.py
+++ b/lib/layerindexlib/__init__.py
@@ -1,5 +1,7 @@
 # Copyright (C) 2016-2018 Wind River Systems, Inc.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/layerindexlib/cooker.py b/lib/layerindexlib/cooker.py
index 848f0e2ee2..87c7c8cc9a 100644
--- a/lib/layerindexlib/cooker.py
+++ b/lib/layerindexlib/cooker.py
@@ -1,5 +1,7 @@
 # Copyright (C) 2016-2018 Wind River Systems, Inc.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/layerindexlib/plugin.py b/lib/layerindexlib/plugin.py
index 92a2e978ba..e7adae7ac0 100644
--- a/lib/layerindexlib/plugin.py
+++ b/lib/layerindexlib/plugin.py
@@ -1,5 +1,7 @@
 # Copyright (C) 2016-2018 Wind River Systems, Inc.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/layerindexlib/restapi.py b/lib/layerindexlib/restapi.py
index d08eb20555..89092fe34e 100644
--- a/lib/layerindexlib/restapi.py
+++ b/lib/layerindexlib/restapi.py
@@ -1,5 +1,7 @@
 # Copyright (C) 2016-2018 Wind River Systems, Inc.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/layerindexlib/tests/common.py b/lib/layerindexlib/tests/common.py
index 22a54585c8..f4e04aacc1 100644
--- a/lib/layerindexlib/tests/common.py
+++ b/lib/layerindexlib/tests/common.py
@@ -1,5 +1,7 @@
 # Copyright (C) 2017-2018 Wind River Systems, Inc.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/layerindexlib/tests/cooker.py b/lib/layerindexlib/tests/cooker.py
index fdbf091103..648c7ba9f4 100644
--- a/lib/layerindexlib/tests/cooker.py
+++ b/lib/layerindexlib/tests/cooker.py
@@ -1,5 +1,7 @@
 # Copyright (C) 2018 Wind River Systems, Inc.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/layerindexlib/tests/layerindexobj.py b/lib/layerindexlib/tests/layerindexobj.py
index e2fbb950b0..7de1338d78 100644
--- a/lib/layerindexlib/tests/layerindexobj.py
+++ b/lib/layerindexlib/tests/layerindexobj.py
@@ -1,5 +1,7 @@
 # Copyright (C) 2017-2018 Wind River Systems, Inc.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/layerindexlib/tests/restapi.py b/lib/layerindexlib/tests/restapi.py
index 58766950ce..fc4ff939bb 100644
--- a/lib/layerindexlib/tests/restapi.py
+++ b/lib/layerindexlib/tests/restapi.py
@@ -1,5 +1,7 @@
 # Copyright (C) 2017-2018 Wind River Systems, Inc.
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/progressbar/__init__.py b/lib/progressbar/__init__.py
index fbab744ee2..c545a62754 100644
--- a/lib/progressbar/__init__.py
+++ b/lib/progressbar/__init__.py
@@ -4,6 +4,8 @@
 # progressbar  - Text progress bar library for Python.
 # Copyright (c) 2005 Nilton Volpato
 #
+# SPDX-License-Identifier: LGPL-2.1-or-later OR BSD-3-Clause-Clear
+#
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
diff --git a/lib/progressbar/compat.py b/lib/progressbar/compat.py
index a39f4a1f4e..9804e0b512 100644
--- a/lib/progressbar/compat.py
+++ b/lib/progressbar/compat.py
@@ -3,6 +3,8 @@
 # progressbar  - Text progress bar library for Python.
 # Copyright (c) 2005 Nilton Volpato
 #
+# SPDX-License-Identifier: LGPL-2.1-or-later OR BSD-3-Clause-Clear
+#
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
diff --git a/lib/progressbar/progressbar.py b/lib/progressbar/progressbar.py
index 2873ad6cae..e2b6ba1083 100644
--- a/lib/progressbar/progressbar.py
+++ b/lib/progressbar/progressbar.py
@@ -5,6 +5,8 @@
 #
 # (With some small changes after importing into BitBake)
 #
+# SPDX-License-Identifier: LGPL-2.1-or-later OR BSD-3-Clause-Clear
+#
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
diff --git a/lib/progressbar/widgets.py b/lib/progressbar/widgets.py
index 77285ca7a3..0772aa536d 100644
--- a/lib/progressbar/widgets.py
+++ b/lib/progressbar/widgets.py
@@ -3,6 +3,8 @@
 # progressbar  - Text progress bar library for Python.
 # Copyright (c) 2005 Nilton Volpato
 #
+# SPDX-License-Identifier: LGPL-2.1-or-later OR BSD-3-Clause-Clear
+#
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
index c3cb73ad92..9961040b58 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 __version__ = "1.0.0"
 
 import os, time
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 495d09f39b..d6188a679b 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 import logging
 import os.path
 import errno
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 6a99728c4f..be3acec36a 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 import os,sys,logging
 import signal, time
 from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
diff --git a/lib/pyinotify.py b/lib/pyinotify.py
index 4eb03b092d..8fe4041fae 100644
--- a/lib/pyinotify.py
+++ b/lib/pyinotify.py
@@ -3,6 +3,8 @@
 # pyinotify.py - python interface to inotify
 # Copyright (c) 2005-2015 Sebastien Martini <seb@dbzteam.org>
 #
+# SPDX-License-Identifier: MIT
+#
 # Permission is hereby granted, free of charge, to any person obtaining a copy
 # of this software and associated documentation files (the "Software"), to deal
 # in the Software without restriction, including without limitation the rights
diff --git a/lib/toaster/bldcollector/admin.py b/lib/toaster/bldcollector/admin.py
index 1f2e07f50b..feaa888c73 100644
--- a/lib/toaster/bldcollector/admin.py
+++ b/lib/toaster/bldcollector/admin.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from django.contrib import admin
 from orm.models import BitbakeVersion, Release, ToasterSetting, Layer_Version
 from django import forms
diff --git a/lib/toaster/bldcollector/urls.py b/lib/toaster/bldcollector/urls.py
index 888175d0ab..182a7a6159 100644
--- a/lib/toaster/bldcollector/urls.py
+++ b/lib/toaster/bldcollector/urls.py
@@ -3,6 +3,8 @@
 #
 # Copyright (C) 2014-2017   Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/bldcollector/views.py b/lib/toaster/bldcollector/views.py
index f32fa4d225..132e44c681 100644
--- a/lib/toaster/bldcollector/views.py
+++ b/lib/toaster/bldcollector/views.py
@@ -3,6 +3,8 @@
 #
 # Copyright (C) 2014        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/bldcontrol/admin.py b/lib/toaster/bldcontrol/admin.py
index fcbe5f5935..e85c30ed11 100644
--- a/lib/toaster/bldcontrol/admin.py
+++ b/lib/toaster/bldcontrol/admin.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from django.contrib import admin
 from django.contrib.admin.filters import RelatedFieldListFilter
 from .models import BuildEnvironment
diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 5195600d90..d182a36e9e 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2014        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 9490635934..4d4afafd4d 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2014        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 14298d9daf..fe2c4dc2bb 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from django.core.management.base import BaseCommand, CommandError
 from django.db import transaction
 
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 6a55dd46c8..50ec409860 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from django.core.management.base import BaseCommand
 from django.db import transaction
 from django.db.models import Q
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index 409614b9e7..bcffcf5e20 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from __future__ import unicode_literals
 from django.db import models
 from django.core.validators import MaxValueValidator, MinValueValidator
diff --git a/lib/toaster/bldcontrol/views.py b/lib/toaster/bldcontrol/views.py
index 60f00ef0ef..286d88b45a 100644
--- a/lib/toaster/bldcontrol/views.py
+++ b/lib/toaster/bldcontrol/views.py
@@ -1 +1,5 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 # Create your views here.
diff --git a/lib/toaster/manage.py b/lib/toaster/manage.py
index 0c7ea50882..ae32619d12 100755
--- a/lib/toaster/manage.py
+++ b/lib/toaster/manage.py
@@ -1,4 +1,8 @@
 #!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 import os
 import sys
 
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 66114ff89e..b15b9ce4af 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2016-2017   Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 7720290214..68ca0bcfed 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/selenium_helpers.py b/lib/toaster/tests/browser/selenium_helpers.py
index 08711e4558..66e700c842 100644
--- a/lib/toaster/tests/browser/selenium_helpers.py
+++ b/lib/toaster/tests/browser/selenium_helpers.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 156d639b1e..48a0488e19 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toaster/tests/browser/test_all_builds_page.py
index b86f29bdd4..bab44e9cc2 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/toaster/tests/browser/test_all_projects_page.py
index 44da640751..b0b3aec1fa 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py b/lib/toaster/tests/browser/test_builddashboard_page.py
index f8ccb54528..5d2dcd066b 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
index 1c627ad498..f92b642e95 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_recipes.py b/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
index ed18324e57..7f96288156 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_tasks.py b/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
index da50f16011..d0c4ec33e5 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_js_unit_tests.py b/lib/toaster/tests/browser/test_js_unit_tests.py
index 3c0b96252f..ceea71342c 100644
--- a/lib/toaster/tests/browser/test_js_unit_tests.py
+++ b/lib/toaster/tests/browser/test_js_unit_tests.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
index 4d4cd660fb..06aa5693eb 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -4,6 +4,8 @@
 #
 # BitBake Toaster Implementation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # Copyright (C) 2013-2016 Intel Corporation
 #
 # This program is free software; you can redistribute it and/or modify
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index f24fb093a5..a39bb9ac18 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -4,6 +4,8 @@
 #
 # BitBake Toaster Implementation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # Copyright (C) 2013-2016 Intel Corporation
 #
 # This program is free software; you can redistribute it and/or modify
diff --git a/lib/toaster/tests/browser/test_most_recent_builds_states.py b/lib/toaster/tests/browser/test_most_recent_builds_states.py
index abc0b0bc88..7d44638bc1 100644
--- a/lib/toaster/tests/browser/test_most_recent_builds_states.py
+++ b/lib/toaster/tests/browser/test_most_recent_builds_states.py
@@ -4,6 +4,8 @@
 #
 # BitBake Toaster Implementation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # Copyright (C) 2013-2016 Intel Corporation
 #
 # This program is free software; you can redistribute it and/or modify
diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/lib/toaster/tests/browser/test_new_custom_image_page.py
index ab5a8e66be..f865e3272c 100644
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toaster/tests/browser/test_new_project_page.py
index 77e5f15267..92d414d8d6 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_project_builds_page.py b/lib/toaster/tests/browser/test_project_builds_page.py
index 9fe91ab067..2202d937d6 100644
--- a/lib/toaster/tests/browser/test_project_builds_page.py
+++ b/lib/toaster/tests/browser/test_project_builds_page.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_project_config_page.py b/lib/toaster/tests/browser/test_project_config_page.py
index 0710084995..a0d5bcd348 100644
--- a/lib/toaster/tests/browser/test_project_config_page.py
+++ b/lib/toaster/tests/browser/test_project_config_page.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_project_page.py b/lib/toaster/tests/browser/test_project_page.py
index 0186463324..7b544ed966 100644
--- a/lib/toaster/tests/browser/test_project_page.py
+++ b/lib/toaster/tests/browser/test_project_page.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_sample.py b/lib/toaster/tests/browser/test_sample.py
index 20ec53c28a..4cdd19f3d1 100644
--- a/lib/toaster/tests/browser/test_sample.py
+++ b/lib/toaster/tests/browser/test_sample.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_task_page.py b/lib/toaster/tests/browser/test_task_page.py
index 690d116cba..97708a765e 100644
--- a/lib/toaster/tests/browser/test_task_page.py
+++ b/lib/toaster/tests/browser/test_task_page.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/browser/test_toastertable_ui.py b/lib/toaster/tests/browser/test_toastertable_ui.py
index 53ddf30c3c..0780ef9fe4 100644
--- a/lib/toaster/tests/browser/test_toastertable_ui.py
+++ b/lib/toaster/tests/browser/test_toastertable_ui.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/builds/buildtest.py
index 5a56a110a7..129c9fe401 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/builds/test_core_image_min.py b/lib/toaster/tests/builds/test_core_image_min.py
index 586f4a8f7f..8964071990 100644
--- a/lib/toaster/tests/builds/test_core_image_min.py
+++ b/lib/toaster/tests/builds/test_core_image_min.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/commands/test_loaddata.py b/lib/toaster/tests/commands/test_loaddata.py
index 951f6ff5aa..b4b53d0919 100644
--- a/lib/toaster/tests/commands/test_loaddata.py
+++ b/lib/toaster/tests/commands/test_loaddata.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/commands/test_lsupdates.py b/lib/toaster/tests/commands/test_lsupdates.py
index 49897a476c..2d34f211b9 100644
--- a/lib/toaster/tests/commands/test_lsupdates.py
+++ b/lib/toaster/tests/commands/test_lsupdates.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/commands/test_runbuilds.py b/lib/toaster/tests/commands/test_runbuilds.py
index 3e634835ee..2c9fcf0f20 100644
--- a/lib/toaster/tests/commands/test_runbuilds.py
+++ b/lib/toaster/tests/commands/test_runbuilds.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/db/test_db.py b/lib/toaster/tests/db/test_db.py
index a0f5f6ec03..0410422276 100644
--- a/lib/toaster/tests/db/test_db.py
+++ b/lib/toaster/tests/db/test_db.py
@@ -2,6 +2,8 @@
 #
 # Copyright (c) 2016 Damien Lespiau
 #
+# SPDX-License-Identifier: MIT
+#
 # Permission is hereby granted, free of charge, to any person obtaining a copy
 # of this software and associated documentation files (the "Software"), to deal
 # in the Software without restriction, including without limitation the rights
diff --git a/lib/toaster/tests/eventreplay/__init__.py b/lib/toaster/tests/eventreplay/__init__.py
index 695661947a..f10ea89ae1 100644
--- a/lib/toaster/tests/eventreplay/__init__.py
+++ b/lib/toaster/tests/eventreplay/__init__.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toaster/tests/functional/functional_helpers.py
index 486078a615..8eb2e963f6 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2017 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/toaster/tests/functional/test_functional_basic.py
index cfa2b0fdf0..817bcde333 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2017 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/views/test_views.py
index 1463077e91..d5b00288bd 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013-2015 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 564d595a1c..99e9768ae7 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -3,6 +3,8 @@
 #
 # Copyright (C) 2016        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastergui/buildtables.py b/lib/toaster/toastergui/buildtables.py
index 755a7c2e43..6a20d60752 100644
--- a/lib/toaster/toastergui/buildtables.py
+++ b/lib/toaster/toastergui/buildtables.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2016 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastergui/tablefilter.py b/lib/toaster/toastergui/tablefilter.py
index 65454e140d..1f9016beff 100644
--- a/lib/toaster/toastergui/tablefilter.py
+++ b/lib/toaster/toastergui/tablefilter.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2015        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 9ff756bc8d..855861a869 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2015        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastergui/templatetags/field_values_filter.py b/lib/toaster/toastergui/templatetags/field_values_filter.py
index 5a73af797c..eb483396c2 100644
--- a/lib/toaster/toastergui/templatetags/field_values_filter.py
+++ b/lib/toaster/toastergui/templatetags/field_values_filter.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from django import template
 
 register = template.Library()
diff --git a/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py b/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py
index 0dcc7d2714..048d533871 100644
--- a/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py
+++ b/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from django import template
 import json
 
diff --git a/lib/toaster/toastergui/templatetags/project_url_tag.py b/lib/toaster/toastergui/templatetags/project_url_tag.py
index 04770ac6a8..71e0925787 100644
--- a/lib/toaster/toastergui/templatetags/project_url_tag.py
+++ b/lib/toaster/toastergui/templatetags/project_url_tag.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from django import template
 from django.core.urlresolvers import reverse
 
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index b170a16165..80652edd49 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
index 5aa0f8d889..3921435584 100644
--- a/lib/toaster/toastergui/typeaheads.py
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -3,6 +3,8 @@
 #
 # Copyright (C) 2015        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index dc03e30356..3d0be61faa 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -3,6 +3,8 @@
 #
 # Copyright (C) 2013-2017    Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index c712b06a6e..6aad55b7c8 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index db5c3aa00b..e8aabdd9fa 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2015        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastermain/management/commands/builddelete.py b/lib/toaster/toastermain/management/commands/builddelete.py
index bf69a8fb80..c2d773a577 100644
--- a/lib/toaster/toastermain/management/commands/builddelete.py
+++ b/lib/toaster/toastermain/management/commands/builddelete.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from django.core.management.base import BaseCommand, CommandError
 from django.core.exceptions import ObjectDoesNotExist
 from orm.models import Build
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index 2d57ab557a..2f99c6d556 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2018        Wind River Systems
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastermain/management/commands/buildslist.py b/lib/toaster/toastermain/management/commands/buildslist.py
index 70b5812d98..1ed20224d3 100644
--- a/lib/toaster/toastermain/management/commands/buildslist.py
+++ b/lib/toaster/toastermain/management/commands/buildslist.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from django.core.management.base import BaseCommand, CommandError
 from orm.models import Build
 import os
diff --git a/lib/toaster/toastermain/management/commands/checksocket.py b/lib/toaster/toastermain/management/commands/checksocket.py
index 0399b8659b..d9cdb555df 100644
--- a/lib/toaster/toastermain/management/commands/checksocket.py
+++ b/lib/toaster/toastermain/management/commands/checksocket.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2015 Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastermain/management/commands/perf.py b/lib/toaster/toastermain/management/commands/perf.py
index 6b450bbdfc..7d629fb37f 100644
--- a/lib/toaster/toastermain/management/commands/perf.py
+++ b/lib/toaster/toastermain/management/commands/perf.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 from django.core.management.base import BaseCommand
 from django.test.client import Client
 import os, sys, re
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 13541d380f..6373559190 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastermain/settings_production_example.py b/lib/toaster/toastermain/settings_production_example.py
index 61a288864a..2067624358 100644
--- a/lib/toaster/toastermain/settings_production_example.py
+++ b/lib/toaster/toastermain/settings_production_example.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2016        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastermain/settings_test.py b/lib/toaster/toastermain/settings_test.py
index a322711579..963d77f280 100644
--- a/lib/toaster/toastermain/settings_test.py
+++ b/lib/toaster/toastermain/settings_test.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2016        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index e2fb0aebfd..1a98754ed4 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -6,6 +6,8 @@
 #
 # Copyright (C) 2013        Intel Corporation
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
 # published by the Free Software Foundation.
diff --git a/lib/toaster/toastermain/wsgi.py b/lib/toaster/toastermain/wsgi.py
index 031b314b1a..5ad22aea18 100644
--- a/lib/toaster/toastermain/wsgi.py
+++ b/lib/toaster/toastermain/wsgi.py
@@ -1,3 +1,7 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 """
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-- 
2.20.1


