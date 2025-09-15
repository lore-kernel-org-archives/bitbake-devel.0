Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC3FCAC59C
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 12:21:41 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web11.31660.1757938898894730446
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 05:21:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=WF/YT4Sk;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E8929C8F1D2;
	Mon, 15 Sep 2025 12:21:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3359E6063F;
	Mon, 15 Sep 2025 12:21:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 74381102F2AB8;
	Mon, 15 Sep 2025 14:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757938896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t6pzO6UYEr+ZZWOtaDILvXwr9OyEY64CiTEoTCn7XS8=;
	b=WF/YT4SktL30nAumFh5I5cwi6tVnMKPqGc6kZm/r/IoTxP4AHEO5R/NG2s/h41Jc9St/FX
	RL/SxMGuzrWlRU4C8CVhYuhrfSZMMu6nfiyMFNXxOCPQ+2iFziGOp7PKQ0m8t6+k/tj1i4
	B+MiV5qHz/1I9bYvFfg/tnC/CxtlF37t01ofKrOCkmTSvfHZCPiEtAvegkcaMiAGOReuLy
	v8L81i34WJVlF14sM0cBGJW53WssrumTgaA+e85D2Jhp+QEtUn0giSBzqd8eAsy58sijno
	lR3AnJ8UpPsHP8TPcY8SfcbQHmgHxJ38BjE1dkcw5Yb9MeFF0kl5a9u/TQVuFQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 15 Sep 2025 14:19:54 +0200
Subject: [PATCH 1/2] doc: fix and automate switchers.js versions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-fix-switchers-js-v1-1-523ef53fe802@bootlin.com>
References: <20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com>
In-Reply-To: <20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19442;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=rzTEO0USf1Je6dVF0IfvmstVxGV6oy4ZvjBGm4plsj8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoyATOZofBnzWJiUKpAEB7LlxGp7/p6KtMZVvbS
 /du35qpoKWJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaMgEzgAKCRDRgEFAKaOo
 NpLbD/97EF+XJYg3ZvUNB4bVMEBkhOPKQ1DAhviOOLGnrpeUtkJHLtNpSFkcdEv83VMBPS/2qyU
 rndCVaDFUeXFj+Ct6sU/QkK6UWzCLKQ6sYwa/JsW2iXrBMmGHI8OtROEZtdtoO2I9tpik+8/jd/
 gVATr/kfQfV6lY18PQdMrm8tl4m20bftDgF09BrhhpUUBc9EomwhGwy+jCIA9RDJzudsWP8lq8y
 bSwXYCW86P8W8HvZg+SDBH6Hb2ax2/GIuqKIybaK8sXBINIKG/Pjgg+bphkPeQ399MEJg31Oqum
 Be9Ruc4hGG/wZFeRXjgmAqbUQpjJPs8MXt7uUhRsIc7oqdc61XhuWaXd2KBR/j0xsQCoKv2zAoh
 MbBbhU7wL3CV9arPjKOWdSf6vXpIHzsS5hYFy2Fdftirum1c+jS8nQsZnA2I094Aas4+8DR+Dkv
 /tHUDLUBBB969kSNJDNVJYnbsMl63LPCw9+qMm5AoPMdqWt1ckFpOq0GE2VqLwoPL9rQySSAWgP
 dofOeT/KF9wlyR3bEmq95BmvBWHVsfkcAq27+n2elobFyx964+Y5CmfkVdXM2oTg2R4Fn8GmHf9
 89OLLbWqvr9C4+MCtM0+FLHoWDLbF/94KeMjyIaub7YBfA3o9UVRmkHyTD610b76K/9EpbX0rfF
 lM/g5nvxMWb1UdQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 12:21:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18024

Like what is done in yocto-docs, make it possible to replace the bitbake
active versions (shown in the switchers menu) from set_versions.py.
There is a default value for the entries in the switcher, otherwise
taken from the environment. This so we can extract the information on
active releases from yocto-docs in the autobuilder and maintain the list
there.

For this to work this switchers.js.in file had to be adapted. It was
originally close to the one from yotco-docs but Bitbake versions work
differently. For this reason the logic in on_version_switch and
on_doctype_switch has changed.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/.gitignore                    |   1 +
 doc/Makefile                      |   3 +-
 doc/set_versions.py               |  53 ++++++++
 doc/sphinx-static/switchers.js    | 233 -----------------------------------
 doc/sphinx-static/switchers.js.in | 250 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 306 insertions(+), 234 deletions(-)

