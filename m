Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
	[209.85.128.194])
	by mail.openembedded.org (Postfix) with ESMTP id C5F4D6FFFE
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Sep 2017 09:13:51 +0000 (UTC)
Received: by mail-wr0-f194.google.com with SMTP id n64so735833wrb.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Sep 2017 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=KTam5z1Fa+fGIQn3FXN3eLZQbCPRhCKUSpDeqj7ljNQ=;
	b=kTTCPjOz9nFjCPfjJjIxVC0umQ2QLzb4EA8UchyDlfZlJiGFa10mURDr01eTZSTDgz
	eVSgc8pN2hoOGNyKmDTYb98n4wbAvC3Kc2yezAhYZSEuzKNFxIfyaQdtrP5NEKJAHprj
	vREiT2jheNeAcSpY/1+v5MLXxe+9iPs/Rsal4HhgEAXwslcf9YVvYwoSmXgx6EY9aQo8
	CtpXJ/NEwhUtfZDECPb3sjb+rdRYN5deN5Z+lZs1BfsOC4Jnxdm0EqW0/6M+/md6v0pT
	jSEO3NUibIDPAghtQUt6TPR2x6DlQibpP64Da4Elxow3LoyZ0Bg+9MidQ3EozamrSOXO
	nCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=KTam5z1Fa+fGIQn3FXN3eLZQbCPRhCKUSpDeqj7ljNQ=;
	b=kVMxppfUE1uYJyug0BUPVvXInZUW+FRQcmDpEf/bMGWTpSlm9E8+eAZNeqMb97tTP6
	K/SrPFUbetdMGebm+Afu2n09gp5Lq/IkLX94Nq3b1tfGfT799rldvWW47YG/P2xsh6oJ
	XOGTBnFbbjLdNf1VfcGCXyC6tsNEY7JhV1UbQDzyhUMj+G6kqbwACfec8n2xpUbA6pfY
	eTqT9tXzYh06RipetrJqUYMgTrvnZfaeN4W0b+RDIRQb/d/tLSupBA3Z1OIV7b5L3lw+
	QYh+OKjsAFtb3xX44qSUsUPPkSVt0bs7VQnPiVdlGilYuCBAGV3Kz8DRiZ/F753+sH2h
	Qctg==
X-Gm-Message-State: AHPjjUgWt/X+x3C9Hr9n39Zh38zRI2dyCKWPaacCzpukkiCJ8jEDNIWl
	fq7dEq3RSRB4672/
X-Google-Smtp-Source: ADKCNb7zBAVnB+NQAtv49Nhb3UyknAkfKo03kIhaWx/IbhXIs01qMUWlFTmd1ZVdlH9/mrPWz5MbtQ==
X-Received: by 10.223.164.206 with SMTP id h14mr1309808wrb.25.1504775632242;
	Thu, 07 Sep 2017 02:13:52 -0700 (PDT)
Received: from localhost ([217.30.68.212])
	by smtp.gmail.com with ESMTPSA id b85sm147974wme.14.2017.09.07.02.13.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Sep 2017 02:13:51 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Sep 2017 11:15:55 +0200
Message-Id: <20170907091555.5596-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.14.1
Cc: Andre Rosa <andre.rosa@lge.com>
Subject: [PATCH] Replace deprecated git branch parameter "--set-upstream"
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
X-List-Received-Date: Thu, 07 Sep 2017 09:13:52 -0000

From: Andre Rosa <andre.rosa@lge.com>

Since 2017-08-17 (git version 2.14.1.473.g3ec7d702a) using deprecated
git branch parameter "--set-upstream" causes a fetcher error. Replace
it by "--set-upstream-to".

https://git.kernel.org/pub/scm/git/git.git/commit/?id=52668846ea2d41ffbd87cda7cb8e492dea9f2c4d
says, it's deprecated since 2012-08-30 so hopefully all still supported
host distributions have new enough git to support "--set-upstream-to".

ERROR: PACKAGE do_unpack: Fetcher failure: ...;
git -c core.fsyncobjectfiles=0 branch --set-upstream master origin/master failed with exit code 128, output:
fatal: the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead.

ERROR: PACKAGE do_unpack: Function failed: base_do_unpack

Signed-off-by: Andre Rosa <andre.rosa@lge.com>
Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 534c93d3..5ef8cd69 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -485,7 +485,7 @@ class Git(FetchMethod):
                 branchname =  ud.branches[ud.names[0]]
                 runfetchcmd("%s checkout -B %s %s" % (ud.basecmd, branchname, \
                             ud.revisions[ud.names[0]]), d, workdir=destdir)
-                runfetchcmd("%s branch --set-upstream %s origin/%s" % (ud.basecmd, branchname, \
+                runfetchcmd("%s branch %s --set-upstream-to origin/%s" % (ud.basecmd, branchname, \
                             branchname), d, workdir=destdir)
             else:
                 runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=destdir)
-- 
2.14.1


