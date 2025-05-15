Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4634AC2D0CD
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 14:54:15 +0000 (UTC)
Received: from esa1.hc324-48.eu.iphmx.com (esa1.hc324-48.eu.iphmx.com [207.54.68.119])
 by mx.groups.io with SMTP id smtpd.web11.14678.1747320848482638361
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 May 2025 07:54:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=f7N1lvbE;
 spf=pass (domain: bmw.de, ip: 207.54.68.119, mailfrom: prvs=22331e167=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1747320848; x=1778856848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wQlyOE1/GLtW0PcJa3wdbBoWsU1mhpZ03jYtcEXIIe4=;
  b=f7N1lvbEVJdFUi3y45BIVnBR6cUA/8bJCP19Bqmy8MkPbvM5sEDAF/CO
   sZ+Em7kZbaGnCRF3/x1wAzypHSyY1Yb9Dtt7pQZXiIECYKi1bIKF4U3e1
   AH0tLKHy2pCWuIR8dzfdZNOAgsoiAA1fZdS0a2LsXocFbaoTjnWkbdwu5
   U=;
X-CSE-ConnectionGUID: 8yT+kmwrQ3OuvYNiuIskig==
X-CSE-MsgGUID: w5j/Fs34RYyPSIUPteOETw==
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa1.hc324-48.eu.iphmx.com with ESMTP/TLS; 15 May 2025 16:54:05 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw4.muc with ESMTP/TLS;
 15 May 2025 16:54:05 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 15 May 2025 16:54:05 +0200
Received: from localhost.localdomain (10.30.85.209) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Thu, 15 May 2025 16:54:05 +0200
X-CSE-ConnectionGUID: ruW8N5USRgKbCqo3AHdTdQ==
X-CSE-MsgGUID: fZs1Z9FmQE2VwjHebFjc5g==
X-CSE-ConnectionGUID: zUBDsWOiRPGpq2e8SM5iOw==
X-CSE-MsgGUID: Uuge5Oa7SPi24BZsjHkByQ==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [RFC PATCH 1/1] siggen: Support non-compressed sigdata files
Date: Thu, 15 May 2025 16:44:55 +0200
Message-ID: <20250515144455.2799533-2-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515144455.2799533-1-philip.lorenz@bmw.de>
References: <20250515144455.2799533-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp09d.europe.bmw.corp (2a03:1e80:a15:58f::2040) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 14:54:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17618

Compression utilities such as `zstd` can achieve significant compression
ratio improvements even when the low entropy data is spread over a
larger input window. As a result compressing a tarball containing
uncompressed sigdata files with zstd can reduce the amount by a factor
of 6-16.

Support this by introducing the `BB_SIGDATA_COMPRESSION` variable which
can be used to control compression of sigdata files. Setting the
variable to "none" disables compression, setting it to "zstd" (its
default value) retains the current behaviour.

All functions used to consume sigdata files are extended to
automatically detect whether input files are compressed and
transparently select the correct behaviour depending on that.

Additionally, expose the compression paramater in all functions to
enable overriding the global setting in some scenarios (e.g. for
.siginfo files created by sstate.bbclass).

Compression results for core-image-sato sigdata files produced using
`bitbake -S none core-image-sato` on poky
122e9a49614b2ddedaae1d90c06004a7a4c43998.

Tarball containing compressed sigdata files: 98 MB
Compressed tarball (zstd -3) containing compressed sigdata files: 76 MB
Compressed tarball (zstd -17) containing compressed sigdata files: 65 MB
Tarball containing uncompressed sigdata files: 310 MB
Compressed tarball (zstd -3) containing uncompressed sigdata files: 12 MB
Compressed tarball (zstd -17) containing uncompressed sigdata files: 4 MB

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/siggen.py | 84 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index a6163b55e..5c954228f 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -4,7 +4,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
+import contextlib
+import enum
 import hashlib
+import io
 import logging
 import os
 import re
@@ -68,6 +71,67 @@ def init(d):
                      ', '.join(obj.name for obj in siggens))
         return SignatureGenerator(d)
 
+class SigdataCompression(enum.Enum):
+    """Enumeration of sigdata compression / decompression schemes"""
+
+    AUTO = "auto"
+    """
+    Compression mode is automatically determined by file content (when reading files) or based
+    on the value of BB_SIGDATA_COMPRESSION (when writing files). BB_SIGDATA_COMPRESSION may be
+    set to any of the other constants defined in the enumeration converted to lower case (e.g. none
+    or zstd).
+    """
+
+    NONE = "none"
+    """
+    Sigdata files are stored uncompressed.
+    """
+
+    ZSTD = "zstd"
+    """
+    Sigdata files are stored using zstd compression.
+    """
+
+@contextlib.contextmanager
+def open_sigdata(path, mode, compression=SigdataCompression.AUTO):
+    """Open the given sigdata file at path with the given mode.
+
+    The compression parameter shall be used to specify which compression mode should be applied to
+    the sigdata file. See SigdataCompressionMode for a list of available modes.
+
+    The special compression mode `auto` may be used to automatically determine the compression mode
+    depending on existing sigdata content. As such `auto` is only supported when opening sigdata
+    files for reading.
+    """
+    ZSTD_MAGIC_BYTES = b"\x28\xb5\x2f\xfd"
+
+    # The underlying file is always opened in binary mode as we may need to pass the file descriptor
+    # to a subprocess for description. In case text decoding is required (e.g. for uncompressed
+    # files) a TextIOWrapper will be used.
+    file_mode = mode.replace("t", "")
+    if "b" not in file_mode:
+        file_mode += "b"
+
+    # The fileobj will be passed to Popen which then continues to operate on the raw file
+    # descriptor. Turn off buffering as this interferes with this assumption and operations such as
+    # peek() or seek() no longer move the file descriptor to the expected position.
+    with open(path, file_mode, buffering=0) as f:
+        if "r" in mode and compression == SigdataCompression.AUTO:
+            compression = SigdataCompression.ZSTD if f.read(4) == ZSTD_MAGIC_BYTES else SigdataCompression.NONE
+            f.seek(0)
+
+        if compression == SigdataCompression.NONE:
+            if "t" in mode:
+                f = io.TextIOWrapper(
+                    f, encoding="utf-8", write_through=True
+                )
+
+            yield f
+            return
+
+        with bb.compress.zstd.open(f, mode=mode, encoding="utf-8", num_threads=1) as zf:
+            yield zf
+
 class SignatureGenerator(object):
     """
     """
