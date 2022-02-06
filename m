Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E15C433F5
	for <webhook@archiver.kernel.org>; Sun,  6 Feb 2022 13:45:17 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web08.8669.1644155116070148544
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Feb 2022 05:45:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YEr3j7i7;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: ptsneves@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id s21so6484696ejx.12
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Feb 2022 05:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spvkU3/BOBzhhXEyK2QuD9S6lUR/tSORjjoOU27BAxE=;
        b=YEr3j7i7a2OL85PsC3uZPJTTM9FMuH4W/MgsnwHDxjh89EpApQU3PPcaFMRnAuXIZz
         1mpmRjv7myEa7es++X1lHltHQD5dzHLcP9CPob/oOXQHcFZlj06b1GoRsmgUJuOGGA/X
         u4sJwwND7T4IUKOzW5Qr4xkmocP5lT4JOK/Ai7Bxj4MvB6WdFWDVeMDAnj9uTzlYic+p
         Cb0/tdCdEqeiQFMdDkLcpGzpYJLcvveep8Bh2R/Xl77EQbegdCueBzT8263uYtBfA3gL
         Ir8kVrt/8v7gSegPijZQW8d/cpb4M8fRwfqm39SoQ+z+NAoJtmaJCGq381T0vm3gVQFo
         SZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spvkU3/BOBzhhXEyK2QuD9S6lUR/tSORjjoOU27BAxE=;
        b=3bsBtSKFHoTua7zP/buNyNonSOegNKTEtwK7zLSrC3zFDR17ecULLqVkaZnI/hpuPs
         js4SRyj3IXwPnBcUZqsrcRm9ZNXvW7JA8i69OqU2dPQ6nyv6YWfskgVcd1qrWiAfobvC
         xJxCgtf97laQa2I0dVBYT8AgcnMKs7BqFU7zZKARiMt6oLy7dn374JdCFdageLXCky+m
         WslP1T/xi3KNKVSEBsB9VFnk4APbOElAp/Mq4SRBO63MQsiw9GPm2MAyokb2STXlgpFo
         fN+PcqvvpyBcTpUD5d1mTUflKA/QZll3gCVqtNeLsvTY3P5O4FhC9/xXilhm53rC/0FW
         axyw==
X-Gm-Message-State: AOAM53139MVk+bt38cK5jwpZgeacRBnJBw7XtFOsECRt6cqXQwy3+Wnk
	o7icMQNBhhvmT74GbP942w1BHbr5hg==
X-Google-Smtp-Source: 
 ABdhPJxs35qctl9UAHwiOaocMOsXMDtVDck6R8Ss9bEVwhQARqY6vD0p+jUMi9aapz7QAOxjkZbfcA==
X-Received: by 2002:a17:907:2d93:: with SMTP id
 gt19mr6599019ejc.604.1644155114516;
        Sun, 06 Feb 2022 05:45:14 -0800 (PST)
Received: from localhost.localdomain
 (031011128254.dynamic-3-poz-k-0-2-0.vectranet.pl. [31.11.128.254])
        by smtp.gmail.com with ESMTPSA id
 gg14sm2626207ejb.62.2022.02.06.05.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:45:13 -0800 (PST)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paulo Neves <ptsneves@gmail.com>
Subject: [PATCH v3] checksum: Support uri formatted file list
Date: Sun,  6 Feb 2022 14:45:07 +0100
Message-Id: <20220206134507.123558-1-ptsneves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 06 Feb 2022 13:45:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13313

Before this commit, if the file list for checksumming had
files names with spaces there would be a crash. This happened
due to filelist.split breaking on the file names instead of
on k:v boundaries. Now we validate this case and emit a fatal
error if such case is found. This needs to be fatal as the split
will generate broken k:v from then on.

Instead of putting literal spaces in the file list the user
should urlencode the file names and if they contain coded spaces
they will be decoded. This is consistent with the current
practice where file names are urlencoded. A reproducer of the
issue this commit fixes, was to pass a do_compile[file-checksums]
list with files containing spaces in their names, urlencoded or
literal.

Change-Id: I6ac4f1cffbb86e913883491d46e8cc69a028e992
Signed-off-by: Paulo Neves <ptsneves@gmail.com>
---
 bitbake/lib/bb/checksum.py                   |  9 +++++++--
 bitbake/lib/bb/fetch2/__init__.py            |  6 +++---
 meta/classes/base.bbclass                    |  4 +++-
 meta/lib/oeqa/selftest/cases/lic_checksum.py | 18 ++++++++++++++++++
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/checksum.py b/bitbake/lib/bb/checksum.py
index fb8a77f6ab..4d34baffcc 100644
--- a/bitbake/lib/bb/checksum.py
+++ b/bitbake/lib/bb/checksum.py
@@ -8,6 +8,7 @@
 import glob
 import operator
 import os
