Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB278E67800
	for <webhook@archiver.kernel.org>; Sat,  2 Nov 2024 14:14:19 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.17730.1730556850506705756
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Nov 2024 07:14:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YomSXy2U;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315eac969aso16326815e9.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 02 Nov 2024 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730556849; x=1731161649; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8c5X1IYxGXlYo36HxiSjXRMJaAs8zrbkJxWjKKTfUjQ=;
        b=YomSXy2UDrWjYpGacIejIPywMj3Qe8OM1UNRQpAEru+ijjgTNGSMhpBxd+f55GQFaZ
         +m1X66JeRW5RnoUdW0/Mhp//mygEaA4AdSrx+UsL5GlVAoVeyWqhLn8JAjlxZuWgy4Xa
         aUV0J2E5xyOSr1oGprtENsD4yGhipJ2EIh898=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730556849; x=1731161649;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8c5X1IYxGXlYo36HxiSjXRMJaAs8zrbkJxWjKKTfUjQ=;
        b=lhsyWPKP3ZYkEtzkaqyEjUs2YQxWwfBYTeD87rI5uXtn3SDT6TawJYt1dgQTolhZma
         RZ74KQdx3ofLV/D6D7/FH1WSHt33hjQXjmdYSAxq/rspJuZcqm+HG2wIIDnpUUTUUoO/
         fbqco6K2Sx7rHUtbJ/o+/uedy6iFmkY1getqfeK8Kq3Kq5KIz2DHnIab5e+xwG73BS/G
         KL/osZ9d5JKvC6Q/q9Nos5VniX2W8RbwnP5KzIRaxZAWH4Gg1fzkD0LuJRbTDHDu43gf
         hCCN95KkOxp0740Udgx6o2CrJogsp+rYqZV+xBbZHoHIJ/HiL9eCrhBhg1aelP+b8UDL
         z2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCV6XsFMXdXdqYUMutoqKiEz0dSJSp8mpC0mGM087LOfwyB4aMyy8J38m731a4k1SzMCvZas2NnKnQhcV6T6@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz8NC8EXXjC/B4DGuDyzhhnFw5vm7+dXiDnju57DXkTV+2el/Ox
	R3aDHnqtbAJ86W+7kVaoYsRA86Q5fEsCsValX2cl5f1rQXfNXwBJyekPwVWPbYM=
X-Google-Smtp-Source: AGHT+IHoTSW7dPj3hh+LSS5+VxGWu+DxVangciS4ud9Lj9qhTPg4Gj896SJ44ClhqBRNd/gI1puLFw==
X-Received: by 2002:a05:600c:512a:b0:431:5226:1633 with SMTP id 5b1f17b1804b1-4327daa349emr79967495e9.6.1730556848898;
        Sat, 02 Nov 2024 07:14:08 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:fdce:c4d:9295:5245? ([2001:8b0:aba:5f3c:fdce:c4d:9295:5245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852d9sm96057695e9.37.2024.11.02.07.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 07:14:07 -0700 (PDT)
Message-ID: <863880dddca8a8e37fa350e0baf69ac682c9bd07.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][PATCH 1/2] bitbake: hashserv: client:
 immediately test the server address
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: quaresma.jose@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <jose.quaresma@foundries.io>, Joshua Watt
	 <JPEWhacker@gmail.com>
Date: Sat, 02 Nov 2024 14:14:06 +0000
In-Reply-To: <20241031120015.3651707-1-jose.quaresma@foundries.io>
References: <20241031120015.3651707-1-jose.quaresma@foundries.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 02 Nov 2024 14:14:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16769

On Thu, 2024-10-31 at 12:00 +0000, Jose Quaresma via lists.openembedded.org=
 wrote:
> Test as soon as possible if it is possible to connect to the server
> and use raw socket for this, which is much simpler and works for what you=
 want.
>=20
> Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
> ---
> =C2=A0bitbake/lib/hashserv/__init__.py | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__in=
it__.py
> index ac891e0174..47b25fa6ab 100644
> --- a/bitbake/lib/hashserv/__init__.py
> +++ b/bitbake/lib/hashserv/__init__.py
> @@ -82,6 +82,15 @@ def create_client(addr, username=3DNone, password=3DNo=
ne):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
c.connect_websocket(*a)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
c.connect_tcp(*a)
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # test the connection now
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 import socket
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock =
=3D socket.create_connection(a, timeout=3D5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock.=
close()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except socket.error as e:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 ConnectionError
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return c
> =C2=A0=C2=A0=C2=A0=C2=A0 except Exception as e:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c.close()

This didn't work, see below. Copying Joshua for comment on these.

ERROR: Running idle function
Traceback (most recent call last):
  File "/usr/lib/python3.11/contextlib.py", line 137, in _GeneratorContextM=
anager.__enter__():
             try:
    >            return next(self.gen)
             except StopIteration:
  File "/mnt/b/yoe/master/sources/poky/bitbake/lib/bb/siggen.py", line 589,=
 in SignatureGeneratorOEEquivHash.client():
                 if getattr(self, '_client', None) is None:
    >                self._client =3D hashserv.create_client(self.server, *=
*self.get_hashserv_creds())
                 yield self._client
  File "/mnt/b/yoe/master/sources/poky/bitbake/lib/hashserv/__init__.py", l=
ine 97, in create_client(addr=3D'unix:///mnt/b/yoe/master/hashserve.sock', =
username=3DNone, password=3DNone):
             c.close()
    >        raise e

  File "/mnt/b/yoe/master/sources/poky/bitbake/lib/hashserv/__init__.py", l=
ine 89, in create_client(addr=3D'unix:///mnt/b/yoe/master/hashserve.sock', =
username=3DNone, password=3DNone):
             try:
    >            sock =3D socket.create_connection(a, timeout=3D5)
                 sock.close()
  File "/usr/lib/python3.11/socket.py", line 825, in create_connection(addr=
ess=3D('/mnt/b/yoe/master/hashserve.sock',), timeout=3D5, source_address=3D=
None, all_errors=3DFalse):

    >    host, port =3D address
         exceptions =3D []
ValueError: not enough values to unpack (expected 2, got 1)


Cheers,

Richard


