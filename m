Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC42CCCF9E2
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 18:00:05 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.1372.1761156002793569926
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Oct 2025 11:00:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KS/UaXvc;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b472842981fso975668066b.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 11:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761156001; x=1761760801; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7GghR/zgLP/e+2TZo2FffLrbHBVwGDkRMa64vgiWzY=;
        b=KS/UaXvcGc6uqf8yw8K1aIK+7ot2CWxdaOMG02Z4HHMr7mUYnOkLu37Vsgtpa0dB1Z
         augp7O6wHineo3SnKCk72FASDOXzgsSkuT75HWwYu6VASIt+34kMPTsW8k8YXYhZ8Lpw
         HMvtorta2arhiBodzB96tLVQH/MjkX6c3nUJZeYs6FLyOYWJLPhgI5eh8iVmzZFo8k2G
         1nKvUmsU3qqJ2Cxkpjd/optjl6dL7Kz1DlqNBXJJvmwWQzaixMXeHisBuuwYeWbx5g6d
         Dd6/4D6c9duBHUiOrjxB6quMr+oKMwiSLPRtvtr/Z2CU/IPts7Gz7xlbtLV98Zn+q7w/
         Af2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761156001; x=1761760801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7GghR/zgLP/e+2TZo2FffLrbHBVwGDkRMa64vgiWzY=;
        b=g4q9eOnWFnzCe4jhodY9aF7fRmsNokQ0TTjNaH5Y7qvczIvwIqk7jlng6GKxPiTxmK
         aLv+XrNb+rhDgTz+OX83FkavGgGC8jl/DN9/haiwjPdDdd4+xJ48eRJaNc+ERfd2oIWm
         3sUIXhi65fHsAodnMxY+weaOksj+8TsQ7pVBahQegGitFi29+X8CsdKd67JX3B0QIQ67
         REFPxsg1/0u7mNrYqUox4qQu7PmIaEaL0ZHihgNxRRDw6rLFgT/5+j/LWEXXZsRs8s/b
         kfYhZD4ksXalTqNU1+cD9bJ08zJ94f+dbvuzcqWse7A6701YBsew5cGCfkcHoZYje2dP
         tx7w==
X-Gm-Message-State: AOJu0YysECSJ5JvzGY/4bDu73hWmHR29uBHFLNe/EfmPbp71PWbUKHTJ
	TsXVHNLFBHgrd3cCbtJ/Zx4EmW7XMyQ7kYlLcBALQbHrelbw3S/am6OrS0FYCg==
X-Gm-Gg: ASbGnctH0qtyBDJq1j97+tf1XPa6eYU6sWsNRqopj3Edc1Xldk1YGKSZexy1A+divYD
	XseHOJMYZBFxlBz5ws2PfCCcvT4JSpqnSAe3VnrGGyWEaR5+UjzpR+lSsvPCw09tHPvd/ua/elR
	lxo7nJal4cCtpYCyCG6aNFnBDvwjOkxO7ZJkreRCq6qAK9kJbbTxaDZgdXz316gTOCQClwjvmFj
	+rVA/xFMz5q9Pgf/6y9355OxQk/ONEGQvm4D4soYkp+4EOiNPt21SAyh7x9MK7rECqXKZBIkUfa
	BzjQYSvfs7+iNSoK+kEJilpcug0utpyEAIXoFTvi4WSebn20lflo+4JBWquGOKDRkJ2Hj2cZrXU
	dOaVIEphXZZd4IikRfHaMAYEorqn4odu/uQNR+Tw9vyLdUcb0sQz7e+ecSMzpwYdBpdFGRRFJNb
	DLz/OPHFv97h3OCeS1/cxI
X-Google-Smtp-Source: AGHT+IG/VHpMKRwftBKX/1hWFOYDU3FKA0/I391A+0NwMrCi4ww79t7YS3EM3GTaS+eWhmmVWQi5/g==
X-Received: by 2002:a17:907:d89:b0:b45:e8e2:ade3 with SMTP id a640c23a62f3a-b6474637f53mr2452214066b.64.1761156000890;
        Wed, 22 Oct 2025 11:00:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:d881:1b43:b51e:659b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8391523sm1386121166b.18.2025.10.22.10.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 11:00:00 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>,
	Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v2 1/2] doc: bitbake-user-manual: AUTOREV and SRCREV_FORMAT roles in fetching
Date: Wed, 22 Oct 2025 19:59:12 +0200
Message-ID: <20251022175913.13007-2-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022175913.13007-1-adam.blank.g@gmail.com>
References: <20251022175913.13007-1-adam.blank.g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 18:00:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18211

Describe the roles of AUTOREV and SRCREV_FORMAT in the fetching step.
Add their missing descriptions to the variable reference section.

Fixes [YOCTO #14498]

Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-fetching.rst          | 47 ++++++++++++++++++-
 .../bitbake-user-manual-ref-variables.rst     | 15 ++++--
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f357765b7..73cb1aafd 100644
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
 
@@ -843,4 +848,42 @@ submodules. However, you might find the code helpful and readable.
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
+   Also, recipes using it are not part of the parsing-time cache,
+   and hence are parsed every time.
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
index 810f88689..e112aced1 100644
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

