Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBC8C4332F
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 14:59:47 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.16251.1670511582158909929
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Dec 2022 06:59:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aTkMyWQA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id y16so1936050wrm.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 06:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7tQSraZEazeF3DDPD8Y8iw0PpdnY55Forpf757q+4iY=;
        b=aTkMyWQAuTNT2agpWF8sn5rOOkVt0uKjwlgREF/r1xXTFTGxb9EphACh2zqrfKzrWr
         WmsGQGhSXng9N20kTg+sqdmMj+LFU9mbFDpA0zUwEtYEaaZieU70lscer828ecb89L4J
         b2wknJhI4AXWg0rO6163ZJSHE2/5t/O079zfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tQSraZEazeF3DDPD8Y8iw0PpdnY55Forpf757q+4iY=;
        b=NWfxqLilmc0OW7LFny1oQtPLm6yUaeS2QO95GA0422MiZD+Mz1XZRJYCpZ3rPgeVY5
         OMISyciQeqM6sm3kbnrIfwnAHVjdq0Eis3zzwyXYc1VgBRoe7uBS37mrO0fFbpx24wzR
         qVaH6BiLEfoe2T+yh9nHhuE8TjDDC6CT8IwAtNZiE2lbiRD58ADSR+2j2wsx6Qb2kJ+l
         O4y87a6s+DJsf4b9B/ExqffDFZugP6WW9VzLHxpzTmN162BssSNM3oN6n03tfhoOB1d2
         TgSi83iQsNvA5F8YqaH66ARLkyBeVFxwEDE9KpYxBp33Nw7EO0rC+dYE4FScXDY+/DFF
         JA6Q==
X-Gm-Message-State: ANoB5plCGgCEcBjrytWbAI1G49zINlqDiZBxrhKSgxoT6HwokJHK9kqZ
	90mufJFWXIbEKROXldTPFhf5cg==
X-Google-Smtp-Source: AA0mqf6RxUgzFE1DUToMctfE8++PupuTuOAETFQLjGV5Q6FWqyOZc9x7i8PR/nNXhpRp3ZGxknH98w==
X-Received: by 2002:adf:ef89:0:b0:242:1ae0:f2a5 with SMTP id d9-20020adfef89000000b002421ae0f2a5mr1630847wro.42.1670511580300;
        Thu, 08 Dec 2022 06:59:40 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:50bb:c4ee:bb3b:bc91? ([2001:8b0:aba:5f3c:50bb:c4ee:bb3b:bc91])
        by smtp.gmail.com with ESMTPSA id ay5-20020a5d6f05000000b00242710c9910sm9554505wrb.8.2022.12.08.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 06:59:39 -0800 (PST)
Message-ID: <609ec123425599c724285de7c56b2150ec491d71.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget.py: correctly match
 versioned directories
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Thu, 08 Dec 2022 14:59:38 +0000
In-Reply-To: <20221208122131.2455528-1-alex@linutronix.de>
References: <20221208122131.2455528-1-alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 14:59:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14151

On Thu, 2022-12-08 at 13:21 +0100, Alexander Kanavin wrote:
> When obtaining latest upstream versions, the code needs
> to check if the existing tarball is in a versioned directory
> (e.g. component-name/x.y/component-name-x.y.z.tar.gz) and
> if it is, it needs to first obtain the list of all
> such versioned directories and then check all of them by going
> one step up in the directory hierarchy.
>=20
> Existing code was returning a correct match when the component
> name did not have numbers, e.g. a check on 'source/epiphany/43/'
> would return 43, but was stopping too soon when the component
> name itself had numbers ('source/libxml2/2.10/' would return libxml2).
>=20
> This change ensures the last match is taken instead of the first.
>=20
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bitbake/lib/bb/fetch2/wget.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
> index 821afa5b58..7ccea3ad89 100644
> --- a/bitbake/lib/bb/fetch2/wget.py
> +++ b/bitbake/lib/bb/fetch2/wget.py
> @@ -644,10 +644,10 @@ class Wget(FetchMethod):
>              # search for version matches on folders inside the path, lik=
e:
>              # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}=
-${PV}.tar.gz
>              dirver_regex =3D re.compile(r"(?P<dirver>[^/]*(\d+\.)*\d+([-=
_]r\d+)*)/")
> -            m =3D dirver_regex.search(path)
> +            m =3D dirver_regex.findall(path)
>              if m:
>                  pn =3D d.getVar('PN')
> -                dirver =3D m.group('dirver')
> +                dirver =3D m[-1][0]
> =20
>                  dirver_pn_regex =3D re.compile(r"%s\d?" % (re.escape(pn)=
))
>                  if not dirver_pn_regex.search(dirver):


There are tests and examples in lib/bb/tests/fetch.py, could we add
something for this case?

Cheers,

Richard


