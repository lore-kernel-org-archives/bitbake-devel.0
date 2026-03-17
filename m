Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A0AF3383D
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 10:08:58 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.72669.1773742134482446345
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Mar 2026 03:08:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=CoRqbVzE;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 195FAC55059
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:09:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65E9C6003C;
	Tue, 17 Mar 2026 10:08:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DBD610450451;
	Tue, 17 Mar 2026 11:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773742128; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UW6ZP52706CRGSl1x5Y8LlDxeJRhtlVOmn23SELbxwo=;
	b=CoRqbVzE1V4Wgb5ziJz3p8lDlzH0MAKJAAhzkET/IIb5Vqll0foHXhnjf/eHLd0nnwFSW5
	p/uGo8hMV8dL3yZXNyY3neQAuRR/cBZFeNb+Puf/hLz8JxmiUbryouWi6YLy7WFXkDyWZE
	udbCdCPs/lBeEfN9nXYojlMOfmcJj5w0apwAfqA4Pd3JIZLrxEJnvbeRQ3GROkmhgwp5fW
	zuk810f0cReyTfTIG0P4co3Ll5J4QDs80VG05FVdZh9oHZrohXjwrL6IAUgmGHHoq5Ysc2
	//qAp8Ym79odhasZq3gQjoXLuMFobbxYVahandeLqg/x21w7TLuarn4HZcu73Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Mar 2026 11:08:39 +0100
Subject: [PATCH 4/5] doc: build using remote releases.json
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-docs-releases-json-v1-4-492d0b256349@bootlin.com>
References: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
In-Reply-To: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4223;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ngZ+rrsxtF5KxJEmcdhfJGyJuxOhBqYFd916F7TpBqk=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuSgrVQw0U5eOVYcL+INyBWA681dXsZDkyy0s4
 +qFJJU4WOyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCabkoKwAKCRDRgEFAKaOo
 NuEuEACmjIKW5SkF3NldZRvO1VIXWnchHwiACWoGUVvYkheqlKTxrd0e5vQ3/lRqA2N3lG3b5K2
 Dhjsvr7XJ3SU0pMSEJl6JR9l7l8+n85l3+iT1LJzedq1fUcjsnJ8wKrk7UJW5hjCPGOGFkhMFkF
 Dhdf8GxZVQG8sh7LYE91JhNrnvf6RcwYqI0DZ512BvWp5pjZ6vmKyGxjzApYkojPhKdjAVw0Mzj
 G8gmVeo61bJpMGBDYDZRFS4N9TwObKgE9KErW5F1dNa/75pHzPo15nlhN9SJseUQAJ7Ib0QbSPd
 Ts+dxd8r6n5xGPFLFlc/I1rNaCwPgcrscLIMU661PdwtvYzJHz1V3YGtYT0se9LKOJ/FAmWyaTx
 9XP5CtfzyZ24tP0+BdjXoq5P+JAjyukIzCTWXDd9h6jhMZT0cjXbEvMn4FG+PeOEVNBL0uhgYye
 9sGSAVGUOVdEfblAXWcyRpQlnrBNVqEUhMo/ppVZVkRVmv9DQAlzoYdLemSRXW9gJfrUX/AnCbJ
 5+ChHw8pbF8mt4441yMbSof71thehISEMEe+JKDmjZIHa07QEXjrwSZ+/FIYqLV/qV+Xe7IlJfg
 teCvXAi0xFREu4qvNV53tTpcL8RFZZB1L+XAy3nTfACLQq7oA3xk+AR51ecdwtdv72U4bxDhMW3
 17v8juLeCBp8Ftg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:08:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19163

Like what was done for yocto-docs[1], build using the remote
releases.json file we can fetch from [2].

The file is downloaded if not present, and not re-downloaded for
subsequent builds. In case of fetch failure, fallback to default values.

[1]: https://git.yoctoproject.org/yocto-docs/commit/?id=5bebe38a808a33fea3deefc21dda39a35d90a7dd
[2]: https://dashboard.yoctoproject.org/releases.json

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/.gitignore     |  1 +
 doc/Makefile       |  2 +-
 doc/setversions.py | 59 +++++++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/doc/.gitignore b/doc/.gitignore
