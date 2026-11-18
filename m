Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1969.1795038866473556418
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2026 13:54:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=PFxTK0C7;
 spf=pass (domain: gmail.com, ip: 209.85.210.171, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so864643b3a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 13:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795038865; x=1795643665; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DF8PYomYvJ3xQFZvCKf5vLu19LSgRXo3lrZE+EfnEUE=;
        b=PFxTK0C7Ak/dx9XEh5ipNhFhzU6qvW9693BTxDrJdOFU57v3Ef4iR/kqZk+/xd+6va
         iRQs5td63JFqUYtcXIK3QtY1KhkvugwAOK8I69gUqne7kjFqK2jWFg4YSfOj3A7bd5Sg
         wShFtmpwiwhZUzseeKo6vUM/HXUIcm72Is1HucJgXJv2YNVxRIA3G0ZcJMfQY/2EBx27
         DzyWNxw2oBUjV0Phsmj4Jye5BuIwe5AWntE5eavk1orLScrQzc2QxXMUfwdLRQRN2WOn
         qkijWzfUbTuneLXjwQEsG1yAUX83mY7W2Ri4vxOOp8/g3q0ancW8ZrVbzryPA4j6HyHp
         4kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038865; x=1795643665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DF8PYomYvJ3xQFZvCKf5vLu19LSgRXo3lrZE+EfnEUE=;
        b=iMIun5aKgYO0Gh5rbrkOMmWh021RborCtzFtnksw0gfoj5Oxe547OrOZydcLt3f981
         zHoBjapboEMSJ9nSFRQlAy7C4px+zI6xJetAQ6UDcJa7lMcac+uZ4Asl/fosyAS1KQJL
         lZQ4GBE1GjdRkMimNZkFNsvtFSmJanf3em+GueRVvEHefhylY77zyvPb0oj6J8RFAcN2
         IokpOQlhDKe3XS+6cY2Yhj0qQ22rrWqcvw7v9yLJL8W5P6ccuyNS15dwUPgOAS4Ln2gG
         Cjw7+yhnFe+LVgPDGK1cZhKktaGY/jS+C4If8e1ady+L3mpXUtwINwMEzZfX2MkpUomy
         fOmw==
X-Gm-Message-State: APuU4Z8LYRCjIneBXCaj22eF4iJwjZ9PFQjuNjmiglapRN9KcvrXhglC
	mB26QHorUI6ctaqy7RQqzwHnag0o9Kp+vlw6rVW2LzwII3ZkR7L3ySRW6WRn5bWEDRk=
X-Gm-Gg: AYBFou0EM4C9CUZFEXJ6wjgvaeD91fUQrG4/kJ4UfILYJ5ISFdiEPNYk4k1xQ9hwtzj
	q2sRBkc1ehPfZUAEMveCaLAqDvI66810h/v9UewZAaQJSklJUXpBfAWExLerG2D6iAI0TeQOfUC
	B3k4OY0unVaMxGr+GnxQaKCoFoVnem3PaN9eM4rLSSxazDI3x5PfGscdZ1CaP3tRqcPOsDLtbdo
	oqgelMQSJd/AePdA71tD08DqB87G/M/YpQxjZSypDAAz18utSxcGEw/gZwM94sv7bLrqoUKPtxI
	mr2THW9Qej+J3cCMy10a3n/Pd9xTkoNTrVKjM/+1tYX0JICsLOeX6lrLHZi3/TBwfVKsBTemOUz
	6SaAYX16OLyR1U3tXBIsjFNsWWKfF+c7BAqdV+aXROYQarrnEfRzca7BDlMVR5T7S82B1XCn5jh
	ufKOmvFrueZXMJaMxfA6YVWBtudwx1Ep8V6otJCvvQiem2naebWKd8ScOSDS9D7MGDkNIxwGD/e
	dxIv3e1k3h0uPTfkars7qpYJ42Ysh5ZKGg4gmLp1oDyY7rUUX83zxlDwKrlOdwHjo6ky2YMcPLf
	VGv0UQYJjPBC+Qvd9qAZDICEiNp3SOaLO2cwMwEx3qaP43OIuzcsGNW20A==
X-Received: by 2002:a05:6a21:b8c:b0:3f2:acd9:132e with SMTP id adf61e73a8af0-3fe8b5eea33mr3704170637.61.1795038865500;
        Wed, 18 Nov 2026 13:54:25 -0800 (PST)
Return-Path: <bbnpreetsingh@gmail.com>
Received: from localhost.localdomain ([65.7.19.138])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde534861eesm574329a12.14.2026.11.18.13.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:54:24 -0800 (PST)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH v2] cooker: make the event log path absolute
Date: Wed, 18 Nov 2026 21:54:23 +0000
Message-ID: <20261118215423.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a41c1517f39b3f6ea520094767ee2b98ab010b7a.camel@linuxfoundation.org>
References: <a41c1517f39b3f6ea520094767ee2b98ab010b7a.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 21:54:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20459
Content-Type: text/plain; charset="utf-8"

