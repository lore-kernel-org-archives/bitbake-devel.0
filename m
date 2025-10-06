Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC6CCA470
	for <webhook@archiver.kernel.org>; Mon,  6 Oct 2025 22:37:28 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
 by mx.groups.io with SMTP id smtpd.web11.5398.1759790243773127695
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Oct 2025 15:37:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UszbsEDH;
 spf=pass (domain: gmail.com, ip: 74.125.224.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63605f6f64eso4907978d50.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 15:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759790243; x=1760395043; darn=lists.openembedded.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2ixKuT+IIIODXx8T1GAbq4kNlU57p8+Xevd+kJykGM=;
        b=UszbsEDHeRXbPTf6jXjAd9ZnEeNXSUIG7LcbgSkOkyBOpX9EYvApL6WoDkP/lwpLAG
         DLRSp8AWh6nb8hSkgnzmYrg5RyQV8xpwGP3aX7b0UaoYH9b9X/LzSzJjv3vbMyRLG9Rp
         NQXs8llbdu2kugXNkkgLiCuU1JDliSQ3arP3S9WIXrm51lp2qy/TWp4FO/3MVhVoaM5u
         dir0L+9OrjtKMUczO/TFO7g0PYZjlQD86u+ANBk8Ub0VMOw4NN1uEnk96nF/X5Nbpqnd
         11Xn0Turtj7MhPd6ibKrOaDAu5Jtn9xwhx9AYNhhLi0dss4B1vpa5X13tEFLfRLnerIu
         qqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759790243; x=1760395043;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2ixKuT+IIIODXx8T1GAbq4kNlU57p8+Xevd+kJykGM=;
        b=sfzpLJ3GOHklx53beafLmE65S/TQ4acOODd+FQokqPF157OQFQ/WzMX5m79EdAXl+g
         PtBED0oXoicbZcV/RTeCgLioZ/gvl/tOdXWZMMi18gzZoy9IFojEgXsxQxpygUTGGcAl
         X5c2ec8Ce+pqpPx+cfEAbX6SaphNzqLWzfDiBL5pNgAivRgwnviSUwx0JLTc4VPTTNL2
         kSnlTcMw99OopeCFUSRs/M5HP5lkqtISaJMfMO8HMnwZFqEcqFZ/we/ZS8WiOquALnFr
         RocV4db7cgB3m7++/Wx2QGrWBRNmYsPYcN+DUiwFQR3fUYsVqmvM2UFBGR6GLg38EPtV
         SPcA==
X-Gm-Message-State: AOJu0YzB8OAwiSczp2goY/6K1CX5JMAIn6itAodAs2E71MnFatmSmUqo
	cFs1m0p31anvRwi37GqBP9DCafHMqv16xqaMYljmu62aGiNktK0BvFY5fzu2Ld3teYyBskoK4rL
	0F0ZUCZEWvxWVm0PUdnV9Wgm9cRWqfdrceA==
X-Gm-Gg: ASbGncuezfxwSHxOUK6CG4Vg7YKiV3cxBosq71g/5b3ceX/tv3SWsOnjyQsAboMTDB8
	cvg9Sju9Gsv5lIbVL/jAohguAjaXbR5nq1y+HvqeKkF8ajy8i2WEjIf0JudbQhLJj4NC5+rgqw4
	mW+nIt7wgNfnkswZGWf05Hd9tNgiSPjofZomXzARSjon1m/bfUUnxNur7nxcZEor+qeR8PSE8Lc
	sr1kIoeIt1PbarITvPxCKFFYj5t+QC5LMPN4nehdiud9mmiT8TOdph9
X-Google-Smtp-Source: AGHT+IHx6dpLExZTUGyhR3GcMCocIuT9GS/Bc8ZEWEchtndvSaxRsyfzvWW4BKYNSe9sKv63wnQzSJ+ytH8ezvu3deI=
X-Received: by 2002:a53:ef86:0:b0:635:4ecd:759d with SMTP id
 956f58d0204a3-63b9a0effa5mr11315561d50.43.1759790242725; Mon, 06 Oct 2025
 15:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
In-Reply-To: <20250729144906.1665908-1-JPEWhacker@gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 6 Oct 2025 16:37:11 -0600
X-Gm-Features: AS18NWBFuPi5ONzl5rtFcm5URoZm9CyghZnKTCFy0HrAzDiza4g22aHKfyPA7rQ
Message-ID: <CAJdd5GbA5G+2of5NzN52gFP0iYGp=Q+q5cQTn7gXv_zY_FEpXw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
To: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 22:37:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18141

Any update on this? I'm still getting a lot of internal questions
asking if it's going to be merged or not.

On Tue, Jul 29, 2025 at 8:49=E2=80=AFAM Joshua Watt <jpewhacker@gmail.com> =
wrote:
>
> Implements a new layer-specific variable called
> BB_DANGLINGAPPENDS_IGNORE. This variable is similar to the removed
> BB_DANGLINGAPPENDS_WARNONLY, except that it is scoped to a specific
> layer, and it also causes appends to be completely ignored instead of
> warning about them.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
> BACKGROUND AND RATIONAL:
>
> I was fully on board with removing BB_DANGLINGAPPENDS_WARNONLY, since it
> was pretty bad that it operated on all layers if any layer set the
> variable. However, I did mention at the time that it was going to cause
> us some trouble, but not wanting to hold up a good change, I indicated
> that I would attempt a fix for it later. Later is now :)
>
> After much poking around in our setup and deliberation, the conclusion
> that I came to is that we do actually need _something_ along the lines
> of being able to ignore dangling appends, at least in a few specific
> layers.
>
> Our setup is that we have a "disto" layer that we need to maintain
> against several version of Yocto at once. In this disto layer, we make
> policy choices that sometimes are tied to a specific version of a recipe
> found in a specific version of Yocto using a bbappend; and often that
> version is only in one or two Yocto versions, which means that the
> bbappend will be dangling in the others.
>
> dynamic-layers doesn't work here because we are keying off the Yocto
> version, not the existence of some layer (unless there is something I'm
> unaware of).
>
> BBMASK is also a less than satisfactory solution (IMHO). Part of the
> reason we have structured our distro layer in the way we have is to
> reduce the cognitive overhead required to maintain our dozens of
> products that more or less need to behave similarly. Keeping all the
> distro stuff together makes the quite easy to reason about, but having
> then again to track (probably quite complicated, and possibly
> per-product) BBMASKs erodes that maintainability.
>
> We did go through and eliminate as many dangling appends with other
> methods as possible, but at the end of the day, we ended up with some
> for which we didn't really see a viable (and maintainable) solution.
>
> I'm open to suggestions if this change is entirely reprehensible, but
> our primary goal is to keep the maintenance of our cross-yocto distro
> layer simple.
>
> I also decided to simplify this to just ignore dangling BBAPPENDS, since
> I suspect anyone setting this is simply going to ignore the warnings
> anyway, but that can be changed if there's a strong option to do it
> differently.
>
>  bitbake/lib/bb/cooker.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index 1810bcc604..349e27d538 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -953,7 +953,11 @@ You can also remove the BB_HASHSERVE_UPSTREAM settin=
g, but this may result in si
>              appends_without_recipes[mc] =3D []
>              for _, appendfn in self.collections[mc].bbappends:
>                  if not appendfn in applied_appends:
> -                    appends_without_recipes[mc].append(appendfn)
> +                    layername =3D self.collections[mc].calc_bbfile_prior=
ity(appendfn)[2]
> +                    ignore =3D self.databuilder.mcdata[mc].getVar("BB_DA=
NGLINGAPPENDS_IGNORE_%s" % layername,
> +                        False) or "no"
> +                    if ignore.lower() not in ("1", "yes", "true"):
> +                        appends_without_recipes[mc].append(appendfn)
>
>          msgs =3D []
>          for mc in sorted(appends_without_recipes.keys()):
> --
> 2.49.0
>

