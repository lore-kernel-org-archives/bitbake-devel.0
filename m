Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551EAEB64DB
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 22:27:59 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.3330.1687300077065453145
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jun 2023 15:27:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=aK4dxRZC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3112d202363so3630087f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jun 2023 15:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687300075; x=1689892075;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yv/kDwiCSZ2Yur/Kp33+kXmmlWlYuKtLCTNQZ33dbqI=;
        b=aK4dxRZCFEnnKGtAjkfIxAZN0KJ9G+50BKBSmxTisyvi6vCuxSs6ePdzO2MEoxQLLp
         wF61JENXyHS5DF/rCdm9/wnpXCZ1qlbO5Ea1hwDGQYYar/P77VjQHjTo9g4xaSaOappR
         pTk4NA4WKd1y4TaWFa2Wrr1YlT6u4dq2AOlf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687300075; x=1689892075;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yv/kDwiCSZ2Yur/Kp33+kXmmlWlYuKtLCTNQZ33dbqI=;
        b=FQ5azNm0qXEyWe0qn/Yri1LSieMJPbmLji3ZJmtfM8a95o4AWEVAUCC1xQsbuaaOo4
         GZmEwB6+ITgwCXOwpBeNT4lxvL2IA6ZYMaMfAngPT+Zd3hCgtgmgwG8pBNpPOx62wAyA
         q/cMln5WoPNjup4AOoWYBnr/LfMac8c/YriNpTtOY82DceqrnVEiXuQYtaoHFMoyV54A
         0H1qpNwb8yPrnakPjvDio2xODZPBNsKK86Jdti1M1td5lvucG6OkKtjo8ZKthHIn3Ezx
         wXfu8eVgMDOUuSBQvUydlynQd//3yqRWVccjuvWQ93mgHdYRqbafG1mI8vsZ5BrGQjXC
         yeWg==
X-Gm-Message-State: AC+VfDzNaIiLLAqBqOlzJJCrgqHD8cbiMqdmDBV5LKQgZ8/x7cePzbNo
	RlevDq4GsCd+0/Q1oPklop3GWA==
X-Google-Smtp-Source: ACHHUZ5Cy919SmywDYxgf39KOMrQrAlZ3GU9tS02RHX7XE5biwBgWMK1fvaz7ctrVDU53JLvdcHYhg==
X-Received: by 2002:adf:ec03:0:b0:306:36ef:2e3b with SMTP id x3-20020adfec03000000b0030636ef2e3bmr10292133wrn.70.1687300075335;
        Tue, 20 Jun 2023 15:27:55 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:1417:9a5:3a38:428a? ([2001:8b0:aba:5f3c:1417:9a5:3a38:428a])
        by smtp.gmail.com with ESMTPSA id p2-20020a7bcc82000000b003f9bcba3839sm445097wma.12.2023.06.20.15.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:27:54 -0700 (PDT)
Message-ID: <d3339edca72c52a5f4bd15e67f37cf8717ef607a.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH] doc: Document FILE_LAYERNAME
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, 
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Tue, 20 Jun 2023 23:27:53 +0100
In-Reply-To: <60145e50-fd6a-b28c-51ab-f3cf3540f4a5@bootlin.com>
References: <20230620135822.2802308-1-richard.purdie@linuxfoundation.org>
	 <60145e50-fd6a-b28c-51ab-f3cf3540f4a5@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jun 2023 22:27:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14853

On Tue, 2023-06-20 at 22:16 +0200, Michael Opdenacker wrote:
> Hi Richard
>=20
> On 20.06.23 at 15:58, Richard Purdie wrote:
> > Document the new variable.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >   .../bitbake-user-manual-ref-variables.rst                    | 5 ++++=
+
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.=
rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > index ee5d7ba8d4..337cfa3ed5 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > @@ -1072,6 +1072,11 @@ overview of their function and contents.
> >         environment variable. The value is a colon-separated list of
> >         directories that are searched left-to-right in order.
> >  =20
> > +   :term:`FILE_LAYERNAME`
> > +      During parsing and task execution, this is set to the name of th=
e
> > +      layer containing the recipe file. Code can use this to identify =
which
> > +      layer a recipe is from.
> > +
> >      :term:`GITDIR`
> >         The directory in which a local copy of a Git repository is stor=
ed
> >         when it is cloned.
>=20
>=20
> Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>=20
> If you can merge this commit quickly, I'll be able to include the Yocto=
=20
> Manual one you submitted, referring to it.

Merged!

We may need to expand some of the documentation on this but I wanted to
at least have the basics.

Cheers,

Richard