@@ -172,7 +236,7 @@ class SignatureGenerator(object):
     def stampcleanmask(self, stampbase, file_name, taskname, extrainfo):
         return ("%s.%s.%s" % (stampbase, taskname, extrainfo)).rstrip('.')
 
-    def dump_sigtask(self, mcfn, task, stampbase, runtime):
+    def dump_sigtask(self, mcfn, task, stampbase, runtime, compression=None):
         return
 
     def invalidate_task(self, task, mcfn):
@@ -239,6 +303,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.unitaskhashes = self.unihash_cache.init_cache(data, "bb_unihashes.dat", {})
         self.localdirsexclude = (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE") or "CVS .bzr .git .hg .osc .p4 .repo .svn").split()
         self.tidtopn = {}
+        self.sigdata_compression = SigdataCompression(data.getVar("BB_SIGDATA_COMPRESSION") or SigdataCompression.ZSTD)
 
     def init_rundepcheck(self, data):
         self.taskhash_ignore_tasks = data.getVar("BB_TASKHASH_IGNORE_TASKS") or None
@@ -415,7 +480,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
     def save_unitaskhashes(self):
         self.unihash_cache.save(self.unitaskhashes)
 
-    def dump_sigtask(self, mcfn, task, stampbase, runtime):
+    def dump_sigtask(self, mcfn, task, stampbase, runtime, compression=SigdataCompression.AUTO):
+        compression = compression if compression != SigdataCompression.AUTO \
+            else self.sigdata_compression
         tid = mcfn + ":" + task
         mc = bb.runqueue.mc_from_tid(mcfn)
         referencestamp = stampbase
@@ -478,7 +545,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         fd, tmpfile = bb.utils.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
         try:
-            with bb.compress.zstd.open(fd, "wt", encoding="utf-8", num_threads=1) as f:
+            with open_sigdata(fd, "wt", compression) as f:
                 json.dump(data, f, sort_keys=True, separators=(",", ":"), cls=SetEncoder)
                 f.flush()
             os.chmod(tmpfile, 0o664)
@@ -880,12 +947,13 @@ def clean_checksum_file_path(file_checksum_tuple):
         return "./" + f.split("/./")[1]
     return os.path.basename(f)
 
-def dump_this_task(outfile, d):
+def dump_this_task(outfile, d, compression=SigdataCompression.AUTO):
     import bb.parse
     mcfn = d.getVar("BB_FILENAME")
     task = "do_" + d.getVar("BB_CURRENTTASK")
     referencestamp = bb.parse.siggen.stampfile_base(mcfn)
-    bb.parse.siggen.dump_sigtask(mcfn, task, outfile, "customfile:" + referencestamp)
+    bb.parse.siggen.dump_sigtask(mcfn, task, outfile, "customfile:" + referencestamp,
+                                 compression=compression)
 
 def init_colors(enable_color):
     """Initialise colour dict for passing to compare_sigfiles()"""
@@ -969,13 +1037,13 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
         return formatstr.format(**formatparams)
 
     try:
-        with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
+        with open_sigdata(a, "rt") as f:
             a_data = json.load(f, object_hook=SetDecoder)
     except (TypeError, OSError) as err:
         bb.error("Failed to open sigdata file '%s': %s" % (a, str(err)))
         raise err
     try:
-        with bb.compress.zstd.open(b, "rt", encoding="utf-8", num_threads=1) as f:
+        with open_sigdata(b, "rt") as f:
             b_data = json.load(f, object_hook=SetDecoder)
     except (TypeError, OSError) as err:
         bb.error("Failed to open sigdata file '%s': %s" % (b, str(err)))
@@ -1218,7 +1286,7 @@ def dump_sigfile(a):
     output = []
 
     try:
-        with bb.compress.zstd.open(a, "rt", encoding="utf-8", num_threads=1) as f:
+        with open_sigdata(a, "rt") as f:
             a_data = json.load(f, object_hook=SetDecoder)
     except (TypeError, OSError) as err:
         bb.error("Failed to open sigdata file '%s': %s" % (a, str(err)))

