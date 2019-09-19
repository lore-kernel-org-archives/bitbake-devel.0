Return-Path: <ross.burton@intel.com>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
	[209.85.221.46])
	by mail.openembedded.org (Postfix) with ESMTP id 5E8D37FE7B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 22:43:43 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id r3so4781192wrj.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 15:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=6fkIGc3z3ldKbz9sdrzJJfHqc8nBd9vvd0YMnPxpE/s=;
	b=RgjOjT9ez7hQn8Z84mjX5KJpj7DhN0btewC0FZxeB36QZ/mg0U9x9BiuBhVYVfBQFf
	/JBb54F42DcIDVrqCxn3YCHqA2JrlmNT+TKPhu+QOJSy8nESVXSvdiBVFnAWxpDL6zF0
	zoVqHOjYfcfBtyLQIHfKsC+rRJHhMJlNmE0orqtHirCi4/Piwrd2fv6Q25cq9HCR4teK
	M0VdnjJ45V7loPQoMg66d2D2sX3YENz284pPjCoyq/uiAK96JzyZ1CRCtVkiUXlubPM2
	bXsZP86RJrq/QJArvfqXup3mbnEqSD2w+EhuHtNdWnJD/lBVsXEUO9Z9W76i2FqiCpHV
	xlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6fkIGc3z3ldKbz9sdrzJJfHqc8nBd9vvd0YMnPxpE/s=;
	b=XOUScGkizTC5W5/TPNYwNf/DSysvSuav1wQoqtNLuC2tFucFcdEMwasWyv1kxopAzW
	PY2GpOIfbQ4qPEWaoiauFZvvGt+UB51vP5tuc58paT9kiK1iTduoLF68iVxp/pISxIE3
	4DiJWkaCtjPI+U7eJQ8GLc8hPa7YeYKQ/dJBPHUR11Rcz2+Bo9MH3hcsgyfKoM3ZXE7D
	cWfNJrsxFx7FkScDgyBrPjqJrDNLADc+Ll414bgZdK3Sj/wKJI7xdQ/e+ozLwbSvRXeI
	sfbtCoHLx9LRJqnH3R7AYmxuocu0avnXh2C/wA3BSl+AZU4YvF17tbnoDCL3z2H9iHwx
	JJxQ==
X-Gm-Message-State: APjAAAXBSK+VNIWFYAyTRTjstFz+Da3kSDPNlWLwsTlCX0b2+Sk1TtYZ
	6fr0dGGxiwgaDvUIV0pAR3VsTWODhwc=
X-Google-Smtp-Source: APXvYqwbFx3dEK8Wv9ay+Nj6slPN2yF83MkR0EA0RTL7BVonfwbtCC6fr5KXxQ1TyhQuFZAXuLkbYg==
X-Received: by 2002:adf:f5ca:: with SMTP id k10mr9493936wrp.236.1568933024088; 
	Thu, 19 Sep 2019 15:43:44 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	u18sm5562054wmj.11.2019.09.19.15.43.43
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Sep 2019 15:43:43 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Sep 2019 23:43:37 +0100
Message-Id: <20190919224337.30208-2-ross.burton@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919224337.30208-1-ross.burton@intel.com>
References: <20190919224337.30208-1-ross.burton@intel.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] tests/fetch: add test case for git-lfs handling
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
X-List-Received-Date: Thu, 19 Sep 2019 22:43:44 -0000
Content-Transfer-Encoding: 8bit

Add a test case to exercise the detection of git-lfs repositories and the
behaviour of the lfs parameter.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/tests/fetch.py | 80 +++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 2ee030546a5..a0b656b6105 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1908,3 +1908,83 @@ class GitShallowTest(FetcherTest):
 
         dir = os.listdir(self.unpackdir + "/git/")
         self.assertIn("fstests.doap", dir)
+
+class GitLfsTest(FetcherTest):
+    def setUp(self):
+        FetcherTest.setUp(self)
+
+        self.gitdir = os.path.join(self.tempdir, 'git')
+        self.srcdir = os.path.join(self.tempdir, 'gitsource')
+        
+        self.d.setVar('WORKDIR', self.tempdir)
+        self.d.setVar('S', self.gitdir)
+        self.d.delVar('PREMIRRORS')
+        self.d.delVar('MIRRORS')
+
+        self.d.setVar('SRCREV', '${AUTOREV}')
+        self.d.setVar('AUTOREV', '${@bb.fetch2.get_autorev(d)}')
+
+        bb.utils.mkdirhier(self.srcdir)
+        self.git('init', cwd=self.srcdir)
+        with open(os.path.join(self.srcdir, '.gitattributes'), 'wt') as attrs:
+            attrs.write('*.mp3 filter=lfs -text')
+        self.git(['add', '.gitattributes'], cwd=self.srcdir)
+        self.git(['commit', '-m', "attributes", '.gitattributes'], cwd=self.srcdir)
+
+    def git(self, cmd, cwd=None):
+        if isinstance(cmd, str):
+            cmd = 'git ' + cmd
+        else:
+            cmd = ['git'] + cmd
+        if cwd is None:
+            cwd = self.gitdir
+        return bb.process.run(cmd, cwd=cwd)[0]
+
+    def fetch(self, uri=None):
+        uris = self.d.getVar('SRC_URI').split()
+        uri = uris[0]
+        d = self.d
+
+        fetcher = bb.fetch2.Fetch(uris, d)
+        fetcher.download()
+        ud = fetcher.ud[uri]
+        return fetcher, ud
+
+    def test_lfs_enabled(self):
+        import shutil
+
+        uri = 'git://%s;protocol=file;subdir=${S};lfs=1' % self.srcdir
+        self.d.setVar('SRC_URI', uri)
+
+        fetcher, ud = self.fetch()
+        self.assertIsNotNone(ud.method._find_git_lfs)
+
+        # If git-lfs can be found, the unpack should be successful
+        ud.method._find_git_lfs = lambda d: True
+        shutil.rmtree(self.gitdir, ignore_errors=True)
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+
+        # If git-lfs cannot be found, the unpack should throw an error
+        with self.assertRaises(bb.fetch2.FetchError):
+            ud.method._find_git_lfs = lambda d: False
+            shutil.rmtree(self.gitdir, ignore_errors=True)
+            fetcher.unpack(self.d.getVar('WORKDIR'))
+
+    def test_lfs_disabled(self):
+        import shutil
+
+        uri = 'git://%s;protocol=file;subdir=${S};lfs=0' % self.srcdir
+        self.d.setVar('SRC_URI', uri)
+
+        fetcher, ud = self.fetch()
+        self.assertIsNotNone(ud.method._find_git_lfs)
+
+        # If git-lfs can be found, the unpack should be successful
+        ud.method._find_git_lfs = lambda d: True
+        shutil.rmtree(self.gitdir, ignore_errors=True)
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+
+        # If git-lfs cannot be found, the unpack should be successful
+        ud.method._find_git_lfs = lambda d: False
+        shutil.rmtree(self.gitdir, ignore_errors=True)
+        fetcher.unpack(self.d.getVar('WORKDIR'))
-- 
2.20.1


