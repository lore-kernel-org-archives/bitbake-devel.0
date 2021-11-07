Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652B1C433F5
	for <webhook@archiver.kernel.org>; Sun,  7 Nov 2021 10:55:39 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web09.29804.1636282538273003623
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Nov 2021 02:55:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=F93CZ/Mc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id v127so10689590wme.5
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Nov 2021 02:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pp+qjCEtb4PccqEcXCHbEeVM6dR1n5IIe/w5+VtkKqQ=;
        b=F93CZ/McNQov9a0uYPzsdar41LM8OK4P7yZn6xjOIc27CU8eilpnTDcCAyEBgna1Ke
         eqO0WBx/rn77qWGn1Veoc7c5v+SaQADnLk9k/rryNZEsyNCOlvR8zKsabMWUu4hDLhOJ
         ZGJKoeI40FjfthfFLY/2pgOhmNqoAtLey0jBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pp+qjCEtb4PccqEcXCHbEeVM6dR1n5IIe/w5+VtkKqQ=;
        b=cWBtWw0z/n5wrFRAgcUtHWnEXS5Fx6um5902yUEMqAzulEmzIuP7R7M/Tfi3F2+YGw
         y7YBVb7/F4qy7/43/bTGb/DdhDEgbIz63mUFyVHd4FIOHdvQgcHf7wqafGlZ144sigTD
         /DsdB48dHhtMRl4HREgHe5Gi4+kqvaJmOugBVAG0OCBNOs9sMVO5h3i87G89gXXa0502
         ef+VBFS2TSCxTbKlrX3/KS9GThBWNtPxQHcnRzwZa8t4U58vMQkRnIXW2aICBgKAkHdW
         FA2oU8DmQILYg1w8j58I1DH2F2/H6+QR7RmyypUZKKZr61UZO8biITVsF1Ru8+XpO9cj
         wYiQ==
X-Gm-Message-State: AOAM533ikRjQPSCJWBbKWi1V3rvRNX4rh6meUVZMr4grN+iz4uAkynUG
	WGwd24Qy25cwwFBPH/T65M0lQsmoQvi9mg==
X-Google-Smtp-Source: 
 ABdhPJwiTIJ43nFuKVVYzYiRT2Lyr2N5dLRwt7NC/jS8Y/t92fODj1p91TInJMIoT/kazcI4T4SPmA==
X-Received: by 2002:a05:600c:4e8d:: with SMTP id
 f13mr29087929wmq.7.1636282536198;
        Sun, 07 Nov 2021 02:55:36 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:fdfa:2bc:4272:d318])
        by smtp.gmail.com with ESMTPSA id
 t8sm11942210wmq.32.2021.11.07.02.55.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 02:55:35 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Update pcre.org address after github changes
Date: Sun,  7 Nov 2021 10:55:35 +0000
Message-Id: <20211107105535.3702344-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 07 Nov 2021 10:55:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12928

vcs.pcre.org was a redirect to github which we use for subversion testing.
With the protocol changes at github and the removal of the redirect, use a
direct address for github.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index b83ec06450..6fd919170b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1137,7 +1137,7 @@ class SVNTest(FetcherTest):
 
         bb.process.run("svn co %s svnfetch_co" % self.repo_url, cwd=self.tempdir)
         # Github will emulate SVN.  Use this to check if we're downloding...
-        bb.process.run("svn propset svn:externals 'bitbake svn://vcs.pcre.org/pcre2/code' .",
+        bb.process.run("svn propset svn:externals 'bitbake https://github.com/PhilipHazel/pcre2.git' .",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
         bb.process.run("svn commit --non-interactive -m 'Add external'",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
-- 
2.32.0


