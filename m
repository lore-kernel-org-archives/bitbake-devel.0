Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6F7C61DD3
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 01:37:23 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3438.1787708237068537459
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 18:37:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BVdYaz+i;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-930f618435cso22679885a.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 18:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787708236; x=1788313036; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+MKszRxE5v+/ejGd2uRRZbnHvmyaYJJq3HcPThZvIsE=;
        b=BVdYaz+iGCbin+2afUPjMRCMw4uSzXdD1GFior9xyl0GMDGvsFEpdaOfX5UV0XLHRk
         0VR8dXCHihaiy+0LCY8e4uD8+bcl31TeN3/eCdVpYd8QjlxL4a7nVbpfzoAzaAWIi0JZ
         19aZCBEA/jIGjIn3d8NAgxJ/J8YrnWi89L2fZNxqgj7VbP5d9NdRKDsprWlfqvnUabSw
         bNjSZ1g1hnKa5JY2wZfotCOp+A7KjKMcTCxBpwUlhrhmZ0Xbk58udNNeymwtryKMss14
         sSCgKgyvZJHJU+TD6iDe4ddpXupG+Om7A6ZWXuKDH8Ss+A9GGCeAiiFLO/+gY3M3QH9Q
         uZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787708236; x=1788313036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+MKszRxE5v+/ejGd2uRRZbnHvmyaYJJq3HcPThZvIsE=;
        b=nI/V0tsZz6w5woi4Bu/W0wqGOjF+adm03GPofYKPcWU7JVUsunJGc4by3hytPYtSYu
         ONiYYzmHVwZYGe6yfk9vIEoejFLwuknLAacktW/HVI/5Fs5yxdid8nxDBrXDubzTMIe9
         cVP8CA6l9QcDLsZlB15eK+c9Ltb57VxzcwHvTgV3me9T/xSz8Hd6H730T3vitiHfvLrZ
         nL/h+VefovHtQFHlPsoOhlAYAMOmkbFxalTuZlGlj68oAvTLXvM0aPc7gDMhRuR593pq
         lQbQ9Tx466hLWKZCJJCtKwiH0S2MwFTlwOml1yKoCnANagjHU6hpn9NnHoqFl+NiguAN
         1+wA==
X-Gm-Message-State: AFuF++mwpVd3xpTQKM2gXBDbKQTYpVwbBCRMZVAgwWVOrN2hf7xJceZx
	QKw2UMc7VR7RXVARgalYMSpiGF2r6E+YBqR77J4WYEeiKZkuX3NZrX6lt7Kabipw
X-Gm-Gg: AR+sD11zjpe7yIKNI748z9Ed0G44gfbvie4dRbBFnU7PwfdwB6gineAgj+pQcfZoemP
	Mc0I2WviexMprEiOgAlUUDlhDcx0aKF45o4SjAvccri0gx2HrHxvEYTx0BZzQX/0FrlTKqulSAj
	T/6L/5l+W58P07KUnxGUUIOonOxBfu7rxusB5kR8zkaL+5fqaz3NnOvMHCdHrEO6xHptzuv0cz0
	9YoAHaID2HLSd4dKZVmXkhYCZfPzaRD4bFXzwwseDOLyCaz+9RKrjInWvKyZlfPOc+CA8nZX7R7
	xzDIuUvC4Ucf3oOlhQS8XivR1bIMDajsv5r92GuEY9iHMzIv0bPBkVrMqBUw1yHOPCT8iR/wGpu
	qjqaomXzaOnkBJF2Px33Mth/eX9vlRvwqaT2KrLahy/GsjNGWVoa2rp6KusiZG5NPbYL2qBVfsf
	a5EjLaqGah3OKhab5GCc4ftK17vz3lo234CFX9sYx9w9kM6h/rPx2XK68EWdlfL/nOH6wvFve/f
	29Kxrm1LitotkOxAofb8yGV1Sj6YiE+iabC9Xb6lQ==
X-Received: by 2002:a05:620a:701c:b0:92e:f372:7b5b with SMTP id af79cd13be357-93780107a2fmr272907985a.10.1787708235733;
        Tue, 25 Aug 2026 18:37:15 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e67c50esm103863685a.37.2026.08.25.18.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 18:37:13 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: docs@lists.yoctoproject.org
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] doc: bitbake-user-manual-fetching: use the bitbake code-block language
Date: Tue, 25 Aug 2026 21:37:02 -0400
Message-ID: <20260826013703.2674786-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260826013703.2674786-1-twoerner@gmail.com>
References: <20260826013703.2674786-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 01:37:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20053

