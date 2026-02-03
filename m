Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11969E83064
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 20:09:21 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2911.1770149360625833948
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Feb 2026 12:09:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z+eM5mAN;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-894774491deso76938376d6.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Feb 2026 12:09:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770149360; cv=none;
        d=google.com; s=arc-20240605;
        b=gPI4/iY9rjrI9CinvcJybX+vgZ1auGDgfbsraCpEFqj8gPYnJp77lARnrjJyJh5CXA
         X15YQX5n+KHHRtpTw/8ZNO2w6CZUnGDyJ1kJNNusZBbB0Y+oVoIS1x7UajBScFFbnVEe
         1zz0+2JuGQemSMpAbetsp4Rnw+9qfV0k0ySKMHZ+HstGBnK+rqy2p7C8xlXZZyk9RjSg
         pOWEpKA3ddY4Dn1S5QDxW2qiqwVObxJDM6zsbuxgrdtJpWXCNJnIAGRCN3zwkwUiEYr7
         vtr3NmgLHl26CoepPlhGjryp65AYDe4UpIwjzytnz9mI83jalAQcl3odZlvHThwIorGc
         V1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d5ctf17tznWNbljJ2XX/bP+Xm4bJB16B0RbCsHgPplM=;
        fh=xFJHH2cxj7sVA9YEQlWbfoJHyGB9PRgHmiQTZZciMkc=;
        b=EZM2tWcxd2c/qwvnopXywy+w33s9+HW3Vw0vZjCigBjGxgMBKALtHrwhMrOtaPt5jg
         iuIIttOhSQtXAv4xqkJVIONCKMsut5gHwI7ot/sTrRqKnHslF7beetBvs6F0bVGwL31/
         ETRPKTbDNaL4v7NvHctY0mKz1HyF+k7t97xfNJwPdvXhLegusmo699SynLn3XfAWM6jW
         dEgx+nKqEBykxXSCz7/0NIdXuXcDExTKfe2W3bc8EPPErH6kM1ANPjy1xrYPwKMnxwS6
         kjkfkY06PISnE5vH+aPPr+33R2+Za0EYgPKOdxoU1IJZE5CSm5KOlnWYTxU1xZy3g4IE
         pm3g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770149360; x=1770754160; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5ctf17tznWNbljJ2XX/bP+Xm4bJB16B0RbCsHgPplM=;
        b=Z+eM5mANzpg5qnBw2+CKupfHyVBsHN6aaaz9bvEdFs26oQ8aQUTyQfFkWAUPoM3rvo
         4+Nqrv56C/4PAQXwN2mUUNnnDxD882+hOfDMmqdmiTyJeyzbTWsqHwY7p6MMPMWaVuAG
         IO+IW9OZcs1ePMVZVskKQrTS3PnUbeCvnDbiV09IRIhmg8JmvnT7Yzaw7dH9mL3E2L34
         m1ZfdaX+qtbl4RVfDDdAT/Bg/v7vTuTzTKde5fF0oQtt6P0x86RJ7dDU+910GNX6FXX8
         /JXwTdbFANnoTj32GI5UFHfwnygdQCif2noIKf6RTdPsiRv9AoKCH17r3eIIFcgfdAxF
         lx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770149360; x=1770754160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5ctf17tznWNbljJ2XX/bP+Xm4bJB16B0RbCsHgPplM=;
        b=lqe0aoBNHJrO54/Slsh1FxjxQ8zjtXAGK5+QEtQXPjT/Grl5kLQFIz2R+pg7ZQPrEL
         rpB7FiLVFBhf9P31wpwSbXMUzBmF5fwQmgcDaG/aXuSpO+ivRX6Sf2L/59mAORZJ86G+
         Ah0Ynfk7N60fUkv1skuo5CAHyy7vpnHlUAxU9SR8Cg/l6qJC/O2LO55czUzciKt6FeSr
         LfcqTIJ+4U2C2x+vbzYbc6eTz5HyRsqv9HIdw3aDXNUgEV6vlDWectoES23iG4XGIF/d
         nOXBJcUxm/Xb54iyhBNI9pFKSr7zcZl2jV0VXxB5Ni3uF7uLSefjYyYLpK9AuIwQlz9m
         Lwqg==
