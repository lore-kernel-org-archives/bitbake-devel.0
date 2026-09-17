Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DD0C982DA
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 22:17:20 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1753.1789683435901046119
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 15:17:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=bebRQVO8;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so1547645e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789683434; x=1790288234; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yqd3a15kABHbux1buscXySsv8YdsMYpxBdV+ZMbux7A=;
        b=bebRQVO8L5sXJXmA8BKb8l+Age+YE/J5BoLDH/pVOtk60wGJ0APRN+p9KOF6urtJrn
         UezZ6uHipL9V2VRAWcaCmYFjXORTT11OTRz15pzuyWRqk4zuKD+CoZ57STZT944fTd7Y
         f6kNP+ASkPrkZFmDUizttxlvj6gP3jNalnNaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683434; x=1790288234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yqd3a15kABHbux1buscXySsv8YdsMYpxBdV+ZMbux7A=;
        b=Y4zdaXY2NBiSF1uVQYa1kLHZZVHUkC7p+waCI4JA9vTmTKSuh7yp42/VAPhTkfTXqE
         4rgfpteF+g8tvNAaGwSHsSf24GPXK+s9bmWOUmeFUYrP5oQreBCRuUU5QZ7eoykvdpu9
         ziNZJfUXRou4TeKqtHZV7V7cGmxmtqHr1NqK7lG6SX3SPHN4XVU1srTdA9raOEvQE9uX
         xB2Rzgvi88rG1NY1HKb+a5a9gW0jyZfoFkhpM6h6rha+VnT7n48/FMB4EUi5pHOoGelf
         dwCkNbxiUs2GQyxao8Y4HUVjf0+X+hFNniY5ssaMjLl2E1slHjL4V4s8t0yzpRrbnCEY
         +O0g==
X-Gm-Message-State: AFuF++kPXtg7oSv0ahPjKRO0EdiDzEQByfwAIn8uK5gytaz1mX6ug/48
	LfDXTH+Fq9U2uiTBwNrIxRthkrUd8KQG3ROf9VtOE4ZyHGGATxoM4339an91iK8nhoNDZgnH0bX
	bgSeE9Bk=
X-Gm-Gg: AYBFou0GQp+VUdDALzirLbgzYffMP01RvCfTds2pqhXmp5xQ69XqhvK/9uGPblmFgv8
	A27bB+p5Aebq3rkKDcFZbMkCz7coyD4mJdW1zhZLhS5rWsQPcUyNA6KnsdvrPxtlClayupIrGal
	5ZDmpQs6DQ0ZPXpO+nMgt/zjIh8UAkyNGAoEnUFNN/QWCoO1xSijDRLh2pPd9zlgEi9UdqtvafX
	0onzYIuKAw1iuUj75eImKcqZMq028yoGOb/qFP4m982TQzKECqh4gSd2l37ubznhDnZFJFfN3eC
	JxGiRBy9gGNr0XMB7MZdfaxl864vE1M8/5jC3iPJxs0fcN6gUg2KNk8hBj7WFD6orjI1nRzoqYY
	sdCarUgpd+4NkFvvYJQy5/IwgIZE5HsWsfofqiSyw9SI3VEoH1DRZTJkcqNIAXjYry2C0iWTjgO
	sY8m98s9jLqpzuuU6Osjm9CJ/LnAujqVhcU7SuovBlHHMvbKiX+utINf2QKcP9/rEK2kzZYSx94
	IU3cUeZk+Ck9OlEQtqvWmDig4pNrCezGmmXMAnOX8BucGcmThIBwiOmWbfwIfTCWZHrwBYzo1Q=
X-Received: by 2002:a05:600c:8b81:b0:49d:15f8:2bdb with SMTP id 5b1f17b1804b1-49fc568125bmr3188645e9.7.1789683434063;
        Thu, 17 Sep 2026 15:17:14 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm185737725e9.11.2026.09.17.15.17.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:17:13 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 5/7] bb/tests/fetch.py: add case for filter_regex parameter in latest_versionstring
Date: Fri, 18 Sep 2026 00:17:03 +0200
Message-ID: <b64c79236f96baa412d3cd06b30cdf9e369901d0.1789683244.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789683244.git.yoann.congal@smile.fr>
References: <cover.1789683244.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 22:17:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20228

From: Chen Qi <Qi.Chen@windriver.com>

Add bitbake selftest case for fitler_regex parameter in
latest_versionstring to ensure no regression.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 63a51b543e17d44c26a82e6ca911ed23e517fc33)
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 78 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 137505343..c72e4c4e3 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1577,7 +1577,24 @@ class FetchLatestVersionTest(FetcherTest):
         # basic example; version pattern "A.B.C+cargo-D.E.F"
         ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69")
             : "0.9.29"
-   }
+    }
+
+    test_git_stable_uris = {
+        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master;protocol=https", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "", r"^1\.4\.\d+$")
+            : ("1.4.0", "1.5.0"),
+        ("systemd", "git://github.com/systemd/systemd.git;protocol=https;branch=stable/v259-stable", "b3d8fc43e9cb531d958c17ef2cd93b374bc14e8a", "", r"^259\.\d+$")
+            : ("259.5", "260")
+    }
+
+    test_wget_stable_uris = {
+        ("openssh", "https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.2p1.tar.gz", "10.2p1", "", "", r"^10\.2p\d+$")
+            : ("10.2p1", "10.3")
+    }
+
+    test_crate_stable_uris = {
+        ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69", r"^0\.9\.\d+")
+            : ("0.9.29", "0.10.0")
+    }
 
     @skipIfNoNetwork()
     def test_git_latest_versionstring(self):
@@ -1634,6 +1651,65 @@ class FetchLatestVersionTest(FetcherTest):
                 r = bb.utils.vercmp_string(v, verstring)
                 self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
+    @skipIfNoNetwork()
+    def test_git_latest_versionstring_stable(self):
+        for k, v in self.test_git_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                self.d.setVar("SRCREV", k[2])
+                self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
+                filter_regex = k[4]
+                ud = bb.fetch2.FetchData(k[1], self.d)
+                pupver= ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
+    @skipIfNoNetwork()
+    def test_wget_latest_versionstring_stable(self):
+        for k, v in self.test_wget_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                url = k[1]
+                self.d.setVar("PV", k[2])
+                if k[3]:
+                    self.d.setVar("UPSTREAM_CHECK_URI", k[3])
+                if k[4]:
+                    self.d.setVar("UPSTREAM_CHECK_REGEX", k[4])
+                filter_regex = k[5]
+                ud = bb.fetch2.FetchData(url, self.d)
+                pupver= ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
+    @skipIfNoNetwork()
+    def test_crate_latest_versionstring_stable(self):
+        for k, v in self.test_crate_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                ud = bb.fetch2.FetchData(k[1], self.d)
+                filter_regex = k[2]
+                pupver = ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris = ["https://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
                       "https://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",

