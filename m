Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C990AC021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 09:16:12 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.19505.1740129371885504220
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 01:16:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L45BQOkS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4399deda4bfso12696745e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 01:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740129370; x=1740734170; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NT8fZi4ID0N+CK1021bnis/a8dPCboNOp04DhgeV/6w=;
        b=L45BQOkS8BSQZqlBhy9Dg/mPPVzbJekx3A9lwuMbb3wz/DlB2Q+ca4YM27+0ExSeHM
         pIko9a6aN5rT4LxYCYKuqyY05JwXf1saXmfcinVjmUnchraSG1Cy/0wnsND1nl2WncQa
         2rhoPEVKOCjrceUkf1FOqOYw/d94iPkvZUbrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129370; x=1740734170;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NT8fZi4ID0N+CK1021bnis/a8dPCboNOp04DhgeV/6w=;
        b=oe//yMf3bDfCzFMUI2I8AQrSK0yKVhEZ2qioybwkvB+SKaoPOZrcyvmowYnPx89/z+
         uhxkJhFzwp3WvLX9zNlYOnel5WvM/tS4wUNfaGCrCml3G2GMVt2BBhP3I7cjD4cfBY0I
         eZ/xKLhTEKAl7qH1cvnKgjK9f4L9tkPs7PR5x7GvxVHJBMc9cG5jxh1mofuB/8xZ3saj
         dS52HiJ1Htvd+OLUErtAXTfDjDL8mrW1bXVMR7/oPWZd/Ej8iNTy6bja5T/9Pss1Gnnj
         kmyHHbk4cHQkpmH6sWSCjHZr6lKhFnXozN7z9H34HjEILN0Y13fVrawUGHafAe0lkzNo
         4a0A==
X-Gm-Message-State: AOJu0Yy/XKPpkuzmb+pifA/Vvt3vhlvM+LPZV1OdxaU6euy6OS0HKg2c
	pGLOLzYSYP8uabcKVPhQ4eYWk+4SaD9plWLQ7l6s+VfbOkE0I5OsoA1DmKpwyE4=
X-Gm-Gg: ASbGncthOXzu+Yplwqr8mZEwSlW4qGpuBfmFefLVYbaibh83DsAfk5DZvHXWs9o9IBq
	HANWA40r5+Lbau/hFpBySusSAV5zNBbq7Bs5LfS7i+P/apEMUSWJhyZ8TCxfjSABKjVbDqI6C+7
	IXZLdTqUkXxZNZY7sDZVhVoxhTAegbOHBksMgcIlrsoCMxhhXIfdZavtSP1psV38nxGytGoI9se
	0wGvTqoKLY++EhT5O+Pc4IHwuM5GWvOJQw0yKLC0nkPfdQKMwFCk/hot6o0d/seHmMMLBZc2dqK
	HbHIW0Rw4pgyQImUgEL8fi81EaiULrnKqadP2+BbdZ+ERSmKHcwLaM/+Di3I0r83RhthLkhghm4
	5asEtF76PAFs7
X-Google-Smtp-Source: AGHT+IGtKT7PLjPhHUj0P7LghnMDhanMrE78LYzjaw/ER8e8e8DJje8LsZtDXPxw9db9mM2eB8LWug==
X-Received: by 2002:a05:600c:1d1e:b0:439:9c0e:3692 with SMTP id 5b1f17b1804b1-439ae2228f7mr18333165e9.28.1740129370282;
        Fri, 21 Feb 2025 01:16:10 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:16ed:8c7:cc1f:ea46? ([2001:8b0:aba:5f3c:16ed:8c7:cc1f:ea46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b030bd9csm11132295e9.28.2025.02.21.01.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:16:09 -0800 (PST)
Message-ID: <416aa1661cd94d9787fec39012c4c94634a38b4c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Feb 2025 09:16:09 +0000
In-Reply-To: <CANNYZj8aM+mydGDSpMhrvbt8XxKDLzMywVyfKOdxdxrAPgSs2w@mail.gmail.com>
References: <20240502183501.1216856-1-JPEWhacker@gmail.com>
	 <CANNYZj8aM+mydGDSpMhrvbt8XxKDLzMywVyfKOdxdxrAPgSs2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 09:16:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17273

On Thu, 2025-02-20 at 17:05 +0100, Alexander Kanavin wrote:
> On Thu, 2 May 2024 at 20:35, Joshua Watt via lists.openembedded.org
> <JPEWhacker=3Dgmail.com@lists.openembedded.org> wrote:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except ConnectionError as e:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except (ConnectionError, Impo=
rtError) as e:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bb.warn("BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash equiva=
lence server at '%s': %s"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 % (upstream, repr(e)=
))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstr=
eam =3D None
>=20
> I'm setting up a bitbake-setup configuration that uses
> BB_HASHSERVE_UPSTREAM and the official yocto sstate cache on the cdn,
> and I think we have a usability issue here.
>=20
> Specifically, if the user does not have websockets python module
> installed, then they will only get a warning:
>=20
> WARNING: BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash
> equivalence server at 'wss://hashserv.yoctoproject.org/ws':
> ModuleNotFoundError("No module named 'websockets'")
>=20
> without a suggestion about how to resolve it. Worse yet, the build
> will proceed, but fail to use any sstate, resulting in rebuilds from
> source, and a bad first experience for yocto newcomers.

I think we should split that exception handler to catch ImportError
separately and mention in the message websockets was missing, if wss://
is in the url.

Cheers,

Richard

