Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id DBA8078450
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Nov 2017 10:33:04 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id z3so2706505wme.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Nov 2017 02:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=O7V6s0kN13Dra64cynFZrk1IHMk+3oUACML7jwCTfcU=;
	b=XSlglfI8NP0aNkd8tFeM33t6EJGO4PvUrBujNUohdYDHid/pHhmzPpmoSQjADWSIsY
	6SkPK90euTQLX8PFPAE60oJ7fdVVBBIi8xCdRjHejOOG8DHNKcYNN73jI6XIirEXd9k2
	BolL33ZwksRkpprckzQdeTFNwlB3qxRy+lxswIYJ+bqPQaJ5B6VysB6rPrjx17+IzrMP
	lI3I6sY37UqGJWXz3Gj75iZnTsWboftJfMZSHBak3nUX6s42HQPdAnRACJhiuCF9AZI3
	+XFPor2XmPQrTaDhAZHxaojBKArOqlEF9s50Jzwck38iHCySwQ32oK17uPleg9AoaSzg
	t4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=O7V6s0kN13Dra64cynFZrk1IHMk+3oUACML7jwCTfcU=;
	b=fWzgbF5rRdGlObez7LruLdo/epCLmTaeaUGYmJAg2pW42WVzEXBLROxX8ZWrPq4Ayg
	feC0yNjm/hMXLcPA1W78+zF6lZEkiXGC4HO/NJK/wh7fdw5bZD45QksK4D2q7Il7X/Jl
	w6ox6/yadUM0Rd9KdoAnRvMXAQdwmnZdEI4OrQPqSKvfk3NWhIXFQAwPUiJbwmgWdD1w
	Or3MKyKyrQ3Kp6Nvj782AmDJjRJLOcANcOSFc3ZDsggvpqo8VNX8R/PG7jR90qb2GHBQ
	Og7eULbigCOHtetrc/sING5WWoGrQmdOPl0cgZXnwnasj8z2Q6S6Zl4vXgetquKYf+Zc
	WiIQ==
X-Gm-Message-State: AJaThX769IAtsIWUwlEYwAzdYwtChB4823+zIUUeOhALPbcvuzZUlr+B
	scZOk2XoNQVRo2wPEfENNGwHNsLM
X-Google-Smtp-Source: ABhQp+RqpASAzmWNFoViAmupHBt4iaFsdM4yEZqnBF2lhjF4xSm2buR728M2JaAVfoGoizViJ0O0Rw==
X-Received: by 10.28.113.71 with SMTP id m68mr1126783wmc.1.1510050785312;
	Tue, 07 Nov 2017 02:33:05 -0800 (PST)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	c143sm11914321wmd.0.2017.11.07.02.33.04
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 Nov 2017 02:33:04 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Nov 2017 10:33:02 +0000
Message-Id: <20171107103302.9511-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] bitbake: be more explicit when warning about locale choice
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 07 Nov 2017 10:33:05 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/bin/bitbake        | 2 +-
 bitbake/bin/bitbake-worker | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 431bb4b676e..95e41096859 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -36,7 +36,7 @@ from bb import cookerdata
 from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 if sys.getfilesystemencoding() != "utf-8":
-    sys.exit("Please use a locale setting which supports utf-8.\nPython can't change the filesystem locale after loading so we need a utf-8 when python starts or things won't work.")
+    sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
 
 __version__ = "1.37.0"
 
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index ee2d6224a59..e925054b7f9 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -17,7 +17,7 @@ from multiprocessing import Lock
 from threading import Thread
 
 if sys.getfilesystemencoding() != "utf-8":
-    sys.exit("Please use a locale setting which supports utf-8.\nPython can't change the filesystem locale after loading so we need a utf-8 when python starts or things won't work.")
+    sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
 
 # Users shouldn't be running this code directly
 if len(sys.argv) != 2 or not sys.argv[1].startswith("decafbad"):
@@ -499,4 +499,3 @@ worker_thread.join()
 
 workerlog_write("exitting")
 sys.exit(0)
-
-- 
2.11.0


