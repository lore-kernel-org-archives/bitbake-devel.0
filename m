Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9C0C43217
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 14:42:45 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.6534.1636123364733435536
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 07:42:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C7DEB6000F;
	Fri,  5 Nov 2021 14:42:42 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH 1/2] doc: bitbake-user-manual: add TMPDIR and WORKDIR to the
 variable index
Date: Fri,  5 Nov 2021 15:42:37 +0100
Message-Id: <20211105144238.27679-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211105144238.27679-1-michael.opdenacker@bootlin.com>
References: <20211105144238.27679-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 14:42:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12901

This allows to add references to these variables

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-execution.rst         |  2 +-
 .../bitbake-user-manual-fetching.rst          |  4 +--
 .../bitbake-user-manual-hello.rst             |  4 +--
 .../bitbake-user-manual-ref-variables.rst     | 28 +++++++++++++++++--
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index a4b1efbe..580503d5 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -545,7 +545,7 @@ to help illustrate the concept::
        CCACHE_DIR EXTERNAL_TOOLCHAIN CCACHE CCACHE_DISABLE LICENSE_PATH SDKPKGSUFFIX"
 
 The previous example excludes the work directory, which is part of
-``TMPDIR``.
+:term:`TMPDIR`.
 
 The rules for deciding which hashes of dependent tasks to include
 through dependency chains are more complex and are generally
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 4396830a..38083e54 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -42,7 +42,7 @@ The instantiation of the fetch class is usually followed by::
    rootdir = l.getVar('WORKDIR')
    fetcher.unpack(rootdir)
 
-This code unpacks the downloaded files to the specified by ``WORKDIR``.
+This code unpacks the downloaded files to the specified by :term:`WORKDIR`.
 
 .. note::
 
@@ -51,7 +51,7 @@ This code unpacks the downloaded files to the specified by ``WORKDIR``.
    examine the OpenEmbedded class file ``base.bbclass``
    .
 
-The :term:`SRC_URI` and ``WORKDIR`` variables are not hardcoded into the
+The :term:`SRC_URI` and :term:`WORKDIR` variables are not hardcoded into the
 fetcher, since those fetcher methods can be (and are) called with
 different variable names. In OpenEmbedded for example, the shared state
 (sstate) code uses the fetch module to fetch the sstate files.
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
index 722dc5a2..0aab6fcd 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
@@ -233,11 +233,11 @@ Following is the complete "Hello World" example.
        recipe to set PN . You will also need to include PN as part of the STAMP
        , T , and B variable definitions in the local.conf file.
 
-    The ``TMPDIR`` variable establishes a directory that BitBake uses
+    The :term:`TMPDIR` variable establishes a directory that BitBake uses
     for build output and intermediate files other than the cached
     information used by the
     :ref:`bitbake-user-manual/bitbake-user-manual-execution:setscene`
-    process. Here, the ``TMPDIR`` directory is set to ``hello/tmp``.
+    process. Here, the :term:`TMPDIR` directory is set to ``hello/tmp``.
 
     .. tip::
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index e955beb1..5abf43d8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -176,7 +176,7 @@ overview of their function and contents.
       The first example works only if you also set the
       :term:`BB_DISKMON_WARNINTERVAL`
       variable. This example causes the build system to immediately abort
-      when either the disk space in ``${TMPDIR}`` drops below 1 Gbyte or
+      when either the disk space in :term:`TMPDIR` drops below 1 Gbyte or
       the available free inodes drops below 100 Kbytes. Because two
       directories are provided with the variable, the build system also
       issues a warning when the disk space in the ``${SSTATE_DIR}``
@@ -185,12 +185,12 @@ overview of their function and contents.
       defined by the :term:`BB_DISKMON_WARNINTERVAL` variable.
 
       The second example stops the build after all currently executing
-      tasks complete when the minimum disk space in the ``${TMPDIR}``
+      tasks complete when the minimum disk space in the :term:`TMPDIR`
       directory drops below 1 Gbyte. No disk monitoring occurs for the free
       inodes in this case.
 
       The final example immediately aborts the build when the number of
-      free inodes in the ``${TMPDIR}`` directory drops below 100 Kbytes. No
+      free inodes in the :term:`TMPDIR` directory drops below 100 Kbytes. No
       disk space monitoring for the directory itself occurs in this case.
 
    :term:`BB_DISKMON_WARNINTERVAL`
@@ -1446,6 +1446,28 @@ overview of their function and contents.
       consist mostly of task logs and scripts, when building a particular
       recipe.
 
+   :term:`TMPDIR`
+      This variable is the base directory BitBake uses for all build output
+      and intermediate files (other than the shared state cache). By default,
+      the :term:`TMPDIR` variable points to ``tmp`` within the
+      Build Directory.
+
+      If you want to establish this directory in a location other than the
+      default, you can set it in your project's ``local.conf`` file.
+
+      An example use for this scenario is to set :term:`TMPDIR` to a local disk,
+      which does not use NFS, while having the Build Directory use NFS.
+
+      The filesystem used by :term:`TMPDIR` must have standard filesystem
+      semantics (i.e. mixed-case files are unique, POSIX file locking, and
+      persistent inodes). Due to various issues with NFS and bugs in some
+      implementations, NFS does not meet this minimum requirement.
+      Consequently, :term:`TMPDIR` cannot be on NFS.
+
    :term:`TOPDIR`
       Points to the build directory. BitBake automatically sets this
       variable.
+
+   :term:`WORKDIR`
+      Speficies the working directory in which BitBake builds a recipe.
+      BitBake automatically sets this variable.
-- 
2.25.1


