Return-Path: <ernstp@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCBEC433F5
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 12:57:32 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web09.11605.1636462647672520855
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:57:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=qAQrObuD;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: ernstp@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id p18so20677862plf.13
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 04:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKoZOYE6fhnUPDUyZjUWMTSLnG4lfX8FY/852sQB6Ug=;
        b=qAQrObuD1iQ2FqQkRzxkVLQ0/Vsvf1L77B3pYmBfKLQ/enk67dq6yaTSN22ouVZH4y
         woYQJdFrIhk1HohWHSEM2BXEkDV/CA93x4lYxMxGms5tX0X1dDMfK/vSZH7Z6WPfw3Jf
         ktvZ7yBxKWf+U8qPTh7qZykhIYoRKLoC7TB8ah+gqs8yf8lYjGv6Mk+8gP83pQIXForQ
         uVDKuy4FjZopJ/YkwdbbWJ5J8PEHoO7oAj1jZSo4n4GPdkm0DiyDueY3+VUIEuPQ905A
         7fUh3SD5foyBVksbFjbwuy2IXsRexmWTodj0xd44nQKpXSzHLPQ2FLXlZTUjjCyB0VEG
         TLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKoZOYE6fhnUPDUyZjUWMTSLnG4lfX8FY/852sQB6Ug=;
        b=ILCJdbHWK2/sVHJkVxVkQWcfBRrCmvOV//ekATf2GPNqTU0GbHwOnWJ8MG1GKITeRq
         nuF3MnPbuP/LkQxKwmK66rDjmK9dCKN+OE+jj9OoB+r2N1n9My/n32TMfl/qP3ddCf5d
         KaVUf6YbyaecerLrOQ8bzyVIg1QSgCalupBI7xJLZVbFPjoWB/ivC1N3fhTJ6AwmYsvd
         CwKDt/mE5gQ3hRrEcQbPfOgWrTl5ijRkl2oIgJQ+HdSVeW7NIixoDBFGYNdBY3g+Esze
         VljDFkSGD1qKYmt3T1huQJjfTPkEu6QkbfiYC5euoUJEdIu8SSL09cnTPXE54MFhB6hF
         qm4g==
X-Gm-Message-State: AOAM532hbFU5vD9/d0nna2u5vGchpoOsZwpcez3NB8ZSLYjfqr45atBA
	lQJxLo9xr2bWq9EaSSxEWBDDdR8rYmTbAsWvBhA=
X-Google-Smtp-Source: 
 ABdhPJxysWBHwi2gQlvegWqSYRwmWI8NNViRkScH6wtg023NTVffWXVo7e3SWjF3vUpOCDG3F00rwWZY7MPXkmywO60=
X-Received: by 2002:a17:90b:350d:: with SMTP id
 ls13mr1622763pjb.175.1636462647160;
 Tue, 09 Nov 2021 04:57:27 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
 <CANNYZj8_zPhh_XCZrxaPvXd_Oz5kzbzHNLvT6qzvtztquKA0ew@mail.gmail.com>
 <CAMaS9hO8yU+T3tKb-dQj-DFx-vqGsUTLc7Jkta1sAM+eDr45BA@mail.gmail.com>
 <CANNYZj9G7YaHpQgCzVZaCjTTAmNXgEiGnkf-GyrXzbxckqp4oA@mail.gmail.com>
 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
 <YYo2KsoUeMTZ6y5C@korppu> <16B5D5AA827DA237.27841@lists.openembedded.org>
 <16B5D6BAD1F7C3E6.27841@lists.openembedded.org>
 <CAMaS9hNRUsmWdXNaJV9E8rKCw6g2OzdZd4U8s6k+0c7VYo8P9g@mail.gmail.com>
 <e5b2f8439e5aab93a2841728e00650185ff60573.camel@linuxfoundation.org>
 <16B5E0648E5826A2.410@lists.openembedded.org>
 <CAMaS9hPn5k2w+MXzPE6jLfkYJmQi8CMTNbhtUu64Vn6avs-e0w@mail.gmail.com>
In-Reply-To: 
 <CAMaS9hPn5k2w+MXzPE6jLfkYJmQi8CMTNbhtUu64Vn6avs-e0w@mail.gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Tue, 9 Nov 2021 13:57:15 +0100
Message-ID: 
 <CAD=4a=VtVpxjFUUB-0KPePw-Js5vctqDEYZitM8H4vgaE1TNCA@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Mikko.Rapeli@bmw.de,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000c5b94005d05aa62b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 12:57:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12970

--000000000000c5b94005d05aa62b
Content-Type: text/plain; charset="UTF-8"

Hi,

jumping into the thread a bit randomly.

I work with Yocto at $DAYJOB and the use of a mailing list for patches has
really hindered me from contributing, with Outlook and DMARC etc.
I'd much prefer something like Gitlab! When the Mesa project switched to
Gitlab I set up an email subscription for all new merge requests
which emulated the old feed of emails pretty well IMHO.

For the code review I've always preferred Gerrit for it's powerful system
of patchsets and ability to review the commit messages very clearly.

Regards
//Ernst

--000000000000c5b94005d05aa62b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-family:arial,helvetica,sans-serif" clas=
s=3D"gmail_default">Hi,</div><div style=3D"font-family:arial,helvetica,sans=
-serif" class=3D"gmail_default"><br></div><div style=3D"font-family:arial,h=
elvetica,sans-serif" class=3D"gmail_default">jumping into the thread a bit =
randomly.<br></div><div style=3D"font-family:arial,helvetica,sans-serif" cl=
ass=3D"gmail_default"><br></div><div style=3D"font-family:arial,helvetica,s=
ans-serif" class=3D"gmail_default">I work with Yocto at $DAYJOB and the use=
 of a mailing list for patches has really hindered me from contributing, wi=
th Outlook and DMARC etc.</div><div style=3D"font-family:arial,helvetica,sa=
ns-serif" class=3D"gmail_default">I&#39;d much prefer something like Gitlab=
! When the Mesa project switched to Gitlab I set up an email subscription f=
or all new merge requests</div><div style=3D"font-family:arial,helvetica,sa=
ns-serif" class=3D"gmail_default">which emulated the old feed of emails pre=
tty well IMHO.</div><div style=3D"font-family:arial,helvetica,sans-serif" c=
lass=3D"gmail_default"><br></div><div style=3D"font-family:arial,helvetica,=
sans-serif" class=3D"gmail_default">For the code review I&#39;ve always pre=
ferred Gerrit for it&#39;s powerful system of patchsets and ability to revi=
ew the commit messages very clearly.</div><div style=3D"font-family:arial,h=
elvetica,sans-serif" class=3D"gmail_default"><br></div><div style=3D"font-f=
amily:arial,helvetica,sans-serif" class=3D"gmail_default">Regards</div><div=
 style=3D"font-family:arial,helvetica,sans-serif" class=3D"gmail_default">/=
/Ernst<br></div></div>

--000000000000c5b94005d05aa62b--

