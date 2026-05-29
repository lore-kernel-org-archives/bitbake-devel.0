Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA91CCD6E51
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 15:00:19 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12275.1780066816160687372
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 08:00:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TDJgT7gX;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so646042f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066814; x=1780671614; darn=lists.openembedded.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUZNmOMp9B4F/AcV28+MAzp7N5VSttONZsQAae+ijzA=;
        b=TDJgT7gXSkIFIHYDRa6ORmj2s227gStCZcngzQJRpfT98ufh4kHdXGFzWr7W8wez7Q
         6agG9DWGEkvM+rhncEWEpuuOTL9nq2vyLzteA6uHfdGrI/ScejO7AlRAB63KSaBtcbWh
         E0AtKadSstfwAHt9ArSLelVC5dbLrsMssUphyebYvXKgFEO/iSV9mG1FLEeaRnHWxvty
         9raW/M+P/m7ZdFHCK7fcnnWrFwe4IM+3XX6VLjGKb2keU1XHPRHQPb3EZekBtfxCq/Qz
         Podr7pH26FTJ5Gi9zAm8+2GbmV0dIzWhZWbBcWz+r9Bfysd1dsV+U7nSMbdeBXljaqD0
         D/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066814; x=1780671614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUZNmOMp9B4F/AcV28+MAzp7N5VSttONZsQAae+ijzA=;
        b=PtY07UOong1Q6HhJMhNqS6eMZyPnUQoTlYZVPBH/u8jD2pT3uYBLDsTKW7VZ+wSBQV
         P/ItBdzI7c7X0f0RUOjNSn9BYrfwJUBpcsZ8pHVH8yvQ8MvfJuqR8mH6BHcBET40FIdb
         kenq0UfQRwp8sJF+j9PC07neOeTQKRw7W9ycqh0ytVOM+kuUuVmpskqhFO2XBthWIkQF
         /DXlP4BWfe5+7aONm532zQP05eSeqk4u1i0wfZv9qpKQLToDd1oG2CWzWBBTM0oLWrJu
         soR+hhLqzIbuD7jyVWlnhPFceUCHNjFJt8sIujz8S8Ege+4VVrrly8PEsVGFatfruiDF
         ZZLg==
X-Gm-Message-State: AOJu0YwaVw8YdMCO5wLrMqY1bvZ+1lpig34Bo25jl5V1zjVXgxLVg1+0
	90ytaP9WTNrhDj3PLQ7gGStimYHsDfu4X9IRsYSQxFe4G5yoA78Z4wWAVrwmOKmZ
X-Gm-Gg: Acq92OEmZop5JtyQ5HjgdZcorFi90LRMNKGwUymn1aTW+AiIu6eGz1BwUluG+mdeE4r
	oHS4ZacsjX5dvLndS6uzbYq1WajWlGf/ASzX4cqYGCE7Dv0nZCV1rncVPyojCaub2UYgIoyGU7d
	i594FUykm4qvTdGqQCxRsv0n6i2toWIq+RrR+muSxmn29E5kUaMbsv5nQnvvbModlInZ3ogZXGG
	Jj6okNjHah54j6rbOSOagMX38ZS1MZ9YtCaUp+5jtZSilKkwVLPJ5FTzs3WJZ5E6bX0KtfH9qGJ
	b18uJargvRRCss/U2PxKPfzdJOd5ofmH3co+aPc905wCXosjvISeV6J3qZvNq99LPH7zG4OW3pz
	afz2riwxQhG1Tz1azNPRZnaHjTBmm6zRGxOLUwiJ7tnO+Q4Ah+IrRqQPTmDWBmeDJhLoPDrQ5Pu
	0SApRjYxr5VPSJYMwzaWcS61faVB7fViTVm+19QYp3fAIa8Mowa/1T8P6w/OYITA5iFiCVtJZCs
	/c1/KgdhmaG599aPcPmCni6LBqcLTfVoosVRg==
X-Received: by 2002:a05:6000:1285:b0:452:65d:e108 with SMTP id ffacd0b85a97d-45ef6af6ce7mr341211f8f.3.1780066814257;
        Fri, 29 May 2026 08:00:14 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm4285826f8f.34.2026.05.29.08.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:00:13 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Fri, 29 May 2026 17:00:01 +0200
Subject: [PATCH 2/2] bitbake-setup: write notes for generated build configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-bb-setup-notes-v1-2-a251ef1c5af4@toradex.com>
References: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
In-Reply-To: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 15:00:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19565

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

For bb-layers configurations, bitbake-setup currently writes an empty
"conf-notes.txt". Configurations using "oe-template" get this file from
the template.

Add an optional field called "notes" to configurations that populates
this field when "bb-layers" is used instead of "oe-template".

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 bin/bitbake-setup                                                 | 3 ++-
 doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 5 +++++
 lib/bb/tests/setup.py                                             | 4 ++++
 setup-schema/bitbake-setup.schema.json                            | 4 ++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 220540f7f9ca..e22e5b77bde1 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -301,7 +301,8 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
             f.write(bitbake_config["description"] + "\n")
 
         with open(os.path.join(build_conf_dir, "conf-notes.txt"), 'w') as f:
-            f.write("")
+            notes = bitbake_config.get("notes")
+            f.write(notes + "\n" if notes else "")
 
     def _make_init_build_env(builddir, oeinitbuildenvdir):
         builddir = os.path.realpath(builddir)
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 1252f22c823a..e99cf7b3415d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -1057,6 +1057,11 @@ They contain the following sections:
       snippet. This is what is prompted during the
       :ref:`ref-bbsetup-command-init` command execution.
 
+   -  ``notes`` (*optional*): additional information written to
+      ``build/conf/conf-notes.txt`` when ``bitbake-setup`` generates the build
+      configuration from ``bb-layers``. For ``oe-template`` configurations,
+      this file is provided by the template.
+
    -  ``configurations``: Configurations can recursively contain as many nested
       configurations as needed. This will create more choices when running the
       :ref:`ref-bbsetup-command-init` command.
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 638d56d3bb32..ffe390db1bda 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -136,6 +136,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             {
                 "name": "gadget-notemplate",
                 "description": "Gadget notemplate configuration",
+                "notes": "Gadget notemplate notes",
                 "bb-layers": ["layerA","layerB/meta-layer"],
                 "oe-fragments": ["test-fragment-1"]
             },
@@ -249,6 +250,9 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         else:
             with open(os.path.join(bb_conf_path, 'conf-summary.txt')) as f:
                 self.assertIn(bitbake_config["description"], f.read())
+            with open(os.path.join(bb_conf_path, 'conf-notes.txt')) as f:
+                expected_notes = bitbake_config.get("notes")
+                self.assertEqual(f.read(), expected_notes + "\n" if expected_notes else "")
             with open(os.path.join(bb_conf_path, 'bblayers.conf')) as f:
                 bblayers = f.read()
                 for l in bitbake_config["bb-layers"]:
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index be8772db1b2d..6a39e66a0ae4 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -41,6 +41,10 @@
                                 "type": "string",
                                 "description": "Human-readable description of the configuration"
                             },
+                            "notes": {
+                                "type": "string",
+                                "description": "Extra notes that populate conf-notes.txt when bb-layers is used"
+                            },
                             "bb-layers": {
                                 "type": "array",
                                 "description": "List of BitBake layer paths to include, relative to the layers download directory",

-- 
2.43.0


