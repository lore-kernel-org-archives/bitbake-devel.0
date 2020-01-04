Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by mail.openembedded.org (Postfix) with ESMTP id E1E427F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:21 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id p14so24279288pfn.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=2AC/cz9GgoujPhoQ+l1Sr0MEw5HPAPDk9mL7kbmERrg=;
	b=n/oMtH1GkcHFOMRwqZ+Kr5CQEOvXcD5ch7terVprzIOAzFCMVWg4gusLLyqhooM9LD
	0VCThfnannDW3RsCUurp1oV457sfvdjEGgyAR3kOSBMplPqmq1BI9Kf6EoLu4F5MTSkG
	oZVEh34HpvuotAIFF7yPhm2Q3ByeC/ODV+gyUclYHmCTSD4hGAaJYAGbF0rPLKzcpSSm
	ivUnXaeXm2tYAQ6PQJ6bjnqKOgOzVU4ILBps1dhA4wXERNl6KmZUwEhIstqM4zsgDY5C
	ypHAKfWW9AT5HA2lS6uJe9aW3WAlTNVYT3jYadAxY26RVFbiVampTlflVx7Shl3GrW1e
	WAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=2AC/cz9GgoujPhoQ+l1Sr0MEw5HPAPDk9mL7kbmERrg=;
	b=eyP2kHvKCOHfDAsxl2br76qKvYv+uHzPhstHlQpNCIPtqUmHvtx3r6s7d3r9F671nE
	ISzvQlvywxbuhh6NSM6AKYuqF1y54LYMdellgVVy/s6B6728nmMzIVW2xuurcfI+a813
	PfuU0nfSHDttSGdjBNCN/NtkdxdZwtK2WWbBGT0QHWJehYXO/fCwZgiW4/k0/jizFAE3
	JCctDKJtSA4qVjqYvt1RBKFaHJNSO5NXxAAdrC60ODhrwjDn7PcwDAcj125gFxEfH3FK
	3I5AEIHskEe8bpjg5zGkBpgGCv3Vr3K40dxHcjZPS/XZZHt1qAzVhg2JyLWyuntZO7e/
	8Lgg==
X-Gm-Message-State: APjAAAVcwUFxjU/jqKD2S1i+iPnp5n8DiDLECAQ5+lbUs78LS6nr16Zd
	kYgh0RaMlgzOf0TN0DKYJjEegUURxF4=
X-Google-Smtp-Source: APXvYqzf7ulaJ2MapCca5GqJupvfsFudwZeTVI3DAazkRwLrjQXVGiBpDIf1BmnteZabhtdlh7FvOw==
X-Received: by 2002:a63:1210:: with SMTP id h16mr98426175pgl.171.1578104602837;
	Fri, 03 Jan 2020 18:23:22 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.22
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:22 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:54 -0800
Message-Id: <81829ab28afae08e02f4a758ec063fc0d90579ea.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 09/25] bb.utils.fileslocked: don't leak files if yield throws
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:23 -0000

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


