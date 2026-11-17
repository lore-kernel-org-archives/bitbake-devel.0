Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16634.1794918756839754278
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 04:32:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XP6Xz59P;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb61185057so21109185e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 04:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794918755; x=1795523555; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HiM5VUSMGvzxMBgF6W0xWllfIYsf+7nge/qMYFjvr+o=;
        b=XP6Xz59PJBuJbwAXRbmFNjPNHqQpe4IHb9FrgS1SRv/6WDeHAVh8DYtCZBAxeNf8o/
         LlGmUN7XegFUTo8bbNJIil2fhfmBnAjJwwo74mVMvQW20jSigrVP4ZMzQGwQaebHhJPo
         +wdzgO/0OjiOzh9deXudXWcmswHEJR3uEAu1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794918755; x=1795523555;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HiM5VUSMGvzxMBgF6W0xWllfIYsf+7nge/qMYFjvr+o=;
        b=s45idmBAt8Wu+NWpuCTA7/7bDl5ac9oJym6n/6C0Stg9i0j6P96w4t01pg6M9A9DVI
         LxaaDcuOQN/ac5pgqQLz8v4/mFS6THm/nbqbY02i0lVDaz2TJNwzXDgoyTsLKvxhBegC
         L4MtpixqW5EsMyzGvfkiYEK5j80aag5fmmuwbN7I+rGTNYarKS7KqUyQ5k/+KpgCGgtm
         eFWv+6RMB4auNXdDkUQi8FkfxR0GJpwDDaST4C+/o1MazxLg62STgaAtRFndIvdDOLB/
         scgPlZ4pHNAvZaQP6EtGzE7ezEaZZ3XlMBy+cGWf3dsEQZiXVK79isPkR80pPkZ2UVY2
         NgFQ==
X-Forwarded-Encrypted: i=1; AL+hErFrBmXfhMh9WJIZxxMTg11AgAill8agSGkCecI1ZPkHxAWVFfv8B6sRraZR1DVNOBU7zE/BzyQraFX9QRpk@lists.openembedded.org
X-Gm-Message-State: APuU4Z/xiE/u4V9+24bh/+OTRAsBoD0t3gFrmP8DVVqvzm8e4VElTaAm
	TAaPIpTcUfmQMv0UbK1FInGU+e84hRU75tJvkrbbTxilqkos5Oh/BCM7grBKxAOkMsUUCqDKEEI
	YvnKqPR4=
X-Gm-Gg: AYBFou2ueA7xS8FPvg0NECpKi33Z2pzwRd4y+Fj4+fmVrA/kvgzRqH4juX/enoZGaUD
	oSatadErlW/6TerOmOWyEBmpPT3NQqtPzfy1n0kiZrn/u7JKvsxGh9F7v8s9iwxVfTo5w9SLZ5+
	Ddd0NxkSoN9ewiMw6X4YGijHBx0GfQZbZTqk45ZD/DdekemIjXnXj5YEyxzO3ojbWeXqBHSVvN1
	W9c22x7tzpsoLRk2BJ4jbmAka1c2h5+REb5QRhP9ZP+R2S6/sA6RU7aW90yf9NYErAyc9bKDkNu
	izUfUDgkz570dsvK776TZYIHcqSJS1WWPHZ52oAFe1SKOA6BN/kL2CBiYVu7+42AORAnBPOmUZy
	U5/jcabSgBcJm0M+u3Zl6f98MW8BC6vuUKH7Mm08uR+tBenILe8BwWZOAGpfE+mN5HpeIrWAz83
	/rYJBV4yaQugmSaFiAuCdrJBGs79Ww5tqvR6zVc3IStG+JvR72TT85E8HFh3+1f3bZ8+s/teyO+
	CyubQ/uiUHRPiR/y/2WSAAnuZy4BkOZzqH9D30jdv52uOwV3/1bjqMFnBSnpsAQ/0zTwg4ShtCh
	MQ0i7b5o9kSqIv/8zDU6HkdNPqcr0C6CHSwuCKqj87r8iIrbSE+36womOF7vFiT4S3kOJ8Rt6wi
	eKcM4QeBEqDSMiwACPQ==
X-Received: by 2002:a05:600c:8b6c:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4bb649d4148mr187399255e9.28.1794918754909;
        Tue, 17 Nov 2026 04:32:34 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:5769:a004:a5af:24bf? ([2001:8b0:aba:5f3c:5769:a004:a5af:24bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7838c99bsm61691595e9.6.2026.11.17.04.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:32:33 -0800 (PST)
Message-ID: <a41c1517f39b3f6ea520094767ee2b98ab010b7a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: fix -w with a file name that
 has no directory
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bbnpreetsingh@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 17 Nov 2026 12:32:30 +0000
In-Reply-To: <20261114185534.7-1-bbnpreetsingh@gmail.com>
References: <20261114185534.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 12:32:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20448

On Sat, 2026-11-14 at 18:55 +0000, Baban via bitbake-devel wrote:
> "bitbake -w events.json" fails with:
>=20
> =C2=A0 FileNotFoundError: [Errno 2] No such file or directory: ''
>=20
> There is no directory to create for a bare file name, so don't try.
>=20
> Fixes: ee174b231897 ("cooker: Add support for BB_DEFAULT_EVENTLOG")
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> ---
>=20
> Notes:
> =C2=A0=C2=A0=C2=A0 Found while looking at YOCTO #16492. Applies with or w=
ithout Mathieu's
> =C2=A0=C2=A0=C2=A0 patch for that bug.
>=20
> =C2=A0lib/bb/cooker.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++-=
-
> =C2=A0lib/bb/tests/cooker.py | 18 ++++++++++++++++++
> =C2=A02 files changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 8a422e506..f79cd5e6c 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -457,8 +457,9 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting=
, but this may result in si
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not self.eventlog or =
self.eventlog[0] !=3D eventlog:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
# we log all events to a file if so directed
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
# register the log file writer as UI Handler
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if no=
t os.path.exists(os.path.dirname(eventlog)):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bb.utils.mkdirhier(os.path.dirname(eventlog))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirna=
me =3D os.path.dirname(eventlog)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if di=
rname and not os.path.exists(dirname):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bb.utils.mkdirhier(dirname)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
writer =3D EventWriter(self, eventlog)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
EventLogWriteHandler =3D namedtuple('EventLogWriteHandler', ['event'])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.eventlog =3D (eventlog, bb.event.register_UIHhandler(EventLogWriteHand=
ler(writer)), writer)

Thanks for the patch. When reviewing this I realised that the current
working directory in the server code might not be the same as the
commandline.

Would you be able to tweak the code in main.py where it sets=20
"options.writeeventlog =3D eventlog" to resolve the path there to a full
path?

It can also be set via BB_DEFAULT_EVENTLOG and I think we should just
show an error if that path isn't absolute?

I think that would resolve my concerns.

Thanks,

Richard

