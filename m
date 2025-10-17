Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF18CCCD19A
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 10:20:39 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.12113.1760696435040617904
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Oct 2025 03:20:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ncUwjxDl;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63befe5f379so2316508a12.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760696433; x=1761301233; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YMbdhjSai/REh9LRPRhozbUnBNuK5lNzc/WSFvbT6aw=;
        b=ncUwjxDlzWAvsEbcWDy4erTpHDIStHUkip64rvq6pU3aLpHQCvpi5Y8xi+iH1RpOl7
         DHKUmgpGmAGQ/AIa8aRKC6vIIXx69HNzgiwc0n/kPawd/maLJ+xU4n/eg0jESVeL1FLU
         KC6c/y/raYAqe7+60QgojVlX/n22N1SZfPKGq2dsimOfqZ7VgVp5gXQdCK+Pk5zW1GBG
         1nt6Vv4L4arpavrfISbbJjegy+lts0IgAfp4uQZbOl5kxH8QHhVOQAXyKjtNCXWo8Fx/
         C9Tu/I2HBJOhclSYzqCz4V0+z98wO9o0BciTfvaBlaEKcWiG0dq5bfAI6Ug4RqiGx1WR
         Fjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760696433; x=1761301233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMbdhjSai/REh9LRPRhozbUnBNuK5lNzc/WSFvbT6aw=;
        b=n4GF9dcx0VqKw5gh8BuSDjHJY7QodQ40VcVuTVtQjgSWybu4tA4z+JcyebxbjD7or3
         bM0mDrdV9C86r1N6XK6xmZoqa/Blq+yXuolNvsHAv86WJ7ZOtcL2zKEmO6Ed6PwApbZM
         Zh5BSqtroV1xLvC06y3Modc9vwJvTuqOIR58UiDbnT+bWeDKHFHs38DdgH84nX0g2vI4
         Ab5NT8RK/mU0dMH5yY5z29eernKC/J9jMYu/A6OBH6o3iNK8lEH+YdT+Qzaroju9lqK5
         IcLoukalvf5D91qTNZ19gR0Wq6EdPM8MyU1Ht5AygJkqvc4ph6fXL4Tcwo1FI6rHPPPD
         l9mQ==
X-Gm-Message-State: AOJu0YwKcmcrbEV9mbjDYqrJfs74CzcTPZ7qHr+F/g3bHcslxKd1AQId
	vMCeF+FhADtQ44u5e2hVCSTerDtqegEO9vjKbui69RrW0BhwqpPXdVm3VaScgg==
X-Gm-Gg: ASbGncufkAWDJ4nHrr9NiqoadwZAko84mvbOdxvC+vmgvQL0JqRiaeByKqNvAcXRd5v
	3NYs/EkwpDLbYOuuiclHQLRTBLAq9vI+3eV0aO9xFy/9YxfBUNdprWcCRESUhQLI6HYiU2F9/My
	ZBeQfEs7xo8caHUAJLyYcdCqh2O7s71aNQxyqolGv6JRh2rJiKL2mqaatoQ6Q+W6xfjuUykBDyZ
	n47oWB7EsyDWaYnA6jmeUMaCD+Ija21VjO/9gjwAhFgGOtgQ4i/oC8OlgqK8WxCZuYn2D1/VK/1
	oII8komNlQRCiqWlN7cqrqOYNmYGWWmc0KsOskF0XhALGXpjOCzDrj8vDb/70zRJlcfGSKJZlWQ
	LSJvNRm4+URk9X8ccBHAVhiwMGnyZVByoz36smQypISYHgczrWF2ImjAZOuzVfjAcqL1xa6J6bc
	MCsZK4iFu/xEQPwKWPf4GTXma6BBq+Hx4=
X-Google-Smtp-Source: AGHT+IH2h5Y9Ie2tsBzph4af3l0pkn1o7OdcPPHkqVJ3WVwXYBZskjP+UAtI/Lf117XR9N74Q+KW1Q==
X-Received: by 2002:a05:6402:3046:10b0:634:bb0c:728 with SMTP id 4fb4d7f45d1cf-63c1f6c0d4amr2458634a12.23.1760696432930;
        Fri, 17 Oct 2025 03:20:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:b592:c035:b59d:ab62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c3218a8sm18873967a12.40.2025.10.17.03.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:20:32 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>
