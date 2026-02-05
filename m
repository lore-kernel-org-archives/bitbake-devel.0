Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FECE9D3F3
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 15:26:01 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23387.1770305153630534081
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 07:25:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=2Ni9xh5G;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A61171A2C21;
	Thu,  5 Feb 2026 15:25:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6D2BA606FD;
	Thu,  5 Feb 2026 15:25:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21B54119A865B;
	Thu,  5 Feb 2026 16:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770305150; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=gs8MhqaJFSGnBFzjxY25/NbdXlFIV/+/lueVJX+ZG10=;
	b=2Ni9xh5G4CPtL6U0CAs2E6LdFd1VatI9TQj+TA6mKpL1F4W6CcJYdNrWl7arqFRx//qxmW
	gK2gweYOvK1upjKAiZjj8jmj7oW7YoXS6It5hW1W29TCrT+7aIzggWiZxNRWyLJ/fIz6x0
	+sXCSjJFmqN/CGTJ19a4Tf0qxfrfvEgOzKwWQlo4OXNyAoJ/CR2QvicmoIXC6HSHcSAx0L
	XH6fYrfTwBeEiGIyWRYZEfnrzUrTOyDXERyR0ZJevAp87gUv5ExFfc/89ufyJME72qCvO2
	EjWoi0rSertkVfyUQo4iGudzhloS0VoRYXE/dXSMZjwZQrWQ3NxxKJvMXx02Bg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 05 Feb 2026 16:25:45 +0100
Subject: [PATCH v3] doc: fix the switchers menu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-fix-switchers-js-v3-1-61b4401adfdf@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NwQ6CMAyA4VchO1vTFQbDk+9hPAB2MqPMbGRqC
 O/uIPFg9Pg37ddJBPaWg9hlk/AcbbBuSJFvMtH1zXBmsKfUgpAKSVSBsU8IDzt2PfsAlwC6M0W
 hSoltXYl0dvecdlbycEzd2zA6/1o/RLlMF0xhLdUvFiUgKMrZqNywRtq3zo1XO2w7dxMLF+lDl
 EhY/CEIJHCjUWLFxmj1Tczz/AbsrEgG9QAAAA==
X-Change-ID: 20241227-fix-switchers-js-8cf445610b97
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=25583;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=DqPfzctErl0vjVUkNXQN4TJhAiqQRfukEGbTVfEpb+Y=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBphLZ9ME2hNhKBPHtypmdoxk74cDwO62IeC2fEj
 xSkQftRj5eJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYS2fQAKCRDRgEFAKaOo
 Ns+/EADECUgWMzZVJEwkqo+hUP5qtiEobqQiy8CkVzRyedXNQSyUJ3FkzJbtMDbFcKDEGhWWbhO
 4YVDUXwuUR/tos9b0xxpP1LWfZFYDhvpKZ/Xi6RbEQ9KjKA69llIjOSA1hv0qX72layC0iLmtEI
 y17D1j9i+A+GeCwiCVZFPk4q7NMrvz0UfIEmmZ28G7zVQNczBWwMrgW0cBRmHjIX3q3hm1EQZpC
 3E8dtMQv7CDV0nJgj45ifAGnRXbgEOnS7644uvbSn+pCgqFtmnN5lwMnPRPUTAnxqCkIMAkaRTj
 cq5L8omSFGeEm+Sgbm+yH0UFlKjSRZxlPgl+TzQep/QzqggWKmKEqowawqKtGisM9zQClI+GvFg
 x3kcwfaRQzlT3/7EA2/8dPmbkC0TiiTs6OUqLVELTQcWwfd5miQisOXZLzsIebbB295+cIc64NP
 NlYOVcNUzNufj7K2MuOELhl1VUUl9Re11dfhug8zlrHYSdQJC0Kpm6lY//sBLbyVqOjPcNyiwBJ
 pqoQS1TscpfehAg5Q5nT9HWXDDLm91W65m507kvZhfSXYQWIbsz9auDsB3O/EwuF8ID2BhmCq3K
 mTtkJBWG0OTrWvXlAo/JkbhQsT+xdw225Pl0lsKzud1o1DDQteEYzOtxC2ud07xQRCBcCcWRTua
 3rLMpZFdxAZzbhw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 15:26:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18971

