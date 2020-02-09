Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
	[209.85.216.46])
	by mail.openembedded.org (Postfix) with ESMTP id 103FF60EE7
	for <bitbake-devel@openembedded.org>;
	Sun,  9 Feb 2020 16:03:22 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id fa20so3085628pjb.1
	for <bitbake-devel@openembedded.org>;
	Sun, 09 Feb 2020 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=+MqGZa44oQbtSn48tFkBY0WfDRd7kwaeAtVGlLyUlAA=;
	b=a70PctG/hNXPujsB7ohL82yZrMlSBh3JeVlIRuJ9Nx8h28Ooh39OlCj6KHow/JHdKn
	c7YRbzN77/N6iPKKKrkII/QILVo47s520u7Xj0h/qHKQ6qKcWZFhyEUKzRESe7mbsd1J
	k8OjPPEyuRNkVHCJF16oxyY9Ex3aXyqMNNWQ3a0wfLACAHxTjhuSqj8iHf+8TOPEihQq
	HNhrwc8bvw3EWizi5WBb8WPCTQZ0A7/ZWjyW0y2+cZFVm/lkfBmepqu+hVNuCrwi0PFx
	s6cEJNAKCdo/4/pS6f9uvklpl4yy3Tn1pB6JFcz2FIFP1Ze+b6FFONwwPRCWT45vPEQB
	7grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=+MqGZa44oQbtSn48tFkBY0WfDRd7kwaeAtVGlLyUlAA=;
	b=IKE53pEusqQt903D31dNq1HUFBAVjQXlZmSAX61xdAjHL0RMc7SHleCBJqYCLMhzvF
	N03yZDJ4u9i43rwWF3ziNAMp0SWP5JBNcDGZG74vZ2dENE4QCPftaynrwOjGcIEVm7tp
	z3h8slIpnHNFf2kuerDyXPZf26M6Ffog+DdkLtX3Qr/wrwQW1jW3xO5sj93vC5ZDsY3g
	XAVPwvJmcOiHnEsPwAbN193nv7lD44KQamSRx6y082TmlJt3qtGUgSEFpWDpPmdf64b+
	lVFJD9aJm2TcB/yd1pyOVP0AW963PXh+JW/QDTnYieE8OQTskLuA88PbLIb+JJOOiZTi
	zBLg==
X-Gm-Message-State: APjAAAUR0R355MW6SSDUiNAFtBg7q/StpXAPwRrWfeUB61TvC/svVkhO
	kChkAfab6xZHcRqtR17QnqOdDpjK
X-Google-Smtp-Source: APXvYqxqSLXinJD/LEK6RfoIufw2Pt5xz55NWd6fzZ3kj2Mk5RTQcBHCn1VLLj3zUIeLSvtKUzM9vQ==
X-Received: by 2002:a17:90a:b318:: with SMTP id
	d24mr16639807pjr.142.1581264203892; 
	Sun, 09 Feb 2020 08:03:23 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:154b:3780:5122:4aa9])
	by smtp.gmail.com with ESMTPSA id d3sm8529353pjx.10.2020.02.09.08.03.23
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 09 Feb 2020 08:03:23 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sun,  9 Feb 2020 08:03:14 -0800
Message-Id: <1f5a662176fd174c4793e3e28d1b4e95616b1715.1581264053.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1581264053.git.akuster808@gmail.com>
References: <cover.1581264053.git.akuster808@gmail.com>
Subject: [1.44 6/7] siggen: Cache unihash values to avoid cache lookup
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
X-List-Received-Date: Sun, 09 Feb 2020 16:03:23 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Add unihash cache of values to speed up cache lookup.

This avoids the overhead of the disk based check functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 5c9cc45b60904a1c355db9bf9c4495f1b25aca37)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/siggen.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 209a3428..96807c46 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -40,6 +40,7 @@ class SignatureGenerator(object):
     def __init__(self, data):
         self.basehash = {}
         self.taskhash = {}
+        self.unihash = {}
         self.runtaskdeps = {}
         self.file_checksum_values = {}
         self.taints = {}
@@ -80,19 +81,19 @@ class SignatureGenerator(object):
         return
 
     def get_taskdata(self):
-        return (self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.tidtopn, self.setscenetasks)
+        return (self.runtaskdeps, self.taskhash, self.unihash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.tidtopn, self.setscenetasks)
 
     def set_taskdata(self, data):
-        self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.tidtopn, self.setscenetasks = data
+        self.runtaskdeps, self.taskhash, self.unihash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.tidtopn, self.setscenetasks = data
 
     def reset(self, data):
         self.__init__(data)
 
     def get_taskhashes(self):
-        return self.taskhash, self.unitaskhashes, self.tidtopn
+        return self.taskhash, self.unihash, self.unitaskhashes, self.tidtopn
 
     def set_taskhashes(self, hashes):
-        self.taskhash, self.unitaskhashes, self.tidtopn = hashes
+        self.taskhash, self.unihash, self.unitaskhashes, self.tidtopn = hashes
 
     def save_unitaskhashes(self):
         return
@@ -108,6 +109,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
     def __init__(self, data):
         self.basehash = {}
         self.taskhash = {}
+        self.unihash = {}
         self.taskdeps = {}
         self.runtaskdeps = {}
         self.file_checksum_values = {}
@@ -256,7 +258,13 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         data = self.basehash[tid]
         for dep in self.runtaskdeps[tid]:
-            data = data + self.get_unihash(dep)
+            if dep in self.unihash:
+                if self.unihash[dep] is None:
+                    data = data + self.taskhash[dep]
+                else:
+                    data = data + self.unihash[dep]
+            else:
+                data = data + self.get_unihash(dep)
 
         for (f, cs) in self.file_checksum_values[tid]:
             if cs:
@@ -427,6 +435,7 @@ class SignatureGeneratorUniHashMixIn(object):
         (mc, fn, taskname, taskfn) = bb.runqueue.split_tid_mcfn(tid)
         key = mc + ":" + self.tidtopn[tid] + ":" + taskname
         self.unitaskhashes[key] = (self.taskhash[tid], unihash)
+        self.unihash[tid] = unihash
 
     def _get_unihash(self, tid, checkkey=None):
         if tid not in self.tidtopn:
@@ -447,12 +456,14 @@ class SignatureGeneratorUniHashMixIn(object):
 
         # If its not a setscene task we can return
         if self.setscenetasks and tid not in self.setscenetasks:
+            self.unihash[tid] = None
             return taskhash
 
         # TODO: This cache can grow unbounded. It probably only needs to keep
         # for each task
         unihash =  self._get_unihash(tid)
         if unihash is not None:
+            self.unihash[tid] = unihash
             return unihash
 
         # In the absence of being able to discover a unique hash from the
@@ -487,6 +498,7 @@ class SignatureGeneratorUniHashMixIn(object):
             bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
 
         self.set_unihash(tid, unihash)
+        self.unihash[tid] = unihash
         return unihash
 
     def report_unihash(self, path, task, d):
-- 
2.17.1


