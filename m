Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by mail.openembedded.org (Postfix) with ESMTP id 8160F7E3EB
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:11 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id c14so2364999plo.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=wIyn74LDC4SUJLEJ3sb9ZEvu00jX+RARb2fvWovKxYg=;
	b=atWqu6EBBTSoPQwlKuebPqZvpCh7d6lLvoxpVxWcP0sd6hAsnK/BX/QXOUI8wzGlI+
	bl3xM1Q5LtE3+p2j1vtahVsdK+mWlipqLRAZfMwdFkYE/5iAzfQXgyS2czYgRwxEcb+u
	Pra+UZjPgb2yYho9UkuUGOf+75RZZMEaHeO3BlLsMWpEXN7HNz8Mdx87WZ/XZ0iFgTyv
	zqdfj1cWwX4suUMoyqX9xvHBrE4o2bnwXPVeCpnn3vuinLZCQWKS8D9NiJwovVLQ0Lh4
	X01/ejgUQmgOrqmSGK4WS8iNoiAwkeL8lz02hvqsU6OlyZMCztbvcnRwMXOLK0QgxdSy
	a8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=wIyn74LDC4SUJLEJ3sb9ZEvu00jX+RARb2fvWovKxYg=;
	b=QVRJFVHGu0qdolX/k48N6Mw3z19usiwDF/7UHp2rcLq9FOMXus8j3/4uKk3V4KdMxa
	3drzVBPVs3dZO7C/xkBSe6f1dlsYa6kJIAvbXACuBs90OPF7lErO/6xpEuhuAoKEvLgO
	pWWw+NADlwixVINDq+w0G8JS8notPNxI2VbPyztcGZuRVz4ocpyg8qqQDgNen5+JRL+6
	rgLXaex2YsQyDYNWIBo38JgzoC1n0lwSFPas05TJ7FtQfD3fk42zOHDQwtp2hc4VhP5/
	ks8JynZxjglayV5Mx+ve19KXM7w37/MbTB60HXKG5TutXz7hGf2LUprUwxi6HEsQXkPL
	q3Og==
X-Gm-Message-State: APjAAAXiqua9i45p59xPQHh5jIW4psJk4JPHB51MVRLIvnZsPVGTxN+8
	GwIUF95l5zOyeL66LxVDD2X/um1K
X-Google-Smtp-Source: APXvYqywHZAbo+MCjpWfyc/ma7L6Vm3n/il19t8XKv5xDprIJnoXLL03UNk36SvlFY44r6FN306u8w==
X-Received: by 2002:a17:902:e282:: with SMTP id
	cf2mr77031537plb.301.1560621072389; 
	Sat, 15 Jun 2019 10:51:12 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.11
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:12 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:44 -0700
Message-Id: <d102c4e29e4bc5af10422aa9161a869e32c116b0.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 14/23] hunspell: use git fetcher instead of github archive
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:11 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* fixes:
  ERROR: QA Issue: https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz: SRC_URI uses unstable GitHub archives [src-uri-bad]
* there is developer uploaded tarball in:
  https://github.com/hunspell/hunspell/files/2573619/hunspell-1.7.0.tar.gz
  but it's already reconfigured which we don't need, so I've used git fetcher
  to stay closer to what we already use.
* the diff between:
  https://github.com/hunspell/hunspell/files/2573619/hunspell-1.7.0.tar.gz
  and
  https://github.com/hunspell/hunspell/archive/v1.7.0.tar.gz