diff --git a/doc/.gitignore b/doc/.gitignore
index 69fa449dd9..dee9494dca 100644
--- a/doc/.gitignore
+++ b/doc/.gitignore
@@ -1 +1,2 @@
 _build/
+sphinx-static/switchers.js
diff --git a/doc/Makefile b/doc/Makefile
index 996f01b7d5..998ba52b8c 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -27,9 +27,10 @@ publish: Makefile html singlehtml
 	sed -i -e 's@index.html#@singleindex.html#@g' $(BUILDDIR)/$(DESTDIR)/singleindex.html
 
 clean:
-	@rm -rf $(BUILDDIR)
+	@rm -rf $(BUILDDIR) sphinx-static/switchers.js
 
 # Catch-all target: route all unknown targets to Sphinx using the new
 # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
 %: Makefile
+	$(SOURCEDIR)/set_versions.py
 	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
diff --git a/doc/set_versions.py b/doc/set_versions.py
new file mode 100755
index 0000000000..d38e7a2a7e
--- /dev/null
+++ b/doc/set_versions.py
@@ -0,0 +1,53 @@
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
+import os
+
+# This variable is replaced automatically when the Autobuilder builds the
+# documentation. We set a default value here for local builds.
+DEFAULT_ACTIVE_RELEASES = """
+    2.12,Walnascar
+    2.8,Scarthgap
+    2.0,Kirkstone
+"""
+
+
+def _split_releases(releases_env: str) -> dict:
+    """
+    Parse input string containing version and codename
+    as "ver1,codename1 ver2,codename2 ...".
+    """
+    releases_out = {}
+    for r in releases_env.split():
+        r = r.split(',')
+        ver, codename = r[0], r[1]
+        releases_out[ver] = codename.capitalize()
+    return releases_out
+
+
+active_releases = _split_releases(os.getenv("BITBAKE_ACTIVE_RELEASES",
+                                            DEFAULT_ACTIVE_RELEASES))
+
+with open("sphinx-static/switchers.js.in", "r") as r, \
+     open("sphinx-static/switchers.js", "w") as w:
+    lines = r.readlines()
+    for line in lines:
+        if "VERSIONS_PLACEHOLDER" in line:
+            w.write("    'dev': 'Unstable (dev)',\n")
+            for ver in active_releases:
+                w.write("    '%s': '%s (%s)',\n"
+                        % (ver, ver, active_releases[ver]))
+        else:
+            w.write(line)
diff --git a/doc/sphinx-static/switchers.js b/doc/sphinx-static/switchers.js
deleted file mode 100644
index 32113cfa96..0000000000
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
index 0000000000..9680112684
--- /dev/null
+++ b/doc/sphinx-static/switchers.js.in
@@ -0,0 +1,250 @@
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
+  function build_version_select(current_series, current_version) {
+    var buf = ["<select>"];
+
+    $.each(all_versions, function (version, title) {
+      var series = version.substr(0, 3);
+      if (series == current_series) {
+        if (version == current_version)
+          buf.push(
+            '<option value="' +
+              version +
+              '" selected="selected">' +
+              title +
+              "</option>",
+          );
+        else buf.push('<option value="' + version + '">' + title + "</option>");
+
+        if (version != current_version)
+          buf.push(
+            '<option value="' +
+              current_version +
+              '" selected="selected">' +
+              current_version +
+              "</option>",
+          );
+      } else {
+        buf.push('<option value="' + version + '">' + title + "</option>");
+      }
+    });
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
+    var version_select = build_version_select(current_series, release);
+
+    $(".version_switcher_placeholder").html(version_select);
+    $(".version_switcher_placeholder select").bind("change", on_version_switch);
+
+    var doctype_select = build_doctype_select(current_doctype);
+
+    $(".doctype_switcher_placeholder").html(doctype_select);
+    $(".doctype_switcher_placeholder select").bind("change", on_doctype_switch);
+
+    if (! ((release == "master") || (release in all_versions))){
+      $("#outdated-warning").html(
+        "Version " +
+          release +
+          " of the project is now considered obsolete, please select and use a more recent version",
+      );
+      $("#outdated-warning").css("padding", ".5em");
+    }
+  });
+})();

-- 
2.51.0


