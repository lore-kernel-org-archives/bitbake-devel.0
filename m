Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id 1867365CC7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Nov 2017 11:09:21 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id y80so2876121wmd.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Nov 2017 03:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=0OkKokS0GhDc4wQUKQ5MmU1h4zVO+qTxG8IvpCjXR8Y=;
	b=TU1fmQqnhJizSjJ36YZkOGMDm+XgHoL6FKydkp/A3FCEoXA6yvhbA1D5+JzCt0JVcu
	4s7acEonTAn61eSKhQLwt+L8zeFRhINtjiQdGpM5eFDrLSxMIHXjqCtryLcy3AdfhQ8q
	dyDrWlD6oPUxewo/nPj1H7aep0s/cdY870YQOBWC1tDYn1q2etziFQllKy41YjbQ/i5T
	r4C8i1SF2YIBRMeBQ6l2t+q4duMdJmdTvUv7ZnqKSfgEPvSAOEukRA5dZm3Eve7lJlzx
	DV2PQbPO6L4tqcL3tL+LnhBStszqKIUrxCjtXmGGZc31umiWtvMWf4Bj09oaB0u27DI6
	U94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=0OkKokS0GhDc4wQUKQ5MmU1h4zVO+qTxG8IvpCjXR8Y=;
	b=fzjRwwTQu3MYKq7gz6LtByYFFBeDZhloGUm1L8FajFt/qfCl3DDCiJd7L0IdBa+M5I
	gJaKNnWxFbcS+fIZJ1u8K1Eu9wCp4iCClAJWV4gyg78Sa+meQCawhpDslh/T675s0jjS
	qAO1G3h5Q4BOUE3Q+TRTlHbJL0N1IV2BkM8TrEsyYYsaqAQJDpQ+kKKXYmrKWJ24iQgG
	gGC4+ILc3Q2O5ZS/fybFA+RFMOFcBsk5NxJNO+gCK8prRDwhJEU4aKi+jWDAfCZrwCSS
	0MjnzgX9bzEyS0YQeECGg0c7X/EL+jqcKzg4PyEdzyUFoaybTG2H0dYjaJapdlQf1Rqm
	WcZA==
X-Gm-Message-State: AJaThX6LOXD1OpBA2h3x1EHdfYOFpu819Imal4vgtCPQkLMyPNX7zTpo
	Z15jl3UqBfZSQT1lY1x5m7OupL65
X-Google-Smtp-Source: ABhQp+RqMPP2RMX1/OjKrjQvuiYrAQaShTBtpwbxQduf8WgdXeIlWfJ9WGd21tT3XKrJygGTbn1ifw==
X-Received: by 10.28.175.73 with SMTP id y70mr1227002wme.21.1510052962519;
	Tue, 07 Nov 2017 03:09:22 -0800 (PST)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	143sm2737743wmj.35.2017.11.07.03.09.21
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 Nov 2017 03:09:21 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Nov 2017 11:09:19 +0000
Message-Id: <20171107110919.9680-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] tests/fetch: use subtests in the wget tests
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
X-List-Received-Date: Tue, 07 Nov 2017 11:09:22 -0000

As we test multiple URLs in this these tests and one failing abandons the test,
use subtests so all URLs are tested. This should help us identify patterns in
the failing URLs.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/tests/fetch.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index f1799a7eff3..b07bf00470f 100644
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