docker-shr @ ~/hunspell $ diff -rq hunspell-1.7.0*/
Only in hunspell-1.7.0-archive/: .gitignore
Only in hunspell-1.7.0-archive/: .travis.yml
Only in hunspell-1.7.0-archive/: COPYING.MPL
Only in hunspell-1.7.0/: INSTALL
Only in hunspell-1.7.0/: Makefile.in
Only in hunspell-1.7.0-archive/: README.md
Only in hunspell-1.7.0/: aclocal.m4
Only in hunspell-1.7.0-archive/: appveyor.yml
Only in hunspell-1.7.0/: compile
Only in hunspell-1.7.0/: config.guess
Only in hunspell-1.7.0/: config.h.in
Only in hunspell-1.7.0/: config.sub
Only in hunspell-1.7.0/: configure
Only in hunspell-1.7.0/: depcomp
Only in hunspell-1.7.0/: install-sh
Only in hunspell-1.7.0/: ltmain.sh
Only in hunspell-1.7.0-archive/m4: ChangeLog
Only in hunspell-1.7.0-archive/m4: README
Only in hunspell-1.7.0/m4: libtool.m4
Only in hunspell-1.7.0/m4: ltoptions.m4
Only in hunspell-1.7.0/m4: ltsugar.m4
Only in hunspell-1.7.0/m4: ltversion.m4
Only in hunspell-1.7.0/m4: lt~obsolete.m4
Only in hunspell-1.7.0/man: Makefile.in
Only in hunspell-1.7.0/man/hu: Makefile.in
Only in hunspell-1.7.0/: missing
Only in hunspell-1.7.0-archive/: msvc
Only in hunspell-1.7.0-archive/po: .gitignore
Only in hunspell-1.7.0/po: ca.gmo
Files hunspell-1.7.0-archive/po/ca.po and hunspell-1.7.0/po/ca.po differ
Only in hunspell-1.7.0/po: de.gmo
Files hunspell-1.7.0-archive/po/de.po and hunspell-1.7.0/po/de.po differ
Only in hunspell-1.7.0/po: es.gmo
Files hunspell-1.7.0-archive/po/es.po and hunspell-1.7.0/po/es.po differ
Only in hunspell-1.7.0/po: hu.gmo
Files hunspell-1.7.0-archive/po/hu.po and hunspell-1.7.0/po/hu.po differ
Files hunspell-1.7.0-archive/po/hunspell.pot and hunspell-1.7.0/po/hunspell.pot differ
Only in hunspell-1.7.0/po: it.gmo
Files hunspell-1.7.0-archive/po/it.po and hunspell-1.7.0/po/it.po differ
Only in hunspell-1.7.0/po: pl.gmo
Files hunspell-1.7.0-archive/po/pl.po and hunspell-1.7.0/po/pl.po differ
Only in hunspell-1.7.0/po: pt_BR.gmo
Files hunspell-1.7.0-archive/po/pt_BR.po and hunspell-1.7.0/po/pt_BR.po differ
Only in hunspell-1.7.0/po: tg.gmo
Files hunspell-1.7.0-archive/po/tg.po and hunspell-1.7.0/po/tg.po differ
Only in hunspell-1.7.0/src: Makefile.in
Only in hunspell-1.7.0/src/hunspell: Makefile.in
Only in hunspell-1.7.0-archive/src/parsers: .gitignore
Only in hunspell-1.7.0/src/parsers: Makefile.in
Only in hunspell-1.7.0-archive/src/tools: .gitignore
Only in hunspell-1.7.0/src/tools: Makefile.in
Only in hunspell-1.7.0-archive/src/tools: fuzzer.cxx
Only in hunspell-1.7.0/: tap-driver.sh
Only in hunspell-1.7.0/: test-driver
Only in hunspell-1.7.0-archive/tests: .gitattributes
Only in hunspell-1.7.0-archive/tests: .gitignore
Only in hunspell-1.7.0/tests: Makefile.in
Only in hunspell-1.7.0-archive/tests: hu.wrong
Only in hunspell-1.7.0-archive/tests: nepali.wrong
Only in hunspell-1.7.0-archive/tests: ph2.good
Only in hunspell-1.7.0-archive/tests/suggestiontest: .gitignore
Only in hunspell-1.7.0/tests/suggestiontest: Makefile.in
Only in hunspell-1.7.0-archive/tests/suggestiontest: prepare2
Only in hunspell-1.7.0-archive/tests: wordpair.good

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-oe/recipes-support/hunspell/hunspell_1.7.0.bb | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/meta-oe/recipes-support/hunspell/hunspell_1.7.0.bb b/meta-oe/recipes-support/hunspell/hunspell_1.7.0.bb
index 40da3b4..c2fb4fa 100644
--- a/meta-oe/recipes-support/hunspell/hunspell_1.7.0.bb
+++ b/meta-oe/recipes-support/hunspell/hunspell_1.7.0.bb
@@ -6,9 +6,10 @@ LIC_FILES_CHKSUM = " \
     file://COPYING.LESSER;md5=c96ca6c1de8adc025adfada81d06fba5 \
 "
 
-SRC_URI = "https://github.com/${BPN}/${BPN}/archive/v${PV}.tar.gz"
-SRC_URI[md5sum] = "b2399a4aa927e8b3e171d9ea6737cc02"
-SRC_URI[sha256sum] = "bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a"
+SRCREV = "4ddd8ed5ca6484b930b111aec50c2750a6119a0f"
+SRC_URI = "git://github.com/${BPN}/${BPN}.git"
+
+S = "${WORKDIR}/git"
 
 inherit autotools pkgconfig gettext
 
-- 
2.7.4