The server's current directory may not be the one bitbake was run
from, so a relative -w path is not safe to hand over. A bare file name
fails outright:

  FileNotFoundError: [Errno 2] No such file or directory: ''

Resolve the -w path in main.py, and show an error if
BB_DEFAULT_EVENTLOG is relative.

Fixes: ee174b231897 ("cooker: Add support for BB_DEFAULT_EVENTLOG")
AI-Generated: Uses Claude (claude-opus-5-5)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---

 lib/bb/cooker.py       |  2 ++
 lib/bb/main.py         |  4 ++++
 lib/bb/tests/cooker.py | 45 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a6bc2827d..54f87278f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -314,6 +314,8 @@ class BBCooker:
 
         eventlog = self.data.getVar("BB_DEFAULT_EVENTLOG")
         if not self.configuration.writeeventlog and eventlog:
+            if not os.path.isabs(eventlog):
+                bb.fatal("BB_DEFAULT_EVENTLOG must be an absolute path, not \"%s\"" % eventlog)
             self.setupEventLog(eventlog)
 
         if consolelog:
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 5cce8eb27..5a49f73b3 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -338,6 +338,10 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
             eventlog = "bitbake_eventlog_%s.json" % datetime.now().strftime("%Y%m%d%H%M%S")
             options.writeeventlog = eventlog
 
+        # the server may not share our current directory
+        if options.writeeventlog:
+            options.writeeventlog = os.path.abspath(options.writeeventlog)
+
         if options.bind:
             try:
                 #Checking that the port is a number and is a ':' delimited value
diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index db4104d40..923adc156 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -409,3 +409,48 @@ addtask marker
             with open(os.path.join(builddir, "marker.log")) as f:
                 self.assertEqual(f.read(), "bbappend-applied",
                                  "bitbake -b did not apply the recipe's bbappend")
+
+
+class EventLogTest(_BitbakeSubprocessTestCase):
+    """Tests for the event log ("bitbake -w" and BB_DEFAULT_EVENTLOG)."""
+
+    _parsetests = os.path.realpath(os.path.join(os.path.dirname(__file__), "parse-tests"))
+
+    def _make_env(self, builddir):
+        env = os.environ.copy()
+        env.pop("BBEVENTLOG", None)
+        env["BBPATH"] = self._parsetests
+        env["BB_ENV_PASSTHROUGH_ADDITIONS"] = "TOPDIR BB_DEFAULT_EVENTLOG"
+        env["TOPDIR"] = builddir
+        return env
+
+    def test_write_log_path_is_absolute(self):
+        """The -w path is resolved against the client's directory, since the
+        server may run in another one."""
+        import bb.main
+        for arg in ("events.json", ""):
+            with self.subTest(arg=arg):
+                params = bb.main.BitBakeConfigParameters(["bitbake", "-w", arg])
+                self.assertTrue(os.path.isabs(params.writeeventlog))
+                self.assertEqual(os.path.dirname(params.writeeventlog), os.getcwd())
+
+    def test_write_log_bare_filename(self):
+        """bitbake -w must accept a file name without a directory."""
+        with self._build_dir(prefix="eventlogtest") as builddir:
+            self._run_subprocess(["bitbake", "-w", "events.json", "-e"],
+                                 self._make_env(builddir), builddir)
+
+            self.assertTrue(os.path.exists(os.path.join(builddir, "events.json")))
+
+    def test_default_eventlog_relative_is_error(self):
+        """A relative BB_DEFAULT_EVENTLOG is refused with an error."""
+        with self._build_dir(prefix="eventlogtest") as builddir:
+            env = self._make_env(builddir)
+            env["BB_DEFAULT_EVENTLOG"] = "events.json"
+            proc = subprocess.run(["bitbake", "-e"], env=env, cwd=builddir,
+                                  stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                                  universal_newlines=True)
+
+            self.assertNotEqual(proc.returncode, 0, proc.stdout)
+            self.assertRegex(proc.stdout, r"ERROR: .*BB_DEFAULT_EVENTLOG")
+            self.assertFalse(os.path.exists(os.path.join(builddir, "events.json")))
-- 
2.43.0

