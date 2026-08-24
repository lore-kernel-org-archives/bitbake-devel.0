Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3653C5DF8C
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 04:50:13 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10002.1787547013324282741
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 23 Aug 2026 21:50:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=B7Vr1q25;
 spf=pass (domain: gmail.com, ip: 209.85.216.53, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e041ea211so2423903a91.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 23 Aug 2026 21:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787547013; x=1788151813; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PxwFa5os9cLo3QhvuBTfHC4VAX97dvALYGXqoKs5MB0=;
        b=B7Vr1q25sO+7pJhR56AvygDw87msaqcP9mho8g4qaB73IsEuQ87gW5qy7rym7lRRUI
         aXtJVZ9uXuCIKOjMPWdFAg9hcp9iJTFyGBvlCJjIHLov0XVkouH0NaHFlj1rdo2B3IpG
         r/pihI74Ki59oP/kRu9UA9V5Cgs3oXJ+Q2FrzmYQi7vh7k2HYK5IEiYH7q3UPckC9Fg+
         6Et61E4rsAyIIzBOZWJCiSYg9lXRnlKnRNhGo0c6nTB3QiIWa3rihRga2BAbJDyg6AHA
         y79MFajZjvmzbsKZ7PzbqujPhKO0TCiGHJrjlJkS91XpRIziQt2pxy0j/Jl2GekFAuD6
         ei7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787547013; x=1788151813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PxwFa5os9cLo3QhvuBTfHC4VAX97dvALYGXqoKs5MB0=;
        b=Cj08wWypHTCp85CIqUQz97ZdeYZp/0Sp+lKFFvMs5krOybk0cXH14Lj+Yua4BeKhjP
         i3bI8iuiBk1XFnW3qGim53z61nAK+F4N11Gj9p1TUrdth0cBEKKmqXyYb8w94Gk1M0S4
         g+x8z8FXiPcr5i6RJAxKZnUnENZy+Phthk//Jx4+vO731eOB7W43PCNBEtv7tCZVULGn
         o5GlUOZQz3vd5eO5Wd7h44x/EVH7C3Br3A42Z3huUCJd1ufdn8obXjcfbsJSpdSfbiYn
         6VR/HZlo9kyJ7hstFuj7f2tYm8OZaD37nncID8xMSZ5MXg1n8/SIUBJkwubmZZv2MNtG
         Qc5Q==
X-Gm-Message-State: AFuF++ln/NeI7kuKx7e5FsL6wpzv61jUtpp6Bx7mvgn4oRdD/UDpaD+6
	tolJmcAwPzLOjjdcPcaGaarFsxLl456TFJfW9Gw971G2DJaJgFycT4VhaEHXiTpb/n0=
X-Gm-Gg: AR+sD105CzJm8mh9YkIU5tdtREyq4Nl5h3Zl7I2h9xs06xwtrdRBLoPrXX1e2HAQOTC
	fJ2LtyD2TkAHFlZ2Q6y0mPdmXtJHTizKznY4zX9ApsyTTtqeYsOYaRGjmrOQoBnLugl3K36sXnH
	x52bM7T+yGp/62Nh1j75VXJX+puDSskkjkO0qWqz2+Dx9Au7NFuNf5CyIOrI/podafum96tgLO+
	d5SQ7sLy5unH7yocukAkj+3EqMXE8/XeGWz5u7edcoHa9pWBSSem4i/gGK+drERSHyQCEc3Jbxp
	Zup5eteTO6GVJ5CBjf32jLAVW0OJuCoV4XjVSQytFSTGI1gR7XjIMiWV/AD9jXs+rrJlbIOjnkU
	h3YfQ1MuzG0QWvQIGZFhsbkv/eEP1S40H8PLIycgouNSU1yHXxXAE3HCBZxmycc9Lxf4vmB4zXJ
	bHPfV2EQQ+tVUi5rssctjZKQcjHY4eO5gCqv6QN3iALJDnd1rzFTCGMAXm1miR
X-Received: by 2002:a17:90b:57e5:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-395c35f0a79mr43013415a91.14.1787547012421;
        Sun, 23 Aug 2026 21:50:12 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c92b5528sm3307335a91.4.2026.08.23.21.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 21:50:12 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH] prserv: add --status to list running servers
Date: Mon, 24 Aug 2026 04:50:11 +0000
Message-ID: <20260824045011.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2026 04:50:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20020

bitbake-prserv could start and stop a server but not say what is
running. Add --status: it reads every /tmp/PRServer_<ip>_<port>.pid,
reports each server as running (with its pid) or as a stale pidfile,
and exits 0 if at least one server is alive, 1 otherwise.

Extend the ScriptTests start/stop lifecycle with status checks in
both states.

[YOCTO #10865]

Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 bin/bitbake-prserv  |  7 +++++++
 lib/prserv/serv.py  | 23 +++++++++++++++++++++++
 lib/prserv/tests.py | 16 +++++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index c26362b2e..8413c585f 100755
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
index e17588630..322c22a0f 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -388,6 +388,29 @@ def stop_daemon(host, port):
 
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
index df0c00300..518d5c441 100644
--- a/lib/prserv/tests.py
+++ b/lib/prserv/tests.py
@@ -381,8 +381,22 @@ class ScriptTests(unittest.TestCase):
         except subprocess.CalledProcessError as e:
             self.fail("Failed to start bitbake-prserv: %s" % e.returncode)
 
-    def test_2_stop_bitbake_prserv(self):
+    def test_2_status_bitbake_prserv(self):
+        result = subprocess.run([BIN_DIR / "bitbake-prserv", "--status"],
+                                capture_output=True, text=True)
+        self.assertEqual(result.returncode, 0,
+                         "Expected a running PRServer: %s" % result.stdout)
+        self.assertIn(":8585 (pid ", result.stdout)
+
+    def test_3_stop_bitbake_prserv(self):
         try:
             subprocess.check_call([BIN_DIR / "bitbake-prserv", "--stop"])
         except subprocess.CalledProcessError as e:
             self.fail("Failed to stop bitbake-prserv: %s" % e.returncode)
+
+    def test_4_status_stopped_bitbake_prserv(self):
+        result = subprocess.run([BIN_DIR / "bitbake-prserv", "--status"],
+                                capture_output=True, text=True)
+        self.assertEqual(result.returncode, 1,
+                         "Expected no running PRServer: %s" % result.stdout)
+        self.assertNotIn(":8585 (pid ", result.stdout)
-- 
2.43.0


