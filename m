Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64158C982C7
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 16:06:46 +0000 (UTC)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.458.1789488402070815541
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Sep 2026 09:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XrP8TsJg;
 spf=pass (domain: gmail.com, ip: 74.125.228.12, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so418418a12.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Sep 2026 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488401; x=1790093201; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4aOj/tv/oPKW7Gvz2ecPaDtA6tIX97TR4dA8ifBEBN0=;
        b=XrP8TsJgaO+fFbnBIB1mqGDBQRuwsfCsMy51S9x3ewtQaQu7YOUfwvRvaLgGJ4Cla2
         xnmkIw8t80VFgeTzKtiXxBn8Je00Qdr+ce2a1ryd0bMyF9b+/ieZp+LhSeFZP+j/lsEO
         KzwgWTuHjclj45YwKjA1u5mVqIFF+Y4/pLiAIvqqGXHjmDQprP7ecmGzsN9H0AxhUdpu
         +TlbEzlXRieLfG/jFu5Dj9TCkzwI1QNRhbOmje0X7OIOxKlclchhE5U5l+wcktHIJdmF
         dr6RyQeWIUA4JeoDNjg9vUHXBPNbscY9UyYPAT1qH8WKeuuxN2BDf4tx7QYs6x6d1+Ew
         CASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488401; x=1790093201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4aOj/tv/oPKW7Gvz2ecPaDtA6tIX97TR4dA8ifBEBN0=;
        b=aeCGO0kd7hgfPtqHKdpmajF7mv9kBMI0VodQ0n8rKmrW7DEjQKsoD4Yl06QwOKX6eW
         l9ms3wUiOkdOvN2A4YEcSIdgqmbPFUi3ZMQrJachGTYK9TXaRtPlHa+5e+mrF+9YYM0N
         +387WSHjeldX64WL5Yo+EGD9EgXhONXzPoH1DSzdhxK7ktWdIYwhDxHYA66tZOROKiqx
         xQgUA3fK2Dl/Lr1og6WovzrPTRSVNjx0Vh326waE78EWZBCNM0yG2tPxyv1AVn1EY8HH
         pY+kZupQO7rcmez5AIUsO9u3mFi9Z6CXqJiLUD35S3hFWDDIoPr+yQT6veZVtLJsaE05
         r0ow==
X-Gm-Message-State: AFuF++noBjzVv773SCC/FxALc7E7yv2Vetrs62xoLyu/rBSd6RUMiSSJ
	hcaTNdAWSfTvp+FYXpf8/pcc12HBw3r6NNUpQJZ+IxbFuMIA//nQaiEHmDhfXe2cZTE=
X-Gm-Gg: AYBFou1cLrFDdHJg2SK+rhfh6y6MkFln0alLPNT5qrDyazXoSjylCK0MFoyai903o0Q
	H13qKvPlCV6TgHLbfLply4/D8bPL1KoZIhqvJUYGW6UF0k8gfyMOi7aydLTjea2Kwb9plAudm4w
	7x8/QNJvPjGlajuZKjEbpv+kqpRX9GswsCVsu3uBrotw3DLckO+A40BR/TE3DlKSCkVVnuqxdv2
	yI54u0nhE2j2MXNXEkbB1eBdwS8rTWtUUkBhb5ORmjjWrS+Y/ePc/AJoq9PLCqTM7Ub5NTJpjzv
	M+vtkmNlrNZHicUvJGk7tldIFIDRjseRoCZrZLOfSzGsuZY511YMomAoICyH9ml/U0IWhJV3Be4
	PQ1Ui2jzIEa1FC7wxAU50Ss5dRwrTF78MuXA8/Q8Kl32sHSAaFERy1MKOUuad7eilSxNkYsFCNO
	pmujKmAfoEpcWgPGEcZyKFx86T3Qd5+68u0dLDmQTvIapGrQWSPqLAgRnbYLfZQhvTkuSJ0gk=
X-Received: by 2002:a17:90a:1048:b0:39e:1329:7816 with SMTP id 98e67ed59e1d1-39e13298c84mr1520403a91.15.1789488401382;
        Tue, 15 Sep 2026 09:06:41 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfba020d1sm2605678a91.2.2026.09.15.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:06:40 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH v2 3/3] prserv: add --status to list running servers
