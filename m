Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
	[209.85.216.52])
	by mail.openembedded.org (Postfix) with ESMTP id D71F57F849
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:52 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id s94so5368858pjc.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=806B50MWULWQP/U5WbcCbAXbSLm3W+fEyK86DOMOtP8=;
	b=gHtpLCnxDR0A4/BXG//CnED3rxM+s2lkoHDLYeukolbAtKaNwAoCwsu36DIZwCJgDQ
	EAHx1na5cQyuWUnFSdvI/gm71LrWkwWZjSiB8NHphoyd3EGjjy1GAWzj3pz6vyzvMgxY
	BA2mN1yfxyKKUsUV52j8amTSrxChkHsIU7Az8m07j4rC37MV8Z0SVmhKJKhv+s/HT95F
	XyIWIoGzlp6nUqdPKk+MgCr5fgi0VleyRu+l612s3/K/+aLZv8+muR/bbZuY+12z4otL
	EU0vEV41QqFRhZqAKSYUNr1tXMygXbwgkRY+UiOQYXYGrgylv+Y+W9kkfND1sRYkbl9n
	pUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=806B50MWULWQP/U5WbcCbAXbSLm3W+fEyK86DOMOtP8=;
	b=QrlbM2plMmUHJL6NmaukXzpHC3LiOTf5nnyDnKBecW5hClU6leNWfHt4KfUZsgJ8M5
	FtffSFY38jBHvhy+f8Jn2ostLCDoUIXiJ15T41RyK9bjcE45ftop3zEcL/KEfqfgYfuo
	j9R+a1+BQtd5GsVNNWhUKfYMZKvCdIhQLXKYcMJq3RupZvKi7fiUxQlZs9IwkgsIVhyT
	ya0DFA416clNoao8zwUT10dHHMcVvV//OIpqR86mWfMgyAaMpAU7SomYonF3IOfsySUD
	BM+blBLwgHT8/ywvKKlmQoI7cLgn3fc9ygnhNoy88M/4HSHocanRyvraRMWi4NKlO/7o
	owKA==
X-Gm-Message-State: APjAAAUpSoRalkEBA88EdcBKfH1TGWT16KNBzSvqetC4sy44kFXX3I7x
	Q/559SH9usFp2y/VJaF65lEan7YifX8=
X-Google-Smtp-Source: APXvYqwCJlOVdoxPQKQ/gzE+jmbUurwMwXx07a03usCjBSlh+lefKA3maSFfXge1vqRmIPACxd+93Q==
X-Received: by 2002:a17:902:9048:: with SMTP id
	w8mr28162825plz.294.1577076653847; 
	Sun, 22 Dec 2019 20:50:53 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.53
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:53 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:33 -0800
Message-Id: <81829ab28afae08e02f4a758ec063fc0d90579ea.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 09/18] bb.utils.fileslocked: don't leak files if yield throws
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:52 -0000

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
index 8d40bcd..d65265c 100644
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
2.7.4


