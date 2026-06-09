Return-Path: <ernestvanhoecke@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2880CD8C92
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 11:59:24 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.77819.1781006361615253785
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jun 2026 04:59:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TJ906SGZ;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: ernestvanhoecke@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so36561305e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jun 2026 04:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781006360; x=1781611160; darn=lists.openembedded.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXACDy1usanGLzgexJZ7Qc4+QIVsn9WfNhi9Wd2EdAY=;
        b=TJ906SGZUmkz3kbNEQtWhnKN3pnEpYr0cRcduyFZSj8irCNqkRkKYUrpEj44VM+yKp
         oOz0QduAnYcQYr1gqozWQnAgI734VLfUYipssAhVU3EI+F3OOSpMvx6sOWX8A6XdPmgs
         E0SNedIPIaT2y7ChzQlkK2piuXXmJHksC/qp8kDgOmD3LchBHbKI+j/MkGuxGqRo4n/K
         0WdtpUqV4vLhKG4pnLyb1kazYu9gylzVUfl4IvKNiS4HPFKKGamO1jUgxz0k09E1L5Jx
         JJWJ+DJuffN+HuaDiN/bVIiM+mec5QYFU9heBek2TZgspWv1yGvErqlzN9jjxe6B2yvL
         Na0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006360; x=1781611160;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXACDy1usanGLzgexJZ7Qc4+QIVsn9WfNhi9Wd2EdAY=;
        b=E2txviD3c+Rrc3xO/n4FejNhyS7Aa4h9/NMHq/KydoGn4WrG5SHsjBB9ww5wQabiu8
         LTeanEMu9r68AHDjBrcRVDjXX/+mx3U5W9SDfwABN6eP/pQxGeDK6C+Zveub+HleeAc5
         CE2bXZ+5rCgnpGen5la7jys0WX0Bw6Q+Eb7A6/Dm1annjxz8Wcsfmmxt4n/lv+AdpNXF
         OvPG47xBFzvOmv0KA4t2w6yxyt9Z2YkLvbtyD9nYg+onHIOwMV+1DOFrr/9YWeNvc7UN
         HhmZDVFOGpZeiHD6ibD+/7c9+22S9pZUhlKBE69OskU+sHmLq0x8W1aPXObDrYWz9u1J
         toxA==
X-Gm-Message-State: AOJu0YzO7PomCX8qIVjTUZIlqXboUP8Hg6JeYAZu2NEMjNSk01CS7O0M
	pJAJI5Kix4mPnTwwpWG9jcEEm73gc/lk7+g+scqFJa/tzPupW+IcFe5eQ4nOKfxd
X-Gm-Gg: Acq92OEqZnnjaJRmyRvksamjXcAqbsVW8jDIJKriI4nEjKsYHYN8S7g/Z0Fxn5KgcmR
	f3pCR5Gpbz5yCW54bR7HPEPU3aAyJDYxnLwFvlheT2elYGn/R9b22xdI7YWys9Mcf4NGpp0v/VB
	jty4OvTvEw+zFQn//fMlvxxUeB3GfEWmCTL9FqiiG4FKCbLjuJ5/yJAZ4S3HH+UOLaDI38V1oiC
	yg47rKszTrla53iqnC9yryT6zmxRs5XWPiw9/lKvsPrjnsAE+Whj8b00Q8OAmgFzqGKBsju0knr
	bY6LUw8/N2zG5rJ9ETATFJhnZRG2yHOxjTsPKLam7VFlsXe02mzD2B6Z5NYrA87PqI6mxK+3Q1u
	VIVEK+5alSlOTZY+LOtb6ftKibfwOL+qedkcRWCYspAR233++u88eouEKn3s2pJf3Y0YD8iPOZT
	ZDMuytZ6q8vkAeNcwDTsnBs5k3saXcY5AjOdgB6nraBk3SunQUqlrRzwgQYklL2GAUSQYPXErkH
	2QSPmi859UJKsYGc8VJdjndFPhaB7zIbdfmh/dm1YeKLc/6
X-Received: by 2002:a05:600c:8b85:b0:490:9d5b:d721 with SMTP id 5b1f17b1804b1-490c25f166fmr330208505e9.16.1781006359592;
        Tue, 09 Jun 2026 04:59:19 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm567509995e9.9.2026.06.09.04.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:59:18 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Date: Tue, 09 Jun 2026 13:59:14 +0200
