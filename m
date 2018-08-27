Return-Path: <ptsneves@gmail.com>
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
	[209.85.208.179])
	by mail.openembedded.org (Postfix) with ESMTP id DB03D78F12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Aug 2018 19:39:13 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id v26-v6so125609ljj.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Aug 2018 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=4Hgtgd+7zMI4XOk8QEWa6HO01qhZzf474JVx0l9cmpQ=;
	b=fHiXeep+oKDKiXB306m7OXci9+lX130hJY+gu98VtJEsesEqH85EJkmicZ1ubfdnfX
	KJeNIR+gNkmlRmSBrSMq9lOMxCuzBcxqYAaBuvrWv3NEVC7bwJ02RksBHmLRgSzapaY3
	F1wC5rOFhM7G4eSJTSVbK+RsTETbgyiKKH+KrjZI0Y33L873ptasqQYnS7BY2AexhYMd
	Ql20LfpS2VUgYfXpqn1yoh2g3Ija/aXD0Fq2qkKtJ4PhwdV4ORSQad+A8gvnMTIzh9Gz
	BfbFicB4QIg64PggBfjRR0AW29DqtiFZnpR48HLVPU72axvRUHz8J8H85Dy3svWx8XdK
	cRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=4Hgtgd+7zMI4XOk8QEWa6HO01qhZzf474JVx0l9cmpQ=;
	b=L1af28gLwtCY4oAp6hyQcz3Ibzied3a7/o3aKmoXBiD7bwSN9mQV7ivLk6MYet+BGy
	ve+VUqTaO0Vl/9RHh4nARtGkVRsffAnbt7Kx+khPtmtFVGbvAbwAF5GGGhS48sc4qwok
	JM/8Gr7erfemSM/JSlSm8+EX7KN2nfhDgsABK4A6jpETKDi3HM7yh7M72APNF51X6hpt
	zARBfKOovIE8Q5/2oShkcgChMYj0YFK4eK3ZIgwl2KdwU/sAi2wjQUCyAReS7QIVunH5
	jzqUBi7FCxICZXWIe++cm3KLF/Wd0UrZZ970S0sxIRAna0GlH2fPxmpnU0uQHePignwC
	ZhVw==
X-Gm-Message-State: APzg51CkLd/zkS0FY0XAz2JUhH7vIZm3E+P6Txqr/sfTB2y07MdNT7HN
	mGzYLRbjf2WpjkXIIEtUe2HiM9k=
X-Google-Smtp-Source: ANB0VdYR9QEkcJfLt3txqHQ15ZtuYXxN0mMl08lX0VOaDsyxXYvxThI9nUfqdmbYdf/QbUH8K7wGJA==
X-Received: by 2002:a2e:54b:: with SMTP id
	72-v6mr10161002ljf.152.1535398754279; 
	Mon, 27 Aug 2018 12:39:14 -0700 (PDT)
Received: from pneves-XPS-15-9550.home (dynamic-78-8-57-113.ssp.dialog.net.pl.
	[78.8.57.113]) by smtp.gmail.com with ESMTPSA id
	y68-v6sm13460lfd.66.2018.08.27.12.39.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 27 Aug 2018 12:39:13 -0700 (PDT)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Aug 2018 21:38:59 +0200
Message-Id: <1535398739-17159-1-git-send-email-ptsneves@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] fetcher: Fixed remote removal not throwing exception.
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
X-List-Received-Date: Mon, 27 Aug 2018 19:39:14 -0000

Before this fix it is assumed that the removal of the
remote can only fail because there is not remote to remove. This
is a false assumption. Example error which would be ignored:

git -c core.fsyncobjectfiles=0 remote rm origin failed with exit code 1, output:
Note: A branch outside the refs/remotes/ hierarchy was not removed;
to delete it, use:
  git branch -d master
error: could not lock config file config
error: Could not remove config section 'remote.origin'

Due to the masking of this error a stranger error will be
presented to the user, because this time we do not mask the
exception:

git -c core.fsyncobjectfiles=0 remote add --mirror=fetch origin https://github.com/ptsneves/tl-wn722.git failed with exit code 128, output:
fatal: remote origin already exists.

The most likely reason that the remote cannot be removed nor
modified is that the DL_DIR/git2 does not have permissions
compatible with the user running bitbake.

This commit fixes:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=12728

Signed-off-by: Paulo Neves <ptsneves@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 612aac4..35da14d 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -353,10 +353,9 @@ class Git(FetchMethod):
                 break
 
         if needupdate:
-            try: 
-                runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
-            except bb.fetch2.FetchError:
-                logger.debug(1, "No Origin")
+            output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
+            if "origin" in output:
+              runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
 
             runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d, workdir=ud.clonedir)
             fetch_cmd = "LANG=C %s fetch -f --prune --progress %s refs/*:refs/*" % (ud.basecmd, repourl)
-- 
2.7.4