index dee9494dcaf..1ee009c2012 100644
--- a/doc/.gitignore
+++ b/doc/.gitignore
@@ -1,2 +1,3 @@
 _build/
 sphinx-static/switchers.js
+releases.json
diff --git a/doc/Makefile b/doc/Makefile
index 5e1632314c5..752f9b53b3e 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -27,7 +27,7 @@ publish: Makefile html singlehtml
 	sed -i -e 's@index.html#@singleindex.html#@g' $(BUILDDIR)/$(DESTDIR)/singleindex.html
 
 clean:
-	@rm -rf $(BUILDDIR) sphinx-static/switchers.js
+	@rm -rf $(BUILDDIR) sphinx-static/switchers.js releases.json
 
 # Catch-all target: route all unknown targets to Sphinx using the new
 # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
diff --git a/doc/setversions.py b/doc/setversions.py
index 967a0ba5a64..bcc3194b63c 100755
--- a/doc/setversions.py
+++ b/doc/setversions.py
@@ -14,30 +14,69 @@
 #
 
 import itertools
+import json
+import os
 import re
 import subprocess
 import sys
 
+from urllib.request import urlopen, URLError
+
+# NOTE: the following variables contain default values in case we are not able to fetch
+# the releases.json file from https://dashboard.yoctoproject.org/releases.json
 DEVBRANCH = "2.18"
 LTSSERIES = ["2.8", "2.0"]
 ACTIVERELEASES = ["2.16"] + LTSSERIES
-
 YOCTO_MAPPING = {
     "2.18": "wrynose",
     "2.16": "whinlatter",
-    "2.12": "walnascar",
-    "2.10": "styhead",
     "2.8": "scarthgap",
-    "2.6": "nanbield",
-    "2.4": "mickledore",
-    "2.2": "langdale",
     "2.0": "kirkstone",
-    "1.52": "honister",
-    "1.50": "hardknott",
-    "1.48": "gatesgarth",
-    "1.46": "dunfell",
 }
 
+RELEASES_FROM_JSON = {}
+
+# Use the local releases.json file if found, fetch it from the dashboard otherwise
+releases_json_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "releases.json")
+try:
+    with open(releases_json_path, "r") as f:
+        RELEASES_FROM_JSON = json.load(f)
+except FileNotFoundError:
+    print("Fetching releases.json from https://dashboard.yoctoproject.org/releases.json...",
+          file=sys.stderr)
+    try:
+        with urlopen("https://dashboard.yoctoproject.org/releases.json") as r, \
+                open(releases_json_path, "w") as f:
+            RELEASES_FROM_JSON = json.load(r)
+            json.dump(RELEASES_FROM_JSON, f)
+    except URLError:
+        print("WARNING: tried to fetch https://dashboard.yoctoproject.org/releases.json "
+              "but failed, using default values for active releases", file=sys.stderr)
+        pass
+
+if RELEASES_FROM_JSON:
+    ACTIVERELEASES = []
+    DEVBRANCH = ""
+    LTSSERIES = []
+    YOCTO_MAPPING = {}
+
+    for release in RELEASES_FROM_JSON:
+        bb_ver = release["bitbake_version"]
+        if release["status"] == "Active Development":
+            DEVBRANCH = bb_ver
+        if release["series"] == "current":
+            ACTIVERELEASES.append(bb_ver)
+        if "LTS until" in release["status"]:
+            LTSSERIES.append(bb_ver)
+        if release["bitbake_version"]:
+            YOCTO_MAPPING[bb_ver] = release["release_codename"]
+
+    ACTIVERELEASES.remove(DEVBRANCH)
+
+print(f"ACTIVERELEASES calculated to be {ACTIVERELEASES}", file=sys.stderr)
+print(f"DEVBRANCH calculated to be {DEVBRANCH}", file=sys.stderr)
+print(f"LTSSERIES calculated to be {LTSSERIES}", file=sys.stderr)
+
 BB_RELEASE_TAG_RE = re.compile(r"^[0-9]+\.[0-9]+\.[0-9]+$")
 
 def get_current_version():

-- 
2.53.0


