Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DC8C61DA4
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 09:58:48 +0000 (UTC)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 by mx.groups.io with SMTP id smtpd.web10.6629.1676541527518619689
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Feb 2023 01:58:48 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=XytpPa23;
 spf=pass (domain: myneves.com, ip: 185.70.40.18, mailfrom: paulo@myneves.com)
Date: Thu, 16 Feb 2023 09:58:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676541524; x=1676800724;
	bh=1C2qeAkTJZv/Y7iBwo1bmsMBrsUvly7t4gqHN5TjPUc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XytpPa23OlTXOmWwJQVM7Hpt+xwS9+CkdJMG3aKZimkkPFLjUxFk1CIBiTaIPV09E
	 I0NSF7nyNmPFSqJgzvP8QJpiuwLGOHDMoUvSOM3j0INAToLH/s+4qk8Y2SXuNWXnqu
	 CwVYYl5p8VQvD3YbiFxrZILkav7L2jBtiynfMWepQyS1BGNocr6x59m7zpG9OFXvxc
	 x7Ewq2jBfcaHFxnV8lMKFV6rV8cda4JfNYSL30Jf+yAGQnlGhVg2RBBLoaANYWopA/
	 3BbeRJ/w+X/4Lq+i6TcKNScKh5JWiiu9l6KDO5vVxjRcR2Y4oGY/NgPSVg2pbVF3kz
	 rGh3xHgIu4VtQ==
To: Ross Burton <ross.burton@arm.com>, bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Cc: nd@arm.com
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: clean up netrc usage
Message-ID: <76c73df9-69ff-da0c-60fb-378b9940f75a@myneves.com>
In-Reply-To: <20230214160751.2391568-1-ross.burton@arm.com>
References: <20230214160751.2391568-1-ross.burton@arm.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Feb 2023 09:58:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14443

Your commit mentions TypeError but you also removed ImportError and
IOError. Why were they there and why are they removed?

Paulo Neves
On 2/14/23 17:07, Ross Burton wrote:
> Assigning a return value which is potentially None to a tuple and
> catching TypeError is pretty ugly.  Rewrite the code to explicitly check
> the value for clarity.
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>   bitbake/lib/bb/fetch2/wget.py | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
> index 696e9180303..6d365729e0c 100644
> --- a/bitbake/lib/bb/fetch2/wget.py
> +++ b/bitbake/lib/bb/fetch2/wget.py
> @@ -361,10 +361,11 @@ class Wget(FetchMethod):
>
>                   try:
>                       import netrc
> -                    n =3D netrc.netrc()
> -                    login, unused, password =3D n.authenticators(urllib.=
parse.urlparse(uri).hostname)
> -                    add_basic_auth("%s:%s" % (login, password), r)
> -                except (TypeError, ImportError, IOError, netrc.NetrcPars=
eError):
> +                    auth_data =3D netrc.netrc().authenticators(urllib.pa=
rse.urlparse(uri).hostname)
> +                    if auth_data:
> +                        login, _, password =3D auth_data
> +                        add_basic_auth("%s:%s" % (login, password), r)
> +                except (FileNotFoundError, netrc.NetrcParseError):
>                       pass
>
>                   with opener.open(r, timeout=3D30) as response:
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14419): https://lists.openembedded.org/g/bitbake-deve=
l/message/14419
> Mute This Topic: https://lists.openembedded.org/mt/96962989/4454782
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [paulo@=
myneves.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>



