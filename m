Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.413.1626396812248984344
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jul 2021 17:53:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=P2GDmlbe;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: raj.khem@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id x6so3804817qvx.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jul 2021 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gHnc3usDJVdLzt3CIZzqZcam2MZ07teurWfi7QJaBQ=;
        b=P2GDmlbeuEAk5qZI2FJB6fE63yoaVI4Qft8PVbZPaJIDP3X6oGO9UCEzzvlLVEQ4/Y
         On+wZJK2v46i3BRI7h2gWhimUAVO+PVaJIPuJGfpo13RxtSizCGzsT1E7iPTFdLgCBci
         6WVWEWOXacmpSCign/iS7hMbdwTPxUjTeTqjMG5zjyr28Cicnq/0V7SkuJuqLh3IYsjN
         uQJD4B4WgZBmOoyltXcwuT5DsJrzUWZxi9Y5T9DV1UR3ytI5tHHBR9WWf13yAEldnEHe
         NynPDCyHTGN4wK276ceXFOjhHnheXGYgdP1kB8yMt42EvUWHIoFOSaP/ifjCW7pPUPbK
         xOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gHnc3usDJVdLzt3CIZzqZcam2MZ07teurWfi7QJaBQ=;
        b=bEccAVmvwQytS3K7ZT/yT+cZEpDS6XUvJDhDjVtIi3CwgInJgyzfHLlIeczFpU/DdH
         CTQ5o1Pk7G/6gu4d7cQgsjzeaUsQetG2VJ+f8QgPoWyi/TxIPNNiXU2POpqTDFtU7m+s
         N+gZcyt38GPVcjLBh1StI/VyMoqJN4wdBLHpuBgeYEGva0tj+YHrqujNsGmiEroTuYcT
         l9Kx9xqwfKnCZZOcvcyGyknmMHDmz7ht6b/eQuchcePy6Lpr8kuX5fEswTPixDg26Rv9
         ElVbNZZ8FKXERApyYbr6VOI8oanMLsX7UO9lXuZr3aZhDJK+yVJ7MAqmZkndbEYGU4av
         2YkQ==
X-Gm-Message-State: AOAM530EIRN8y3YelzG26g57F1txLDdIfvfUVRvPhLm9lCciKzSPCmmS
	rn2nSrngkStULdvDEj7HshILrZ/nNEaPAtiNBtI=
X-Google-Smtp-Source: ABdhPJxaW+rrW1pYu0YjfcCYCsiPfSBdlwnldwmNnOqycvcoO4AMmvPV4ysNExABDjuaerIWMbPjLNSdjyTCR/7Wp+4=
X-Received: by 2002:a0c:f848:: with SMTP id g8mr6671511qvo.31.1626396811395;
 Thu, 15 Jul 2021 17:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <89xC.1626390228088042584.TYTM@lists.openembedded.org>
In-Reply-To: <89xC.1626390228088042584.TYTM@lists.openembedded.org>
From: "Khem Raj" <raj.khem@gmail.com>
Date: Thu, 15 Jul 2021 17:53:05 -0700
Message-ID: <CAMKF1spOZGGMciL16ZmLmbL3+wOphzjw3_f06cTnEM=b9cw5uw@mail.gmail.com>
Subject: Re: [bitbake-devel] bbappend SRC_URI restriction request
To: jared_terry@dell.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 15, 2021 at 4:03 PM <jared_terry@dell.com> wrote:
>
> I'm building in Yocto 3.1.3 with bitbake 1.46.0 and I had a co-worker do a bbappend with this in it
>
> PV = "231"
> SRC_URI = "https://github.com/systemd/systemd-bootchart/releases/download/v${PV}/${PN}-${PV}.tar.xz"
>
> now the hard part is this is a append applying over the top of systemd-bootchart_233.bb and since the SRC_URI = is a complete wipe of the value in the bb file its basically doing a forced override.
>
> is it possible to set it up so this throws a warning?  This is something I would think would be very bad in a bbappend file and basically bypasses the bitbake-layers show-overlayed I've been using to detect who has forced an override of whats in poky.

Technically, bbappends are not limited in any way than the main recipe
and hence we don't have such tools, have we decided that SRC_URIs can
not be overridden but only appended to then such a check would make
sense globally, however
if it matters to you perhaps you can think of writing a QA check in
insane bbclass perhaps.

>
> 
>
