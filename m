Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by mail.openembedded.org (Postfix) with ESMTP id A22E07CDAC
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jul 2019 09:07:30 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id w24so51364plp.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Jul 2019 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=yrb1x+kj5OU5ecT0AFnNmlbrZR7wEONrt692Omu/0L4=;
	b=evpXsKkOx3XQWbHQcR80X40BXfkMjIoV42OnPk+/QXtIwjzna4qY4jhCtnRE4IUmlN
	xBnU81igpelCNQ3tz1odpwRTSue/b3ubJ4vb8XpOAZ7pCaIz5+NETz8GJMnBsEtN6m+3
	bltFJTFdse5zfKFMOGQ2Hyrw6DnbiNwI9mS5u5F1gx7gsgalGr3I1uRGr/Zn5Rvu4Qnx
	zEe0fTM8olmD75WF1VgoGY0mEZjKDDGCLWyh+gxTsgLrwW1Ew/37iz3LiriGAFRNh7Ur
	AuEy+vEKz+bsEzI3TzsltoDsGvTdQ4ylnK+FHIb6Kgy6gN4Tmo/8fuUDb6PtJUsYLocE
	wmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=yrb1x+kj5OU5ecT0AFnNmlbrZR7wEONrt692Omu/0L4=;
	b=owgOwRAyILEkM5f1i8D6LVGMJtLltR6YDQCy7VvgaK006hqR+KIQ3AgYh6LjMHDf+J
	A3iLsoKk84/G3h8RR0Y3Vp+JowLX35KxJLdkC7LTfhYxAaE60l+/VAdCBca6db1kZ/ge
	X4gsUJ1IMOGafBuGPBz5Uq824X3fiHatl03VB7TmN3UXa+3mk7x6F1Ysoe1Ra8ZaIvo3
	FbdAUuPsNLu3Z74w30vxPjKfFfPi2TuLgVm3h2Cl1X/StXQ65SkhLdg8EWjvgJGzJQqw
	bMNYCyL4mmYD6+QcT1YuY46nnN9VyHsuzM7S9vejNeDWC/8Mg7Ui/TMZCl2jj4F/5q7C
	5opg==
X-Gm-Message-State: APjAAAV97VaQ64i++ITB3MU7AP0VyfQJkzbSTzTmu//ibZhm9IYSOjKQ
	UBQ/RSNWL2aMApAKXG8f2IQ0/7k8
X-Google-Smtp-Source: APXvYqwwcB9FXtvurGDu07mgosansP8cG/vPSl1gysWTHzVhr6CXnsifNXg/jJgOosQnJ9W/AZw4bg==
X-Received: by 2002:a17:902:704c:: with SMTP id
	h12mr34377099plt.214.1562058451055; 
	Tue, 02 Jul 2019 02:07:31 -0700 (PDT)
Received: from localhost.localdomain (163-47-106-5.flip.co.nz. [163.47.106.5])
	by smtp.gmail.com with ESMTPSA id
	m69sm1253589pga.11.2019.07.02.02.07.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Jul 2019 02:07:30 -0700 (PDT)
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Jul 2019 21:07:10 +1200
Message-Id: <20190702090710.1411-1-ankur.tyagi85@gmail.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Cc: Ankur Tyagi <ankur.tyagi85@gmail.com>
Subject: [bitbake-devel, 1.42, 1.40] git.py: Handle space in git repo name
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
X-List-Received-Date: Tue, 02 Jul 2019 09:07:30 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Ankur Tyagi <ankur.tyagi85@gmail.com>
---
 lib/bb/fetch2/git.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e171aa7e..5300fa8f 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -236,7 +236,7 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
+        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(" ", "%20"))
         if gitsrcname.startswith('.'):
             gitsrcname = gitsrcname[1:]
 
@@ -459,7 +459,7 @@ class Git(FetchMethod):
             readpathspec = ""
             def_destsuffix = "git/"
 
-        destsuffix = ud.parm.get("destsuffix", def_destsuffix)
+        destsuffix = ud.parm.get("destsuffix", def_destsuffix).replace(" ", "%20")
         destdir = ud.destdir = os.path.join(destdir, destsuffix)
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
@@ -574,7 +574,7 @@ class Git(FetchMethod):
             username = ud.user + '@'
         else:
             username = ""
-        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path.replace(" ", "%20"))
 
     def _revision_key(self, ud, d, name):
         """
-- 
2.22.0.windows.1


