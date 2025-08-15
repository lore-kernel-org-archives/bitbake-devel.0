Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6CACA0EE4
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 19:44:07 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.20323.1755287044402795823
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Aug 2025 12:44:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LVzLtweV;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7a2befdso339987366b.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Aug 2025 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755287043; x=1755891843; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnWIx5D9D8t5YIit8vSXLeNvhq5NaPtS2I5RSmWNeWo=;
        b=LVzLtweVe8JgFSSKhJf86/NvKyBr92X4T47QIN8ivPUkDBBkbXnikgIU2ErvuYvd0p
         rmtIzoOfWQCjfchAmY8jfJl2y8JeRWu87g0NGhq5G1CoekNDOIZj8mt2Xf97HqQUjGPq
         l0fNI2ci9XczDzsVMlYLyoVD2SmHKOnKdYVr3wrGkvdHVu+TvFHpATeta+JGTu8U2DOk
         Xdz0cAaJpqk2uuHSf+MefMOue4JQt0EdPfXYBa899UUgjPFnweuCU4ebZRJP4Eo13XU2
         O1NRxe97KKdi7EN4H223+9xV4X9JOuF+OnCTppB3BXa0t2QMwHuuYH2+e2ZYPQvB2TbT
         Gi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755287043; x=1755891843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PnWIx5D9D8t5YIit8vSXLeNvhq5NaPtS2I5RSmWNeWo=;
        b=EBEjQY35+c5o2Jq4VWZJoTXrzxDba+LpifEGIvuWgk9MS3ZBZyo0OWpTZJ+j6LXgkF
         nSOLX51huNlSc7BExJdC29/b3/3sz9vz3pNYLEtQXs49Pe+fnB7n2JrSOcI1vmsK6oDL
         YuxVRbHjO2kE3gixsGIC/OSKsmilKNFF0nHfXkrVD5AAhLHeSIXqd/y3vzsug80RxpEO
         yCWr7Y5JoERZb+a2d1NPxmd5TKoEh0Z/mpymaVcjYVb25LEaVLBM2Mxlgl4LEWHRjqnY
         cjT8GJqILYhv8yUHAWIu8+rs8XHRd5CWAtPVPITdHCyGf8CGdwEDq/QTIElPvnHvWG3P
         rVOw==
X-Gm-Message-State: AOJu0YxsBKz/1fwgu0uUN8oMnZILqU+WHS90KBajgrFfOWvYxWea2mH4
	RVeTerD990HA4TZu6uVjJXAiuzNRMQS/I3FgcYjgsWbv6bqmi9wID1GSZrhF6e97
X-Gm-Gg: ASbGnct6qkj5R5AOjULCRC5UKrGEyzbc/FljVXnutkL2iVmukfZ3KZ0eRMoiIyjViCE
	/Qt0y+VJcIbfFbFe1ddaMyuUwigVJWlKRX04HnhgYE23HACUizucXUWXL3x/DPMozL91nHChIEg
	+DtsspSylKgXWWowhXTDpMexY2m7aiDC0ncY+mT/rVnzg6fG8BamonivSOjMcOehFwc7eVaue6D
	nR5b+/nN1WYgrI9yyXQRzF2j8uWfMY0wWXsvmjcG4ZOyCdKHGpAifAXXZrvkIAFPVVS2IF54SoL
	+3EFZ4/R0++FuEEOD9cVMPFhQ7+7+W5pR0RxeM7D4yj+3jLf6gwY3pF+rLMS/+pkRaEzIiWyX6y
	Vvo+Zlm8J+6uHmLA2E+Hab9innJipGw==
X-Google-Smtp-Source: AGHT+IFtH91a2kNCrT8SpnEY5AUoJDY2UY0EnSuHg80yitZcD1z8RkdrOpP8Q0SupITMPy7e0qeY7w==
X-Received: by 2002:a17:907:c27:b0:ae0:d332:f637 with SMTP id a640c23a62f3a-afceadd7408mr12128766b.31.1755287042539;
        Fri, 15 Aug 2025 12:44:02 -0700 (PDT)
Received: from desktop ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfcceb6sm201346866b.66.2025.08.15.12.44.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:44:02 -0700 (PDT)
From: Gyorgy Sarvari <skandigraun@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/git: verify if local clone contains tag
Date: Fri, 15 Aug 2025 21:44:01 +0200
Message-ID: <20250815194401.2866251-1-skandigraun@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Aug 2025 19:44:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17877

