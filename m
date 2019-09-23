Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com
	[209.85.166.50])
	by mail.openembedded.org (Postfix) with ESMTP id D2BB07DE37
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Sep 2019 18:21:16 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id b136so35858627iof.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Sep 2019 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DtPBh/Li15EfDi8OQE59CE/2vgVNqL/NfD7rGuJ3QHU=;
	b=iNKcgP2Q0CH24+GlSDa/yELsbsvP0De7fcjfxuZG9P1u1kEpo9GpU064y80X0mUugT
	sS/G5NtwVqy8j4fsP5jvvBbfttyUU52HyzBtVaSy/awX29uAOtC6BKL+9eFIiVz5i8zN
	1BB7h2DL5uWczv2jp2ExdLSK2SK0cUi6Y3clu+LvsX1E0RDW2wB8I3OdOIy/r0ew0GEs
	aHItX7uUZXcvyDrpFd0GSMwm9YCKdxIwbfIc7M9fCocDtkoGZ6pqgNjoK7gDUPBM05sB
	FfVJrU37irvO5WJZmKrNOQ9Km7L9+PM6V9VGgc7+tNFQRuFVIcctE2rgzFRYb8P38sgI
	e5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DtPBh/Li15EfDi8OQE59CE/2vgVNqL/NfD7rGuJ3QHU=;
	b=l41r/WVq903R6Oknbj/ep33TctyK1qShhYxM5tALUF9DR4Do+I9LKNNyuoArWvKcSR
	BNcHEZZ8O+5XGZswy8AzPQ12TZHw629Fr5GuynLvTg03MP6GLyUxWsx6XCbqJWbU3bBv
	ggRIQe6I160zTBYpDnno3l0L0IQRl2++c+h4+goZ6Jt+GAUL8C2uZbIkHIF8k5d/YgKI
	Ii6DBzaVxpVQxCk7wAsuoZRuxCchpNswnRbcTLP7/tnfHQmbeKRcU5gSWL9rdrglY4/C
	xs7GAe8/4lnC6WVpUqQq9+V+JTeIjaZGDggJ6d6oAly/vzHDBYN1rKej4ApFnfZ9IJId
	eLhg==
X-Gm-Message-State: APjAAAXW/XgAMs9zhQzRTCCp0A+gpcvujPYHTxgZqW4kozv8bF9MrpHL
	3EG09h3lljP1XVXRp1SJnBY9X5hi
X-Google-Smtp-Source: APXvYqysgwnNsST6Ehgwd+Ogji3tHax3STxw8EM+fRVqZIM8ppwJn73Q2PBNrm9+Qj/Qi13zcxjXEA==
X-Received: by 2002:a02:344a:: with SMTP id z10mr793341jaz.123.1569262877469; 
	Mon, 23 Sep 2019 11:21:17 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	n17sm10114154ioj.73.2019.09.23.11.21.16
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 23 Sep 2019 11:21:16 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Sep 2019 13:21:11 -0500
Message-Id: <20190923182111.30212-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: zbooth.dev@gmail.com
Subject: [PATCH] cookerdata: Add mc conffiles hashes to cache hash
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
X-List-Received-Date: Mon, 23 Sep 2019 18:21:17 -0000
Content-Transfer-Encoding: 8bit

The variable values that result from parsing multiconfig should be
included in the cooker data hash, otherwise changes to these files won't
be detected, which will allow the parsing cache to be loaded with the
old values for the multiconfigs. This can either manifest as the
variable values simply not updating, or getting basehash changed errors
when building.

This bug was previously undetected because all of the multiconfig base
files were a direct file dependency in all parsed recipes. This was
fixed in 34137a00f60 ("bitbake: bitbake: cooker: Rename __depends in all
multiconfigs"), exposing this bug.

[YOCTO #13541]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cookerdata.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 96a8e6beeec..472423fdc87 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -13,6 +13,7 @@ import logging
 import os
 import re
 import sys
+import hashlib
 from functools import wraps
 import bb
 from bb import data
@@ -267,6 +268,7 @@ class CookerDataBuilder(object):
         self.mcdata = {}
 
     def parseBaseConfiguration(self):
+        data_hash = hashlib.sha256()
         try:
             self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
 
@@ -290,7 +292,7 @@ class CookerDataBuilder(object):
                 bb.event.fire(bb.event.ConfigParsed(), self.data)
 
             bb.parse.init_parser(self.data)
-            self.data_hash = self.data.get_hash()
+            data_hash.update(self.data.get_hash().encode('utf-8'))
             self.mcdata[''] = self.data
 
             multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()
@@ -298,9 +300,11 @@ class CookerDataBuilder(object):
                 mcdata = self.parseConfigurationFiles(self.prefiles, self.postfiles, config)
                 bb.event.fire(bb.event.ConfigParsed(), mcdata)
                 self.mcdata[config] = mcdata
+                data_hash.update(mcdata.get_hash().encode('utf-8'))
             if multiconfig:
                 bb.event.fire(bb.event.MultiConfigParsed(self.mcdata), self.data)
 
+            self.data_hash = data_hash.hexdigest()
         except (SyntaxError, bb.BBHandledException):
             raise bb.BBHandledException
         except bb.data_smart.ExpansionError as e:
-- 
2.21.0


