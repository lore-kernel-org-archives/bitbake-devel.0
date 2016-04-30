Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id 27667760B0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:52:59 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id 145so15351846pfz.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=2Za4ZGehTBtdpCv3OXLIUTF3G0Kj194HXXGBJotwYbw=;
	b=SZL+pyCg7u/6I7E6KdAQMqK+Fhc3KxCgN+oNo5Yl3u7e6PaV0t1FsW40ercpV/ouQJ
	H8j1YuhM5Zgz5wsi9kYeOTHcFQT3fD0pBQ6m8v3GyL0c6Y7iADwHrTsC5gjkq6e9GFar
	1V1WqX9S3YzvQZGW5Ha5Ui01bxK8SxSyuorFB/lq2DgcMAIsiMWOzil7fxsugMSSFNiB
	Fz7EEanpvIeHBstNYaLx2C0lmjD6KwP9sUfldbtggvmFATnQ1Bp61AVarfZQ+2z+LfOG
	T9r7Z8twosdwZZ8AOWVZor1P9tSxmpruld9AVDdZ5yGr5NgIg0qn+ev/kJ+7Is6dCAPG
	s9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=2Za4ZGehTBtdpCv3OXLIUTF3G0Kj194HXXGBJotwYbw=;
	b=dYL/XmA5qVee/CY5l0stCGBmjgwxuClfi3jHdGMbsbuMrhTqBCCOyfuIep/Dc/LLiL
	CSKduZqiLDnw2qmYdiOPhPvQutVL077r2QtNNR5zUjntzblmYLJJxMxkTmPWKsZQQPEg
	xzupdD/kjBVsMcsU97gumGDEPjThXWl/5SA4UgKcusg6RJ9agW1GwMTMjNCwrTqcfkGL
	JFnTfK4rppKAuKXdI+VAWXLaj+hkcnUAQFDM2FszmMqIY+muzI3ZL15GjDEDPa3m1rfq
	LmYwd7BzMfp9Ooybcq17323EWE0M570bQ+YoIcFZI2Bg8GwRLGt3yjo0rxMC3m+kaKeX
	V0mA==
X-Gm-Message-State: AOPr4FU1N8R0mTNyS6vxc4DxQS6tvOLN0ojFRI/mu+RKMFtL1WTH4hlVGL1kw4tK2XIBJw==
X-Received: by 10.98.82.208 with SMTP id g199mr39198902pfb.113.1462045980801; 
	Sat, 30 Apr 2016 12:53:00 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	z2sm33247522pfa.90.2016.04.30.12.52.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:52:59 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:52:49 -0700
Message-Id: <1462045969-14538-5-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
References: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH] Provide LAYERDIR_RE for layer.conf
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
X-List-Received-Date: Sat, 30 Apr 2016 19:53:00 -0000

From: Christopher Larson <chris_larson@mentor.com>

This variable is a regex-escaped version of LAYERDIR, for safer use in
BBFILE_PATTERN, so as to avoid issues with regex special characters in the
layer path.

[YOCTO #8402]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-hello.xml         |  2 +-
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml | 11 +++++++++++
 lib/bb/cookerdata.py                                          |  9 +++++++--
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.xml b/doc/bitbake-user-manual/bitbake-user-manual-hello.xml
index f6d82b4..8b7edbf 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.xml
@@ -399,7 +399,7 @@ ERROR: Unable to parse base: ParseError in configuration INHERITs: Could not inh
      <link linkend='var-BBFILES'>BBFILES</link> += "${LAYERDIR}/*.bb"
 
      <link linkend='var-BBFILE_COLLECTIONS'>BBFILE_COLLECTIONS</link> += "mylayer"
-     <link linkend='var-BBFILE_PATTERN'>BBFILE_PATTERN_mylayer</link> := "^${LAYERDIR}/"
+     <link linkend='var-BBFILE_PATTERN'>BBFILE_PATTERN_mylayer</link> := "^${LAYERDIR_RE}/"
                 </literallayout>
                 For information on these variables, click the links
                 to go to the definitions in the glossary.</para>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
index ae7e4ce..4d06ff9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
@@ -1636,6 +1636,17 @@
             </glossdef>
         </glossentry>
 
+        <glossentry id='var-LAYERDIR_RE'><glossterm>LAYERDIR_RE</glossterm>
+            <glossdef>
+                <para>When used inside the <filename>layer.conf</filename> configuration
+                    file, this variable provides the path of the current layer,
+                    escaped for use in a regular expression
+                    (<link linkend='var-BBFILE_PATTERN'><filename>BBFILE_PATTERN</filename></link>).
+                    This variable is not available outside of <filename>layer.conf</filename>
+                    and references are expanded immediately when parsing of the file completes.</para>
+            </glossdef>
+        </glossentry>
+
         <glossentry id='var-LAYERVERSION'><glossterm>LAYERVERSION</glossterm>
             <glossdef>
                 <para>Optionally specifies the version of a layer as a single number.
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 50259a9..2b11717 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -22,9 +22,11 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-import os, sys
-from functools import wraps
 import logging
+import os
+import re
+import sys
+from functools import wraps
 import bb
 from bb import data
 import bb.parse
@@ -295,9 +297,12 @@ class CookerDataBuilder(object):
                 if layer.endswith('/'):
                     layer = layer.rstrip('/')
                 data.setVar('LAYERDIR', layer)
+                data.setVar('LAYERDIR_RE', re.escape(layer))
                 data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
                 data.expandVarref('LAYERDIR')
+                data.expandVarref('LAYERDIR_RE')
 
+            data.delVar('LAYERDIR_RE')
             data.delVar('LAYERDIR')
 
         if not data.getVar("BBPATH", True):
-- 
2.8.0


