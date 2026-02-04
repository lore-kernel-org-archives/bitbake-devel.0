Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B11E95371
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 10:03:36 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17030.1770199406825133729
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 02:03:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=O614QTmU;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E30BA4E423E2
	for <bitbake-devel@lists.openembedded.org>; Wed,  4 Feb 2026 10:03:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B35F560745;
	Wed,  4 Feb 2026 10:03:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7FB3119A865B;
	Wed,  4 Feb 2026 11:03:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770199404; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=kd93QOFFClTglkosSo62a0ohJypX3qnbD4APy715ffc=;
	b=O614QTmUdFp9P6iisAum4advgFBagrDAHzk+MQmJ1gymbKG2suP9tIMzTwrI1rikJinGKy
	GMjXFwmUiQOh/JnPxlY/Ak14hMmP5ycUbiRZgZJhC23i1mdfcGx0dZu8RpJyYIQrhZ4cv3
	a1lz53u7BRNXP0xm5+zMeqCs/kI23GZduEii50Csi7nwRtOFB1nD+DjZuRtDBHLI5xkzhn
	uMRzuFylFuztCdc/uAEcOCM9H3gEn5IPFNm+quQKQ2iYSxDh7cVlW+yoeSI03QLGx7QPHO
	35H0YsuR/x12zONfVNlSHZRv4ZFd2EFaSPoNhpmr6Dsgob82HVDknrEqYZwH/Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Feb 2026 11:03:01 +0100
Subject: [PATCH v2] doc: fix the switchers menu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNwQ6CMBBEf4Xs2TVtoQKe/A/DQepW1mhrugQ1h
 H+3cPX4JjNvZhBKTALHYoZEEwvHkMHsCnDDJdwI+ZoZjDKVNqZGzx+UN49uoCR4F2ycryp70Kp
 va8izV6Lc2ZTnLvPAMsb03R4mvaarzKpW23/ZpFGhNSV5W3pqlDn1MY4PDnsXn9Aty/IDcUwHp
 bIAAAA=
X-Change-ID: 20241227-fix-switchers-js-8cf445610b97
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=25047;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=toeTFUUkw5ZzHvnc8xHx/duwzkqJjUGAx6tuThcVxho=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpgxlq1Jetz/SP6kg9DDtwzjlyMG+Td5wP3jnUO
 iPbqNgHOWaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYMZagAKCRDRgEFAKaOo
 NstLEACUTbxAFyRUU8HN0INH4A72KVPFcTSbn5gTklUZK+70uczq9KUMbtlAMbLZvQ8/ZYn+7hT
 ebfRLb1oemgeX7TP1YxAfJJGwPZhDcdKrTqG96tOrY7ve5z46ab+M1QE8SBAj8lzpfFaVJ82fll
 i6mtHwg0cH7iymC2qOtHracuKTXCWxjYEbTG3UBZZD0WSk7/igEq92P2KzxYDvBcVgdfGYFrA0F
 9fjYtEypZx1q/iB4KISS7KjzNx5fRF3yNXCHicFxos7NA6K1PXBik/Yjp+Wv2dAA9ptS+zXYMf1
 G7BwHkFIgXxPmN4HCzo7H4HNEu+2hUjZv4SVDY6DBDd5DkeTVgtiVj6dq0vbu/yEsZa5v70H+2d
 OjMvY69Lb+cQnXXyS/FKvOzICSb1vq1f25vUbMiQjBKJJ/429elksLimvOdumLeOsG9XoqyIIg7
 JJYkSOhSJR/XfL1wYPaIY8vYsNEAvcE6xuoHkuRwDRZ6bLxTcCcn32H7BZADAXYha1YE3oVD3iP
 08Q2RnPMpiZ40J6dEtDsEhlIk8QuAO8G4ZMZihZvR70DA+BFFc/LZVwJzGtTgXmSFy0ZmqQXMTG
 3yRz5ly/+sTvxj59HZTMouA9qjhdx3dlnaDD7phAcgbupHJh9C8+g+rkT4J1pVfb3XVbkD+ur7U
 Jz45sJV6b4LMubQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 10:03:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18948

