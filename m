Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC416CDC188
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:10:49 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88570.1767701443093170791
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:10:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LLo8VlhI;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8018eba13cso156533666b.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701441; x=1768306241; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4i9sicM6Z7W0DQ/FMvbubjpLq+gTNnswRlKEWWAobpY=;
        b=LLo8VlhIB2/pZxzpHr8bmPUWTyAT6+H00UUVywUo12w8D47/7SI9Q7YQxHUL3XsXcs
         OWJMhbUGxXuzl+M2RbIGOMcMiBrQBCRuyUFmYr+YBt9bpod4bsPx2ZXnPWbLMmV7E8Yp
         Dcm1T0Nm18613TvOJTw4gmGzLO7ILL/mju2fOINESRVOGmC4rJ3ReHtflwBKemvRgAdN
         5U5HCUsKF08wRbBvPkS0z9wnhoTlw9cODokO03531cbrbLVWrkysNkT+Q6Mr/Tbutptr
         +mt01LfLKImdVtashm0w4Z6Q9iajCY/YkJq2jeLWlKBvZTYebXptFH0qcBfeYUIiKFtO
         Vdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701441; x=1768306241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4i9sicM6Z7W0DQ/FMvbubjpLq+gTNnswRlKEWWAobpY=;
        b=CG1bUhHUmXTybFP2iyfmIRUNPKdvJBpEgmYH7bVrsY3smO89mSP851LV/8rJHCP5UU
         JYx9A4ZC6+uzjMl/cTWXTHmKLPC2rtR39CIGQbzMv79bTwzg1I9H6zHmYBf9jr5+e+iV
         PYw93dB3xsXfMtTbhK95ym8BRlBIXaYAkda9XjlDiGU0OIvDQJ/mOKJSG0sVAIvYX/7P
         TNuZsCT8TyDl+ptKXpfpoXNB9mDX550GOmizQ3fIaCyM4AaVJx3ZAbj/JBQ1Ns0R8uMQ
         YqFpU/zjCEAvvvN13p4Epi54NmB3spa2eV/VVlZk1OGfPuCHdptSGPVpMjbCLEA0xOH2
         wBhA==
X-Gm-Message-State: AOJu0YxgJ6aqkRwhhSpYFFhxnLZ+7aZfwLUL5arAmpffzYPmpCTlbMN7
	byLqeG9IhhAqX6t1uHSvJL/Tq/TAB248wNNfy77Irjn+8SEh282zcXgI1VCo7A==
X-Gm-Gg: AY/fxX5z1JroWlVeOiQAzuRaWfP0aJ1xrMR4LJkiFS9CGkHIAsAVqjgB8qrog+imlo1
	6CGbR7O1sdiHofsCamf5BZBXjuzyNhtOcv5F2YF4+Ctip+WftFNDONcOcbNQb0uk5hY1rIcAhLp
	/d7KTOhRWHolYyh8yqoWqMqriQMY9u43tXx5Z+KH/KIYKqzQpUsetFn+NtzfDF+/04jH8wsJhYw
	u6EwRgQWfy5S3h9LAaWsR4Yr/8ExOfkzABlOfpkf6L2yb8jBTPRaKuCjCEvdPpx7yEQSmzftKYb
	71gcMKZld4efH80mRU8Dnk/YZlmBsJmKhbpnoFZFO7DsFOG4wqmeoUL0qaxx+Ws4rwkYYfQbaw3
	a0wQyeVNiZUQE4IBSTWKqY0EPyhcuMEukduiOBWh4WzQwQhY3/Ou8J60CsdShCmv3+6BYc4aKUX
	8bQZv9IMzBc44PYdkkv5pgGffgxUDCrAM0N3wOM+NrAD7+5GQ=
X-Google-Smtp-Source: AGHT+IGP0RlcbH6B51E4gUQr9lms/bASy/ev9myKb2Pge5/0qaudZx6Y5nDprfAtitoyBMJRghw5LA==
X-Received: by 2002:a17:906:fd8d:b0:b73:9aa5:8782 with SMTP id a640c23a62f3a-b8426a43d3amr274144466b.9.1767701441213;
        Tue, 06 Jan 2026 04:10:41 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm223329466b.0.2026.01.06.04.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:10:40 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 07/10] bitbake-setup: in tests, refactor the config writer to allow variable sources
Date: Tue,  6 Jan 2026 13:10:29 +0100
Message-ID: <20260106121033.3892596-7-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106121033.3892596-1-alex.kanavin@gmail.com>
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:10:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18697

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


