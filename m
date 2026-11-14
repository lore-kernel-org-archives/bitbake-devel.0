Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2404.1794682535577550735
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 14 Nov 2026 10:55:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=ODNdgWGr;
 spf=pass (domain: gmail.com, ip: 209.85.215.177, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so830849a12.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 14 Nov 2026 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794682535; x=1795287335; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XM8UIT3LJaIzl9eVV5TThaExWE4kdKI+squ0H3z52eo=;
        b=ODNdgWGriETTtqoPcve0XDE/JSawZ2/Y758g3kZ4PT5bYBWxp+vFHfV2auYnl1vVdq
         r3g+cb1orFAN3c7Md5sZ4Jp91dJY/WCYKAX4RHoC5ORp/q0J2sx+8Ad0m812bR+Kb75U
         vmK9PaYCFr0SRtAx6DglFGy5oAGkbP6ilhk2gzLEm64zxzDeXsZ8BHp2qxYXnwM8/RDB
         sEbS1jVQzEnhltMrErzwJ+yzLsUX4XbPPskF6o7IRDjLDV/dRWObI/Ujloj5JdHJXnes
         eQ1drRN49RtHJ7TXxcHnTfs/jXKZ7yowlcS/hZHBIYqr6QHgS7yM7gTwwB6AJKMkTuS1
         takA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794682535; x=1795287335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XM8UIT3LJaIzl9eVV5TThaExWE4kdKI+squ0H3z52eo=;
        b=aFBGfIbNRFnVojGM1auc3iTilkE3JkjvKKAZQLVyWP/g0CUMLKHM+ZK1aWjE8oxcNW
         5TUFNJOW2OIfWmA1YHCZmw6YjWHlK8Cdu7ligQUDXGVQSoaFM5qNlsOvMO7aYpws2eWr
         GStZos6tE0XewvMhJeZt7Fc+cFXf2tEqYmn5Gn0ovVj2UiXf/3GMc9vi+zRdETtGXKyQ
         9cuUTUc1mQlLa3GtUXr1pHyf5qeVfWGOFrXBl0a3KDZb4yPHTuGEPLMPrLEqCV3ZnKCX
         eR4jdH2DFyXaPXb5b4b62PZrPIiooksHVDypu8n7u8TKyxgO80yO+Svn4kBh8HuF/vMT
         t8SQ==
X-Gm-Message-State: APuU4Z/Lol9o431eaRJMRW7PV2uOWWbcP2aZktEyoBBkRpG7IQqPERod
	Wnb4bSGLJrbKcycW4qHdaV5xXXaJfXYpc7hKPf3Cm9bar5DFDTm/cTlOYigzGggKQKo=
X-Gm-Gg: AYBFou0PhLpAEPuvIDWFvPY+Jw8v+Q1/PSzY8LqWQ2lLVmhPDass/jioPkZQ/bumnDH
	6+1uDneM50IyQpzfAPIIr6EFnJyhRNYthMGP4SaqQbAWkO5xUw8WLOAYYocTv7A//76XQCcqF5l
	/IoONnxInjeB6yo4Yj5nArPtsqg23htG/CGwcEI09fvJPicF6RRAGwhZhh5bYepX/V2HJRKQStq
	952FaAEYPBQwaOl4Dj6ie1ZofkZ+7Uz9ee1IUKcyfNSaPSlhSA10ysiaR3d+Hr2lls76QgPm/xi
	+Y10uLslMshKROUtd1awAoxtgICkFoEByZEygBzstQPBlLYzBuLz/VVQ0mm9c97FOB3t4Kiylk8
	xSdp96Yfyqnmysc+oIaYc2u/1T9LOzwedYtXzmrnBO2gkzfke0LITmBCpbAgEs7zHg+mUbagDzY
	Bfo7Kbz7gUzbg/YLQ6FKo6+KwRR+ZA3XiKB8P16xj6mmV75Rt9cfiNAoPuseOIaX49TsINMt3jO
	27BwERO98vTWAey1++znYqTMcMXmUyEAlOpUrmm0Jg++5V+GdUgNxGjj3Q657vs1yzmndnUieNi
	BY0+F6yAeV5VMlGt8pcg/cxgtZLG/2lhpobek4Mp4RQXGTPXILuIv4wFhc9S064=
X-Received: by 2002:a17:90b:3806:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3b1b0b53ad8mr5514175a91.50.1794682534897;
        Sat, 14 Nov 2026 10:55:34 -0800 (PST)
Return-Path: <bbnpreetsingh@gmail.com>
Received: from localhost.localdomain ([108.180.159.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3f09b92sm4437116a91.4.2026.11.14.10.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:55:34 -0800 (PST)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH] cooker: fix -w with a file name that has no directory
Date: Sat, 14 Nov 2026 18:55:34 +0000
Message-ID: <20261114185534.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sat, 14 Nov 2026 18:55:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20432
Content-Type: text/plain; charset="utf-8"

"bitbake -w events.json" fails with:

  FileNotFoundError: [Errno 2] No such file or directory: ''

There is no directory to create for a bare file name, so don't try.

Fixes: ee174b231897 ("cooker: Add support for BB_DEFAULT_EVENTLOG")
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---

Notes:
    Found while looking at YOCTO #16492. Applies with or without Mathieu's
    patch for that bug.

 lib/bb/cooker.py       |  5 +++--
 lib/bb/tests/cooker.py | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 8a422e506..f79cd5e6c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -457,8 +457,9 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
         if not self.eventlog or self.eventlog[0] != eventlog:
             # we log all events to a file if so directed
             # register the log file writer as UI Handler
-            if not os.path.exists(os.path.dirname(eventlog)):
-                bb.utils.mkdirhier(os.path.dirname(eventlog))
+            dirname = os.path.dirname(eventlog)
+            if dirname and not os.path.exists(dirname):
+                bb.utils.mkdirhier(dirname)
             writer = EventWriter(self, eventlog)
             EventLogWriteHandler = namedtuple('EventLogWriteHandler', ['event'])
             self.eventlog = (eventlog, bb.event.register_UIHhandler(EventLogWriteHandler(writer)), writer)
diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index db4104d40..c6a0cac2a 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -409,3 +409,21 @@ addtask marker
             with open(os.path.join(builddir, "marker.log")) as f:
                 self.assertEqual(f.read(), "bbappend-applied",
                                  "bitbake -b did not apply the recipe's bbappend")
+
+
+class EventLogTest(_BitbakeSubprocessTestCase):
+    """Tests for the event log ("bitbake -w")."""
+
+    _parsetests = os.path.realpath(os.path.join(os.path.dirname(__file__), "parse-tests"))
+
+    def test_write_log_bare_filename(self):
+        """bitbake -w must accept a file name without a directory."""
+        with self._build_dir(prefix="eventlogtest") as builddir:
+            env = os.environ.copy()
+            env["BBPATH"] = self._parsetests
+            env["BB_ENV_PASSTHROUGH_ADDITIONS"] = "TOPDIR"
+            env["TOPDIR"] = builddir
+
+            self._run_subprocess(["bitbake", "-w", "events.json", "-e"], env, builddir)
+
+            self.assertTrue(os.path.exists(os.path.join(builddir, "events.json")))
-- 
2.43.0

