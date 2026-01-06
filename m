Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB28CDC17E
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:11:09 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88598.1767701467468071216
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:11:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VujlrVqG;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ba0d6c68a8so85519485a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701466; x=1768306266; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QA7vQZsW28N82Kl2VSYHT2FnhOX1Q2vpURFUBAFN6A4=;
        b=VujlrVqG1MBwkoY47UZWuQeCKSMXV1v0bp6cepymPUiOXZ1HvPksjBaT4HKuwjjcum
         EWlJhvb+IPL1yTsjRDSJq5MPhRvP8XsEufuMJYRDNhGinO379hYXMituY8RBpwLrm90j
         ZaBs+NbV9+wLlWbET6JQhfyFirQbXMHBDP1KYF0+US1mN2d6IPR2gVCtaruBbNuSY98s
         lTEyml0YcrnDxnvwD1YMu94UL50IBLUXol8w8uZnxG/Hv6c774FQrt95KfhVGfZS0fp4
         GV/WgVQnCJJcZFJx+78Nk3SuiBoS1aqmDPYaV5vtpklGWjypID/+hTWGXifsadsZR0AH
         uldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701466; x=1768306266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QA7vQZsW28N82Kl2VSYHT2FnhOX1Q2vpURFUBAFN6A4=;
        b=pNR7NT3LHGLUtvx9IaHAWOmdhHPxbdi0s8+wWgWslwu1ArcBTbvbaeqoPNXgZN0bP5
         rYBQZtq3C04xES0olkUyqO7tAQqtwivw2NoHp/GkvY8sbhcKMagIciTDLL0ytMnaT3IH
         vdYY95lkUVXT0Gh0+LK0wcZLZ7XJYfpAuivg1IK6hAJVwN8vB33wPqaxl/lIo4EaPSes
         iomcXne4iNiplj/fw1N5EhDghkszQFjZ8XK/ok0qFzYWQoVo2GoJ54qBvSyBFzcQex04
         Dzzn9h+X0Pr38c/N91BlICNGgVQ+yhNPBFIdW/pMm1nnrAGEWWjgHr9FQhiaFyEccJHY
         Cm0g==
X-Gm-Message-State: AOJu0YzLXYUQ0Ml4Q/CmxRmmQ253tJ3JlE4mgXL7FAq00vhlPUrGXKaf
	6oZ/Xn8m8Svems1YL/BN/ZVnHJVAvT09si2nGtWnqjDChMkAFPdYXin2a5NNXeQa/66OOpiz3e6
	xUaI44S8WLeQGrOYT0kyzt+iQHGJTZPY=
X-Gm-Gg: AY/fxX4MNZI2EWLnvkCAfzmJ4ZEjfQpAektAa1ggLtpsN0gmvthWrqy+IEP9hteeacR
	fqmCMWmuMGJkDL211nRrYpA6F1D+ETfhnx1PyCIPBbMoD8sYWkACFmN35AR4itPKgsZazKQFZ0B
	nKBvKr+Q5VEec9rZHu/N75r52lTlNWWTdXt61JWQqGzKY61VvgbITQ2CKyzk/sQFr2bCrqVtVLz
	87gJbfDL3fbTNqa+aJpsd0SdSf1rqlurZplrJb3deRjjcNGAYPIi+okWTmvbv8bwTkQO///nBdG
	70GC5lYWM6wNlXs6iXgdz4Z38N4uPpPploUIEy0q
X-Google-Smtp-Source: AGHT+IFyBNkEykhSCq1MJPSUfRaT5wolyiaSpCuPb5XCKWqrq2gIoN7rm91LApq+CtgKsPbnZel/EnT568+wW8WRysA=
X-Received: by 2002:ad4:4145:0:b0:890:7fc7:8839 with SMTP id
 6a1803df08f44-8907fc78a69mr4352756d6.25.1767701466234; Tue, 06 Jan 2026
 04:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
 <20260102193438.2960561-9-alex.kanavin@gmail.com> <DFHDMY9WEY3D.RDQ8ZANAMU5L@bootlin.com>
