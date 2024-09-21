Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC23CF9C69
	for <webhook@archiver.kernel.org>; Sat, 21 Sep 2024 16:09:45 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.12122.1726934980682356277
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Sep 2024 09:09:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O5BfjuAw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a90188ae58eso357424466b.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Sep 2024 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726934979; x=1727539779; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9SXXk6BtsU1GgomSDupWu46IHiC8B7ftuIEywaxStk=;
        b=O5BfjuAw8h4cxEARj4XC2m4XlDCzzzMkYBa44xGtv/8GPWJGD0YyqIRdz27oveAPrZ
         AXq06kpVxOi2JJF7Sr92GQa0KjwvprlRv3ARjnpAjtIhs2mgpbrdXkw6PiAYmrf94Q91
         iXsAlDF+bQ4cH9xgxFLDS1WvXYINlztgJvCzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726934979; x=1727539779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9SXXk6BtsU1GgomSDupWu46IHiC8B7ftuIEywaxStk=;
        b=F2RAkO39FR1TR1JltEXjV5piN+Mx34ThduRaZPiFOsaAwO2VGWwvdCVeB8RZhKdJ8h
         HdxuFNAyixGuzqQMJCHIL5AQ60zNcv+xbaKGpf3kgyLf9ltHuK0fc93nO/PlAOamwnEc
         q03hKnJUzGoTmL80WadlgqQ1a8Wo/GogL3RwxXnBtSYH3tAk3LeDmf534cDUK8AyfTz6
         vnmViKwfivV0z1XbRKxqeqZ1JdzTwoIx/NqFmTaB/Tg9AQfqK+gCaRTjP+6sESenBveb
         tB8ks7n5RmeDu27rCYo+zenp43N/gKTuRl64+/6bQTYSF8hAIwRUgmjbNzglUh9VbhzF
         QGhw==
X-Forwarded-Encrypted: i=1; AJvYcCVnoWyPCtL98Lr/pD9y+TQidE8s5aJw7FZaYImHuTHka8q+d7XYmWadP6NgQKiLtWKl4fzqKEtkY0/eEAf6@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy5TdIO0WmZ7UiClCUk301hjtYqmMAc3rbHczMpCwgyAGbuuCLX
	7abzYBSo0eGV7TmtAgeUvzOOKLyGQQDLyWB4wt3dn6oHGJcfmAB98X1WDayn/Lc=
X-Google-Smtp-Source: AGHT+IGng1jGjr/n3Jrq1g1W8J+o3KkyjXkHJQWP60snbQmkw5SgwF3vjzyxfmsitKStqK2DzqErOA==
X-Received: by 2002:a17:907:1c28:b0:a8a:3ece:d073 with SMTP id a640c23a62f3a-a90d5672848mr520540366b.10.1726934978777;
        Sat, 21 Sep 2024 09:09:38 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4f6a:2d77:ed0c:6809? ([2001:8b0:aba:5f3c:4f6a:2d77:ed0c:6809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f3ae2sm982774866b.76.2024.09.21.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 09:09:38 -0700 (PDT)
Message-ID: <92162b7f77c4c9df450600706926a9bc58b3b097.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/3] bb/data_smart: fix override syntax
 warning
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: kweihmann@outlook.com, bitbake-devel@lists.openembedded.org
Date: Sat, 21 Sep 2024 17:09:37 +0100
In-Reply-To: <GV1PR07MB91203D2CA5B12F4DD0287BB1A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
References: <20240921120920.240557-1-kweihmann@outlook.com>
	 <GV1PR07MB91203D2CA5B12F4DD0287BB1A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Sep 2024 16:09:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16581

On Sat, 2024-09-21 at 12:09 +0000, Konrad Weihmann via lists.openembedded.o=
rg wrote:
> when defining a function do_removesomething,
> the parser warned about
>=20
> Variable do_removesomething contains an operation using the
> old override syntax. Please convert this layer/metadata before
> attempting to use with a newer bitbake
>=20
> correct it would be to search for a override operator at the end
> of the string or for the next operator
>=20
> Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
> ---
> =C2=A0lib/bb/data_smart.py | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 4e15a43c2..49cd4357a 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -539,8 +539,7 @@ class DataSmart(MutableMapping):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return var in self.overr=
idedata
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def setVar(self, var, value, **loginfo):
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not var.startswith("__anon=
_") and ("_append" in var or "_prepend" in var or "_remove" in var):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not var.startswith("__anon=
_") and re.search(r"(_append|_prepend|_remove)(_|$)", var):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
info =3D "%s" % var
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if "file" in loginfo:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % loginfo["file"]
>=20

We can't add a non pre-compiled regex into a code hot path. Even a
precompiled regex is going to be relatively slow at that code point.
That is why it is using "in" and it was a relatively loose test.

Cheers,

Richard

