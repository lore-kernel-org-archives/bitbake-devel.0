Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web08.21056.1612710121210732068
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Feb 2021 07:02:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=VwGmJh2k;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: schnitzeltony@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id j21so8083719wmj.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 07 Feb 2021 07:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGm5VZmzUsz9AIaozI0WZRgQnweiqMKyiL77UYWoM3c=;
        b=VwGmJh2kzzNvGbGSvwwf5M3kwPSKlCxgMeRXvpUFZlVCsCxDB93rTr9mCmAQiNVh5k
         OLdCMzS6f/cG9kfb4IuCM03B3SCJIW/E4geizGfTcLN4oXc7DLPOk9fP/HheaW70lcZ3
         VMMgOQT1fVEnoBqU7iBaMUn94hYK6ofBh6kuW96cx+sIOhqo+dDGks1BiCUrjwXhy92S
         LsTVM+4YRhZJSYSXXgkiKcRrUMpusaGq2zWWa7rs79T1WvahwVrfK9w8/+FbpPDkNDe+
         Fqw62ZBEeGRqMoreioRG01XuiXK9Pu/2TdnpUaR17F6HpLOZWzkRHG0htQzeXf7QnLy6
         R5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGm5VZmzUsz9AIaozI0WZRgQnweiqMKyiL77UYWoM3c=;
        b=AkKkxWa+KuQy3wIAduvv9jyNnTRfFvFYgvTX73T/Lak7YtfscK20qlvV/VaIviWyq7
         +a3XIzHapKhwMhOJ3jzsT4Tec6vz0+GMJiAiqi4NmUBflJVdDhSFtSj8ER02PLnOLZgo
         QIwozIwEisXPt5e7DJIT9QGHFQacZaNgaYPqgh5TDTVwNB1VpW9E2SU0C7YunHA946hY
         a7OzqERdra+dC558zSR3UDirylKT/gyEGOGKxQj/L7tvwytjaZei1ItA2VlO5ZA/laeS
         eJwkBDVynbreQ0oTZwANT2uscjs6EPPKoJs3d9QN3yZ2vjURbaa/FOnRg/c5XR4Sbv0K
         Dw3g==
X-Gm-Message-State: AOAM532A2/Whi/cx9Uwq64U6tV5F//mHwHWC2lMxE9y2K9pbv1/FvLnf
	9MfiGBBCK4rkaru9HJv9C4gHK/7H48g=
X-Google-Smtp-Source: ABdhPJzoHzvod+t5OqDzGYMcQaHWXF+lqp4HcQ55C8qxtotZj+Bdb9JTVVgc3VjZMqGteeqJJ0xA1w==
X-Received: by 2002:a1c:e08a:: with SMTP id x132mr7359480wmg.184.1612710119749;
        Sun, 07 Feb 2021 07:01:59 -0800 (PST)
Return-Path: <schnitzeltony@gmail.com>
Received: from superandy.speedport.ip (p200300f07f44b13017fa725760fbfa73.dip0.t-ipconnect.de. [2003:f0:7f44:b130:17fa:7257:60fb:fa73])
        by smtp.gmail.com with ESMTPSA id 9sm24229114wra.80.2021.02.07.07.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:01:59 -0800 (PST)
From: =?UTF-8?B?QW5kcmVhcyBNw7xsbGVy?= <schnitzeltony@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com,
	randy.macleod@windriver.com,
	ross.burton@arm.com
Subject: [RFC-cargo-fetcher 1/3] Add a fetcher for cargo crate index
Date: Sun,  7 Feb 2021 16:01:45 +0100
Message-Id: <20210207150147.31011-2-schnitzeltony@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210207150147.31011-1-schnitzeltony@gmail.com>
References: <20210207150147.31011-1-schnitzeltony@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mimic cargo fetch for common crate index

Signed-off-by: Andreas Müller <schnitzeltony@gmail.com>
---
 lib/bb/fetch2/__init__.py   |   2 +
 lib/bb/fetch2/crateindex.py | 155 ++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 lib/bb/fetch2/crateindex.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index ee3d7b16..8f535b61 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1908,6 +1908,7 @@ from . import repo
 from . import clearcase
 from . import npm
 from . import npmsw
+from . import crateindex
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -1927,3 +1928,4 @@ methods.append(repo.Repo())
 methods.append(clearcase.ClearCase())
 methods.append(npm.Npm())
 methods.append(npmsw.NpmShrinkWrap())
