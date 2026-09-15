Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F167C88E7F
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 16:06:46 +0000 (UTC)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.456.1789488398453294831
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Sep 2026 09:06:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KSEyo7hj;
 spf=pass (domain: gmail.com, ip: 74.125.227.140, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so1381089a91.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Sep 2026 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488398; x=1790093198; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31ghfM750/FltrKM6hs6zjlTUSqDtyvdkojsG6Pmd4I=;
        b=KSEyo7hjjwOdNE5/8Bi7XFNMZjsGYecib/IzERAD0eWdSecnaXtDeIe1s2mxAGerLk
         hJ04WjXH1uDxH9puumcJng5m+l9D0trtueOa9L5JRDGtPbjIG/WCTlxezqQUeXmutNsz
         i4nM1KIJAHlmDnfzDF4TBZQ9yjpwogG0TB7DWLfymnMLvIzLYHc1BlOTCOmj+/cEgmLk
         C1bmIdTG10gGL4BtLpboTjSydsjbU1KUrGLZFoXKLiGo+HNJeXx8DfmT+Pv1YA/Ewoar
         VL1H6Dn1glNHB0TIj/H4jyCC6xQDT4WmZvDlgGxo25K30aQyZWqsMmlhusAVXWhCHIaE
         Yqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488398; x=1790093198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=31ghfM750/FltrKM6hs6zjlTUSqDtyvdkojsG6Pmd4I=;
        b=G2PYNs3q+2MwwJ4xAJxfG4dRP43n9yD27NhvFQ3JS0/dz/y3jhkIb4V5TaRsqZrjOq
         EX2zLsuEV42FsnUX/8HThY1WiQgUfaTsZlXAEY9h9GgDbJaNmJp9vutKeHpRI+2Fm1vt
         IXPh5XC+Rrcyppe6Jy+NMGn3M3DAO8OjOeuHL2Z4gCR6V7NDhlzbxr8s91ETLmMkRydP
         UrkmpP/yyq2chvrm69fdxLFyPAwBu0vA513Zh08lK68zv/YQ1OKM2tJtJ4j7oevtdIOe
         0LzhHd0pym0WoybkHNO7pG/9+5L6XOiww7dvP7XmoauDndsvxVIvofnrLkprNBEodQ+r
         KALg==
X-Gm-Message-State: AFuF++lC44nu/oht4PRLafbpvwng1TiVSJ47eamPdvlEiLWy93cR0Z2M
	S04vSQ3e0GffLHAFohRZdWhyBnJmuSYj1b/n0KPkaz2yfM+dOsmmlp/8CCwyQMoq
X-Gm-Gg: AYBFou0K9RYfyD4kK02Af9JhOIi3fk0qUTj3KqpuuH02Vl1PhHY4xCfNP/aWXgC4csy
	VmZMEnnBo8L6makmfkxrvqn4epZBVT2QsDA/Gd0e3UwrJ9T/MWtjCRapD6vFugvInXxEPhIcxqr
	J9duFkt8AkzbheJkEtwfIeI9/WR9P6ralE0NuuA708WJWz8G+aqEjKNKX2Z8xGIr4RrUJK90dO5
	CL79VjdiI28ZBtVmBZJNeOlofB3553G/Pci9lv7Onb3vi+7nhkv7DqLiwx+H9g8NTIBzXXV34rU
	YTDsApcYAWPAQ2LHQsMh7fxWSf0tRKkuPLOEfqI+5iBK639nBK/jWt1zlj+O+0/sukUOZx/runD
	4a27zp8tcrlzXiFR3vW7g+mqCjr2O5p/gZvlSSNFVhVQADzSsW2jge9dEusgp+4u1pcXt9ZtqIP
	gZhSEkfiwdZO7ej0LdCCwaMGIV2wUct+ka5Cs9ut0VMy1KquKdGDyoKl1+M5OWU1sYesqEuQ8=
X-Received: by 2002:a17:90b:3d8e:b0:39d:e1da:81e5 with SMTP id 98e67ed59e1d1-39dfe11c04dmr5141363a91.11.1789488397619;
        Tue, 15 Sep 2026 09:06:37 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfba020d1sm2605678a91.2.2026.09.15.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:06:37 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH v2 1/3] prserv/tests: run ScriptTests on a free port with one database
Date: Tue, 15 Sep 2026 16:06:31 +0000
Message-ID: <20260915160633.7-2-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160633.7-1-bbnpreetsingh@gmail.com>
References: <20260915160633.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Sep 2026 16:06:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20214

ScriptTests starts bitbake-prserv on the default port (8585) and gives
each test its own temporary directory for the database. Anything
already listening on 8585 on the test machine stops the daemon from
binding.

Pick a free port in setUpClass and keep one database directory for the
whole class, which is what the oe-selftest prservice test already does
for its port.

AI-Generated: Uses Claude (claude-fable-5-1)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 lib/prserv/tests.py | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/lib/prserv/tests.py b/lib/prserv/tests.py
index df0c00300..f3b2aae45 100644
--- a/lib/prserv/tests.py
+++ b/lib/prserv/tests.py
@@ -369,20 +369,28 @@ class PRUpstreamTests(PRTestSetup, unittest.TestCase):
 
 class ScriptTests(unittest.TestCase):
 
-    def setUp(self):
-
-        self.temp_dir = tempfile.TemporaryDirectory(prefix='bb-prserv')
-        self.addCleanup(self.temp_dir.cleanup)
-        self.dbfile = os.path.join(self.temp_dir.name, "prtest.sqlite3")
+    @classmethod
+    def setUpClass(cls):
+        cls.temp_dir = tempfile.TemporaryDirectory(prefix='bb-prserv')
+        cls.dbfile = os.path.join(cls.temp_dir.name, "prtest.sqlite3")
+        # The server test_1 starts runs until test_2 stops it, so use a
+        # port nothing else on the machine is listening on
+        with socket.socket() as s:
+            s.bind(("0.0.0.0", 0))
+            cls.port = str(s.getsockname()[1])
+
+    @classmethod
+    def tearDownClass(cls):
+        cls.temp_dir.cleanup()
 
     def test_1_start_bitbake_prserv(self):
         try:
-            subprocess.check_call([BIN_DIR / "bitbake-prserv", "--start", "-f", self.dbfile])
+            subprocess.check_call([BIN_DIR / "bitbake-prserv", "--start", "-f", self.dbfile, "--port", self.port])
         except subprocess.CalledProcessError as e:
             self.fail("Failed to start bitbake-prserv: %s" % e.returncode)
 
     def test_2_stop_bitbake_prserv(self):
         try:
-            subprocess.check_call([BIN_DIR / "bitbake-prserv", "--stop"])
+            subprocess.check_call([BIN_DIR / "bitbake-prserv", "--stop", "--port", self.port])
         except subprocess.CalledProcessError as e:
             self.fail("Failed to stop bitbake-prserv: %s" % e.returncode)
-- 
2.43.0


