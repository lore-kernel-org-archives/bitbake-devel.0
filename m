Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0B9C636CC
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 07:57:25 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.10308.1676447842383420722
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 23:57:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=DU9f02uN;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so2194025wms.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 23:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lktIbkZ7l+RMjlnS0xokmx4TwoLpf1Lt771v0kSZ13s=;
        b=DU9f02uN/+v0bEwOhBvgvEXCTOpH9I0B5W6IGpNReKhAQHw+E+7DoESdsUI+XQYrw9
         4ahbQdkt2dj+MzKhuRJDvfh6ZBxTlgdCKvV/A8iOdFjSByqkVmj40zPXTcgMrJ3KyKmc
         NJqaYDn1vJxU8clgnWtEr0CeoqfrzgRrHlnMj3ZDxNQWfbaIs7h9dVhur5WAHMGS+qj5
         3YATBJgax6gYBd+Qjfd3bKgn7fWW86m4qu4WNKY0mVn/eD7is3zIk55saM04rWa3ZX+K
         nt4sRjKdDtumM16vYg0PLQe2BoOC7mfdNRlLVhyTd3biXzZ80T8uAjn6a4pFUdSVZJCY
         MtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lktIbkZ7l+RMjlnS0xokmx4TwoLpf1Lt771v0kSZ13s=;
        b=WrH6PPdi+/r9NT6oWEoEFH0MyEJasH/CrT2ULO5pp/gmHm2Bssn59hCjc/PalmwhYH
         hTebIhIZ2OczmbllL3ciuIRJ7ICpeI2FWHuxEDtDsvQGruEKil2AavEKeweQOrRWz87j
         GrBk8/7jApi0LH2xMEoIMEvB77yMS/4HrxoYNjTPWa2jzAItHuutrk1pMOTEmgGKn5dM
         B45D3lJ/yIG+1pOXVFxuuLfY6T5qmvDRKHMuFLQhxgeR6Pny7s/+n5x3wPtI2y/rT/J/
         SVc0cMyTKZUGlNfe7rvvCzbGX6/8akrvn+mnoQHLIjJF68Jq4MYHcXe8TMkSnVNJlDHM
         RDWg==
X-Gm-Message-State: AO0yUKVLzkALQWoL4Me3PGYoN3Tl1a7ZEhL+wA3yrJhl7+8g0/L7btCR
	P3xd90/LEpXGgGqNLC7LeiO/gVshXSs=
X-Google-Smtp-Source: AK7set8Nw7EPyrSvy7txQpKmL9a8NLiA8074kIuBQ6dduyFYEE1xAPDWVstmlnqyLrkrMyNAsSaukg==
X-Received: by 2002:a05:600c:816:b0:3dc:557f:6123 with SMTP id k22-20020a05600c081600b003dc557f6123mr1301539wmp.1.1676447840646;
        Tue, 14 Feb 2023 23:57:20 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c459300b003dc47d458cdsm1343223wmo.15.2023.02.14.23.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:57:20 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [2.0][PATCH] fetch2/git: show SRCREV and git repo in error message about fixed SRCREV
Date: Wed, 15 Feb 2023 08:57:15 +0100
Message-Id: <20230215075715.667660-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 07:57:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14421

* in recipe with 17 git repos in SRC_URI I've accidentally pasted one SRCREV to
  be one character shorter and because fetcher uses:
    if not ud.revisions[name] or len(ud.revisions[name]) != 40  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
  to decide which SRCREV values are fixed SRCREVs this one was
  considered as tag or branch name, because it was only 39 chars long

  The original error message wasn't very helpful as it doesn't show
  which repo or which SRCREV was considered missing:

  do_fetch: Bitbake Fetcher Error: FetchError("Recipe uses a floating tag/branch without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE).", None)

  with SRCPV included in PV as error recomments it's a bit better:

  bb.data_smart.ExpansionError: Failure expanding variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} which triggered exception FetchError: Fetcher failure: Unable to resolve '0a92994d729ff76a58f692d3028ca1b64b145d9' in upstream git repository in git ls-remote output for github.com/Maratyszcza/FP16
  The variable dependency chain for the failure is: SRCPV -> PV -> WORKDIR -> T

  with this change the first error will read:

  do_fetch: Bitbake Fetcher Error: FetchError("Recipe uses a floating tag/branch '0a92994d729ff76a58f692d3028ca1b64b145d9' for repo 'github.com/Maratyszcza/FP16' without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE).", None)

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5fff6966..4e286ca9 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -736,7 +736,7 @@ class Git(FetchMethod):
         Compute the HEAD revision for the url
         """
         if not d.getVar("__BBSEENSRCREV"):
-            raise bb.fetch2.FetchError("Recipe uses a floating tag/branch without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE).")
+            raise bb.fetch2.FetchError("Recipe uses a floating tag/branch '%s' for repo '%s' without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE)." % (ud.unresolvedrev[name], ud.host+ud.path))
 
         # Ensure we mark as not cached
         bb.fetch2.get_autorev(d)
-- 
2.39.1