X-Gm-Message-State: AOJu0YwslmJwUZWpiJvIkLazg9Jh+2m0EJeu0qAGn3WuHfKKn2k2JEbo
	oYvmiG9hjZNEXyN3sezmLCHvx36NUZHD85H8qYYzCrF1e3DTz7l7TYCAJPuXE+kB0chyMXaJvro
	fMbk5KsuXWTQO0V2gcVfHFmTiNp4hIj8=
X-Gm-Gg: AZuq6aK+PMIk04yHhOdwGjIAO9tKRgM7LZC6kZ8e5YFqh6+/s/1JNakoz1KqbzYlciX
	xxn2JQpG/gcTPy2nxJEhJle1GcVzn569x2WKcNH9By2Lrl2SBuoD11S3mCHA40QjuikjKpGT6i4
	UnNlZy4aFitCIxAZ04P38RXjsMnK3tMlPeO0VK5MX7quF2xagnGznNNRq+jnrpjPa/UHSXyE06t
	x4ND4IblGUSEZ1guLA9A+3XbUylp/FfonBYRFW5Rp4QuOdEY9uLeg1SVlVRpgmYxP4A9bv2Kqq3
	fqecDkJhHNwjD5+gXCOv8DNum5bxsRfmwIc60Jb2
X-Received: by 2002:a05:6214:20c7:b0:88a:277d:100 with SMTP id
 6a1803df08f44-895221d1862mr9657206d6.62.1770149359438; Tue, 03 Feb 2026
 12:09:19 -0800 (PST)
MIME-Version: 1.0
References: <35455cbe-dfa3-4050-82d1-8c13439b0473@cherry.de>
In-Reply-To: <35455cbe-dfa3-4050-82d1-8c13439b0473@cherry.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 3 Feb 2026 21:09:08 +0100
X-Gm-Features: AZwV_Qi-chqcjrIzB8wwBc0n4yBCSRVDGJEh9nVPx9FK3mUMf8ytYivWvIEBuiM
Message-ID: <CANNYZj86kMs5Z-5Ubt_9Sh2ETQWFNCNDYTg-Fa4HJN2QOF33Fg@mail.gmail.com>
Subject: Re: [bitbake-devel] Why does bitbake-setup force a machine config fragment?
To: quentin.schulz@cherry.de
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	Antonin Godard <antonin.godard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Feb 2026 20:09:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18945

On Tue, 3 Feb 2026 at 19:12, Quentin Schulz via lists.openembedded.org
<quentin.schulz=cherry.de@lists.openembedded.org> wrote:
> In short, I'm wondering if we shouldn't have an additional option in the
> list for machine targets which would be something along the lines of:
> "None: I'll set the MACHINE variable from the environment or local.conf
> myself".

There's a --skip-selection command line option where you can list
things you don't want to select. You also have the option of not
specifying possible machines in the config itself, e.g. drop this

                "machine": {
                    "description": "Target machines",
                    "options" : ["machine/qemux86-64",
"machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64",
"machine/genericx86-64"]
                },

or its equivalent from your config file. You can also have two
configurations side by side in the config file, one with machine
selector looking similar to above and another without. Configurations
can be nested and form a tree structure.

> Or maybe we should NOT forbid the user to pass a MACHINE env variable
> when there already is a config fragment for a MACHINE? What was the
> rationale behind this?

I think this was the bug:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=16060

and this was the fix:

https://lists.openembedded.org/g/bitbake-devel/message/18468

(there's probably associated discussion on the mailing list as well
which is not registered in the ticket).

I agree that overriding fragment-based machine selection from command
line by setting MACHINE=xxx would be beneficial as lots of people have
finger memory for it, but I think this was found tricky to implement
correctly, and so we decided to just deem it a mis-configuration. But
you can look into it again.

Otherwise, it's okay to do this instead of 'MACHINE=xxx bitbake...'
when there's already a machine set via fragment:

bitbake-config-build enable-fragment machine/xxx && bitbake ...

You can add a shell alias for the first command, and then it's even shorter:

M xxx && bitbake ...

Alex