In-Reply-To: <DFHDMY9WEY3D.RDQ8ZANAMU5L@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 6 Jan 2026 13:10:54 +0100
X-Gm-Features: AQt7F2pBYqS_egRbS8nExUDyjpro-UxCFCGS86ad7PNGQJI3gr2BZy46Noe_gtI
Message-ID: <CANNYZj_9G5YE1hO0cbK3KK2ZJEB634sprqmuo17OdkcpOXfmfw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 09/10] doc: document fixed revisions
 override in bitbake-setup manual
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:11:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18701

Thanks, I corrected all of these and sent a v2.

Alex

On Tue, 6 Jan 2026 at 09:52, Antonin Godard <antonin.godard@bootlin.com> wrote:
>
> Hi,
>
> On Fri Jan 2, 2026 at 8:34 PM CET, Alexander Kanavin via lists.openembedded.org wrote:
> > From: Alexander Kanavin <alex@linutronix.de>
> >
> > Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> > ---
> >  .../bitbake-user-manual-environment-setup.rst | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> > index ec1bdeecd..68b2ad31d 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> > @@ -938,3 +938,49 @@ Here is an example file that overrides the branch of the BitBake repository to
> >  -  The ``sources`` section contains the same options as the ``sources`` option
> >     of a :term:`Generic Configuration` file. See the
> >     :ref:`ref-bbsetup-section-config-reference` section for more information.
> > +
> > +.. _ref-bbsetup-fixed-revisions
>
> Missing colon at the end:
>
> .. _ref-bbsetup-fixed-revisions:
>
> otherwise this is treated as a comment.
>
> > +
> > +Fixed source revisions
> > +======================
> > +
> > +:term:`Generic Configuration` can set source revisions in ``rev`` to a tag or a branch.
> > +Bitbake-setup will make sure the actual revision will match the tag or branch when performing
> > +initializations or updates, and will capture the revisions in a :ref:`_ref-bbsetup-source-overrides`
> > +file.
> > +
> > +The file is named ``sources-fixed-revisions.json`` and is available in ``layers/``
>
> s/The/This/ ?
>
> if this is a continuation to your previous sentence
>
> > +or ``config/`` under :term:`Setup` directory. It can be used to keep record of
>
> s/under :term:`Setup` directory/under the :term:`Setup` directory/
>
> Why layers/ _or_ config/? It's ambiguous for users reading here what the
> difference between the two might be. If this is a compatibility thing (because
> bitbake-setup used to do it one way, then it was changed to another location), I
> would just keep the final one documented here (or explain that it's for
> compatibility).
>
> > +what was checked out when using configurations that do not specify exact revisions.
> > +
> > +Also, as it is an override file, it can be combined with the original configurations
> > +to initialize a setup in a reproducible way that guarantees an exact, never-changing
> > +set of revisions.
> > +
> > +For example if the original configuration had specified only a master branch
> > +for a source::
> > +
> > +     "bitbake": {
> > +         "git-remote": {
> > +             "remotes": {
> > +                 "origin": {
> > +                     "uri": "https://git.openembedded.org/bitbake"
> > +                 }
> > +             },
> > +             "branch": "master",
> > +             "rev": "master"
> > +     }
> > +
> > +
> > +the override will contain the exact revisions::
> > +
> > +     "bitbake": {
> > +         "git-remote": {
> > +             "remotes": {
> > +                 "origin": {
> > +                     "uri": "https://git.openembedded.org/bitbake"
> > +                 }
> > +             },
> > +             "branch": "master",
> > +             "rev": "720df1a53452983c1c832f624490e255cf389204"
> > +     }
>
> """
> This file can later be used with the ``--source-overrides`` option of the
> :ref:`ref-bbsetup-command-init` command.
> """
>
> ?
>
> Thanks,
> Antonin
>
> --
> Antonin Godard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

