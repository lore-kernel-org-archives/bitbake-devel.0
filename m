Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905B8C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 15:06:38 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web08.13167.1633619197186552842
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=YmB7RjRK;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.222.178,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qk1-f178.google.com with SMTP id 77so5046122qkh.6
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TLQff+TXp6C70+Oizc1gTHBjCQomIvntl+DtqLVW/Kg=;
        b=YmB7RjRKTlgE75Djrhn3JPakzlWaiZdLrJeWt5sFeAUacJJaojkTlTCz1T8N0QG+e7
         IgnpUM8efIoAQMqPAdENoeUksybTNFLYF5AMhG3TPduN5BXNJVgXgjNXLITwXRrvysm+
         izz1VnONRyt/Kkt9ZZQ3wYBx9/ljSnrmKKUQkGGWOSqRqGik2TpRTxZbb+fg9Y1SgP9x
         J9fsEiYdL+FeLdzqt4NVV/cxP47+VFDtVbWMGcHQX5Np0Huewl5Qg1Aja9jREYoJ8jj0
         eRXwlvgw062uDNj6ocwzQFJZ/15vdqJOmnvod2o7GDL8gDbsutzOUlBRA/ai2D06bdUd
         UnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLQff+TXp6C70+Oizc1gTHBjCQomIvntl+DtqLVW/Kg=;
        b=owuifqTAW+H+oWQyG+eNrufcigZmobZevtm7/wq7G9ltfoqxfD9VScLqrhnjYVJ9+w
         Jk4oZa5B4hQWNe5Svm1pqCdCIdQa3nnyRTATknP4Ft4JXviIJbiHcYq01Gh2LMD+UJE3
         jZoC7OhYMzNNWoxp0OqFQBcAO4k3UEzJk/iSXDT0OPASZPMBvTq+i7zYNCRSkU47BjEj
         YbisWPlCGFeUOTcNXomAvB5WS5MudlZNwp5GcRaoMqG+tXgAjgMkDdpN4bJkLI0LpZKZ
         AkMmNVa1UQSbv8AI4O2g5QFwBm+rqR0rP26Vtl5xoo6Sllnm2JmNS8TXOeMYepK0Kp7m
         iUow==
X-Gm-Message-State: AOAM531TnABZShTowQF16Fq0sE3r+4Blwzd8RuM1yszxXYouSEma3NEz
	18TYjfbJACMyTfFp4iXRyvIhww==
X-Google-Smtp-Source: 
 ABdhPJwZKcjnzl5MdHOAs2xwIEARg9DS40Gwb9wKHv64PkBhW+rBkQf/a5grdWnzuX0dPYyTOcrEFg==
X-Received: by 2002:a05:620a:484:: with SMTP id
 4mr3811918qkr.409.1633619196137;
        Thu, 07 Oct 2021 08:06:36 -0700 (PDT)
Received: from localhost ([2605:a601:a650:b700:9937:f30b:7d2e:fddf])
        by smtp.gmail.com with ESMTPSA id
 t17sm15841240qtq.56.2021.10.07.08.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:06:35 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: openembedded-core@lists.openembedded.org,
	docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/8] bitbake: replace http with https for URLs
Date: Thu,  7 Oct 2021 11:06:27 -0400
Message-Id: <20211007150630.22138-6-jdmason@kudzu.us>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211007150630.22138-1-jdmason@kudzu.us>
References: <20211007150630.22138-1-jdmason@kudzu.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 15:06:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12746

