Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B417DCCD1AF
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 18:30:06 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web10.20572.1761071396454143356
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Oct 2025 11:29:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kD4Z0EOV;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so6969287a12.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071395; x=1761676195; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7kWp/hQ5KCjmgYPA6qbidYAdxfuPY34KMUCtoqAN/A=;
        b=kD4Z0EOV0vCVCcfbbY9w7bIcphQ1sH7FBNVitc/KFXhC4awJB1G/qL9QeuO9QMGiwG
         lliP+p5wB9GQY2nglowLGuZB6G7gImT/XPqjSJuQWtnUT2x4TyC0OhsCuATDcPR6i71M
         SRJpw/9j0LFQfUZcY0RLrq5m94+NFnLWHy0/AtTwz7HLg5RdKkqaboJ3AcPVbGgk9S7l
         HIWpeMHKf9cR/doLzmnOjQsEmBwB4CL06N661phRXIzUIgF8fqcyuqVbCoiLhvLmQVyg
         MZCr2BHnW8NXApwsPNt2pdq86HEG+yh8MDEZLecoPBbBGsDFva6D0eAjf6IHHL7Ung01
         sGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071395; x=1761676195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7kWp/hQ5KCjmgYPA6qbidYAdxfuPY34KMUCtoqAN/A=;
        b=DHO1GO0VeVy/f5M+wDyKJL4Of4zeeuV2i3ChuajTT9xxvaGbwRN0lFTwECoTnZ4RUw
         GZfUAs/iBKRk7MjfiQgbnqy80fphG/Bey5D1KuITMaWWkiv4imMB3cm3zgdDNi6gbSw8
         s8aSI97vqnaTgVFAwGgY4HBDeCmrAl5sh6LohJ7ws00YFi6pjakC++uNzGr1oXz7obIp
         /AQ+tcy+xZd5b0HLVAsWMQqCLb91KbAdBa/s+xdPqWrqM9zLXgjJN0POQMCwNMcNQ6Fx
         8ncjmq1dLxespn360WrBi9Mt5lxV9scrGEuDhsu5mBi3aakDVKg3qhAazTFZcCA2LZdl
         UTiQ==
X-Gm-Message-State: AOJu0YxVb3wIH+RfHleILFqGN4AbJb7cxyjSvgJes3fUEVP29GWljSRD
	dCbqDN4coXGRRxi/qZ/gZVYqoXtGoG9wWrEg93E6u806iLRWZdd06aJ+yBHmyA==
X-Gm-Gg: ASbGncvYafCmVGweKyIVFoW2qLZZX+6ibwdm+jKNXU45IbE5frUSiuGcY4VrshrjYvH
	cLgZzP8wioijIWrMJctgIyMDaX6w7UWokkjZ2Z6hT0D7G4bHVJK5LqZKjHlYapDc+IdE/Xp5sXj
	iUMx3ZUBAjI57sNE6NKVjyxb3QxVqvpDTfEiUGVE5w9DxG8Dj/8GU8RqskRIFs8ok9ZYjV/aaT+
	KDIZkpvqbCU0PhyLkcjCj/OgUILJEgRoBu721K03LXPK7cmWCXzu57CuQcDKfFRYG/UaVgwpvDG
	WM5/dbzKuJuEsekjqMS3DXNHQ2SyBO8d4yUYviksvNSj2piccQohqO9ozBnF+TZgbHeDs+AeGKi
	UkPJ5uKaRRv+jN6H0r8gHKae1rENUBUXLrq5dZtCeC0FE/wiLXVtCTbiwB/wSIEgMZcCXvO0woO
	ne/APGPVHujpFUId4KAA1nldDgq6eRns0=
X-Google-Smtp-Source: AGHT+IFa9xyOihH4sSZoT7TDrHhdDdgb1Kky6kSzbh6wNAukhTw1dLYO9ad4KZJrD58XaaENoMbXag==
X-Received: by 2002:a17:906:40d5:b0:b65:f5a6:68aa with SMTP id a640c23a62f3a-b65f5a66b4dmr1320725766b.16.1761071394415;
        Tue, 21 Oct 2025 11:29:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:564c:7f09:5ade:5a5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm1151383166b.54.2025.10.21.11.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:29:54 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>
