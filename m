Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by mail.openembedded.org (Postfix) with ESMTP id 4CBB17F27C
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  8 Sep 2019 19:23:59 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id y72so7771895pfb.12
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 08 Sep 2019 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=OeXDrW/j4UDhus3vwFlPJvyuG8AIwlzeA7m1i1/DyY0=;
	b=AAiotq/DTnYgWf5+2kgeOO/JY5FudTHA8YBDiQf9ffZZTGRIYLY9YV5u0NEMxMOMBj
	tbUMNCIMfCbUTVLOzsurqMXrwLDfPg2rSdxEQRgVsTrwDRGj3T+zqEZ9tNfRMwSddZwt
	PEQkGjm3x5/RuMcqVxvihXbYlfi7d8WQtNaYBUZcd5sPlN/b0D7yOnRb+V7XEXolyn3M
	emrvomCdHY1MnT69Tl1LZolbW75QN2SYpJFXcFzLh3KfzDTReeLZOnh1tVbleAAnKNZo
	DGz+ZfQGZkS7DzCM2j0H08mgM9zBvp9L6g28zue/TfqgCn2PcsCBNOD1nkqzFPL3teKi
	3ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=OeXDrW/j4UDhus3vwFlPJvyuG8AIwlzeA7m1i1/DyY0=;
	b=a892JxHgh/IZbdcGg0igglqNTJdASzmLdCPDwTH7nYtck6W+M+2VndZbqqAgrOu7Uy
	mBFlkW1VctaHM0SIcv6uswafKiHq4T+29lh+NmWYK/8phdj2Vn3zUq9BHvlZRfaW9Q3c
	6jbtSNd0kKPU6gtfCh5S/+CbSXTm6koxOmQX7Z6qWxfaxs3IeZHZokZu2+17bUHSQaFy
	FL+6sUM+tjLKScDY/tW536wG1ENErjw/kCLLUtDlcMRYNpCl3XQLxD6sybQb++YGwMw1
	IYwod3Axobgys+cpRUO34YmnpgFiefkYs4QTrojTId3+x2LDhXEI4rDwxlsTpJB22Yhy
	TxYA==
X-Gm-Message-State: APjAAAXYIMuXDg7swYQ5q1JbNXSvH/ihLaaqjxSYc7u/yvbaAtK+ViOv
	sfLdH9ntG6npJdaRbsyd9+JWGXVs
X-Google-Smtp-Source: APXvYqwXPuzexxA6bvBJ3gklSNJwjSa34uugiHfZ7Ez61xWcbEoqk/TJSyoMU9wf5vvJ0Btowgb2BQ==
X-Received: by 2002:a63:181:: with SMTP id 123mr5739978pgb.63.1567970640059;
	Sun, 08 Sep 2019 12:24:00 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:1e2:13d2:378e:990e])
	by smtp.gmail.com with ESMTPSA id
	r18sm11776211pfc.3.2019.09.08.12.23.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 08 Sep 2019 12:23:59 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Sep 2019 12:23:58 -0700
Message-Id: <1567970638-11732-1-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [1.42][PATCH] tests/fetch: Resolve fetch error in bitbake-selftest
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
X-List-Received-Date: Sun, 08 Sep 2019 19:23:59 -0000

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
index 9fca98e..32db5c3 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1117,8 +1117,8 @@ class FetchLatestVersionTest(FetcherTest):
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


