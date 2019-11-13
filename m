Return-Path: <anibal.limon@linaro.org>
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
	[209.85.210.47])
	by mail.openembedded.org (Postfix) with ESMTP id 8A0017F838
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 23:23:10 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id c19so3202639otr.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 15:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=tVsL2ADYU+K26snuwkMC4lDKljBCf3wD3K2PiGtosi8=;
	b=iqi6PZmldP8n3BdhvpIg/AtdUR8WV7+kyqt+qR7sHFIAimLicDC5POUtKs2pDtcWXS
	IVbplNMqQXNVyL8XJPKImK8LTMg6Jnyv3f5zgAH8JcZH+XyiqEaYAEW4mjOVev9xvOIf
	Kd/59HDZvbQ06NUAa8REpjS5fxWvTSPfZxK4tpeIQQVhb4/3uKc/iCN/V8fVvzmDAjLe
	+7HwXg0OGXAnupBltbW1yt1wOX0SuN5AwItv5niKlpJK99Pb0lG05bZI25bt6FMcrVig
	CYWSbOqYmNEfYtHQYMIdmn2gLE5Q24CwPCQv55FXzSi/0l0XgFkgsdsH3sThREUivDg3
	Zz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=tVsL2ADYU+K26snuwkMC4lDKljBCf3wD3K2PiGtosi8=;
	b=dhMce+TrcMReyxMB5QPyexFVw/voYrilE/dRseoXBm4LT/6Zbs3MvJ59LDP+XD0In5
	cPmY+BsFrCG/mCSGaIIgMLM3364wlmcspNWS5LX8Gb4J6FPcZIZS6NGRM4zCrknzEeni
	FTJaAQ+4zKLfcGAIPpiorK1DURVLkID53kXsaiQwjbOszFw0hoSmqRjqJfO/N9q5ZWhE
	r4zBMkzWWaFFBfzhev9dGHwuOeXSZ7P++akEklpCkq7DosBYprc+73ph/Kp2RnIsJNCk
	Wzoh4O4H/p3S6CntmnY0ZPY8jrdTSiOlOvZO1+HrynXPHGG1l7iBTEwJDIEiAXPwcJ5A
	+JLA==
X-Gm-Message-State: APjAAAU+q2dxLVYhClIq+TBVgpOph/wn7B7T99F7EdCzggjwl29D2wPr
	vIRNhxMb6yjw9q6Ux/BN2TfM23++LqY=
X-Google-Smtp-Source: APXvYqziyM/v63vzoB8/EOljjD90NokgKxOUiaODHEQgm1bh/Zbad5PAXImQ5IMNpMJBMPv01Lev+Q==
X-Received: by 2002:a9d:351:: with SMTP id 75mr4909844otv.142.1573687391124;
	Wed, 13 Nov 2019 15:23:11 -0800 (PST)
Received: from blackbox.rga.ip ([2806:109f:4:a26c:908a:c7ff:fe6a:e9f5])
	by smtp.gmail.com with ESMTPSA id
	e62sm1192009oif.12.2019.11.13.15.23.09
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 13 Nov 2019 15:23:10 -0800 (PST)
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 13 Nov 2019 17:23:03 -0600
Message-Id: <20191113232303.29047-1-anibal.limon@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Subject: [PATCH] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Wed, 13 Nov 2019 23:23:10 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a list
of directories to exclude when making taskhash, our specific case
is using SRC_URI that points local VCS directory.

In OE-Core this variable could be set by default to:

BB_SIGNATURE_LOCAL_DIRS_EXCLUDE = ".cvs .git .svn"

Signed-off-by: Aníbal Limón <anibal.limon@linaro.org>
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
index a4bb1ff7..f110fd72 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -123,6 +123,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         self.unihash_cache = bb.cache.SimpleCache("1")
         self.unitaskhashes = self.unihash_cache.init_cache(data, "bb_unihashes.dat", {})
+        self.localdirsexclude = (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE") or "").split()
 
     def init_rundepcheck(self, data):
         self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST") or None
@@ -221,9 +222,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         if task in dataCache.file_checksums[fn]:
             if self.checksum_cache:
-                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename)
+                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
             else:
-                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
+                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
             for (f,cs) in checksums:
                 self.file_checksum_values[tid].append((f,cs))
                 if cs:
-- 
2.24.0


