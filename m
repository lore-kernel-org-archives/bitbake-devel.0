Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B6C369AB
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 11:22:03 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.12576.1745493715749356537
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Apr 2025 04:21:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=max1LHBW;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6eeb7589db4so14024526d6.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Apr 2025 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745493715; x=1746098515; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgTj8gA7L8e55cIKXG9MjIC6X4R64ZlxlgHbB2fPMAQ=;
        b=max1LHBW13Z79XeERWdAxqHFGH+QgqfrkjRrC+yWNXmfE7fvL5GOByZFXVnc3deU7o
         dWVpeS0GXuE+zIg4H1G8EcbIQGNdHiVoL+AFohNKOORoH+WM85X+yhdju50V/gg3fRDa
         9609fS0LMuxZ29KaMxWmVxytOvo027i6kMsBMmckyQKEu2+g3pN7HxqXm0OdIhypdPzw
         9uGK0oERwy05uu+vK01gVLqktmrwlc1faG7XydVnt/TzUvXFmANqkoIYC/REIrEAlGfZ
         zlMRjWu/OtA0F4U8GPOLhMAk22/2ySHhKy8grccbrKFQe6iW4F7ZAKvGgZ5uWG2LJUUf
         14rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745493715; x=1746098515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgTj8gA7L8e55cIKXG9MjIC6X4R64ZlxlgHbB2fPMAQ=;
        b=K1awt+mMZTg87F35NQ9/7/6Kicw1pXL+vWnZdiJuSWAmzw9lRg/nhpDVM7k3wlkMVX
         7IP5inwYzwEwXpWpQNLaSC07S+qyV1taPIFVYiZnLzostOdl+8/wBHs7XRM/NJb7kdlb
         MYh36x+actdWNPyHnD1cLmI94YDbaJIu5z9Xg5Wa0Jrqzs9B/mblQEaOgtAm4zap+rA7
         hApEUeQiw/iBFC1yVdNXlV3e7dG0PWNEkAjHPbi40smtrbD6/I2NBIv4EKG6yl2UXa4b
         fH4EK7WinQA91vJEpi5lWWeerYnfrnrLLO/JpaZyR9Lj8D0lRo9wl/DYGM2BhrEfExFB
         nCdg==
X-Forwarded-Encrypted: i=1; AJvYcCUWCbCtDigxt4BHXlJs7HRxuVIlQhcIPA5nCo5itPxGeTKnP8bbdLijd/Sw0rA7NiClvBAUxwTXnBmnTMtF@lists.openembedded.org
X-Gm-Message-State: AOJu0YyU5eXcb8FOlDKHjKCJday6LdNsjS40XHiDfSi/TavBdTPgLXYl
	64Xpfbw8zM8KrYjmzH1w34yrV/paIX0+GX4n59yXzwIwDRSxVQHZwHlidNixj7YPDnlZ0zcpTfg
	49btY0MVdl7VS0JdHmy4LmcpZC1RXwQ==
X-Gm-Gg: ASbGncuwy10waNhDDhoBTlLswOhyiA9JVRMD3YYwrsFHrgLuVp9ScCtoZnedCB+Iitp
	mDVECb9RMSO66QPNjF8akJY+R4YGJf1LcDewuGtIm5PGHhAx54AAahFqtbagk+yhG2GZ93JeXL2
	PfOhVYsk418/dUKGGYto/QkJjq1kGB2k8704UK4hFw+mJOdEKP7ZWQ03BJ
X-Google-Smtp-Source: AGHT+IHa5uFHOl9iQ7iJRjCNbFCOiDUbCZhslQHlOXs/vX6+hmKNKT/rhwLB8m0J/J0QWeHkgFuVqacwPrgHk2zGeAY=
X-Received: by 2002:ad4:5749:0:b0:6e5:a0fc:f663 with SMTP id
 6a1803df08f44-6f4bfa6aa47mr42760676d6.0.1745493714729; Thu, 24 Apr 2025
 04:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250423151901.1300944-1-philip.lorenz@bmw.de>
 <20250423151901.1300944-4-philip.lorenz@bmw.de> <D9EOJ22QSMAC.3LNDP3MSMSGCG@bootlin.com>
 <404982c1-3b75-48e9-9182-1b66aa3d3b43@bmw.de>
