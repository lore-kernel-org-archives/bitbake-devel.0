Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC44C43334
	for <webhook@archiver.kernel.org>; Mon, 25 Jul 2022 22:04:49 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.2088.1658786681362756966
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 15:04:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DIsMG1GZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id
 c187-20020a1c35c4000000b003a30d88fe8eso10227730wma.2
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=wS/Y1c+TsyxeE4gSU80VxC5W6yhT1SmxGXVUKpFkRvY=;
        b=DIsMG1GZ6lVsliC99sncDAnQH/0DfXHjW6DymlfB16mqL58RYIVkxY8G9NcAOhQAeL
         F5S+bjgf3MwY5YChCk4zqkmZPY8ygQaaqmUDcjtCPw9bwhmQhMILMwEg6/8+JicZ+lte
         opllxVVoeWaCmEso+Cojw4hS2MctLfODInwaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=wS/Y1c+TsyxeE4gSU80VxC5W6yhT1SmxGXVUKpFkRvY=;
        b=DDy7s+bH33/MdWBYhzKSMhFt8xrhaXEKW7owKmhVKn5vAZyeeTvcBUF/ALqE6kG5QQ
         wlXggul2TS8hN+cIR3MWVj7ix/9zHtyDu8DK8nTXD575ah38iX1u8HFP7WK3p9fszshL
         fnNlmNj+XgsyszLGQeFjNcy2dEH87X+lZSSpeC/2SSY905yqpxZub9rsew8A2DGCFlm/
         DB9SrieviywDaVGxAGE5WGAGSc6YswOipd2olUihsE40hoM+M2BlzwuJ7Brglpv6lbZj
         yefeqyvQW+Pq6UgJafP+coSz8a/DHcM8wuCU8fTyHRUpuGV2Int2YGn1lBQJiSe5eyuW
         zmew==
X-Gm-Message-State: AJIora8fw4F23l3cpjpOiX72dQttnUS9f2R+kkEdO8KWIZ5DtoLkPMj0
	OpxE1/D/44QMiJ0MProOtVylxQ==
X-Google-Smtp-Source: 
 AGRyM1sNOuyHbqXKvIhc8BMm3GbwuACyFBAzoIdXHBQvVc7yJ3q+K5KMDWJ1nfFbAdvb8sypqQifkw==
X-Received: by 2002:a7b:cd15:0:b0:3a3:1d69:5201 with SMTP id
 f21-20020a7bcd15000000b003a31d695201mr9707590wmj.10.1658786679684;
        Mon, 25 Jul 2022 15:04:39 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:289a:8162:dbfe:813c?
 ([2001:8b0:aba:5f3c:289a:8162:dbfe:813c])
        by smtp.gmail.com with ESMTPSA id
 j23-20020a05600c1c1700b003a32251c3f9sm22781954wms.5.2022.07.25.15.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:04:39 -0700 (PDT)
Message-ID: 
 <94302dd15bf3efc70cc72ba1d272e9112812e787.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH v3] bitbake-user-manual: Document
 override :append, :prepend, :remove order
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: enrico.scholz@sigma-chemnitz.de, Marek Vasut <marex@denx.de>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Date: Mon, 25 Jul 2022 23:04:38 +0100
In-Reply-To: <lyr12983fh.fsf@ensc-pc.intern.sigma-chemnitz.de>
References: <20220725155625.381756-1-marex@denx.de>
	 <lyr12983fh.fsf@ensc-pc.intern.sigma-chemnitz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Jul 2022 22:04:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13848

On Mon, 2022-07-25 at 20:14 +0200, Enrico Scholz via
lists.yoctoproject.org wrote:
> "Marek Vasut" <marex@denx.de> writes:
>=20
> > =20
> > +.. note::
> > +
> > +   The overrides are applied in this order, ":append", ":prepend", ":r=
emove".
> > +   This implies it is not possible to re-append previously removed
> >     strings.
>=20
> fwiw, this is possible by anonymous python functions which are evaluated
> after ":remove"
>=20
> > FOO =3D "123 abc XYZ"
> >=20
> > python () {
> >     v =3D d.getVar('FOO')
> >     d.setVar('FOO', v + ' abc 789')
> > }
> >=20
> > FOO:remove =3D "abc XYZ"
>=20
> results in
>=20
> > FOO=3D"123   abc 789"

The reason for this isn't perhaps obvious and worth documenting - use
of setVar clears all append/prepend/remove operations against a
variable.

FOO =3D "A"
FOO:append =3D " B"

python () {
    d.setVar('FOO', 'C')
}

results in C.

Cheers,

Richard