https has been the preferred way to access websites for many years now.
Change all of the URLs with a _working_ https server/certificate to use
that URL.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 bitbake/README                                |  8 ++---
 bitbake/doc/README                            |  2 +-
 .../bitbake-user-manual-fetching.rst          |  2 +-
 .../bitbake-user-manual-hello.rst             |  4 +--
 .../bitbake-user-manual-intro.rst             |  6 ++--
 .../bitbake-user-manual-ref-variables.rst     | 10 +++---
 bitbake/lib/bb/tests/fetch.py                 | 36 +++++++++----------
 bitbake/lib/layerindexlib/__init__.py         |  4 +--
 bitbake/lib/layerindexlib/restapi.py          |  4 +--
 bitbake/lib/layerindexlib/tests/restapi.py    |  2 +-
 bitbake/lib/toaster/orm/fixtures/oe-core.xml  | 12 +++----
 bitbake/lib/toaster/orm/fixtures/poky.xml     | 24 ++++++-------
 .../orm/management/commands/lsupdates.py      |  2 +-
 .../toastergui/templates/layerdetails.html    |  2 +-
 .../templates/package_detail_base.html        |  2 +-
 15 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/bitbake/README b/bitbake/README
index 2d5cd254e5eb..80a97118b9e2 100644
--- a/bitbake/README
+++ b/bitbake/README
@@ -7,7 +7,7 @@ One of BitBake's main users, OpenEmbedded, takes this core and builds embedded L
 stacks using a task-oriented approach.
 
 For information about Bitbake, see the OpenEmbedded website:
-    http://www.openembedded.org/
+    https://www.openembedded.org/
 
 Bitbake plain documentation can be found under the doc directory or its integrated
 html version at the Yocto Project website:
@@ -17,7 +17,7 @@ Contributing
 ------------
 
 Please refer to
-http://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
+https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
 for guidelines on how to submit patches, just note that the latter documentation is intended
 for OpenEmbedded (and its core) not bitbake patches (bitbake-devel@lists.openembedded.org)
 but in general main guidelines apply. Once the commit(s) have been created, the way to send
@@ -28,11 +28,11 @@ branch, type:
 
 Mailing list:
 
-    http://lists.openembedded.org/mailman/listinfo/bitbake-devel
+    https://lists.openembedded.org/g/bitbake-devel
 
 Source code:
 
-    http://git.openembedded.org/bitbake/
+    https://git.openembedded.org/bitbake/
 
 Testing:
 
diff --git a/bitbake/doc/README b/bitbake/doc/README
index 62595820bd0d..16e6cdf990d2 100644
--- a/bitbake/doc/README
+++ b/bitbake/doc/README
@@ -13,7 +13,7 @@ Folders exist for individual manuals as follows:
 Each folder is self-contained regarding content and figures.
 
 If you want to find HTML versions of the BitBake manuals on the web, 
-go to http://www.openembedded.org/wiki/Documentation. 
+go to https://www.openembedded.org/wiki/Documentation.
 
 Sphinx
 ======
diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index a944d0f78e52..4396830a2f58 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -74,7 +74,7 @@ handles that particular URL type. This behavior can be the source of
 some confusion when you are providing URLs for the :term:`SRC_URI` variable.
 Consider the following two URLs::
 
-   http://git.yoctoproject.org/git/poky;protocol=git
+   https://git.yoctoproject.org/git/poky;protocol=git
    git://git.yoctoproject.org/git/poky;protocol=http
 
 In the former case, the URL is passed to the ``wget`` fetcher, which does not
diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
index 83a415d994f9..722dc5a2cc60 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
@@ -99,7 +99,7 @@ discussion mailing list about the BitBake build tool.
 
    This example was inspired by and drew heavily from
    `Mailing List post - The BitBake equivalent of "Hello, World!"
-   <http://www.mail-archive.com/yocto@yoctoproject.org/msg09379.html>`_.
+   <https://www.mail-archive.com/yocto@yoctoproject.org/msg09379.html>`_.
 
 As stated earlier, the goal of this example is to eventually compile
 "Hello World". However, it is unknown what BitBake needs and what you
@@ -205,7 +205,7 @@ Following is the complete "Hello World" example.
     recipe files. For this example, you need to create the file in your
     project directory and define some key BitBake variables. For more
     information on the ``bitbake.conf`` file, see
