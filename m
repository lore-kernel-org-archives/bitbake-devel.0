Return-Path: <liu.ming50@gmail.com>
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by mail.openembedded.org (Postfix) with ESMTP id 037887C2AA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 14:41:31 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so8575337ljd.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 06:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=rLiO0GJMLUF2u/S8XltJZ8pkdrwEJ8dtflPKmNlvq50=;
	b=Z5fc7uf5BE3kvI67+OSG924XzBxdzoFtr3qj4n0hRXChCpyAHJ6FSQ9E1sDXddXViq
	OyOt3wl25zkqUgOvHSXKlwj37Jdgti6xyhrWNBwJEDpcZM1IMUV+sqZnVEQYhP+TSN1m
	WcsSBtBnVjlba0VPU1oDESV1WKZ/nPId1sR7BjDE5qIz3RJIWjSe3qw/gO4877ssB1i1
	QR39hFyEsh9Xh29mklXDMtfFGTW0FS0imeykZ62OXOB0pl6+ROgvy5T/vDivZiH0KV1e
	QJ1RxU7AV9LFdWnqDVtLEkroTap3toZpWoAaib1zhs6AG6/NuXkhyLq8prySHGcV+ztu
	MsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=rLiO0GJMLUF2u/S8XltJZ8pkdrwEJ8dtflPKmNlvq50=;
	b=PpoguDqKEEi7RmpDMjF3yVu/2R6pf5n+3EEYR2QIoOOosUbg3H6MklMxRqmvWDxExv
	IVnkI9NRvL5b0k2W2nPekKlufNqdqUxgjVnd2yzjh1UU63YmSZAVrFUVbOB6pcPHpG3i
	pIaPw5CS8tbg6vzGkX7OrmfsO7+1YIPxX9gsG9qWFUQNfqvWpxT4gH3Mym2AfKEqojeY
	RKIo3givUwbpViCzpoxRbKbnyHsTAO1+5RUiNLtOYrpX3X11EmAe8JTIPFo9mPonnKf3
	vu/u5SiSlw0SXOMUi+HlmA9qNZ14YYVHXSTY+hZrnGQGMDVoWOmIk0X4qSRUtzv0vQbw
	H4Yw==
X-Gm-Message-State: AJcUukdMgOSpi0b2LYcIzy7M2o1yFN0mzjyVcNaDmRsZXt2DL9zN+S1m
	gE2Hj2bKKZuGjQUacfMLeGFGOAF6LTo=
X-Google-Smtp-Source: ALg8bN6ixzIeFsTPifkHiQUtQXcwKyfMpU93by5P0axkgbiZzjqKp1nI8fYd8PcndcTpKuiJZgsV0w==
X-Received: by 2002:a2e:1bc5:: with SMTP id
	c66-v6mr9662989ljf.96.1548427292259; 
	Fri, 25 Jan 2019 06:41:32 -0800 (PST)
Received: from peterliu-Precision-M4800.emea.group.atlascopco.com
	(m77-218-252-226.cust.tele2.se. [77.218.252.226])
	by smtp.gmail.com with ESMTPSA id w4sm1481335lfk.83.2019.01.25.06.41.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 25 Jan 2019 06:41:31 -0800 (PST)
From: liu.ming50@gmail.com
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Jan 2019 15:41:27 +0100
Message-Id: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
X-Mailer: git-send-email 2.7.4
Cc: luka.pivk@toradex.com, stefan.agner@toradex.com,
	Ming Liu <liu.ming50@gmail.com>
Subject: [PATCH V2] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Fri, 25 Jan 2019 14:41:32 -0000

From: Ming Liu <liu.ming50@gmail.com>

A following issue was observed with gitsm:
| git -c core.fsyncobjectfiles=0 config submodule... failed with exit code 255, output:
| error: could not lock config file config: File exists

Since all git submodules share a config file and Git creates a lock
file (.git/config.lock) to synchronize access to it, but Git only tries
exactly once and returns a error if it's already locked. This leads to
a race condition if there are many 'git config submodule' run in
different processes.

It could be fixed by introducing a bitbake file lock to protect config
file from concurrent update from submodules.

Reported-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Ming Liu <liu.ming50@gmail.com>
---
 lib/bb/fetch2/gitsm.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index f45546b..9465acb 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -183,11 +183,19 @@ class GitSM(Git):
 
             local_path = newfetch.localpath(url)
 
-            # Correct the submodule references to the local download version...
-            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
+            # Protects the config file from concurrent updates by submodules
+            # e.g. 'git config submodule' run in different processes may lead
+            # to a race condition.
+            lf = bb.utils.lockfile(os.path.join(ud.destdir, "gitsm-config.lock"))
 
-            if ud.shallow:
-                runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
+            try:
+                # Correct the submodule references to the local download version...
+                runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
+
+                if ud.shallow:
+                    runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
+            finally:
+                bb.utils.unlockfile(lf)
 
             # Ensure the submodule repository is NOT set to bare, since we're checking it out...
             try:
-- 
2.7.4


