Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
	[209.85.214.175])
	by mail.openembedded.org (Postfix) with ESMTP id 051D47EABB
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:04 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id b7so2352584pls.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=XrOABJFA1xQe5XQNBYrSyibf/229tYTIPCPN4272Px4=;
	b=NivfGAG9eyOTTPp1kAv/E0oq7RsLlmnGRx/HtS54OGQmuSxmFxjRIITZqc7bp8Mia3
	zqVD5qYqluEwrUeU30OZL3e5wfFb5XL+TJlYpRCnTytkCGwpIzlKEzoj/4J/zSSeowSB
	7O8cxBBxh9De+hGuvUckvopIuywE+yKzbRKum98fLBOz/A52pGXP7/q5BZ/GbLgcZDVU
	yn5X/rCvRhVRMfe4QL4c17HX7pL2P4yxbNGzNQzx6gidu7TPYVYS8Ji3e+XWkag1xUsR
	kuzyT7icbOk3jYNG0//TinRERYY4HiyE4yNgAXp6EJYMIRWBJE8WcCAlWxZpYJNM++uG
	i5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=XrOABJFA1xQe5XQNBYrSyibf/229tYTIPCPN4272Px4=;
	b=rNq4wxh8TVqL/Kquo15FJknu9x1+Pr2rRKR3DtGRdHZoX+9gmcH6ndYBqVS3OTD7aD
	3cLk5C/BIAexpshI1esc6KSxoTQ9Gd8znAoc7683X7nOjoKbqzf9u5IycMZ1HfkbBLPE
	lDHfnkuYttTtSp3Y106MDV7QVIfIpG86+ro+KM9UYWtumJdjVbPgJ4WJxQN4y+x0uwZ/
	YPp0J8fuqozJiq9+cKVFWeV/Q+h1gmaJ5dbQE+XqJDh1AegLYGcZcqJdFKbSlZnhLIvn
	hAfHnbp5QAIX4E9DM34A9/BU2au6we3TP+lfTmDw7oYckfW+bXR0oPHKjsQPzqyFwbx3
	VvGA==
X-Gm-Message-State: APjAAAVPpxeLDneHJ7asYEuUn8aDCAsDQjdpl2ueO51pEu4BG4/uZaAy
	4bH/iYfsEkz9X5HdxGMmo4eYUYb6
X-Google-Smtp-Source: APXvYqwq2L/dYs38QsJZNZRcYYxoKX0G/mcHemwvPbtKL6WeEk7VByF7fb57ApwiHImhRdB0t6MJkw==
X-Received: by 2002:a17:902:341:: with SMTP id
	59mr45797002pld.20.1560621066041; 
	Sat, 15 Jun 2019 10:51:06 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.05
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:05 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:36 -0700
Message-Id: <95ab6fa926bd29112e7f80899d91575054037b61.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 06/23] triggerhappy: fix issues
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:05 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* using PN instead of BPN in S causes all tasks to fail:
  make: *** No targets specified and no makefile found.  Stop.
* using github archives is bad, because they are regenerated from time to time
  with different checksums
* set PV, because this isn't exactly 0.5.0, because of the debian changes
  mostly the systemd support
* fix indentation

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../{triggerhappy_0.5.0.bb => triggerhappy_git.bb} | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)
 rename meta-oe/recipes-extended/triggerhappy/{triggerhappy_0.5.0.bb => triggerhappy_git.bb} (73%)

diff --git a/meta-oe/recipes-extended/triggerhappy/triggerhappy_0.5.0.bb b/meta-oe/recipes-extended/triggerhappy/triggerhappy_git.bb
similarity index 73%
rename from meta-oe/recipes-extended/triggerhappy/triggerhappy_0.5.0.bb
rename to meta-oe/recipes-extended/triggerhappy/triggerhappy_git.bb
index 037ce06..24df750 100644
--- a/meta-oe/recipes-extended/triggerhappy/triggerhappy_0.5.0.bb
+++ b/meta-oe/recipes-extended/triggerhappy/triggerhappy_git.bb
@@ -4,12 +4,12 @@ HOMEPAGE = "https://github.com/wertarbyte/triggerhappy"
 LICENSE = "GPLv3"
 LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"
 
-SRC_URI = "https://github.com/wertarbyte/triggerhappy/archive/debian/0.5.0-1.tar.gz"
+# matches debian/0.5.0-1 tag
+SRCREV = "44a173195986d0d853316cb02a58785ded66c12b"
+PV = "0.5.0+git${SRCPV}"
+SRC_URI = "git://github.com/wertarbyte/${BPN}.git;branch=debian"
 
-SRC_URI[md5sum] = "77f90a18c775e47c4c5e9e08987ca32f"
-SRC_URI[sha256sum] = "9150bafbf7f2de7d57e6cc154676c33da98dc11ac6442e1ca57e5dce82bd4292"
-
-S = "${WORKDIR}/${PN}-debian-${PV}-1"
+S = "${WORKDIR}/git"
 
 inherit autotools-brokensep pkgconfig update-rc.d systemd
 
@@ -21,12 +21,12 @@ INITSCRIPT_PARAMS = "defaults"
 SYSTEMD_SERVICE_${PN} = "triggerhappy.service triggerhappy.socket"
 
 FILES_${PN} = "\
-${sbindir}/thd \
-${sbindir}/th-cmd \
-${sysconfdir}/triggerhappy/triggers.d \
-${nonarch_base_libdir}/udev/rules.d/80-triggerhappy.rules \
-${sysconfdir}/init.d/triggerhappy \
-${systemd_unitdir}/system \
+    ${sbindir}/thd \
+    ${sbindir}/th-cmd \
+    ${sysconfdir}/triggerhappy/triggers.d \
+    ${nonarch_base_libdir}/udev/rules.d/80-triggerhappy.rules \
+    ${sysconfdir}/init.d/triggerhappy \
+    ${systemd_unitdir}/system \
 "
 CONFFILES_${PN} = "${sysconfdir}/udev/rules.d/80-triggerhappy.rules"
 
-- 
2.7.4


