Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
	[209.85.214.176])
	by mail.openembedded.org (Postfix) with ESMTP id 74EB47EAA6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:03 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id c14so2364921plo.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=JKgax1/JA3rG3mIzzlJvX+0nubFO07ESn0wG0YJ8qEs=;
	b=nLrDI41jFlDrXtwNJqu6MU4vwphRyiqPb4d8Gm/ukihlw1UOPOuDCyrIKFSJ4prNpR
	QQhpdSxhCDzMjYuq+m28aTZrMZ49jmhyTpAyQya4OluJs7ug/gKXzvpnTbPTUnguZ5Mh
	p+DHWvFdHjma8CX0xRPISKRjesP4YPgc5UqM4lyC/xjoljVSRE8tT+4d9GKw6hkgyTx2
	2WGb2xs9/MufW2OyVoLk4qw0QcQqYUbzLnrVTLYzEUXs6r5aAEaAGsfER/MZlaHA+Xz6
	ZF39ntauR71jX79+Mva3VJ/0N/6vkyWBfumsxKvyWbJh2trL78sysb1kFgYBQt28ttDR
	YkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=JKgax1/JA3rG3mIzzlJvX+0nubFO07ESn0wG0YJ8qEs=;
	b=p7gnLsKOpNcklxQUrG5QTWC41S8uvs2R/QZT3RzJE59hBIw4z8a3Bwr83VpZXPg4IO
	XxQoTR4WW+/KfrsqBAhWX/5/V/WfyC/UUWk1TPVouRgPJpD39MfCmIDPue6qi5AAEXhO
	YUzB8k64+nkQvH31K/xRsH4pvykrWPtZxgRVQ4DGzWzNkuNIEV5Q1b+O1M66SuqG0v7Y
	fEjCE6x4Zo8a9kKPKz2e/Q1xk3NPJynxZYgDu3GrRiFaRkdVIlzgBQuy59F0djv8Sesn
	EaRxRh+5NdmJFVBtgE3ggobwYhG4QP0cfcr/ovBTPv862rrpmHlFzUdplrNnaaor8BWF
	KE4g==
X-Gm-Message-State: APjAAAUhgau8TN4stPTsMqN1F039+AFZMabnJqQeF0chBS7xTR5kMCnk
	pCLdUmwBK7FKl2QOA5p3GJgSmHEt
X-Google-Smtp-Source: APXvYqwivLFpzwz4jqwq9fA2tHFAqu6zKNf14HcWIsILmSnhHCXdIs+ZJhu8hIoIZVHSpG/RZB0LsA==
X-Received: by 2002:a17:902:b609:: with SMTP id
	b9mr20509341pls.8.1560621064369; 
	Sat, 15 Jun 2019 10:51:04 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.03
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:03 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:34 -0700
Message-Id: <21fb7771ece4e7e3efb19d394c55acfeda3009b1.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 04/23] umip: make MACHINE_ARCH
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:03 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* Depends on ipsec-tools which is already MACHINE_ARCH (and also RRECOMMENDS kernel modules)
* Fixes:
  ERROR: umip different signature for task do_configure.sigdata between hammerhead and mako
  Hash for dependent task umip/umip_1.0.bb.do_prepare_recipe_sysroot changed from 7c74a208880f6c8a5aa46b1c8577e39b6b71429d9a379ea75f17a155ca270035 to 87c6cd438dd9645c98530e3ac1094005bace785bfd89bfe4073bc8815926abba
  Unable to find matching sigdata for /OE/build/luneos-master/webos-ports/meta-openembedded/meta-networking/recipes-connectivity/umip/umip_1.0.bb.do_prepare_recipe_sysroot with hashes 7c74a208880f6c8a5aa46b1c8577e39b6b71429d9a379ea75f17a155ca270035 or 87c6cd438dd9645c98530e3ac1094005bace785bfd89bfe4073bc8815926abba

  bitbake-diffsigs /OE/build/luneos-master/webos-ports/tmp-glibc/sstate-diff/1557963509/[hm]*/*/umip/*do_prepare*.sigdata*
  Hash for dependent task ipsec-tools/ipsec-tools_0.8.2.bb.do_populate_sysroot changed from 1100c4984d88050bb7ca154445205bac3c3ab80c3ff0aa7c9124825c9d4f6e14 to feeddbd35a8106b264c98076e21d0b3cb227ab1d209e150926112b2906273ef4
  Unable to find matching sigdata for /OE/build/luneos-master/webos-ports/meta-openembedded/meta-networking/recipes-support/ipsec-tools/ipsec-tools_0.8.2.bb.do_populate_sysroot with hashes 1100c4984d88050bb7ca154445205bac3c3ab80c3ff0aa7c9124825c9d4f6e14 or feeddbd35a8106b264c98076e21d0b3cb227ab1d209e150926112b2906273ef4

  as detected with:
  openembedded-core/scripts/sstate-diff-machines.sh --targets=world --tmpdir=tmp-glibc/ --analyze --machines="hammerhead mako qemux86"

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-networking/recipes-connectivity/umip/umip_1.0.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta-networking/recipes-connectivity/umip/umip_1.0.bb b/meta-networking/recipes-connectivity/umip/umip_1.0.bb
index e2abc02..43367b5 100644
--- a/meta-networking/recipes-connectivity/umip/umip_1.0.bb
+++ b/meta-networking/recipes-connectivity/umip/umip_1.0.bb
@@ -20,6 +20,9 @@ SRC_URI = "git://git.umip.org/umip/umip.git \
            "
 SRCREV = "cbd441c5db719db554ff2b4fcb02fef88ae2f791"
 
+# Depends on ipsec-tools which is already MACHINE_ARCH (and also RRECOMMENDS kernel modules)
+PACKAGE_ARCH = "${MACHINE_ARCH}"
+
 S = "${WORKDIR}/git"
 
 EXTRA_OECONF = "--enable-vt"
-- 
2.7.4


