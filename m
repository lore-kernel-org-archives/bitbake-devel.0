Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AB0CCF2C1
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 16:09:34 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8972.1792253370592256451
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Oct 2026 09:09:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S9twjODj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so5744675e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792253369; x=1792858169; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=14W6nQZafGLS3GlIPnT5kwfSIROPIg3LjH60qeTxsYc=;
        b=S9twjODjsGREjZOMZ4Ocj2/LkleKrLmVl6+XOmoLl4L0Ecl2sqU7hQKfKGRPpko+7P
         PzuNDgsNcR/P5HTDDbqjPmRyHbJGqVeqA6fR4pISXIlXMnocxWBYcr/SbRNxmO2f5vir
         Wlak01FJytTgsD64tFPWGkFFppghGGn9v035k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792253369; x=1792858169;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14W6nQZafGLS3GlIPnT5kwfSIROPIg3LjH60qeTxsYc=;
        b=pi/k/iRcQ59S3QBo+kXl2oMQ2xPo+d2RpeG/eRkZAgQeuEDqTwuxfe8nzpZlaaQ2Xp
         l6sj/BIksrTT+LhsBAoKPjSs9NpkZKwBUsWK5tdE1hp4IGwuT8dX3uvDrvZWX0A3Swm/
         fv85CfuzZGBzMCCpSBcV6EB+BhiR1ROnJ+lMKFeCnt/sqXsBwz6WEdv9QQlTgY8yG5eE
         NUpo2IZ5TQc1e3OQEKNGhe1A5U+9WYpUbjL0Amoqt2RQJA0ugaAaOwoT93ajW1ZXUQUL
         vdwN5Ssv2qxSNqJV3QQadedV+4QqkJJdrrZCSiX2BzmbzHnb0h6JtvhDX418UCYjR652
         N/5w==
X-Gm-Message-State: AFq9FYISSL/zmFmlC4PoVHI6rhlSbEmN2fD4bAwtkYfy4KrDB60yxZZ2
	ZPnv7XAZ1As/KtfANCvr3skPKdtmonI6KIoMZTqGtP+Gu1E1x++YbQ/Nf27/IqzhLeCXVwoJ+ZT
	qSUabJpg=
X-Gm-Gg: AYBFou02j+CNP7hShuQHBd9CD7D5cLb7eiKhHb5ow1AG+LkBCJbesONCPLu+kzWdydI
	ph41ZqSkJ3fngk5mKARkUNDNbQ5sWbs0ncIgEa9zWWL/DHdZ1XgGkTwggE3WNE7yhhIlIc+b3CN
	MITTgeozxvBL6J6wBXYWRAVFsabOo2Q66VSDmFH4giSxbXFTMZbRLR6Ae70mseF5ml2iDvgSKXE
	Qf9CWuMaLF2ufXsRht6MvnBxf29vWgWmta8xsXogsBVImWFB4LtS8ZZgU2JygFhFlkCxbKIOl6t
	cUdf/eBKVhe0PAqGPW7Oh5DLwpjgDw0srmVn2k9tw17fit7r/ZWy3HEjSftmTg6oGc3Tg9gR1ZV
	cXADpBzMkx2V/nb0P9mlicg7gTG2aZWVkMM80H+Wf3XtZtIdsrm9mKXMPbbvOXW26HfgSCrx18L
	pumkkaGTUqT+v1675AhJlNZznzX/X1eEe22t0O+T48z4vWN9ajm0jfUEp4xW0hLk591jxug4R7Y
	bX+zz71HrkaVvCavbPTT6DLOSUfvcCe+KOtMfumwH6dczLSeL+f4WjZ5dLbJqM=
X-Received: by 2002:a05:600c:37cd:b0:4a1:cfa7:e960 with SMTP id 5b1f17b1804b1-4a1d7601f1emr67234935e9.22.1792253368826;
        Sat, 17 Oct 2026 09:09:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:471d:9ae9:4cd8:a378? ([2001:8b0:aba:5f3c:471d:9ae9:4cd8:a378])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8a81587sm275698265e9.1.2026.10.17.09.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:09:28 -0700 (PDT)
Message-ID: <d5eb44b790ebb8de2b39566832f88f42f089c682.camel@linuxfoundation.org>
Subject: Re: [bitbake][scarthgap][2.8][PATCH 0/1] Pull request (cover letter
 only)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Date: Sat, 17 Oct 2026 17:09:26 +0100
In-Reply-To: <CAMSfU+5o1-peBH3NLrfqNMTMiXpBMGXiPuHg2WefWXFKqRXyLw@mail.gmail.com>
References: <cover.1792191269.git.yoann.congal@smile.fr>
	 <8c77cdccbbef939d980d80c07376c9808e37fc5f.camel@linuxfoundation.org>
	 <CAMSfU+5o1-peBH3NLrfqNMTMiXpBMGXiPuHg2WefWXFKqRXyLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 16:09:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20359

On Sat, 2026-10-17 at 17:50 +0200, Yoann Congal wrote:
> Le sam. 17 oct. 2026, 17:18, Richard Purdie <richard.purdie@linuxfoundati=
on.org> a =C3=A9crit=C2=A0:
> > On Sat, 2026-10-17 at 00:55 +0200, Yoann Congal wrote:
> > >=20
> > > The following changes since commit d3b32587c2314febf96897f97e0172790b=
4fc1cf:
> > >=20
> > > =C2=A0 toastergui/views: Replace os.system call with improved paramet=
er handling (2026-09-28 22:25:53 +0100)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > > =C2=A0 https://git.openembedded.org/bitbake-contrib=C2=A0stable/2.8-n=
ext
> > > =C2=A0 https://git.openembedded.org/bitbake-contrib/log/?h=3Dstable/2=
.8-next
> > >=20
> > > for you to fetch changes up to 6b443060ee96a62efb94723c97f22b51c9b205=
07:
> > >=20
> > > =C2=A0 prserv: commit new revisions when a request succeeds (2026-10-=
11 23:40:57 +0200)
> >=20
> > Do other branches need that patch?
>=20
> I think not.
>=20
> The patch says:
> This is specific to the 2.8 branch. The server was reworked for master an=
d
> 2.10 ("prserv: enable database sharing" and the commits around it), which
> commits where values are stored and uses WAL, so master does not have thi=
s
> problem and the commit cannot be backported as it is.
> =C2=A0
> Other supported branches are 2.18, 2.20 (all above 2.10 and the reference=
d patch)
>=20
> I checked the 2.10 commit and it looked like it matched so I took the pat=
ch.

Agreed, sorry, I think I misread something somewhere when comparing to
the current code. This does seem to make sense and I've merged.

Thanks,

Richard