Fix the switchers.js script of Bitbake to show what are the supported
versions and be able to switch between them.

The default landing page is the stable branch and shows the BitBake
version along with the corresponding Yocto Project codename. This
hopefully makes it easier to remember the correspondance between the
BitBake version and the Yocto Project version.

This works thanks to a set_versions.py script, which is largely inspired
from yocto-docs. It reads the tags from the repository and tries to
guess the currently checked out version of BitBake on which we are.

The "obsolete" warning is now also shown when browsing outdated manuals,
meaning any version not part of activereleases in set_versions.py.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Note: This will be accompanied by a patch to adapt the Autobuilder to
generate this file for each release.
---
Changes in v2:
- Remove environment information grabbing mechanism, making this fully
  standalone.
- Link to v1: https://lore.kernel.org/r/20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com
---
 doc/.gitignore                    |   2 +
 doc/Makefile                      |   3 +-
 doc/bitbake.yaml.in               |   1 +
 doc/conf.py                       |  10 +-
 doc/set_versions.py               | 155 ++++++++++++++++++++++++
 doc/sphinx-static/switchers.js    | 233 -----------------------------------
 doc/sphinx-static/switchers.js.in | 247 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 416 insertions(+), 235 deletions(-)

diff --git a/doc/.gitignore b/doc/.gitignore
index 69fa449dd96..40ebe76c088 100644
--- a/doc/.gitignore
+++ b/doc/.gitignore
@@ -1 +1,3 @@
 _build/
+sphinx-static/switchers.js
+bitbake.yaml
diff --git a/doc/Makefile b/doc/Makefile
index 996f01b7d5c..cdb054d3a52 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -27,9 +27,10 @@ publish: Makefile html singlehtml
 	sed -i -e 's@index.html#@singleindex.html#@g' $(BUILDDIR)/$(DESTDIR)/singleindex.html
 
 clean:
-	@rm -rf $(BUILDDIR)
+	@rm -rf $(BUILDDIR) sphinx-static/switchers.js bitbake.yaml
 
 # Catch-all target: route all unknown targets to Sphinx using the new
 # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
 %: Makefile
+	$(SOURCEDIR)/set_versions.py
 	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
diff --git a/doc/bitbake.yaml.in b/doc/bitbake.yaml.in
new file mode 100644
index 00000000000..4085582df60
--- /dev/null
+++ b/doc/bitbake.yaml.in
@@ -0,0 +1 @@
+DOCCONF_VERSION : "dev"
diff --git a/doc/conf.py b/doc/conf.py
index bce386624e2..5b28808c590 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -14,17 +14,25 @@
 # import sys
 # sys.path.insert(0, os.path.abspath('.'))
 
+import os
 import sys
 import datetime
+import yaml
 
 from pathlib import Path
 
-current_version = "dev"
+current_version = 'dev'
+
+with open("bitbake.yaml") as data:
+    buff = data.read()
+    subst_vars = yaml.safe_load(buff)
+    current_version = subst_vars["DOCCONF_VERSION"]
 
 # String used in sidebar
 version = 'Version: ' + current_version
 if current_version == 'dev':
     version = 'Version: Current Development'
+
 # Version seen in documentation_options.js and hence in js switchers code
 release = current_version
 
