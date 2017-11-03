Return-Path: <ross.burton@intel.com>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
	[209.85.128.194])
	by mail.openembedded.org (Postfix) with ESMTP id EE54678330
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Nov 2017 11:52:51 +0000 (UTC)
Received: by mail-wr0-f194.google.com with SMTP id k62so2273190wrc.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Nov 2017 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=MlrpG4bP4YWmIEATTlUBTPdZiLiDPsAwHTwgtNNYlFM=;
	b=J90XryjotxMl8Rczdl5c4vEfpYZjx/4SL6M5jOwjlTRdVPkM2PK8VvAzQBNWDqV8G6
	GpGVncPJFgksmiSyRGSH9rAtUyaGm9rplMf/IlMNLNDENx8k6/FIoshJEDhW+DwFZT3n
	8xP3JDmrFvr+UY5A71cJLs908/RorWXofIHMES9Cx7oc6tGl+n/yQbkkacN4z9igya/B
	vZk0ReZWw4uCEZ1dU8EpDfWLBLjd9Yy0bGvuJU1oa8mq5zEQiiCOXgOM4Ji0nlN93Ohj
	Gwj5Fbk9ZoFEYSrI4LDaOJcE+wr8c9E5tBIlbuUMv5coNGMEg87HTL8INE8xppjlwqHZ
	Iomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=MlrpG4bP4YWmIEATTlUBTPdZiLiDPsAwHTwgtNNYlFM=;
	b=YBb9WSMpns0GTWyImPZQTt/MH/poP/cr4Cvw/ubvBRCNiDoI4n1rz4hpiqCgzqFays
	fwtM0Owznl4xlnI67Q6dkm6CyB1W/qjH/PNClEkhz98gsShJMvRdhjbni97vfSoMD3U3
	EjzAzdy+sS3+vA/0PAenRtNktZw8bnTobWP0ElicUqbM9BcBmdrdrZXWybFD08c+kw67
	sxPh3NKtkXiNgqUsAeYG0vASV+WN6LT2pbRHFLbri/zwgcDn/j27awM3ZScN2YkvgtAF
	Z4d1XLxeevGp6BnU5r6nctjt0ZjMjml5hvR0kSP5Ac6WSKfcZBBGurdjKR8epZii+bXx
	tUIA==
X-Gm-Message-State: AMCzsaUBYx2IPSYtHcDef2t4FI+mOToGlTdzEvl3vobIveHcxbfUaahO
	EXLvrWdY47oWAbcJTCqy84JFSImI
X-Google-Smtp-Source: ABhQp+S60TeQCvG3YJpVgvseVnBfZCmzOfNNbpQK1bsZOExv3ZXtVjJn0JqN981q0OClHIDo2OJkUg==
X-Received: by 10.223.176.115 with SMTP id g48mr6295571wra.177.1509709972435; 
	Fri, 03 Nov 2017 04:52:52 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id w4sm5558009wrc.17.2017.11.03.04.52.51
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 Nov 2017 04:52:51 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Nov 2017 11:52:44 +0000
Message-Id: <20171103115244.19504-2-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171103115244.19504-1-ross.burton@intel.com>
References: <20171103115244.19504-1-ross.burton@intel.com>
Subject: [PATCH 2/2] tests/fetch: use subtests in the wget tests
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
X-List-Received-Date: Fri, 03 Nov 2017 11:52:52 -0000

As we test multiple URLs in this these tests and one failing abandons the test,
use subtests so all URLs are tested. This should help us identify patterns in
the failing URLs.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/tests/fetch.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 154bf1779be..4952d51fedb 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -848,10 +848,11 @@ class FetchCheckStatusTest(FetcherTest):
     def test_wget_checkstatus(self):
         fetch = bb.fetch2.Fetch(self.test_wget_uris, self.d)
         for u in self.test_wget_uris:
-            ud = fetch.ud[u]
-            m = ud.method
-            ret = m.checkstatus(fetch, ud, self.d)
-            self.assertTrue(ret, msg="URI %s, can't check status" % (u))
+            with self.subTest(url=u):
+                ud = fetch.ud[u]
+                m = ud.method
+                ret = m.checkstatus(fetch, ud, self.d)
+                self.assertTrue(ret, msg="URI %s, can't check status" % (u))
 
     @skipIfNoNetwork()
     def test_wget_checkstatus_connection_cache(self):
@@ -862,10 +863,11 @@ class FetchCheckStatusTest(FetcherTest):
                     connection_cache = connection_cache)
 
         for u in self.test_wget_uris:
-            ud = fetch.ud[u]
-            m = ud.method
-            ret = m.checkstatus(fetch, ud, self.d)
-            self.assertTrue(ret, msg="URI %s, can't check status" % (u))
+            with self.subTest(url=u):
+                ud = fetch.ud[u]
+                m = ud.method
+                ret = m.checkstatus(fetch, ud, self.d)
+                self.assertTrue(ret, msg="URI %s, can't check status" % (u))
 
         connection_cache.close_connections()
 
-- 
2.11.0


