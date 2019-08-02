Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
	[209.85.128.52])
	by mail.openembedded.org (Postfix) with ESMTP id 862C27F318
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:20:53 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id w9so1694533wmd.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Af+tTHZ0vNcZZPcG4sU83zTiPrNDw9RLglRG0xMK9iU=;
	b=YYb/kennSlh6WkcdS0v5PbPn4508xtI2tsgdSUvJNiVPJf4dei1jb2C0Zn6r9liwqr
	M3kEb4a2q7JyTRsoSkazz7eG6eO3v0ACbNlNoqj7cacnva68bitwj7OImSPJznKXTX7J
	kmpKnjAFqOIJMxl+bhAlEqJ0TLHaG9Bhzq7a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Af+tTHZ0vNcZZPcG4sU83zTiPrNDw9RLglRG0xMK9iU=;
	b=GfLxIkyOcgr1011eGJtOXVThMxa6eb/qhELFku9VNq/2/CcZ79MUS+BodWnN8Dcr78
	abU6lkeK2IFlvwxbE0Xwt1rp0C4Tvx8SPs5BiEe8EIi5Asne8ygkRSMdrXDFHdstDBfb
	yd0mDUelTaAH+hn3gnZVzxB3wl4DdCnlOlz8dTRfuF0Zd2CkWeRjKQZA0oUu45w0y7sf
	W1rch9YCGlFsCKHDs3YUrNxD3ZNO3aw7Foi+lnmf7P17HhxmaPGGAMK9cTRBeWwki11l
	2mNvjUe67A5Bk7oD/qEzobMFsl+e3sP5/5LA8QzoYPnO+pSbiqjQQed1xUynYvDheQHg
	2Szw==
X-Gm-Message-State: APjAAAUHQQL5qMH3GXEuKRZJNoAiNZNoLN50cyDGw5Wg7VzFLy+JknoN
	2P1ueZLQxqoWfhYtHXvC+C8q+O8xAPA=
X-Google-Smtp-Source: APXvYqxnrbCJ6WPXTkUvREJJK/Z4A1n5OG9UjpKQs+9KfFFX+uZNzHgRpOnPcEe7H456KoX2Bq+E7Q==
X-Received: by 2002:a05:600c:224d:: with SMTP id
	a13mr4862031wmm.62.1564759253885; 
	Fri, 02 Aug 2019 08:20:53 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.20.53
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:20:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:37 +0100
Message-Id: <20190802152049.16529-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 04/16] siggen: Add new unitaskhashes data variable which is cached
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
X-List-Received-Date: Fri, 02 Aug 2019 15:20:54 -0000
Content-Transfer-Encoding: 8bit

We need to preserve unihash task hashes between runs. Use the new SimpleCache
class to create such a class within the signature generator which is loaded
at init time and saved when builds complete. The default is unpopulated but
metadata sig handlers can populate this cache.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py |  1 +
 lib/bb/siggen.py   | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9883a982c2..519561c231 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1516,6 +1516,7 @@ class RunQueue:
             self.dm_event_handler_registered = False
 
         if build_done and self.rqexe:
+            bb.parse.siggen.save_unitaskhashes()
             self.teardown_workers()
             if self.rqexe:
                 if self.rqexe.stats.failed:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 0105fa7251..2bb0b68527 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -41,6 +41,7 @@ class SignatureGenerator(object):
         self.runtaskdeps = {}
         self.file_checksum_values = {}
         self.taints = {}
+        self.unitaskhashes = {}
 
     def finalise(self, fn, d, varient):
         return
@@ -73,14 +74,23 @@ class SignatureGenerator(object):
         return
 
     def get_taskdata(self):
-        return (self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash)
+        return (self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes)
 
     def set_taskdata(self, data):
-        self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash = data
+        self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes = data
 
     def reset(self, data):
         self.__init__(data)
 
+    def get_taskhashes(self):
+        return self.taskhash, self.unitaskhashes
+
+    def set_taskhashes(self, hashes):
+        self.taskhash, self.unitaskhashes = hashes
+
+    def save_unitaskhashes(self):
+        return
+
 
 class SignatureGeneratorBasic(SignatureGenerator):
     """
@@ -107,6 +117,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
         else:
             self.checksum_cache = None
 
+        self.unihash_cache = bb.cache.SimpleCache("1")
+        self.unitaskhashes = self.unihash_cache.init_cache(data, "bb_unihashes.dat", {})
+
     def init_rundepcheck(self, data):
         self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST") or None
         if self.taskwhitelist:
@@ -244,6 +257,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
             bb.fetch2.fetcher_parse_save()
             bb.fetch2.fetcher_parse_done()
 
+    def save_unitaskhashes(self):
+        self.unihash_cache.save(self.unitaskhashes)
+
     def dump_sigtask(self, fn, task, stampbase, runtime):
 
         k = fn + "." + task
-- 
2.20.1


