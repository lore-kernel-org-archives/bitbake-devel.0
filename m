Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86517C47073
	for <webhook@archiver.kernel.org>; Mon,  1 Jan 2024 18:31:01 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.11648.1704133856822755670
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jan 2024 10:30:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kTkjg8Ql;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ccbded5aa4so63015341fa.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jan 2024 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704133855; x=1704738655; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8aHedIGW+rxmokrNXUy9qovL9JdPIjUMxOFEjyVB9U=;
        b=kTkjg8QlhaYElFO8LZspLjQgls07e0EGHNIR40hH9rzhD/v9cg4Vxs4bV1XbpKRiH9
         ittJ8fSMNa5uYa+6IoFDpDzxvjjvt91New7CBdmpKrQCQ+n1GkjZIqbcAOgdi2is4clb
         deOqdxx0qLUeYubkt6tdYsOg3Qv2hohEeHKhvLhiZez6HunPJFPeMbRCfeJs51XvB7YT
         sa+3iKcqKO7GG/DIxky59fPMmq77zc0FOuoSa/PhP1S6YvYBC7/mzeeVdX7xDr998l+9
         OwFfQe6jDTKZIJj9jwo+AgkRLGf5IpibKlhH1g5Ym7uPEt/e3z/n5jheNPbcFpllWOW3
         8ijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704133855; x=1704738655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8aHedIGW+rxmokrNXUy9qovL9JdPIjUMxOFEjyVB9U=;
        b=iAKv1Wfn63fD3EGHwg+csO5sCf0eiWNXbU5lf+6l+zaLDo6ITXoCseWX3RhC1SRueS
         qJShHils2xUBtvwIhzSTzslS44JJP1DUIdAkCravCfXxvJYUPLJiE9Lmu0pKejdz5ffX
         jgBQx3IZFUzloaUP+DQNuqFAKitmNLV4YwxZIO2xYjs78t8Ws4DxOLC9WMcGR+xsuvZL
         TuCRAPSgmwTsQO4cIs8Pwj/rdGvO70uRsI45zX0T/rjkIWJVanmjMrGJMml29e+7sVqZ
         B4/4egqF8vmsi8kmlca9qC04bACGmLBkWwpopKV97gjFq0K3SPwTbTOqLNAPlfPuMRhp
         6yBg==
X-Gm-Message-State: AOJu0Yzum+WnUiKEfVYZE84UECGs0kuqx98q3i938xkQeBGpGYSqJFK2
	hhX3nREtGx74QpZRkIzyt9ON1rD0V/G0T90AD0g=
X-Google-Smtp-Source: AGHT+IG6z2RPoFDaNnsmZwkChZCZaI2lDfJlyg+k99kFPJclUzGNmAjdxx3EOrc1MgQx070QHKcho2ue9Gzkrrd1VcU=
X-Received: by 2002:a2e:b0ed:0:b0:2cc:b617:d2c0 with SMTP id
 h13-20020a2eb0ed000000b002ccb617d2c0mr6306040ljl.90.1704133854728; Mon, 01
 Jan 2024 10:30:54 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj-eNGeQhM6cVhPHF1WgG3d2_nu1bsobWXfW_3HmAWUVBg@mail.gmail.com>
 <CAJdd5GbWTeo9FSd_uE2Z0oaXv9M38e94EOq8jFJJu+7JOG6yRQ@mail.gmail.com>
In-Reply-To: <CAJdd5GbWTeo9FSd_uE2Z0oaXv9M38e94EOq8jFJJu+7JOG6yRQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 1 Jan 2024 19:30:43 +0100
Message-ID: <CANNYZj89yvc0EPJL0iJVPY-XPFSfsgiUm4U87rW-kq2fAjSO-Q@mail.gmail.com>
Subject: Re: bitbake/lib/hashserv/sqlite.py:294: DeprecationWarning: The
 default datetime adapter is deprecated as of Python 3.12
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jan 2024 18:31:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15737

Here:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15333

Alex

On Sun, 31 Dec 2023 at 17:13, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Ah, I suspect they want you to register an explicit converter instead of =
relying on the default. I don't think that should be too hard to do. Would =
you be able to open a bug and assign it to me? I won't have computer access=
 for a few days
>
> On Sun, Dec 31, 2023, 2:39=E2=80=AFAM Alexander Kanavin <alex.kanavin@gma=
il.com> wrote:
>>
>> Hello Joshua,
>>
>> I'm seeing this with python 3.12:
>>
>> /srv/work/alex/poky/bitbake/lib/hashserv/sqlite.py:294:
>> DeprecationWarning: The default datetime adapter is deprecated as of
>> Python 3.12; see the sqlite3 documentation for suggested replacement
>> recipes
>>   cursor.execute(query, data)
>>
>> The documentation that is supposed to help (but doesn't, not for me :) i=
s:
>> https://docs.python.org/3/library/sqlite3.html#default-adapters-and-conv=
erters-deprecated
>>
>> Just thought it would be good to address this warning well in advance
>> of it becoming a hard error.
>>
>> Alex

