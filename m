Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D835BD3EE7F
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 15:02:29 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39171.1769094143801258491
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 07:02:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1d7hEdHW;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E07FFC21AA6
	for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 15:02:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1505D606B6;
	Thu, 22 Jan 2026 15:02:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 289E8119B82C8;
	Thu, 22 Jan 2026 16:02:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094141; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2ZGEPt+4v/RyZV4sMzJbPe5hi+in9DOkXCMf+lyuY7Y=;
	b=1d7hEdHWq8evc6+p4TBRp0Ox1+6pSPJfqiOY7bknhtWuTCAp7LDHsTX5Xu74ONOSb/5MDf
	ZOkJNYXuWmHenHEUOrOLc/k7JXi3s5qZjIPwQRUgqbEnMWWScK93v5lqki1ffM8ibZ46XB
	htxqEtnssdqqpFylh2SmheALm9FZDKkZbPcDsEZLp0Q0MkvxWQ5iWg9ug9rAJiooE+agAo
	ydgtdofcLjcwdeKirkkYHal8cr+0VChHRISqWTAPThrKb7WP7pyFnIin3eDR24JzixZWht
	z66kRURU2XhqL1WXqmHzymcdJkmUtUwyKTfx2OatMLemgm4j5/qpviQeHbeAxg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 22 Jan 2026 16:01:58 +0100
Subject: [PATCH v3 1/3] bin/bitbake-setup: add descriptions for fragment
 choices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-bitbake-setup-choose-builtin-v3-1-c55291acc1a7@bootlin.com>
References: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
In-Reply-To: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8159;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=afytrESbCE7KTnmirGBuEgjb8HMwyH4hCj3g5uHb2Jo=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcjv6eEMWViqzbc+rzHzRkuFZLxXxDTfae8d0b
 4mUdcQCAiOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXI7+gAKCRDRgEFAKaOo
 Nj0cEACtD49NhzETKalLQD0Fy7d7sPhsjH4vDeyCDogjnGG91oJNE7lN+2mF+UezI3/qt/T0Wui
 G8D/h1gNYFEz/lrKmPKe0MS/+srLVqpKYlcuawLgkSZ1hG8+f81S0f9KbcCjybm/rAEo6y72izy
 FmCxlpofoDNVknp1vM6P99EEh2LBSH0ALwS2R1fs/EQBrpQzJTUrUorhEXZUtgNGgD9fG5ZM4jc
 C0FayzdZIvCNjYp6Gf1VyIuyZXKsykEJRDbmz5sgldo40MtpEalc0i1Y6DWifMO3zphE9ebWWv3
 nmC630oIbBUK6HxxPe45BggtbItwzuHuCzZ2oOxUCR2cM9FcvP9sFwPquFpxVNcn396CrDD8ZY0
 q2aJ2w21MP1Wx+n1tKJwnzEMwStsbgpfKPK6u1chfNiOnyjJ3APTyk38zafSZAC/P7Yhd8H/MtW
 go61a442LfR2D4qkKDYpGU9rEwIw3IcEoq2nI4SYDDTf8le96+3oJ8x8IWDhXEFcJMASe5fgvgd
 /yB5iHAHWhmbtPEj8hbX2ESryleWOKV3fb4hxK3yn7LZ8g9mBNYqDThyRi1t5cw4zw7GCAoyJRJ
 Fd6uob88KKtNMP/8oXp4BXvZMUXO04aAihUuXtB2ycP2Ft1YjpcQ4oZgr6Pr9E3oWPQTmig03wK
 pON7BZIpuO6dhvQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 15:02:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18848

Make it possible to give fragments descriptions as it can help users
determine which fragments to pick during bitbake-setup init.

It is still possible to provide a list (with no descriptions) for
backwards-compatibility.

Update the documentation accordingly.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup                                  | 23 ++++++++++++++-----
 .../bitbake-user-manual-environment-setup.rst      | 26 ++++++++++++++++++++--
 setup-schema/bitbake-setup.schema.json             | 21 ++++++++++++++++-
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c832..b0d14e7c1b8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -494,23 +494,34 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         if skip_selection and k in skip_selection:
             logger.info("Skipping a selection of {}, as requested on command line. The resulting bitbake configuration may require further manual adjustments.".format(k))
             continue
