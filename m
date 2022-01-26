Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B027CC433F5
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 21:04:45 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web12.18951.1643231084661954174
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Jan 2022 13:04:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=qsnbPxeT;
 spf=pass (domain: gmail.com, ip: 209.85.167.50, mailfrom: ptsneves@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id n8so1346091lfq.4
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Jan 2022 13:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GT9KSMs2qJcAGAIKNBYvYn+A10v8UvOmRrYelP/Fox8=;
        b=qsnbPxeTCRtCL22gOLJdhiqA7WMbro+uBz//LVhH2ODq1HdgLDvY8hgQ/wM/U7Egi8
         nU25PELLEHYPX8jUuqQCMV6XyflmP0YeH9jn69DVBl1x5D852S35vfgLTpHwX/6WBj/8
         /0a2S6B4epQ0CDrskrnCD0msghLRPxmAsusK49RX6mizr+K4525KBnAbG++c5ZNqow+E
         YVubqaaXLC7gDD3rw44aOQ9sa1iU9pP844CHd93qt9TyVMyYX03u5oymRbw3TSAcJA9S
         mvN4VNPrNFsDDYmMj8ORtIZoQcZCBTIZ235cP8BOEqmyN0UTrKpX8X3bFc8Vc09vg9c0
         cDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GT9KSMs2qJcAGAIKNBYvYn+A10v8UvOmRrYelP/Fox8=;
        b=7BJi8XIvXpjccMkzPa8IbrzSv1zMeojaoErohqfKPXGnWKQFOQYUqIXqgti8bImNrj
         GVNJhyD4UBhMJaGpz+Ci6nmuu8o0w4PksMv7Q35igXRkG+4bml7t3yPmMe6kVoD/eWaq
         kxvmGYQPx6bNmDw0gfkrabMglQmGoW7s8GOCmadrKG17gnlmRfXT94fBvtQOSXBlRf1p
         SBqKSyXVGAA7kLmhcdY7zDRJFHJOOOl4SP+FvTxyoi1swUjqWP3OMLd6Q7Y4eR4LMZWX
         mhqxeiI0cx+WMw1+QsVQXB7GcxoHS+XuZIFxcxAlfOdjS/YoxZpcj6GD9umGD3fP1HIs
         pSOQ==
X-Gm-Message-State: AOAM531gwaNjMRzgRK2gz30CYXjdiGqbkVvMsfdsaajjHk5tQpRd2M8O
	5L8DB9FYBFcQdec4Rn044jqS+d+Bgg==
X-Google-Smtp-Source: 
 ABdhPJwwpAW1GqFlMzLhvkuqgjkMfYL+NsdMjmyIR4prUM3HsqYt5AM1Yp6++G6UzYqrmC3xXUDwyw==
X-Received: by 2002:ac2:539b:: with SMTP id g27mr572443lfh.612.1643231082776;
        Wed, 26 Jan 2022 13:04:42 -0800 (PST)
Received: from localhost.localdomain
 (031011128254.dynamic-3-poz-k-0-2-0.vectranet.pl. [31.11.128.254])
        by smtp.gmail.com with ESMTPSA id
 y22sm1949005lfa.48.2022.01.26.13.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:04:42 -0800 (PST)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paulo Neves <ptsneves@gmail.com>
Subject: [PATCH v2] checksum: Support uri formatted file list
Date: Wed, 26 Jan 2022 22:04:18 +0100
Message-Id: <20220126210417.466199-1-ptsneves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Jan 2022 21:04:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13285

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
index d37174185a..c19d4b8636 100644
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
+                filelist.append(f + ":" + str(os.path.exists(pth)))
 
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


