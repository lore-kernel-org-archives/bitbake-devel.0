Return-Path: <eu@felipetonello.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id E3DB27716F
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Feb 2016 16:28:36 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id l66so171746993wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Feb 2016 08:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=felipetonello-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=6ZZum9ClDAfGJgKXcRw9O8hsmtYXNVLYqi9yMIN14x0=;
	b=byoAfa90akKybg0FZMsaK3hxzKgYk5JpoDFT96zWHmOl7GrW/R/iFwo+q9CZ4RQNmN
	Q4dIwmiOT4wmg1UcA9tJptMFCjTbw81wLwAa+zdbBT/lAThP4UiR0MjZB5XwFl9OOjff
	AcJcX34GDzGET1R7IAJEia33zm1rdS7urhrl7y0h5CoXtFi0rub6R6GT/cCDwpPGCnA7
	xLjXtoBfuLhxXRsSf5Y4b6GK5TTtWl8UlnUy9KC+Yw58dMGKHXi4dm1XpAVAaOzao2OU
	upytpM9eaCpzEIW1HrXWf2lB6nro5Tzo+aNs3eui4BFSE2Jo04N1ZylZdsoID2gz2prN
	prAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=6ZZum9ClDAfGJgKXcRw9O8hsmtYXNVLYqi9yMIN14x0=;
	b=GD4wQP38PAtG6YZdZf5wmxvr8CQEpkTpn9ENo9vJT6elIONwcS/IY9sp9qPkehJYeK
	TtU0hNGzYlSS0n/JUL1/OOR25KpWhpUbJRM7KVfVC72CUmu9GN1xj8BU2Yi3OFeWR9Ty
	cy22NTmGlaV1ehqmv1icUMocm1Fc1WRsgcQ+7uGDlaJX1ZqVP2D5MmM7sNuSOL1qZSQw
	3eAYHTr157+Y4gkNPLAKJGm9GAsmFhL3/EVJ1ALUx0bapqSrFoKursZS9SE0XM6emEfN
	pW6MhJd3lRhQ4re/msg7fgKyJnsg0t2ZpCu+C0e5Z1277tiJmVW4m3HhwUX6KjImKGSz
	8ngw==
X-Gm-Message-State: AG10YOTLJDNIxfbU3PlLwu3YtsVqailQUtM9LZbwlcuW7xFlqlegnDrPS5BAqKKJHgA59g==
X-Received: by 10.28.97.11 with SMTP id v11mr5243979wmb.42.1454516916426;
	Wed, 03 Feb 2016 08:28:36 -0800 (PST)
Received: from felipe-arch.localdomain ([81.145.202.106])
	by smtp.gmail.com with ESMTPSA id
	jc7sm7269479wjb.33.2016.02.03.08.28.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 03 Feb 2016 08:28:35 -0800 (PST)
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Feb 2016 16:29:42 +0000
Message-Id: <1454516982-3788-1-git-send-email-eu@felipetonello.com>
X-Mailer: git-send-email 2.7.0
Subject: [PATCH] fetch2/gitsm: Fix when repository change submodules
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
X-List-Received-Date: Wed, 03 Feb 2016 16:28:41 -0000

This fix a problem when checking out a commit that changes the submodules
previously checkout.

Example:
Recipe uses branch A and then it updates to use branch B, but branch B has
different submodules dependencies then what branch A previously had.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0392e48d1aa0..2ecea7c7ed60 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -131,7 +131,7 @@ class GitSM(Git):
         os.chdir(ud.destdir)
         submodules = self.uses_submodules(ud, d)
         if submodules:
-            runfetchcmd("cp -r " + ud.clonedir + "/modules " + ud.destdir + "/.git/", d)
+            runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d)
             runfetchcmd(ud.basecmd + " submodule init", d)
             runfetchcmd(ud.basecmd + " submodule update", d)
 
-- 
2.7.0