Fix the switchers.js script of Bitbake to show what are the supported
versions and be able to switch between them.

The default landing page is the stable branch and shows the BitBake
version along with the corresponding Yocto Project codename. This
hopefully makes it easier to remember the correspondance between the
BitBake version and the Yocto Project version.

This works thanks to a setversions.py script, imported and executed in
conf.py, which is largely inspired from the one in yocto-docs. It reads
the tags from the repository and tries to guess the currently checked
out version of BitBake on which we are.

The "obsolete" warning is now also shown when browsing outdated manuals,
meaning any version not part of activereleases in setversions.py and
"dev"/"next".

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Note: This will be accompanied by a patch to adapt the Autobuilder to
generate this file for each release.
---
Changes in v3:
- Drop the bitbake.yaml file entirely. Right now we don't need this kind
  of file in the BitBake documentation, and so computing the version
  from conf.py is much easier. We do want to keep a separate file though
  as this is backported automatically by the Autobuilder.
- Rename set_versions.py to setversions.py as this is more name format
  for modules.
- Drop the ourseries variable as it wasn't used anywhere.
- Apply suggestions from Quentin.
- Link to v2: https://patch.msgid.link/20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com

Changes in v2:
- Remove environment information grabbing mechanism, making this fully
  standalone.
- Link to v1: https://lore.kernel.org/r/20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com
---
 doc/.gitignore                    |   1 +
 doc/Makefile                      |   2 +-
 doc/conf.py                       |  20 +--
 doc/setversions.py                | 132 ++++++++++++++++++++
 doc/sphinx-static/switchers.js    | 233 -----------------------------------
 doc/sphinx-static/switchers.js.in | 249 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 393 insertions(+), 244 deletions(-)

diff --git a/doc/.gitignore b/doc/.gitignore
index 69fa449dd96..dee9494dcaf 100644
--- a/doc/.gitignore
+++ b/doc/.gitignore
@@ -1 +1,2 @@
 _build/
+sphinx-static/switchers.js
diff --git a/doc/Makefile b/doc/Makefile
index 996f01b7d5c..5e1632314c5 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -27,7 +27,7 @@ publish: Makefile html singlehtml
 	sed -i -e 's@index.html#@singleindex.html#@g' $(BUILDDIR)/$(DESTDIR)/singleindex.html
 
 clean:
-	@rm -rf $(BUILDDIR)
+	@rm -rf $(BUILDDIR) sphinx-static/switchers.js
 
 # Catch-all target: route all unknown targets to Sphinx using the new
 # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
diff --git a/doc/conf.py b/doc/conf.py
index bce386624e2..9318358731c 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -6,20 +6,16 @@
 
 # -- Path setup --------------------------------------------------------------
 
-# If extensions (or modules to document with autodoc) are in another directory,
-# add these directories to sys.path here. If the directory is relative to the
-# documentation root, use os.path.abspath to make it absolute, like shown here.
-#
-# import os
-# import sys
-# sys.path.insert(0, os.path.abspath('.'))
-
-import sys
 import datetime
+import os
+import sys
 
 from pathlib import Path
 
-current_version = "dev"
+sys.path.insert(0, os.path.abspath('.'))
+import setversions
+
+current_version = setversions.get_current_version()
 
 # String used in sidebar
 version = 'Version: ' + current_version
@@ -28,6 +24,10 @@ if current_version == 'dev':
 # Version seen in documentation_options.js and hence in js switchers code
 release = current_version
 
+setversions.write_switchers_js("sphinx-static/switchers.js.in",
+                               "sphinx-static/switchers.js",
+                               current_version)
+
 # -- Project information -----------------------------------------------------
 
 project = 'Bitbake'
