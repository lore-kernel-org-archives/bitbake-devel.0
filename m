Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BC2C3DA6E
	for <webhook@archiver.kernel.org>; Sun, 31 Dec 2023 16:13:35 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web11.222766.1704039208368948100
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 Dec 2023 08:13:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Fzc9+OuH;
 spf=pass (domain: gmail.com, ip: 209.85.208.178, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ccba761783so62078241fa.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704039206; x=1704644006; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZffSivKSxigZsE5GbJ/B0maCdtp4G7QTRMHfG+Q2XIc=;
        b=Fzc9+OuHGLou86novLOK0Ia7zDNy/AvOCwZwxQq/iTg8mqKd+SUJkGgkx/hbTdcaiJ
         l430ZozpO+RY9okLqcQ26MQ/f6a3SKsgL5dAiGBFZgTw7RC1BFoDCWmdkLpcJDLxt9SA
         otls9CjFPg3Xb3BbB0NqNyG/T9sewCPXBMURomygzlGMsH8Dbndow/9CVzM3xU4oW7Ir
         OKZzeA3qeRw/1mAvn44kkHoi/PtB2f0HLL6tBQVkeHUJoIWN3nYp4AxbM3LsOj22dR7N
         vOkJkRlmo4DShvtC069s/VUNT+jnTDc4YfqB6/J09RtHgjzl2ZCalHkHVgth2BExkv++
         EzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704039206; x=1704644006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZffSivKSxigZsE5GbJ/B0maCdtp4G7QTRMHfG+Q2XIc=;
        b=oKIDxdagHMQF2ncnZ0ZXwWtWFjIhVmybwgwXkSCWlIDOtQEkLsgEcB8YtLdD4cPHtS
         Mrfp9NH3BE+/o1juDI1HIancAQz1RQoDk0NmZ45vcTwmv6ti67vOewu3aX9MANrhbBl1
         E6x6BMlqs22U+y8nE479btqAPfD5NRePJ4qZanAiDBgImdPmfSTPmvXw5YSMLEmDVRjE
         2nBVgFS8JYLxON+FhAQtrIoRVtRbWWTvRgu3cTlQQmVRYGgbyH1LKPYWTdq0HSCWRHeP
         S5o2EwWy1vPBY/QkxWh1SW5Do7rR3WYhDa9YTGpTFpXwt11RfP8GFMLgmLoJBtFnIqPN
         iIhw==
X-Gm-Message-State: AOJu0YwEdioZZwgg3AdIdsoRpQUmHhgYqcvHaYvmZe4XT6dQXLY3mMEM
	VwBgkIQehtN7/Ytq1KVvRKjlgZDoH5gLtSx79zc=
X-Google-Smtp-Source: AGHT+IEAHUDDEhDI39P25UByXPugvQaMZFEY7VfgMGLceMgD29h4bo0L8uK4XsHl6GgnSJV3g4cWfrHsAI93NBQJ6UM=
X-Received: by 2002:a2e:8713:0:b0:2cc:fd69:8073 with SMTP id
 m19-20020a2e8713000000b002ccfd698073mr626190lji.13.1704039206223; Sun, 31 Dec
 2023 08:13:26 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj-eNGeQhM6cVhPHF1WgG3d2_nu1bsobWXfW_3HmAWUVBg@mail.gmail.com>
In-Reply-To: <CANNYZj-eNGeQhM6cVhPHF1WgG3d2_nu1bsobWXfW_3HmAWUVBg@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Sun, 31 Dec 2023 09:13:16 -0700
Message-ID: <CAJdd5GbWTeo9FSd_uE2Z0oaXv9M38e94EOq8jFJJu+7JOG6yRQ@mail.gmail.com>
Subject: Re: bitbake/lib/hashserv/sqlite.py:294: DeprecationWarning: The
 default datetime adapter is deprecated as of Python 3.12
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="00000000000092034d060dd08b0d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 16:13:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15735

--00000000000092034d060dd08b0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, I suspect they want you to register an explicit converter instead of
relying on the default. I don't think that should be too hard to do. Would
you be able to open a bug and assign it to me? I won't have computer access
for a few days

On Sun, Dec 31, 2023, 2:39=E2=80=AFAM Alexander Kanavin <alex.kanavin@gmail=
.com>
wrote:

> Hello Joshua,
>
> I'm seeing this with python 3.12:
>
> /srv/work/alex/poky/bitbake/lib/hashserv/sqlite.py:294:
> DeprecationWarning: The default datetime adapter is deprecated as of
> Python 3.12; see the sqlite3 documentation for suggested replacement
> recipes
>   cursor.execute(query, data)
>
> The documentation that is supposed to help (but doesn't, not for me :) is=
:
>
> https://docs.python.org/3/library/sqlite3.html#default-adapters-and-conve=
rters-deprecated
>
> Just thought it would be good to address this warning well in advance
> of it becoming a hard error.
>
> Alex
>

--00000000000092034d060dd08b0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ah, I suspect they want you to register an explicit conve=
rter instead of relying on the default. I don&#39;t think that should be to=
o hard to do. Would you be able to open a bug and assign it to me? I won&#3=
9;t have computer access for a few days</div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 31, 2023, 2:39=E2=80=AFA=
M Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kana=
vin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hello =
Joshua,<br>
<br>
I&#39;m seeing this with python 3.12:<br>
<br>
/srv/work/alex/poky/bitbake/lib/hashserv/sqlite.py:294:<br>
DeprecationWarning: The default datetime adapter is deprecated as of<br>
Python 3.12; see the sqlite3 documentation for suggested replacement<br>
recipes<br>
=C2=A0 cursor.execute(query, data)<br>
<br>
The documentation that is supposed to help (but doesn&#39;t, not for me :) =
is:<br>
<a href=3D"https://docs.python.org/3/library/sqlite3.html#default-adapters-=
and-converters-deprecated" rel=3D"noreferrer noreferrer" target=3D"_blank">=
https://docs.python.org/3/library/sqlite3.html#default-adapters-and-convert=
ers-deprecated</a><br>
<br>
Just thought it would be good to address this warning well in advance<br>
of it becoming a hard error.<br>
<br>
Alex<br>
</blockquote></div>

--00000000000092034d060dd08b0d--

