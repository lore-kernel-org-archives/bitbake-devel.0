Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D80BC433EF
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 13:31:57 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
 by mx.groups.io with SMTP id smtpd.web11.10042.1644499916701271908
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 05:31:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=UWpaQXYz;
 spf=pass (domain: gmail.com, ip: 209.85.217.45,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-vs1-f45.google.com with SMTP id j5so3101668vsm.5
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Feb 2022 05:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JO3LjJe/N7HTIAB1Li2nsYUa/oGA5r9npxz7wkhfuSs=;
        b=UWpaQXYzA6WY0AKmseMAgm93Ww54/N7s5Oe22niIm8Ki0Wnn2Ax4qfnUA+BxX1YLBB
         EO5za3tbWiGogGgWieVmclbs2dVNsM0NTygIlgndJRL8NVTeqJpWFVMiKMczRyzIgDH5
         MevC+I2ubw7SuhZcC6v4buME3ost+FmEy+SoXTTkPu/0qc19TQAEtgbElwV4jxuiz0Ld
         jzCnYR8KaQufMouWBen3BTcbcZiZNqCEbY4xf0QEOerxPRmJzFwpLkvTd+ulPoWaLXkC
         2oaJk7Jn/1GjtjmXst130GwXuy8QPvqrkgUYSguGToWDS2vH9q1pohdb+QfQUP0H1jP0
         MFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JO3LjJe/N7HTIAB1Li2nsYUa/oGA5r9npxz7wkhfuSs=;
        b=Jl3dEwJFJIXB6ktsPMCae+zzyN8BXiyCW61nCmxegOS7aJebREqCt2jopF1/tmWFiy
         PdhhOqfTR2RwRiTOfJ8XuOGH9U3YILYFzUjBu8cyFGyHuFAwcQXC/wWKDUHWj9KPHv2P
         tR7f9QMTkJswx8m3ytkFTGOqH1X2sLdfccU4KP49OaEE3tJAyatgsa4X3WwSnPGaWJfE
         1MS1DlKpfYsKMK3d0fnRxQpeCGlLT/5vI8jBfPT3JGwO0JsPHjksuTdw6XH5rqUmcbaN
         B6ULC5EuQtMevi0H7ACyhPHXWjL9YeQzO5NjjuZ5IALBMm06sEg6ZJ9092GHwjZB6SbA
         P2vw==
X-Gm-Message-State: AOAM531qAK4b2fZQrt3qrKp/EwaBEFXyOyg2OPAb4wdkHTOpxWk4AZqX
	7w66WBq/8NRFWSRlLyDDmB2P9AS9e8EL/8OolBM=
X-Google-Smtp-Source: 
 ABdhPJxsy8YKyNqo0LEAzZAIpU5fsxTAJKJJ4c7dsgEMSc17tIEDBUctgCIdyNCE9+FdkCsqRfkylQoRVEvQG3jlO34=
X-Received: by 2002:a05:6102:c50:: with SMTP id
 y16mr2316932vss.45.1644499915633;
 Thu, 10 Feb 2022 05:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20220210132714.22921-1-tomasz.dziendzielski@gmail.com>
In-Reply-To: <20220210132714.22921-1-tomasz.dziendzielski@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 10 Feb 2022 14:31:44 +0100
Message-ID: 
 <CANNYZj86ijf96uT3umpXywktF3X27vjeS1PAUULeNGP9neVrJA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/git.py: Check if clonedir is
 correct after shallow tarball clone
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
 Pavel Zhukov <pavel@zhukoff.net>,
	Jan Brzezanski <jan.brzezanski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Feb 2022 13:31:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13329

Wait, doesn't this mask the real issue? Is it ok that the tarball
unpacking failed 'for any reason'?

Alex

On Thu, 10 Feb 2022 at 14:27, Tomasz Dziendzielski
<tomasz.dziendzielski@gmail.com> wrote:
>
> If shallow tarball clone is used and if tar unpacking fails for any
> reason it might end up with empty directory created. Since runfetchcmd
> does not check any return code we might not detect the issue and we will
> not clone from git. Then due to missing hash it will replace main
> repository's git remote with the remote of failing recipe.
>
> To fix this behaviour we'll check if clonedir is not empty and if git
> dir is the same as clonedir.
>
> Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
> ---
>  lib/bb/fetch2/git.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 30da8e95..ed6ecb64 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -356,8 +356,15 @@ class Git(FetchMethod):
>
>          repourl = self._get_repo_url(ud)
>
> -        # If the repo still doesn't exist, fallback to cloning it
> -        if not os.path.exists(ud.clonedir):
> +        # Clean repo if git dir is different than ud.clonedir, which means tar unpacking failed
> +        if os.path.exists(ud.clonedir):
> +            if ud.clonedir != runfetchcmd("%s -C %s rev-parse --git-dir" % (ud.basecmd, ud.clonedir), d):
> +                bb.utils.remove(ud.clonedir, recurse=True)
> +                bb.utils.mkdirhier(ud.clonedir)
> +                os.chdir(ud.clonedir)
> +
> +        # If the repo still doesn't exist or is empty, fallback to cloning it
> +        if not os.path.exists(ud.clonedir) or not os.listdir(ud.clonedir):
>              # We do this since git will use a "-l" option automatically for local urls where possible
>              if repourl.startswith("file://"):
>                  repourl = repourl[7:]
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13328): https://lists.openembedded.org/g/bitbake-devel/message/13328
> Mute This Topic: https://lists.openembedded.org/mt/89045076/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