diff --git a/doc/setversions.py b/doc/setversions.py
new file mode 100755
index 00000000000..9e4138025ac
--- /dev/null
+++ b/doc/setversions.py
@@ -0,0 +1,132 @@
+#!/usr/bin/env python3
+#
+# This file defines is used in doc/conf.py to setup the version information for
+# the documentation:
+# - get_current_version() used in doc/conf.py computes the current version by
+#   trying to guess the approximate versions we're at using git tags and
+#   branches from the repository.
+# - write_switchers_js() write the switchers.js file used for switching between
+#   versions of the documentation.
+#
+# Copyright (c) 2026 Antonin Godard <antonin.godard@bootlin.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+import itertools
+import re
+import subprocess
+import sys
+
+DEVBRANCH = "2.18"
+LTSSERIES = ["2.8", "2.0"]
+ACTIVERELEASES = ["2.16"] + LTSSERIES
+
+YOCTO_MAPPING = {
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
+BB_RELEASE_TAG_RE = re.compile(r"^[0-9]+\.[0-9]+\.[0-9]+$")
+
+def get_current_version():
+    ourversion = None
+
+    # Test that we are building from a Git repository
+    try:
+        subprocess.run(["git", "rev-parse", "--is-inside-work-tree"],
+                       stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
+    except subprocess.CalledProcessError:
+        sys.exit("Building bitbake's documentation must be done from its Git repository.\n"
+                 "Clone the repository with the following command:\n"
+                 "git clone https://git.openembedded.org/bitbake ")
+
+    # Test tags exist and inform the user to fetch if not
+    try:
+        subprocess.run(["git", "show", f"{LTSSERIES[0]}.0"],
+                       stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
+    except subprocess.CalledProcessError:
+        sys.exit("Please run 'git fetch --tags' before building the documentation")
+
+
+    # Try and figure out what we are
+    tags = subprocess.run(["git", "tag", "--points-at", "HEAD"],
+                          stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                          universal_newlines=True).stdout
+    for t in tags.split():
+        if re.match(BB_RELEASE_TAG_RE, t):
+            ourversion = t
+            break
+
+    if ourversion:
+        # We're a tagged release
+        components = ourversion.split(".")
+    else:
+        # We're floating on a branch
+        branch = subprocess.run(["git", "branch", "--show-current"],
+                                stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                universal_newlines=True).stdout.strip()
+
+        if branch == "" or branch not in list(YOCTO_MAPPING.keys()) + ["master", "master-next"]:
+            # We're not on a known release branch so we have to guess. Compare the
+            # numbers of commits from each release branch and assume the smallest
+            # number of commits is the one we're based off
+            possible_branch = None
+            branch_count = 0
+            for b in itertools.chain(YOCTO_MAPPING.keys(), ["master"]):
+                result = subprocess.run(["git", "log", "--format=oneline", "HEAD..origin/" + b],
+                                        stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                        universal_newlines=True)
+                if result.returncode == 0:
+                    count = result.stdout.count('\n')
+                    if not possible_branch or count < branch_count:
+                        print("Branch %s has count %s" % (b, count))
+                        possible_branch = b
+                        branch_count = count
+            if possible_branch:
+                branch = possible_branch
+            else:
+                branch = "master"
+            print("Nearest release branch estimated to be %s" % branch)
+
+        if branch == "master":
+            ourversion = "dev"
+        elif branch == "master-next":
+            ourversion = "next"
+        else:
+            ourversion = branch
+            head_commit = subprocess.run(["git", "rev-parse", "--short", "HEAD"],
+                                         stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                         universal_newlines=True).stdout.strip()
+            branch_commit = subprocess.run(["git", "rev-parse", "--short", branch],
+                                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
+                                            universal_newlines=True).stdout.strip()
+            if head_commit != branch_commit:
+                ourversion += f" ({head_commit})"
+
+    print("Version calculated to be %s" % ourversion)
+    return ourversion
+
+def write_switchers_js(js_in, js_out, current_version):
+    with open(js_in, "r") as r, open(js_out, "w") as w:
+        lines = r.readlines()
+        for line in lines:
+            if "VERSIONS_PLACEHOLDER" in line:
+                if current_version != "dev":
+                    w.write(f"    'dev': 'Unstable (dev)',\n")
+                for series in ACTIVERELEASES:
+                    w.write(f"    '{series}': '{series} ({YOCTO_MAPPING[series]})',\n")
+            else:
+                w.write(line)
+        print("switchers.js generated from switchers.js.in")
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
index 00000000000..0b209e959da
--- /dev/null
+++ b/doc/sphinx-static/switchers.js.in
@@ -0,0 +1,249 @@
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
+    // if release = "X.Y (<abbrev hash>)", remove the "(<abbrev hash>)" so that only X.Y is compared
+    release = release.split(" ")[0];
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


