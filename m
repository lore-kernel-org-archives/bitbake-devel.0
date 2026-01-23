Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF42D74ED3
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 13:24:28 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.67345.1769174659890702789
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 05:24:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=g4yqma+T;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A6CC2C21ABF
	for <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 13:24:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60FE06070A;
	Fri, 23 Jan 2026 13:24:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80615119A87C6;
	Fri, 23 Jan 2026 14:24:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769174656; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R653SCSX5DaiB7xR51sNuzKHbXZIQEjblooBMBY0vPY=;
	b=g4yqma+Tavn0PrdYYtt/reSPMigm4wOgkIQWDosqAihbIr4FocNRXFuQw4z4+z6/hgNwmt
	+AyjIit43p9x5JEfgOkxfiocRP3S7Inf9QJyLUr5Sm90p2eChFbbcpEdlyZIalLSOg9pk2
	tel1I412bpIpaTJfh2f7NdCnlf9YmFwoagQCRaox3o6YdBYbnLjoyoq7awVY/lJiQ3YkWf
	jXZhmmTscUWJg8+/+3cbCeyQzMmyXQdcdaI0z5bNwyARTBsgJWftLJ7EAnAmAQnXxbwUDB
	G1NbyoHruD5ujSu1cUFljiQQVS3l58kn2XETwvP9Da/ey5GmIqKnb9vZ4U92xw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 14:24:06 +0100
Subject: [PATCH v4 1/3] bin/bitbake-setup: add descriptions for fragment
 choices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-bitbake-setup-choose-builtin-v4-1-99361f2128f6@bootlin.com>
References: <20260123-bitbake-setup-choose-builtin-v4-0-99361f2128f6@bootlin.com>
In-Reply-To: <20260123-bitbake-setup-choose-builtin-v4-0-99361f2128f6@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8159;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=gMq1Fa2C70lDztiZG3xKaAAdfvjJCMp4XBU6o4UOp88=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpc3Z9sdVjhV7pNos9gvaWDxQX8JvVS7SeAXu8B
 pDlSaAjoRCJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXN2fQAKCRDRgEFAKaOo
 NoBkD/9Spco23W53qyCyhdD0tg16/MRgAPVVQ59Ljd76QjtZ/Rgpw2oeKjJGGBo2QJOftrGGdQF
 nsLmxwDr5tsqoAMahIh2HZbpcu8z4E+DUTvoVnt6dyV0HPDxt0pdo3qtxvJu/6P1tb2Ld9f2Mp4
 Gsuh7zpoUVfsZtrFJ0HSAQOmz05Sw/oSXVq1em2HlJ9wJaY4ZgR7dxZGvhEorUdh3qFZd1C6t+e
 ea5GU6z1F/ne30DsUQkUB12jCbTjd2EfB+VR2hk82853Qou99jbc9CVdn1feyy9ETHOVHQtiQb5
 37q98mmZBzGIrerpsO06m1q1T7mQgcYyGnL8tb9HKXH1XKdU2/5WkMGgGeH9dx/i7FSW/VbnPC+
 june5i+fQudPI4TgSXC6AbgpqYzHk3Mc9ooSVsiw386SIxXRDPtjkBq7rFNddELnwM7oYX1m0fb
 HPpWHzerlr+ETAgN9YJLCuEbvdjFXs7tbSK2mXoHe59erNfwg9gWqkhbjKNufwP0fv40J91VkI/
 dLT3ZQmY99CqCbn/8HDWvNL86vNwvVQeIz9fvZHTpiun6LvXglc1bDOe4tGj+0tGfP8FKNeQuX9
 zfM8mXg2IztTya7iH0YHyW9xNHQ2B02hzGTJ3XK3qZv14QDeS1/+xgHnxOxSmiLjAuUqm0HaF44
 uWpEK5QWqssV8MA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 13:24:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18860

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
index 0cd26814a6e..315f195a4d7 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -515,23 +515,34 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
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
 
 def obtain_config(top_dir, registry, args, source_overrides, d):
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index b7212f1af41..93477d71473 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -778,11 +778,21 @@ They contain the following sections:
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
@@ -871,6 +881,18 @@ They contain the following sections:
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