-    http://git.openembedded.org/bitbake/tree/conf/bitbake.conf.
+    https://git.openembedded.org/bitbake/tree/conf/bitbake.conf.
 
     Use the following commands to create the ``conf`` directory in the
     project directory::
diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 76c8e3dacecc..42263cef3adb 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -60,11 +60,11 @@ member Chris Larson split the project into two distinct pieces:
 -  OpenEmbedded, a metadata set utilized by BitBake
 
 Today, BitBake is the primary basis of the
-`OpenEmbedded <http://www.openembedded.org/>`__ project, which is being
+`OpenEmbedded <https://www.openembedded.org/>`__ project, which is being
 used to build and maintain Linux distributions such as the `Angstrom
 Distribution <http://www.angstrom-distribution.org/>`__, and which is
 also being used as the build tool for Linux projects such as the `Yocto
-Project <http://www.yoctoproject.org>`__.
+Project <https://www.yoctoproject.org>`__.
 
 Prior to BitBake, no other build tool adequately met the needs of an
 aspiring embedded Linux distribution. All of the build systems used by
@@ -319,7 +319,7 @@ You can obtain BitBake several different ways:
 
    The following example downloads a snapshot of BitBake version 1.17.0::
 
-     $ wget http://git.openembedded.org/bitbake/snapshot/bitbake-1.17.0.tar.gz
+     $ wget https://git.openembedded.org/bitbake/snapshot/bitbake-1.17.0.tar.gz
      $ tar zxpvf bitbake-1.17.0.tar.gz
 
    After extraction of the tarball using
diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 11f8fdcde003..0e5f9746b41c 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -538,7 +538,7 @@ overview of their function and contents.
 
       You can use this variable in combination with task overrides to raise
       or lower priorities of specific tasks. For example, on the `Yocto
-      Project <http://www.yoctoproject.org>`__ autobuilder, QEMU emulation
+      Project <https://www.yoctoproject.org>`__ autobuilder, QEMU emulation
       in images is given a higher priority as compared to build tasks to
       ensure that images do not suffer timeouts on loaded systems.
 
@@ -1123,10 +1123,10 @@ overview of their function and contents.
       your configuration::
 
          PREMIRRORS:prepend = "\
-         git://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-         ftp://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-         http://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-         https://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n"
+         git://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+         ftp://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+         http://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+         https://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n"
 
       These changes cause the build system to intercept Git, FTP, HTTP, and
       HTTPS requests and direct them to the ``http://`` sources mirror. You can
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index af292a21634a..2a009874be2c 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -450,7 +450,7 @@ class MirrorUriTest(FetcherTest):
             self.assertEqual([v], newuris)
 
     def test_urilist1(self):
