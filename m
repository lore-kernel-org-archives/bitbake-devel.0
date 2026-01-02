Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE946FC6162
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:35:00 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11803.1767382492075954463
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:34:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GX3a5KWM;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79af62d36bso2065308966b.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382490; x=1767987290; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4i9sicM6Z7W0DQ/FMvbubjpLq+gTNnswRlKEWWAobpY=;
        b=GX3a5KWMFJ8H1/TjwtwRsibDogQuXe4N2kV7lAllEDphuKgTG8sBTg0w2BmXZQ9Aim
         IjNLcVUJhBvhXqs978MuV5E1l8W03cs7SQkJUUcxqE76NZ7QY9A/5VPP6l03JAJBVPaN
         /3x54fX3zI42IfQ6LWegw6vDqF6kpXOeGLVgOOMGVZ5U1joNEioA75vGs37PU8ePOu9q
         WOLJUQaPEtiaC5BAK/sf9pExU2+L05b/L/Z9Pi5b1UZaXn8TfnCCKTUdl9tFGZzKzNXx
         mtWnrbs+8PFSGvd5DjWXr8H/OVTyRV36Xx7WGmm9N4MBU4ee5j6LlpeTFurv5g/+DLuD
         dH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382490; x=1767987290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4i9sicM6Z7W0DQ/FMvbubjpLq+gTNnswRlKEWWAobpY=;
        b=LxdrvSlSALDPw5r9Do/20fP3iCO0Ko6HB8hRXaLkdmM/vD+ZNMAt2g9O7cnN0NzQ0d
         oOxLcjF8omdJBlaxOhBYNPRHlilGDbCf+J2s19bZ81+IyMdlRwrg7asv+J1FGNYueUJG
         /kAU3CZtfqwaeuXnpB0AHbAb/WXuRJrBchzQR0blGnpPaQGfIoZeWv1Zyq0/55iH5Ows
         cawwYhzvjO2kLCyhRwZ/4+4QeH2810D/WCCQxw66N/b8yO/ox0JWESSkv9TJcqT0TSNh
         agyZPPBJX2MWkoarKpfPlrCLCLX/akCsWm/IEjnUIUvVyqH9PgpCodMmapsqNs63sy1U
         mJCA==
X-Gm-Message-State: AOJu0YwPWsD+WfZvdkfb4sUgTaUBQ7Uor3pGdwA3OKExbGFGstEDlxo3
	PmRRnemvjMntIMXEBzunol3StgZP4CJXaeCfmFERwbWJXo4xi+RUKo7xYPLabA==
X-Gm-Gg: AY/fxX5bBni2ef9cANNlyqQdkqyljVPDK+DnogP0aU7ozl4UqsFpWqnjUBL4gcaF6/U
	+yXsp+K5ASJ5nrSaDHCpasNIu1ZujtdXZZ+O0thJC/qXM2lhsqgNoItKrOTds/ope19p29xk6wn
	v32mb8DZv/lY/Cou2sVqcRb+eDRWJgexlE/CU023X3UjtEPITKsknfMCQFiqB4r0ibPbxKGxD19
	FFygfsLcA9HmydXlk8+4MblKQXaKzaOrHTkJyU2SViR2YYBAK6lm1QnOICdBubl/UcYYj6J+AhV
	Z3P7DRNUZw/JltzgFJY29gKkOeD/dNOTy6MnZ6H8ReaPBgOM5Oif8GfmyCMT+0kd00tCWLI1eUM
	J8zqRwIsW0Isk1P1LWtKxQpBjKMo8ncV0XSHpdXno5SNZQTzk58proIlVOa/c4EtUxtHb+N8K9x
	3xUJ3aE5+eNqLaJThCec/8MqSHIjERknWMtqWl9wJvsCskS9c=
X-Google-Smtp-Source: AGHT+IGHYNacIfOgt68J9ORSjzn9eGKla1BcEVjHzp6NdJkHGDl95DvqQYut9VQsggMOcuIhdisuaA==
X-Received: by 2002:a17:907:9408:b0:b73:6998:7bce with SMTP id a640c23a62f3a-b8037152a19mr4356013666b.33.1767382490150;
        Fri, 02 Jan 2026 11:34:50 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm4645615866b.39.2026.01.02.11.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:34:49 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 07/10] bitbake-setup: in tests, refactor the config writer to allow variable sources
Date: Fri,  2 Jan 2026 20:34:34 +0100
Message-ID: <20260102193438.2960561-7-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102193438.2960561-1-alex.kanavin@gmail.com>
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:35:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18677

From: Alexander Kanavin <alex@linutronix.de>

This will be used to make configs that use local sources instead
of git-remotes.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/tests/setup.py | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 30c8b31e3..438dc0cd8 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -89,21 +89,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         bbsetup = os.path.abspath(os.path.dirname(__file__) +  "/../../../bin/bitbake-setup")
         return bb.process.run("{} --global-settings {} {}".format(bbsetup, os.path.join(self.tempdir, 'global-config'), cmd))
 
-    def add_json_config_to_registry(self, name, rev, branch):
+
+    def _add_json_config_to_registry_helper(self, name, sources):
         config = """
 {
     "sources": {
-        "test-repo": {
-            "git-remote": {
-                "remotes": {
-                    "origin": {
-                        "uri": "file://%s"
-                    }
-                },
-                "branch": "%s",
-                "rev": "%s"
-            }
-        }
+%s
     },
     "description": "Test configuration",
     "bitbake-setup": {
@@ -160,7 +151,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
     },
     "version": "1.0"
 }
-""" % (self.testrepopath, branch, rev)
+""" % (sources)
         os.makedirs(os.path.join(self.registrypath, os.path.dirname(name)), exist_ok=True)
         with open(os.path.join(self.registrypath, name), 'w') as f:
             f.write(config)
@@ -168,6 +159,22 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git('commit -m "Adding {}"'.format(name), cwd=self.registrypath)
         return json.loads(config)
 
+    def add_json_config_to_registry(self, name, rev, branch):
+        sources = """
+        "test-repo": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "file://%s"
+                    }
+                },
+                "branch": "%s",
+                "rev": "%s"
+            }
+        }
+""" % (self.testrepopath, branch, rev)
+        return self._add_json_config_to_registry_helper(name, sources)
+
     def add_file_to_testrepo(self, name, content, script=False):
         fullname = os.path.join(self.testrepopath, name)
         os.makedirs(os.path.join(self.testrepopath, os.path.dirname(name)), exist_ok=True)
-- 
2.47.3


