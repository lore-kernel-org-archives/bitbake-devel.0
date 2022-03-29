Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880B9C433EF
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 13:08:02 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web12.6356.1648559281406018277
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 06:08:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ibhPv08w;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 0A983E001C;
	Tue, 29 Mar 2022 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648559279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k2Yee8q4ic05bo4RTjEBtShyJz7SMHAbQIqT/DRODd8=;
	b=ibhPv08wbgreCQMXCxqapKu8kU78H+8t0YJWP1EL/x92j6AGKG3yQivl7ZybI9G36aXTpS
	5sGer/ZZkAFEvnB3NThDVDHX6Mofz+YrHSEtnZVft+JUSd9SlhohBHO+hP/R9BaqRDIPXe
	8FAAqXwAfVC51u46gWNYRcFAw/9lYyuPJmWlZdYEwlJH1q42EXhseeJJE31bOKUXoW2rPk
	dz+BajNhxSNaH1a3oYDd0m2Bv6aqVbDQQhrtLzC1AX0xfBt1Aw9Osm6w51D61FWV032GCQ
	I6/mQLL4yZvnBWrzcqpVFdpHmmaDPGenU7KuTukLAQwqNnQp780oQovg9Kw2rg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: punctuation fixes
Date: Tue, 29 Mar 2022 15:07:47 +0200
Message-Id: <20220329130747.364485-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 13:08:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13536

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

- Replace hyphens by em dashes when necessary
  See https://www.grammarly.com/blog/hyphens-and-dashes/
- No uppercase after em dashes
- No uppercase after colons if what follows is not a
  complete sentence.
- Fix spacing before colons ":"
- Replace em-dashes with colons for consistency in a section

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/README                                    |  2 +-
 .../bitbake-user-manual-execution.rst         |  4 +-
 .../bitbake-user-manual-metadata.rst          |  4 +-
 .../bitbake-user-manual-ref-variables.rst     | 64 +++++++++----------
 4 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/doc/README b/doc/README
index 7325831d..d4f56afa 100644
--- a/doc/README
+++ b/doc/README
@@ -8,7 +8,7 @@ Manual Organization
 
 Folders exist for individual manuals as follows:
 
-* bitbake-user-manual      - The BitBake User Manual 
+* bitbake-user-manual      --- The BitBake User Manual 
 
 Each folder is self-contained regarding content and figures.
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index 088eb818..7a22e96e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -523,7 +523,7 @@ it cannot figure out dependencies.
 Thus far, this section has limited discussion to the direct inputs into
 a task. Information based on direct inputs is referred to as the
 "basehash" in the code. However, there is still the question of a task's
-indirect inputs - the things that were already built and present in the
+indirect inputs --- the things that were already built and present in the
 build directory. The checksum (or signature) for a particular task needs
 to add the hashes of all the tasks on which the particular task depends.
 Choosing which dependencies to add is a policy decision. However, the
@@ -534,7 +534,7 @@ At the code level, there are a variety of ways both the basehash and the
 dependent task hashes can be influenced. Within the BitBake
 configuration file, we can give BitBake some extra information to help
 it construct the basehash. The following statement effectively results
-in a list of global variable dependency excludes - variables never
+in a list of global variable dependency excludes --- variables never
 included in any checksum. This example uses variables from OpenEmbedded
 to help illustrate the concept::
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index ea42d77c..af4b1358 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1658,8 +1658,8 @@ user interfaces:
 
 .. _variants-class-extension-mechanism:
 
-Variants - Class Extension Mechanism
-====================================
+Variants --- Class Extension Mechanism
+======================================
 
 BitBake supports multiple incarnations of a recipe file via the
 :term:`BBCLASSEXTEND` variable.
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 96cfdc82..af4ff980 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -503,14 +503,14 @@ overview of their function and contents.
       Selects the name of the scheduler to use for the scheduling of
       BitBake tasks. Three options exist:
 
-      -  *basic* - The basic framework from which everything derives. Using
+      -  *basic* --- the basic framework from which everything derives. Using
          this option causes tasks to be ordered numerically as they are
          parsed.
 
-      -  *speed* - Executes tasks first that have more tasks depending on
+      -  *speed* --- executes tasks first that have more tasks depending on
          them. The "speed" option is the default.
 
-      -  *completion* - Causes the scheduler to try to complete a given
+      -  *completion* --- causes the scheduler to try to complete a given
          recipe once its build has started.
 
    :term:`BB_SCHEDULERS`
@@ -557,10 +557,10 @@ overview of their function and contents.
 
       The variable can be set using one of two policies:
 
-      -  *cache* - Retains the value the system obtained previously rather
+      -  *cache* --- retains the value the system obtained previously rather
          than querying the source control system each time.
 
-      -  *clear* - Queries the source controls system every time. With this
+      -  *clear* --- queries the source controls system every time. With this
          policy, there is no cache. The "clear" policy is the default.
 
    :term:`BB_STRICT_CHECKSUM`
@@ -686,7 +686,7 @@ overview of their function and contents.
       This variable is useful in situations where the same recipe appears
       in more than one layer. Setting this variable allows you to
       prioritize a layer against other layers that contain the same recipe
-      - effectively letting you control the precedence for the multiple
+      --- effectively letting you control the precedence for the multiple
       layers. The precedence established through this variable stands
       regardless of a recipe's version (:term:`PV` variable).
       For example, a layer that has a recipe with a higher :term:`PV` value but
@@ -1331,7 +1331,7 @@ overview of their function and contents.
       The section in which packages should be categorized.
 
    :term:`SRC_URI`