-        fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
+        fetcher = bb.fetch.FetchData("https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
         mirrors = bb.fetch2.mirror_from_string(self.mirrorvar)
         uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///somepath/downloads/bitbake-1.0.tar.gz', 'file:///someotherpath/downloads/bitbake-1.0.tar.gz'])
@@ -466,7 +466,7 @@ class MirrorUriTest(FetcherTest):
         # Test if mirror of a mirror works
         mirrorvar = self.mirrorvar + " http://.*/.* http://otherdownloads.yoctoproject.org/downloads/ \n"
         mirrorvar = mirrorvar + " http://otherdownloads.yoctoproject.org/.* http://downloads2.yoctoproject.org/downloads/ \n"
-        fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
+        fetcher = bb.fetch.FetchData("https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
         mirrors = bb.fetch2.mirror_from_string(mirrorvar)
         uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
         self.assertEqual(uris, ['file:///somepath/downloads/bitbake-1.0.tar.gz', 
@@ -826,12 +826,12 @@ class FetcherNoNetworkTest(FetcherTest):
 class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_fetch(self):
-        fetcher = bb.fetch.Fetch(["http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", "http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz"], self.d)
+        fetcher = bb.fetch.Fetch(["https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", "https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.1.tar.gz"), 57892)
         self.d.setVar("BB_NO_NETWORK", "1")
-        fetcher = bb.fetch.Fetch(["http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", "http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz"], self.d)
+        fetcher = bb.fetch.Fetch(["https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", "https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz"], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         self.assertEqual(len(os.listdir(self.unpackdir + "/bitbake-1.0/")), 9)
@@ -839,21 +839,21 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_fetch_mirror(self):
-        self.d.setVar("MIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
+        self.d.setVar("MIRRORS", "http://.*/.* https://downloads.yoctoproject.org/releases/bitbake")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
     @skipIfNoNetwork()
     def test_fetch_mirror_of_mirror(self):
-        self.d.setVar("MIRRORS", "http://.*/.* http://invalid2.yoctoproject.org/ \n http://invalid2.yoctoproject.org/.* http://downloads.yoctoproject.org/releases/bitbake")
+        self.d.setVar("MIRRORS", "http://.*/.* http://invalid2.yoctoproject.org/ \n http://invalid2.yoctoproject.org/.* https://downloads.yoctoproject.org/releases/bitbake")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
     @skipIfNoNetwork()
     def test_fetch_file_mirror_of_mirror(self):
-        self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ \n file:///some1where/.* file://some2where/ \n file://some2where/.* http://downloads.yoctoproject.org/releases/bitbake")
+        self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ \n file:///some1where/.* file://some2where/ \n file://some2where/.* https://downloads.yoctoproject.org/releases/bitbake")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
         os.mkdir(self.dldir + "/some2where")
         fetcher.download()
@@ -861,20 +861,20 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_fetch_premirror(self):
-        self.d.setVar("PREMIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake")
+        self.d.setVar("PREMIRRORS", "http://.*/.* https://downloads.yoctoproject.org/releases/bitbake")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
     @skipIfNoNetwork()
     def test_fetch_specify_downloadfilename(self):
-        fetcher = bb.fetch.Fetch(["http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz;downloadfilename=bitbake-v1.0.0.tar.gz"], self.d)
+        fetcher = bb.fetch.Fetch(["https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz;downloadfilename=bitbake-v1.0.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-v1.0.0.tar.gz"), 57749)
 
     @skipIfNoNetwork()
     def test_fetch_premirror_specify_downloadfilename_regex_uri(self):
-        self.d.setVar("PREMIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake/")
+        self.d.setVar("PREMIRRORS", "http://.*/.* https://downloads.yoctoproject.org/releases/bitbake/")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz;downloadfilename=bitbake-v1.0.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-v1.0.0.tar.gz"), 57749)
@@ -882,7 +882,7 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     # BZ13039
     def test_fetch_premirror_specify_downloadfilename_specific_uri(self):
-        self.d.setVar("PREMIRRORS", "http://invalid.yoctoproject.org/releases/bitbake http://downloads.yoctoproject.org/releases/bitbake")
+        self.d.setVar("PREMIRRORS", "http://invalid.yoctoproject.org/releases/bitbake https://downloads.yoctoproject.org/releases/bitbake")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz;downloadfilename=bitbake-v1.0.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-v1.0.0.tar.gz"), 57749)
@@ -1291,10 +1291,10 @@ class FetchLatestVersionTest(FetcherTest):
         #
         # packages with versions only in current directory
         #
-        # http://downloads.yoctoproject.org/releases/eglibc/eglibc-2.18-svnr23787.tar.bz2
+        # https://downloads.yoctoproject.org/releases/eglibc/eglibc-2.18-svnr23787.tar.bz2
         ("eglic", "/releases/eglibc/eglibc-2.18-svnr23787.tar.bz2", "", "")
             : "2.19",
-        # http://downloads.yoctoproject.org/releases/gnu-config/gnu-config-20120814.tar.bz2
+        # https://downloads.yoctoproject.org/releases/gnu-config/gnu-config-20120814.tar.bz2
         ("gnu-config", "/releases/gnu-config/gnu-config-20120814.tar.bz2", "", "")
             : "20120814",
         #
@@ -1357,13 +1357,13 @@ class FetchLatestVersionTest(FetcherTest):
 
 
 class FetchCheckStatusTest(FetcherTest):
-    test_wget_uris = ["http://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
-                      "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
-                      "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.3.tar.gz",
+    test_wget_uris = ["https://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
+                      "https://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
+                      "https://downloads.yoctoproject.org/releases/sato/sato-engine-0.3.tar.gz",
                       "https://yoctoproject.org/",
                       "https://docs.yoctoproject.org",
-                      "http://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
-                      "http://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
+                      "https://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
+                      "https://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
                       "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
                       "http://ftp.gnu.org/gnu/autoconf/autoconf-2.60.tar.gz",
                       "https://ftp.gnu.org/gnu/chess/gnuchess-5.08.tar.gz",
diff --git a/bitbake/lib/layerindexlib/__init__.py b/bitbake/lib/layerindexlib/__init__.py
index 3159bf2f668a..08063c571e9a 100644
--- a/bitbake/lib/layerindexlib/__init__.py
+++ b/bitbake/lib/layerindexlib/__init__.py
@@ -198,7 +198,7 @@ The format of the indexURI:
 
   For example:
 
-  http://layers.openembedded.org/layerindex/api/;branch=master;desc=OpenEmbedded%20Layer%20Index
+  https://layers.openembedded.org/layerindex/api/;branch=master;desc=OpenEmbedded%20Layer%20Index
   cooker://
 '''
         if reload:
@@ -576,7 +576,7 @@ This function is used to implement debugging and provide the user info.
 #   index['config'] - configuration data for this index
 #   index['branches'] - dictionary of Branch objects, by id number
 #   index['layerItems'] - dictionary of layerItem objects, by id number
-#   ...etc...  (See: http://layers.openembedded.org/layerindex/api/)
+#   ...etc...  (See: https://layers.openembedded.org/layerindex/api/)
 #
 # The class needs to manage the 'index' entries and allow easily adding
 # of new items, as well as simply loading of the items.
diff --git a/bitbake/lib/layerindexlib/restapi.py b/bitbake/lib/layerindexlib/restapi.py
index 26a1c9674e2b..81d99b02eaeb 100644
--- a/bitbake/lib/layerindexlib/restapi.py
+++ b/bitbake/lib/layerindexlib/restapi.py
@@ -31,7 +31,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
             The return value is a LayerIndexObj.
 
             url is the url to the rest api of the layer index, such as:
-            http://layers.openembedded.org/layerindex/api/
+            https://layers.openembedded.org/layerindex/api/
 
             Or a local file...
         """
@@ -138,7 +138,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
             The return value is a LayerIndexObj.
 
             ud is the parsed url to the rest api of the layer index, such as:
-            http://layers.openembedded.org/layerindex/api/
+            https://layers.openembedded.org/layerindex/api/
         """
 
         def _get_json_response(apiurl=None, username=None, password=None, retry=True):
diff --git a/bitbake/lib/layerindexlib/tests/restapi.py b/bitbake/lib/layerindexlib/tests/restapi.py
index 33b5c1c4c842..71f0ae8a9dbc 100644
--- a/bitbake/lib/layerindexlib/tests/restapi.py
+++ b/bitbake/lib/layerindexlib/tests/restapi.py
@@ -22,7 +22,7 @@ class LayerIndexWebRestApiTest(LayersTest):
         self.assertFalse(os.environ.get("BB_SKIP_NETTESTS") == "yes", msg="BB_SKIP_NETTESTS set, but we tried to test anyway")
         LayersTest.setUp(self)
         self.layerindex = layerindexlib.LayerIndex(self.d)
-        self.layerindex.load_layerindex('http://layers.openembedded.org/layerindex/api/;branch=sumo', load=['layerDependencies'])
+        self.layerindex.load_layerindex('https://layers.openembedded.org/layerindex/api/;branch=sumo', load=['layerDependencies'])
 
     @skipIfNoNetwork()
     def test_layerindex_is_empty(self):
diff --git a/bitbake/lib/toaster/orm/fixtures/oe-core.xml b/bitbake/lib/toaster/orm/fixtures/oe-core.xml
index 026d94869a01..b01a337012a5 100644
--- a/bitbake/lib/toaster/orm/fixtures/oe-core.xml
+++ b/bitbake/lib/toaster/orm/fixtures/oe-core.xml
@@ -34,7 +34,7 @@
     <field type="CharField" name="description">Openembedded Dunfell</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
     <field type="CharField" name="branch_name">dunfell</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=dunfell\"&gt;OpenEmbedded Dunfell&lt;/a&gt; branch.</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=dunfell\"&gt;OpenEmbedded Dunfell&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -48,14 +48,14 @@
     <field type="CharField" name="description">OpenEmbedded core master</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">3</field>
     <field type="CharField" name="branch_name">master</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/\"&gt;OpenEmbedded master&lt;/a&gt; branch.</field>
   </object>
   <object model="orm.release" pk="4">
     <field type="CharField" name="name">gatesgarth</field>
     <field type="CharField" name="description">Openembedded Gatesgarth</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
     <field type="CharField" name="branch_name">gatesgarth</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"http://cgit.openembedded.org/openembedded-core/log/?h=gatesgarth\"&gt;OpenEmbedded Gatesgarth&lt;/a&gt; branch.</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href=\"https://cgit.openembedded.org/openembedded-core/log/?h=gatesgarth\"&gt;OpenEmbedded Gatesgarth&lt;/a&gt; branch.</field>
   </object>
 
   <!-- Default layers for each release -->
@@ -81,9 +81,9 @@
   <object model="orm.layer" pk="1">
     <field type="CharField" name="name">openembedded-core</field>
     <field type="CharField" name="vcs_url">git://git.openembedded.org/openembedded-core</field>
-    <field type="CharField" name="vcs_web_url">http://cgit.openembedded.org/openembedded-core</field>
-    <field type="CharField" name="vcs_web_tree_base_url">http://cgit.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
-    <field type="CharField" name="vcs_web_file_base_url">http://cgit.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_url">https://cgit.openembedded.org/openembedded-core</field>
+    <field type="CharField" name="vcs_web_tree_base_url">https://cgit.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">https://cgit.openembedded.org/openembedded-core/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="1">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
diff --git a/bitbake/lib/toaster/orm/fixtures/poky.xml b/bitbake/lib/toaster/orm/fixtures/poky.xml
index a468a54c49bb..363789d62491 100644
--- a/bitbake/lib/toaster/orm/fixtures/poky.xml
+++ b/bitbake/lib/toaster/orm/fixtures/poky.xml
@@ -39,7 +39,7 @@
     <field type="CharField" name="description">Yocto Project 3.1 "Dunfell"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">1</field>
     <field type="CharField" name="branch_name">dunfell</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=dunfell"&gt;Yocto Project Dunfell branch&lt;/a&gt;.</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=dunfell"&gt;Yocto Project Dunfell branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="2">
     <field type="CharField" name="name">local</field>
@@ -53,14 +53,14 @@
     <field type="CharField" name="description">Yocto Project master</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">3</field>
     <field type="CharField" name="branch_name">master</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model="orm.release" pk="4">
     <field type="CharField" name="name">gatesgarth</field>
     <field type="CharField" name="description">Yocto Project 3.2 "Gatesgarth"</field>
     <field rel="ManyToOneRel" to="orm.bitbakeversion" name="bitbake_version">4</field>
     <field type="CharField" name="branch_name">gatesgarth</field>
-    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=gatesgarth"&gt;Yocto Project Gatesgarth branch&lt;/a&gt;.</field>
+    <field type="TextField" name="helptext">Toaster will run your builds using the tip of the &lt;a href="https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=gatesgarth"&gt;Yocto Project Gatesgarth branch&lt;/a&gt;.</field>
   </object>
 
   <!-- Default project layers for each release -->
@@ -122,9 +122,9 @@
     <field type="CharField" name="name">openembedded-core</field>
     <field type="CharField" name="layer_index_url"></field>
     <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="vcs_web_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
-    <field type="CharField" name="vcs_web_tree_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
-    <field type="CharField" name="vcs_web_file_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
+    <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="1">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">1</field>
@@ -160,9 +160,9 @@
     <field type="CharField" name="name">meta-poky</field>
     <field type="CharField" name="layer_index_url"></field>
     <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="vcs_web_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
-    <field type="CharField" name="vcs_web_tree_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
-    <field type="CharField" name="vcs_web_file_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
+    <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="5">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">2</field>
@@ -198,9 +198,9 @@
     <field type="CharField" name="name">meta-yocto-bsp</field>
     <field type="CharField" name="layer_index_url"></field>
     <field type="CharField" name="vcs_url">git://git.yoctoproject.org/poky</field>
-    <field type="CharField" name="vcs_web_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
-    <field type="CharField" name="vcs_web_tree_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
-    <field type="CharField" name="vcs_web_file_base_url">http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky</field>
+    <field type="CharField" name="vcs_web_tree_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
+    <field type="CharField" name="vcs_web_file_base_url">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=%branch%</field>
   </object>
   <object model="orm.layer_version" pk="9">
     <field rel="ManyToOneRel" to="orm.layer" name="layer">3</field>
diff --git a/bitbake/lib/toaster/orm/management/commands/lsupdates.py b/bitbake/lib/toaster/orm/management/commands/lsupdates.py
index 2fbd7be3d2fa..3b950e6e1508 100644
--- a/bitbake/lib/toaster/orm/management/commands/lsupdates.py
+++ b/bitbake/lib/toaster/orm/management/commands/lsupdates.py
@@ -21,7 +21,7 @@ import threading
 import time
 logger = logging.getLogger("toaster")
 
-DEFAULT_LAYERINDEX_SERVER = "http://layers.openembedded.org/layerindex/api/"
+DEFAULT_LAYERINDEX_SERVER = "https://layers.openembedded.org/layerindex/api/"
 
 # Add path to bitbake modules for layerindexlib
 # lib/toaster/orm/management/commands/lsupdates.py (abspath)
diff --git a/bitbake/lib/toaster/toastergui/templates/layerdetails.html b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
index 1e26e31c8b86..923ca3bfe4d3 100644
--- a/bitbake/lib/toaster/toastergui/templates/layerdetails.html
+++ b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
@@ -355,7 +355,7 @@
             {% if layerversion.layer_source == layer_source.TYPE_LAYERINDEX  %}
             <dt>Layer index</dt>
             <dd>
-            <a href="http://layers.openembedded.org/layerindex/branch/{{layerversion.release.name}}/layer/{{layerversion.layer.name}}">Layer index {{layerversion.layer.name}}</a>
+            <a href="https://layers.openembedded.org/layerindex/branch/{{layerversion.release.name}}/layer/{{layerversion.layer.name}}">Layer index {{layerversion.layer.name}}</a>
             </dd>
             {% endif %}
           </dl>
diff --git a/bitbake/lib/toaster/toastergui/templates/package_detail_base.html b/bitbake/lib/toaster/toastergui/templates/package_detail_base.html
index 66f8e7f06926..a4fcd2aa425c 100644
--- a/bitbake/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/bitbake/lib/toaster/toastergui/templates/package_detail_base.html
@@ -127,7 +127,7 @@
                     {% comment %}
                     # Removed per team meeting of 1/29/2014 until
                     # decision on index search algorithm
-                    <a href="http://layers.openembedded.org"  target="_blank">
+                    <a href="https://layers.openembedded.org"  target="_blank">
                     <i class="glyphicon glyphicon-share get-info"></i>
                     </a>
                     {% endcomment %}
-- 
2.20.1