+methods.append(crateindex.CrateIndex())
diff --git a/lib/bb/fetch2/crateindex.py b/lib/bb/fetch2/crateindex.py
new file mode 100644
index 00000000..eb80248e
--- /dev/null
+++ b/lib/bb/fetch2/crateindex.py
@@ -0,0 +1,155 @@
+"""
+BitBake 'Fetch' crateindex implementation
+
+crateindex downloads cargo's crates index. It mimics cargo fetch so all
+further calls of cargo can be done as:
+
+export CARGO_HOME="${DL_DIR}/cargo"
+export CARGO_TARGET_DIR="${B}"
+cargo build --frozen
+
+The crate-fetch part can be found in cratelock.py.
+
+crate index fetcher support the SRC_URI with format of:
+
+SRC_URI = "crateindex://some.host/somepath.git;OptionA=xxx;OptionB=xxx;..."
+
+Class CrateIndex derives from Git fetcher. Supported SRC_URI options are same
+as for git fetcher plus:
+
+- cargoindexhash
+    Cargo generates hash from download location of index [1]. So as long
+    as we use the official index at github.com/rust-lang/crates.io-index
+    the hash can be considered constant: 'github.com-1ecc6299db9ec823'
+    which is used as default when not set.
+    [1] https://gitlab.com/kornelski/LTS/-/blob/master/src/hash.rs
+
+The following git-fetcher parameters are ignored:
+
+* nocheckout
+* bareclone
+
+"""
+
+# Copyright (C) 2021 Andreas Müller
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import os
+import json
+import tempfile
+import bb
+from   bb.fetch2 import runfetchcmd
+from   bb.fetch2 import MissingParameterError
+from   . import git
+
+class CrateIndex(git.Git):
+    def supports(self, ud, d):
+        """
+        Check to see if a given url can be fetched with git.
+        """
+        return ud.type in ['crateindex']
+
+    def urldata_init(self, ud, d):
+        """Init cratelock specific variables within url data"""
+        super().urldata_init(ud, d)
+
+        # get cargoindexhash param or set default for
+        # github.com/rust-lang/crates.io-index
+        ud.cargoindexhash = ud.parm.get("cargoindexhash")
+        if ud.cargoindexhash == None:
+            ud.cargoindexhash = 'github.com-1ecc6299db9ec823'
+
+    def _basecachedir(self, ud,d):
+        return os.path.join(d.getVar("DL_DIR"), 'cargo', 'registry/index', ud.cargoindexhash)
+
+    def download(self, ud, d):
+        # fetch git
+        super().download(ud, d)
+
+        # Mimic cargo fetch - index part (see cratelock.py for crate part)
+        # We buffer cache once in download area because of:
+        # * Creation is time consuming and cache shared by all rust recipes
+        # * Index is target/arch independent - there is only one
+        # * 'man cargo fetch' says: 'Subsequent Cargo commands never touch the
+        #   network after a cargo fetch unless the lock file changes.'
+
+        # Index cache part 1:
+        # Fetch only git repository
+        basecachedir = self._basecachedir(ud, d)
+        bb.utils.mkdirhier(basecachedir)
+        commit_id = ud.revisions[ud.names[0]]
+        progresshandler = git.GitProgressHandler(d)
+        runfetchcmd("%s init" % ud.basecmd, d, workdir=basecachedir)
+        runfetchcmd("%s fetch %s %s --progress" % (ud.basecmd, ud.clonedir, commit_id), d, log=progresshandler, workdir=basecachedir)
+        # Looks like hack but without cargo wants to download and ends with
+        # 'attempting to make an HTTP request, but --frozen was specified'
+        runfetchcmd("%s update-ref refs/remotes/origin/HEAD %s" % (ud.basecmd, commit_id), d, workdir=basecachedir)
+        runfetchcmd("%s update-ref refs/remotes/origin/master %s" % (ud.basecmd, commit_id), d, workdir=basecachedir)
+
+        # Index cache part 2:
+        # Convert cache text files to the binary format cargo expects:
+        # <0x01>
+        # <ASCII representation of git hash><0x00>
+        # per line
+        #  <ASCII semver for fast search><0x00><JSON contents of crate index file><0x00>
+        #
+        # One reason why they use the binary cache is to avoid slow json
+        # parsing see:
+        # https://github.com/rust-lang/cargo/blob/master/src/cargo/sources/registry/index.rs
+
+        # unpack files to temp dir
+        tmp_cachedir = tempfile.TemporaryDirectory()
+        runfetchcmd("%s archive %s | tar -x -C %s" % (ud.basecmd, commit_id, tmp_cachedir.name), d, workdir=ud.clonedir)
+        # create binary cache
+        cachedir = os.path.join(basecachedir, '.cache')
+        bb.utils.mkdirhier(cachedir)
+        for path_read, fdummy, files in os.walk(tmp_cachedir.name):
+            path_write = path_read.replace(tmp_cachedir.name, cachedir, 1)
+            bb.utils.mkdirhier(path_write)
+            for file in files:
+                if file == "config.json":
+                    continue
+                filename_read = os.path.join(path_read, file)
+                filename_write = os.path.join(path_write, file)
+                with open(filename_read, 'r') as file:
+                    crate_info = file.read()
+                with open(filename_write, 'wb') as file:
+                    file.write(b'\x01')
+                    file.write(commit_id.encode('utf-8'))
+                    file.write(b'\x00')
+                    for line in crate_info.splitlines():
+                        line = line.replace(' ', '')
+                        if line != '':
+                            try:
+                                jdict = json.loads(line)
+                            except json.JSONDecodeError:
+                                bb.note("Invalid json line in %s - ignore" % (filename_write))
+                                continue
+                            else:
+                                if 'vers' in jdict:
+                                    file.write(jdict['vers'].encode("utf-8"))
+                                    file.write(b'\x00')
+                                    file.write(line.encode('utf-8'))
+                                    file.write(b'\x00')
+        tmp_cachedir.cleanup()
+        # Extra file cargo fetch creates
+        runfetchcmd("touch %s/.last-updated" % basecachedir, d)
+
+    def unpack(self, ud, destdir, d):
+        # No files to recipe's workdir. So:
+        return True
+
+    def verify_donestamp(self, ud, d):
+        # Main magic is done by git fetcher just add simple check
+        # .last-updated was last step in download
+        basecachedir = self._basecachedir(ud, d)
+        return super().verify_donestamp(ud, d) and os.path.exists(basecachedir)
+
+    def clean(self, ud, d):
+        super().clean(ud, d)
+        cachedir = self._basecachedir(ud, d)
+        if os.path.exists(cachedir):
+            bb.note('Removing %s' % cachedir)
+            bb.utils.remove(cachedir, True)
-- 
2.26.2

