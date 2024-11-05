Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20659D3E779
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 22:06:39 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.32537.1730844391874997728
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Nov 2024 14:06:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EW1E4pK9;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so7443891e87.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 14:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730844390; x=1731449190; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUzkeCeCfCqmCSkF1K1C5KKDQXJxuxp7TdKFnONvy7k=;
        b=EW1E4pK9WZh5mSc9FF8p+5kb14iKwXNQ+LsqxfUhq+AHvxveSIsrCy1n2LApNka28F
         Ye6qVvYhM5CAUGvnjEuWFOpfHtwX20GtX4Qzcx9GG6DRFjPhB3SnJ8Dmp1lMA7WCFdtR
         ZYJ8f+xb6ZEZxZtE8zduAPrzvjBb9PVD6Aa5rNhyG/PoTdykV3g9wC1gaSgKuaguqTQq
         Vwp9Rl1onA8JTSL2seDCMvai8UaMmKlnwbBCw8U0Y2W3rS7997HR3y320onnbDUpo8rb
         P+y06Ojo/VLjLoT7qx27U/W0FfVCPqdPzztObJ/Kf2VUSaGN8jo7dIpsiiewWb0r23my
         b9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730844390; x=1731449190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUzkeCeCfCqmCSkF1K1C5KKDQXJxuxp7TdKFnONvy7k=;
        b=BXacucLJA1AAP9tHG/tKCy/qClsbsLvt7t7mk0Zh/dP/wbDUOsaL8H4o6vN5oSd2jS
         lnVr76LeSA0tJSX8PPNDNJYNe/oXSnH91eUYHkOpY1wqGvJvflhRr2rHrT+fwM7bDC6U
         4gqvY2VKuvAxgVlCmKs88M15xVw70Wvg+/OajpVZL8n3GeDaFUEqjfXkZRAQL8kx/Jbc
         O1GfGqWKJNdC7f2aoQT5JbhoiBC/DF5WyWOWMb0SyWlBsoSm1PmADFMokzB88gMjaWbh
         MuiODYM55m7qEyMpWDiWtnrLWfNw7/NCQuJMrX97aJ57FoQBZRIjI/UzVUrwsBQZKuen
         yH8Q==
X-Gm-Message-State: AOJu0YzPzd80h9/nsIVXPgNiruyEdZVyfi/84J5vY4r+fuqIp6ramMhv
	heEJCd4Eb0lGRMxOjz2fzoYidQv+EQo5lKFK9Y5SNCbzSmBwmUHwGeZ6Qjf4B5HwSHkLYNApeGJ
	+ZKERHzrQ915+xXcUsX+OCoiqicU=
X-Google-Smtp-Source: AGHT+IEvk5ie57ZSsUaLebNXAXdeAf8LOqiz9/LGWqFPrGTP93rxxy5dWgn2mGxUbKXKK8yb23qh2o4sosSLhlmORbk=
X-Received: by 2002:a05:6512:1392:b0:536:73b5:d971 with SMTP id
 2adb3069b0e04-53b34c5f886mr18916409e87.38.1730844389309; Tue, 05 Nov 2024
 14:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20241105154238.3611453-1-jsbronder@cold-front.org>
In-Reply-To: <20241105154238.3611453-1-jsbronder@cold-front.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 5 Nov 2024 15:06:17 -0700
Message-ID: <CAJdd5GaL4tOJAREOfXp5vzeQ+zrrL41Sio1e8XaktoDM7=fk5g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] asyncrpc: timeout attempting to create a
 TCP connection
To: jsbronder@cold-front.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 22:06:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16781

On Tue, Nov 5, 2024 at 8:42=E2=80=AFAM Justin Bronder via
lists.openembedded.org
<jsbronder=3Dcold-front.org@lists.openembedded.org> wrote:
>
> Timeout when trying to connect to an upstream that may be filtering
> connections (instead of waiting endlessly) and raise a ConnectionError
> which will allow the caller to note that the client is not connected.
> This, for instance, ensures that a firewalled BB_HASHSERVE_UPSTREAM will
> trigger warnings.
>
> Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
> ---
>  lib/bb/asyncrpc/client.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
> index 9be49261c..92e140dfe 100644
> --- a/lib/bb/asyncrpc/client.py
> +++ b/lib/bb/asyncrpc/client.py
> @@ -68,7 +68,12 @@ class AsyncClient(object):
>
>      async def connect_tcp(self, address, port):
>          async def connect_sock():
> -            reader, writer =3D await asyncio.open_connection(address, po=
rt)
> +            try:
> +                reader, writer =3D await asyncio.wait_for(
> +                        asyncio.open_connection(address, port),
> +                        timeout=3D5)

Use self.timeout instead of "5" so that users can configure this
through the normal timeout methods.

> +            except asyncio.TimeoutError as e:
> +                raise ConnectionError(f"Timeout connecting to {address}:=
{port}") from e
>              return StreamConnection(reader, writer, self.timeout, self.m=
ax_chunk)
>
>          self._connect_sock =3D connect_sock
> --
> 2.46.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16778): https://lists.openembedded.org/g/bitbake-deve=
l/message/16778
> Mute This Topic: https://lists.openembedded.org/mt/109407941/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

