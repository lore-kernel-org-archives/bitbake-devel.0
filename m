Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC108C04A95
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 14:21:39 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.7728.1666707694384873763
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Oct 2022 07:21:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PGNVouvS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id l14so14113310wrw.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Oct 2022 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzOkNlD9uaabFvE54fuQ95FA2ppJzQR9fXlHM2EhWC0=;
        b=PGNVouvSa1kJ3hxVYP00LcHhnsSicqCIBlzPQkscPCkaCkDZIsr2kI5DH7FCrDAZgI
         KlUgaehqZ9/iu4nDSlk1VfQ1hE5QIHo5xthu5BIfCRhApq25YtRLOahgFit4BBlXW4MW
         KN9InUaUO4oZw3BAtaabyXocJ0mx4x5XQ061I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PzOkNlD9uaabFvE54fuQ95FA2ppJzQR9fXlHM2EhWC0=;
        b=NXrONCdjxLwAiUMAPsbRpgErNxAbuIziq6jDErtILn7i1qanCCGf9e2HUxQOep41cR
         uAbKG85buAQhUURInIBADPX9OPls9aSnP+00KBfExGhZeCfnkJTlelHNqT44UZFgUWXv
         ibjZnW79cBScf4ExbHnGLFhARlySkAubxEM86AgAgwK8hxc6t6WmPABEOr4f0sVn6Tzp
         86SPXeSjz+MjFfoK+gXJsccFW9G4oEq+n2KR8i04u+jJty6qXgZQdFORowDQ/jK1aWV/
         odanW/XRIa2c/vyfsDPs04asY+MQCp4jLVkckCvbjEN6YQqPQ9cw8MIEJQqMBgXcLfxK
         HPPQ==
X-Gm-Message-State: ACrzQf2YXVRXPiYRAPyQUnzqdBMFu1tzXGqHI5TTchuQgGAuJmL15HIA
	ZGF7hezW++yq+ALDo6Tou+4XCA==
X-Google-Smtp-Source: AMsMyM7JBXaQsBvFZzb/ScTY6NuWUDakQJGsdY8sl2rLiXz1/1J49PYOqpyx51uLsJ0krOKSdrTfgg==
X-Received: by 2002:a5d:6d02:0:b0:232:4070:6026 with SMTP id e2-20020a5d6d02000000b0023240706026mr26124230wrq.33.1666707692433;
        Tue, 25 Oct 2022 07:21:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:46a:60c6:26a1:e0b0? ([2001:8b0:aba:5f3c:46a:60c6:26a1:e0b0])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b003c6cd82596esm11677085wmo.43.2022.10.25.07.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:21:31 -0700 (PDT)
Message-ID: <321b3611966533c6083eb40ed4300971f9e0a347.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] gitsm: pass lfs parameter from main
 repo to all its submodules
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <Martin.Jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 25 Oct 2022 15:21:29 +0100
In-Reply-To: <20221017132026.88753-1-Martin.Jansa@gmail.com>
References: <20221017132026.88753-1-Martin.Jansa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Oct 2022 14:21:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14049

On Mon, 2022-10-17 at 15:20 +0200, Martin Jansa wrote:
> * it might not be ideal in some cases where we might require LFS objects
>   only in some of the submodules, but still better than no way to set
>   lfs for submodules which causes git smudge issues in e.g. vulkan-sample=
s
>   when LFS is enabled in gitconfig
>=20
> [YOCTO #14938]
>=20
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/fetch2/gitsm.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 25d5db0e..36f0464c 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -122,6 +122,7 @@ class GitSM(Git):
>              url +=3D ';protocol=3D%s' % proto
>              url +=3D ";name=3D%s" % module
>              url +=3D ";subpath=3D%s" % module
> +            url +=3D ";lfs=3D%s" % ud.parm.get("lfs", "1")
> =20
>              ld =3D d.createCopy()
>              # Not necessary to set SRC_URI, since we're passing the URI =
to


Shouldn't that be:

ud.parm.get("lfs", "0")

i.e. default to off but pass if present?

Cheers,

Richard