BitBake snippets here render as unhighlighted text. A reStructuredText
literal block carries no language, and Sphinx falls back to a default
that cannot recognise BitBake metadata.

Pygments 2.21 added a BitBake lexer, so tag these 34 blocks
explicitly. Variable names, assignment operators, override chains,
expansions and shell or Python task bodies are then highlighted.

AI-Generated: codex/claude-opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../bitbake-user-manual-fetching.rst          | 124 +++++++++++++-----
 1 file changed, 93 insertions(+), 31 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 2993eda49439..f98e3176333d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -85,7 +85,9 @@ In the former case, the URL is passed to the ``wget`` fetcher, which does not
 understand "git". Therefore, the latter case is the correct form since the Git
 fetcher does know how to use HTTP as a transport.
 
-Here are some examples that show commonly used mirror definitions::
+Here are some examples that show commonly used mirror definitions:
+
+.. code-block:: bitbake
 
    PREMIRRORS ?= "\
       git://.*/.\*  http://somemirror.org/sources/ \
@@ -112,19 +114,25 @@ File integrity is of key importance for reproducing builds. For
 non-local archive downloads, the fetcher code can verify SHA-256 and MD5
 checksums to ensure the archives have been downloaded correctly. You can
 specify these checksums by using the :term:`SRC_URI` variable with the
-appropriate varflags as follows::
+appropriate varflags as follows:
+
+.. code-block:: bitbake
 
    SRC_URI[md5sum] = "value"
    SRC_URI[sha256sum] = "value"
 
 You can also specify the checksums as
-parameters on the :term:`SRC_URI` as shown below::
+parameters on the :term:`SRC_URI` as shown below:
+
+.. code-block:: bitbake
 
   SRC_URI = "http://example.com/foobar.tar.bz2;md5sum=4a8e0f237e961fd7785d19d07fdb994d"
 
 If multiple URIs exist, you can specify the checksums either directly as
 in the previous example, or you can name the URLs. The following syntax
-shows how you name the URIs::
+shows how you name the URIs:
+
+.. code-block:: bitbake
 
    SRC_URI = "http://example.com/foobar.tar.bz2;name=foo"
    SRC_URI[foo.md5sum] = 4a8e0f237e961fd7785d19d07fdb994d
@@ -262,7 +270,9 @@ time the ``download()`` method is called.
 If you specify a directory, the entire directory is unpacked.
 
 Here are a couple of example URLs, the first relative and the second
-absolute::
+absolute:
+
+.. code-block:: bitbake
 
    SRC_URI = "file://relativefile.patch"
    SRC_URI = "file:///Users/ich/very_important_software"
@@ -288,7 +298,9 @@ Authorization header will be added to each request, including across redirects.
 To instead limit the Authorization header to the first request, add
 "redirectauth=0" to the list of parameters.
 
-Some example URLs are as follows::
+Some example URLs are as follows:
+
+.. code-block:: bitbake
 
    SRC_URI = "http://oe.handhelds.org/not_there.aac"
    SRC_URI = "ftp://oe.handhelds.org/not_there_as_well.aac"
@@ -298,19 +310,25 @@ Some example URLs are as follows::
 
    Because URL parameters are delimited by semi-colons, this can
    introduce ambiguity when parsing URLs that also contain semi-colons,
-   for example::
+   for example:
+
+   .. code-block:: bitbake
 
       SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47"
 
    Such URLs should should be modified by replacing semi-colons with '&'
-   characters::
+   characters:
+
+   .. code-block:: bitbake
 
       SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47"
 
    In most cases this should work. Treating semi-colons and '&' in
    queries identically is recommended by the World Wide Web Consortium
    (W3C). Note that due to the nature of the URL, you may have to
-   specify the name of the downloaded file as well::
+   specify the name of the downloaded file as well:
+
+   .. code-block:: bitbake
 
       SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47;downloadfilename=myfile.bz2"
 
@@ -351,7 +369,9 @@ The supported parameters are as follows:
    username is different than the username used in the main URL, which
    is passed to the subversion command.
 