Subject: [PATCH] doc: bitbake-user-manual: AUTOREV and SRCREV_FORMAT roles in fetching
Date: Fri, 17 Oct 2025 12:20:15 +0200
Message-ID: <20251017102015.5296-1-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Oct 2025 10:20:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18184

Describe the roles of AUTOREV and SRCREV_FORMAT in the fetching step.
Add their missing descriptions to the variable reference section.
Correct encountered style issues.

Fixes [YOCTO #14498]

Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
---
 .../bitbake-user-manual-fetching.rst          | 115 ++++++++++++------
 .../bitbake-user-manual-ref-variables.rst     |  22 +++-
 2 files changed, 95 insertions(+), 42 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f357765b7..1b5fa3ae1 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -42,7 +42,7 @@ The instantiation of the fetch class is usually followed by::
    rootdir = l.getVar('UNPACKDIR')
    fetcher.unpack(rootdir)
 
-This code unpacks the downloaded files to the specified by ``UNPACKDIR``.
+This code unpacks the downloaded files to the specified :term:`UNPACKDIR`.
 
 .. note::
 
@@ -51,7 +51,7 @@ This code unpacks the downloaded files to the specified by ``UNPACKDIR``.
    examine the OpenEmbedded class file ``base.bbclass``
    .
 
-The :term:`SRC_URI` and ``UNPACKDIR`` variables are not hardcoded into the
+The :term:`SRC_URI` and :term:`UNPACKDIR` variables are not hardcoded into the
 fetcher, since those fetcher methods can be (and are) called with
 different variable names. In OpenEmbedded for example, the shared state
 (sstate) code uses the fetch module to fetch the sstate files.
@@ -159,19 +159,25 @@ URLs except Git URLs, BitBake uses the common ``unpack`` method.
 A number of parameters exist that you can specify within the URL to
 govern the behavior of the unpack stage:
 
--  *unpack:* Controls whether the URL components are unpacked. If set to
+-  *"unpack":* Controls whether the URL components are unpacked. If set to
    "1", which is the default, the components are unpacked. If set to
    "0", the unpack stage leaves the file alone. This parameter is useful
    when you want an archive to be copied in and not be unpacked.
 
--  *dos:* Applies to ``.zip`` and ``.jar`` files and specifies whether
+-  *"dos":* Applies to ``.zip`` and ``.jar`` files and specifies whether
    to use DOS line ending conversion on text files.
 
--  *striplevel:* Strip specified number of leading components (levels)
-   from file names on extraction
+-  *"striplevel":* Strip specified number of leading components (levels)
+   from file names on extraction.
 
--  *subdir:* Unpacks the specific URL to the specified subdirectory
-   within the root directory.
+-  *"subdir":* Unpacks the specific URL to the specified subdirectory
+   within the specified root directory. This path can be further modified
+   by fetcher specific parameters.
+
+-  *"name":* Assigns a name to a given component of the :term:`SRC_URI`.
+   This component is later referenced by this name when specifying its
+   :term:`SRCREV` or :term:`SRC_URI` checksum, or to correctly place its
+   revision in the package version string with aid of :term:`SRCREV_FORMAT`.
 
 The unpack call automatically decompresses and extracts files with ".Z",
 ".z", ".gz", ".xz", ".zip", ".jar", ".ipk", ".rpm". ".srpm", ".deb" and
@@ -246,21 +252,19 @@ Some example URLs are as follows::
    introduce ambiguity when parsing URLs that also contain semi-colons,
    for example::
 
-           SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47"
-
+      SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47"
 
    Such URLs should should be modified by replacing semi-colons with '&'
    characters::
 
-           SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47"
-
+      SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47"
 
    In most cases this should work. Treating semi-colons and '&' in
    queries identically is recommended by the World Wide Web Consortium
    (W3C). Note that due to the nature of the URL, you may have to
    specify the name of the downloaded file as well::
 
-           SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47;downloadfilename=myfile.bz2"
+      SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47;downloadfilename=myfile.bz2"
 
 
 .. _cvs-fetcher:
@@ -398,16 +402,16 @@ This fetcher supports the following parameters:
 
    .. note::
 
-     When ``protocol`` is "ssh", the URL expected in :term:`SRC_URI` differs
-     from the one that is typically passed to ``git clone`` command and provided
-     by the Git server to fetch from. For example, the URL returned by GitLab
-     server for ``mesa`` when cloning over SSH is
-     ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the expected URL in
-     :term:`SRC_URI` is the following::
+      When ``protocol`` is "ssh", the URL expected in :term:`SRC_URI` differs
+      from the one that is typically passed to ``git clone`` command and provided
+      by the Git server to fetch from. For example, the URL returned by GitLab
+      server for ``mesa`` when cloning over SSH is
+      ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the expected URL in
+      :term:`SRC_URI` is the following::
 
-       SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;branch=main;protocol=ssh;..."
+         SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;branch=main;protocol=ssh;..."
 
-     Note the ``:`` character changed for a ``/`` before the path to the project.
+      Note the ``:`` character changed for a ``/`` before the path to the project.
 
 -  *"nocheckout":* Tells the fetcher to not checkout source code when
    unpacking when set to "1". Set this option for the URL where there is
@@ -453,7 +457,7 @@ This fetcher supports the following parameters:
    By default, the path is ``git/``.
 
 -  *"usehead":* Enables local ``git://`` URLs to use the current branch
-   HEAD as the revision for use with ``AUTOREV``. The "usehead"
+   HEAD as the revision for use with :term:`AUTOREV`. The "usehead"
    parameter implies no branch and only works when the transfer protocol
    is ``file://``.
 
@@ -525,10 +529,10 @@ The fetcher uses the ``rcleartool`` or
 
 Following are options for the :term:`SRC_URI` statement:
 
--  *vob*: The name, which must include the prepending "/" character,
+-  *"vob":*: The name, which must include the prepending "/" character,
    of the ClearCase VOB. This option is required.
 
--  *module*: The module, which must include the prepending "/"
+-  *"module":*: The module, which must include the prepending "/"
    character, in the selected VOB.
 
    .. note::
@@ -540,7 +544,7 @@ Following are options for the :term:`SRC_URI` statement:
 
          load /example_vob/example_module
 
--  *proto*: The protocol, which can be either ``http`` or ``https``.
+-  *"proto"*: The protocol, which can be either ``http`` or ``https``.
 
 By default, the fetcher creates a configuration specification. If you
 want this specification written to an area other than the default, use
@@ -549,9 +553,9 @@ the specification is written.
 
 .. note::
 
-   the SRCREV loses its functionality if you specify this variable. However,
-   SRCREV is still used to label the archive after a fetch even though it does
-   not define what is fetched.
+   the :term:`SRCREV` loses its functionality if you specify this variable.
+   However, :term:`SRCREV` is still used to label the archive after a fetch even
+   though it does not define what is fetched.
 
 Here are a couple of other behaviors worth mentioning:
 
@@ -606,21 +610,23 @@ password, and fetches a Revision based on a Label::
 
 .. note::
 
-   You should always set S to "${UNPACKDIR}/p4" in your recipe.
+   Your recipe should always set S as shown in the above example::
+
+     S = "${UNPACKDIR}/p4"
 
 By default, the fetcher strips the depot location from the local file paths. In
 the above example, the content of ``example-depot/main/source/`` will be placed
 in ``${UNPACKDIR}/p4``.  For situations where preserving parts of the remote depot
 paths locally is desirable, the fetcher supports two parameters:
 
-- *"module":*
-    The top-level depot location or directory to fetch. The value of this
-    parameter can also point to a single file within the depot, in which case
-    the local file path will include the module path.
-- *"remotepath":*
-    When used with the value "``keep``", the fetcher will mirror the full depot
-    paths locally for the specified location, even in combination with the
-    ``module`` parameter.
+-  *"module":*
+   The top-level depot location or directory to fetch. The value of this
+   parameter can also point to a single file within the depot, in which case
+   the local file path will include the module path.
+-  *"remotepath":*
+   When used with the value "``keep``", the fetcher will mirror the full depot
+   paths locally for the specified location, even in combination with the
+   ``module`` parameter.
 
 Here is an example use of the the ``module`` parameter::
 
@@ -843,4 +849,37 @@ submodules. However, you might find the code helpful and readable.
 Auto Revisions
 ==============
 
-We need to document ``AUTOREV`` and :term:`SRCREV_FORMAT` here.
+For recipes which need to use the latest revision of their source code,
+the way to achieve it is to use :term:`AUTOREV` as the value of the
+source code repository's :term:`SRCREV`::
+
+   SRCREV = "${AUTOREV}"
+
+In this case, to properly show the revision information in the package's version
+string, :term:`PV` should be set to include the ``+`` sign.
+
+.. note::
+
+   With :term:`AUTOREV`, BitBake will always need to take the additional step of
+   querying the remore repository to retrieve the latest available revision.
+
+   Also, recipes using it don't benefit from the caching mechanism.
+
+Multiple Source Control Repositories
+====================================
+
+For some recipes it is necessary to make use of more than one
+version controlled source code repository. It such case, the recipe
+must provide BitBake with information about how it should include
+all those SCM versions in its package version string, instead of its
+usual approach with a single :term:`SRCREV`.
+
+For this purpose, the recipe must set the :term:`SRCREV_FORMAT`
+variable. One notable example is the OpenEmbedded ``kernel-yocto.bbclass``::
+
+   SRCREV_FORMAT ?= "meta_machine"
+
+The value given to :term:`SRCREV_FORMAT` references names, which were
+assigned using the ``name`` parameter to those components of :term:`SRC_URI`,
+which represent the version controlled source code repositories. In the above
+example, the :term:`SRC_URI` contained two URLs named "meta" and "machine".
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 810f88689..9256c20b6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -36,6 +36,14 @@ overview of their function and contents.
       when specified allows for the Git binary from the host to be used
       rather than building ``git-native``.
 
+   :term:`AUTOREV`
+      This is a special variable used during fetching. When :term:`SRCREV` is
+      set to the value of this variable, it means that the latest revision
+      from the version controlled source code repository should be used.
+      Here is an example::
+
+         SRCREV = "${AUTOREV}"
+
    :term:`AZ_SAS`
       Azure Storage Shared Access Signature, when using the
       :ref:`Azure Storage fetcher <bitbake-user-manual/bitbake-user-manual-fetching:fetchers>`
@@ -1622,7 +1630,8 @@ overview of their function and contents.
 
       -  ``name``: Specifies a name to be used for association with
          :term:`SRC_URI` checksums or :term:`SRCREV` when you have more than one
-         file or git repository specified in :term:`SRC_URI`. For example::
+         file or source control repository specified in :term:`SRC_URI`.
+         For example::
 
             SRC_URI = "git://example.com/foo.git;branch=main;name=first \
                        git://example.com/bar.git;branch=main;name=second \
@@ -1635,7 +1644,8 @@ overview of their function and contents.
       -  ``subdir``: Places the file (or extracts its contents) into the
          specified subdirectory. This option is useful for unusual tarballs
          or other archives that do not have their files already in a
-         subdirectory within the archive.
+         subdirectory within the archive. This path can be further modified
+         by fetcher specific parameters.
 
       -  ``subpath``: Limits the checkout to a specific subpath of the
          tree when using the Git fetcher is used.
@@ -1657,11 +1667,11 @@ overview of their function and contents.
       identifier and not just a tag.
 
    :term:`SRCREV_FORMAT`
-      Helps construct valid :term:`SRCREV` values when
+      Helps construct a valid package version string when
       multiple source controlled URLs are used in
       :term:`SRC_URI`.
 
-      The system needs help constructing these values under these
+      The system needs help constructing this value under these
       circumstances. Each component in the :term:`SRC_URI` is assigned a name
       and these are referenced in the :term:`SRCREV_FORMAT` variable. Consider
       an example with URLs named "machine" and "meta". In this case,
@@ -1697,3 +1707,7 @@ overview of their function and contents.
    :term:`TOPDIR`
       Points to the build directory. BitBake automatically sets this
       variable.
+
+   :term:`UNPACKDIR`
+      The directory into which recipe's downloads are unpacked during its
+      build process.

