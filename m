Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DB9C7EE30
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 16:01:08 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.2190.1750780865194297693
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Jun 2025 09:01:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=k2SHuQ/Z;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fd1b2a57a0so5241956d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Jun 2025 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750780864; x=1751385664; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TG9HJ3A0zKvg42zmBDo6Vxx6N0Ur9ZHPB+QDMSyOfYw=;
        b=k2SHuQ/ZQIxrP4Eh650xeT1a3WvdFfvAH6p7M3k7HxDf96C+M31nAU6mHW5zjnPLzJ
         YmV2OjbwULhmt5lV3vrEIECbrfzvlc76ocyHs+Py1aPfb8gUCBY/dbbcM6ATBPjl44PD
         ILvg/gMH0AASB6iqixFqtNd/zp+L3YKSMmqTysDtPwmZMZePv1xJS7SCnKE4T5XEhG6f
         EovBMuh3CGo942hJHLB64Dh8iF3XLUnL+wie43KgIHJs1DnQyKTqJN9HZK06B0LHSszT
         cpQf7eYWTbAgmVbe9xqZTaFbd15UUYmZwFAhiwiUzsGwYDHMH9HhSyISaAjGasIRA2/M
         hy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750780864; x=1751385664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TG9HJ3A0zKvg42zmBDo6Vxx6N0Ur9ZHPB+QDMSyOfYw=;
        b=ahMntcvneezkeVEqEIYmCS9Ma8Gu9Zn9erQTDBMUJzV0TpizDFe++/+7IBvDMcV6eY
         Ri0G9i0InAmPF5yZVcv6pZqV7mJwPPeqA1YWVlK4f2ZlBC6f0nZ/McFOcNACtnlQZkzI
         UTB5nN0rgYqOSN3OMmXWCQFBWtKJ9AaY/Z40SDCDqvSBhi1MJ9xqAZ6anYgvDrqt0+v+
         +02h+Ui3j+IMK9mDsIuIucnlqOeVCcY1rviQBIU4eyyAjHe2AT2FB+LoNKavCGUcIcmE
         92b/t5LL09FJX21hJtWfdwHvlOZOFj53sNT9GwsoJoiQx3XK6oeSXf7YmUp5h9h7cSKx
         lz6A==
X-Forwarded-Encrypted: i=1; AJvYcCWFcAufgaEt+ARtxBsD63QHifpMAVomKD0u7deLTEIQR6WVDcZKLNrKO8dMERbz6w1igYSRMHvEGm5sPPGd@lists.openembedded.org
X-Gm-Message-State: AOJu0YwgYBEVyc43bWgxLQ1ZPUoes1QOt4fmDWN1ctdTtvWK5jgjveXp
	hZOJX0/F1jVJHeEPUXa3bkLRPDwQ6mYusJWzKCr4mRh7yGP5/awt2uZ7HkrvyWwOF7YDQVEm5Ep
	4d3+8aOZs9y/qLstozS9Q8q+i4NnKuVbG4w==
X-Gm-Gg: ASbGncs90CO6b95bvGyimedGB9mkgG0ntsmReZsUEIZMcohJlhO3L5E5i/hnsxHtgsR
	kOfjpBCBBrQIWZHFvEn2Gib0k+zhioYEpqRbVfqxfQiq3GtRlQmu42/bpA5G9wy9q02wWXpFkzs
	zvyZzYzwOw/23dLU4iBBT90qTdHx9+y1e7TaD15nHxqW43SeUyKRMWLH8Bbf5V7yWvFRJYhIsdg
	ocQ/A==
X-Google-Smtp-Source: AGHT+IFNNTcROusqmiNv5N/TtR2gFEjEiXVGTkd1OXGfMplAY10+wuOjPWoF/YnypJsdtjhHLcV8xyHnafTTe5ZUavg=
X-Received: by 2002:a05:6214:c83:b0:6d8:99cf:d2db with SMTP id
 6a1803df08f44-6fd0a5d7bf5mr311613576d6.38.1750780861754; Tue, 24 Jun 2025
 09:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250623165507.1633860-1-alex.kanavin@gmail.com>
 <6fb30604dfb196088f07c6b59f437eeb0f1df788.camel@linuxfoundation.org>
 <CANNYZj8bcMto=-OHPNEZs_aEM4vr9K1ujVOZ77EDBT-9xC5sRw@mail.gmail.com> <749dde0c3ed74dc938085cd15316245eeaa15cc4.camel@linuxfoundation.org>
In-Reply-To: <749dde0c3ed74dc938085cd15316245eeaa15cc4.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 24 Jun 2025 18:00:49 +0200
X-Gm-Features: Ac12FXzEr61-W12wngpwinTvPp04UteLqOAZrKReiXIS0XXLwzJ6oVyvq4ZBI2o
Message-ID: <CANNYZj_9Yv-SnHt26fbkAbYjjmwKwftAbOzZ_E2zuz6S-64Kew@mail.gmail.com>
Subject: Re: [poky] [PATCH 1/2] meta-poky/conf/templates/default/bblayers.conf.sample:
 do not assume integrated poky repo
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: poky@lists.yoctoproject.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Yocto-mailing-list <yocto@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Jun 2025 16:01:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17715

On Tue, 24 Jun 2025 at 15:58, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> > Right, this refers to the poky integration process that cherry-picks
> > files and directories from original repos, e.g. the default template
> > from oe-core (meta/conf/templates/default) does not make it into poky
> > at all.
> >
> > The patch follows the suggestion that such a tweak is possible:
> > https://lists.openembedded.org/g/openembedded-architecture/message/2129
>
> Ah, that is a bit different. There aren't tweaks of a similar nature.
> I'll need to give this more thought...

I want to put my thoughts (and a proposal) forward: the real issue
here is that BBLAYERS is a list of full paths, and thus is not
relocatable. And there's lots of awkwardness around changing that list
relative to ##OEROOT## and back in templates (and ##OEROOT##-prefixed
paths are still not relocatable).

I tried to think of a way to specify layer identifiers instead, and
have some kind of 'magic' figuring out where the layers are in the
filesystem. One option is something like this:

BBLAYERS_SEARCH_PATHS = "/path/to/where/layers/are /some/other/path/with/layers"
BBLAYERS_IDS = "core yocto intel"

e.g. bitbake would walk the filesystem starting from those paths (they
would be set by bitbake-setup or other tools performing layer
checkouts), and add any matching layers to the build.

I think that's actually not too horrible. Should I try to prototype
this? One nice consequence is that it makes templates optional for
those who do not like them: one could instead set the build entirely
from just a list of fragments (machine/distro built-ins at a minimum
:) and layer ids. Having to maintain templates for any possible layer
combination doesn't scale, same way as on-disk fragments for
machines/distros wouldn't scale.

Alex

