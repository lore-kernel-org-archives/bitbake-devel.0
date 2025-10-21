Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C3CCD1B9
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 18:30:06 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.20639.1761071398760216488
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Oct 2025 11:29:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q4Hztndg;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso10146381a12.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071397; x=1761676197; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTuDGp7V+A+Ilgalo/4QXAtydtp6D4lLXImQZq/bxhc=;
        b=Q4HztndgdrhpHxEvxtGsTthTj5wbbPkTqDGE3lw5M0gT+4B0L8OOvdOgzhBeo9B5+T
         2RGAaXD6IK67LPYr0rau0/rvPRMin3DHySyialLy5W41BYz8qVE/jG0sbbNsXJWbYD2X
         HBcy5AupODOg7x1kGTVwCbdSSfO6Er9DFMB5LqW++usdWC91b0lXltUYmaA4hZtJAUWU
         68Q96dGOLDMvqebXUnICWN1O5rHs464zPtqhzxTS25tXruGsxzpNsNc3xEOtstiSteqC
         JlJFLP2VFTFHeXR22vX4EkK+8sjYMBISEXKbIVI4WxhHdm1tWlBDgFFASCPvSMFInPjv
         mYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071397; x=1761676197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTuDGp7V+A+Ilgalo/4QXAtydtp6D4lLXImQZq/bxhc=;
        b=n80i+v/5HwN0LrXMhMlZ6LnW9EETz64AcP2hcF4meXcdTBuv/pSig5Y2fygQvQqAVV
         mTbY+T+B6Ls1ipZnXRuhs8xD+6Vuurc6MltMWM7PUJpVBEU2w2zpV8/KkEW++o5uxSh6
         WXOo5D0rA+EaOLUL3oMqwAQVC8fNTMa/ZYuEYfnbUJVLuaxOaYC3T0S6c00XBuHQ7bCK
         pSxQWZ8+fmGoXt0SQkZNTuZgCUw2u7AM7X+enlFR+IFulGvnLjJG0FqNAo1oNOcFM5zt
         FwHegwtHEPH9AafgOqH4BeGsEPvNyTvyuLpqzBPoi3PTvIhpxgQMp5ktv1tC7zD9Q1Rx
         yU9g==
X-Gm-Message-State: AOJu0YxmHnOaNsEKcNliJ1rm6cBG1jaXZe2K4x28EgykeMpvgjL0LSZ4
	A2T4U6HfXxS8g6bYthLidAGIr61C48/OfcG7GgtvFqdX3R2UEUG+mz3qmIXrIQ==
X-Gm-Gg: ASbGncstv8Pl4xkTSpYshB/BACPf+2MPLZJVF6uUQsG31G3HPXFr/TjsQOS049KBtXa
	SfrCBDMUrKZ1DqvU1ijD8+/uSiOBhe++USbRUtY95S3nIT1UCc3yPIQ+phxRUsSf/aYmn7JJORl
	uNdNBakjsGJH8cgGgFraxoZTEOScobMiQC+ITuYTFNEy21NQUt2lsvDajMZCOEiDFUQI2qAYi3x
	RQsNap4KFB/EMLCJpgP1yIMX00Prpc48Zp57kB9JjgItENS6eZWDbkolbmAP/5HSK2ks1QswYkk
	2qMPAIW+XROirlYQkdZuwXlVLth4boYIpped+CYQF8f848jb4TrDCfmwNqk3Gat+NNamg58oNrf
	Qvicwu5x0M57f9/IwuTfH3EDRB7VLmORl3IgzGtKYa6SNvzlIweUwgBXCNmhZhz9YRxJjkexPtd
	OTxmTPQmEFo+cWb00Y0dPz6jVs9oNPp0k=
X-Google-Smtp-Source: AGHT+IFja3TOkO4AwiqPLU+eq3xz7ALopBpctRLZ1cM2ZQGaZLHa7uHswGt3qmQgADbUk7oeUs3sNQ==
X-Received: by 2002:a17:907:7f8a:b0:b62:2352:5043 with SMTP id a640c23a62f3a-b6474940cd5mr2003484066b.46.1761071396666;
        Tue, 21 Oct 2025 11:29:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:564c:7f09:5ade:5a5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm1151383166b.54.2025.10.21.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:29:56 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>
Subject: [PATCH 3/3] doc: bitbake-user-manual: style and completeness corrections
Date: Tue, 21 Oct 2025 20:28:34 +0200
Message-ID: <20251021182834.11403-4-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021182834.11403-1-adam.blank.g@gmail.com>
References: <20251021182834.11403-1-adam.blank.g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 18:30:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18200

Fix encountered style issues in the fetching section.
Mention that "subdir" and fetcher specific parameters can stack-up.

Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
---
 .../bitbake-user-manual-fetching.rst          | 67 +++++++++----------
 .../bitbake-user-manual-ref-variables.rst     |  3 +-
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index dbb52e85a..fe23c7620 100644
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
+-  *"vob":*: The name, which must include the prepending "/" character,
    of the ClearCase VOB. This option is required.
 
--  *module*: The module, which must include the prepending "/"
+-  *"module":*: The module, which must include the prepending "/"
    character, in the selected VOB.
 
    .. note::
@@ -545,7 +544,7 @@ Following are options for the :term:`SRC_URI` statement:
 
          load /example_vob/example_module
 
--  *proto*: The protocol, which can be either ``http`` or ``https``.
+-  *"proto"*: The protocol, which can be either ``http`` or ``https``.
 
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
 
@@ -620,14 +619,14 @@ the above example, the content of ``example-depot/main/source/`` will be placed
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
index 7c864b69a..8993bab87 100644
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

