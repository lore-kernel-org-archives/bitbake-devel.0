Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF723CFA46B
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 10:36:27 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12158.1763894179095330708
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 23 Nov 2025 02:36:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=T8FmA6x6;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so5205338a12.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 23 Nov 2025 02:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763894177; x=1764498977; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IXy09HhxPPTzYqUCaE7Y4FqS49YB7h/VmtJcF5j9vHs=;
        b=T8FmA6x6UIuUiKWUIjRVxXKY3T+hXgWvThnHPl9oxcNEWuZlUOGBL1jy/XmseC4R4x
         y+Tc1YMW9XayME8S6Pnz5avq5yh0cGB4c8ppQ6gsySi0xMCGKVr2QlvUU0cv6pmir9nQ
         Fmk+MaMgRzddfKnNf2nBjk3qBkce+Nc+IvGSs/JbXp0WWMoRlWYxtfdj62xO2w6qLuzE
         jYhbGWTIeExTx74jK7B0XPQ1GvvudAd+Y3jWE3jf9y+UCyB0srEFoX5KlIdWc7PqGK6L
         LPOU3CfIhWBqMfRA1L6J3LsAuMuOYO1XCsg9h8vOQVHQ0fiuoQkfHk/Dd3qwlmmU7uxQ
         xOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763894177; x=1764498977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXy09HhxPPTzYqUCaE7Y4FqS49YB7h/VmtJcF5j9vHs=;
        b=KfyNn2taaG/GxgMHuov+OTrdmuxm/YBs5kQaso1u6JXYmCQ2zMksft3RrQi1CWoeBO
         58A14+Uqz1UwuH+D+05bxD/cliP/HhfswoCgaQU5tgt+1vSV/X4LqRj3o6W8bNtLmdW4
         JM3KdZrCYZnWlEHyKovXHlDg7k0hhDkM3Vku20Ox30oGqJssPK308J22KwSklIe7d4dT
         2BA+QNE8WgYhf4dzN0aCU+jU0lB9fruNoZQmXbuBqrDsMGLVszXClrFSMSEdll+cmJp+
         OHSbIKtGKcJ29jWSKC9JOYUR04i8i9ABCvPKjJe+brR5CJC67AaYnP4xOaXYARGaX5gx
         nU6Q==
X-Gm-Message-State: AOJu0YxFqENq4riORYHmb/p8OpD0yj3m/rIsjy1DkB/Z/BwX4B6uZS1q
	tmWJfksuJ4qmFgBGV4WZ8aq6C2vvMk04mZ4pdHGdIJ5D0hBT7/dJNYLfIkcwdg==
X-Gm-Gg: ASbGncvtwy47BHtheBS4qsRKSLcNPYzBo2SCT4/m3t6iTUrIecjQ1+MFGJlHxcN5YxM
	z6fhXQ45fx5YyljQ0Iffo3O7JxzTLMlvzjPlMPZyd+2S1Ozp9wP/yoxxDtd9/9FQzOsJaLLaeyT
	ZYnMpXNnMUKJdcdbOJxHnZUqX+jdz8qq2+EZiXxTdnPNiiBntoUk4Z0pqw7EYNZAh3eFSp9cQFU
	T8oYhjzSSClgsc40dZqKi326jTE2qjIooSD5ar+6bMdAJtDhOs2YIm8Q4Goy+RZEBoZn5xxd5EG
	bQNTfY6CKFFkKmi3nNwEJwi/o6dPQh3K9Os31q/1cRB+BdV3z1cKkgLqqZl+jziEWIFbKh953bF
	8rVqp2GZQyVJ19GYOneenyKYdrCp3gXTloCD8s56khkKbNwcLKPpxBq/nPZbLt9l6HAdlo4sShF
	DPGjteOnHyAuHO86D0GGoyA5SPkNvlRKoUZMziJOMjQTn4uQ0faNw=
X-Google-Smtp-Source: AGHT+IHO6iDc3BKidjWDnPwe4cePAjTdXfvWFo10/LF9aubwMeBG6kal49cH/cMIyTYDO9Uw0Jt93g==
X-Received: by 2002:a17:907:741:b0:b72:c1e9:5f1e with SMTP id a640c23a62f3a-b7671518370mr841326866b.3.1763894177035;
        Sun, 23 Nov 2025 02:36:17 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd43e2sm960248266b.39.2025.11.23.02.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 02:36:16 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: correct the confusion over 'uri' format in json configs
Date: Sun, 23 Nov 2025 11:36:13 +0100
Message-Id: <20251123103613.2701128-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 23 Nov 2025 10:36:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18478

From: Alexander Kanavin <alex@linutronix.de>