-Following are three examples using svn::
+Following are three examples using svn:
+
+.. code-block:: bitbake
 
    SRC_URI = "svn://myrepos/proj1;module=vip;protocol=http;rev=667"
    SRC_URI = "svn://myrepos/proj1;module=opie;protocol=svn+ssh"
@@ -385,7 +405,9 @@ This fetcher supports the following parameters:
       by the Git server to fetch from. For example, the URL returned by GitLab
       server for ``mesa`` when cloning over SSH is
       ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the expected URL in
-      :term:`SRC_URI` is the following::
+      :term:`SRC_URI` is the following:
+
+      .. code-block:: bitbake
 
          SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;branch=main;protocol=ssh;..."
 
@@ -439,7 +461,9 @@ This fetcher supports the following parameters:
    parameter implies no branch and only works when the transfer protocol
    is ``file://``.
 
-Here are some example URLs::
+Here are some example URLs:
+
+.. code-block:: bitbake
 
    SRC_URI = "git://github.com/fronteed/icheck.git;protocol=https;branch=${PV};tag=${PV}"
    SRC_URI = "git://github.com/asciidoc/asciidoc-py;protocol=https;branch=main"
@@ -496,7 +520,9 @@ repository.
 
 To use this fetcher, make sure your recipe has proper
 :term:`SRC_URI`, :term:`SRCREV`, and
-:term:`PV` settings. Here is an example::
+:term:`PV` settings. Here is an example:
+
+.. code-block:: bitbake
 
    SRC_URI = "ccrc://cc.example.org/ccrc;vob=/example_vob;module=/example_module"
    SRCREV = "EXAMPLE_CLEARCASE_TAG"
@@ -570,7 +596,9 @@ the server's URL and port number, and you can specify a username and
 password directly in your recipe within :term:`SRC_URI`.
 
 Here is an example that relies on ``P4CONFIG`` to specify the server URL
-and port, username, and password, and fetches the Head Revision::
+and port, username, and password, and fetches the Head Revision:
+
+.. code-block:: bitbake
 
    SRC_URI = "p4://example-depot/main/source/..."
    SRCREV = "${AUTOREV}"
@@ -578,7 +606,9 @@ and port, username, and password, and fetches the Head Revision::
    S = "${UNPACKDIR}/p4"
 
 Here is an example that specifies the server URL and port, username, and
-password, and fetches a Revision based on a Label::
+password, and fetches a Revision based on a Label:
+
+.. code-block:: bitbake
 
    P4PORT = "tcp:p4server.example.net:1666"
    SRC_URI = "p4://user:passwd@example-depot/main/source/..."
@@ -604,7 +634,9 @@ paths locally is desirable, the fetcher supports two parameters:
    paths locally for the specified location, even in combination with the
    ``module`` parameter.
 
-Here is an example use of the the ``module`` parameter::
+Here is an example use of the the ``module`` parameter:
+
+.. code-block:: bitbake
 
    SRC_URI = "p4://user:passwd@example-depot/main;module=source/..."
 
@@ -612,7 +644,9 @@ In this case, the content of the top-level directory ``source/`` will be fetched
 to ``${P4DIR}``, including the directory itself.  The top-level directory will
 be accesible at ``${P4DIR}/source/``.
 
-Here is an example use of the the ``remotepath`` parameter::
+Here is an example use of the the ``remotepath`` parameter:
+
+.. code-block:: bitbake
 
    SRC_URI = "p4://user:passwd@example-depot/main;module=source/...;remotepath=keep"
 
@@ -640,7 +674,9 @@ This fetcher supports the following parameters:
 
 -  *"manifest":* Name of the manifest file (default: ``default.xml``).
 
-Here are some example URLs::
+Here are some example URLs:
+
+.. code-block:: bitbake
 
    SRC_URI = "repo://REPOROOT;protocol=git;branch=some_branch;manifest=my_manifest.xml"
    SRC_URI = "repo://REPOROOT;protocol=file;branch=some_branch;manifest=my_manifest.xml"
@@ -663,11 +699,15 @@ Such functionality is set by the variable:
    delegate access to resources, if this variable is set, the Az Fetcher will
    use it when fetching artifacts from the cloud.
 
-You can specify the AZ_SAS variable prefixed with a ? as shown below::
+You can specify the AZ_SAS variable prefixed with a ? as shown below:
+
+.. code-block:: bitbake
 
    AZ_SAS = "?se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>"
 
