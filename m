Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D378ACD98F6
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 10:58:28 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39802.1781866704292749276
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 03:58:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fufHoqJJ;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8dd17d7308bso13000956d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 03:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781866703; cv=none;
        d=google.com; s=arc-20240605;
        b=PLbL8XkyULq/NaulHtZF3SYTY5LTXLcNcxiHAyiv2Wve7frzsOmJM3dZOAP4xN/Hb/
         bTURfsEAPXLoZQYfQsMRNBGdhvIGh31L4gC2rbDwrAAvWsa81QAwCoPoai7PPCm6slxF
         bBRSOzuIAp6mxqRcoczju/vuPbOttc92UAqv7ajx+uH58XbpjJrU8eEwxyx2yQfQWIx3
         LmIJP/dtuDLmT/GtWO9XRepTtbhVGtow6MELkkoiVc9GIcsXy+fPlv40cnOclYcFWAkG
         PI/+0Pgu/D6NAVD4juN2cfpRv6FeenBrAANdZqVP0O2dAH6c9/Le4hv9fbu2HNuH3vdY
         1LKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BD3b1C8xvDmqdnDc4mrewItY9ho6v/m+LBpPm8m+I1Q=;
        fh=S70EIw5I6KnwG2JXmyE4WkvLU4aK+s9Srxw9jTjAdcY=;
        b=llKYhusKY0RIvO1OiUaoUvS6Du79y5qYzvwy0Je/oJLL2LvPKZ7tTEeBQmToyR4u/x
         pSQLq5diirLQ+VS68MN0naL1d53Q/NpDD9hRvrOvMmM8qC+8M5ewBNnih5n8goU5TSHp
         PH8E9O+H0kidcvL6wjaRF2d6mdouFeIUrUmOPPozVkw8m29dbIoaIXH8RSti9WeiVBOX
         f4exm4nSU86I7Ku5LWil469b8KnfTJ+arq/5GU7sTW70neDPasjuA6QkzmhBqxPSaFoB
         DUKLRpAHOippxJLUJUreHR30N8TbANFbCS8/24+IJI/JAr/u/94VbrZAE2Jhh0+qrkSj
         vGqQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781866703; x=1782471503; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BD3b1C8xvDmqdnDc4mrewItY9ho6v/m+LBpPm8m+I1Q=;
        b=fufHoqJJ13Zw51gBBkTG1GFYYe1ldyH1WongM6xcT9EV1F5w0xeuScnv4tf7YP/532
         3guZ3ejNH5g0cMC3/OkGSu+Yz8fjBm/e7F5bnyPFlES8Yu4oxhH7Lqxd2aMKFaWTNI90
         Mm8yMtX3YrhQjOKGkNI5AC50yW8N7hhod8JRRKv86OtzlAk4AAGDS2m/V4etlnnVdWI0
         NtR1cumwRcjwD1HuSP7VWw42ZBCL80cRYTm0e3dCViy0j6QXg5cv4O1l2+QxIHOvhpQW
         NkvumGXHqN6Usidrg9F6qjZykD0dVUs1Uj3OPJ6HDiIyUcWc1ouxX2qaX6+gvpbR2YEq
         JaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866703; x=1782471503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD3b1C8xvDmqdnDc4mrewItY9ho6v/m+LBpPm8m+I1Q=;
        b=BF0xo/MLBsFQbOd1cRTjmDmiaiRxeWSuIJ7VgmQ0mjjDeGtbHTmX0QZIIyGHjb3uGE
         CrPEAh8ZykUvZ4iD4kjsUBKeuzo2wIlAKznTwzsvtw9Yseoh7dtXh93kpPbC03ZY4Niy
         wUQnOvc8HiIX35t8TgXajALxndDD1DnmcgYW8I78PV+XHLjlA8qON7Baj1l74duS8mWI
         n1VW18ZTKGCCfahzLUG3DqJTO1qs4Xj86EMvD1YVKeazCiTUvzbWPj94qO7jjFnoIOXw
         dsFS3RcfPlaYU31L7v/tOcWMKK8Dccflo+ZafdNU03A5sut48PzGKNhNk1yxGMo705hx
         hTHQ==
X-Gm-Message-State: AOJu0YwqcS+bsY2cqeDSRZ+iN6Rv9kYB9j7dYwhvpkZabI4CgFINzF+r
	C7h7BL6iu+fYbPzoZPpaH5NWCkTwjzeVtNhpcwOFezFY16kP0ofwfmK4i0Es8auvV9Vm1GKsgx5
	g8I17GZj73eSiU7ysEGjTjZGF66lhhS0=
X-Gm-Gg: AfdE7clQ8gGVVs5LNJDkKUGPyVDrK8KZDTGB07yxRQRnOBb4MWvPcbRg/EUQ3AReUWm
	VXcZH0t2lGV532NqWOBWIQWq2aWiQD5DSYdZPLTs/xQu7QmSU/Ta4ue/scywkbvdBZGXiQL/rZ8
	M5Mj+P01UOGBzcMGuk94Xl8PBVRIkYQeu2MLj0WhyriPnV7eUOQ6moJ+GMzeakeBGLMHLIFSrCI
	4in1uonXlRxK7Qe+P0thRaH6fUFUEvhhNShzpSuClND6lLLutAlYCaNeaJ/tlJoLn5OD+6inNrr
	xGC+HYjsPThy6AvkQ9m5KEAZa/UR7Cs=
X-Received: by 2002:a05:6214:810b:b0:8ce:cc34:e604 with SMTP id
 6a1803df08f44-8de40718cd5mr45982976d6.35.1781866703184; Fri, 19 Jun 2026
 03:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-bb-setup-source-choices-integrated-tests-v2-0-66b3b438f073@toradex.com>
In-Reply-To: <20260618-bb-setup-source-choices-integrated-tests-v2-0-66b3b438f073@toradex.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 19 Jun 2026 12:58:11 +0200
X-Gm-Features: AVVi8CcxB-at--Ucss_PLcmNLtRJivUw52fVSmf6UaHhu740J0XsRpdiXeSbUXc
Message-ID: <CANNYZj8wU4-Qh-EgB1ukobjqs9sOvjDSjOs6fEFCNqCSgTXBjw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] bitbake-setup: add source choices
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 10:58:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19748

On Thu, 18 Jun 2026 at 20:04, Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
> The consolidated registry examples intentionally do not preserve the
> exact setup-dir-name behavior of the existing release-specific files.
> Today, setup-dir-name can substitute oe-fragments-one-of selections, but
> it has no way to refer to the selected source choice. Possible follow-ups
> include a built-in source-choice substitution variable or a different way
> to model source/config combination metadata. For a substitution variable,
> we have to prevent collision with a fragment choice.

Yes, there probably should be a 'special' variable for substituting
the selected source, and a check that there's no fragment selection
that has the name (in the unlikely case there's an accidental clash -
it's easy to address by tweaking the name of the fragment selection
block).

Alex