The 'uri' property in bitbake-setup json configurations is actually
using the standard git URI syntax, and not bitbake fetcher-specific one.
Bitbake-setup converts it to something the git fetcher understands.

This was overlooked when default registry configs were added. It worked
but only by coincidence (and was using git:// protocol despite 'protocol=https'
in the value).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 default-registry/configurations/oe-nodistro.conf.json    | 6 +++---
 default-registry/configurations/poky-master.conf.json    | 8 ++++----
 .../bitbake-user-manual-environment-setup.rst            | 9 ++++-----
 setup-schema/layers.schema.json                          | 2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
index 70ae6d364..9f9314399 100644
--- a/default-registry/configurations/oe-nodistro.conf.json
+++ b/default-registry/configurations/oe-nodistro.conf.json
@@ -5,7 +5,7 @@
             "git-remote": {
                 "remotes": {
                     "origin": {
-                        "uri": "git://git.openembedded.org/bitbake;protocol=https"
+                        "uri": "https://git.openembedded.org/bitbake"
                     }
                 },
                 "branch": "master",
@@ -16,7 +16,7 @@
             "git-remote": {
                 "remotes": {
                     "origin": {
-                        "uri": "git://git.openembedded.org/openembedded-core;protocol=https"
+                        "uri": "https://git.openembedded.org/openembedded-core"
                     }
                 },
                 "branch": "master",
@@ -27,7 +27,7 @@
             "git-remote": {
                 "remotes": {
                     "origin": {
-                        "uri": "git://git.yoctoproject.org/yocto-docs;protocol=https"
+                        "uri": "https://git.yoctoproject.org/yocto-docs"
                     }
                 },
                 "branch": "master",
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 6940129a6..1de038bab 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -5,7 +5,7 @@
             "git-remote": {
                 "remotes": {
                     "origin": {
-                        "uri": "git://git.openembedded.org/bitbake;protocol=https"
+                        "uri": "https://git.openembedded.org/bitbake"
                     }
                 },
                 "branch": "master",
@@ -16,7 +16,7 @@
             "git-remote": {
                 "remotes": {
                     "origin": {
-                        "uri": "git://git.openembedded.org/openembedded-core;protocol=https"
+                        "uri": "https://git.openembedded.org/openembedded-core"
                     }
                 },
                 "branch": "master",
@@ -27,7 +27,7 @@
             "git-remote": {
                 "remotes": {
                     "origin": {
-                        "uri": "git://git.yoctoproject.org/meta-yocto;protocol=https"
+                        "uri": "https://git.yoctoproject.org/meta-yocto"
                     }
                 },
                 "branch": "master",
@@ -38,7 +38,7 @@
             "git-remote": {
                 "remotes": {
                     "origin": {
-                        "uri": "git://git.yoctoproject.org/yocto-docs;protocol=https"
+                        "uri": "https://git.yoctoproject.org/yocto-docs"
                     }
                 },
                 "branch": "master",
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 8a90e33e8..2b8051bcb 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -662,7 +662,7 @@ They contain the following sections:
                  "git-remote": {
                      "remotes": {
                          "origin": {
-                             "uri": "git://git.openembedded.org/bitbake;protocol=https"
+                             "uri": "https://git.openembedded.org/bitbake"
                          }
                      },
                      "branch": "master",
@@ -675,9 +675,8 @@ They contain the following sections:
 
    Sources can be specified with the following options:
 
-   -  ``uri`` (**required**): a URI that follows the BitBake Git fetcher syntax.
-      See the :doc:`/bitbake-user-manual/bitbake-user-manual-fetching` section
-      for more information on the Git fetcher.
+   -  ``uri`` (**required**): a URI that follows the git URI syntax.
+      See https://git-scm.com/docs/git-clone#_git_urls for more information.
 
    -  ``rev`` (**required**): the revision to checkout. Can be the name of the
       branch to checkout on the latest revision of the specified ``branch``.
@@ -879,7 +878,7 @@ Here is an example file that overrides the branch of the BitBake repository to
                    "branch": "master-next",
                    "remotes": {
                        "origin": {
-                           "uri": "git://git.openembedded.org/bitbake;protocol=https"
+                           "uri": "https://git.openembedded.org/bitbake"
                        }
                    },
                    "rev": "master-next"
diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index b5c13fdb5..144ea6d9f 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -58,7 +58,7 @@
                                             ],
                                             "properties": {
                                                 "uri": {
-                                                    "description": "The URI for the remote",
+                                                    "description": "The URI for the remote, using git URL syntax",
                                                     "type": "string"
                                                 }
                                             }
-- 
2.39.5