-Here is an example URL::
+Here is an example URL:
+
+.. code-block:: bitbake
 
    SRC_URI = "az://<azure-storage-account>.blob.core.windows.net/<foo_container>/<bar_file>"
 
@@ -694,17 +734,23 @@ chosen bucket. Instructions for authentication can be found in the
 
 If it used from the OpenEmbedded build system, the fetcher can be used for
 fetching sstate artifacts from a GCS bucket by specifying the
-``SSTATE_MIRRORS`` variable as shown below::
+``SSTATE_MIRRORS`` variable as shown below:
+
+.. code-block:: bitbake
 
    SSTATE_MIRRORS ?= "\
        file://.* gs://<bucket name>/PATH \
    "
 
-The fetcher can also be used in recipes::
+The fetcher can also be used in recipes:
+
+.. code-block:: bitbake
 
    SRC_URI = "gs://<bucket name>/<foo_container>/<bar_file>"
 
-However, the checksum of the file should be also be provided::
+However, the checksum of the file should be also be provided:
+
+.. code-block:: bitbake
 
    SRC_URI[sha256sum] = "<sha256 string>"
 
@@ -718,7 +764,9 @@ This submodule fetches code for
 corresponding to Rust libraries and programs to compile. Such crates are typically shared
 on https://crates.io/ but this fetcher supports other crate registries too.
 
-The format for the :term:`SRC_URI` setting must be::
+The format for the :term:`SRC_URI` setting must be:
+
+.. code-block:: bitbake
 
    SRC_URI = "crate://REGISTRY/NAME/VERSION"
 
@@ -727,7 +775,9 @@ This fetcher supports the following parameters:
 -  *"protocol":* The protocol used to fetch the crates. The default is "https".
    You can also use "http".
 
-Here is an example URL::
+Here is an example URL:
+
+.. code-block:: bitbake
 
    SRC_URI = "crate://crates.io/glob/0.2.11"
 
@@ -746,7 +796,9 @@ This submodule fetches source code from an
 `NPM <https://en.wikipedia.org/wiki/Npm_(software)>`__
 Javascript package registry.
 
-The format for the :term:`SRC_URI` setting must be::
+The format for the :term:`SRC_URI` setting must be:
+
+.. code-block:: bitbake
 
    SRC_URI = "npm://some.registry.url;ParameterA=xxx;ParameterB=xxx;..."
 
@@ -763,7 +815,9 @@ This fetcher supports the following parameters:
 Note that NPM fetcher only fetches the package source itself. The dependencies
 can be fetched through the `npmsw-fetcher`_.
 
-Here is an example URL with both fetchers::
+Here is an example URL with both fetchers:
+
+.. code-block:: bitbake
 
    SRC_URI = " \
        npm://registry.npmjs.org/;package=cute-files;version=${PV} \
@@ -792,7 +846,9 @@ This submodule fetches source code from an
 description file, which lists the dependencies
 of an NPM package while locking their versions.
 
-The format for the :term:`SRC_URI` setting must be::
+The format for the :term:`SRC_URI` setting must be:
+
+.. code-block:: bitbake
 
    SRC_URI = "npmsw://some.registry.url;ParameterA=xxx;ParameterB=xxx;..."
 
@@ -804,7 +860,9 @@ This fetcher supports the following parameters:
    (``${S}`` by default).
 
 Note that the shrinkwrap file can also be provided by the recipe for
-the package which has such dependencies, for example::
+the package which has such dependencies, for example:
+
+.. code-block:: bitbake
 
    SRC_URI = " \
        npm://registry.npmjs.org/;package=cute-files;version=${PV} \
@@ -840,7 +898,9 @@ Auto Revisions
 
 For recipes which need to use the latest revision of their source code,
 the way to achieve it is to use :term:`AUTOREV` as the value of the
-source code repository's :term:`SRCREV`::
+source code repository's :term:`SRCREV`:
+
+.. code-block:: bitbake
 
    SRCREV = "${AUTOREV}"
 
@@ -862,7 +922,9 @@ the different SCM revisions in its package version string, instead of its
 usual approach with a single :term:`SRCREV`.
 
 For this purpose, the recipe must set the :term:`SRCREV_FORMAT`
-variable. Consider the following example::
+variable. Consider the following example:
+
+.. code-block:: bitbake
 
    SRC_URI = " \
        git://git.some.example.com/source-tree.git;name=machine \