Subject: [PATCH 2/3] doc: bitbake-user-manual: AUTOREV and SRCREV_FORMAT roles in fetching
Date: Tue, 21 Oct 2025 20:28:33 +0200
Message-ID: <20251021182834.11403-3-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021182834.11403-1-adam.blank.g@gmail.com>
References: <20251021182834.11403-1-adam.blank.g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 18:30:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18199

Describe the roles of AUTOREV and SRCREV_FORMAT in the fetching step.
Add their missing descriptions to the variable reference section.

Fixes [YOCTO #14498]

Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
---
 .../bitbake-user-manual-fetching.rst          | 46 ++++++++++++++++++-
 .../bitbake-user-manual-ref-variables.rst     | 15 ++++--
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index d10d2f611..dbb52e85a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -173,6 +173,11 @@ govern the behavior of the unpack stage:
 -  *subdir:* Unpacks the specific URL to the specified subdirectory
    within the root directory.
 
+-  *name:* Assigns a name to a given component of the :term:`SRC_URI`.
+   This component is later referenced by this name when specifying its
+   :term:`SRCREV` or :term:`SRC_URI` checksum, or to correctly place its
+   revision in the package version string with aid of :term:`SRCREV_FORMAT`.
+
 The unpack call automatically decompresses and extracts files with ".Z",
 ".z", ".gz", ".xz", ".zip", ".jar", ".ipk", ".rpm". ".srpm", ".deb" and
 ".bz2" extensions as well as various combinations of tarball extensions.
@@ -453,7 +458,7 @@ This fetcher supports the following parameters:
    By default, the path is ``git/``.
 
 -  *"usehead":* Enables local ``git://`` URLs to use the current branch
-   HEAD as the revision for use with ``AUTOREV``. The "usehead"
+   HEAD as the revision for use with :term:`AUTOREV`. The "usehead"
    parameter implies no branch and only works when the transfer protocol
    is ``file://``.
 
@@ -845,4 +850,41 @@ submodules. However, you might find the code helpful and readable.
 Auto Revisions
 ==============
 
-We need to document ``AUTOREV`` and :term:`SRCREV_FORMAT` here.
+For recipes which need to use the latest revision of their source code,
+the way to achieve it is to use :term:`AUTOREV` as the value of the
+source code repository's :term:`SRCREV`::
+
+   SRCREV = "${AUTOREV}"
+
+.. note::
+
+   With :term:`AUTOREV`, BitBake will always need to take the additional step of
+   querying the remote repository to retrieve the latest available revision.
+
+   Also, recipes using it don't benefit from the caching mechanism.
+
+Multiple Source Control Repositories
+====================================
+
+For some recipes it is necessary to make use of more than one
+version controlled source code repository. In such case, the recipe
+must provide BitBake with information about how it should include
+the different SCM revisions in its package version string, instead of its
+usual approach with a single :term:`SRCREV`.
+
+For this purpose, the recipe must set the :term:`SRCREV_FORMAT`
+variable. Consider the following example::
+
+   SRC_URI = " \
+       git://git.some.example.com/source-tree.git;name=machine \
+       git://git.some.example.com/metadata.git;name=meta \
+       "
+   SRCREV_machine = "3f9db490a81eeb0077be3c5a5aa1388a2372232f"
+   SRCREV_meta = "1ac1d0ff730fe1dd1371823d562db8126750a98c"
+   SRCREV_FORMAT ?= "meta_machine"
+
+The value given to :term:`SRCREV_FORMAT` references names, which were
+assigned using the ``name`` parameter in the :term:`SRC_URI` definition,
+and which represent the version controlled source code repositories.
+In the above example, the :term:`SRC_URI` contained two URLs named
+"meta" and "machine".
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index e50b71380..7c864b69a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -36,6 +36,14 @@ overview of their function and contents.
       when specified allows for the Git binary from the host to be used
       rather than building ``git-native``.
 
+   :term:`AUTOREV`
+      This is a special variable used during fetching. When :term:`SRCREV` is
+      set to the value of this variable, the latest revision from the version
+      controlled source code repository is used.
+      It should be set as follows::
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
@@ -1657,11 +1666,11 @@ overview of their function and contents.
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