Subject: [PATCH v2] bitbake-setup: write notes for generated build configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-bb-setup-notes-v2-1-a697d76a7ecf@toradex.com>
X-B4-Tracking: v=1; b=H4sIABEAKGoC/3WMQQ7CIBAAv9Ls2TVAAbUn/2F6oHSxHCwNYFPT8
 Hexd48zycwOiaKnBF2zQ6TVJx/mCuLUgJ3M/CT0Y2UQTGimxA2HARPl94JzyJSQad22kg9MXq5
 QoyWS89sxfPSVJ59yiJ/jv/Kf/btaOTI0QnFy3Crj5L2WZqTtbMML+lLKF4C4QWCuAAAA
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, 
 Antonin Godard <antonin.godard@bootlin.com>, docs@lists.yoctoproject.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
X-Mailer: b4 0.13.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jun 2026 11:59:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19634

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

For bb-layers configurations, bitbake-setup currently writes an empty
"conf-notes.txt". Configurations using "oe-template" get this file from
the template.

Add an optional field called "notes" to configurations that populates
this field when "bb-layers" is used instead of "oe-template".

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
Add a "notes" string property that can be used to populate
"conf-notes.txt" when bb-layers is used instead of oe-template.
---
Changes in v2:
- The "notes" field can now either be an array of strings (lines) or
  just a string. 
- Link to v1: https://lore.kernel.org/r/20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com
---
 bin/bitbake-setup                                          |  5 ++++-
 .../bitbake-user-manual-environment-setup.rst              |  6 ++++++
 lib/bb/tests/setup.py                                      |  9 +++++++++
 setup-schema/bitbake-setup.schema.json                     | 14 ++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 69c9882f4c45..fe3b6b0e67d0 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -301,7 +301,10 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
             f.write(bitbake_config["description"] + "\n")
 
         with open(os.path.join(build_conf_dir, "conf-notes.txt"), 'w') as f:
-            f.write("")
+            notes = bitbake_config.get("notes")
+            if isinstance(notes, list):
+                notes = "\n".join(notes)
+            f.write(notes + "\n" if notes else "")
 
     def _make_init_build_env(builddir, oeinitbuildenvdir):
         builddir = os.path.realpath(builddir)
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 1252f22c823a..aa546c30b9c9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -1057,6 +1057,12 @@ They contain the following sections:
       snippet. This is what is prompted during the
       :ref:`ref-bbsetup-command-init` command execution.
 
+   -  ``notes`` (*optional*): additional information written to
+      ``build/conf/conf-notes.txt`` when ``bitbake-setup`` generates the build
+      configuration from ``bb-layers``. This can be a string, or a list of
+      strings which will be written one per line. For ``oe-template``
+      configurations, this file is provided by the template.
+
    -  ``configurations``: Configurations can recursively contain as many nested
       configurations as needed. This will create more choices when running the
       :ref:`ref-bbsetup-command-init` command.
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index b30168ed61de..5592e81965d2 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -136,6 +136,10 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             {
                 "name": "gadget-notemplate",
                 "description": "Gadget notemplate configuration",
+                "notes": [
+                    "Gadget notemplate notes",
+                    "Second line"
+                ],
                 "bb-layers": ["layerA","layerB/meta-layer"],
                 "oe-fragments": ["test-fragment-1"]
             },
@@ -249,6 +253,11 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         else:
             with open(os.path.join(bb_conf_path, 'conf-summary.txt')) as f:
                 self.assertIn(bitbake_config["description"], f.read())
+            with open(os.path.join(bb_conf_path, 'conf-notes.txt')) as f:
+                expected_notes = bitbake_config.get("notes")
+                if isinstance(expected_notes, list):
+                    expected_notes = "\n".join(expected_notes)
+                self.assertEqual(f.read(), expected_notes + "\n" if expected_notes else "")
             with open(os.path.join(bb_conf_path, 'bblayers.conf')) as f:
                 bblayers = f.read()
                 for l in bitbake_config["bb-layers"]:
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index be8772db1b2d..99f47f73d0a6 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -41,6 +41,20 @@
                                 "type": "string",
                                 "description": "Human-readable description of the configuration"
                             },
+                            "notes": {
+                                "oneOf": [
+                                    {
+                                        "type": "string"
+                                    },
+                                    {
+                                        "type": "array",
+                                        "items": {
+                                            "type": "string"
+                                        }
+                                    }
+                                ],
+                                "description": "Extra notes that populate conf-notes.txt when bb-layers is used"
+                            },
                             "bb-layers": {
                                 "type": "array",
                                 "description": "List of BitBake layer paths to include, relative to the layers download directory",

---
base-commit: 26978d55eab18278cc6a527072e8015cfbced9de
change-id: 20260529-bb-setup-notes-0663341b0478

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>