+import urllib
 import stat
 import bb.utils
 import logging
@@ -110,10 +111,14 @@ class FileChecksumCache(MultiProcessCache):
 
         checksums = []
         for pth in filelist.split():
-            exist = pth.split(":")[1]
+            spl = pth.split(':')
+            if len(spl) != 2:
+                bb.fatal("found unformatted path in filelist " + pth)
+
+            exist = spl[1]
             if exist == "False":
                 continue
-            pth = pth.split(":")[0]
+            pth = urllib.parse.unquote(spl[0])
             if '*' in pth:
                 # Handle globs
                 for f in glob.glob(pth):
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index d37174185a..5cdd150d6b 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1214,13 +1214,13 @@ def get_checksum_file_list(d):
             paths = ud.method.localpaths(ud, d)
             for f in paths:
                 pth = ud.decodedurl
-                if f.startswith(dl_dir):
+                if pth.startswith(dl_dir):
                     # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
-                    if os.path.exists(f):
+                    if os.path.exists(pth):
                         bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN'), os.path.basename(f)))
                     else:
                         bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
-                filelist.append(f + ":" + str(os.path.exists(f)))
+                filelist.append(urllib.parse.quote(f) + ":" + str(os.path.exists(pth)))
 
     return " ".join(filelist)
 
diff --git a/meta/classes/base.bbclass b/meta/classes/base.bbclass
index 5f4956a1d3..8e6cf84479 100644
--- a/meta/classes/base.bbclass
+++ b/meta/classes/base.bbclass
@@ -94,6 +94,8 @@ def extra_path_elements(d):
 PATH:prepend = "${@extra_path_elements(d)}"
 
 def get_lic_checksum_file_list(d):
+    import urllib
+
     filelist = []
     lic_files = d.getVar("LIC_FILES_CHKSUM") or ''
     tmpdir = d.getVar("TMPDIR")
@@ -113,7 +115,7 @@ def get_lic_checksum_file_list(d):
             if path[0] == '/':
                 if path.startswith((tmpdir, s, b, workdir)):
                     continue
-                filelist.append(path + ":" + str(os.path.exists(path)))
+                filelist.append(urllib.parse.quote(path) + ":" + str(os.path.exists(path)))
         except bb.fetch.MalformedUrl:
             bb.fatal(d.getVar('PN') + ": LIC_FILES_CHKSUM contains an invalid URL: " + url)
     return " ".join(filelist)
diff --git a/meta/lib/oeqa/selftest/cases/lic_checksum.py b/meta/lib/oeqa/selftest/cases/lic_checksum.py
index 91021ac335..6bdbac3ba2 100644
--- a/meta/lib/oeqa/selftest/cases/lic_checksum.py
+++ b/meta/lib/oeqa/selftest/cases/lic_checksum.py
@@ -4,6 +4,7 @@
 
 import os
 import tempfile
+import urllib
 
 from oeqa.selftest.case import OESelftestTestCase
 from oeqa.utils.commands import bitbake
@@ -11,6 +12,23 @@ from oeqa.utils import CommandError
 
 class LicenseTests(OESelftestTestCase):
 
+    def test_checksum_with_space(self):
+        bitbake_cmd = '-c populate_lic emptytest'
+
+        lic_file, lic_path = tempfile.mkstemp(" -afterspace")
+        os.close(lic_file)
+        #self.track_for_cleanup(lic_path)
+
+        self.write_config("INHERIT:remove = \"report-error\"")
+
+        self.write_recipeinc('emptytest', """
+INHIBIT_DEFAULT_DEPS = "1"
+LIC_FILES_CHKSUM = "file://%s;md5=d41d8cd98f00b204e9800998ecf8427e"
+SRC_URI = "file://%s;md5=d41d8cd98f00b204e9800998ecf8427e"
+""" % (urllib.parse.quote(lic_path), urllib.parse.quote(lic_path)))
+        result = bitbake(bitbake_cmd)
+
+
     # Verify that changing a license file that has an absolute path causes
     # the license qa to fail due to a mismatched md5sum.
     def test_nonmatching_checksum(self):
-- 
2.25.1


