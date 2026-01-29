Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC04D6100E
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 11:52:07 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13022.1769687519317011516
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jan 2026 03:51:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kiF4fG10;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so7094585e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769687517; x=1770292317; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xi9dUots5QVbojUT2Fv8aDnMs9lKJE/Ef6pJjh1IMk=;
        b=kiF4fG10kICITqOv73DIQ06/cQzGRctIKLAH1olC/SeEeTny0XYFeHA0KYLlzur7t4
         XaV5Ny1yIv5HMo+QPQg3cBoQOjG062OgRbJTI6LljsvxIi5J5w8J5lQGuzI4Az5VOqvZ
         bojNwcYf/2iWqlRY8wwcmYNE93cYsiYEcVkwyEEPcRusuSkHaErLTLX2ppGDzbhaweoU
         ij2wP1RYabbRX7hsxR/FIC/xK93tuLxIiIOkloXxgOyRsD5PniZE0nYtygvUhtHWCIIR
         uxEM2lVZadUSTOo1loIHV+W4PBp6QFEbtsVNwnl/YPoLJXK876PPaCXtnLXawIb3Sr4Y
         l8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769687517; x=1770292317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xi9dUots5QVbojUT2Fv8aDnMs9lKJE/Ef6pJjh1IMk=;
        b=fwsQXET1v3Omzz3+zEVzqdX8oE9MWyWGaFGSB4xV2vvnyuxXmWnixzYykvuGdxEtkk
         jCTaDIpcWSjA/1KshIkH1sUCRqY52T/hpMyvdEI03nxcjejs8ee4YeDYTL/AjPtMKUiH
         C1xX35DNc0zq/Uxe9xkXDxFMiZr+5dFUmVDY4PpXUgZTqi/FPkB6nczeM4Ancc9pufgw
         LQi7vgg5yfR+49YHf1DgaijD8gLQkbwP8gsR+1gBDJMZ6EHzYvMj8ROTNoBCyu3nBwPV
         JmCzVD+VRedRXRrPyXby9po/p3h+kLMleB4JOd1dYFbytK34AY3jbAn+qKHdahRZuIOl
         danA==
X-Gm-Message-State: AOJu0YwoKdn6Zm07WXmgid+DTQClLMQUm6Rb+U0fiRtxrDlYpMq4PFIO
	U2uv1zfBvZoS5PBBZT0/D/jzS5QXecxpYSW74EQB9iOMy0VQ0gve6CmI4s3IQw==
X-Gm-Gg: AZuq6aK3cmwSWp4x8UaLDR2LHi1YGdXGLHm6Hr2bUKOVONs6Gfr8BPPV34rW8f6hx8l
	1sETFH4xVuI1IL4KYSPFIU+1kvfPMq+SE1CFB+ipkEwkNwtqFb/Jj+QCf/q81008ky4O7FUBSAK
	HSm9opTYK+wP4J8k3Cr4rDvnXhQTM424MdhlFyogGWa2dKht6bbbId2SWExjSjdrv6ABoLKtU56
	Q5RDk5wqjkbxk3Ljm/oRk/DH0LjYW5la+Kuwwrb7eLC3vLeyOGEJt0LKOEKqRN0NUUeEkvyhUt/
	m8bLfeGdgGbnkW+Sdf/sSQBRdbN3SFa9V1owYSOdyLU5gHuklAGpL4cJkfbguTQ6xfFGohqw/o9
	SlNysWxi8rl0TgvlFroPSncm16keCngBPWRS4n4hm9GMJV46K8U7oRKRsEPOwuEcFKhLzuF8pEw
	7Z2PJe/R/2AlhimjechvDjLomkznAnkzQ1yhBZ+qk/fkWVRwWjsgXPnE/+XQ==
X-Received: by 2002:a05:600c:458a:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-48069c16459mr99753745e9.5.1769687517158;
        Thu, 29 Jan 2026 03:51:57 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5dddb2asm2177085e9.8.2026.01.29.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 03:51:56 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 2/2] bitbake-setup: share sstate by default between builds
Date: Thu, 29 Jan 2026 12:51:43 +0100
Message-ID: <20260129115143.4185990-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129115143.4185990-1-alex.kanavin@gmail.com>
References: <20260129115143.4185990-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 11:52:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18932

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
v2: use ?= (weak assignments) for sstate variables to make it easier
to override them in particular builds, set hashserve db location
from value of SSTATE_DIR, rather than as direct value.
---
 bin/bitbake-setup                             | 28 ++++++++++++++++++-
 .../bitbake-user-manual-environment-setup.rst | 19 +++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 7f6ea550c..679654336 100755
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
+                SSTATE_DIR ?= "{sstate_dir}"
+                #
+                # Hash Equivalence database location
+                #
+                # Hash equivalence improves reuse of sstate by detecting when a given sstate
+                # artifact can be reused as equivalent, even if the current task hash doesn't
+                # match the one that generated the artifact. This variable controls where the
+                # Hash Equivalence database ("hashserv.db") is stored and can be shared between
+                # concurrent builds.
+                BB_HASHSERVE_DB_DIR ?= "${SSTATE_DIR}"
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
index 3b6a73fd8..b7212f1af 100644
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


