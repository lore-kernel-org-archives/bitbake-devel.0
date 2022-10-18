Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4A6C433FE
	for <webhook@archiver.kernel.org>; Tue, 18 Oct 2022 19:38:05 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.1347.1666121882037645613
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Oct 2022 12:38:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=fwNAbaXn;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id f11so25397230wrm.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Oct 2022 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SjeDteiYCSewdJWnuonQJBMXrVl4Ibnn3NJL3fLKKVk=;
        b=fwNAbaXnR4VK2Jmg/FbHNf6vWEg5ID3c4TtEieLXuVJ7Lxf37+9MsfAZ9HERAASKXN
         DapR3LR+dkj2Rlq1nmT7wTichFyocD2XsJn8zyhW1Fgvx98l+9DCrJAsiUveiz+0jiUv
         waHmSACdWyPf3u1yP+tkW35XnVOzQiC+Ukhn329TIUHwERgODcQAb5mavT/LOSZLXoxZ
         H+KQ4WJXhWts+HiJstgiNuHXFmzJUVxsJgKWYkRXT96HsnHLi7TjBuFkZGBW46bQfOpD
         wE/xMfHeNdZfzenvri9AKmHa8xK4bZBIBJwDeTKw6BcpeLbWQAIXhVI2otMUUmzpbUmO
         Xa1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjeDteiYCSewdJWnuonQJBMXrVl4Ibnn3NJL3fLKKVk=;
        b=tLQri+gjy8i8JJ9icI5Usc8S2s/gPu6p4hb/zqNzKmQOTAE0zI1/YxLJXtxqhG0j8u
         M9Y54PVL3kr8it1WEzdyFsXBQPFMAPLZb+4wmpbzhvqJ7lNnySSeuGia0mvZ6/xm+sYJ
         mMp/lG2mlP1M9e7dGuAN4H1FWfnVaVKI8Vz77MuNzJthStdGXkKXXgwhoxXfYwo57EjA
         E12i7BPVSJanHi+85HwZF10BZA2ePwERJ5hp9M9ZByaT2kcT8C7Y4jK7weqlwcWSHaJF
         uzdA4JPbaa7cVl6T3xHC22t6rix8KEQh5BFv8m0X+dPqGE9357Uc0YiFF51VhYw+njCG
         XMBg==
X-Gm-Message-State: ACrzQf11C25hvcq504PAWZzYPdw+bx+Q/42CbcrNdsZ0Jfc2EJEb9t9N
	DaN5jrBq3+xnna5qz/hC+8N59hIjm35EEw==
X-Google-Smtp-Source: AMsMyM4/ZytHgUQe8HbwTDMzUan+gutZNm6rQyQaVFaHxClO9Rz3idtL6GGHWujnljyp8ZdopvswOQ==
X-Received: by 2002:a5d:6da2:0:b0:22e:42ff:2f8 with SMTP id u2-20020a5d6da2000000b0022e42ff02f8mr2788973wrs.269.1666121880264;
        Tue, 18 Oct 2022 12:38:00 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0a4300b003b4fdbb6319sm21266221wmq.21.2022.10.18.12.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 12:37:59 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [PATCH] [RFC][DO-NOT-MERGE] tests: add test that LFS objects are resolved also inside submodules
Date: Tue, 18 Oct 2022 21:37:46 +0200
Message-Id: <20221018193746.3599845-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Oct 2022 19:38:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14042

* RFC because it will currently fail on hosts where LFS isn't
  enabled in .gitconfig or /etc/gitconfig, but it documents why
  people are seeing different results in repos with LFS objects
  e.g. vulkan-samples recipe failing in do_unpack

  I'm not sure what's the expected behavior here which would work
  for everybody, lets discuss.

