Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB231CCD1AB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 18:00:15 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.1343.1761156006380379213
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Oct 2025 11:00:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=C7X7D99R;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b50206773adso266586966b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761156005; x=1761760805; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmWTdhTBrTN7G6tvLASWuHFrM1ChAjiSD8i9m1fGYEY=;
        b=C7X7D99Rbq2pjtgzfDglyh6vcUJnFDEABZLUJbtV7mFeU3BQnYxxpyewvTDK6j4QSI
         kQwzFsy8cAIRt/DqPtAn3IoOnIpOvntjb2u4GmGePwkBX0Ji4Nrj/5p8To6k9LsI37tW
         XSI1JjRS32G2XU0SjCOLInLOzptHxHzZRFeJCk+sVIiTqx/lrv7z3OmW9IVjzmCvVxxL
         fa0y5ndBtvXxr5SdP7SiZHO+qQH8vpawoMaZVbwEqfJPZ8pDULWEJaKcmInHj2FkdrmM
         BxleBgz7d+myvJTfCDu8CkyxjNwMjtL87jDToc0cPhw3bZ2jdKbzXPkQEJaBsRG4Bk/5
         rJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761156005; x=1761760805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmWTdhTBrTN7G6tvLASWuHFrM1ChAjiSD8i9m1fGYEY=;
        b=JhiDzcvIO254XFmkw4eljYb1NTryEQfiJJv0LIkX6z5yDPgxVSpyJSY2zNLHY04s/o
         hzrQ3kXkvl0OHbhJMDsOPi8yZSgh1WW097U+dFxYcjuqP8F25j7TJ4h4KkSxMycJR8B+
         IZaQ+1uY1sIFqYpwnhisAkdDcthSxUxhLVBvYnkq/+/erZ7kaeTM53uqoaFJCRDHX0Ce
         B+PGqcOI7GzaZFSBb5cjxAvSpplq2Vf5awW5cjwPVg3ngR6mHwfQ7CJx9xcP93QjWJzr
         Gaev5/joPPYfcKjOqzxXGkxlplZ+DjEM3OT2hBxjpMGxJPdOnwNc48F8uJEaK8P4Xzrj
         oIpg==
X-Gm-Message-State: AOJu0YxnW42yD6Cbyzi8bHcIkfW0Fajzh3eGN/jjQ3p9tFnVDFfSKoyA
	ZUjbY2FmXr9SVv1fPVGOzDPSzv/4i1sJc1KXDlp+L/DvHfVlskFKFahn9tldKA==
X-Gm-Gg: ASbGncsyoBMASrhkWkNjUVR+9K9uDJBvadUE0ZcjTyXW9wZotYVt08QScfJ46OhF+qt
	2yD/Eii1HbGIiqxiH86Q7WOBuyYnRE5l++sZcblgFcDCedf+8lO7w8HbIfuRiQEhoFPnp7nY97c
	GkGwdSBLb/5PFpCPtqt3V0HZsgm/j2E+x2CO/ExzTFCRra2LoYwM07VzN637R6KjMRi3X98Ws6M
	9YLubw33jYXBapmvhwg8awICfOHcZP07OrKWiu0v0gTsD1vGyNhMCLpUPs/bFC+1u8L+7pFveaK
	Trs3QE14UHWGxNMVN8Mhe+9wibWuicsmRLOufjDLwfVVAPSYdz2y5UD3CyXOPmZpaXv9t7JiUdq
	20+449zuxcs4PGV4feS9kXP1TfkS4D6qjs1Qdcm9TT4QDTeDIlM4UKCVhI3RKGhXpX7L6QtjD83
	DsR2rn0a4BN7GrfP5/QMgUrEG/nNrfXe0=
X-Google-Smtp-Source: AGHT+IHk4He81fPBAs7xt2KaLBFmi4SVTBaQ2rH3Ob41pSIqfwHJBXiynC+Wm9Lo9NSXjVBcJCtExA==
X-Received: by 2002:a17:907:7e9c:b0:b50:9f92:fde0 with SMTP id a640c23a62f3a-b6d2c79b133mr536404066b.29.1761156004403;
        Wed, 22 Oct 2025 11:00:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:d881:1b43:b51e:659b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8391523sm1386121166b.18.2025.10.22.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 11:00:02 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>,
	Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v2 2/2] doc: bitbake-user-manual: style and completeness corrections
Date: Wed, 22 Oct 2025 19:59:13 +0200
Message-ID: <20251022175913.13007-3-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022175913.13007-1-adam.blank.g@gmail.com>
References: <20251022175913.13007-1-adam.blank.g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 18:00:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18212

Fix encountered style issues in the fetching section.
Mention that "subdir" and fetcher specific parameters can stack-up.

Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-fetching.rst          | 67 +++++++++----------
 .../bitbake-user-manual-ref-variables.rst     |  3 +-
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 73cb1aafd..2b06c1d47 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -159,21 +159,22 @@ URLs except Git URLs, BitBake uses the common ``unpack`` method.
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
 
--  *name:* Assigns a name to a given component of the :term:`SRC_URI`.
+-  *"name":* Assigns a name to a given component of the :term:`SRC_URI`.
    This component is later referenced by this name when specifying its
    :term:`SRCREV` or :term:`SRC_URI` checksum, or to correctly place its
    revision in the package version string with aid of :term:`SRCREV_FORMAT`.
@@ -251,21 +252,19 @@ Some example URLs are as follows::
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
@@ -403,16 +402,16 @@ This fetcher supports the following parameters:
 
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
@@ -530,10 +529,10 @@ The fetcher uses the ``rcleartool`` or
 
 Following are options for the :term:`SRC_URI` statement:
 
--  *vob*: The name, which must include the prepending "/" character,
+-  *"vob":* The name, which must include the prepending "/" character,
    of the ClearCase VOB. This option is required.
 
--  *module*: The module, which must include the prepending "/"
+-  *"module":* The module, which must include the prepending "/"
    character, in the selected VOB.
 
    .. note::
@@ -545,7 +544,7 @@ Following are options for the :term:`SRC_URI` statement:
 
          load /example_vob/example_module
 
--  *proto*: The protocol, which can be either ``http`` or ``https``.
+-  *"proto":* The protocol, which can be either ``http`` or ``https``.
 
 By default, the fetcher creates a configuration specification. If you
 want this specification written to an area other than the default, use
@@ -554,9 +553,9 @@ the specification is written.
 
 .. note::
 
-   the SRCREV loses its functionality if you specify this variable. However,
-   SRCREV is still used to label the archive after a fetch even though it does
-   not define what is fetched.
+   the :term:`SRCREV` loses its functionality if you specify this variable.
+   However, :term:`SRCREV` is still used to label the archive after a fetch even
+   though it does not define what is fetched.
 
 Here are a couple of other behaviors worth mentioning:
 
@@ -618,14 +617,14 @@ the above example, the content of ``example-depot/main/source/`` will be placed
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
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index e112aced1..d47a99210 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1644,7 +1644,8 @@ overview of their function and contents.
       -  ``subdir``: Places the file (or extracts its contents) into the
          specified subdirectory. This option is useful for unusual tarballs
          or other archives that do not have their files already in a
-         subdirectory within the archive.
+         subdirectory within the archive. This path can be further modified
+         by fetcher specific parameters.
 
       -  ``subpath``: Limits the checkout to a specific subpath of the
          tree when using the Git fetcher is used.

