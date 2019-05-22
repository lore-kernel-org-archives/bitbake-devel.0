Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f194.google.com (mail-it1-f194.google.com
	[209.85.166.194])
	by mail.openembedded.org (Postfix) with ESMTP id 0E2896C44A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2019 13:35:19 +0000 (UTC)
Received: by mail-it1-f194.google.com with SMTP id u186so3082457ith.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2019 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Myc5DmxPfS0NHmw5FMZnwnbdA9XxGGgmivcxcmqGFck=;
	b=k1jldF3X9+MPpfTDUbXLD6T2Q0SFt0mO3sDhQ7Z9lWq1/QwbWu2tWzD1iQC6ngZ0eQ
	fNxvN40qtfNPNUoexEr4uGgvosmIyeumqtfS5s+Fpm9JiVITTrtZ43BU+NLWCNY7MxV0
	rlQ/8VEfcqsU6Vcf8ZtWbfagB4iue8ygNJFPzcpVPy7XoWWLWP4TR7LmcSqxKEjrI5TG
	Kq90QEJYZel9LUscXlc9J0W7hmFs6QIoQGTeCqhAWslAdUAZ6sEZsb58c5nTC65m2Fxv
	9eAjYZEq/UfCWU8wET3IWvUVTqBi2QNnMNf/vJ4TQqfUqGoTANnEDwRQ0xtJTE1CoAAF
	5ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Myc5DmxPfS0NHmw5FMZnwnbdA9XxGGgmivcxcmqGFck=;
	b=nz698Qd4RJe/58YuIRnJXXPVciDqtC2SoMgG0aPJxp5dwrIRSbUCsQ1PvoT9JdUFIA
	TM0IVfJ2Zh9Sf7QQrlVcc6Vpfcp0tk8s2l0pktyIAeekmn3fTOJwtO86wdg/LMnqnslM
	5zKca2ugStfX4btaZGLW3TjlH9xoZ+PYwMJ2rpvWceJS74bE6f+UJ3Q1lc8PXzcRDhHs
	fIC/qoW/PLyYVqrQJEQahubYH6Tm1XduFa3qqSr9U5vlf0tly4On0DCzOIPE+Wsln6ci
	Me3Ylh/2EeQJa6CLfR52T3diN6WeOzsqnyAdmkFaUVDnPhuCi18zaWRc4OW35kwnQ8wd
	QFLQ==
X-Gm-Message-State: APjAAAXKCDegX4PtthFGB1FIXnzq510pOCG+A5u2p5/MZ0XlCQOMM6J3
	ULwueUe1fsyhsQcfPU8CAPFh4/hi
X-Google-Smtp-Source: APXvYqwddLu/fiHUhO/WH/Pp9L7Vg1NBm0lNdX2pD1do23XCCYZluf5Y4oRUkb1AcbKDY9YuNOXsgQ==
X-Received: by 2002:a05:6638:518:: with SMTP id
	i24mr23900718jar.3.1558532120764; 
	Wed, 22 May 2019 06:35:20 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id o7sm7504091ioa.67.2019.05.22.06.35.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 06:35:19 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 May 2019 08:35:03 -0500
Message-Id: <20190522133503.14212-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521214942.3300-1-JPEWhacker@gmail.com>
References: <20190521214942.3300-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [PATCH v2] bitbake: cooker: Rename __depends in all multiconfigs
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
X-List-Received-Date: Wed, 22 May 2019 13:35:20 -0000
Content-Transfer-Encoding: 8bit

The renaming of the __depends variable to __base_depends and file
watches needs to occurs for all multiconfigs, not just the base config.
Failing to do this for all multiconfigs will result in a huge increase
in the size of the parsing cache (about 5x for a single mulitconfig)
because all multiconfig caches will still depend on the base config
files. This will also seen a similar jump in the amount of time required
to load the parsing cache from memory, both because the cache is larger
and because of explosion of additional existence checks that must be
done for the base files.

[YOCTO #13359]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index adc41014e6..78658a1683 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -391,8 +391,9 @@ class BBCooker:
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.disableDataTracking()
 
-        self.data.renameVar("__depends", "__base_depends")
-        self.add_filewatch(self.data.getVar("__base_depends", False), self.configwatcher)
+        for mc in self.databuilder.mcdata.values():
+            mc.renameVar("__depends", "__base_depends")
+            self.add_filewatch(mc.getVar("__base_depends", False), self.configwatcher)
 
         self.baseconfig_valid = True
         self.parsecache_valid = False
-- 
2.21.0


