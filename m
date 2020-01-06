Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
	[209.85.214.169])
	by mail.openembedded.org (Postfix) with ESMTP id 944D77FDF7
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:08 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id f20so22042411plj.5
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=2PQFLTpft4I4RHmYaiSVuS4s4wdizbv7+pRw3yKbcHg=;
	b=rektrahXSFKcZvld7pFPOSeNjj1y/LcZ2qcUohF4kXwvuWCQ851OhVMBHdhvoUKq2i
	fFcxx41gh+k/Cbd7vpgZk0zReSkUzwqte5s+yI15qQPtfxBhxJ4wGR28XkxeELtiGhbe
	XIJvl5kOoIpMOXpA0HYYbco0ayplgECohojuJADTZHnJ0N56ECI4f271aHlmpcmZKwVD
	thhkK81NF4LwUsAQnIRXiibTRQ0jssJR7gb1yspfyLxJiYxHW5NOoCbfvQJOVaOaSDYJ
	ndhnz9yHuUdrccr8JIwjA00S9eaGzc+TI6Fn1GMyf0UpKux7XtaFTevswD9SPhoh9ZQ+
	cy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2PQFLTpft4I4RHmYaiSVuS4s4wdizbv7+pRw3yKbcHg=;
	b=RcjJT8HbzJwG1dZ5AYODB2loHSojuO22HvavNPlZ5l30vXd16qLNcSEqlIertZyWPe
	Yz7wfh9ylMpKPfAiJQnBezUsrtS997dhbCAn45qGFtGoeatWmzcOxZ5+pj+7Qi8pivpS
	OPTnakpGh+CMJVxx61GnJoQfN67OkreC4hIay5KJV0hnT8o1LADE8SguSkZHNzC4B7za
	As8dfpTyjhDJCPHXJPHiM9Px/lMMKJ1NYe8bOZ6RI2tDKthKN/pw4J27oRqja6VeyGcs
	vfEaEgQbQeT4nomVhOcnzoxizY3IOz/OpKNaaE+OhDuUiQEuK40zv5Hguwn2D6Bza6Sh
	D4FQ==
X-Gm-Message-State: APjAAAXfuOss2WkQhcTXVr4mP7EtiNT4Bp+8LDGsclr9V5CoEE3at9mX
	26mCTNXPZZ2d+O1yQsURulToWYEN
X-Google-Smtp-Source: APXvYqwtszOllkE9zlvM0eM8sQvAyi2vOe34gu0fU9OkTieR+xdj0VbDVeLFW1I7cQ09aJk8kdmQHA==
X-Received: by 2002:a17:90a:31cc:: with SMTP id
	j12mr42829748pjf.103.1578328029521; 
	Mon, 06 Jan 2020 08:27:09 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.08
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:09 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:40 -0800
Message-Id: <4c7d689341f471efdf8ab7c2a7c6a19d2d370f5c.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
MIME-Version: 1.0
Subject: [1.44 19/25] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:08 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aníbal Limón <anibal.limon@linaro.org>

The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a list
of directories to exclude when making taskhash, our specific case
is using SRC_URI that points local VCS directory.

Use bb.fetch.module to set default to: "CVS .bzr .git .hg .osc .p4 .repo .svn"

Signed-off-by: Aníbal Limón <anibal.limon@linaro.org>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 923aff060d8aba8456979c35b16d300ba7c13ff9)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/checksum.py        | 5 +++--
 lib/bb/fetch2/__init__.py | 4 ++--
 lib/bb/siggen.py          | 5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 5bc8a8fc..677020f4 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -74,7 +74,7 @@ class FileChecksumCache(MultiProcessCache):
             else:
                 dest[0][h] = source[0][h]
 
-    def get_checksums(self, filelist, pn):
+    def get_checksums(self, filelist, pn, localdirsexclude):
         """Get checksums for a list of files"""
 
         def checksum_file(f):
@@ -90,7 +90,8 @@ class FileChecksumCache(MultiProcessCache):
             if pth == "/":
                 bb.fatal("Refusing to checksum /")
             dirchecksums = []
-            for root, dirs, files in os.walk(pth):
+            for root, dirs, files in os.walk(pth, topdown=True):
+                [dirs.remove(d) for d in list(dirs) if d in localdirsexclude]
                 for name in files:
                     fullpth = os.path.join(root, name)
                     checksum = checksum_file(fullpth)
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 07de6c26..731c1608 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1197,14 +1197,14 @@ def get_checksum_file_list(d):
 
     return " ".join(filelist)
 
-def get_file_checksums(filelist, pn):
+def get_file_checksums(filelist, pn, localdirsexclude):
     """Get a list of the checksums for a list of local files
 
     Returns the checksums for a list of local files, caching the results as
     it proceeds
 
     """
-    return _checksum_cache.get_checksums(filelist, pn)
+    return _checksum_cache.get_checksums(filelist, pn, localdirsexclude)
 
 
 class FetchData(object):
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index e484e5e3..f982bf22 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -126,6 +126,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         self.unihash_cache = bb.cache.SimpleCache("1")
         self.unitaskhashes = self.unihash_cache.init_cache(data, "bb_unihashes.dat", {})
+        self.localdirsexclude = (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE") or "CVS .bzr .git .hg .osc .p4 .repo .svn").split()
 
     def init_rundepcheck(self, data):
         self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST") or None
@@ -222,9 +223,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         if task in dataCache.file_checksums[fn]:
             if self.checksum_cache:
-                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename)
+                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
             else:
-                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
+                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
             for (f,cs) in checksums:
                 self.file_checksum_values[tid].append((f,cs))
 
-- 
2.17.1


