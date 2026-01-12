Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50804C9EC8B
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 13:04:33 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32411.1768223071115171323
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 05:04:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Uk0oDyfU;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43246af170aso2940440f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768223069; x=1768827869; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrtdQZBUcNQMnut5TS4ZJez8+aXRPUJSGWUYjMKxJz0=;
        b=Uk0oDyfUNtNfmDSQ8chYPZZn++m4wpqWRVodecSH8MCc6RJZkB6K9o0aKgiGD7DLPe
         4S/MDdT+NXsR20yH0kEDM9mxoae6Rj7wc4ns/KMcUIzwh6K0ukZvYXhgjOEgcYFKXUMF
         aPukZJGz+g5Fa7P8e+CIF8sRyW3lREgHv43aZPMoJhzJoUYqyxnZR1ChB5PbgmP8/8sO
         uXEyGAKZM8eCqr3Xl9KiWAaAlXSBMHjV+Z0X8eOwI4cRHVPeAqAhe0JsGa1HqLCTya7T
         PjBk/5Nmc/KyK4iTPoenslRgLF9nHJGIgVxTkQFo1Kh3MUi4s2mL4be4qxUtPmoS3Pkr
         bhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768223069; x=1768827869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DrtdQZBUcNQMnut5TS4ZJez8+aXRPUJSGWUYjMKxJz0=;
        b=Wk9VdyZGJZ028LNf2g6/T4WnkIRsSHeXyYElZzuQUZM8oE+5LxbvnhdyUZlSjxV16u
         6N6mCv1XWEVEgpuf/AbIx/AHTuLNyz2R2wg3nbKcjlam3EB59ZhG0pVfMw91gORVmnkb
         SzUH3U697n2hGXOhhjdxtjGZL9BgifDT37DNZjP1JvNjUJ33VwoJ5l2TnRWb6VpuGzkj
         tVSIuXmMSWpFvUnLofmJh5h8BzX+ZNdbnAiUwlcsesXx4MZuTYVKAp0S70XGlmTRNg/T
         v6fp0epf5ZPrmjyMbqLodBABlmrb5b8eVYJhbc5C7RE2oe5Nd/LXreOSsxP7VOxYGmmH
         4g9A==
X-Gm-Message-State: AOJu0YxaYuDn5Fx3EbR0eLvMYa7A+OdnUvuh8xDdBmMFT4kFu8nkaIXf
	FwNzeQ5RxmCJdzgZ/Pst/q2tpLiV5zMUywaGh4t5as+G9qbtxbakzA92q3hdwpDt
X-Gm-Gg: AY/fxX7XQ0y1H9HD6oxVBNA5jrVN/H0qu2LK+lCQLaetdLfs3rglfTR88B3j92k7l+k
	mEkX65sVB4QInNZ2CV4Ppne+brz2bsE9DhgQyTzpJ7v6k28EmRiM3wMZz/HE7u90Y8joalZIAH1
	AiSwDsRrOM6zWghJS1sGOHTXvzN/ImACqy1X+BMdYbYQ85hh9zHLGLjGu9CGiFQfBbJr/38O7ZU
	SwrSZQUuKRrIxsLpV9GAWhpHIRaFU6jBEB0RloO/+Tt6Ykm+BHSmOCINFV0l9Of/HLgwwrJrXX4
	XJzgxVQ/y92pcCB3amuAPgIAgtXHGaWowcDYZ3linR4BQ434TIthazi+V9G76nm05Y8YQJsScvo
	EM6QSKmJvbnI2pEiL7tIasLafVrUq8z1vLeJ2kLb/747lmJMwdSbe7o+SMa2o7NHoUnu9g7NqjP
	6Xyzr12KZL8TQ4TpvA+uF0eOcpiKQKzyiYeOXLVGJcE92X6is=
X-Google-Smtp-Source: AGHT+IHa2KW/Rk482I9OTJWSMl9ppfscXY2Sv3LlzSFjtp+3dCCIoJLOXEs+ZvTyqL5D24PnxlCK0g==
X-Received: by 2002:a5d:5d11:0:b0:429:d3c9:b8af with SMTP id ffacd0b85a97d-432c3764450mr21368968f8f.25.1768223069362;
        Mon, 12 Jan 2026 05:04:29 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0daa84sm38531371f8f.2.2026.01.12.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:04:29 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/2] bitbake-setup: share sstate by default between builds
Date: Mon, 12 Jan 2026 14:04:18 +0100
Message-ID: <20260112130418.3166002-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112130418.3166002-1-alex.kanavin@gmail.com>
References: <20260112130418.3166002-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 13:04:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18733

From: Alexander Kanavin <alex@linutronix.de>

Nowadays sharing sstate must also include sharing the hash equivalency
information and thus, managing a hash equivalency server. There are
two ways to do it:

- starting/stopping the server outside the bitbake invocations, and
guaranteeing that it's available when bitbake is invoked.

- using bitbake's built-in start/stop code which launches a server
before a build starts and stops it when a build is finished; essentially
this is a private server, using a database private to a build directory
(by default).

I couldn't come up with a good way to do the first option in bitbake-setup:
it needs to be invisible to users, they should not have to run special commands
and they should not wonder why there is a mysterious background process.
It's not impossible to auto-start a shared server, but that will quickly
run into synchronization issues: if one server is being started, another
should not be started at the same time. If one server is shutting down
(e.g. after an inactivity timeout), another starting server should wait
until it frees the socket, and block all bitbake invocations on that.
Memory resident bitbake does this in lib/bb/server/process.py with a lot of
complexity, and I don't think it should be added to the hash server as well.

On the other hand, hash equivalency database is sqlite-driven, and sqlite
documentation reassures that sharing it between different simultaneous
processes is okay: nothing will get lost or corrupted: https://sqlite.org/faq.html#q5

I've confirmed this by running simultaneous builds that way: nothing
unusual happened, and sstate was shared as it's supposed to.

There's a new setting that turns off this behavior for situations
where the server and sstate are managed externally.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup                             | 28 ++++++++++++++++++-
 .../bitbake-user-manual-environment-setup.rst | 19 +++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 7f6ea550c..2c2b6d8ec 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -838,6 +838,31 @@ def create_siteconf(top_dir, non_interactive, settings):
 
         os.makedirs(top_dir, exist_ok=True)
         with open(siteconfpath, 'w') as siteconffile:
+            sstate_settings = textwrap.dedent(
+                """
+                #
+                # Where to place shared-state files
+                #
+                # BitBake has the capability to accelerate builds based on previously built output.
+                # This is done using "shared state" files which can be thought of as cache objects
+                # and this option determines where those files are placed.
+                #
+                # You can wipe out TMPDIR leaving this directory intact and the build would regenerate
+                # from these files if no changes were made to the configuration. If changes were made
+                # to the configuration, only shared state files where the state was still valid would
+                # be used (done using checksums).
+                SSTATE_DIR = "{sstate_dir}"
+                #
+                # Hash Equivalence database location
+                #
+                # Hash equivalence improves reuse of sstate by detecting when a given sstate
+                # artifact can be reused as equivalent, even if the current task hash doesn't
+                # match the one that generated the artifact. This variable controls where the
+                # Hash Equivalence database ("hashserv.db") is stored and can be shared between
+                # concurrent builds.
+                BB_HASHSERVE_DB_DIR = "{sstate_dir}"
+                """.format(sstate_dir=os.path.join(top_dir, ".sstate-cache"))
+            )
             siteconffile.write(
                 textwrap.dedent(
                     """\
@@ -855,7 +880,7 @@ def create_siteconf(top_dir, non_interactive, settings):
                     """.format(
                         dl_dir=settings["default"]["dl-dir"],
                     )
-                )
+                ) + (sstate_settings if settings["default"]["common-sstate"] == 'yes' else "")
             )
 
 
@@ -1061,6 +1086,7 @@ def main():
                          'top-dir-name':'bitbake-builds',
                          'registry':default_registry,
                          'use-full-setup-dir-name':'no',
+                         'common-sstate':'yes',
                          }
 
         global_settings = load_settings(global_settings_path(args))
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index fcffab812..a6657252f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -517,6 +517,7 @@ A valid settings file would for example be:
    registry = /path/to/bitbake/default-registry
    dl-dir = /path/to/bitbake-setup-downloads
    use-full-setup-dir-name = yes
+   common-sstate = yes
 
 Settings and their values can be listed and modified with the ``bitbake-setup
 settings`` command. See the :ref:`ref-bbsetup-command-settings` section for
@@ -621,6 +622,24 @@ will override the suggestions for the :term:`Setup` directory name made by
 will make the directory names longer, but fully specific: they will contain
 all selections made during initialization.
 
+.. _ref-bbsetup-setting-common-sstate:
+
+``common-sstate``
+-----------------
+
+When this setting is set to ``yes`` (which is also the default), bitbake-setup will
+set up a common sstate directory and common hash equivalency database for all the
+:term:`setups <Setup>` in a :term:`Top Directory`. This is very beneficial for speeding
+up builds as build artefacts will be reused whenever possible between them.
+
+Set this to ``no`` for advanced use cases, such as placing the sstate directory on a NFS
+mount and maintaining a separate hash equivalency server, so that sstate and hash equivalency
+data can be shared between several computers. For such use cases the sstate settings need
+to be added to a build configuration separately.
+
+See https://docs.yoctoproject.org/dev-manual/hashequivserver.html for how to share sstate
+on the network.
+
 .. _ref-bbsetup-section-config-reference:
 
 Generic Configuration Files Reference
-- 
2.47.3