[YOCTO #14938]

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/tests/fetch.py | 68 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index b4ed691f..a38df519 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2199,6 +2199,7 @@ class GitLfsTest(FetcherTest):
 
         self.gitdir = os.path.join(self.tempdir, 'git')
         self.srcdir = os.path.join(self.tempdir, 'gitsource')
+        self.srcdirsm = os.path.join(self.tempdir, 'gitsource-submodule')
 
         self.d.setVar('WORKDIR', self.tempdir)
         self.d.setVar('S', self.gitdir)
@@ -2213,8 +2214,18 @@ class GitLfsTest(FetcherTest):
         self.git_init(cwd=self.srcdir)
         with open(os.path.join(self.srcdir, '.gitattributes'), 'wt') as attrs:
             attrs.write('*.mp3 filter=lfs -text')
+        with open(os.path.join(self.srcdir, 'lalala.mp3'), 'wt') as attrs:
+            attrs.write('lalala')
         self.git(['add', '.gitattributes'], cwd=self.srcdir)
         self.git(['commit', '-m', "attributes", '.gitattributes'], cwd=self.srcdir)
+        self.git(['add', 'lalala.mp3'], cwd=self.srcdir)
+        self.git(['commit', '-m', "lalala", 'lalala.mp3'], cwd=self.srcdir)
+
+        # set another git repo which will have the first 1 as a submodule
+        bb.utils.mkdirhier(self.srcdirsm)
+        self.git_init(cwd=self.srcdirsm)
+        self.git(['submodule', 'add', self.srcdir], cwd=self.srcdirsm)
+        self.git(['commit', '-am', "submodule"], cwd=self.srcdirsm)
 
     def fetch(self, uri=None, download=True):
         uris = self.d.getVar('SRC_URI').split()
@@ -2277,6 +2288,63 @@ class GitLfsTest(FetcherTest):
         shutil.rmtree(self.gitdir, ignore_errors=True)
         fetcher.unpack(self.d.getVar('WORKDIR'))
 
+    def test_lfs_in_submodule_enabled(self):
+        import shutil
+
+        uri = 'gitsm://%s;protocol=file;lfs=1;branch=master' % self.srcdirsm
+        self.d.setVar('SRC_URI', uri)
+
+        # In contrast to regular fetch() here the LFS isn't in the
+        # main repo, but in its submodule
+        fetcher, ud = self.fetch()
+        self.assertIsNotNone(ud.method._find_git_lfs)
+
+        # If git-lfs can be found, the unpack should be successful. A
+        # live copy of git-lfs is not required for this case, so
+        # unconditionally forge its presence.
+        ud.method._find_git_lfs = lambda d: True
+        shutil.rmtree(self.gitdir, ignore_errors=True)
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+        self.assertTrue(os.path.exists(os.path.join(self.d.getVar('WORKDIR'), 'git', 'gitsource', 'lalala.mp3')))
+        self.assertEqual(open(os.path.join(self.d.getVar('WORKDIR'), 'git', 'gitsource', 'lalala.mp3'), 'r').read(), 'lalala')
+
+    def test_lfs_in_submodule_disabled(self):
+        import shutil
+
+        uri = 'gitsm://%s;protocol=file;lfs=0;branch=master' % self.srcdirsm
+        self.d.setVar('SRC_URI', uri)
+
+        # In contrast to regular fetch() here the LFS isn't in the
+        # main repo, but in its submodule
+        fetcher, ud = self.fetch()
+        self.assertIsNotNone(ud.method._find_git_lfs)
+
+        # If git-lfs can be found, the unpack should be successful. A
+        # live copy of git-lfs is not required for this case, so
+        # unconditionally forge its presence.
+        ud.method._find_git_lfs = lambda d: True
+        shutil.rmtree(self.gitdir, ignore_errors=True)
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+        self.assertTrue(os.path.exists(os.path.join(self.d.getVar('WORKDIR'), 'git', 'gitsource', 'lalala.mp3')))
+        # There should be something like:
+        #     version https://git-lfs.github.com/spec/v1
+        #     oid sha256:3f29e1b2b05f8371595dc761fed8e8b37544b38d56dfce81a551b46c82f2f56b
+        #     size 6
+        # not the actual 'lalala' content, but that depends on git config
+        # with:
+        # [filter "lfs"]
+        #       smudge = git-lfs smudge -- %f
+        #       process = git-lfs filter-process
+        #       required = true
+        #       clean = git-lfs clean -- %f
+        # it works correctly, but might fail in git smudge when the objects aren't available
+        # and without smudge and process it fails with:
+        # fatal: lalala.mp3: smudge filter lfs failed
+        # fatal: unable to checkout submodule 'gitsource'
+        # and without this whole "lfs" section it will contain 'lalala' here instead of the link
+        # even when lfs is explicitly disabled in SRC_URI
+        self.assertNotEqual(open(os.path.join(self.d.getVar('WORKDIR'), 'git', 'gitsource', 'lalala.mp3'), 'r').read(), 'lalala')
+
 class GitURLWithSpacesTest(FetcherTest):
     test_git_urls = {
         "git://tfs-example.org:22/tfs/example%20path/example.git;branch=master" : {
-- 
2.38.0


