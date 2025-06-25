Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D85BC7115C
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 13:56:50 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.16040.1750859808343455471
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Jun 2025 06:56:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ri9ByAyJ;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6facba680a1so72361046d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Jun 2025 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859807; x=1751464607; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TO6bS55TGLKoK5sv35n0MZNbsOp0ani7xk2IKmTuWjI=;
        b=Ri9ByAyJTDgDJCpdKafS91zxk3Yz/tuFJ+2CbMamgBCgbkDUlApYvmhVJDAK2wTnt7
         Pf9/YU8YMCPqBxaSrhgEr4PbLt13BgaEByxMtTHeUh9UY3d+VVLEhBa/9Ldon+SA9M3Y
         EhoIu161GPzWBwIgEEoInFlj3MioEpXmnbdNMYwHARGsEjllUjvX0CyuUOn9VfpTE6fF
         B9NyQvFprW7pstumdpTqGKeCQwkHf4r+b7u78O4xj4sLiyEMVCiSDB8EuXwOP4yV28v1
         JnUd3pbFvuaeJSWnj6WFIlpIa01RN+jM1Bya+6RKwyW8OOwzg0on32IkLpNYu/lTVDha
         1OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859807; x=1751464607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TO6bS55TGLKoK5sv35n0MZNbsOp0ani7xk2IKmTuWjI=;
        b=ZYSt4mYA8uaQxgwGNEXsn6uRyXsKk5A75V/fTEqknUfPr/VBjVejURpI3J6dFYeCXK
         dO+plNP5InVXieipriK/+/DBR3uS9Mc3FY0vC7+6jMVSTvPGoc4OB9rdgyL8a9+qhRu8
         24EVTE6U46fFHcvJ50WvVNS8gfmk0iWSMPxP/1SafXBfrCb4B8pNzreupTMmauOH3a24
         2xBOLlwOt8TxQuKYI9Q/zQQxAeKch8pFQWfDFOClpt/eUW/TbM7oMDtGHc8tIFfRTi37
         rcAzDAuq57ZEvrParEZZr0uAdAqQibd3s4NtWpyRyOhBacSyhzqmkjlTdp/mTeo8YBfn
         2CuA==
X-Forwarded-Encrypted: i=1; AJvYcCVQnBEUat6OH39ZHRBa9HD5yvusuaFHjB9jlO3+uuJqmGwlEJfS0RgEwV++lxftoVHpg8NIXW7no6iJqT2M@lists.openembedded.org
X-Gm-Message-State: AOJu0YxHzAW+UYSFB79uJWE5ONbrY5CNA+WbxxN0GvrTsPKlWVZ8fHY3
	/fMcMhZ4p/rmq6/P0Y6/3TFd4PBLF3hoJqg1hdKb5JGHhg+ipDnkY6ScQd5KddsjWaGW1Cqaxer
	b0tN6Y0+1qUJmx3pLwdlhUBHPYXkz9+U=
X-Gm-Gg: ASbGncsqNUHCPz09Nw/Mk4GCm4QlLx52PYvCFFHzCE6Q3CpIWJpNVSxOoh6/Tj608XI
	U0xvXagGZxSmFjeeZvnp2YjETluSsVP+TWzwE4kiEJQGkU5Ld2T0DiH8xxGAf/7serzUNP2059f
	zhTcomqga6V6hxVOBtHQcHsuQHdM+UXzAfCZ/JAFVfG6TykR52Ny9Haq/nA4SlQspnFq3ZIlb8F
	Jw5vg==
X-Google-Smtp-Source: AGHT+IFgxhHKN2m/Xijqg5QqK542/8hM3Xxl+EPW+Bli+BCzWuX3ZeaCP4wSkEY2Twob6vovqvr9lG9lFePKhLhYW6U=
X-Received: by 2002:a05:6214:5b08:b0:6fb:4f9e:957b with SMTP id
 6a1803df08f44-6fd5efe3678mr42763286d6.43.1750859806794; Wed, 25 Jun 2025
 06:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250623165507.1633860-1-alex.kanavin@gmail.com>
 <6fb30604dfb196088f07c6b59f437eeb0f1df788.camel@linuxfoundation.org>
 <CANNYZj8bcMto=-OHPNEZs_aEM4vr9K1ujVOZ77EDBT-9xC5sRw@mail.gmail.com>
 <749dde0c3ed74dc938085cd15316245eeaa15cc4.camel@linuxfoundation.org> <184C05EBFBF7A622.2779@lists.yoctoproject.org>
In-Reply-To: <184C05EBFBF7A622.2779@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 25 Jun 2025 15:56:35 +0200
X-Gm-Features: Ac12FXyr7uMBrxODu0dypy1FJaxeL6Waiut6t37Je0bbsQnDq8p9hDsYddZDTLs
Message-ID: <CANNYZj-1im-sOPEGV8Pwph5gqqf8Kstay6mpwi1sMdiMZ-GzDQ@mail.gmail.com>
Subject: Re: [poky] [PATCH 1/2] meta-poky/conf/templates/default/bblayers.conf.sample:
 do not assume integrated poky repo
To: alex.kanavin@gmail.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, poky@lists.yoctoproject.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Yocto-mailing-list <yocto@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Jun 2025 13:56:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17716

On Tue, 24 Jun 2025 at 18:01, Alexander Kanavin via
lists.yoctoproject.org <alex.kanavin=gmail.com@lists.yoctoproject.org>
wrote:

> I think that's actually not too horrible. Should I try to prototype
> this? One nice consequence is that it makes templates optional for
> those who do not like them: one could instead set the build entirely
> from just a list of fragments (machine/distro built-ins at a minimum
> :) and layer ids. Having to maintain templates for any possible layer
> combination doesn't scale, same way as on-disk fragments for
> machines/distros wouldn't scale.

After some 'background brain processing', I've convinced myself that
the best way out is that bitbake-setup would be able to write out
bblayers.conf itself directly, from its own configuration file. Yes,
like kas does :) I've resisted this for a long time, on the principle
that bitbake-setup has no business directly meddling in build/conf/,
but really, every other option is not as good.

So, a configuration entry could look like this:

            "qemux86-64-poky": {
                "description": "Poky reference distro build for qemux86-64",
                "bb-layers":
["openembedded-core/meta","meta-yocto/meta-poky","meta-yocto/meta-yocto-bsp"],
                "oe-fragments":
["machine/qemux86-64","distro/poky","core/yocto/sstate-mirror-cdn"],
                "targets": ["bitbake core-image-minimal
core-image-full-cmdline core-image-sato-sdk core-image-weston"]
            },

and would not require templates at all.

Bitbake-setup would write out bblayers.conf with BBLAYERS entry
('bitbake-layers add-layer' can't be used at that point yet), and then
enable fragments via bitbake-config-build (this is already
implemented). This should result in a functional build directory, with
a blank (or absent) local.conf.

Then this patch, and the ones adding 'blank' templates become unnecessary.

Alex

