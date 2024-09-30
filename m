Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8F4CF6497
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 09:13:59 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.50131.1727687630653983691
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Sep 2024 02:13:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y0Nzz9wQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cc84c12c2so2091816f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Sep 2024 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727687629; x=1728292429; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrAWeBfiLm5R2eoSRyXozl9eCRC1eKc+5p/6flHvYxg=;
        b=Y0Nzz9wQMnTZ3OyH0ZqEQ+aFxtSOehf6a4MthrUQWFMMMxHo+7g7Wdv6VxwZ2pS42p
         QnZefBTTM9R3gRmmC1GpaS6Ep+p9SLWBwcOrwU3SNDyE5rU+AhU/LRLIUzcaB0cwbIXB
         uuCj5xVr/DQA4/FSkK6yk13Wq7VxaL37O9EvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727687629; x=1728292429;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UrAWeBfiLm5R2eoSRyXozl9eCRC1eKc+5p/6flHvYxg=;
        b=bwOHR4Hud9KKSktEQELteYC5ISuIAxc5v2PfMJoSuyohuKPT1FlgHQW27X7zXP7wx1
         OcSc6U8mlZHbLzMxx+fMQWiXkEiOwEkaq1TH4Wxria8xFI+Rij/2QZZjjHiLdlmOQZ7r
         RwpjvZZifJfgAYZ4pOXPEOd4AdXJ1SRDxouxQJHRj3TH8vUInG1/aSRZtSMA/fTx9Z3t
         y0m/79OjeE/gMgb+yjwmbVcrhkbuyL/Q1l7B+80g7OPT2qk3cCD3eShNi/urw0rXcH79
         eo8lImpdSFtXcN8+Q43WD9n2NsL40KH5S6Jlrras0hJB24PVawXyArIHHRhAInO/VWsX
         DZpg==
X-Forwarded-Encrypted: i=1; AJvYcCX56DQP8scgXywB/xwthezYweSWwe5tA2r/kxhex16fIUdUKEIt7KJ8M3XzPZC6bd9d9L2z7prKm9FkkeyV@lists.openembedded.org
X-Gm-Message-State: AOJu0YwJo+fl/vt+7SgLDFa2yc/1h5G7feEJJAYJivJ7p0gKrKHnT2ws
	IjCv7lmGg1BvypmAisYQoV+Z+nrVvak+VH1BK/8AVFFqRImj/LOy8ZmkFvdK/q+qhLEJMr7ZjNN
	v
X-Google-Smtp-Source: AGHT+IH4+Pr6RB5SALNOMtiGXMecFPfGQGDdq46QNBvJcLSwej45pbZdmfg3GE6eZlk06zcwoQo+/g==
X-Received: by 2002:a5d:6807:0:b0:37c:ce45:96f2 with SMTP id ffacd0b85a97d-37cd5b1f317mr5588149f8f.50.1727687628891;
        Mon, 30 Sep 2024 02:13:48 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:bbd1:92ec:a53b:af7d? ([2001:8b0:aba:5f3c:bbd1:92ec:a53b:af7d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572f8bfsm8523254f8f.85.2024.09.30.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:13:48 -0700 (PDT)
Message-ID: <e6694732a1e929e0a33aeba62713433019ea1dc4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 2/3] bb/data_smart: fix override
 syntax warning
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: kweihmann@outlook.com, bitbake-devel@lists.openembedded.org
Date: Mon, 30 Sep 2024 10:13:47 +0100
In-Reply-To: <GV1PR07MB91208FE4BD9DE31DFD4A7318A8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
References: 
	<GV1PR07MB91208FE4BD9DE31DFD4A7318A8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Sep 2024 09:13:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16616

On Sat, 2024-09-28 at 09:00 +0200, Konrad Weihmann via
lists.openembedded.org wrote:
> when defining a function do_removesomething,
> the parser warned about
>=20
> Variable do_removesomething contains an operation using the
> old override syntax. Please convert this layer/metadata before
> attempting to use with a newer bitbake
>=20
> correct it would be to search for a override operator at the end
> of the string or for the next operator.
>=20
> To avoid running the expensive regex search on every setVar call
> the current "cheap" check would be have to be triggered,
> before the more precise check is run.
>=20
> Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
> ---
> =C2=A0 lib/bb/data_smart.py | 14 +++++++-------
> =C2=A0 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 4e15a43c2..0523744de 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -539,14 +539,14 @@ class DataSmart(MutableMapping):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return var in self=
.overridedata
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def setVar(self, var, value, **login=
fo):
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not var.startsw=
ith("__anon_") and ("_append" in var or=20
> "_prepend" in var or "_remove" in var):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info =
=3D "%s" % var
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if "f=
ile" in loginfo:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % loginfo["file"]
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if "l=
ine" in loginfo:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 info +=3D " line: %s" % loginfo["line"]
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.fa=
tal("Variable %s contains an operation using the
> old=20
> override syntax. Please convert this layer/metadata before attempting
> to=20
> use with a newer bitbake." % info)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if re=
.search(r"(_append|_prepend|_remove)(_|$)", var) is
> not None:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 info =3D "%s" % var
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if "file" in loginfo:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % loginfo[=
"file"]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if "line" in loginfo:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " line: %s" % loginfo[=
"line"]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bb.fatal("Variable %s contains an operation using
> the=20
> old override syntax. Please convert this layer/metadata before=20
> attempting to use with a newer bitbake." % info)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shortvar =3D=
 var.split(":", 1)[0]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if shortvar in sel=
f._var_renames:

The patch appears line wrapped unfortunately (it appears as quoted
above).

Also, I would still prefer a pre-compiled regex. I appreciate python
just have a last used cache but I'd prefer not to rely on python's
implementation details which can and do change.

Cheers,

Richard

