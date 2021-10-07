Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1F3C4167E
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 15:06:36 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web10.13269.1633619194942225329
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=I9vor3HU;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.160.177,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qt1-f177.google.com with SMTP id e16so6381071qte.13
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pAHB/56B2Q1LiwJ3SgNYTVvV3ONuZJY4VgOCcvcu93Q=;
        b=I9vor3HUgD8qFjL9Y8vR6FSYvhUd6ZcDwxIQB8wcKNhf7EcGIkXKhiriNMMkAG9mE0
         frVFNNIx+5cZJQXw3eeY72JdhdyuOqQkJ0ogrPERhyetFArVKCu3+16umsp3NX7RLtTw
         9dNmtB30UxxtyjsIWd1AYFyi/CKqcYo5CM/XdLmzL5FGqEnqgksV+AUkFBMnNNxDZhjM
         vKkuVIFvejJI3NAYNPPRqMyq0vKCIo62CsxtYlamgTPWwlqEHjQ1zw0hsJEK+M58zx8i
         hSyjNusOvv9SIuqI5PlebsNN8e25q3thnN+UtgmDlbvrsjHuesMWI7fiVsCtg4Su3l7o
         jAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAHB/56B2Q1LiwJ3SgNYTVvV3ONuZJY4VgOCcvcu93Q=;
        b=o9JKYlxvaMFrkIJc/5qaqV962i/oHD2otEfQ1/M7Ti3RATlIYN3m5nkKiTFg20EWdh
         80IVPjSMS9slLpPPGn2AOPrj2tnG2Az+eiMrtuErm8QgXBZe9pYmMbMriarJY+QUBT4S
         gWcRLBnRaYQOzqwPIbGxRTuYzVX5k9iW+v5qy+UsHdr5l9yFSn84QcqBC2lYYtGkbnZR
         mmV2PGe/kNQDcCEGXyGqSiZnvtxsFlx6oNx9JhnTdRv7Cird01Duxh4b54qfd6dlD7GZ
         cMR1W1oLtcM5yWQsls6pzJX1pzd+UDgXsBruk6lPCjP1gksH+ErzBy8nVHGD3A/GJVSv
         YyJg==
X-Gm-Message-State: AOAM5317oAMVeShXY8Wqb5tZbIyHAbMQjK08P7HZ96LRf3zNwBuqMJgu
	hXCcR8xFTbRd18ycTqbPg2exJFboZA1rOg==
X-Google-Smtp-Source: 
 ABdhPJxVrgwBN3TQU7vGE01935bMVPoGrCQibBeqwMSSfQeiEThAyPiRU3ODEqHUHDwTzde/8yLVdQ==
X-Received: by 2002:ac8:5fd3:: with SMTP id k19mr5639591qta.60.1633619193564;
        Thu, 07 Oct 2021 08:06:33 -0700 (PDT)
Received: from localhost ([2605:a601:a650:b700:9937:f30b:7d2e:fddf])
        by smtp.gmail.com with ESMTPSA id
 k2sm15294542qtg.35.2021.10.07.08.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:06:33 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: openembedded-core@lists.openembedded.org,
	docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/8] meta: replace http with https for URLs
Date: Thu,  7 Oct 2021 11:06:25 -0400
Message-Id: <20211007150630.22138-4-jdmason@kudzu.us>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211007150630.22138-1-jdmason@kudzu.us>
References: <20211007150630.22138-1-jdmason@kudzu.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 15:06:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12744

https has been the preferred way to access websites for many years now.
Change all of the URLs with a _working_ https server/certificate to use
that URL.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 README.OE-Core.md                             | 10 ++++-----
 .../devtool/devtool-test-local_6.03.bb        |  2 +-
 .../devtool/devtool-test-patch-gz.bb          |  2 +-
 .../devtool/devtool-upgrade-test2_git.bb      |  2 +-
 .../devtool-upgrade-test2_git.bb.upgraded     |  2 +-
 .../git-submodule-test/git-submodule-test.bb  |  2 +-
 .../recipes-core/busybox/busybox_%.bbappend   |  2 +-
 meta/classes/insane.bbclass                   |  2 +-
 meta/classes/mirrors.bbclass                  | 20 ++++++++---------
 meta/classes/sstate.bbclass                   |  2 +-
 meta/classes/toaster.bbclass                  |  2 +-
 meta/conf/distro/include/maintainers.inc      |  2 +-
 meta/conf/distro/include/yocto-uninative.inc  |  2 +-
 meta/lib/oe/package_manager/__init__.py       |  2 +-
 .../lib/oeqa/manual/toaster-managed-mode.json |  8 +++----
 meta/lib/oeqa/runtime/cases/buildlzip.py      |  2 +-
 meta/lib/oeqa/sdk/cases/buildlzip.py          |  2 +-
 meta/lib/oeqa/selftest/cases/buildoptions.py  | 22 +++++++++----------
 meta/lib/oeqa/selftest/cases/devtool.py       |  4 ++--
 meta/lib/oeqa/selftest/cases/fetch.py         |  2 +-
 meta/lib/oeqa/selftest/cases/recipetool.py    |  2 +-
 meta/recipes-core/dbus-wait/dbus-wait_git.bb  |  2 +-
 .../images/build-appliance-image_15.0.0.bb    |  2 +-
 meta/recipes-core/psplash/psplash_git.bb      |  2 +-
 meta/recipes-devtools/glide/glide_0.13.3.bb   |  4 ++--
 .../opkg-utils/opkg-utils_0.4.5.bb            |  6 ++---
 meta/recipes-devtools/opkg/opkg_0.4.5.bb      |  2 +-
 meta/recipes-devtools/prelink/prelink_git.bb  |  4 ++--
 .../pseudo/files/build-oldlibc                |  2 +-
 meta/recipes-devtools/pseudo/pseudo.inc       |  2 +-
 meta/recipes-devtools/pseudo/pseudo_git.bb    |  4 ++--
 ...ssing-libraries-to-Extension-for-mul.patch |  2 +-
 ...t-fail-to-build-on-some-PPC32-config.patch |  2 +-
 meta/recipes-gnome/gcr/gcr_3.40.0.bb          |  2 +-
 .../libsecret/libsecret_0.20.4.bb             |  2 +-
 .../libfakekey/libfakekey_git.bb              |  2 +-
 .../matchbox-session/matchbox-session_0.1.bb  |  2 +-
 .../matchbox-wm/matchbox-wm_1.2.2.bb          |  2 +-
 .../mini-x-session/mini-x-session_0.1.bb      |  2 +-
 .../xcursor-transparent-theme_git.bb          |  2 +-
 ...-workarounds-in-cpu-features-detecti.patch |  2 +-
 meta/recipes-graphics/xrestop/xrestop_0.4.bb  |  2 +-
 ...der.c-when-env-var-is-set-do-not-fal.patch |  2 +-
 .../matchbox-config-gtk_0.2.bb                |  2 +-
 .../matchbox-desktop/matchbox-desktop_2.2.bb  |  2 +-
 .../matchbox-keyboard_0.1.1.bb                |  2 +-
 .../matchbox-panel-2/matchbox-panel-2_2.11.bb |  2 +-
 .../matchbox-session-sato_0.1.bb              |  2 +-
 .../matchbox-terminal_0.2.bb                  |  2 +-
 .../matchbox-theme-sato.inc                   |  2 +-
 .../sato-screenshot/sato-screenshot_0.3.bb    |  2 +-
 .../settings-daemon/settings-daemon_0.0.2.bb  |  2 +-
 meta/recipes-sato/webkit/webkitgtk_2.32.3.bb  |  2 +-
 meta/recipes-support/icu/icu_69.1.bb          |  2 +-
 .../libunwind/libunwind_1.5.0.bb              |  2 +-
 .../ptest-runner/ptest-runner_2.4.2.bb        |  2 +-
 scripts/autobuilder-worker-prereq-tests       |  6 ++---
 scripts/create-pull-request                   |  4 ++--
 scripts/install-buildtools                    | 10 ++++-----
 scripts/lib/build_perf/html/report.html       |  2 +-
 60 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/README.OE-Core.md b/README.OE-Core.md
index 521916cd4f3f..2f2127fb03a7 100644
--- a/README.OE-Core.md
+++ b/README.OE-Core.md
@@ -6,24 +6,24 @@ of OpenEmbedded. It is distro-less (can build a functional image with
 DISTRO = "nodistro") and contains only emulated machine support.
 
 For information about OpenEmbedded, see the OpenEmbedded website:
-    http://www.openembedded.org/
+    https://www.openembedded.org/
 
 The Yocto Project has extensive documentation about OE including a reference manual
 which can be found at:
-    http://yoctoproject.org/documentation
+    https://docs.yoctoproject.org/
 
 
 Contributing
 ------------
 
 Please refer to
-http://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
+https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
 for guidelines on how to submit patches.
 
 Mailing list:
 
-    http://lists.openembedded.org/mailman/listinfo/openembedded-core
+    https://lists.openembedded.org/g/openembedded-core
 
 Source code:
 
