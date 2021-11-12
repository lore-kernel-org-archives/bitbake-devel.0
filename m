Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF41C433EF
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 16:47:59 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.18422.1636735678161559511
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Nov 2021 08:47:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 33D3DC0009;
	Fri, 12 Nov 2021 16:47:55 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: expand SRC_URI description
Date: Fri, 12 Nov 2021 17:47:47 +0100
Message-Id: <20211112164748.177526-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Nov 2021 16:47:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13035

From contents from the Yocto Project manual
Took the opportunity to reorder SRC_URI fetchers and options
alphabetically.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst     | 85 +++++++++++++------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index e955beb1..78fb2826 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1333,67 +1333,100 @@ overview of their function and contents.
       The list of source files - local or remote. This variable tells
       BitBake which bits to pull for the build and how to pull them. For
       example, if the recipe or append file needs to fetch a single tarball
-      from the Internet, the recipe or append file uses a :term:`SRC_URI` entry
-      that specifies that tarball. On the other hand, if the recipe or
-      append file needs to fetch a tarball and include a custom file, the
-      recipe or append file needs an :term:`SRC_URI` variable that specifies
-      all those sources.
-
-      The following list explains the available URI protocols:
+      from the Internet, the recipe or append file uses a :term:`SRC_URI`
+      entry that specifies that tarball. On the other hand, if the recipe or
+      append file needs to fetch a tarball, apply two patches, and include
+      a custom file, the recipe or append file needs an :term:`SRC_URI`
+      variable that specifies all those sources.
+
+      The following list explains the available URI protocols. URI
+      protocols are highly dependent on particular BitBake Fetcher
+      submodules. Depending on the fetcher BitBake uses, various URL
+      parameters are employed. For specifics on the supported Fetchers, see
+      the :ref:`bitbake-user-manual/bitbake-user-manual-fetching:fetchers`
+      section.
 
-      -  ``file://`` : Fetches files, which are usually files shipped
-         with the metadata, from the local machine. The path is relative to
-         the :term:`FILESPATH` variable.
+      -  ``az://`` : Fetches files from an Azure Storage account using HTTPS.
 
       -  ``bzr://`` : Fetches files from a Bazaar revision control
          repository.
 
-      -  ``git://`` : Fetches files from a Git revision control
+      -  ``ccrc://`` - Fetches files from a ClearCase repository.
+
+      -  ``cvs://`` : Fetches files from a CVS revision control
          repository.
 
-      -  ``osc://`` : Fetches files from an OSC (OpenSUSE Build service)
-         revision control repository.
+      -  ``file://`` - Fetches files, which are usually files shipped
+         with the Metadata, from the local machine.
+         The path is relative to the :term:`FILESPATH`
+         variable. Thus, the build system searches, in order, from the
+         following directories, which are assumed to be a subdirectories of
+         the directory in which the recipe file (``.bb``) or append file
+         (``.bbappend``) resides:
 
-      -  ``repo://`` : Fetches files from a repo (Git) repository.
+         -  ``${BPN}`` - The base recipe name without any special suffix
+            or version numbers.
 
-      -  ``http://`` : Fetches files from the Internet using HTTP.
+         -  ``${BP}`` - ``${BPN}-${PV}``. The base recipe name and
+            version but without any special package name suffix.
 
-      -  ``https://`` : Fetches files from the Internet using HTTPS.
+         -  *files -* Files within a directory, which is named ``files``
+            and is also alongside the recipe or append file.
 
       -  ``ftp://`` : Fetches files from the Internet using FTP.
 
-      -  ``cvs://`` : Fetches files from a CVS revision control
+      -  ``git://`` : Fetches files from a Git revision control
          repository.
 
       -  ``hg://`` : Fetches files from a Mercurial (``hg``) revision
          control repository.
 
+      -  ``http://`` : Fetches files from the Internet using HTTP.
+
+      -  ``https://`` : Fetches files from the Internet using HTTPS.
+
+      -  ``npm://`` - Fetches JavaScript modules from a registry.
+
+      -  ``osc://`` : Fetches files from an OSC (OpenSUSE Build service)
+         revision control repository.
+
       -  ``p4://`` : Fetches files from a Perforce (``p4``) revision
          control repository.
 
+      -  ``repo://`` : Fetches files from a repo (Git) repository.
+
       -  ``ssh://`` : Fetches files from a secure shell.
 
       -  ``svn://`` : Fetches files from a Subversion (``svn``) revision
          control repository.
 
-      -  ``az://`` : Fetches files from an Azure Storage account using HTTPS.
-
       Here are some additional options worth mentioning:
 
-      -  ``unpack`` : Controls whether or not to unpack the file if it is
-         an archive. The default action is to unpack the file.
+      -  ``downloadfilename`` : Specifies the filename used when storing
+         the downloaded file.
+
+      -  ``name`` - Specifies a name to be used for association with
+         :term:`SRC_URI` checksums or :term:`SRCREV` when you have more than one
+         file or git repository specified in :term:`SRC_URI`. For example::
+
+            SRC_URI = "git://example.com/foo.git;name=first \
+                       git://example.com/bar.git;name=second \
+                       http://example.com/file.tar.gz;name=third"
+
+            SRCREV_first = "f1d2d2f924e986ac86fdf7b36c94bcdf32beec15"
+            SRCREV_second = "e242ed3bffccdf271b7fbaf34ed72d089537b42f"
+            SRC_URI[third.sha256sum] = "13550350a8681c84c861aac2e5b440161c2b33a3e4f302ac680ca5b686de48de"
 
       -  ``subdir`` : Places the file (or extracts its contents) into the
          specified subdirectory. This option is useful for unusual tarballs
          or other archives that do not have their files already in a
          subdirectory within the archive.
 
-      -  ``name`` : Specifies a name to be used for association with
-         :term:`SRC_URI` checksums when you have more than one file specified
-         in :term:`SRC_URI`.
+      -  ``subpath`` - Limits the checkout to a specific subpath of the
+         tree when using the Git fetcher is used.
 
-      -  ``downloadfilename`` : Specifies the filename used when storing
-         the downloaded file.
+      -  ``unpack`` : Controls whether or not to unpack the file if it is
+         an archive. The default action is to unpack the file.
 
    :term:`SRCDATE`
       The date of the source code used to build the package. This variable
-- 
2.25.1


