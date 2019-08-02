Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
	[209.85.128.42])
	by mail.openembedded.org (Postfix) with ESMTP id 66D1D7F338
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:20:54 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id u25so56353533wmc.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=tAFWeVx4UMu1HUoB/rr9Ee5dJdlaTmO+8n8e4fza2y8=;
	b=EEJA2R1A3U9+GbpKG4I6HLnkcmpHc1VxrHYEF8QCy8YboYI/7BCmeyunbzmcwh4cbI
	gZ2JdYHNOOuKChN8JVh0YqMQwu1MvR3tBQa46IwQKt9QZ+dzf8oNlkqbRRBP4FH9VUeB
	4M8RZTA15kZirm93BqdU/0e4PM8mfZXU64m9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=tAFWeVx4UMu1HUoB/rr9Ee5dJdlaTmO+8n8e4fza2y8=;
	b=KV4A5anja0n/5OLi4TQilR+fXBh8DFNRulP0yBzyYqvVlTtMZXTWNSdvcyQ2HpfO6D
	4fXgkwbIiHgXQ1ot2JIjT7e5K0VmLMDPcXm4BJho1qOuAWUdmt9gVMH0yx23d3xYzMst
	YQNPqY/K72GLBIIeENE2nBreioKQnN1PCwagv2/cZyObT9iHv9sCJ60Oj9oocEZmfH3e
	bt7RvDKR1a1KF+nQBIQQvNuRWqqTHILKEOWpOWs1GSgE4tljTWQEvN8c70ahDVuSoaKA
	VH00UcWq33VlJZ/0IYxiPNx5CHRxMR1v75Ft9/yqQrQc5JQKYsi7xvPYeDOHC2J4j2n4
	/BOQ==
X-Gm-Message-State: APjAAAXiB7s/2mUdQ0x3HHw6NnC1LhcEJifqJ07odBHfIusCiKYvwbgv
	Bp79WBecaDpZGZZ10nlnK2FgjWC4YzY=
X-Google-Smtp-Source: APXvYqzmUvRIneOpp+tRfq0fz1NT4Ydkr8Ip4COK0gS0VVDvtgeE9VbmTOWBMDcncd95UYv8RfM52Q==
X-Received: by 2002:a05:600c:2102:: with SMTP id
	u2mr5071664wml.105.1564759254829; 
	Fri, 02 Aug 2019 08:20:54 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.20.53
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:20:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:38 +0100
Message-Id: <20190802152049.16529-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 05/16] siggen: Convert to use self.unitaskhashes
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

Rather than metadata driven sqlite databases for communication, use
bitbake's unitaskhashes variable instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 2bb0b68527..368209807f 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -388,12 +388,15 @@ class SignatureGeneratorUniHashMixIn(object):
             # If a unique hash is reported, use it as the stampfile hash. This
             # ensures that if a task won't be re-run if the taskhash changes,
             # but it would result in the same output hash
-            unihash = self.unihashes.get(self.__get_task_unihash_key(task))
+            unihash = self.unitaskhashes.get(self.__get_task_unihash_key(task), None)
             if unihash is not None:
                 return unihash
 
         return super().get_stampfile_hash(task)
 
+    def set_unihash(self, task, unihash):
+        self.unitaskhashes[self.__get_task_unihash_key(task)] = unihash
+
     def get_unihash(self, task):
         import urllib
         import json
@@ -404,7 +407,7 @@ class SignatureGeneratorUniHashMixIn(object):
 
         # TODO: This cache can grow unbounded. It probably only needs to keep
         # for each task
-        unihash = self.unihashes.get(key)
+        unihash = self.unitaskhashes.get(key, None)
         if unihash is not None:
             return unihash
 
@@ -446,7 +449,7 @@ class SignatureGeneratorUniHashMixIn(object):
         except (KeyError, json.JSONDecodeError) as e:
             bb.warn('Poorly formatted response from %s: %s' % (self.server, str(e)))
 
-        self.unihashes[key] = unihash
+        self.unitaskhashes[key] = unihash
         return unihash
 
     def report_unihash(self, path, task, d):
@@ -464,7 +467,7 @@ class SignatureGeneratorUniHashMixIn(object):
         key = fn + '.do_' + task + ':' + taskhash
 
         # Sanity checks
-        cache_unihash = self.unihashes.get(key)
+        cache_unihash = self.unitaskhashes.get(key, None)
         if cache_unihash is None:
             bb.fatal('%s not in unihash cache. Please report this error' % key)
 
@@ -515,6 +518,7 @@ class SignatureGeneratorUniHashMixIn(object):
 
                 if new_unihash != unihash:
                     bb.debug(1, 'Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
+                    bb.event.fire(bb.runqueue.taskUniHashUpdate(fn + ':do_' + task, new_unihash), d)
                 else:
                     bb.debug(1, 'Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
             except urllib.error.URLError as e:
-- 
2.20.1


