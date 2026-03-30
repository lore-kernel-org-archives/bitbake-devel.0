Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6C21061B16
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 16:34:23 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.55812.1774888458279720550
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Mar 2026 09:34:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VGI6WaC+;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4873ce69ba9so12238185e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774888457; x=1775493257; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5KS7P1T5kTERsMbToJwjPckRMEOwiXbbKga8IX4fk28=;
        b=VGI6WaC+b4OE9S9PIeMI9cgB+7HDTgSXncME6GP7Hhizmi6VtcIZu32yEvfr390J4T
         az1hNrHHjL4W8yimEeN22AMh3Fn8za18CXMnFOwl4I+1ZQ0CyZhk+igdJnCO2RRpvptO
         BiRss1IRljdl462i0lsjXywhA9p6y4EvxKZrs1PHkLNMnbyodTn8yzuYAetVlALofhme
         x7gUt4qOvG7r2+XMvIHe21Lt5QT3UzJes4NE1WPZX4NSTXUNJuKBh2KjQdhLSk5PiaHK
         Iskok4u4p3rToZdP5SpwAicPPCC696KSCxi0AoSVsgVsc5fz9wfZaPstoIzX6pdVL2uF
         ndzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774888457; x=1775493257;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KS7P1T5kTERsMbToJwjPckRMEOwiXbbKga8IX4fk28=;
        b=U0iHepRKJVJUn9tmcKBO6rfNCOJTrDMwo9xvcQ+E+aCjDozO7r1lS9j0EbsJxD6CDM
         +g/bUEvf4NCzMC0R6o/ueIyiOZtJLSv8XrUxcwdRofq2TdOJWHP8/32tdLcaUMzb/pwv
         XSVbZw9AFLwEzr/BN5Aw0/aQcEay0hqcB+/YkUwS9veP1eyTXA1EBFOiU5ydlrUz2QKd
         cnCh2A+vPMG6Z+Aj0PhHpzxGLMr9kk+cPcfIkMQfVhIFbDVe1HayB4B89WHahebM6M/m
         dwXfMrnUK4bBtEf2+VcFpWxG8hLdSB+XgEJxdSju6/b6a1vQ/ljLQokNg4rWksYosP0T
         /PVg==
X-Forwarded-Encrypted: i=1; AJvYcCXsFxZoBJ9Hi0qLd/8X6H4jMdFdxL55ewWIz+lJOpAd7xHZ2Ffnxae/yImzQLDazkNOQlxTV2rMyc57xZm2@lists.openembedded.org
X-Gm-Message-State: AOJu0YxPOcmbaMMQ6k0w2Z+mc5Cz1QhDKcrjkwy6OulGRF2Al3rOeIkX
	1dJyORr/5ntL6Vp1I8jxX7VePNZcwPRM70Z0Tn3uO+4wkGg354bDjbnn
X-Gm-Gg: ATEYQzyyram8/n5fjuoUgUTJtmzPsj0caF6eDTxnq/LDgGmQb87QUaCgce81lTeO6Yi
	9ba9J5geS6WunqRUquiQhbzNSDGYDWKtShXs/5de135vG/W+G+uJevX8DwQPd9APQMhrYbz02kL
	WLiMlwnHYyfGK7cbWmzNAuzu5S3LbM2t52vhK9OBovUuIPsTpVKohlel90R06AsDfVP09bTj4i9
	T8dlIFjzNenI05lHBdHOt4vRRy/ZvhvSJh5OomEDlHKtZ7blQzlBLi72yc+Sa8uD5o7FK2MFlOQ
	EEIWAGq5DGHQ8q7kegv2Sv2p/RmzkbTVv5HEsV4C8+qaoOFl4jMN7PmIFE4IzCtZ2xrErJnuCqX
	CWs4nWX3zqU3ekBcW4IAyYpwChXiutxVJHLylkYlWqOhq/h+4+t2vABSzsLhvceNfZ8fCaya4K4
	eSjxpa1XYYU6RKJ1DCGOZIAuFJuJoThODeWnZwG5ZBLseLnCCldpRDWEsa/cKbGyNSaAHCJ+No
X-Received: by 2002:a05:600c:6094:b0:486:fd71:e609 with SMTP id 5b1f17b1804b1-48727f1fc05mr208054745e9.25.1774888456405;
        Mon, 30 Mar 2026 09:34:16 -0700 (PDT)
Received: from ?IPv6:2a02:169:59a6:0:55c4:f628:91f3:4287? ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487351fb38csm204372585e9.4.2026.03.30.09.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:34:15 -0700 (PDT)
Message-ID: <fcac19e4dff25335679496878b691fa73bcb7485.camel@gmail.com>
Subject: Re: [bitbake-devel] [PATCH 10/11] bitbake-setup: Set function
 default to None
From: adrian.freihofer@gmail.com
To: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com
Date: Mon, 30 Mar 2026 18:34:15 +0200
In-Reply-To: <20260326185742.542268-11-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
	 <20260326185742.542268-11-rob.woolley@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Mar 2026 16:34:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19283

On Thu, 2026-03-26 at 11:57 -0700, Rob Woolley via
lists.openembedded.org wrote:
> The function defaults are evaluated once and use across calls
> can lead to unexpected behaviour.
>=20
> Set the value to none and let the function initialize the value
> in the case when the value is not set.
>=20
> Resolves B006 from flake8-bugbear
>=20
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
> =C2=A0bin/bitbake-setup | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 2e1e347d6..6b210cd3e 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -45,7 +45,7 @@ def color_enabled() -> bool:
> =C2=A0def get_diff_color_param() -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0 return "--color=3Dalways" if color_enabled() els=
e "--color=3Dnever"
> =C2=A0
> -def print_configs(prompt: str, choices: list[str], descriptions:
> list[str] =3D []):
> +def print_configs(prompt: str, choices: list[str], descriptions:
> list[str] =3D None):

While "=3D None" looks better than "=3D []", this is still a bit wrong. It
should be:
  list[str] | None =3D None

However, this syntax would require Python 3.10+, so not possible.

Other options could be:
- Dropping the type checks from this function
- Using typing.Optional ?

Regards,
Adrian


> =C2=A0=C2=A0=C2=A0=C2=A0 """
> =C2=A0=C2=A0=C2=A0=C2=A0 Helper function to print a list of choices and a=
lign the output.
> =C2=A0=C2=A0=C2=A0=C2=A0 Each option name is made bold to stand out, unle=
ss color is not
> enabled in
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19255):
> https://lists.openembedded.org/g/bitbake-devel/message/19255
> Mute This Topic: https://lists.openembedded.org/mt/118523930/4454582
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[adrian.freihof=
er@gmail.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