-      The list of source files - local or remote. This variable tells
+      The list of source files --- local or remote. This variable tells
       BitBake which bits to pull for the build and how to pull them. For
       example, if the recipe or append file needs to fetch a single tarball
       from the Internet, the recipe or append file uses a :term:`SRC_URI`
@@ -1347,17 +1347,17 @@ overview of their function and contents.
       the :ref:`bitbake-user-manual/bitbake-user-manual-fetching:fetchers`
       section.
 
-      -  ``az://`` : Fetches files from an Azure Storage account using HTTPS.
+      -  ``az://``: Fetches files from an Azure Storage account using HTTPS.
 
-      -  ``bzr://`` : Fetches files from a Bazaar revision control
+      -  ``bzr://``: Fetches files from a Bazaar revision control
          repository.
 
-      -  ``ccrc://`` - Fetches files from a ClearCase repository.
+      -  ``ccrc://``: Fetches files from a ClearCase repository.
 
-      -  ``cvs://`` : Fetches files from a CVS revision control
+      -  ``cvs://``: Fetches files from a CVS revision control
          repository.
 
-      -  ``file://`` - Fetches files, which are usually files shipped
+      -  ``file://``: Fetches files, which are usually files shipped
          with the Metadata, from the local machine.
          The path is relative to the :term:`FILESPATH`
          variable. Thus, the build system searches, in order, from the
@@ -1365,51 +1365,51 @@ overview of their function and contents.
          the directory in which the recipe file (``.bb``) or append file
          (``.bbappend``) resides:
 
-         -  ``${BPN}`` - The base recipe name without any special suffix
+         -  ``${BPN}``: the base recipe name without any special suffix
             or version numbers.
 
-         -  ``${BP}`` - ``${BPN}-${PV}``. The base recipe name and
+         -  ``${BP}`` - ``${BPN}-${PV}``: the base recipe name and
             version but without any special package name suffix.
 
-         -  *files -* Files within a directory, which is named ``files``
+         -  ``files``: files within a directory, which is named ``files``
             and is also alongside the recipe or append file.
 
-      -  ``ftp://`` : Fetches files from the Internet using FTP.
+      -  ``ftp://``: Fetches files from the Internet using FTP.
 
-      -  ``git://`` : Fetches files from a Git revision control
+      -  ``git://``: Fetches files from a Git revision control
          repository.
 
-      -  ``gitsm://`` : Fetches submodules from a Git revision control
+      -  ``gitsm://``: Fetches submodules from a Git revision control
          repository.
 
-      -  ``hg://`` : Fetches files from a Mercurial (``hg``) revision
+      -  ``hg://``: Fetches files from a Mercurial (``hg``) revision
          control repository.
 
-      -  ``http://`` : Fetches files from the Internet using HTTP.
+      -  ``http://``: Fetches files from the Internet using HTTP.
 
-      -  ``https://`` : Fetches files from the Internet using HTTPS.
+      -  ``https://``: Fetches files from the Internet using HTTPS.
 
-      -  ``npm://`` - Fetches JavaScript modules from a registry.
+      -  ``npm://``: Fetches JavaScript modules from a registry.
 
-      -  ``osc://`` : Fetches files from an OSC (OpenSUSE Build service)
+      -  ``osc://``: Fetches files from an OSC (OpenSUSE Build service)
          revision control repository.
 
-      -  ``p4://`` : Fetches files from a Perforce (``p4``) revision
+      -  ``p4://``: Fetches files from a Perforce (``p4``) revision
          control repository.
 
-      -  ``repo://`` : Fetches files from a repo (Git) repository.
+      -  ``repo://``: Fetches files from a repo (Git) repository.
 
-      -  ``ssh://`` : Fetches files from a secure shell.
+      -  ``ssh://``: Fetches files from a secure shell.
 
-      -  ``svn://`` : Fetches files from a Subversion (``svn``) revision
+      -  ``svn://``: Fetches files from a Subversion (``svn``) revision
          control repository.
 
       Here are some additional options worth mentioning:
 
-      -  ``downloadfilename`` : Specifies the filename used when storing
+      -  ``downloadfilename``: Specifies the filename used when storing
          the downloaded file.
 
-      -  ``name`` - Specifies a name to be used for association with
+      -  ``name``: Specifies a name to be used for association with
          :term:`SRC_URI` checksums or :term:`SRCREV` when you have more than one
          file or git repository specified in :term:`SRC_URI`. For example::
 
@@ -1421,15 +1421,15 @@ overview of their function and contents.
             SRCREV_second = "e242ed3bffccdf271b7fbaf34ed72d089537b42f"
             SRC_URI[third.sha256sum] = "13550350a8681c84c861aac2e5b440161c2b33a3e4f302ac680ca5b686de48de"
 
-      -  ``subdir`` : Places the file (or extracts its contents) into the
+      -  ``subdir``: Places the file (or extracts its contents) into the
          specified subdirectory. This option is useful for unusual tarballs
          or other archives that do not have their files already in a
          subdirectory within the archive.
 
-      -  ``subpath`` - Limits the checkout to a specific subpath of the
+      -  ``subpath``: Limits the checkout to a specific subpath of the
          tree when using the Git fetcher is used.
 
-      -  ``unpack`` : Controls whether or not to unpack the file if it is
+      -  ``unpack``: Controls whether or not to unpack the file if it is
          an archive. The default action is to unpack the file.
 
    :term:`SRCDATE`
-- 
2.25.1


