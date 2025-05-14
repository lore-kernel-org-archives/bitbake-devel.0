Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2092C3ABDD
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 16:55:41 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web11.107747.1747241735581797595
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 May 2025 09:55:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DHTE0U1M;
 spf=pass (domain: gmail.com, ip: 209.85.167.180, mailfrom: raj.khem@gmail.com)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40356cb3352so53515b6e.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747241735; x=1747846535; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VTlbXbtsJkJcgRE3gcdc87/XtaRs6HMJE4i2wCCC+o=;
        b=DHTE0U1Mdik1RoveoN4ztao8n8N8xAvNspU20k2juUKzzJMi2+pa3bnKnaapE25mdm
         FKFUR8kAqsI0vZdHQ4eKVonQ2JJo/QjyaBvT7cK4K5m/vho1igxZNwXwxZsT+atOBNCu
         VVStDXqbCJxevi/PZzZDHVEipz+GMF9oQodyA3HzrBOiVzeSFv+211gMpjAbM8d85xZf
         AP/sNdrvnijXOV5Ec8CTLNgPFcyHZ7prLoartjbtIBxulZyq05z9hgg5d0u7su3APp32
         XgN3CgbZTSESklO+BDuMVr3UnzGWW97WtMcNowMbu1EgQvzFMUhRg396AZke4eok0WF/
         l3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747241735; x=1747846535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VTlbXbtsJkJcgRE3gcdc87/XtaRs6HMJE4i2wCCC+o=;
        b=VLo31ZlEeRzf7De5FWtgvvX9Ltvmh8sqRHbXQjEHXHfXw6yBp5q+KETCCG+aCovpHt
         mOI29iVm9bXAQD5orTL4DaRNKrP9c9Wdh9ajAHxBq8b/niCMJMKiLv9mgZ+x4NlN8CAR
         BotG5Wfi3eM/brHn4ZTimHjkgnrUA2DVdTW/GHSzn9s/M1ie/MidcTdBnaQClWYm4gwg
         5fHYwOPEWp/4ApCHAQVABnR7y+jKUBvhHtswtUKTj/z75/jmqDuRUk0e+wau/bxd5P06
         /e8H325exy5bh89i1yjoUzeesvqAGLao9KnGp1LtuwQ7R8xWzfD45xcMjfot4PomH0LX
         DCsw==
X-Forwarded-Encrypted: i=1; AJvYcCUKsOfTTNN0wkHzzVEPumRVSKWx29TwgUpJJ5cMhiJA0SFPHlCzdHLcmwyeGm8TGSUieKpk7XrlsTWgIAEt@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw9nFBY4Mm5LmjN2Fp/HVadpyYAGAu7VWdrS5b9b6mibh4LuQ3B
	pLTR96YQTqGfVeobwkI6uNZMNTd/5aO+KTLUI9uCbuq27XpD9PsIKxJdI50Gc7RkEvJnAB0SQas
	veW23plhSw0qUT9piEO26xrHnz0U=
X-Gm-Gg: ASbGncsuJp4qoC50sdswDrRHkQ1hWZfPDWA7IzDJTF3Gu6/wW+p8achX+ApZB2bjCO9
	NsusQ1Y703S/SOA4DeGChiInSZOlZ2LkX90mefpBCaf5NCJSnpfbOyNFH1a7w+E1npuRtgCivoL
	kg8mHHXaSEDyXbw4n7OelL9zM0CLWzBNvn
X-Google-Smtp-Source: AGHT+IEnihUxUEvNqoxBtpz8AnsRUBbF5bD/FxoeDAOQll7rBGxidPlu4/C7U2OLfGGTOtE+69cqQX9bjTUd/oBO8vA=
X-Received: by 2002:a05:6808:2287:b0:3fe:aebe:dde7 with SMTP id
 5614622812f47-404cd5f0d1fmr202161b6e.2.1747241734698; Wed, 14 May 2025
 09:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250514050900.2096691-1-Qi.Chen@windriver.com>
 <49e877afefd86763dc916c0f5f6445026986c752.camel@linuxfoundation.org> <b680eae5-c7c5-4fdc-8934-d4f8acdfe7fe@windriver.com>
In-Reply-To: <b680eae5-c7c5-4fdc-8934-d4f8acdfe7fe@windriver.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 14 May 2025 09:55:08 -0700
X-Gm-Features: AX0GCFtxjtA9LdK1iUC51p_UJW9fC9T6FB-ggPxiMHPc93famKqXh65uavtBh30
Message-ID: <CAMKF1sria5rq-i_d=MKcqNgfH0t2azWyYR380AeXgviXeT+9mg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] fetch2/git: fix shallow clone for tag
 containing slash
To: Qi.Chen@windriver.com
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	liezhi.yang@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 16:55:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17610

there is a bug as well - this should help with
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15862
so referring to that would be good

On Tue, May 13, 2025 at 11:33=E2=80=AFPM Chen Qi via lists.openembedded.org
<Qi.Chen=3Dwindriver.com@lists.openembedded.org> wrote:
>
> On 5/14/25 14:28, Richard Purdie via lists.openembedded.org wrote:
> > On Wed, 2025-05-14 at 13:09 +0800, Chen Qi via lists.openembedded.org w=
rote:
> >> From: Chen Qi <Qi.Chen@windriver.com>
> >>
> >> If a tag contains slash, e.g., debian/5.22, then shallow clone
> >> fails because it's using a wrong ref.
> >>
> >> To reproduce the issue, add the following lines in local.conf:
> >>
> >>    BB_GIT_SHALLOW =3D "1"
> >>    BB_GENERATE_SHALLOW_TARBALLS =3D "1"
> >>
> >> And then run 'bitbake debianutils -c fetch'.
> >>
> >> What the original os.path.basename(ref) wanted to do is to remove
> >> the strings such as refs/heads/. So we do it explitly to fix this
> >> issue.
> >>
> >> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> >> ---
> >>   bitbake/lib/bb/fetch2/git.py | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.=
py
> >> index 11cda2007d..784a45bda2 100644
> >> --- a/bitbake/lib/bb/fetch2/git.py
> >> +++ b/bitbake/lib/bb/fetch2/git.py
> >> @@ -639,7 +639,7 @@ class Git(FetchMethod):
> >>                   extra_refs.append(r)
> >>
> >>           for ref in extra_refs:
> >> -            ref_fetch =3D os.path.basename(ref)
> >> +            ref_fetch =3D ref.replace('refs/heads/', '').replace('ref=
s/remotes/origin/', '').replace('refs/tags/', '')
> >>               runfetchcmd("%s fetch origin --depth 1 %s" % (ud.basecmd=
, ref_fetch), d, workdir=3Ddest)
> >>               revision =3D runfetchcmd("%s rev-parse FETCH_HEAD" % ud.=
basecmd, d, workdir=3Ddest)
> >>               runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, re=
vision), d, workdir=3Ddest)
> >>
> > Thanks, I just saw a few people reporting this.
> >
> > Would it be possible to add a test case to bitbake-selftest so we can
> > esure this doesn't regress in future?
>
> Got it. I'll add a testcase and send out a new patch.
>
> Regards,
> Qi
>
> >
> > Cheers,
> >
> > Richard
> >
> >
> >
> >
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17607): https://lists.openembedded.org/g/bitbake-deve=
l/message/17607
> Mute This Topic: https://lists.openembedded.org/mt/113103962/1997914
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [raj.kh=
em@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

