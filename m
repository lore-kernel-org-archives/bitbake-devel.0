Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail.openembedded.org (Postfix) with ESMTP id A82B260EAD
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  8 Feb 2020 16:01:13 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id g1so5463507wmh.4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 08 Feb 2020 08:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=etzNzsppBqL/fkki1hU3ZPbZdeoRPVcj1LupUuyyu8o=;
	b=YWWVdG5nGWW4Dh3X4EqK3mfmyzwl5WUTCCev3U8ZOXK+WDhgNtjcDKWF9NNVOCnJcT
	PmSiW46VsoikH1wiKSE7uWU6ea0B1IrAhKwmxMHYG/z8yIyZNtvAq7gJL+6e7fDJCZnA
	us2TxyFceOa2u1jvhIzXGk7dl9ZTZe7C/2h6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=etzNzsppBqL/fkki1hU3ZPbZdeoRPVcj1LupUuyyu8o=;
	b=r0UvFpe+axtrkZ/ScXVToQc7FCTKUKTsZxBKksXYGFg/lKplJB5PXaOJYuuNKBLcvA
	exHmTaugLnYsRpLZ3njQQkqhKUuGpLIdExoUCD0HsJmI6wZir1yZPJtfdmdWQSDTmzs8
	Qtaj52X3vG9x5x7BkDM02XkzHjcOzWGNjuKu9X48x1f/p9pMXHwSfl6Qj+ueW7i8zMsb
	lJJ/1eN/UxKr8TYup82XdLT3DPERHCnIf+G1WY9vPtEcwnSXLJCxCIMIvA40tQQ30Qpx
	NwTXoJsn7KcNPIDPLnxTMy0Hy12PUM/0b/HSy2EsUKOqYrV9RnfgoXDOccSZZRBfyyAO
	LjXQ==
X-Gm-Message-State: APjAAAXOiWPG7Jf93DDX7JnsGBuS4+CXd0gChbfJmutujsQ/RzkuTxQJ
	LhSTxY4crdG4+dVxXZ/R8/UUbMeefaI=
X-Google-Smtp-Source: APXvYqwPRnDKpAr69vTxBkmCz/mG+UzdfdBBBxCLbcG/2Ic/0JMJMza14OWAT+zKLB/mbJnX+Kqr6A==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr4774809wme.153.1581177673882; 
	Sat, 08 Feb 2020 08:01:13 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	s23sm2512996wra.15.2020.02.08.08.01.12
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 08 Feb 2020 08:01:13 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  8 Feb 2020 16:01:10 +0000
Message-Id: <20200208160111.13305-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208160111.13305-1-richard.purdie@linuxfoundation.org>
References: <20200208160111.13305-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/3] siggen: Cache unihash values to avoid cache lookup
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
X-List-Received-Date: Sat, 08 Feb 2020 16:01:13 -0000
Content-Transfer-Encoding: 8bit

Add unihash cache of values to speed up cache lookup.

This avoids the overhead of the disk based check functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 209a342883..96807c46cd 100644
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
2.20.1


