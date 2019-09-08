Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail.openembedded.org (Postfix) with ESMTP id 32DDE7F27C
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  8 Sep 2019 19:27:44 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id n9so6536979pgc.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 08 Sep 2019 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=yO2dyYWxPRAotHe4L4EbZ5/zuOmNuLmpUgUAF9gUGq8=;
	b=qPGxd7vsaku2zDmMpY+zHJIVQPy2zImex4BigJEyBaR1oMY6ZWA6NGTF/K7l8cuqVz
	T+iadPPqRwEcE9eTLtKq1X0/fhEQLB2M/jEuzE7YioSS2wCfv58PkmrfSFt1M8O18SWG
	10Qv8AmXzQGxi5kzpc7QvjxLrjoVOIWRS4nBHr1BjHpFAFRRySYqyTpeDIBorOSQ+WVg
	366rdvBljEDRDNk/Gg1CE+6/Tj4BwUMh3+Qs65Flb35KLLN7sjmwzfF4HYpwKOIP2a0X
	p+JsjC/M03ZjlHFmr7NQIEy8bcQZfvzcfmSXvrO7GI6780yy6DebRNDeVuj/O0/nF4TA
	LFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=yO2dyYWxPRAotHe4L4EbZ5/zuOmNuLmpUgUAF9gUGq8=;
	b=l3qCRwreVR+webSV8qlA2GyyQ40s8O+Ja5UHLecR2LO2nRdMH6A36RyDmULg/fbJKP
	mjnoLVdWyeyj3KixiN04N8rCMaxjCNkKh1KfPvUsqSsfvKtPCTW9aKrEohiX6HZfb7v2
	Ta5iTdNTcMFC/9PvwBCuSigVs+itUubrZx5eXERSeAdnkB3Je7hWxJL9F8n1isGT+AeZ
	0FeHp0yx874A2pdNkTnSEVecWNZmcCR9cQAfyr9TUFryS+sdr2Wm5KjeeHLfo2rd7L/2
	W6p/2bg3p6cajkS8Qigtfcv9hlqz433LhSaVZD/tRVIL5ERZ3RPDC7xC0o9Ntq1RmGn7
	q7MA==
X-Gm-Message-State: APjAAAXalngWYeG57HqvLLf/m2hx3NnBDVAf5LGBbt6ntFSrobTvi9wu
	YI4HrCR2ODknLQVm5MQVPGXxpYs6
X-Google-Smtp-Source: APXvYqyjZd9upAxoDq0NtL2vRDUYngZqaPJBBfZZpZJc5nU4XN+DlIA0coY2ksmykQ4fhf6bMIrh8g==
X-Received: by 2002:a65:4b89:: with SMTP id t9mr17892653pgq.55.1567970865154; 
	Sun, 08 Sep 2019 12:27:45 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:1e2:13d2:378e:990e])
	by smtp.gmail.com with ESMTPSA id
	m13sm11917267pgn.57.2019.09.08.12.27.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 08 Sep 2019 12:27:44 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Sep 2019 12:27:43 -0700
Message-Id: <1567970863-12122-1-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [1.40][PATCH] tests/fetch: Resolve fetch error in bitbake-selftest
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
X-List-Received-Date: Sun, 08 Sep 2019 19:27:44 -0000

FAIL: test_wget_latest_versionstring (bb.tests.fetch.FetchLatestVersionTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest/build/bitbake/lib/bb/tests/fetch.py", line 1229, in test_wget_latest_versionstring
      self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
      AssertionError: '' is not true : Could not find upstream version for db

[YOCTO #13496]

The Oracle UPSTREAM_CHECK_URI used changed and does not work with logic in wget.

Update UPSTREAM_CHECK_URI and UPSTREAM_CHECK_REGEX to match the ones used in the
recipe. Also change the version being checked.

Signed-off-by: Armin Kuster <akuster808@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/tests/fetch.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 9c71207..57376c4 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1128,8 +1128,8 @@ class FetchLatestVersionTest(FetcherTest):
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


