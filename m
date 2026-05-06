Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B9BCD342C
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 11:25:44 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16206.1778066737741320162
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 04:25:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N7nqp59K;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba840146so55574675e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778066735; x=1778671535; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2knZijpCWOATWtTObkZUFmEbdkBCY43MOiob+29D7mM=;
        b=N7nqp59KcLwPgwEVM2aiO0diQf9k8VJCn6ucbmnxfoKBLprlibIF7HUg72HIDzx+Pc
         dBI1rHE8lxmxmRex5tL8o6wwZY3OyZ54Htvbumo9d0l923WMdTStRIkhVgWAwFUO6vHk
         TmM60JYtJNTVIl9rUd1IdFAczG3InNgHvs1Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778066735; x=1778671535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2knZijpCWOATWtTObkZUFmEbdkBCY43MOiob+29D7mM=;
        b=crqAI6RcIuFt9srzool5ovHnfWCgN8UNhvtHC8eo++o4FY7h41mawWXPbYfPkYv6Z8
         useJ5DiV4ZFXp/E/zFS0aIM9vJPuk8IvnwFbPoWwEgVgQxsLOv8xvlFYePYA1d9WM/KP
         clFb+vv63XlLianZTcwmLaf1n6NrVDsKLHeU9sGjPDsrZGN/rUIbsCtZiLgyJ6q8g3l0
         Kqf6U4KPpCzunt+RSib/jghmjY4VllLdttaTODQL/d8Q7sT+kS9ISwUJglz5aKRDl9Al
         X7J713AaVkZ15HNqAyGZzwyV//ybiG0DoRf7rde2Lov3fTVAspbOKIDYqoNDQ/cvITbO
         FpSA==
X-Gm-Message-State: AOJu0Ywsk/BSbblG5qqdC9oMeaFApuWTLAN526hsn+QlwQ69gOdd3jqi
	cZJDu07gvM6Ay61EJAwsDwZ2QlZdI58vWzcS8Bhlf9LyEZd5GrYHUb6E3TY0e9yjQs0IAqayyqn
	c83G5
X-Gm-Gg: AeBDieu8h5yszsoJ0EnbAO0+2fNVfpThTSY7cZlC3VYIVKs562Blwo79zHN5N8N7cJo
	VFt+ofljVECUeC1vMWKg0ooL8XDa5QadDagZV7LfItOlln4gdRVj6kL+WeeVKQUKS/c5605PjSl
	MT/36EADm/xX3DJW9ITWHv/R4iKaBwdzIWbiN2xuTkE3Dvdf33P29HVunwaPHPsXASsfCH1kAfd
	Gw7bbpPVB+Eqwoy8A5+DwGzMSxon08L5DNpTlWm9lY8URnJu0s0m9GR5gcFidR47wigcuNBxDDh
	2pdIVfmfX5J6ropgqDcrS7xCpdF37Aq/nEOKF+0UQcRha2vIWp1ck6ZbvKNuI97oAkOk3ZJ9q9H
	coB7/9OGeTX1T/diEI2f9/XE6NPaxqcQ1CoeWo/ylzSIAgLTGiRMBN4jopmETzkDdI/2SP/9AG0
	mRqOGbRBwEshMFsXISxehCZG5N3OTVh6cVBrsaSEjAasn4q7IJAsrElOR7x04keYM=
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48e51e0a6a2mr51339285e9.4.1778066735546;
        Wed, 06 May 2026 04:25:35 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5409:94a2:bd3e:6c21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5312de76sm14463775e9.21.2026.05.06.04.25.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:25:34 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch/git: Fix leaking of temporary directory
Date: Wed,  6 May 2026 12:25:32 +0100
Message-ID: <20260506112533.3826658-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 11:25:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19442

We create a temporary directory for holding a clone but we never clean it
up. Fix this by using a context manager areound the temporary directory.

This resolves a buildup of tmp directories in DL_DIR in builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 10eb63b205c..fda7bf9faae 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -391,14 +391,14 @@ class Git(FetchMethod):
                 bb.utils.mkdirhier(ud.clonedir)
                 runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
             else:
-                tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
-                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
-                output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
-                if 'mirror' in output:
-                    runfetchcmd("%s remote rm mirror" % ud.basecmd, d, workdir=ud.clonedir)
-                runfetchcmd("%s remote add --mirror=fetch mirror %s" % (ud.basecmd, tmpdir), d, workdir=ud.clonedir)
-                fetch_cmd = "LANG=C %s fetch -f --update-head-ok  --progress mirror " % (ud.basecmd)
-                runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
+                with tempfile.TemporaryDirectory(dir=d.getVar('DL_DIR')) as tmpdir:
+                    runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
+                    output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
+                    if 'mirror' in output:
+                        runfetchcmd("%s remote rm mirror" % ud.basecmd, d, workdir=ud.clonedir)
+                    runfetchcmd("%s remote add --mirror=fetch mirror %s" % (ud.basecmd, tmpdir), d, workdir=ud.clonedir)
+                    fetch_cmd = "LANG=C %s fetch -f --update-head-ok  --progress mirror " % (ud.basecmd)
+                    runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
         repourl = self._get_repo_url(ud)
 
         needs_clone = False

