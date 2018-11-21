Return-Path: <kergoth@gmail.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id BC21C6BC7D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Nov 2018 18:14:26 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id p4so6692141wrt.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Nov 2018 10:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=qOa9c3cVAe6w+FTZz+x6uf0/YL7BQtc3udlcss1WLXc=;
	b=CpPCiN+Zz+m3J17ITB6lYkZYU62U29nOAiVvKyuzMqmvuboi2g8xalCRYq3wkM3qTA
	U9vibvnUQB6FDwYh9KgX/sefG+yOxo4KkEwOCt40YriY3PrCAQh0KJ+PsS1O3sjHn7Cx
	LZW2gHnrAHYN+XJvDmfpPK796QNIpFAYg59ssm7ROt12Qlzbb1Ytvk7p3JvHGVxe920p
	Q3hYhWyBpSeFmc8PEpGjrfFnAvczINwoqIrVTuT4LSLiN1nIHJAPkDSRjDmL2as6P0cJ
	YO1KAG6KzzvpzJ1sqnN0Naxc33UPkZ0DXMOiIEDdgFE5TtM7Asv6sqrNT7SVDTeB/5PU
	2f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=qOa9c3cVAe6w+FTZz+x6uf0/YL7BQtc3udlcss1WLXc=;
	b=VpWtYuMuy+74xycTsZb8c6h0l95tAYagGdpPHTwdVq4sX8W2J5PiJU65OZoJtXxkrJ
	SnxHh7ZNXe1hV2bD9guX2kp2crJs/6L/Yx4rK9daHA98bk4TaYdOtOGA7tl3x9u+qiBO
	Z6BC9seslVsoSfmCQg+rjDz8PBMh59QQIYPfXb+lZbP+sAXY0obVXO02FkeoQoTfqxsw
	h7Zm8qdZns9pTWKsO4/tXK6eLmdYPRrXlYWFirbrPKuuFvqSGzIZnTV6pgsmRURalsiL
	5zeA7OC27lGrd+61NAbpDsdCcbh+CmE/AOhcysFkChlC9kv75AwwqVWoQE0UQbe2mJYi
	DIDA==
X-Gm-Message-State: AA+aEWasYiN7jIZ9kWF/5dnloHz1lJVl9FCemmhdSq2Ye10BsOlMmO2j
	QOxHsdRSAZ8KpNg+wc9WLWMO2BVQ
X-Google-Smtp-Source: AFSGD/WNoRoobpC+vMfDw8J2b+NfbJ+whkw8Yt4RvpR790uaa41KqeLO+svUvkWxiK5JUBtqDE+LWA==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr6571663wrv.308.1542824066838; 
	Wed, 21 Nov 2018 10:14:26 -0800 (PST)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	e14-v6sm28168939wrv.93.2018.11.21.10.14.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 21 Nov 2018 10:14:25 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Nov 2018 23:14:07 +0500
Message-Id: <20181121181407.23700-1-kergoth@gmail.com>
X-Mailer: git-send-email 2.11.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] fetch/git: fix AttributeError in shallow extraction logic
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
X-List-Received-Date: Wed, 21 Nov 2018 18:14:27 -0000

From: Christopher Larson <chris_larson@mentor.com>

This code checks to see if shallow is either disabled or the tarball is
missing, but the else block tries to print the tarball filename, and
this attribute doesn't exist at all when shallow is disabled. Handle the
two cases separately to give sane errors for both cases without the
exception:

    Exception: AttributeError: 'FetchData' object has no attribute 'fullshallow'

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 15858a62..59a2ee8f 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -488,12 +488,15 @@ class Git(FetchMethod):
                 source_error.append("clone directory not available or not up to date: " + ud.clonedir)
 
         if not source_found:
-            if ud.shallow and os.path.exists(ud.fullshallow):
-                bb.utils.mkdirhier(destdir)
-                runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
-                source_found = True
+            if ud.shallow:
+                if os.path.exists(ud.fullshallow):
+                    bb.utils.mkdirhier(destdir)
+                    runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
+                    source_found = True
+                else:
+                    source_error.append("shallow clone not available: " + ud.fullshallow)
             else:
-                source_error.append("shallow clone not enabled or not available: " + ud.fullshallow)
+                source_error.append("shallow clone not enabled")
 
         if not source_found:
             raise bb.fetch2.UnpackError("No up to date source found: " + "; ".join(source_error), ud.url)
-- 
2.11.1