In-Reply-To: <404982c1-3b75-48e9-9182-1b66aa3d3b43@bmw.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 24 Apr 2025 13:21:43 +0200
X-Gm-Features: ATxdqUH98tneGkR7KWhjaDo5puKCcwh-boldLLt2pysUw40f0sOMJDBuZAxMpFM
Message-ID: <CANNYZj8Sq3KGhrGc=zUzF8Ccp2F-W=v0LQmJsXrFQH5ZA1eJMA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/8] fetch2: Check for git-lfs existence
 before using it
To: philip.lorenz@bmw.de
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Apr 2025 11:22:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17554

We probably should install git-lfs on the autobuilder workers to
prevent this from regressing, but keep it as a 'soft' host tool
dependency otherwise?

Alex

On Thu, 24 Apr 2025 at 09:48, Philip Lorenz via lists.openembedded.org
<philip.lorenz=3Dbmw.de@lists.openembedded.org> wrote:
>
> Hi Mathieu,
>
> On 24.04.25 09:10, Mathieu Dubois-Briand wrote:
> > Sent from outside the BMW organization  - be CAUTIOUS, particularly wit=
h links and attachments.
> > Absender au=C3=9Ferhalb der BMW Organisation - Bitte VORSICHT beim =C3=
=96ffnen von Links und Anh=C3=A4ngen.
> > -----------------------------------------------------------------------=
------------------------
> >
> > On Wed Apr 23, 2025 at 5:18 PM CEST, Philip Lorenz via lists.openembedd=
ed.org wrote:
> >> So far, existence of `git-lfs` was only checked during unpacking. As t=
he
> >> binary is also used in earlier steps also check for its existence ther=
e.
> >>
> >> Additionally, factor out the LFS existence check into a dedicated
> >> function and call it wherever git-lfs is used for the first time.
> >>
> >> Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
> >> ---
> >
> >
> > I was not able to test this series on the autobuilder so far, as I
> > believe git-lfs is not installed in there. Now maybe this has to be a
> > new requirement on the host and maybe this is fine. Just two points:
> > - Is that really a new requirement and is it needed?
>
> The requirement isn't new but simply was never checked before (so users
> would've seen a git-lfs not found error rather than the helpful error
> message that is raised during unpacking). Support for LFS can be
> explicitly disabled for per URI by adding lfs=3D0 to its parameter list.
> git-lfs is already needed during downloading as this is the point in
> time at which the large file objects need to be retrieved. During unpack
> pointers in the repository (this process is called smudging) are
> replaced by those downloaded objects.
>
> However I just noticed that I was missing parentheses in patch 6 (it
> should have been `url +=3D ";lfs=3D%s" % ("1" if self._need_lfs(ud) else
> "0")`) which would explain any possible failures (for example in
> vulkan-samples). If there are no further comments on this series I'll
> push a revised series in the next couple of days.
>
> > - We probably need to update a bit of documentation about that.
>
> I would've hoped that this is already documented since the LFS feature
> has been around for quite a while (but have to admit that I couldn't
> find anything on it inside the bitbake documentation). This patch series
> merely ensures that it also works correctly when used via the "gitsm"
> fetcher (and while at it improves some of the existing implementation).
> I'm happy to write up something for the documentation but I'd suggest to
> send this in via a dedicated patch series.
>
> Philip
>
>
> --
> Philip Lorenz
> BMW Car IT GmbH, Software-Plattform, -Integration Connected Company, Lise=
-Meitner-Stra=C3=9Fe 14, 89081 Ulm
> -------------------------------------------------------------------------
> BMW Car IT GmbH
> Management: Chris Brandt, Michael B=C3=B6ttrich, Christian Salzmann
> Domicile and Court of Registry: M=C3=BCnchen HRB 134810
> -------------------------------------------------------------------------
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17552): https://lists.openembedded.org/g/bitbake-deve=
l/message/17552
> Mute This Topic: https://lists.openembedded.org/mt/112416098/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

