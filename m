Return-Path: <akuster808@gmail.com>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
	[209.85.220.65])
	by mail.openembedded.org (Postfix) with ESMTP id 21144605BF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Sep 2016 15:06:57 +0000 (UTC)
Received: by mail-pa0-f65.google.com with SMTP id cd13so353761pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Sep 2016 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=oky8R4wzGlXGrcta10ZJRUqfmALEPKxdmYIW96jjMmU=;
	b=0je/PMViG54qispqoCZkxchQVjC6aJbR7b6ld2fpWapsF/ph+9JBOuVWL0Ucz4fpyU
	EQwi449nzfTB3r0bIR7vHD6Yu6FVrmADbr4gEqv4v+AWmSjNX9RxP1KG+cGb2RAO+fS8
	Wsj1ZTUGqAWVg3s4a9SdmroTLlrj3eZA+qWUtDbHta7OlmcHYl5gx46r2w/XiPBFee8Q
	W1zoIxTkSWe72VW7+T0pOPeqTSRRLAkCJSnfWMhjVEDDru1JyF6Ouu1CcM/kUIQA9wDy
	VBF3AP/1L7jsT6kjljs7FUNegF9Ui8eq6cYDteToGo3WRCfhjq9k5FN6n6ow2LAKnXd6
	TzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=oky8R4wzGlXGrcta10ZJRUqfmALEPKxdmYIW96jjMmU=;
	b=U7H0Pu3lo7vRdA+d/f1lp3e6Wu+x4TNTcTHqZsXeY6b1v+Jg7+Pc4/wiqNKXvTfswO
	IlpMwjJR8F1S+wMi1fyvx9nyvOb+Im9knD3gMRvojSoWqMBqn3mzurUsTqKfjGZBhJDc
	+X9otsx9n4VjE8YTmj2ONRcd9CavgeYGbN7mWPUwEMzeq/buuQ+n+HtDVwTNbdliOFXk
	QMzHIy9SBtYfxDpG3q4eMX4eH2c+SbiN8JXq3Oz0VRoKkZnc3IjyUyjRHuXssc6uuLqf
	4DwmJmnGLaPDrP97kFtyNHw5y+Y//XPBr/C3RahJ/RKoid/CzCXjWPZZNio1c14IyQ5F
	B+IQ==
X-Gm-Message-State: AE9vXwO4O/cLW1KpTsarmnFOYPTTxv09A8C/BQ8b4OcTnXYvelhAQd+t5dFCBIu/C9l5Qg==
X-Received: by 10.66.49.130 with SMTP id u2mr57327851pan.172.1475075219254;
	Wed, 28 Sep 2016 08:06:59 -0700 (PDT)
Received: from akuster-ThinkPad-X240.mvista.com
	([2601:202:4001:9ea0:8d18:8d09:2d56:eaa1])
	by smtp.gmail.com with ESMTPSA id l3sm2763837pfl.75.2016.09.28.08.06.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 28 Sep 2016 08:06:58 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: akuster@mvista.com,
	bitbake-devel@lists.openembedded.org
Date: Wed, 28 Sep 2016 08:06:57 -0700
Message-Id: <1475075217-17547-1-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] codeparser: Use hashlib for hashing, not hash()
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
X-List-Received-Date: Wed, 28 Sep 2016 15:06:58 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

"hash() is randomised by default each time you start a new instance of
recent
versions (Python3.3+) to prevent dictionary insertion DOS attacks"

which means we need to use hashlib.md5 to get consistent values for
the codeparser cache under python 3. Prior to this, the codeparser
cache was effectively useless under python3 as shown by performance
regressions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 12d43cf45ba48e3587392f15315d92a1a53482ef)

We kept running into an issue where shell scripts were not
getting generated on 32bit hosts. It seemed to be caused by this code.

Example:
.../i686/build-project/tmp/work/cortexa5hf-vfp-neon-montavista-linux-gnueabi/libpthread-stubs/0.3-r0/temp/run.sysroot_stage_all.104712:
line 121: sysroot_stage_dir: command not found
WARNING:
..../i686/build-project/tmp/work/cortexa5hf-vfp-neon-montavista-linux-gnueabi/libpthread-stubs/0.3-r0/temp/run.sysroot_stage_all.104712:1
exit 127 from
  sysroot_stage_dir $from/usr/include $to/usr/include
DEBUG: Python function do_populate_sysroot finished
ERROR: Function failed: sysroot_stage_all (log file is located at
.../i686/build-project/tmp/work/cortexa5hf-vfp-neon-montavista-linux-gnueabi/libpthread-stubs/0.3-r0/temp/log.do_populate_sysroot.104712)

Signed-off-by: Armin Kuster <akuster@mvista.com>
---
 lib/bb/codeparser.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 82a3af4..15492e4 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -3,6 +3,7 @@ import codegen
 import logging
 import os.path
 import bb.utils, bb.data
+import hashlib
 from itertools import chain
 from pysh import pyshyacc, pyshlex, sherrors
 from bb.cache import MultiProcessCache
@@ -16,6 +17,8 @@ except ImportError:
     import pickle
     logger.info('Importing cPickle failed.  Falling back to a very slow implementation.')
 
+def bbhash(s):
+    return hashlib.md5(s.encode("utf-8")).hexdigest()
 
 def check_indent(codestr):
     """If the code is indented, add a top level piece of code to 'remove' the indentation"""
@@ -248,7 +251,7 @@ class PythonParser():
         if not node or not node.strip():
             return
 
-        h = hash(str(node))
+        h = bbhash(str(node))
 
         if h in codeparsercache.pythoncache:
             self.references = set(codeparsercache.pythoncache[h].refs)
@@ -291,7 +294,7 @@ class ShellParser():
         commands it executes.
         """
 
-        h = hash(str(value))
+        h = bbhash(str(value))
 
         if h in codeparsercache.shellcache:
             self.execs = set(codeparsercache.shellcache[h].execs)
-- 
2.7.4


