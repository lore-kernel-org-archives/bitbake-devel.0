Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD4C64ED6
	for <webhook@archiver.kernel.org>; Tue, 28 Feb 2023 13:36:28 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.23259.1677591386501069755
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Feb 2023 05:36:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20210112.gappssmtp.com header.s=20210112 header.b=tf1sBO2q;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.214.175, mailfrom: sam@liddicott.com)
Received: by mail-pl1-f175.google.com with SMTP id p6so9588821plf.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Feb 2023 05:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kyplrqu+k06BSoTjuux4mjZnW1jB02ALTOcY0CdAesE=;
        b=tf1sBO2qLj659GF6wMrUv6w8/SVtJbwLyiqKw1f7IpPB1WRFQjMVQQKhB939w9/Q+M
         TmBt+5kAk+sPKtHVp+kwjt5CeFHd8ZtQLhDibR05qBhn/lKD8vvsCPshGi7Ovu9OlNHK
         fUR40HrbAGUPQ1rSSrv/VpzunKGlnmZ4ZAzhLWuC3qSp0gLyo9zOKrYSsiiC4ZZyiqWb
         ISELYGVpApMKGVaS27IbjxctkvUqlbxdtY+bDxf48Hmpo+tu+yNxMeclj525waNqCHWN
         RdzFe/4SB5KjJ6OO6e38oAuxWPbaeCMTpqwyKqv7NqI3yCAnWflrfF+wvAZoLdf6pUKn
         +c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kyplrqu+k06BSoTjuux4mjZnW1jB02ALTOcY0CdAesE=;
        b=VFaSIc0wumVrEZtHKl5iEumNT+0J+4JyHrQEjUpRvn9PgBFw840lAB0hqmnemgP19g
         kZI0YcXXnBrvDyfwS7kGhGlXp1t2vsIHIRM3nCfMyeTTg7AISFcodspIRNYUrA70hkRp
         nQB8NtEQSNdy4bDW//Kkh51QEFAyo4o9FBdlbzO08PmYV57NRfFM3CCiHvfSJF6lzo0X
         ya/3GeD0SgHtAa/x05nzZWodhkKH1ve4u+hRrwLV/Ct0K0aEsnCHvbN8ehO6CxR6ka3f
         MpZDBxtHj5n2xxm8zmDVBsO+tV3UlV1BRJhdVX++y4ahr6UtIMRo60/ypvOXlgO66Wmx
         Zw3w==
X-Gm-Message-State: AO0yUKV+rQ1UxFaLaXeIiDJyKKRuXGS01llSKh7fQjDD4Rzhm+KCWenl
	fkbXnrno7ULgBG8RaGzYdbn3swy2OzUhAJH0uDDG9HGHT45SQEtL
X-Google-Smtp-Source: AK7set8cdBuecMPorMPoYiYFC7BDIrKFUuOTsDTvEZL8iGt7ZLqfeKfzBgJ3UOQHNLGNu7q411hwUKJY5Adx/YrXvMA=
X-Received: by 2002:a17:90a:d3ca:b0:237:9cbe:22ad with SMTP id
 d10-20020a17090ad3ca00b002379cbe22admr1139534pjw.5.1677591385278; Tue, 28 Feb
 2023 05:36:25 -0800 (PST)
MIME-Version: 1.0
From: Sam Liddicott <sam@liddicott.com>
Date: Tue, 28 Feb 2023 13:35:49 +0000
Message-ID: <CAOj-5WB8oaXJ=rrXDNRYzhB92CgRrsutveMnWXhEpcEJKb60KA@mail.gmail.com>
Subject: discussion: git fetcher now needs either file:// or -s
To: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Feb 2023 13:36:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14508

These recent security changes to git prevent git.py cloning of local
repos that contain symlinks in the .git directories (e.g. a repo-tool
manifest checkout)

* https://github.com/git/git/commit/36596fd2dfa473cf1069d23776e62cc156e7b5c6
   clone: better handle symlinked files at .git/objects/
* https://github.com/git/git/commit/6f054f9fb3a501c35b55c65e547a244f14c38d56
   builtin/clone.c: disallow --local clones with symlinks
* https://github.com/git/git/commit/bffc762f87ae8d18c6001bf0044a76004245754c
   dir-iterator: prevent top-level symlinks without FOLLOW_SYMLINKS

To prevent some local clones from failing, the bitbake git fetcher
could use the -s like this:

-            clone_cmd = "LANG=C %s clone --bare --mirror \"%s\" %s
--progress" % (ud.basecmd, repourl, ud.clonedir)
+            clone_cmd = "LANG=C %s clone -s --bare --mirror \"%s\" %s
--progress" % (ud.basecmd, repourl, ud.clonedir)

Instead of "-s", others may prefer to restore the url prefix file://
which also works,

-            if repourl.startswith("file://"):
-                repourl = repourl[7:]

I don't know which bests represents the original intention behind
removing file://, but "-s" gives a quicker clone of what for me is a
symlinked source repo anyway, and for the lifetime of a build I'm not
expecting the local original source repo to vanish in a way that will
affect the build.

Sam

