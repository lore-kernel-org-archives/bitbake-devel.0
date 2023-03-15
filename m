Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C9EC61DA4
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 17:44:06 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web10.18.1678902238173187356
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 10:43:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=TyI+cmQF;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: alex.kiernan@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id v10so1653338iol.9
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyCU0LgMM+10TOhnPglcQ3v0kUXTTRg7SlesD2EeOIc=;
        b=TyI+cmQFy++VbSkjkQtrAevqTxC6/bbvWMNAW9MOtoSsKQWCJxE/jIIObbB1Qczl35
         3nqUTCXdlPpzOjS/WMVWp6Bs73QX2+Tc6u7fpFB60XyRv2jurT8RU1aE6UfHT+l9paZq
         xlgnD+ki+FkwUgrLI4qCNo0+j/X2wM4GLPiWgcAiiAH2OtDtq4jHh7ZOrO42hGClAtpW
         BtSr3u8P5mYJo3IuFjBlgncvSNQLJvBR2jRJReNP3Kj+XLIviA1Xm34nyDNltD1FLfql
         nuCUELHscgqYMDuGvZn/J1v5j7C3QVf56lOnS9Bfqwp10EVv1Lnkzcs8Zb2BhY9Cjwr+
         Fd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyCU0LgMM+10TOhnPglcQ3v0kUXTTRg7SlesD2EeOIc=;
        b=AVGpaNd47c9DMduhPAfuZU+lYNvjA4+ppjI/doakvTmF2+BOLT5yP3Wp1Nohhlma/S
         OUBqZXiHJqSuaTPs28Ti8EPg5dDH+sen+bnL3lH42ei0BhMcjrH3xH2Fj+QRqwSbQDhJ
         J60aGYRq2TxN95kVTxWFZK91exWTaFUSX+Oa8zeNF67lHEI+ecl08DKYd991gdG5mVRU
         RBVhd2wyFnY3FlJ9oRVFgSbU6/wchbJA69CT0EelYmELck3UJHPdg2oNHqjUtEe4bSeo
         6AKzdUF7CCZ4elkYJ2oAUfCle2w1wbKW+Hwtf/YJsPMrt9zf/E5l6+kAhVObSdajtgVa
         FdfQ==
X-Gm-Message-State: AO0yUKWDqmwTRW+xVdDG5h2wkaotKARBZziDjwcDMGhAxmKvZOeSYfns
	kZAUolRFLpkuSos6EqlpL5WELnCLwXJAOUemp3g=
X-Google-Smtp-Source: AK7set+qSF1HfvhmZzXvnXXUBUQQ7ojs0Ge0TFdscgnYzHzjcNstrSVxbdqKN9TUQy2jUMSo5D2DMN5J9Q4twLyViPI=
X-Received: by 2002:a6b:7402:0:b0:752:b100:5db with SMTP id
 s2-20020a6b7402000000b00752b10005dbmr2262780iog.4.1678902237457; Wed, 15 Mar
 2023 10:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
 <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
 <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com> <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com>
In-Reply-To: <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Wed, 15 Mar 2023 17:43:45 +0000
Message-ID: <CAO5Uq5RK8o_he_741feA-NQT01-tgGnXhi8pgwYqFPpHqA+-UQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: Martin Jansa <martin.jansa@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, 
	Frederic Martinsons <frederic.martinsons@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 17:44:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14569

On Wed, Mar 15, 2023 at 5:08=E2=80=AFPM Martin Jansa <martin.jansa@gmail.co=
m> wrote:
>
> On Wed, Mar 15, 2023 at 4:50=E2=80=AFPM Alexander Kanavin <alex.kanavin@g=
mail.com> wrote:
>>
>> On Wed, 15 Mar 2023 at 16:03, Alex Kiernan <alex.kiernan@gmail.com> wrot=
e:
>> > I really don't think this is the right direction, at least not by
>> > default. If a crate is your primary build artefact then this is
>> > useful:
>> >
>> > https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15012
>> >
>> > But doing this for all the dependency crates we're just repeating
>> > what's in the Cargo.lock which should always be part of the primary
>> > artefact.
>>
>> Maybe cargo will verify (some) items against Cargo.lock. Maybe it
>> won't. Upstream cargo isn't something we develop, and it may add and
>> remove various exceptions and special cases.
>>
>> Anyway, we cannot actually trust cargo (unlike, say, git), and we need
>> to do our own checks, and keep the checksums in files external to the
>> source tree. This will free us from worrying about whether cargo
>> protects us from supply chain attacks properly or not.
>
>
> Also if bitbake fetcher detects unexpected checksum it can easily rename =
the file in DL_DIR and try fetching it again, because that's what fetcher d=
oes for other downloads and fetcher "owns" DL_DIR.
>
> If cargo complains about unexpected checksum, than cargo fails and user w=
ill have to make sure that wrongly fetched crate is removed from DL_DIR.
>
> Regards,

Okay, you're convincing me :) I've definitely tripped over that!

I guess we need to update the cargo crate updater class and librsvg too.

--=20
Alex Kiernan