Date: Tue, 15 Sep 2026 16:06:33 +0000
Message-ID: <20260915160633.7-4-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160633.7-1-bbnpreetsingh@gmail.com>
References: <20260915160633.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Sep 2026 16:06:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20216

Add `prserv --status` to report running servers and stale pidfiles, with lifecycle tests for both running and stopped states.

[YOCTO #10865]

AI-Generated: Uses Claude (claude-fable-5-1)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 bin/bitbake-prserv  |  7 +++++++
 lib/prserv/serv.py  | 23 +++++++++++++++++++++++
 lib/prserv/tests.py | 18 +++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index e666fef06..5775f47fb 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -64,6 +64,11 @@ def main():
         action="store_true",
         help="stop daemon",
     )
+    parser.add_argument(
+        "--status",
+        action="store_true",
+        help="list PR servers running on this machine",
+    )
     parser.add_argument(
         "--host",
         help="ip address to bind",
@@ -102,6 +107,8 @@ def main():
         )
     elif args.stop:
         ret=prserv.serv.stop_daemon(args.host, args.port)
+    elif args.status:
+        ret=prserv.serv.status_daemon()
     else:
         ret=parser.print_help()
     return ret
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 6aba1c3e0..a49faeb4a 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -427,6 +427,29 @@ def stop_daemon(host, port):
 
     return 0
 
+def status_daemon():
+    import glob
+    running = 0
+    for pidfile in sorted(glob.glob(PIDPREFIX % ("*", "*"))):
+        root, _ = os.path.splitext(os.path.basename(pidfile))
+        parts = root.split("_")
+        ip, port = "_".join(parts[1:-1]), parts[-1]
+        try:
+            with open(pidfile) as pf:
+                pid = int(pf.readline().strip())
+        except (IOError, ValueError):
+            sys.stderr.write("Ignoring unreadable pidfile %s\n" % pidfile)
+            continue
+        if is_running(pid):
+            print("PRServer running at %s:%s (pid %s)" % (ip, port, pid))
+            running += 1
+        else:
+            print("Stale pidfile %s (pid %s not running)" % (pidfile, pid))
+    if not running:
+        print("No PRServer running.")
+        return 1
+    return 0
+
 def is_running(pid):
     try:
         os.kill(pid, 0)
diff --git a/lib/prserv/tests.py b/lib/prserv/tests.py
index f1e4f12c8..8b78e2496 100644
--- a/lib/prserv/tests.py
+++ b/lib/prserv/tests.py
@@ -403,8 +403,24 @@ class ScriptTests(unittest.TestCase):
         except subprocess.CalledProcessError as e:
             self.fail("Failed to start bitbake-prserv: %s" % e.returncode)
 
-    def test_2_stop_bitbake_prserv(self):
+    def test_2_status_bitbake_prserv(self):
+        result = subprocess.run([BIN_DIR / "bitbake-prserv", "--status"],
+                                capture_output=True, text=True)
+        self.assertEqual(result.returncode, 0,
+                         "Expected a running PRServer: %s" % result.stdout)
+        self.assertIn(":%s (pid " % self.port, result.stdout)
+
+    def test_3_stop_bitbake_prserv(self):
         try:
             subprocess.check_call([BIN_DIR / "bitbake-prserv", "--stop", "--port", self.port])
         except subprocess.CalledProcessError as e:
             self.fail("Failed to stop bitbake-prserv: %s" % e.returncode)
+
+    def test_4_status_stopped_bitbake_prserv(self):
+        result = subprocess.run([BIN_DIR / "bitbake-prserv", "--status"],
+                                capture_output=True, text=True)
+        self.assertNotIn(":%s (pid " % self.port, result.stdout)
+        # Servers unrelated to this test may be running on the machine
+        if "PRServer running at" not in result.stdout:
+            self.assertEqual(result.returncode, 1,
+                             "Expected no running PRServer: %s" % result.stdout)
-- 
2.43.0