-    http://git.openembedded.org/openembedded-core/
+    https://git.openembedded.org/openembedded-core/
diff --git a/meta-selftest/recipes-test/devtool/devtool-test-local_6.03.bb b/meta-selftest/recipes-test/devtool/devtool-test-local_6.03.bb
index 6bfc557060a3..e95b365ce806 100644
--- a/meta-selftest/recipes-test/devtool/devtool-test-local_6.03.bb
+++ b/meta-selftest/recipes-test/devtool/devtool-test-local_6.03.bb
@@ -3,7 +3,7 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3"
 
 INHIBIT_DEFAULT_DEPS = "1"
 
-SRC_URI = "http://downloads.yoctoproject.org/mirror/sources/syslinux-${PV}.tar.xz \
+SRC_URI = "https://downloads.yoctoproject.org/mirror/sources/syslinux-${PV}.tar.xz \
            file://file1 \
            file://file2"
 
diff --git a/meta-selftest/recipes-test/devtool/devtool-test-patch-gz.bb b/meta-selftest/recipes-test/devtool/devtool-test-patch-gz.bb
index fc3799590cc3..069d0395be98 100644
--- a/meta-selftest/recipes-test/devtool/devtool-test-patch-gz.bb
+++ b/meta-selftest/recipes-test/devtool/devtool-test-patch-gz.bb
@@ -3,7 +3,7 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f"
 
 DEPENDS = "libxres libxext virtual/libx11 ncurses"
 
-SRC_URI = "http://downloads.yoctoproject.org/releases/xrestop/xrestop-0.4.tar.gz \
+SRC_URI = "https://downloads.yoctoproject.org/releases/xrestop/xrestop-0.4.tar.gz \
            file://readme.patch.gz \
            "
 UPSTREAM_VERSION_UNKNOWN = "1"
diff --git a/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git.bb b/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git.bb
index 07b83276fb95..dcb5816da552 100644
--- a/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git.bb
+++ b/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git.bb
@@ -1,5 +1,5 @@
 SUMMARY = "A simple tool to wait for a specific signal over DBus"
-HOMEPAGE = "http://git.yoctoproject.org/cgit/cgit.cgi/dbus-wait"
+HOMEPAGE = "https://git.yoctoproject.org/cgit/cgit.cgi/dbus-wait"
 SECTION = "base"
 LICENSE = "GPLv2"
 LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
diff --git a/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git.bb.upgraded b/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git.bb.upgraded
index 32ec4b14fa62..cef88cbb3351 100644
--- a/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git.bb.upgraded
+++ b/meta-selftest/recipes-test/devtool/devtool-upgrade-test2_git.bb.upgraded
@@ -1,5 +1,5 @@
 SUMMARY = "A simple tool to wait for a specific signal over DBus"
-HOMEPAGE = "http://git.yoctoproject.org/cgit/cgit.cgi/dbus-wait"
+HOMEPAGE = "https://git.yoctoproject.org/cgit/cgit.cgi/dbus-wait"
 SECTION = "base"
 LICENSE = "GPLv2"
 LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
diff --git a/meta-selftest/recipes-test/git-submodule-test/git-submodule-test.bb b/meta-selftest/recipes-test/git-submodule-test/git-submodule-test.bb
index 9429564df43d..41e50b792e0b 100644
--- a/meta-selftest/recipes-test/git-submodule-test/git-submodule-test.bb
+++ b/meta-selftest/recipes-test/git-submodule-test/git-submodule-test.bb
@@ -1,5 +1,5 @@
 SUMMARY = "Test recipe for fetching git submodules"
-HOMEPAGE = "http://git.yoctoproject.org/cgit/cgit.cgi/git-submodule-test/"
+HOMEPAGE = "https://git.yoctoproject.org/cgit/cgit.cgi/git-submodule-test/"
 LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
 
diff --git a/meta-skeleton/recipes-core/busybox/busybox_%.bbappend b/meta-skeleton/recipes-core/busybox/busybox_%.bbappend
index 621c94f651f5..79353bf61e4d 100644
--- a/meta-skeleton/recipes-core/busybox/busybox_%.bbappend
+++ b/meta-skeleton/recipes-core/busybox/busybox_%.bbappend
@@ -5,7 +5,7 @@
 # when DISTRO = "mydistro" is defined in your conf/local.conf file.
 #
 # More details can be found in the Kernel Dev Manual
