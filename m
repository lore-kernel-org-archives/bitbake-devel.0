Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2392C433F5
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 20:26:10 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web12.2697.1635193570326283598
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 13:26:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZrknXbmj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id
 83-20020a1c0456000000b0032cb02544aaso1111082wme.5
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZBAg8bGrnHOTE9aX/szhX+yQWjBYv379TBjAbSU/Nw=;
        b=ZrknXbmjV5HG0dDgvFtdpbTJ9vrsTitriiZ57vRHWixmZZMGeokcWeCTshX5fwHLDS
         jQ1IBNCU4ZWOJkLKoe75mRHKAc/ntZo/kT2iLjA/WbfI5xpBLdrIu8pvROvO6dOxWmLT
         t4/gNmOPsU4yGkwjKgpP5xvcm+Qz7i8CFtcjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MZBAg8bGrnHOTE9aX/szhX+yQWjBYv379TBjAbSU/Nw=;
        b=CFHOgujIWuOOBb9giGAhKonCLwQPtfr5AaFncGUUhVLfgXFown7hffoe9rWid5nKg2
         E4Jk6/0lcMbaBIaP+Uvgwpm6mHK5VryCXgs0t69hOHfXkLzb63jQVHvTXiIKYVbYs3UE
         0rp+mO18YHE1yuxhwW66bP7+3nQFCvrg5uawIxhJZWwYC5sbNruEXb/46+503Hw8iwc1
         IWRgIociLiazHMm5Cm2CNxuDkEhEbHhQG10Id1LkgyEx/XG477AHFnjqIevEghWle4Eu
         AVEJehUmUkOG4G4XgGPjoYiTx1bG6xLklN8ehwhAwD7E0735u/Mb6JAHmC0mFqyTE5XA
         P/EQ==
X-Gm-Message-State: AOAM531/KPW9kGEubP7rowwhv3b/y/9PSAfFUdcNc3B1jHji0quR3fRI
	wcgCkKfwQT0X3QAS2/E/7iYJy46zl3cebw==
X-Google-Smtp-Source: 
 ABdhPJzdlodqyfJYXc8X0KPYOfzkeZ+we/kbCcsEeMcsuEXiDngdSrDpqED2tk+5QjE1k9gXxldhsg==
X-Received: by 2002:a05:600c:25ca:: with SMTP id
 10mr14579502wml.106.1635193568618;
        Mon, 25 Oct 2021 13:26:08 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:5fb2:414a:7b8b:6fb3])
        by smtp.gmail.com with ESMTPSA id
 n68sm19603498wmn.13.2021.10.25.13.26.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:26:08 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/git: Allow git fetcher to support subdir param
Date: Mon, 25 Oct 2021 21:26:07 +0100
Message-Id: <20211025202607.3281692-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 20:26:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12827

The git fetcher is odd in that it supports destsuffix as a parameter but not
the default documented subdir parameter. destsuffix is more limited as it can't
take absolute paths. Rework the code to correctly support subdir.

Also cleanup to use the None default .get() values and be a bit more pythonic
and use subpath as the variable name for subpath for code clarity.

We could consider dropping destsuffix as a parameter as some future point.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e8ddf2c761..bd15940503 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -516,13 +516,24 @@ class Git(FetchMethod):
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
 
-        subdir = ud.parm.get("subpath", "")
-        if subdir != "":
-            readpathspec = ":%s" % subdir
-            def_destsuffix = "%s/" % os.path.basename(subdir.rstrip('/'))
-        else:
-            readpathspec = ""
-            def_destsuffix = "git/"
+        subdir = ud.parm.get("subdir")
+        subpath = ud.parm.get("subpath")
+        readpathspec = ""
+        def_destsuffix = "git/"
+
+        if subpath:
+            readpathspec = ":%s" % subpath
+            def_destsuffix = "%s/" % os.path.basename(subpath.rstrip('/'))
+
+        if subdir:
+            # If 'subdir' param exists, create a dir and use it as destination for unpack cmd
+            if os.path.isabs(subdir):
+                if not os.path.realpath(subdir).startswith(os.path.realpath(destdir)):
+                    raise UnpackError("subdir argument isn't a subdirectory of unpack root %s" % destdir, ud.url)
+                destdir = subdir
+            else:
+                destdir = os.path.join(destdir, subdir)
+            def_destsuffix = ""
 
         destsuffix = ud.parm.get("destsuffix", def_destsuffix)
         destdir = ud.destdir = os.path.join(destdir, destsuffix)
@@ -569,7 +580,7 @@ class Git(FetchMethod):
                 bb.note("Repository %s has LFS content but it is not being fetched" % (repourl))
 
         if not ud.nocheckout:
-            if subdir != "":
+            if subpath:
                 runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revisions[ud.names[0]], readpathspec), d,
                             workdir=destdir)
                 runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d, workdir=destdir)
-- 
2.32.0


