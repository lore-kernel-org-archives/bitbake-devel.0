Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87CDF33837
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 10:08:57 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.72668.1773742134472112746
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Mar 2026 03:08:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=C/yiFCrn;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1A863C5505A
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:09:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 206E560050;
	Tue, 17 Mar 2026 10:08:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3756310450452;
	Tue, 17 Mar 2026 11:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773742129; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wwpQW9mWKbuzMuyKUcHjXZ2tIQFntUWd39UP37vFCBI=;
	b=C/yiFCrnpHWe8ydhRis1unChTZ7WGdSM9/42zbD7VwCEU79VAQ+WCmlhaP+8+Sq7zyJiaT
	7oSTejCF74XOSRc1nLpMqomoIhAsqplqFG199Fua9+oemHhBcly3eUADkUjDlgbfH6ZVTJ
	figvkoUISmxzVpSUpWCFcVjcOMLVRSiaq5MiDbrz+mgYOdQudGsjYV952YU7tIlYoefXth
	KQhYGMhoml1kjbYXxabxlBGbyOvq8Dgc+IsYNqBEaGGfr29BbrpbIa6SowVDZntLInwX3i
	pC9CiljZw4uN3eJPbcNNdhMEAFa/WTA5FT3gSvq6WGBen05rwY5RiMNC3qzTJQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Mar 2026 11:08:40 +0100
Subject: [PATCH 5/5] doc: generate the releases.rst file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-docs-releases-json-v1-5-492d0b256349@bootlin.com>
References: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
In-Reply-To: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=21071;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=8rC8QFNqPXGHVHDW7K8vvzWF3SM83sDGXsoSrjdtBE0=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuSgr24v5PlyCwslNGkpvmhV8keC7IRQdl0C1d
 WcASgjNmv6JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCabkoKwAKCRDRgEFAKaOo
 Nh14EACdUbug8TIj1mxdsslEQ5lrWaEw4yrFaV1/Q02gZl+ST9Sd9VU91tyQ7UPeEp7rKors06S
 bKKlwa+jROUH/93TmuGQQ5ONymaxaY/Km+yr0ep5DVk9uI+TpakKMx8VpRn1zJrug/DRVARme6Z
 2yyKK4G5wGCK7PzjFLq6BZhURJKCgDsVYrrUjbMsYktgvsSr8oDiHV8uwWGPdjMex3x0O2vd2++
 WMYaa1cmN+ckt3/NEDmTu026xvE3NqwYYeH5cXgJmyPC4v/dgUzdGI5evoLywIAwEsJB3IylRgI
 hBnBWCdcICouucskOa7WiU0cbTEoObqNovstjnC7sNKbGJeUMb853aRTZhCeZ8tlcQkXwbFkJQN
 500vbJ1yOVhRaZGXV5WicfFwc3oCerr/9gm2cPXdtwf2GWp7ZIhf5LF2U2xYB+AqduecM/97KaO
 jypWRGhuVMRKcw8ZPpjIcrSxXVMd+mVxPhzKXGbatS3tE3vVeK39R7m8GNQqSjHKdsy+Ab9dmP+
 cuWxA0rVlF72shBBwsZecIkpn+0mUAqEKyG7XWgX863NZr4SB2Gzy+Jj+pC69HZLPmRc5JACUUJ
 KBr1cDUyhHWDW/UsxtsOEdlG4xjrrMyBf2071g0xr/qltqg0WIElq5d2cfM2CB43cwU7GADLY3t
 STZzKd4hixKkuCg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:08:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19164

Use the information we gather from releases.json to automatically create
the supported and outdated releases document.

The older releases do not follow the same linking scheme, so add them
statically at the bottom of the file from script.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/.gitignore     |   1 +
 doc/Makefile       |   2 +-
 doc/conf.py        |   2 +
 doc/releases.rst   | 199 -----------------------------------------------------
 doc/setversions.py | 191 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 195 insertions(+), 200 deletions(-)