-# http://www.yoctoproject.org/docs/current/kernel-dev/kernel-dev.html#changing-the-configuration
+# https://www.yoctoproject.org/docs/current/kernel-dev/kernel-dev.html#changing-the-configuration
 FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
 SRC_URI:append:mydistro += " \
diff --git a/meta/classes/insane.bbclass b/meta/classes/insane.bbclass
index f2d2ca3689fd..bb6fb8145f9e 100644
--- a/meta/classes/insane.bbclass
+++ b/meta/classes/insane.bbclass
@@ -1132,7 +1132,7 @@ python do_qa_patch() {
     # Check patch.log for fuzz warnings
     #
     # Further information on why we check for patch fuzz warnings:
-    # http://lists.openembedded.org/pipermail/openembedded-core/2018-March/148675.html
+    # https://www.openembedded.org/pipermail/openembedded-core/2018-March/148675.html
     # https://bugzilla.yoctoproject.org/show_bug.cgi?id=10450
     ###########################################################################
 
diff --git a/meta/classes/mirrors.bbclass b/meta/classes/mirrors.bbclass
index ba325a658bc1..90f5d6cf2cfa 100644
--- a/meta/classes/mirrors.bbclass
+++ b/meta/classes/mirrors.bbclass
@@ -40,16 +40,16 @@ ${SAVANNAH_NONGNU_MIRROR} http://download-mirror.savannah.nongnu.org/releases \n
 ftp://sourceware.org/pub http://mirrors.kernel.org/sourceware \n \
 ftp://sourceware.org/pub http://gd.tuwien.ac.at/gnu/sourceware \n \
 ftp://sourceware.org/pub http://ftp.gwdg.de/pub/linux/sources.redhat.com/sourceware \n \
-cvs://.*/.*     http://downloads.yoctoproject.org/mirror/sources/ \n \
-svn://.*/.*     http://downloads.yoctoproject.org/mirror/sources/ \n \
-git://.*/.*     http://downloads.yoctoproject.org/mirror/sources/ \n \
-hg://.*/.*      http://downloads.yoctoproject.org/mirror/sources/ \n \
-bzr://.*/.*     http://downloads.yoctoproject.org/mirror/sources/ \n \
-p4://.*/.*      http://downloads.yoctoproject.org/mirror/sources/ \n \
-osc://.*/.*     http://downloads.yoctoproject.org/mirror/sources/ \n \
-https?$://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-ftp://.*/.*     http://downloads.yoctoproject.org/mirror/sources/ \n \
-npm://.*/?.*    http://downloads.yoctoproject.org/mirror/sources/ \n \
+cvs://.*/.*     https://downloads.yoctoproject.org/mirror/sources/ \n \
+svn://.*/.*     https://downloads.yoctoproject.org/mirror/sources/ \n \
+git://.*/.*     https://downloads.yoctoproject.org/mirror/sources/ \n \
+hg://.*/.*      https://downloads.yoctoproject.org/mirror/sources/ \n \
+bzr://.*/.*     https://downloads.yoctoproject.org/mirror/sources/ \n \
+p4://.*/.*      https://downloads.yoctoproject.org/mirror/sources/ \n \
+osc://.*/.*     https://downloads.yoctoproject.org/mirror/sources/ \n \
+https?$://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+ftp://.*/.*     https://downloads.yoctoproject.org/mirror/sources/ \n \
+npm://.*/?.*    https://downloads.yoctoproject.org/mirror/sources/ \n \
 cvs://.*/.*     http://sources.openembedded.org/ \n \
 svn://.*/.*     http://sources.openembedded.org/ \n \
 git://.*/.*     http://sources.openembedded.org/ \n \
diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 7f4b1f6804cc..5810d7b56674 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -1112,7 +1112,7 @@ def setscene_depvalid(task, taskdependees, notneeded, d, log=None):
             # Allow excluding certain recursive dependencies. If a recipe needs it should add a
             # specific dependency itself, rather than relying on one of its dependees to pull
             # them in.
-            # See also http://lists.openembedded.org/pipermail/openembedded-core/2018-January/146324.html
+            # See also https://www.openembedded.org/pipermail/openembedded-core/2018-January/146324.html
             not_needed = False
             excludedeps = d.getVar('_SSTATE_EXCLUDEDEPS_SYSROOT')
             if excludedeps is None:
diff --git a/meta/classes/toaster.bbclass b/meta/classes/toaster.bbclass
index dd5c7f224ba8..ef987656d2a2 100644
--- a/meta/classes/toaster.bbclass
+++ b/meta/classes/toaster.bbclass
@@ -69,7 +69,7 @@ python toaster_layerinfo_dumpdata() {
 
         layer_info = {}
         layer_name = layer_path.split('/')[-1]
-        layer_url = 'http://layers.openembedded.org/layerindex/layer/{layer}/'
+        layer_url = 'https://layers.openembedded.org/layerindex/layer/{layer}/'
         layer_url_name = _get_url_map_name(layer_name)
 
         layer_info['name'] = layer_url_name
diff --git a/meta/conf/distro/include/maintainers.inc b/meta/conf/distro/include/maintainers.inc
index 8592de5a6682..f3d68a0ad0b4 100644
--- a/meta/conf/distro/include/maintainers.inc
+++ b/meta/conf/distro/include/maintainers.inc
@@ -12,7 +12,7 @@
 # questions in the future), but please try to do the following first:
 #
 #  - look in the Yocto Project Bugzilla
-#    (http://bugzilla.yoctoproject.org/) to see if a problem has
+#    (https://bugzilla.yoctoproject.org/) to see if a problem has
 #    already been reported
 #
 # - look through recent entries of the appropriate mailing list archives
diff --git a/meta/conf/distro/include/yocto-uninative.inc b/meta/conf/distro/include/yocto-uninative.inc
index 3165fc93b899..8b0bfcb5cd0d 100644
--- a/meta/conf/distro/include/yocto-uninative.inc
+++ b/meta/conf/distro/include/yocto-uninative.inc
@@ -8,7 +8,7 @@
 
 UNINATIVE_MAXGLIBCVERSION = "2.34"
 
-UNINATIVE_URL ?= "http://downloads.yoctoproject.org/releases/uninative/3.4/"
+UNINATIVE_URL ?= "https://downloads.yoctoproject.org/releases/uninative/3.4/"
 UNINATIVE_CHECKSUM[aarch64] ?= "3013cdda8f0dc6639ce1c80f33eabce66f06b890bd5b58739a6d7a92a0bb7100"
 UNINATIVE_CHECKSUM[i686] ?= "abed500de584aad63ec237546db20cdd0c69d8870a6f8e94ac31721ace64b376"
 UNINATIVE_CHECKSUM[x86_64] ?= "126f4f7f6f21084ee140dac3eb4c536b963837826b7c38599db0b512c3377ba2"
diff --git a/meta/lib/oe/package_manager/__init__.py b/meta/lib/oe/package_manager/__init__.py
index 8f7b60e07703..bf8fa115382a 100644
--- a/meta/lib/oe/package_manager/__init__.py
+++ b/meta/lib/oe/package_manager/__init__.py
@@ -309,7 +309,7 @@ class PackageManager(object, metaclass=ABCMeta):
         """
         Add remote package feeds into repository manager configuration. The parameters
         for the feeds are set by feed_uris, feed_base_paths and feed_archs.
-        See http://www.yoctoproject.org/docs/current/ref-manual/ref-manual.html#var-PACKAGE_FEED_URIS
+        See https://www.yoctoproject.org/docs/current/ref-manual/ref-manual.html#var-PACKAGE_FEED_URIS
         for their description.
         """
         pass
diff --git a/meta/lib/oeqa/manual/toaster-managed-mode.json b/meta/lib/oeqa/manual/toaster-managed-mode.json
index 1a71985c3c16..17b0d81f7386 100644
--- a/meta/lib/oeqa/manual/toaster-managed-mode.json
+++ b/meta/lib/oeqa/manual/toaster-managed-mode.json
@@ -2176,7 +2176,7 @@
       ],
       "execution": {
         "1": {
-          "action": "Clone the poky environment     git clone http://git.yoctoproject.org/git/poky",
+          "action": "Clone the poky environment     git clone https://git.yoctoproject.org/git/poky",
           "expected_results": ""
         },
         "2": {
@@ -2458,7 +2458,7 @@
       ],
       "execution": {
         "1": {
-          "action": "Clone the poky environment     git clone http://git.yoctoproject.org/git/poky",
+          "action": "Clone the poky environment     git clone https://git.yoctoproject.org/git/poky",
           "expected_results": ""
         },
         "2": {
@@ -2496,7 +2496,7 @@
       ],
       "execution": {
         "1": {
-          "action": "Clone the poky environment     git clone http://git.yoctoproject.org/git/poky\n",
+          "action": "Clone the poky environment     git clone https://git.yoctoproject.org/git/poky\n",
           "expected_results": ""
         },
         "2": {
@@ -2513,7 +2513,7 @@
         },
         "5": {
           "action": "Remove all the layers from the project",
-          "expected_results": " you should see a message that reads:  \n\nYou need to add some layers. For that you can:  \n\n-View all layers compatible with this project  \n\n-Import a layer  \n\n-Read about layers in the documentation  \n\nOr type a layer name below.  \n\n\n The \"Choose from the layers compatible with this project\" link should go to the compatible layers page The \"Import a layer\" link should go to the import layer page The \"Read about layers in the documentation\" link should open in a new window and bring you to http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#understanding-and-creating-layers"
+          "expected_results": " you should see a message that reads:  \n\nYou need to add some layers. For that you can:  \n\n-View all layers compatible with this project  \n\n-Import a layer  \n\n-Read about layers in the documentation  \n\nOr type a layer name below.  \n\n\n The \"Choose from the layers compatible with this project\" link should go to the compatible layers page The \"Import a layer\" link should go to the import layer page The \"Read about layers in the documentation\" link should open in a new window and bring you to https://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#understanding-and-creating-layers"
         }
       },
       "summary": "Verify_delete_layer_functionality"
diff --git a/meta/lib/oeqa/runtime/cases/buildlzip.py b/meta/lib/oeqa/runtime/cases/buildlzip.py
index bc70b4146121..37afce5f713e 100644
--- a/meta/lib/oeqa/runtime/cases/buildlzip.py
+++ b/meta/lib/oeqa/runtime/cases/buildlzip.py
@@ -12,7 +12,7 @@ class BuildLzipTest(OERuntimeTestCase):
 
     @classmethod
     def setUpClass(cls):
-        uri = 'http://downloads.yoctoproject.org/mirror/sources'
+        uri = 'https://downloads.yoctoproject.org/mirror/sources'
         uri = '%s/lzip-1.19.tar.gz' % uri
         cls.project = TargetBuildProject(cls.tc.target,
                                          uri,
diff --git a/meta/lib/oeqa/sdk/cases/buildlzip.py b/meta/lib/oeqa/sdk/cases/buildlzip.py
index 49ae756bf3c4..c1358b69d21d 100644
--- a/meta/lib/oeqa/sdk/cases/buildlzip.py
+++ b/meta/lib/oeqa/sdk/cases/buildlzip.py
@@ -13,7 +13,7 @@ class BuildLzipTest(OESDKTestCase):
     """
     def test_lzip(self):
         with tempfile.TemporaryDirectory(prefix="lzip", dir=self.tc.sdk_dir) as testdir:
-            tarball = self.fetch(testdir, self.td["DL_DIR"], "http://downloads.yoctoproject.org/mirror/sources/lzip-1.19.tar.gz")
+            tarball = self.fetch(testdir, self.td["DL_DIR"], "https://downloads.yoctoproject.org/mirror/sources/lzip-1.19.tar.gz")
 
             dirs = {}
             dirs["source"] = os.path.join(testdir, "lzip-1.19")
diff --git a/meta/lib/oeqa/selftest/cases/buildoptions.py b/meta/lib/oeqa/selftest/cases/buildoptions.py
index f99881758e3a..4dc0a3ae1c15 100644
--- a/meta/lib/oeqa/selftest/cases/buildoptions.py
+++ b/meta/lib/oeqa/selftest/cases/buildoptions.py
@@ -206,17 +206,17 @@ DL_DIR = "${TMPDIR}/test_downloads"
 STAMPS_DIR = "${TMPDIR}/test_stamps"
 SSTATE_DIR = "${TMPDIR}/test_sstate-cache"
 PREMIRRORS = "\\
-    bzr://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \\n \\
-    cvs://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \\n \\
-    git://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \\n \\
-    gitsm://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \\n \\
-    hg://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \\n \\
-    osc://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \\n \\
-    p4://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \\n \\
-    svn://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \\n \\
-    ftp://.*/.*      http://downloads.yoctoproject.org/mirror/sources/ \\n \\
-    http://.*/.*     http://downloads.yoctoproject.org/mirror/sources/ \\n \\
-    https://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \\n"
+    bzr://.*/.*   https://downloads.yoctoproject.org/mirror/sources/ \\n \\
+    cvs://.*/.*   https://downloads.yoctoproject.org/mirror/sources/ \\n \\
+    git://.*/.*   https://downloads.yoctoproject.org/mirror/sources/ \\n \\
+    gitsm://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \\n \\
+    hg://.*/.*    https://downloads.yoctoproject.org/mirror/sources/ \\n \\
+    osc://.*/.*   https://downloads.yoctoproject.org/mirror/sources/ \\n \\
+    p4://.*/.*    https://downloads.yoctoproject.org/mirror/sources/ \\n \\
+    svn://.*/.*   https://downloads.yoctoproject.org/mirror/sources/ \\n \\
+    ftp://.*/.*      https://downloads.yoctoproject.org/mirror/sources/ \\n \\
+    http://.*/.*     https://downloads.yoctoproject.org/mirror/sources/ \\n \\
+    https://.*/.*    https://downloads.yoctoproject.org/mirror/sources/ \\n"
 """)
 
         bitbake("world --runall fetch")
diff --git a/meta/lib/oeqa/selftest/cases/devtool.py b/meta/lib/oeqa/selftest/cases/devtool.py
index f495e84c79b8..ac9ebd601915 100644
--- a/meta/lib/oeqa/selftest/cases/devtool.py
+++ b/meta/lib/oeqa/selftest/cases/devtool.py
@@ -269,7 +269,7 @@ class DevtoolAddTests(DevtoolBase):
         self.track_for_cleanup(tempdir)
         pn = 'pv'
         pv = '1.5.3'
-        url = 'http://downloads.yoctoproject.org/mirror/sources/pv-1.5.3.tar.bz2'
+        url = 'https://downloads.yoctoproject.org/mirror/sources/pv-1.5.3.tar.bz2'
         result = runCmd('wget %s' % url, cwd=tempdir)
         result = runCmd('tar xfv %s' % os.path.basename(url), cwd=tempdir)
         srcdir = os.path.join(tempdir, '%s-%s' % (pn, pv))
@@ -1788,7 +1788,7 @@ class DevtoolUpgradeTests(DevtoolBase):
         recipename = 'i2c-tools'
         recipever = '3.1.2'
         recipefile = os.path.join(self.workspacedir, 'recipes', recipename, '%s_%s.bb' % (recipename, recipever))
-        url = 'http://downloads.yoctoproject.org/mirror/sources/i2c-tools-%s.tar.bz2' % recipever
+        url = 'https://downloads.yoctoproject.org/mirror/sources/i2c-tools-%s.tar.bz2' % recipever
         def add_recipe():
             result = runCmd('devtool add %s' % url)
             self.assertExists(recipefile, 'Expected recipe file not created')
diff --git a/meta/lib/oeqa/selftest/cases/fetch.py b/meta/lib/oeqa/selftest/cases/fetch.py
index 9aa91e59c13d..d9c1e17f7b62 100644
--- a/meta/lib/oeqa/selftest/cases/fetch.py
+++ b/meta/lib/oeqa/selftest/cases/fetch.py
@@ -47,7 +47,7 @@ PREMIRRORS:forcevariable = ""
         features = """
 DL_DIR = "%s"
 GIT_PROXY_COMMAND = "false"
-MIRRORS:forcevariable = "git://.*/.* http://downloads.yoctoproject.org/mirror/sources/"
+MIRRORS:forcevariable = "git://.*/.* https://downloads.yoctoproject.org/mirror/sources/"
 """ % dldir
         self.write_config(features)
         oe.path.remove(dldir, recurse=True)
diff --git a/meta/lib/oeqa/selftest/cases/recipetool.py b/meta/lib/oeqa/selftest/cases/recipetool.py
index c2a53815d0ea..1100971d9ded 100644
--- a/meta/lib/oeqa/selftest/cases/recipetool.py
+++ b/meta/lib/oeqa/selftest/cases/recipetool.py
@@ -509,7 +509,7 @@ class RecipetoolTests(RecipetoolBase):
         temprecipe = os.path.join(self.tempdir, 'recipe')
         os.makedirs(temprecipe)
         recipefile = os.path.join(temprecipe, 'matchbox-terminal_git.bb')
-        srcuri = 'http://git.yoctoproject.org/git/matchbox-terminal'
+        srcuri = 'https://git.yoctoproject.org/git/matchbox-terminal'
         result = runCmd('recipetool create -o %s %s' % (temprecipe, srcuri))
         self.assertTrue(os.path.isfile(recipefile))
         checkvars = {}
diff --git a/meta/recipes-core/dbus-wait/dbus-wait_git.bb b/meta/recipes-core/dbus-wait/dbus-wait_git.bb
index 677768d35a35..8f049cb417f8 100644
--- a/meta/recipes-core/dbus-wait/dbus-wait_git.bb
+++ b/meta/recipes-core/dbus-wait/dbus-wait_git.bb
@@ -1,5 +1,5 @@
 SUMMARY = "A simple tool to wait for a specific signal over DBus"
-HOMEPAGE = "http://git.yoctoproject.org/cgit/cgit.cgi/dbus-wait"
+HOMEPAGE = "https://git.yoctoproject.org/cgit/cgit.cgi/dbus-wait"
 DESCRIPTION = "${SUMMARY}"
 SECTION = "base"
 LICENSE = "GPLv2"
diff --git a/meta/recipes-core/images/build-appliance-image_15.0.0.bb b/meta/recipes-core/images/build-appliance-image_15.0.0.bb
index 86dc691297d1..ebcef783aec8 100644
--- a/meta/recipes-core/images/build-appliance-image_15.0.0.bb
+++ b/meta/recipes-core/images/build-appliance-image_15.0.0.bb
@@ -1,6 +1,6 @@
 SUMMARY = "An image containing the build system itself"
 DESCRIPTION = "An image containing the build system that you can boot and run using either VirtualBox, VMware Player or VMware Workstation."
-HOMEPAGE = "http://www.yoctoproject.org/documentation/build-appliance"
+HOMEPAGE = "https://www.yoctoproject.org/software-item/build-appliance/"
 
 LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
diff --git a/meta/recipes-core/psplash/psplash_git.bb b/meta/recipes-core/psplash/psplash_git.bb
index 1be7ece79d98..5c76aa993c60 100644
--- a/meta/recipes-core/psplash/psplash_git.bb
+++ b/meta/recipes-core/psplash/psplash_git.bb
@@ -1,6 +1,6 @@
 SUMMARY = "Userspace framebuffer boot logo based on usplash"
 DESCRIPTION = "PSplash is a userspace graphical boot splash screen for mainly embedded Linux devices supporting a 16bpp or 32bpp framebuffer. It has few dependencies (just libc), supports basic images and text and handles rotation. Its visual look is configurable by basic source changes. Also included is a 'client' command utility for sending information to psplash such as boot progress information."
-HOMEPAGE = "http://git.yoctoproject.org/cgit/cgit.cgi/psplash"
+HOMEPAGE = "https://git.yoctoproject.org/cgit/cgit.cgi/psplash"
 SECTION = "base"
 LICENSE = "GPLv2+"
 LIC_FILES_CHKSUM = "file://psplash.h;beginline=1;endline=8;md5=8f232c1e95929eacab37f00900580224"
diff --git a/meta/recipes-devtools/glide/glide_0.13.3.bb b/meta/recipes-devtools/glide/glide_0.13.3.bb
index e943dc1762a5..06bb717cbaf0 100644
--- a/meta/recipes-devtools/glide/glide_0.13.3.bb
+++ b/meta/recipes-devtools/glide/glide_0.13.3.bb
@@ -20,12 +20,12 @@ RDEPENDS:${PN}-ptest += "bash"
 BBCLASSEXTEND = "native nativesdk"
 
 # for x86 ends with textrel in ${PN}
-# http://errors.yoctoproject.org/Errors/Details/185631/
+# https://errors.yoctoproject.org/Errors/Details/185631/
 # ERROR: QA Issue: ELF binary '/work/i586-oe-linux/glide/0.13.1-r0/packages-split/glide/usr/bin/glide' has relocations in .text [textrel]
 INSANE_SKIP:${PN} += "textrel"
 
 # for aarch64 ends with textrel in ${PN}-ptest
-# http://errors.yoctoproject.org/Errors/Details/185633/
+# https://errors.yoctoproject.org/Errors/Details/185633/
 # ERROR: QA Issue: ELF binary '/work/aarch64-oe-linux/glide/0.13.1-r0/packages-split/glide-ptest/usr/lib/glide/ptest/github.com/Masterminds/glide/glide.test' has relocations in .text
 # ELF binary '/work/aarch64-oe-linux/glide/0.13.1-r0/packages-split/glide-ptest/usr/lib/glide/ptest/github.com/Masterminds/glide/dependency/dependency.test' has relocations in .text
 # ELF binary '/work/aarch64-oe-linux/glide/0.13.1-r0/packages-split/glide-ptest/usr/lib/glide/ptest/github.com/Masterminds/glide/repo/repo.test' has relocations in .text
diff --git a/meta/recipes-devtools/opkg-utils/opkg-utils_0.4.5.bb b/meta/recipes-devtools/opkg-utils/opkg-utils_0.4.5.bb
index a2bcc7f66116..f056ae1c4323 100644
--- a/meta/recipes-devtools/opkg-utils/opkg-utils_0.4.5.bb
+++ b/meta/recipes-devtools/opkg-utils/opkg-utils_0.4.5.bb
@@ -1,16 +1,16 @@
 SUMMARY = "Additional utilities for the opkg package manager"
 SUMMARY:update-alternatives-opkg = "Utility for managing the alternatives system"
 SECTION = "base"
-HOMEPAGE = "http://git.yoctoproject.org/cgit/cgit.cgi/opkg-utils"
+HOMEPAGE = "https://git.yoctoproject.org/cgit/cgit.cgi/opkg-utils"
 LICENSE = "GPLv2+"
 LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f \
                     file://opkg.py;beginline=2;endline=18;md5=ffa11ff3c15eb31c6a7ceaa00cc9f986"
 PROVIDES += "${@bb.utils.contains('PACKAGECONFIG', 'update-alternatives', 'virtual/update-alternatives', '', d)}"
 
-SRC_URI = "http://git.yoctoproject.org/cgit/cgit.cgi/${BPN}/snapshot/${BPN}-${PV}.tar.gz \
+SRC_URI = "https://git.yoctoproject.org/cgit/cgit.cgi/${BPN}/snapshot/${BPN}-${PV}.tar.gz \
            file://0001-update-alternatives-correctly-match-priority.patch \
            "
-UPSTREAM_CHECK_URI = "http://git.yoctoproject.org/cgit/cgit.cgi/opkg-utils/refs/"
+UPSTREAM_CHECK_URI = "https://git.yoctoproject.org/cgit/cgit.cgi/opkg-utils/refs/"
 
 SRC_URI[md5sum] = "025b19744e5c7fc1c8380e17df1fcc64"
 SRC_URI[sha256sum] = "528635e674addea5c2b3a3268404ad04a952c4f410d17c3d754f5dd5529770c9"
diff --git a/meta/recipes-devtools/opkg/opkg_0.4.5.bb b/meta/recipes-devtools/opkg/opkg_0.4.5.bb
index ef18ccf63a84..e0a3206b3c5e 100644
--- a/meta/recipes-devtools/opkg/opkg_0.4.5.bb
+++ b/meta/recipes-devtools/opkg/opkg_0.4.5.bb
@@ -12,7 +12,7 @@ DEPENDS = "libarchive"
 
 PE = "1"
 
-SRC_URI = "http://downloads.yoctoproject.org/releases/${BPN}/${BPN}-${PV}.tar.gz \
+SRC_URI = "https://downloads.yoctoproject.org/releases/${BPN}/${BPN}-${PV}.tar.gz \
            file://opkg.conf \
            file://0001-opkg_conf-create-opkg.lock-in-run-instead-of-var-run.patch \
            file://run-ptest \
diff --git a/meta/recipes-devtools/prelink/prelink_git.bb b/meta/recipes-devtools/prelink/prelink_git.bb
index 24713b61f847..91605494f874 100644
--- a/meta/recipes-devtools/prelink/prelink_git.bb
+++ b/meta/recipes-devtools/prelink/prelink_git.bb
@@ -3,7 +3,7 @@ SECTION = "devel"
 # Would need transfig-native for documentation if it wasn't disabled
 DEPENDS = "elfutils binutils"
 SUMMARY = "An ELF prelinking utility"
-HOMEPAGE = "http://git.yoctoproject.org/cgit.cgi/prelink-cross/about/"
+HOMEPAGE = "https://git.yoctoproject.org/cgit.cgi/prelink-cross/about/"
 DESCRIPTION = "The prelink package contains a utility which modifies ELF shared libraries \
 and executables, so that far fewer relocations need to be resolved at \
 runtime and thus programs come up faster."
@@ -49,7 +49,7 @@ inherit autotools
 BBCLASSEXTEND = "native"
 
 EXTRA_OECONF = "--with-pkgversion=${PV}-${PR} \
-	--with-bugurl=http://bugzilla.yoctoproject.org/"
+	--with-bugurl=https://bugzilla.yoctoproject.org/"
 
 PACKAGECONFIG ??= ""
 PACKAGECONFIG[selinux] = "--enable-selinux,--disable-selinux,libselinux"
diff --git a/meta/recipes-devtools/pseudo/files/build-oldlibc b/meta/recipes-devtools/pseudo/files/build-oldlibc
index 85c438de4e02..2f8a527e53fa 100755
--- a/meta/recipes-devtools/pseudo/files/build-oldlibc
+++ b/meta/recipes-devtools/pseudo/files/build-oldlibc
@@ -9,7 +9,7 @@
 
 for i in x86_64 aarch64 i686; do
     if [ ! -e $i-nativesdk-libc.tar.xz ]; then
-        wget http://downloads.yoctoproject.org/releases/uninative/3.2/$i-nativesdk-libc.tar.xz
+        wget https://downloads.yoctoproject.org/releases/uninative/3.2/$i-nativesdk-libc.tar.xz
     fi
     tar -xf $i-nativesdk-libc.tar.xz --wildcards \*/lib/libpthread\* \*/lib/libdl\*
     cd $i-linux/lib
diff --git a/meta/recipes-devtools/pseudo/pseudo.inc b/meta/recipes-devtools/pseudo/pseudo.inc
index 7ba414ca25d8..da5b254f092f 100644
--- a/meta/recipes-devtools/pseudo/pseudo.inc
+++ b/meta/recipes-devtools/pseudo/pseudo.inc
@@ -3,7 +3,7 @@
 # BBFETCH2=True PSEUDO_BUILD=1 ../bitbake/bin/bitbake pseudo-native [-c CMD]
 
 SUMMARY = "Pseudo gives fake root capabilities to a normal user"
-HOMEPAGE = "http://git.yoctoproject.org/cgit/cgit.cgi/pseudo"
+HOMEPAGE = "https://git.yoctoproject.org/cgit/cgit.cgi/pseudo"
 DESCRIPTION = "The pseudo utility offers a way to run commands in a virtualized root environment."
 LIC_FILES_CHKSUM = "file://COPYING;md5=a1d8023a6f953ac6ea4af765ff62d574"
 SECTION = "base"
diff --git a/meta/recipes-devtools/pseudo/pseudo_git.bb b/meta/recipes-devtools/pseudo/pseudo_git.bb
index 7acb1d64d59a..1983ac48a04a 100644
--- a/meta/recipes-devtools/pseudo/pseudo_git.bb
+++ b/meta/recipes-devtools/pseudo/pseudo_git.bb
@@ -6,10 +6,10 @@ SRC_URI = "git://git.yoctoproject.org/pseudo;branch=oe-core \
            file://fallback-group \
            "
 SRC_URI:append:class-native = " \
-    http://downloads.yoctoproject.org/mirror/sources/pseudo-prebuilt-2.33.tar.xz;subdir=git/prebuilt;name=prebuilt \
+    https://downloads.yoctoproject.org/mirror/sources/pseudo-prebuilt-2.33.tar.xz;subdir=git/prebuilt;name=prebuilt \
     file://older-glibc-symbols.patch"
 SRC_URI:append:class-nativesdk = " \
-    http://downloads.yoctoproject.org/mirror/sources/pseudo-prebuilt-2.33.tar.xz;subdir=git/prebuilt;name=prebuilt \
+    https://downloads.yoctoproject.org/mirror/sources/pseudo-prebuilt-2.33.tar.xz;subdir=git/prebuilt;name=prebuilt \
     file://older-glibc-symbols.patch"
 SRC_URI[prebuilt.sha256sum] = "ed9f456856e9d86359f169f46a70ad7be4190d6040282b84c8d97b99072485aa"
 
diff --git a/meta/recipes-devtools/python/python3/0001-setup.py-pass-missing-libraries-to-Extension-for-mul.patch b/meta/recipes-devtools/python/python3/0001-setup.py-pass-missing-libraries-to-Extension-for-mul.patch
index ea0af02e7204..cf1d60be33a6 100644
--- a/meta/recipes-devtools/python/python3/0001-setup.py-pass-missing-libraries-to-Extension-for-mul.patch
+++ b/meta/recipes-devtools/python/python3/0001-setup.py-pass-missing-libraries-to-Extension-for-mul.patch
@@ -26,7 +26,7 @@ and `__old_sem_getvalue' is to compat the old version
 sem_getvalue@GLIBC_2.0.
 
 To build python for embedded Linux systems:
-http://www.yoctoproject.org/docs/2.3.1/yocto-project-qs/yocto-project-qs.html
+https://www.yoctoproject.org/docs/2.3.1/yocto-project-qs/yocto-project-qs.html
 If not explicitly link to library pthread (-lpthread), it will
 load glibc's sem_getvalue randomly at runtime.
 
diff --git a/meta/recipes-devtools/valgrind/valgrind/0001-Remove-tests-that-fail-to-build-on-some-PPC32-config.patch b/meta/recipes-devtools/valgrind/valgrind/0001-Remove-tests-that-fail-to-build-on-some-PPC32-config.patch
index a78e1953ff55..fbeda93cc279 100644
--- a/meta/recipes-devtools/valgrind/valgrind/0001-Remove-tests-that-fail-to-build-on-some-PPC32-config.patch
+++ b/meta/recipes-devtools/valgrind/valgrind/0001-Remove-tests-that-fail-to-build-on-some-PPC32-config.patch
@@ -4,7 +4,7 @@ Date: Fri, 8 Jan 2016 16:36:29 +0200
 Subject: [PATCH] Remove tests that fail to build on some PPC32 configurations
 
 Failures are documented here:
-http://errors.yoctoproject.org/Errors/Search/?items=10&query=862d702fbb99e484631315aa44b9e46f8fc567da&filter=valgrind&type=recipe
+https://errors.yoctoproject.org/Errors/Search/?items=10&query=862d702fbb99e484631315aa44b9e46f8fc567da&filter=valgrind&type=recipe
 
 Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
 Upstream-Status: Pending
diff --git a/meta/recipes-gnome/gcr/gcr_3.40.0.bb b/meta/recipes-gnome/gcr/gcr_3.40.0.bb
index a05e753ee94b..c439185d11bb 100644
--- a/meta/recipes-gnome/gcr/gcr_3.40.0.bb
+++ b/meta/recipes-gnome/gcr/gcr_3.40.0.bb
@@ -29,7 +29,7 @@ FILES:${PN} += " \
     ${datadir}/gcr-3 \
 "
 
-# http://errors.yoctoproject.org/Errors/Details/20229/
+# https://errors.yoctoproject.org/Errors/Details/20229/
 ARM_INSTRUCTION_SET:armv4 = "arm"
 ARM_INSTRUCTION_SET:armv5 = "arm"
 ARM_INSTRUCTION_SET:armv6 = "arm"
diff --git a/meta/recipes-gnome/libsecret/libsecret_0.20.4.bb b/meta/recipes-gnome/libsecret/libsecret_0.20.4.bb
index 9c1f97b8f840..93344e89368d 100644
--- a/meta/recipes-gnome/libsecret/libsecret_0.20.4.bb
+++ b/meta/recipes-gnome/libsecret/libsecret_0.20.4.bb
@@ -22,7 +22,7 @@ GTKDOC_MESON_OPTION = 'gtk_doc'
 
 PACKAGECONFIG[manpages] = "-Dmanpage=true,-Dmanpage=false,libxslt-native xmlto-native"
 
-# http://errors.yoctoproject.org/Errors/Details/20228/
+# https://errors.yoctoproject.org/Errors/Details/20228/
 ARM_INSTRUCTION_SET:armv4 = "arm"
 ARM_INSTRUCTION_SET:armv5 = "arm"
 ARM_INSTRUCTION_SET:armv6 = "arm"
diff --git a/meta/recipes-graphics/libfakekey/libfakekey_git.bb b/meta/recipes-graphics/libfakekey/libfakekey_git.bb
index ab6f5ac9ed22..45058a161719 100644
--- a/meta/recipes-graphics/libfakekey/libfakekey_git.bb
+++ b/meta/recipes-graphics/libfakekey/libfakekey_git.bb
@@ -2,7 +2,7 @@ SUMMARY = "Library for converting characters to X key-presses"
 DESCRIPTION = "libfakekey is a simple library for converting UTF-8 characters into 'fake' X \
 key-presses."
 HOMEPAGE = "http://matchbox-project.org/"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "LGPLv2+"
 LIC_FILES_CHKSUM = "file://src/libfakekey.c;endline=30;md5=602b5ccd48f64407510867f3373b448c"
diff --git a/meta/recipes-graphics/matchbox-session/matchbox-session_0.1.bb b/meta/recipes-graphics/matchbox-session/matchbox-session_0.1.bb
index 53229f2edcab..cdb872442346 100644
--- a/meta/recipes-graphics/matchbox-session/matchbox-session_0.1.bb
+++ b/meta/recipes-graphics/matchbox-session/matchbox-session_0.1.bb
@@ -1,7 +1,7 @@
 SUMMARY = "Custom Matchbox session files"
 DESCRIPTION = "Very simple session manager for matchbox tools"
 HOMEPAGE = "http://www.matchbox-project.org/"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "GPLv2"
 LIC_FILES_CHKSUM = "file://matchbox-session;endline=20;md5=180f1c169a15d059a56c30094f6fb5ea"
diff --git a/meta/recipes-graphics/matchbox-wm/matchbox-wm_1.2.2.bb b/meta/recipes-graphics/matchbox-wm/matchbox-wm_1.2.2.bb
index 95a0604aeea6..b009754c3b00 100644
--- a/meta/recipes-graphics/matchbox-wm/matchbox-wm_1.2.2.bb
+++ b/meta/recipes-graphics/matchbox-wm/matchbox-wm_1.2.2.bb
@@ -1,6 +1,6 @@
 SUMMARY = "Matchbox lightweight window manager"
 HOMEPAGE = "http://matchbox-project.org"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "GPLv2+"
 LIC_FILES_CHKSUM = "file://src/wm.h;endline=21;md5=a7e844465edbcf79c282369f93caa835 \
diff --git a/meta/recipes-graphics/mini-x-session/mini-x-session_0.1.bb b/meta/recipes-graphics/mini-x-session/mini-x-session_0.1.bb
index 470a5e9ea904..e50f291a61aa 100644
--- a/meta/recipes-graphics/mini-x-session/mini-x-session_0.1.bb
+++ b/meta/recipes-graphics/mini-x-session/mini-x-session_0.1.bb
@@ -1,6 +1,6 @@
 SUMMARY = "Very simple session manager for X"
 DESCRIPTION = "Simple session manager for X, that provides just the right boilerplate to create a session and launch the browser "
-HOMEPAGE = "http://www.yoctoproject.org"
+HOMEPAGE = "https://www.yoctoproject.org"
 BUGTRACKER = "http://bugzilla.pokylinux.org"
 
 PR = "r4"
diff --git a/meta/recipes-graphics/xcursor-transparent-theme/xcursor-transparent-theme_git.bb b/meta/recipes-graphics/xcursor-transparent-theme/xcursor-transparent-theme_git.bb
index f484f537c1a5..d6d9c265922b 100644
--- a/meta/recipes-graphics/xcursor-transparent-theme/xcursor-transparent-theme_git.bb
+++ b/meta/recipes-graphics/xcursor-transparent-theme/xcursor-transparent-theme_git.bb
@@ -1,6 +1,6 @@
 SUMMARY = "Transparent X11 cursor theme for touchscreens"
 HOMEPAGE = "http://www.matchbox-project.org/"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "GPLv2"
 LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f"
diff --git a/meta/recipes-graphics/xorg-lib/pixman/0001-ARM-qemu-related-workarounds-in-cpu-features-detecti.patch b/meta/recipes-graphics/xorg-lib/pixman/0001-ARM-qemu-related-workarounds-in-cpu-features-detecti.patch
index 4569dca01e22..04417fe46129 100644
--- a/meta/recipes-graphics/xorg-lib/pixman/0001-ARM-qemu-related-workarounds-in-cpu-features-detecti.patch
+++ b/meta/recipes-graphics/xorg-lib/pixman/0001-ARM-qemu-related-workarounds-in-cpu-features-detecti.patch
@@ -10,7 +10,7 @@ Content-Transfer-Encoding: 8bit
 This was ported from meta-oe's patch [1]. The original pixman patch is found
 at [2].
 
-[1] http://cgit.openembedded.org/meta-openembedded/tree/meta-oe/recipes-graphics/xorg-lib/pixman-0.26.2/0001-ARM-qemu-related-workarounds-in-cpu-features-detecti.patch
+[1] https://cgit.openembedded.org/meta-openembedded/tree/meta-oe/recipes-graphics/xorg-lib/pixman-0.26.2/0001-ARM-qemu-related-workarounds-in-cpu-features-detecti.patch
 [2] http://lists.freedesktop.org/archives/pixman/2011-January/000906.html
 
 Upstream-Status: Inappropriate [other] qemu fix
diff --git a/meta/recipes-graphics/xrestop/xrestop_0.4.bb b/meta/recipes-graphics/xrestop/xrestop_0.4.bb
index c7b8716f6f6a..8bd02e23d14b 100644
--- a/meta/recipes-graphics/xrestop/xrestop_0.4.bb
+++ b/meta/recipes-graphics/xrestop/xrestop_0.4.bb
@@ -14,7 +14,7 @@ PR = "r3"
 
 DEPENDS = "libxres libxext virtual/libx11 ncurses"
 
-SRC_URI = "http://downloads.yoctoproject.org/releases/xrestop/xrestop-${PV}.tar.gz"
+SRC_URI = "https://downloads.yoctoproject.org/releases/xrestop/xrestop-${PV}.tar.gz"
 
 SRC_URI[md5sum] = "d8a54596cbaf037e62b80c4585a3ca9b"
 SRC_URI[sha256sum] = "67c2fc94a7ecedbaae0d1837e82e93d1d98f4a6d759828860e552119af3ce257"
diff --git a/meta/recipes-multimedia/gstreamer/gstreamer1.0/0001-gst-gstpluginloader.c-when-env-var-is-set-do-not-fal.patch b/meta/recipes-multimedia/gstreamer/gstreamer1.0/0001-gst-gstpluginloader.c-when-env-var-is-set-do-not-fal.patch
index 23ebd5c6005f..95d488c6c476 100644
--- a/meta/recipes-multimedia/gstreamer/gstreamer1.0/0001-gst-gstpluginloader.c-when-env-var-is-set-do-not-fal.patch
+++ b/meta/recipes-multimedia/gstreamer/gstreamer1.0/0001-gst-gstpluginloader.c-when-env-var-is-set-do-not-fal.patch
@@ -10,7 +10,7 @@ Falling through to the one installed on the system is problamatic in cross-compi
 environemnts, regardless of whether one pointed to by the env var succeeded or failed.
 
 taken from:
-http://cgit.openembedded.org/openembedded-core/commit/meta/recipes-multimedia/gstreamer/gstreamer1.0/0001-gst-gstpluginloader.c-when-env-var-is-set-do-not-fal.patch?id=0db7ba34ca41b107042306d13a6f0162885c123b
+https://cgit.openembedded.org/openembedded-core/commit/meta/recipes-multimedia/gstreamer/gstreamer1.0/0001-gst-gstpluginloader.c-when-env-var-is-set-do-not-fal.patch?id=0db7ba34ca41b107042306d13a6f0162885c123b
 
 Part-of: <https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/669>
 
diff --git a/meta/recipes-sato/matchbox-config-gtk/matchbox-config-gtk_0.2.bb b/meta/recipes-sato/matchbox-config-gtk/matchbox-config-gtk_0.2.bb
index d5fe9b5dceae..268979f3d44f 100644
--- a/meta/recipes-sato/matchbox-config-gtk/matchbox-config-gtk_0.2.bb
+++ b/meta/recipes-sato/matchbox-config-gtk/matchbox-config-gtk_0.2.bb
@@ -1,6 +1,6 @@
 SUMMARY = "Matchbox GTK+ theme configuration application"
 HOMEPAGE = "http://matchbox-project.org"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "GPLv2+"
 LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f \
diff --git a/meta/recipes-sato/matchbox-desktop/matchbox-desktop_2.2.bb b/meta/recipes-sato/matchbox-desktop/matchbox-desktop_2.2.bb
index 79ccb0391b0e..74bf45f4837f 100644
--- a/meta/recipes-sato/matchbox-desktop/matchbox-desktop_2.2.bb
+++ b/meta/recipes-sato/matchbox-desktop/matchbox-desktop_2.2.bb
@@ -1,7 +1,7 @@
 SUMMARY = "Matchbox Window Manager Desktop"
 DESCRIPTION = "A lightweight windows manager for embedded systems. It uses the desktop background to provide an application launcher and allows modules to be loaded for additional functionality."
 HOMEPAGE = "http://matchbox-project.org/"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "GPLv2+ & LGPLv2+"
 LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f \
diff --git a/meta/recipes-sato/matchbox-keyboard/matchbox-keyboard_0.1.1.bb b/meta/recipes-sato/matchbox-keyboard/matchbox-keyboard_0.1.1.bb
index a87841181463..8fb38189484e 100644
--- a/meta/recipes-sato/matchbox-keyboard/matchbox-keyboard_0.1.1.bb
+++ b/meta/recipes-sato/matchbox-keyboard/matchbox-keyboard_0.1.1.bb
@@ -1,7 +1,7 @@
 SUMMARY = "Matchbox virtual keyboard for X11"
 DESCRIPTION = "An on screen 'virtual' or 'software' keyboard."
 HOMEPAGE = "http://matchbox-project.org"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 SECTION = "x11"
 
 LICENSE = "LGPLv2.1"
diff --git a/meta/recipes-sato/matchbox-panel-2/matchbox-panel-2_2.11.bb b/meta/recipes-sato/matchbox-panel-2/matchbox-panel-2_2.11.bb
index c6de14e34eb4..1f851e52d251 100644
--- a/meta/recipes-sato/matchbox-panel-2/matchbox-panel-2_2.11.bb
+++ b/meta/recipes-sato/matchbox-panel-2/matchbox-panel-2_2.11.bb
@@ -2,7 +2,7 @@ SUMMARY = "Simple GTK+ based panel for handheld devices"
 DESCRIPTION = "A flexible always present 'window bar' for holding application \
 launchers and small 'applet' style applications"
 HOMEPAGE = "http://matchbox-project.org"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "GPLv2+"
 LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f \
diff --git a/meta/recipes-sato/matchbox-sato/matchbox-session-sato_0.1.bb b/meta/recipes-sato/matchbox-sato/matchbox-session-sato_0.1.bb
index 7af11c2f5082..8f12268da2e6 100644
--- a/meta/recipes-sato/matchbox-sato/matchbox-session-sato_0.1.bb
+++ b/meta/recipes-sato/matchbox-sato/matchbox-session-sato_0.1.bb
@@ -1,6 +1,6 @@
 SUMMARY = "Custom Matchbox session files for the Sato environment"
 HOMEPAGE = "http://www.matchbox-project.org/"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "GPLv2.0+"
 LIC_FILES_CHKSUM = "file://session;endline=3;md5=f8a5c5b9c279e52dc094d10e11c2be63"
diff --git a/meta/recipes-sato/matchbox-terminal/matchbox-terminal_0.2.bb b/meta/recipes-sato/matchbox-terminal/matchbox-terminal_0.2.bb
index 9f00281ddec5..04c00c7d67d2 100644
--- a/meta/recipes-sato/matchbox-terminal/matchbox-terminal_0.2.bb
+++ b/meta/recipes-sato/matchbox-terminal/matchbox-terminal_0.2.bb
@@ -1,6 +1,6 @@
 SUMMARY = "Lightweight GTK+ terminal application"
 HOMEPAGE = "http://www.matchbox-project.org/"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "GPLv2+"
 LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f \
diff --git a/meta/recipes-sato/matchbox-theme-sato/matchbox-theme-sato.inc b/meta/recipes-sato/matchbox-theme-sato/matchbox-theme-sato.inc
index bd680111d95d..772669f3c0b8 100644
--- a/meta/recipes-sato/matchbox-theme-sato/matchbox-theme-sato.inc
+++ b/meta/recipes-sato/matchbox-theme-sato/matchbox-theme-sato.inc
@@ -1,6 +1,6 @@
 SUMMARY = "Matchbox window manager Sato themes"
 HOMEPAGE = "http://www.matchbox-project.org/"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "CC-BY-SA-3.0"
 LIC_FILES_CHKSUM = "file://COPYING;md5=aae86bb34b0a83716ca09f4e783d6ba4"
diff --git a/meta/recipes-sato/sato-screenshot/sato-screenshot_0.3.bb b/meta/recipes-sato/sato-screenshot/sato-screenshot_0.3.bb
index b2913b4ed5cd..6b03a2444a93 100644
--- a/meta/recipes-sato/sato-screenshot/sato-screenshot_0.3.bb
+++ b/meta/recipes-sato/sato-screenshot/sato-screenshot_0.3.bb
@@ -1,6 +1,6 @@
 SUMMARY = "Ultra-simple screen capture utility, aimed at handheld devices"
 HOMEPAGE = "http://www.o-hand.com"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 
 LICENSE = "GPLv2 & GPLv2+"
 LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f \
diff --git a/meta/recipes-sato/settings-daemon/settings-daemon_0.0.2.bb b/meta/recipes-sato/settings-daemon/settings-daemon_0.0.2.bb
index 742364f699c2..e87a0716707a 100644
--- a/meta/recipes-sato/settings-daemon/settings-daemon_0.0.2.bb
+++ b/meta/recipes-sato/settings-daemon/settings-daemon_0.0.2.bb
@@ -1,6 +1,6 @@
 SUMMARY = "Provides a bridge between gconf and xsettings"
 HOMEPAGE = "https://git.yoctoproject.org/cgit/cgit.cgi/xsettings-daemon/"
-BUGTRACKER = "http://bugzilla.yoctoproject.org/"
+BUGTRACKER = "https://bugzilla.yoctoproject.org/"
 LICENSE = "MIT-style"
 LIC_FILES_CHKSUM = "file://xsettings-manager.h;endline=22;md5=7cfac9d2d4dc3694cc7eb605cf32a69b \
                     file://xsettings-common.h;endline=22;md5=7cfac9d2d4dc3694cc7eb605cf32a69b"
diff --git a/meta/recipes-sato/webkit/webkitgtk_2.32.3.bb b/meta/recipes-sato/webkit/webkitgtk_2.32.3.bb
index 1f3f7a9c00a4..9675ebdc4f41 100644
--- a/meta/recipes-sato/webkit/webkitgtk_2.32.3.bb
+++ b/meta/recipes-sato/webkit/webkitgtk_2.32.3.bb
@@ -116,7 +116,7 @@ FILES:${PN} += "${libdir}/webkit2gtk-4.0/injected-bundle/libwebkit2gtkinjectedbu
 
 RRECOMMENDS:${PN} += "ca-certificates shared-mime-info"
 
-# http://errors.yoctoproject.org/Errors/Details/20370/
+# https://errors.yoctoproject.org/Errors/Details/20370/
 ARM_INSTRUCTION_SET:armv4 = "arm"
 ARM_INSTRUCTION_SET:armv5 = "arm"
 ARM_INSTRUCTION_SET:armv6 = "arm"
diff --git a/meta/recipes-support/icu/icu_69.1.bb b/meta/recipes-support/icu/icu_69.1.bb
index 4daf0fe82e2f..7934db65a6ed 100644
--- a/meta/recipes-support/icu/icu_69.1.bb
+++ b/meta/recipes-support/icu/icu_69.1.bb
@@ -96,7 +96,7 @@ def icu_download_folder(d):
 ICU_PV = "${@icu_download_version(d)}"
 ICU_FOLDER = "${@icu_download_folder(d)}"
 
-# http://errors.yoctoproject.org/Errors/Details/20486/
+# https://errors.yoctoproject.org/Errors/Details/20486/
 ARM_INSTRUCTION_SET:armv4 = "arm"
 ARM_INSTRUCTION_SET:armv5 = "arm"
 
diff --git a/meta/recipes-support/libunwind/libunwind_1.5.0.bb b/meta/recipes-support/libunwind/libunwind_1.5.0.bb
index 9b515b58f47d..8804c2988201 100644
--- a/meta/recipes-support/libunwind/libunwind_1.5.0.bb
+++ b/meta/recipes-support/libunwind/libunwind_1.5.0.bb
@@ -15,7 +15,7 @@ SRC_URI[sha256sum] = "90337653d92d4a13de590781371c604f9031cdb50520366aa1e3a91e1e
 
 EXTRA_OECONF:append:libc-musl = " --disable-documentation --disable-tests --enable-static"
 
-# http://errors.yoctoproject.org/Errors/Details/20487/
+# https://errors.yoctoproject.org/Errors/Details/20487/
 ARM_INSTRUCTION_SET:armv4 = "arm"
 ARM_INSTRUCTION_SET:armv5 = "arm"
 
diff --git a/meta/recipes-support/ptest-runner/ptest-runner_2.4.2.bb b/meta/recipes-support/ptest-runner/ptest-runner_2.4.2.bb
index 1d3c24a17763..90a76ef84045 100644
--- a/meta/recipes-support/ptest-runner/ptest-runner_2.4.2.bb
+++ b/meta/recipes-support/ptest-runner/ptest-runner_2.4.2.bb
@@ -2,7 +2,7 @@ SUMMARY = "A C program to run all installed ptests"
 DESCRIPTION = "The ptest-runner2 package installs a ptest-runner \
 program which loops through all installed ptest test suites and \
 runs them in sequence."
-HOMEPAGE = "http://git.yoctoproject.org/cgit/cgit.cgi/ptest-runner2/about/"
+HOMEPAGE = "https://git.yoctoproject.org/cgit/cgit.cgi/ptest-runner2/about/"
 
 LICENSE = "GPLv2+"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=751419260aa954499f7abaabaa882bbe"
diff --git a/scripts/autobuilder-worker-prereq-tests b/scripts/autobuilder-worker-prereq-tests
index 5d7e6e260130..2a7d8d43ecdd 100755
--- a/scripts/autobuilder-worker-prereq-tests
+++ b/scripts/autobuilder-worker-prereq-tests
@@ -49,13 +49,13 @@ fi
 mkdir -p tmp/deploy/images/qemux86-64
 pushd tmp/deploy/images/qemux86-64
 if [ ! -e core-image-minimal-qemux86-64.ext4 ]; then
-    wget http://downloads.yoctoproject.org/releases/yocto/yocto-2.5.1/machines/qemu/qemux86-64/core-image-minimal-qemux86-64.ext4
+    wget https://downloads.yoctoproject.org/releases/yocto/yocto-2.5.1/machines/qemu/qemux86-64/core-image-minimal-qemux86-64.ext4
 fi
 if [ ! -e core-image-minimal-qemux86-64.qemuboot.conf ]; then
-    wget http://downloads.yoctoproject.org/releases/yocto/yocto-2.5.1/machines/qemu/qemux86-64/core-image-minimal-qemux86-64.qemuboot.conf
+    wget https://downloads.yoctoproject.org/releases/yocto/yocto-2.5.1/machines/qemu/qemux86-64/core-image-minimal-qemux86-64.qemuboot.conf
 fi
 if [ ! -e bzImage-qemux86-64.bin ]; then
-    wget http://downloads.yoctoproject.org/releases/yocto/yocto-2.5.1/machines/qemu/qemux86-64/bzImage-qemux86-64.bin
+    wget https://downloads.yoctoproject.org/releases/yocto/yocto-2.5.1/machines/qemu/qemux86-64/bzImage-qemux86-64.bin
 fi
 popd
 bitbake qemu-helper-native
diff --git a/scripts/create-pull-request b/scripts/create-pull-request
index 8eefcf63a561..6a9da7113b14 100755
--- a/scripts/create-pull-request
+++ b/scripts/create-pull-request
@@ -149,13 +149,13 @@ fi
 WEB_URL=""
 case "$REMOTE_URL" in
 	*git.yoctoproject.org*)
-		WEB_URL="http://git.yoctoproject.org/cgit.cgi/$REMOTE_REPO/log/?h=$BRANCH"
+		WEB_URL="https://git.yoctoproject.org/cgit.cgi/$REMOTE_REPO/log/?h=$BRANCH"
 		;;
 	*git.pokylinux.org*)
 		WEB_URL="http://git.pokylinux.org/cgit.cgi/$REMOTE_REPO/log/?h=$BRANCH"
 		;;
 	*git.openembedded.org*)
-		WEB_URL="http://cgit.openembedded.org/$REMOTE_REPO/log/?h=$BRANCH"
+		WEB_URL="https://cgit.openembedded.org/$REMOTE_REPO/log/?h=$BRANCH"
 		;;
 	*github.com*)
 		WEB_URL="https://github.com/$REMOTE_REPO/tree/$BRANCH"
diff --git a/scripts/install-buildtools b/scripts/install-buildtools
index 8554a5db6791..44c77cb11131 100755
--- a/scripts/install-buildtools
+++ b/scripts/install-buildtools
@@ -11,11 +11,11 @@
 #  Example usage (extended buildtools from milestone):
 #    (1) using --url and --filename
 #        $ install-buildtools \
-#          --url http://downloads.yoctoproject.org/releases/yocto/milestones/yocto-3.1_M3/buildtools \
+#          --url https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-3.1_M3/buildtools \
 #          --filename x86_64-buildtools-extended-nativesdk-standalone-3.0+snapshot-20200315.sh
 #    (2) using --base-url, --release, --installer-version and --build-date
 #        $ install-buildtools \
-#          --base-url http://downloads.yoctoproject.org/releases/yocto \
+#          --base-url https://downloads.yoctoproject.org/releases/yocto \
 #          --release yocto-3.1_M3 \
 #          --installer-version 3.0+snapshot
 #          --build-date 202000315
@@ -23,11 +23,11 @@
 #  Example usage (standard buildtools from release):
 #    (3) using --url and --filename
 #        $ install-buildtools --without-extended-buildtools \
-#          --url http://downloads.yoctoproject.org/releases/yocto/yocto-3.0.2/buildtools \
+#          --url https://downloads.yoctoproject.org/releases/yocto/yocto-3.0.2/buildtools \
 #          --filename x86_64-buildtools-nativesdk-standalone-3.0.2.sh
 #    (4) using --base-url, --release and --installer-version
 #        $ install-buildtools --without-extended-buildtools \
-#          --base-url http://downloads.yoctoproject.org/releases/yocto \
+#          --base-url https://downloads.yoctoproject.org/releases/yocto \
 #          --release yocto-3.0.2 \
 #          --installer-version 3.0.2
 #
@@ -56,7 +56,7 @@ PROGNAME = 'install-buildtools'
 logger = scriptutils.logger_create(PROGNAME, stream=sys.stdout)
 
 DEFAULT_INSTALL_DIR = os.path.join(os.path.split(scripts_path)[0],'buildtools')
-DEFAULT_BASE_URL = 'http://downloads.yoctoproject.org/releases/yocto'
+DEFAULT_BASE_URL = 'https://downloads.yoctoproject.org/releases/yocto'
 DEFAULT_RELEASE = 'yocto-3.2_M3'
 DEFAULT_INSTALLER_VERSION = '3.1+snapshot'
 DEFAULT_BUILDDATE = '20200923'
diff --git a/scripts/lib/build_perf/html/report.html b/scripts/lib/build_perf/html/report.html
index d1ba6f257886..76df3210d41a 100644
--- a/scripts/lib/build_perf/html/report.html
+++ b/scripts/lib/build_perf/html/report.html
@@ -83,7 +83,7 @@ h3 {
 </head>
 
 {% macro poky_link(commit) -%}
-    <a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?id={{ commit }}">{{ commit[0:11] }}</a>
+    <a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?id={{ commit }}">{{ commit[0:11] }}</a>
 {%- endmacro %}
 
 <body><div style="width: 700px">
-- 
2.20.1