diff --git a/doc/set_versions.py b/doc/set_versions.py
new file mode 100755
index 00000000000..63fba2fe948
--- /dev/null
+++ b/doc/set_versions.py
@@ -0,0 +1,155 @@
+#!/usr/bin/env python3
+#
+# This is a minimal version of the set_versions.py from yocto-docs,
+# use to replace VERSIONS_PLACEHOLDER in switchers.js.in by a list defined below
+# with BITBAKE_ACTIVE_RELEASES in the environment.
+#
+# When the documentation is built with the autobuilder, the versions are
+# calculated based on the info found in set_versions.py from yocto-docs.
+#
+# Copyright Linux Foundation
+# Author: Antonin Godard <antonin.godard@bootlin.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+import collections
+import itertools
+import re
+import os
+import subprocess
+import sys
+
+from packaging.version import Version
+from typing import Tuple
+
+devbranch = "2.18"
+ltsseries = ["2.8", "2.0"]
+activereleases = ["2.16"] + ltsseries
+
+yocto_mapping = {
+    "2.18": "wrynose",
+    "2.16": "whinlatter",
+    "2.12": "walnascar",
+    "2.10": "styhead",
+    "2.8": "scarthgap",
+    "2.6": "nanbield",
+    "2.4": "mickledore",
+    "2.2": "langdale",
+    "2.0": "kirkstone",
+    "1.52": "honister",
+    "1.50": "hardknott",
+    "1.48": "gatesgarth",
+    "1.46": "dunfell",
+}
+
+bbver_re = re.compile(r"^[0-9]+\.[0-9]+\.[0-9]+$")
+ourversion = None
+
+# Test that we are building from a Git repository
+try:
+    subprocess.run(["git", "rev-parse", "--is-inside-work-tree"],
+                   stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
+except subprocess.CalledProcessError:
+    sys.exit("Building bitbake's documentation must be done from its Git repository.\n"
+             "Clone the repository with the following command:\n"
+             "git clone https://git.openembedded.org/bitbake ")
+
+# Test tags exist and inform the user to fetch if not
+try:
+    subprocess.run(["git", "show", f"{ltsseries[0]}.0"],
+                   stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
+except subprocess.CalledProcessError:
+    sys.exit("Please run 'git fetch --tags' before building the documentation")
+
+
+# Try and figure out what we are
+tags = subprocess.run(["git", "tag", "--points-at", "HEAD"],
+                      stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                      universal_newlines=True).stdout
+for t in tags.split():
+    if re.match(bbver_re, t):
+        ourversion = t
+
+if ourversion:
+    # We're a tagged release
+    components = ourversion.split(".")
+    ourseries = f"{components[0]}.{components[1]}"
+else:
+    # We're floating on a branch
+    branch = subprocess.run(["git", "branch", "--show-current"],
+                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                            universal_newlines=True).stdout.strip()
+
+    if branch == "" or branch not in list(yocto_mapping.keys()) + ["master", "master-next"]:
+        # We're not on a known release branch so we have to guess. Compare the
+        # numbers of commits from each release branch and assume the smallest
+        # number of commits is the one we're based off
+        possible_branch = None
+        branch_count = 0
+        for b in itertools.chain(yocto_mapping.keys(), ["master"]):
+            result = subprocess.run(["git", "log", "--format=oneline", "HEAD..origin/" + b],
+                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                    universal_newlines=True)
+            if result.returncode == 0:
+                count = result.stdout.count('\n')
+                if not possible_branch or count < branch_count:
+                    print("Branch %s has count %s" % (b, count))
+                    possible_branch = b
+                    branch_count = count
+        if possible_branch:
+            branch = possible_branch
+        else:
+            branch = "master"
+        print("Nearest release branch estimated to be %s" % branch)
+
+    if branch == "master":
+        ourversion = "dev"
+        ourseries = devbranch
+    elif branch == "master-next":
+        ourversion = "next"
+        ourseries = devbranch
+    else:
+        ourversion = branch
+        head_commit = subprocess.run(["git", "rev-parse", "--short", "HEAD"],
+                                     stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                     universal_newlines=True).stdout.strip()
+        branch_commit = subprocess.run(["git", "rev-parse", "--short", branch],
+                                        stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                        universal_newlines=True).stdout.strip()
+        if head_commit != branch_commit:
+            ourversion += f" ({head_commit})"
+        ourseries = branch
+
+print("Version calculated to be %s" % ourversion)
+print("Series calculated to be %s" % ourseries)
+
+replacements = {
+    "DOCCONF_VERSION": ourversion,
+}
+
+if os.path.exists("bitbake.yaml.in"):
+    with open("bitbake.yaml.in", "r") as r, open("bitbake.yaml", "w") as w:
+        lines = r.readlines()
+        for line in lines:
+            data = line.split(":")
+            k = data[0].strip()
+            if k in replacements:
+                w.write("%s : \"%s\"\n" % (k, replacements[k]))
+            else:
+                w.write(line)
+
+    print("bitbake.yaml generated from bitbake.yaml.in")
+
+with open("sphinx-static/switchers.js.in", "r") as r, \
+     open("sphinx-static/switchers.js", "w") as w:
+    lines = r.readlines()
+    for line in lines:
+        if "VERSIONS_PLACEHOLDER" in line:
+            if ourversion != "dev":
+                w.write(f"    'dev': 'Unstable (dev)',\n")
+            for series in activereleases:
+                w.write(f"    '{series}': '{series} ({yocto_mapping[series]})',\n")
+        else:
+            w.write(line)
+    print("switchers.js generated from switchers.js.in")
diff --git a/doc/sphinx-static/switchers.js b/doc/sphinx-static/switchers.js
deleted file mode 100644
index 32113cfa960..00000000000
--- a/doc/sphinx-static/switchers.js
+++ /dev/null
@@ -1,233 +0,0 @@
-(function() {
-  'use strict';
-
-  var all_versions = {
-    'dev': 'dev (3.2)',
-    '3.1.2': '3.1.2',
-    '3.0.3': '3.0.3',
-    '2.7.4': '2.7.4',
-  };
-
-  var all_doctypes = {
-      'single': 'Individual Webpages',
-      'mega': "All-in-one 'Mega' Manual",
-  };
-
-  // Simple version comparision
-  // Return 1 if a > b
-  // Return -1 if a < b
-  // Return 0 if a == b
-  function ver_compare(a, b) {
-    if (a == "dev") {
-       return 1;
-    }
-
-    if (a === b) {
-       return 0;
-    }
-
-    var a_components = a.split(".");
-    var b_components = b.split(".");
-
-    var len = Math.min(a_components.length, b_components.length);
-
-    // loop while the components are equal
-    for (var i = 0; i < len; i++) {
-        // A bigger than B
-        if (parseInt(a_components[i]) > parseInt(b_components[i])) {
-            return 1;
-        }
-
-        // B bigger than A
-        if (parseInt(a_components[i]) < parseInt(b_components[i])) {
-            return -1;
-        }
-    }
-
-    // If one's a prefix of the other, the longer one is greater.
-    if (a_components.length > b_components.length) {
-        return 1;
-    }
-
-    if (a_components.length < b_components.length) {
-        return -1;
-    }
-
-    // Otherwise they are the same.
-    return 0;
-  }
-
-  function build_version_select(current_series, current_version) {
-    var buf = ['<select>'];
-
-    $.each(all_versions, function(version, title) {
-      var series = version.substr(0, 3);
-      if (series == current_series) {
-        if (version == current_version)
-            buf.push('<option value="' + version + '" selected="selected">' + title + '</option>');
-        else
-            buf.push('<option value="' + version + '">' + title + '</option>');
-
-        if (version != current_version)
-            buf.push('<option value="' + current_version + '" selected="selected">' + current_version + '</option>');
-      } else {
-        buf.push('<option value="' + version + '">' + title + '</option>');
-      }
-    });
-
-    buf.push('</select>');
-    return buf.join('');
-  }
-
-  function build_doctype_select(current_doctype) {
-    var buf = ['<select>'];
-
-    $.each(all_doctypes, function(doctype, title) {
-      if (doctype == current_doctype)
-        buf.push('<option value="' + doctype + '" selected="selected">' +
-                 all_doctypes[current_doctype] + '</option>');
-      else
-        buf.push('<option value="' + doctype + '">' + title + '</option>');
-    });
-    if (!(current_doctype in all_doctypes)) {
-        // In case we're browsing a doctype that is not yet in all_doctypes.
-        buf.push('<option value="' + current_doctype + '" selected="selected">' +
-                 current_doctype + '</option>');
-        all_doctypes[current_doctype] = current_doctype;
-    }
-    buf.push('</select>');
-    return buf.join('');
-  }
-
-  function navigate_to_first_existing(urls) {
-    // Navigate to the first existing URL in urls.
-    var url = urls.shift();
-
-    // Web browsers won't redirect file:// urls to file urls using ajax but
-    // its useful for local testing
-    if (url.startsWith("file://")) {
-      window.location.href = url;
-      return;
-    }
-
-    if (urls.length == 0) {
-      window.location.href = url;
-      return;
-    }
-    $.ajax({
-      url: url,
-      success: function() {
-        window.location.href = url;
-      },
-      error: function() {
-        navigate_to_first_existing(urls);
-      }
-    });
-  }
-
-  function get_docroot_url() {
-    var url = window.location.href;
-    var root = DOCUMENTATION_OPTIONS.URL_ROOT;
-
-    var urlarray = url.split('/');
-    // Trim off anything after '/'
-    urlarray.pop();
-    var depth = (root.match(/\.\.\//g) || []).length;
-    for (var i = 0; i < depth; i++) {
-      urlarray.pop();
-    }
-
-    return urlarray.join('/') + '/';
-  }
-
-  function on_version_switch() {
-    var selected_version = $(this).children('option:selected').attr('value');
-    var url = window.location.href;
-    var current_version = DOCUMENTATION_OPTIONS.VERSION;
-    var docroot = get_docroot_url()
-
-    var new_versionpath = selected_version + '/';
-    if (selected_version == "dev")
-        new_versionpath = '';
-
-    // dev versions have no version prefix
-    if (current_version == "dev") {
-        var new_url = docroot + new_versionpath + url.replace(docroot, "");
-        var fallback_url = docroot + new_versionpath;
-    } else {
-        var new_url = url.replace('/' + current_version + '/', '/' + new_versionpath);
-        var fallback_url = new_url.replace(url.replace(docroot, ""), "");
-    }
-
-    console.log(get_docroot_url())
-    console.log(url + " to url " + new_url);
-    console.log(url + " to fallback " + fallback_url);
-
-    if (new_url != url) {
-      navigate_to_first_existing([
-        new_url,
-        fallback_url,
-        'https://www.yoctoproject.org/docs/',
-      ]);
-    }
-  }
-
-  function on_doctype_switch() {
-    var selected_doctype = $(this).children('option:selected').attr('value');
-    var url = window.location.href;
-    if (selected_doctype == 'mega') {
-      var docroot = get_docroot_url()
-      var current_version = DOCUMENTATION_OPTIONS.VERSION;
-      // Assume manuals before 3.2 are using old docbook mega-manual
-      if (ver_compare(current_version, "3.2") < 0) {
-        var new_url = docroot + "mega-manual/mega-manual.html";
-      } else {
-        var new_url = docroot + "singleindex.html";
-      }
-    } else {
-      var new_url = url.replace("singleindex.html", "index.html")
-    }
-
-    if (new_url != url) {
-      navigate_to_first_existing([
-        new_url,
-        'https://www.yoctoproject.org/docs/',
-      ]);
-    }
-  }
-
-  // Returns the current doctype based upon the url
-  function doctype_segment_from_url(url) {
-    if (url.includes("singleindex") || url.includes("mega-manual"))
-      return "mega";
-    return "single";
-  }
-
-  $(document).ready(function() {
-    var release = DOCUMENTATION_OPTIONS.VERSION;
-    var current_doctype = doctype_segment_from_url(window.location.href);
-    var current_series = release.substr(0, 3);
-    var version_select = build_version_select(current_series, release);
-
-    $('.version_switcher_placeholder').html(version_select);
-    $('.version_switcher_placeholder select').bind('change', on_version_switch);
-
-    var doctype_select = build_doctype_select(current_doctype);
-
-    $('.doctype_switcher_placeholder').html(doctype_select);
-    $('.doctype_switcher_placeholder select').bind('change', on_doctype_switch);
-
-    if (ver_compare(release, "3.1") < 0) {
-      $('#outdated-warning').html('Version ' + release + ' of the project is now considered obsolete, please select and use a more recent version');
-      $('#outdated-warning').css('padding', '.5em');
-    } else if (release != "dev") {
-      $.each(all_versions, function(version, title) {
-        var series = version.substr(0, 3);
-        if (series == current_series && version != release) {
-          $('#outdated-warning').html('This document is for outdated version ' + release + ', you should select the latest release version in this series, ' + version + '.');
-          $('#outdated-warning').css('padding', '.5em');
-        }
-      });
-    }
-  });
-})();
diff --git a/doc/sphinx-static/switchers.js.in b/doc/sphinx-static/switchers.js.in
new file mode 100644
index 00000000000..108d1a7d77f
--- /dev/null
+++ b/doc/sphinx-static/switchers.js.in
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: MIT
+(function () {
+  "use strict";
+
+  var all_versions = {
+    VERSIONS_PLACEHOLDER,
+  };
+
+  var all_doctypes = {
+    single: "Individual Webpages",
+    mega: "All-in-one 'Mega' Manual",
+  };
+
+  // Simple version comparision
+  // Return 1 if a > b
+  // Return -1 if a < b
+  // Return 0 if a == b
+  function ver_compare(a, b) {
+    if (a == "dev") {
+      return 1;
+    }
+
+    if (a === b) {
+      return 0;
+    }
+
+    var a_components = a.split(".");
+    var b_components = b.split(".");
+
+    var len = Math.min(a_components.length, b_components.length);
+
+    // loop while the components are equal
+    for (var i = 0; i < len; i++) {
+      // A bigger than B
+      if (parseInt(a_components[i]) > parseInt(b_components[i])) {
+        return 1;
+      }
+
+      // B bigger than A
+      if (parseInt(a_components[i]) < parseInt(b_components[i])) {
+        return -1;
+      }
+    }
+
+    // If one's a prefix of the other, the longer one is greater.
+    if (a_components.length > b_components.length) {
+      return 1;
+    }
+
+    if (a_components.length < b_components.length) {
+      return -1;
+    }
+
+    // Otherwise they are the same.
+    return 0;
+  }
+
+  function build_version_select(current_version) {
+    var buf = ["<select>"];
+
+    $.each(all_versions, function (version, title) {
+      if (current_version != version) {
+        buf.push(
+          '<option value="' +
+          version +
+          '" selected="selected">' +
+          title +
+          "</option>",
+        );
+      }
+    });
+
+    var current_title = current_version;
+    if (current_version in all_versions) {
+      current_title = all_versions[current_version];
+    }
+    buf.push(
+      '<option value="' +
+        current_version +
+        '" selected="selected">' +
+        current_title +
+        "</option>",
+    );
+
+    buf.push("</select>");
+    return buf.join("");
+  }
+
+  function build_doctype_select(current_doctype) {
+    var buf = ["<select>"];
+
+    $.each(all_doctypes, function (doctype, title) {
+      if (doctype == current_doctype)
+        buf.push(
+          '<option value="' +
+            doctype +
+            '" selected="selected">' +
+            all_doctypes[current_doctype] +
+            "</option>",
+        );
+      else buf.push('<option value="' + doctype + '">' + title + "</option>");
+    });
+    if (!(current_doctype in all_doctypes)) {
+      // In case we're browsing a doctype that is not yet in all_doctypes.
+      buf.push(
+        '<option value="' +
+          current_doctype +
+          '" selected="selected">' +
+          current_doctype +
+          "</option>",
+      );
+      all_doctypes[current_doctype] = current_doctype;
+    }
+    buf.push("</select>");
+    return buf.join("");
+  }
+
+  function navigate_to_first_existing(urls) {
+    // Navigate to the first existing URL in urls.
+    var url = urls.shift();
+
+    // Web browsers won't redirect file:// urls to file urls using ajax but
+    // its useful for local testing
+    if (url.startsWith("file://")) {
+      window.location.href = url;
+      return;
+    }
+
+    if (urls.length == 0) {
+      window.location.href = url;
+      return;
+    }
+    $.ajax({
+      url: url,
+      success: function () {
+        window.location.href = url;
+      },
+      error: function () {
+        navigate_to_first_existing(urls);
+      },
+    });
+  }
+
+  function get_docroot_url() {
+    var url = window.location.href;
+    // Try to get the variable from documentation_options.js
+    var root = DOCUMENTATION_OPTIONS.URL_ROOT;
+    if (root == null) {
+      // In recent versions of Sphinx, URL_ROOT was removed from
+      // documentation_options.js, so get it like searchtools.js does.
+      root = document.documentElement.dataset.content_root;
+    }
+
+    var urlarray = url.split("/");
+    // Trim off anything after '/'
+    urlarray.pop();
+    var depth = (root.match(/\.\.\//g) || []).length;
+    for (var i = 0; i < depth; i++) {
+      urlarray.pop();
+    }
+
+    return urlarray.join("/") + "/";
+  }
+
+  function on_version_switch() {
+    var selected_version = $(this).children("option:selected").attr("value");
+    var url = window.location.href;
+    var current_version = DOCUMENTATION_OPTIONS.VERSION;
+    var docroot = get_docroot_url();
+
+    var new_versionpath = selected_version + "/";
+
+    // latest tag is also the default page (without version information)
+    if (docroot.endsWith("dev/")) {
+      var new_url = url.replace("/dev/", "/" + new_versionpath);
+      var fallback_url = new_url.replace(url.replace(docroot, ""), "");
+    } else if (docroot.endsWith(current_version + "/") == false) {
+      var new_url = docroot + new_versionpath + url.replace(docroot, "");
+      var fallback_url = docroot + new_versionpath;
+    } else {
+      var new_url = url.replace(
+        "/" + current_version + "/",
+        "/" + new_versionpath,
+      );
+      var fallback_url = new_url.replace(url.replace(docroot, ""), "");
+    }
+
+    console.log(url + " to url " + new_url);
+    console.log(url + " to fallback " + fallback_url);
+
+    if (new_url != url) {
+      navigate_to_first_existing([
+        new_url,
+        fallback_url,
+        "https://www.yoctoproject.org/bitbake/",
+      ]);
+    }
+  }
+
+  function on_doctype_switch() {
+    var selected_doctype = $(this).children("option:selected").attr("value");
+    var url = window.location.href;
+    if (selected_doctype == "mega") {
+      var docroot = get_docroot_url();
+      var current_version = DOCUMENTATION_OPTIONS.VERSION;
+      var new_url = docroot + "singleindex.html";
+    } else {
+      var new_url = url.replace("singleindex.html", "index.html");
+    }
+
+    if (new_url != url) {
+      navigate_to_first_existing([
+        new_url,
+        "https://www.yoctoproject.org/docs/",
+      ]);
+    }
+  }
+
+  // Returns the current doctype based upon the url
+  function doctype_segment_from_url(url) {
+    if (url.includes("singleindex") || url.includes("mega-manual"))
+      return "mega";
+    return "single";
+  }
+
+  $(document).ready(function () {
+    var release = DOCUMENTATION_OPTIONS.VERSION;
+    var current_doctype = doctype_segment_from_url(window.location.href);
+    var current_series = release.substr(0, 3);
+    var version_select = build_version_select(release);
+
+    $(".version_switcher_placeholder").html(version_select);
+    $(".version_switcher_placeholder select").bind("change", on_version_switch);
+
+    var doctype_select = build_doctype_select(current_doctype);
+
+    $(".doctype_switcher_placeholder").html(doctype_select);
+    $(".doctype_switcher_placeholder select").bind("change", on_doctype_switch);
+
+    if (!(["dev", "next"].includes(release)) && !(release in all_versions)) {
+      $("#outdated-warning").html(
+        "Version " + release + " of the project is now considered obsolete, please select and use a more recent version",
+      );
+      $("#outdated-warning").css("padding", ".5em");
+    }
+  });
+})();

---
base-commit: cdd79c1768ac396a9c6577e38098da4331507f24
change-id: 20241227-fix-switchers-js-8cf445610b97


