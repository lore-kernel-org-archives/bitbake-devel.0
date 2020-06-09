Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web10.8207.1591711848194785234
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jun 2020 07:10:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Mw2EJTcp;
 spf=pass (domain: gmail.com, ip: 209.85.208.171, mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id s1so25253979ljo.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jun 2020 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7rgfyx01iDYKzipDmYkc3XBGrGIr/s/b99p5JI5Ro20=;
        b=Mw2EJTcpm3uDNKfh17YMfVnjugtN6xnP/We7gbSRQ6B8aEFV1uC4i85nAjEwv971Q1
         GZAUDMxcWZEfOOqWqjrY66I06gxS/vl6Rakg65g2yhtzPzUohKbOBXBzdcwmkmPCCE9l
         SrRLShVb4epkTRnSqtQ2PYtPwqnfLymvjJIvGTWdUWddyzQaEsWlB5rcujz17mB1XwEj
         r+48Ggnm0bAog3kXjbenJWJi+OYSIau9fqviBtTyWlUxaQUir3IYTmBCFMR6HksxgpFm
         f3nR4qPX6GyeqyssS5r2HmAPpVgJ+IN9l/xWNg9fKDr0KVJyahHs/9iTKskhI+Kc509M
         8o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7rgfyx01iDYKzipDmYkc3XBGrGIr/s/b99p5JI5Ro20=;
        b=au5HDV/gpMmQYRmf9ngb50NQaMUCdY2OEfdEiKPoOAgI+ELDZFPkHuqwvhNFFTsbjq
         A1YkTr5r5SXg3GKUXE582iurYVM3CCLkcm2vYNXoDRX0EAhxZMUXLCa//kqJabWRcXzK
         Zu4gU27iIQooOIFj2JKdDP/3x5kAQ2v5+AsdDzsHDQEy+qzJY8gEzEc5DWvKknVkD+uG
         tgRSeRratnyxR3KIyfrb1pVBwtKltpLLl+dmlBL8I90oQ7CbUTRjUKMPugTkwmQ6Uidq
         Rj3TJLNX1T3THe9CmEm1K/HkX4VlhalIYJ1O7w9GsvrUJquf1jwVO16xHQg9oU7pjh4i
         HwQQ==
X-Gm-Message-State: AOAM530o6rfxAE3RnPvJx8VMwlbamrGB4C1p47KOQRSoMjlTCbi2umQV
	wCmp2qHm3gtvpuAaqwQbT7zMXyYW
X-Google-Smtp-Source: ABdhPJyG0CLjzB46tukC3yXdr5SSso02J4bseDeFiCDp4EMyJ3eBoHmX0bbNrCY2rR/CaYMIhPDlpg==
X-Received: by 2002:a2e:974a:: with SMTP id f10mr14388312ljj.283.1591711845676;
        Tue, 09 Jun 2020 07:10:45 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain ([213.185.29.22])
        by smtp.gmail.com with ESMTPSA id i22sm4355803ljb.21.2020.06.09.07.10.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 07:10:43 -0700 (PDT)
From: "Jacob Kroon" <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [RFC][PATCH] bitbake: ConfHandler: Add BBINCLUDESTACK
Date: Tue,  9 Jun 2020 16:10:23 +0200
Message-Id: <20200609141023.1751706-1-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add variable 'BBINCLUDESTACK' that contains the file inclusion stack.

Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 .../bitbake-user-manual-ref-variables.xml                 | 8 ++++++++
 lib/bb/parse/parse_py/ConfHandler.py                      | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index c4bd1f25..255000cd 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -1134,6 +1134,14 @@
             </glossdef>
         </glossentry>
 
+        <glossentry id='var-bb-BBINCLUDESTACK'><glossterm>BBINCLUDESTACK</glossterm>
+            <glossdef>
+                <para>
+                    Contains a space-separated list of the file inclusion stack.
+                </para>
+            </glossdef>
+        </glossentry>
+
         <glossentry id='var-bb-BBINCLUDELOGS'><glossterm>BBINCLUDELOGS</glossterm>
             <glossdef>
                 <para>
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index af64d344..396056ed 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -16,6 +16,7 @@ import re
 import os
 import bb.utils
 from bb.parse import ParseError, resolve_file, ast, logger, handle
+from collections import deque
 
 __config_regexp__  = re.compile( r"""
     ^
@@ -46,6 +47,7 @@ __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.]+)\]$" )
+include_stack = deque()
 
 def init(data):
     topdir = data.getVar('TOPDIR', False)
@@ -89,6 +91,9 @@ def include_single_file(parentfn, fn, lineno, data, error_out):
     elif bb.parse.check_dependency(data, fn):
         logger.warning("Duplicate inclusion for %s in %s" % (fn, data.getVar('FILE')))
 
+    include_stack.append(parentfn)
+    data.setVar('BBINCLUDESTACK', ' '.join(include_stack))
+
     try:
         bb.parse.handle(fn, data, True)
     except (IOError, OSError) as exc:
@@ -101,6 +106,8 @@ def include_single_file(parentfn, fn, lineno, data, error_out):
                 raise ParseError("Could not %s file %s: %s" % (error_out, fn, exc.strerror), parentfn, lineno)
             else:
                 raise ParseError("Error parsing %s: %s" % (fn, exc.strerror), parentfn, lineno)
+    finally:
+        include_stack.pop()
 
 # We have an issue where a UI might want to enforce particular settings such as
 # an empty DISTRO variable. If configuration files do something like assigning
