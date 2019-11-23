Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
	[209.85.214.177])
	by mail.openembedded.org (Postfix) with ESMTP id 8895D7FA0E
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 16:25:07 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id j12so4543652plt.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Oxh2CzT3JzHrCDAsLAy/ngKb5Ze7jh6N7vXYXYy+k7g=;
	b=bpXmrr0OZI2nRMxOQLcawRqltAj0hCbm2evgReLZ0ydz74GesKaXEnnVDvQ2qmOwiF
	A5wytk3e4is/2JO6Clnv2vYKi2dx+020jECukyUcSdFmug5qXPoSEHkXFwFpqHpYw2Y1
	AvV0EjSv4sjSM9vTjaWmGDJsVCyukEAV662DFNJSAOeNfJPifJ+sve4HMzCgw+4IA6rW
	EdLY7k1/xUO8GJ5ZfPIIRSBgOjdRwnZqALfeuMMzUtsmsrt+cVvHonCMC53DBswLtj8w
	mHjT+uoUWD+vuq6SdsJe8ZHmTeJh706GVdGOAYA9tC0PJPLTZE5A6Tq5scZEN0xnMymj
	hPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Oxh2CzT3JzHrCDAsLAy/ngKb5Ze7jh6N7vXYXYy+k7g=;
	b=josZaRAb3Q9gcMUlOVtOqQK+L0UxcJaM6KDzFDMHOtdxaKF6tH5ucFjuVV347eLosQ
	AnmNQ/Mq4En2pHebj7FQQGPg98yR/LGv26YJXGnuMZHBsipF8b9fceUtj0a+zW1RuYfq
	IWcKLRrjZE1IIgVW1SU5IuN06CJRdxnF5U15ggP0rlK+op1cXVL7AD/UR4i3HAE+4lHR
	RsJgWfiGoJY1Ra6meE5vMtmiuleZfmIefHE7sqdj8EkL7TD+lCXyjA0kB0Pf2kyyuULE
	q9A5S2u1JIHug5x0PPN5Ef/HsfKsQ/uYh3yaJxj45lgV90V15FlFPJQAcf1nq6N0GW28
	ry9Q==
X-Gm-Message-State: APjAAAXY/HEFnYFJT2HOzmRreqfD+h5vNQOoBRT3Yrot29ENnS0/jbS1
	/UHkuBJHUqQ2bUqpWjs68dxPFhq7
X-Google-Smtp-Source: APXvYqwJhtgpLgndj++fzzvAoVXnd4wXlEmV4dtB7f8vXYak8CHf+EskZ1t7vTBOdfB2p2blMkiA4Q==
X-Received: by 2002:a17:90b:438b:: with SMTP id
	in11mr26751528pjb.129.1574526308708; 
	Sat, 23 Nov 2019 08:25:08 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:d5a1:4623:137e:d439])
	by smtp.gmail.com with ESMTPSA id h9sm2735572pjh.8.2019.11.23.08.25.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 23 Nov 2019 08:25:08 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 08:24:58 -0800
Message-Id: <1574526299-21018-8-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
References: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
Subject: [1.44][PATCH 8/9] fetch2/clearcase: Fix warnings from python 3.8
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
X-List-Received-Date: Sat, 23 Nov 2019 16:25:08 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

bitbake/lib/bb/fetch2/clearcase.py:148: SyntaxWarning: "is" with a literal. Did you mean "=="?
      if command is 'mkview':
bitbake/lib/bb/fetch2/clearcase.py:155: SyntaxWarning: "is" with a literal. Did you mean "=="?
      elif command is 'rmview':
bitbake/lib/bb/fetch2/clearcase.py:159: SyntaxWarning: "is" with a literal. Did you mean "=="?
      elif command is 'setcs':

Python 3.8 is quite correct and we so mean "==" here, fix it to
avoid the warnings.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/fetch2/clearcase.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 3dd93ad..e2934ef 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -145,18 +145,18 @@ class ClearCase(FetchMethod):
 
         basecmd = "%s %s" % (ud.basecmd, command)
 
-        if command is 'mkview':
+        if command == 'mkview':
             if not "rcleartool" in ud.basecmd:
                 # Cleartool needs a -snapshot view
                 options.append("-snapshot")
             options.append("-tag %s" % ud.viewname)
             options.append(ud.viewdir)
 
-        elif command is 'rmview':
+        elif command == 'rmview':
             options.append("-force")
             options.append("%s" % ud.viewdir)
 
-        elif command is 'setcs':
+        elif command == 'setcs':
             options.append("-overwrite")
             options.append(ud.configspecfile)
 
-- 
2.7.4


