Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail.openembedded.org (Postfix) with ESMTP id 412B57C3BE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 16:58:58 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id y139so7366821wmc.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 08:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=o/PijOk1ASKyOnRCGevyvPA8BqbCPrGfwq1AbW0Wkhk=;
	b=WUTbs6IWi6OUJy9GvKD07qYmq1QNqhQmZs4LR7Nq+BK7TfUN8G4jOoQ13YGGUB4gfX
	i/isyspAB53XMf8tZSMusvAU8zn2i8x1On2V/3uU4wTvb3bcEI4K0uCODNnu93AE1fhp
	QF31gWUk3OViFaqgxAywW35JOHmLdgey3msM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=o/PijOk1ASKyOnRCGevyvPA8BqbCPrGfwq1AbW0Wkhk=;
	b=AxQdU6/u/PNQv542TDvq1OOjmnDnJxC1WalWcxxW1RlPzgF+BCeGCDghbl3/y1IBeF
	BKL7BdIoEyXLQk3HF3Cky7Rb/P+u3QEfuzfdSTcwoYyWsFrVzCQf4ONXJAfWNak1BNog
	bihS7GHAHtcYt1dY6llvzz4aoLSIHw9fVA5pjahuh4ZhwMcEyG43Lysdx+b9ILJtEMZl
	mbchoTzgCvEWOZSZ+KVDxWfYfNhdCIcB6pZLljXfN4lQn9wnASd1TB+C8jf1N7glcQEp
	WevJPGd0RtoqYFME1vTQwxLOxigx8zxUTIgLuXac67PQmcwa2UdIx6WX2y+n983Fb8CF
	eRvQ==
X-Gm-Message-State: AJcUukfQwfMIukmjR5E1Bm5opWb46min5txjBgulX80vLgYJF6aKVhK5
	5oXzLfQ2DqytL+zwRIh3ZBIrv5oSvUk=
X-Google-Smtp-Source: ALg8bN5MWV2IXM6NmSmPn5feZtLnxh9ET08/xLSTgehEMK0iCvQ2UwLAHAk7xo2yR6sy0E1OdbO7hg==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr7379682wmd.112.1548435539379;
	Fri, 25 Jan 2019 08:58:59 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l14sm206802283wrp.55.2019.01.25.08.58.58
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 25 Jan 2019 08:58:58 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Jan 2019 16:58:57 +0000
Message-Id: <20190125165857.4627-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH] package: Add pkg_postinst_ontarget to PACKAGEVARS
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
X-List-Received-Date: Fri, 25 Jan 2019 16:58:59 -0000
Content-Transfer-Encoding: 8bit

Changes to pkg_postinst_ontarget were not triggering rebuilds, this fixes
that.

[YOCTO #13127]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 meta/classes/package.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/classes/package.bbclass b/meta/classes/package.bbclass
index 853735f0c64..7dd1b09a874 100644
--- a/meta/classes/package.bbclass
+++ b/meta/classes/package.bbclass
@@ -2123,7 +2123,7 @@ python package_depchains() {
 
 # Since bitbake can't determine which variables are accessed during package
 # iteration, we need to list them here:
-PACKAGEVARS = "FILES RDEPENDS RRECOMMENDS SUMMARY DESCRIPTION RSUGGESTS RPROVIDES RCONFLICTS PKG ALLOW_EMPTY pkg_postinst pkg_postrm INITSCRIPT_NAME INITSCRIPT_PARAMS DEBIAN_NOAUTONAME ALTERNATIVE PKGE PKGV PKGR USERADD_PARAM GROUPADD_PARAM CONFFILES SYSTEMD_SERVICE LICENSE SECTION pkg_preinst pkg_prerm RREPLACES GROUPMEMS_PARAM SYSTEMD_AUTO_ENABLE SKIP_FILEDEPS PRIVATE_LIBS"
+PACKAGEVARS = "FILES RDEPENDS RRECOMMENDS SUMMARY DESCRIPTION RSUGGESTS RPROVIDES RCONFLICTS PKG ALLOW_EMPTY pkg_postinst pkg_postrm pkg_postinst_ontarget INITSCRIPT_NAME INITSCRIPT_PARAMS DEBIAN_NOAUTONAME ALTERNATIVE PKGE PKGV PKGR USERADD_PARAM GROUPADD_PARAM CONFFILES SYSTEMD_SERVICE LICENSE SECTION pkg_preinst pkg_prerm RREPLACES GROUPMEMS_PARAM SYSTEMD_AUTO_ENABLE SKIP_FILEDEPS PRIVATE_LIBS"
 
 def gen_packagevar(d):
     ret = []
-- 
2.19.1


