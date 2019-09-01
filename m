Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
	[209.85.210.170])
	by mail.openembedded.org (Postfix) with ESMTP id 0C4AA7F26D
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  1 Sep 2019 21:28:05 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id w16so7742972pfn.7
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 01 Sep 2019 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=WMjp0julzjr6hGrldVpgPJY5mMyrE517wVsB/mLQ/0c=;
	b=iWLFOaiBdqFfAR9Oh0wpD7a6Rw7nky2wVTzxms5P5zhyFlfW9aihfGbc8Ya5EWmQN5
	BkOA/1ldbWTFpUTuS/1+4EkmlGk8k7kbe2UoCfnuHZZDFCq4jpM2JpOHW6XSd1Z3IW1g
	Otqa50mDL66dYos5U9Ve7DKXE43Xn2QFOO2CpFe8p0Msd9a4zs7fzManwGwZFsrBPP1p
	kXS6PUmGz84ARZqif/4Ncxn3LW9LiGfw5Bv4DjroxR4mws1Wid+/Q6VILmfL2LLjGgMV
	kbvG+XjQEu+WSFKwKFy2J0/rvbBfNlUWoC/xS95EjvnNS1zXlWRCUr3h9ohl2FE5uxvO
	o51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=WMjp0julzjr6hGrldVpgPJY5mMyrE517wVsB/mLQ/0c=;
	b=mP4ClmOxHnfX8FubQJONzJDgjxXuNUM42CskxrG0KMBNycoFMS5F53v8DhAIB7Tg3x
	3WcA3kbmIBdogxsJ4PpRs0KEWKYBhfJ92FIez7iLLDiDtAR5HXvuhznesS0X9a0mBsV+
	9XBA54+9eeHb5iGycBcfJh5YY44Gc2TOp0OQZ0E3+V3O2Gi9/cEwf66kB1B6fPaJ0Swi
	cAap3emG9urYkQXMvnxZRc85dsHTUemDzXpcXwZ10NaBJivxTfeoNe6BN0SR7uszCvxz
	96hqjYGsQcdsB8eHHKd5eRVAMJPMntWziGX+ZOLIkHu/UKB4LP8O2KCw2eLPggwgfSwN
	UXww==
X-Gm-Message-State: APjAAAUs5lTRGHdX/TgvrAOYqYXsdtUP1xoUNaFg0qumjk5gYFOMAJut
	uARLIityFuJdoHu0tVdWLLd6U023
X-Google-Smtp-Source: APXvYqw0K/IBdksnV/rWH3C1RqLRu6aINLF7WX1HJsvDr8+Vx0PAb3QIeP02Hej/QULBmKS/67MerQ==
X-Received: by 2002:a62:1c16:: with SMTP id c22mr10317438pfc.10.1567373286746; 
	Sun, 01 Sep 2019 14:28:06 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:1d53:5246:e59:bfe9])
	by smtp.gmail.com with ESMTPSA id
	y16sm16985522pfc.36.2019.09.01.14.28.05
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 01 Sep 2019 14:28:06 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Sep 2019 14:28:04 -0700
Message-Id: <1567373284-8760-1-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH]] tests: fetch error in bitbake-selftest
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
X-List-Received-Date: Sun, 01 Sep 2019 21:28:06 -0000

FAIL: test_wget_latest_versionstring (bb.tests.fetch.FetchLatestVersionTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest/build/bitbake/lib/bb/tests/fetch.py", line 1229, in test_wget_latest_versionstring
      self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
      AssertionError: '' is not true : Could not find upstream version for db

[Yocto 13496]

The Oracle UPSTREAM_CHECK_URI used changed and does not work with logic in wget.

Update UPSTREAM_CHECK_URI and UPSTREAM_CHECK_REGEX to match the ones used in the
recipe. Also change the version being checked.

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/tests/fetch.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 23c6338..2ee0305 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1200,8 +1200,8 @@ class FetchLatestVersionTest(FetcherTest):
         # packages with valid UPSTREAM_CHECK_URI and UPSTREAM_CHECK_REGEX
         ("cups", "http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2", "https://github.com/apple/cups/releases", "(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
             : "2.0.0",
-        ("db", "http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz", "http://www.oracle.com/technetwork/products/berkeleydb/downloads/index-082944.html", "http://download.oracle.com/otn/berkeley-db/(?P<name>db-)(?P<pver>((\d+[\.\-_]*)+))\.tar\.gz")
-            : "6.1.19",
+        ("db", "http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz", "http://ftp.debian.org/debian/pool/main/d/db5.3/", "(?P<name>db5\.3_)(?P<pver>\d+(\.\d+)+).+\.orig\.tar\.xz")
+            : "5.3.10",
     }
 
     @skipIfNoNetwork()
-- 
2.7.4


