Return-Path: <kergoth@gmail.com>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
	[209.85.128.193])
	by mail.openembedded.org (Postfix) with ESMTP id C99556AC37
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 16:57:14 +0000 (UTC)
Received: by mail-wr0-f193.google.com with SMTP id k10so5961318wre.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3bJrHup6i4KXu4k4rKsiypXOR3sH+GL/W9TPw8zhclY=;
	b=NiYDo/HokMZF7AE5x2DlzptMWnR6UbdT3NH+Avsa+qez/YgTmBkg3qLY25ESgmwCW7
	AUU89aJMVu8/0cyTkxuz3F/1vpk9NHMdhVxyyE6FHePldwIdFkPqdLLeUPE0LfaeCUg2
	rT4QeXGcM/qarzaOmxQu40CeTRfJEgtPRrTIhbf4IG2QjD6ELLwbCbrrL/H3/pvKamq/
	aSz3wAD1bi3jyORyY7sJLxcNoi2pQL9sNB5QoEhc71DhkmKorL2TvsmX4BWSmy6xzdak
	LlWL8bwgUoTwAGPAskFHGlpNFDZC1yvHGWva28bJC7SUZPmGXHNNVkH7EDuIX7Ph4htF
	GJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=3bJrHup6i4KXu4k4rKsiypXOR3sH+GL/W9TPw8zhclY=;
	b=DAqR8dTqoyeLKKLcwbrTMYlOw4PMXjes5gtxy1313zT0wtzqMBl4xGzFA6ctei/cgz
	MNSGYj8yuy8/Wt4KjOeM0SmWR3t5XjiO93E6I2YpWqsnaNtaEr3SJSvewY1SIf8mlEvv
	F7pCfcTBpdVpghTRl3d2qLMwD1nxSH70w5lbMc9iyoK2G0QgosApBmbLNsr+T/3bysIL
	17yseGSvl3GYiXplNiCCYMxDLYby/6vtF1Ua5idJ91wWibmGJlVgVVNg/Noi1+REpPZ/
	BU2PT+0lcroZYL04x+KXP0RociIvscinpfJFQKsJ4BrVth77KPbDIKtw6nuoHmLqKqa8
	WYwA==
X-Gm-Message-State: AHYfb5hZCJqTJ/WV7CdQKonfUHphjHQjTG3T70mSXuotORl+2cV0KzYJ
	YRLx1+mqKHPK2NZCsZs=
X-Received: by 10.28.43.1 with SMTP id r1mr2540454wmr.146.1503334635445;
	Mon, 21 Aug 2017 09:57:15 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id w65sm8586818wme.6.2017.08.21.09.57.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 21 Aug 2017 09:57:14 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Aug 2017 21:57:08 +0500
Message-Id: <20170821165708.13223-1-kergoth@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170821163741.28301-2-kergoth@gmail.com>
References: <20170821163741.28301-2-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCHv2] fetch2/gitsm: copy submodules from DL_DIR in unpack
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
X-List-Received-Date: Mon, 21 Aug 2017 16:57:15 -0000

From: Christopher Larson <chris_larson@mentor.com>

Revert "fetch2/gitsm: Fix when repository change submodules"

This reverts commit 12f6c0651af8bd5d6efb751690571cf2fcd3eeb0.

This commit caused the gitsm fetcher to download submodules from upstream in
do_unpack, rather than using the previously fetched submodules from DL_DIR.
Also drop the pointless checkout, as Git.unpack() already handles this
correctly.

[YOCTO #11830]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/gitsm.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0aff1008..ed94c3d7 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -131,5 +131,6 @@ class GitSM(Git):
         Git.unpack(self, ud, destdir, d)
 
         if self.uses_submodules(ud, d, ud.destdir):
-            runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
+            if not ud.shallow or ud.localpath != ud.fullshallow:
+                runfetchcmd('cp -fpPRH "%s/modules" "%s/"' % (ud.clonedir, os.path.join(ud.destdir, '.git')), d)
             runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
-- 
2.11.1