diff --git a/doc/.gitignore b/doc/.gitignore
index 1ee009c2012..3a570d8c655 100644
--- a/doc/.gitignore
+++ b/doc/.gitignore
@@ -1,3 +1,4 @@
 _build/
 sphinx-static/switchers.js
 releases.json
+releases.rst
diff --git a/doc/Makefile b/doc/Makefile
index 752f9b53b3e..2f8e898c4fc 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -27,7 +27,7 @@ publish: Makefile html singlehtml
 	sed -i -e 's@index.html#@singleindex.html#@g' $(BUILDDIR)/$(DESTDIR)/singleindex.html
 
 clean:
-	@rm -rf $(BUILDDIR) sphinx-static/switchers.js releases.json
+	@rm -rf $(BUILDDIR) sphinx-static/switchers.js releases.json releases.rst
 
 # Catch-all target: route all unknown targets to Sphinx using the new
 # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
diff --git a/doc/conf.py b/doc/conf.py
index 315fb7d06a7..9a53e55c938 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -39,6 +39,8 @@ setversions.write_switchers_js("sphinx-static/switchers.js.in",
                                "sphinx-static/switchers.js",
                                current_version)
 
+setversions.write_releases_rst("releases.rst")
+
 # -- Project information -----------------------------------------------------
 
 project = 'Bitbake'
