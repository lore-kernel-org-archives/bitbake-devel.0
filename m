Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE54C369D0
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 15:16:01 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.14033.1744989354130985027
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Apr 2025 08:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=l+fBPyk5;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9340A43AD2;
	Fri, 18 Apr 2025 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744989352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWcqKlg09Esy79STkp7CZIrl3Mslfy7ayKbDuBc/ehw=;
	b=l+fBPyk5K9ft4+laSPSF5c9i0BR5YB4TP09J1HukJYYeoVMv/CG3eDurR75aQjqk1Rbko8
	LsSOyR32anaku0aVWkHMcympzpr4NCQ/KJnezUs+nZGjh62BUu6BRulJPZM9x6EflezLqo
	QYIBmKqbSqXei4r5exnvzwE3/QgAKyAvkM0YaIWZRCfcUMzxC70fnWDVKz/ox4okGB6Kiz
	DIupPLgygUNJ6DpuRNmgrn83qkamLUkydzBEUIyzRSQ2hPLl9YccAYj8McotJHyTtoLdJT
	46t0HcyidMVUZa6EPkKrp8NhXdkD2E+LCzQ5o1LHp/hFrn0v/TS9dIV65wlI8g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 18 Apr 2025 17:15:27 +0200
Subject: [PATCH 3/4] doc: add a new Library Functions document
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-library-functions-v1-3-3bbb836149d7@bootlin.com>
References: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
In-Reply-To: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3634;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=yrQIBiVItr880uZuRAulQK83XYcPiBBYAWjCAgxBedA=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoAmynqRDYqtLjauV7IPoVqpclfIqVyoRiiMNbl
 y++HsEIbvCJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaAJspwAKCRDRgEFAKaOo
 Npe3D/9RaDPO53U6xP61lOEGLVwP/M9yTgQYo9Y/609J3Fi6qNyaEjGmmbxa7zyvdNxUFntSoks
 SlMa0VfguwS4nWmHiclO1mQ6GmYlvGiLH5aF3SGEzg7BfE2fh5mTDJqP3o5Q6pYWXvghLL9biXG
 FpyR5W8F8HKHS3+TCN6DLLF3Hpzh8a7pzCPMIVe6qVmWMBk7ZNgwuyltB4QpN+hgrNADk0vBvlH
 f7ZkAC4QTskaqsPRKWo+ZfxU2NZmLZiHhwBP5S9MEeKGW9RPWzXtP07uIkSGNEr0RKd78DsnLca
 S1ImUgQy3KSl8AZ1PlMDsenfYLPeJQLS60PU5Px1yMCfW/Rij9zUMT1IsiSdiWKQ8ORGt3aqcvF
 EdRtbH6zxXRuRrCNKNgkxk7F7HDZzxiN25pHWY8hmude+R18h8iUnSMPD0TaHo/EMJq+aRn20Ei
 DXRDNOK02QofuqYMYDOxulM76I6HXLk8e2aCPs6L5nJV0mXKoz7/lG+PrCOEVo/Z4NxXdawDHHp
 wOouSjkvOrl0bUzgVOA39fCYCJ3HQZQY+85TuT5I9xFDDBrlHxKCbAKyiimWF1g3iFfB7g7ycsw
 /FFTQhAdfHZ3ouKEKihNTuwG2QVmosyHImqu/nsjiyugYhAHV1jCRm+6ZxOwqxFPlsFAxEKvbkF
 f12sm046eJtRbtA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmedujegtvdemfeekjegrmehfieehmeehvdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemudejtgdvmeefkeejrgemfheiheemhedvfeehpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhoj
 hgvtghtrdhorhhgpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Apr 2025 15:16:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17537

Add a new document to the BitBake user manual that automatically
documents the library functions from their docstrings. The docstrings
can be formatted in reStructuredText.

Here logging utilities and the bb.utils module is documented. Some
members of the utils module were deliberately excluded as their usage is
most likely only internal to BitBake.

Fixes [YOCTO #9612]

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-library-functions.rst      | 59 ++++++++++++++++++++++
 doc/conf.py                                        |  7 +++
 doc/index.rst                                      |  1 +
 3 files changed, 67 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst b/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst
new file mode 100644
index 000000000..09e353945
--- /dev/null
+++ b/doc/bitbake-user-manual/bitbake-user-manual-library-functions.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: CC-BY-2.5
+
+=================
+Library Functions
+=================
+
+|
+
+This chapter lists common library functions available under the ``lib/``
+directory in BitBake.
+
+These functions can be used in recipes or configuration files with
+:ref:`inline-Python <bitbake-user-manual/bitbake-user-manual-metadata:Inline
+Python Variable Expansion>` or :ref:`Python
+<bitbake-user-manual/bitbake-user-manual-metadata:BitBake-Style Python
+Functions>` functions.
+
+Logging utilities
+=================
+
+Different logging utilities can be used from Python code in recipes or
+configuration files.
+
+The strings passed below can be formatted with ``str.format()``, for example::
+
+   bb.warn("Houston, we have a %s", "bit of a problem")
+
+Formatted string can also be used directly::
+
+   bb.error("%s, we have a %s" % ("Houston", "big problem"))
+
+Python f-strings may also be used::
+
+   h = "Houston"
+   bb.fatal(f"{h}, we have a critical problem")
+
+.. automodule:: bb
+   :members:
+      debug,
+      error,
+      erroronce,
+      fatal,
+      note,
+      plain,
+      verbnote,
+      warn,
+      warnonce,
+
+``bb.utils``
+============
+
+.. automodule:: bb.utils
+   :members:
+   :exclude-members:
+      LogCatcher,
+      PrCtlError,
+      VersionStringException,
+      better_compile,
+      better_exec,
diff --git a/doc/conf.py b/doc/conf.py
index fc2ee0811..f61241e28 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -17,6 +17,8 @@
 import sys
 import datetime
 
+from pathlib import Path
+
 current_version = "dev"
 
 # String used in sidebar
@@ -47,6 +49,7 @@ extlinks = {
 extensions = [
     'sphinx.ext.autosectionlabel',
     'sphinx.ext.extlinks',
+    'sphinx.ext.autodoc',
 ]
 autosectionlabel_prefix_document = True
 
@@ -99,3 +102,7 @@ html_last_updated_fmt = '%b %d, %Y'
 
 # Remove the trailing 'dot' in section numbers
 html_secnumber_suffix = " "
+
+# autoconf needs the modules available to auto-generate documentation from the
+# code
+sys.path.insert(0, str(Path('..', 'lib').resolve()))
diff --git a/doc/index.rst b/doc/index.rst
index ee1660ac1..546ef36c1 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -16,6 +16,7 @@ BitBake User Manual
    bitbake-user-manual/bitbake-user-manual-ref-variables-context
    bitbake-user-manual/bitbake-user-manual-fetching
    bitbake-user-manual/bitbake-user-manual-ref-variables
+   bitbake-user-manual/bitbake-user-manual-library-functions
    bitbake-user-manual/bitbake-user-manual-hello
 
 .. toctree::

-- 
2.47.0