In case a recipe specifies a git SRC_URI along with revision and tag, but only the
revision is present in the local clone without the tag (because it was tagged after
it was cloned), then unpacking fails with the following error:

... rev-list -n 1 1.0 failed with exit code 128, output:\nfatal: ambiguous argument \'1.0\': unknown revision or path not in the working tree

This happens because the during the download step only the revision's presence is
verified to decide if the repository needs to be updated.

To avoid this, check also if the tag is present in the local repository, when the "tag"
tag is specified.

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py  | 10 +++++---
 bitbake/lib/bb/tests/fetch.py | 44 +++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index ecaf0a49af..52fffe21d7 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -323,6 +323,8 @@ class Git(FetchMethod):
             return True
         if not self._contains_ref(ud, d, ud.name, ud.clonedir):
             return True
+        if 'tag' in ud.parm and not self._contains_ref(ud, d, ud.name, ud.clonedir, tag=True):
+            return True
         return False
 
     def lfs_need_update(self, ud, d):
@@ -775,14 +777,16 @@ class Git(FetchMethod):
     def supports_srcrev(self):
         return True
 
-    def _contains_ref(self, ud, d, name, wd):
+    def _contains_ref(self, ud, d, name, wd, tag=False):
         cmd = ""
+        git_ref_name = 'refs/tags/%s' % ud.parm['tag'] if tag else ud.revision
+
         if ud.nobranch:
             cmd = "%s log --pretty=oneline -n 1 %s -- 2> /dev/null | wc -l" % (
-                ud.basecmd, ud.revision)
+                ud.basecmd, git_ref_name)
         else:
             cmd =  "%s branch --contains %s --list %s 2> /dev/null | wc -l" % (
-                ud.basecmd, ud.revision, ud.branch)
+                ud.basecmd, git_ref_name, ud.branch)
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
         except bb.fetch2.FetchError:
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index cde1bf3390..d216eac2ab 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2647,6 +2647,50 @@ class GitURLWithSpacesTest(FetcherTest):
             self.assertEqual(ud.fullmirror, os.path.join(self.dldir, "git2_" + ref['gitsrcname'] + '.tar.gz'))
             self.assertEqual(ud.method._get_repo_url(ud), ref['repo_url'])
 
+
+class FetchLocallyMissingTagFromRemote(FetcherTest):
+    def setUp(self):
+        FetcherTest.setUp(self)
+        self.gitdir = os.path.join(self.tempdir, 'git')
+        self.srcdir = os.path.join(self.tempdir, 'gitsource')
+
+        bb.utils.mkdirhier(self.srcdir)
+        self.git_init(cwd=self.srcdir)
+        self.d.setVar('WORKDIR', self.tempdir)
+        self.d.setVar('S', self.gitdir)
+
+        uri = 'git://%s;protocol=file;subdir=${S};branch=master' % self.srcdir
+        self.d.setVar('SRC_URI', uri)
+
+        open(os.path.join(self.srcdir, 'dummyfile'), 'w').close()
+        self.git(['add', 'dummyfile'], self.srcdir)
+        self.git(['commit', '-m', 'dummymsg', 'dummyfile'], self.srcdir)
+
+    def _fetch_and_unpack(self, uri_to_fetch):
+        fetcher = bb.fetch2.Fetch([uri_to_fetch], self.d)
+        fetcher.download()
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+
+    def test_tag_present_in_remote_but_not_local(self):
+        # fetch a repo that has no tag in it
+        # then add a tag to this repo, and fetch it again, without
+        # changing SRC_REV, but by adding ';tag=tag1` to SRC_URI
+        # the new tag should be fetched and unpacked
+        srcrev = self.git('rev-parse HEAD', cwd=self.srcdir).strip()
+        self.d.setVar('SRCREV', srcrev)
+        src_uri = self.d.getVar('SRC_URI')
+        self._fetch_and_unpack(src_uri)
+
+        self.git('tag -m -a tag1', cwd=self.srcdir)
+
+        src_uri = '%s;tag=tag1' % self.d.getVar('SRC_URI').split()[0]
+        self.d.setVar('SRC_URI', src_uri)
+        self._fetch_and_unpack(src_uri)
+
+        output = self.git('log --pretty=oneline -n 1 refs/tags/tag1', cwd=self.gitdir)
+        assert "fatal: ambiguous argument" not in output
+
+
 class CrateTest(FetcherTest):
     @skipIfNoNetwork()
     def test_crate_url(self):