diff --git a/doc/releases.rst b/doc/releases.rst
deleted file mode 100644
index a0b0ce766ea..00000000000
--- a/doc/releases.rst
+++ /dev/null
@@ -1,199 +0,0 @@
-.. SPDX-License-Identifier: CC-BY-2.5
-
-=================================
-BitBake Supported Release Manuals
-=================================
-
-*******************************
-Release Series 5.3 (whinlatter)
-*******************************
-
-- :yocto_docs:`BitBake 2.16 User Manual </bitbake/2.16/>`
-
-*******************************
-Release Series 5.0 (scarthgap)
-*******************************
-
-- :yocto_docs:`BitBake 2.8 User Manual </bitbake/2.8/>`
-
-******************************
-Release Series 4.0 (kirkstone)
-******************************
-
-- :yocto_docs:`BitBake 2.0 User Manual </bitbake/2.0/>`
-
-================================
-BitBake Outdated Release Manuals
-================================
-
-******************************
-Release Series 5.2 (walnascar)
-******************************
-
-- :yocto_docs:`BitBake 2.12 User Manual </bitbake/2.12/>`
-
-****************************
-Release Series 5.1 (styhead)
-****************************
-
-- :yocto_docs:`BitBake 2.10 User Manual </bitbake/2.10/>`
-
-*******************************
-Release Series 4.3 (nanbield)
-*******************************
-
-- :yocto_docs:`BitBake 2.6 User Manual </bitbake/2.6/>`
-
-*******************************
-Release Series 4.2 (mickledore)
-*******************************
-
-- :yocto_docs:`BitBake 2.4 User Manual </bitbake/2.4/>`
-
-*****************************
-Release Series 4.1 (langdale)
-*****************************
-
-- :yocto_docs:`BitBake 2.2 User Manual </bitbake/2.2/>`
-
-******************************
-Release Series 3.4 (honister)
-******************************
-
-- :yocto_docs:`BitBake 1.52 User Manual </bitbake/1.52/>`
-
-******************************
-Release Series 3.3 (hardknott)
-******************************
-
-- :yocto_docs:`BitBake 1.50 User Manual </bitbake/1.50/>`
-
-*******************************
-Release Series 3.2 (gatesgarth)
-*******************************
-
-- :yocto_docs:`BitBake 1.48 User Manual </bitbake/1.48/>`
-
-****************************
-Release Series 3.1 (dunfell)
-****************************
-
-- :yocto_docs:`BitBake 1.46 User Manual </bitbake/1.46/>`
-- :yocto_docs:`3.1 BitBake User Manual </3.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.1 BitBake User Manual </3.1.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.2 BitBake User Manual </3.1.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.1.3 BitBake User Manual </3.1.3/bitbake-user-manual/bitbake-user-manual.html>`
-
-*************************
-Release Series 3.0 (zeus)
-*************************
-
-- :yocto_docs:`3.0 BitBake User Manual </3.0/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.0.1 BitBake User Manual </3.0.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.0.2 BitBake User Manual </3.0.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.0.3 BitBake User Manual </3.0.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`3.0.4 BitBake User Manual </3.0.4/bitbake-user-manual/bitbake-user-manual.html>`
-
-****************************
-Release Series 2.7 (warrior)
-****************************
-
-- :yocto_docs:`2.7 BitBake User Manual </2.7/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.7.1 BitBake User Manual </2.7.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.7.2 BitBake User Manual </2.7.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.7.3 BitBake User Manual </2.7.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.7.4 BitBake User Manual </2.7.4/bitbake-user-manual/bitbake-user-manual.html>`
-
-*************************
-Release Series 2.6 (thud)
-*************************
-
-- :yocto_docs:`2.6 BitBake User Manual </2.6/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.6.1 BitBake User Manual </2.6.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.6.2 BitBake User Manual </2.6.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.6.3 BitBake User Manual </2.6.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.6.4 BitBake User Manual </2.6.4/bitbake-user-manual/bitbake-user-manual.html>`
-
-*************************
-Release Series 2.5 (sumo)
-*************************
-
-- :yocto_docs:`2.5 Documentation </2.5>`
-- :yocto_docs:`2.5.1 Documentation </2.5.1>`
-- :yocto_docs:`2.5.2 Documentation </2.5.2>`
-- :yocto_docs:`2.5.3 Documentation </2.5.3>`
-
-**************************
-Release Series 2.4 (rocko)
-**************************
-
-- :yocto_docs:`2.4 BitBake User Manual </2.4/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.4.1 BitBake User Manual </2.4.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.4.2 BitBake User Manual </2.4.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.4.3 BitBake User Manual </2.4.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.4.4 BitBake User Manual </2.4.4/bitbake-user-manual/bitbake-user-manual.html>`
-
-*************************
-Release Series 2.3 (pyro)
-*************************
-
-- :yocto_docs:`2.3 BitBake User Manual </2.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.3.1 BitBake User Manual </2.3.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.3.2 BitBake User Manual </2.3.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.3.3 BitBake User Manual </2.3.3/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.3.4 BitBake User Manual </2.3.4/bitbake-user-manual/bitbake-user-manual.html>`
-
-**************************
-Release Series 2.2 (morty)
-**************************
-
-- :yocto_docs:`2.2 BitBake User Manual </2.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.2.1 BitBake User Manual </2.2.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.2.2 BitBake User Manual </2.2.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.2.3 BitBake User Manual </2.2.3/bitbake-user-manual/bitbake-user-manual.html>`
-
-****************************
-Release Series 2.1 (krogoth)
-****************************
-
-- :yocto_docs:`2.1 BitBake User Manual </2.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.1.1 BitBake User Manual </2.1.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.1.2 BitBake User Manual </2.1.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.1.3 BitBake User Manual </2.1.3/bitbake-user-manual/bitbake-user-manual.html>`
-
-***************************
-Release Series 2.0 (jethro)
-***************************
-
-- :yocto_docs:`1.9 BitBake User Manual </1.9/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.0 BitBake User Manual </2.0/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.0.1 BitBake User Manual </2.0.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.0.2 BitBake User Manual </2.0.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.0.3 BitBake User Manual </2.0.3/bitbake-user-manual/bitbake-user-manual.html>`
-
-*************************
-Release Series 1.8 (fido)
-*************************
-
-- :yocto_docs:`1.8 BitBake User Manual </1.8/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`1.8.1 BitBake User Manual </1.8.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`1.8.2 BitBake User Manual </1.8.2/bitbake-user-manual/bitbake-user-manual.html>`
-
-**************************
-Release Series 1.7 (dizzy)
-**************************
-
-- :yocto_docs:`1.7 BitBake User Manual </1.7/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`1.7.1 BitBake User Manual </1.7.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`1.7.2 BitBake User Manual </1.7.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`1.7.3 BitBake User Manual </1.7.3/bitbake-user-manual/bitbake-user-manual.html>`
-
-**************************
-Release Series 1.6 (daisy)
-**************************
-
-- :yocto_docs:`1.6 BitBake User Manual </1.6/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`1.6.1 BitBake User Manual </1.6.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`1.6.2 BitBake User Manual </1.6.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`1.6.3 BitBake User Manual </1.6.3/bitbake-user-manual/bitbake-user-manual.html>`
-
diff --git a/doc/setversions.py b/doc/setversions.py
index bcc3194b63c..82a0e8b191b 100755
--- a/doc/setversions.py
+++ b/doc/setversions.py
@@ -19,6 +19,7 @@ import os
 import re
 import subprocess
 import sys
+import textwrap
 
 from urllib.request import urlopen, URLError
 
@@ -152,3 +153,193 @@ def write_switchers_js(js_in, js_out, current_version):
             else:
                 w.write(line)
         print("switchers.js generated from switchers.js.in")
+
+def _release_section(series_version: str, codename: str, bitbake_version: str) -> str:
+    """
+    Helper function to generate a release section, as:
+
+    ********************
+    Release Series xxxxx
+    ********************
+
+    - <link to manual>
+    """
+    section_length = len(series_version) + len(codename) + 18
+    return textwrap.dedent(
+        f"""\
+        {'*' * section_length}
+        Release Series {series_version} ({codename})
+        {'*' * section_length}
+
+        - :yocto_docs:`BitBake {bitbake_version} User Manual </bitbake/{bitbake_version}/>`
+
+        """)
+
+def write_releases_rst(releases_rst_out: str):
+    """
+    Generates the releases.rst file automatically, based on what is found
+    in the releases.json file.
+    """
+    with open(releases_rst_out, "w") as f:
+        f.write(textwrap.dedent("""\
+            .. SPDX-License-Identifier: CC-BY-2.5
+
+            =================================
+            BitBake Supported Release Manuals
+            =================================
+
+            """))
+
+        for release in RELEASES_FROM_JSON:
+            if release["status"] == "Active Development":
+                continue
+
+            if not release["bitbake_version"]:
+                continue
+
+            if release["series"] == "current":
+                f.write(_release_section(
+                    release["series_version"],
+                    release["release_codename"],
+                    release["bitbake_version"]))
+
+        f.write(textwrap.dedent("""\
+            ================================
+            BitBake Outdated Release Manuals
+            ================================
+
+            """))
+
+        for release in RELEASES_FROM_JSON:
+            if not release["series"] == "previous":
+                continue
+
+            if not release["bitbake_version"]:
+                continue
+
+            f.write(_release_section(
+                release["series_version"],
+                release["release_codename"],
+                release["bitbake_version"]))
+
+        # old legacy links, which cannot be auto-generated
+        f.write(textwrap.dedent(
+            """\
+            - :yocto_docs:`3.1.2 BitBake User Manual </3.1.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`3.1 BitBake User Manual </3.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`3.1.1 BitBake User Manual </3.1.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`3.1.3 BitBake User Manual </3.1.3/bitbake-user-manual/bitbake-user-manual.html>`
+
+            *************************
+            Release Series 3.0 (Zeus)
+            *************************
+
+            - :yocto_docs:`3.0 BitBake User Manual </3.0/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`3.0.1 BitBake User Manual </3.0.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`3.0.2 BitBake User Manual </3.0.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`3.0.3 BitBake User Manual </3.0.3/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`3.0.4 BitBake User Manual </3.0.4/bitbake-user-manual/bitbake-user-manual.html>`
+
+            ****************************
+            Release Series 2.7 (Warrior)
+            ****************************
+
+            - :yocto_docs:`2.7 BitBake User Manual </2.7/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.7.1 BitBake User Manual </2.7.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.7.2 BitBake User Manual </2.7.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.7.3 BitBake User Manual </2.7.3/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.7.4 BitBake User Manual </2.7.4/bitbake-user-manual/bitbake-user-manual.html>`
+
+            *************************
+            Release Series 2.6 (Thud)
+            *************************
+
+            - :yocto_docs:`2.6 BitBake User Manual </2.6/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.6.1 BitBake User Manual </2.6.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.6.2 BitBake User Manual </2.6.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.6.3 BitBake User Manual </2.6.3/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.6.4 BitBake User Manual </2.6.4/bitbake-user-manual/bitbake-user-manual.html>`
+
+            *************************
+            Release Series 2.5 (Sumo)
+            *************************
+
+            - :yocto_docs:`2.5 Documentation </2.5>`
+            - :yocto_docs:`2.5.1 Documentation </2.5.1>`
+            - :yocto_docs:`2.5.2 Documentation </2.5.2>`
+            - :yocto_docs:`2.5.3 Documentation </2.5.3>`
+
+            **************************
+            Release Series 2.4 (Rocko)
+            **************************
+
+            - :yocto_docs:`2.4 BitBake User Manual </2.4/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.4.1 BitBake User Manual </2.4.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.4.2 BitBake User Manual </2.4.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.4.3 BitBake User Manual </2.4.3/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.4.4 BitBake User Manual </2.4.4/bitbake-user-manual/bitbake-user-manual.html>`
+
+            *************************
+            Release Series 2.3 (Pyro)
+            *************************
+
+            - :yocto_docs:`2.3 BitBake User Manual </2.3/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.3.1 BitBake User Manual </2.3.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.3.2 BitBake User Manual </2.3.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.3.3 BitBake User Manual </2.3.3/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.3.4 BitBake User Manual </2.3.4/bitbake-user-manual/bitbake-user-manual.html>`
+
+            **************************
+            Release Series 2.2 (Morty)
+            **************************
+
+            - :yocto_docs:`2.2 BitBake User Manual </2.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.2.1 BitBake User Manual </2.2.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.2.2 BitBake User Manual </2.2.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.2.3 BitBake User Manual </2.2.3/bitbake-user-manual/bitbake-user-manual.html>`
+
+            ****************************
+            Release Series 2.1 (Krogoth)
+            ****************************
+
+            - :yocto_docs:`2.1 BitBake User Manual </2.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.1.1 BitBake User Manual </2.1.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.1.2 BitBake User Manual </2.1.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.1.3 BitBake User Manual </2.1.3/bitbake-user-manual/bitbake-user-manual.html>`
+
+            ***************************
+            Release Series 2.0 (Jethro)
+            ***************************
+
+            - :yocto_docs:`1.9 BitBake User Manual </1.9/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.0 BitBake User Manual </2.0/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.0.1 BitBake User Manual </2.0.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.0.2 BitBake User Manual </2.0.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`2.0.3 BitBake User Manual </2.0.3/bitbake-user-manual/bitbake-user-manual.html>`
+
+            *************************
+            Release Series 1.8 (Fido)
+            *************************
+
+            - :yocto_docs:`1.8 BitBake User Manual </1.8/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`1.8.1 BitBake User Manual </1.8.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`1.8.2 BitBake User Manual </1.8.2/bitbake-user-manual/bitbake-user-manual.html>`
+
+            **************************
+            Release Series 1.7 (Dizzy)
+            **************************
+
+            - :yocto_docs:`1.7 BitBake User Manual </1.7/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`1.7.1 BitBake User Manual </1.7.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`1.7.2 BitBake User Manual </1.7.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`1.7.3 BitBake User Manual </1.7.3/bitbake-user-manual/bitbake-user-manual.html>`
+
+            **************************
+            Release Series 1.6 (Daisy)
+            **************************
+
+            - :yocto_docs:`1.6 BitBake User Manual </1.6/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`1.6.1 BitBake User Manual </1.6.1/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`1.6.2 BitBake User Manual </1.6.2/bitbake-user-manual/bitbake-user-manual.html>`
+            - :yocto_docs:`1.6.3 BitBake User Manual </1.6.3/bitbake-user-manual/bitbake-user-manual.html>`
+            """))

-- 
2.53.0


