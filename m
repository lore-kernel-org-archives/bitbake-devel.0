Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
	[209.85.214.179])
	by mail.openembedded.org (Postfix) with ESMTP id 09C607EAA2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:51:05 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id ay6so127823plb.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=rToy6SWR1WeBgJNHmahxF+2jTL7UJcdPygjl82UcyVM=;
	b=XF7dM22Bp/kQ2GLTB6JKiGL3oSWccKYaw5YD6kmsJdu/M3mrcRhDqeIj4WzSYsl9Yg
	2ewZ8Og0EtC/v+BLDiWCa3CFo1nH/FTAjvRR1pjgRPkKdoPWrOXvWomV+wt2nKnIYEGK
	5N9Fi3La/NHB+huhZlieykhoOyn8glZeTMeuQ/3IfCDH/uxqu72i45oDKfNpdLsw8Lk+
	qvN+XGV6EK7l4oiZ1oIXRRE82hF65XTtjYlxYHCbp0fW9lXy1dIAiXW/Y9DI2t7bhPfg
	KwsiX9624UMUXjmJrBQYwh/VT+P34mzfemzkq4Shzm3odamj/O19Y17HLofYv4y0FuG9
	czlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=rToy6SWR1WeBgJNHmahxF+2jTL7UJcdPygjl82UcyVM=;
	b=qDw2EYQ0KlR2+i7OkG+G6wCmC9Qtdv99kNwRavtahPEuC94rCED+rETCjhexxss+mN
	OwsK/RPW7U/9H3r5RLQ8zjSCWvjiLADc4x7WZ4swNFmEnDK1D6XekJlL154V2wlM2u9q
	5Ww1ZStr6TF0YHD/YP0Bd4DuNS7j4B9wOyKn00sJvk9U94hHDvVDd8RHD2np6cOlVbn4
	T1Pd8dXsisOgABYkq5kgWpy0f1HL7ireA33FPXKbZTrfP5YX14UjnbPuWn0R4zpGRpS1
	yRaAL7DFH4CnpHmBwFsqdgnRKZwUOql5HLvD/fQ25X/NQYhoOJuZAuBZhZ0iYDyPje63
	sCOg==
X-Gm-Message-State: APjAAAUG4BauRtZn/kUpuu+/oAVfShY3lkbNSvG5WNYgZNgGMDVs2ejc
	0ZqR1kjNo1m9iYw3t+izPGBbxRU3
X-Google-Smtp-Source: APXvYqzdrKuVAUTrfBSxwe+PAFab8psuAq3pqbf5POqV87dXGYS/W2oOo/Hv4njSUR6NIgkXLm/k7w==
X-Received: by 2002:a17:902:4c:: with SMTP id
	70mr74428173pla.308.1560621067020; 
	Sat, 15 Jun 2019 10:51:07 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id x5sm6622470pjp.21.2019.06.15.10.51.06
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 15 Jun 2019 10:51:06 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 10:50:37 -0700
Message-Id: <cff942d012135c7e67cee4583cfe6c7a8444e778.1560620937.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
References: <cover.1560620937.git.akuster808@gmail.com>
Subject: [Warror][ 07/23] python-cassandra-driver.inc: fix DEPENDS
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
X-List-Received-Date: Sat, 15 Jun 2019 17:51:06 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* there is no such thing as DEPENDS_${PN}

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-python/recipes-devtools/python/python-cassandra-driver.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-python/recipes-devtools/python/python-cassandra-driver.inc b/meta-python/recipes-devtools/python/python-cassandra-driver.inc
index 1cc1f4c..53ebfec 100644
--- a/meta-python/recipes-devtools/python/python-cassandra-driver.inc
+++ b/meta-python/recipes-devtools/python/python-cassandra-driver.inc
@@ -28,6 +28,6 @@ RDEPENDS_${PN} += "\
     libevent \
 "
 
-DEPENDS_${PN} += "\
+DEPENDS += "\
     ${PYTHON_PN}-cython \
 "
-- 
2.7.4


