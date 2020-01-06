Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
	[209.85.216.50])
	by mail.openembedded.org (Postfix) with ESMTP id 022117FA0C
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:26:57 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id n59so7978174pjb.1
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=2AC/cz9GgoujPhoQ+l1Sr0MEw5HPAPDk9mL7kbmERrg=;
	b=knm6XaygO+EtKNTyGtTGf6EV738m40pRlWZME3xaLSybMuYujfuwfrcSEduzl82ymI
	Dz9ihWiC2UcPPCLsDTT2yuRgKeb2eU1GzC7TGtlq3w3mreWWB08RXYd71p+0OrvOqiBS
	aIPLIfOF9Z6emFVeDipeUpdMJf8vGMT8NbQOceeaGRyTF7V1giyT5+CZ+8A+Pp+awAyF
	CYfc1w5nq2eXLy+Bb+XQiFszVOVwtLsYlmUVPv8rv02Dy5l5orfOP50DD2D5AxQTQwJN
	EssZbhn+LpHBBqJEwo4HJm7/lH46GYRC4uxHHmwhoUhlY+daNa0LZ8mKm8xhZuJuYbSu
	lUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=2AC/cz9GgoujPhoQ+l1Sr0MEw5HPAPDk9mL7kbmERrg=;
	b=Q4UmMt/pNg01xmXuSX++Wodurh4uiK5jpNJ5SYX1JaJpjlFG0p4rL1S6o2Oa6Z2rXJ
	LX4wS0evasHQRHJvoiXuipZ8+SgyrZaswUAfkO9Kc3NuDsRIFljLbYpLnEnsRS1m1y2n
	E/gyYJBrlfJ2uyCjD5RS6C5OU1oZVtIi26oIsBUcCES635fiV6oyk28nJgPFHs7Gc4+7
	49/TxXOhvOqs2uiU356LZZHD00XBVgqysCEaFESqwRa+obCNWIfAoXWiNFgC8j3Y1H1e
	BmoT3oLwJt16pxrCE5pvJ7d1yDiWRHLZDh/t5zWILB4s+LpG0OA3+FL0ZFn5M6zJp60D
	o+QA==
X-Gm-Message-State: APjAAAXSzNYi+ndo9r+qYl+BxJJ5Ui2h15UmK0IHZ5I5wsgcn5L1z+RF
	ygIQlzFypkvoAgnBm6UPNm6oKUtL
X-Google-Smtp-Source: APXvYqzMQnZA6KIqow9uczLJewKTVCmhdHV6/oSnGwnzCZuSmT7cnD821Hl+arn1L3ChR6cVQQ8+Dg==
X-Received: by 2002:a17:902:d694:: with SMTP id
	v20mr66714068ply.127.1578328018778; 
	Mon, 06 Jan 2020 08:26:58 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.26.57
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:26:58 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:30 -0800
Message-Id: <81829ab28afae08e02f4a758ec063fc0d90579ea.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 09/25] bb.utils.fileslocked: don't leak files if yield throws
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
X-List-Received-Date: Mon, 06 Jan 2020 16:26:58 -0000

From: Chris Laplante via bitbake-devel <bitbake-devel@lists.openembedded.org>

Discovered with a recipe under devtool. The ${S}/singletask.lock file (added by
externalsrc.bbclass) was leaked, giving a warning like:

  WARNING: <PN>+git999-r0 do_populate_lic: /home/laplante/yocto/sources/poky/bitbake/lib/bb/build.py:582: ResourceWarning: unclosed file <_io.TextIOWrapper name='/home/laplante/yocto/build/workspace/sources/<PN>/singletask.lock' mode='a+' encoding='UTF-8'>
    exec_func(task, localdata)

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 6beddf6214e22b4002626761031a9e9d34fb04db)
---
 lib/bb/utils.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 8d40bcdf..d65265c4 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -428,10 +428,11 @@ def fileslocked(files):
         for lockfile in files:
             locks.append(bb.utils.lockfile(lockfile))
 
-    yield
-
-    for lock in locks:
-        bb.utils.unlockfile(lock)
+    try:
+        yield
+    finally:
+        for lock in locks:
+            bb.utils.unlockfile(lock)
 
 @contextmanager
 def timeout(seconds):
-- 
2.17.1