-        choice = [o for o in v["options"] if o in parameters]
+
+        # options can be a list of strings or a list of dicts
+        options = v["options"]
+        if len(options) > 0 and isinstance(v["options"][0], str):
+            options = [{"name": o, "description": ""} for o in v["options"]]
+
+        choice = [o["name"] for o in options if o["name"] in parameters]
         if len(choice) > 1:
-            raise Exception("Options specified on command line do not allow a single selection from possibilities {}, please remove one or more from {}".format(v["options"], parameters))
+            raise Exception("Options specified on command line do not allow a single selection "
+                            f"from possibilities {[o['name'] for o in options]}, please "
+                            f"remove one or more from {parameters}")
         if len(choice) == 1:
             choices[k] = choice[0]
             continue
 
         if non_interactive:
-            raise Exception("Unable to choose from options in non-interactive mode: {}".format(v["options"]))
+            raise Exception(f"Unable to choose from options in non-interactive mode: {[o['name'] for o in options]}")
 
         logger.plain("\n" + v["description"] + ":")
-        options_enumerated = list(enumerate(v["options"], 1))
+        options_enumerated = list(enumerate(options, 1))
         for n,o in options_enumerated:
-            logger.plain("{}. {}".format(n, o))
+            opt_str = f"{n}. {o['name']}"
+            if o["description"]:
+                opt_str += f"\t{o['description']}"
+            logger.plain(opt_str)
         option_n = int_input([i[0] for i in options_enumerated],
                              "\nPlease select one of the above options by its number: ") - 1
-        choices[k] = options_enumerated[option_n][1]
+        choices[k] = options_enumerated[option_n][1]["name"]
     return choices
 
 def obtain_config(top_dir, settings, args, source_overrides, d):
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 3b6a73fd8d3..92fedd7d969 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -759,11 +759,21 @@ They contain the following sections:
                 "oe-fragments-one-of": {
                     "machine": {
                         "description": "Target machines",
-                        "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                        "options" : [
+                            { "name": "machine/qemux86-64", "description": "Machine configuration for running an x86-64 system on QEMU" },
+                            { "name": "machine/qemuarm64", "description": "Machine configuration for running an ARMv8 system on QEMU" },
+                            { "name": "machine/qemuriscv64", "description": "Machine configuration for running an RISC-V system on QEMU" },
+                            { "name": "machine/genericarm64", "description": "Machine configuration for Arm64 SystemReady IR/ES platforms" },
+                            { "name": "machine/genericx86-64", "description": "Machine configuration for generic x86_64 (64-bit) PCs and servers" }
+                        ]
                     },
                     "distro": {
                         "description": "Distribution configuration variants",
-                        "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                        "options" : [
+                            { "name": "distro/poky", "description": "Distro configuration for Poky (Yocto Project Reference Distro)" },
+                            { "name": "distro/poky-altcfg", "description": "Distro configuration for Poky (systemd init manager)" },
+                            { "name": "distro/poky-tiny", "description": "Distro configuration for Poky (optimized for size)" }
+                        ]
                     }
                 },
                 "configurations": [
@@ -852,6 +862,18 @@ They contain the following sections:
    -  ``oe-fragments-one-of`` (*optional*, OpenEmbedded specific): the OpenEmbedded
       fragments to select as part of the build.
 
+      This can one of two formats:
+
+      -  A list of dictionaries with ``name`` and a ``description``,
+         corresponding to respectively the fragments names and fragment
+         descriptions (like in the example above).
+
+      -  A list of fragment names. For example:
+
+         .. code-block:: json
+
+            "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+
       This will trigger choices to make during the
       :ref:`ref-bbsetup-command-init` command execution.
 
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index e51fef3b97c..be8772db1b2 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -64,7 +64,26 @@
                                 "type": "array",
                                 "description": "List of BitBake configuration fragments to enable",
                                 "items": {
-                                    "type": "string"
+                                    "oneOf": [
+                                        {
+                                            "type": "string",
+                                            "description": "Configuration fragment name"
+                                        },
+                                        {
+                                            "type": "object",
+                                            "description": "Dictionary of BitBake configuration fragments to enable (with description)",
+                                            "properties": {
+                                                "name": {
+                                                    "type": "string",
+                                                    "description": "Configuration fragment name"
+                                                },
+                                                "description": {
+                                                    "type": "string",
+                                                    "description": "Human-readable description of the fragment"
+                                                }
+                                            }
+                                        }
+                                    ]
                                 }
                             },
                             "oe-fragments-one-of": {

-- 
2.52.0


