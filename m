Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B9AC36005
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 22:59:53 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.9617.1742943583200844007
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Mar 2025 15:59:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iaUDJybr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39ac9aea656so1078007f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742943581; x=1743548381; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7seiCH8ngtOglQROTJI6umZIW0YFr8I/puJXoJPWBE=;
        b=iaUDJybriHTtIVlB7o00k25VIrFg1gQLQSr9ULRV4LiTyvQopVWbA9SuqgmjxkG9uM
         yKp1RdLY1uVEhu4phm4vV/TQsqP8o4wJnSafl1fcvRWVK+fuYR/nChfRhZqeiQMmm8KB
         q8ZJDVYpCa87SSIDx16vFtxO9SJzGEPNefYS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742943581; x=1743548381;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G7seiCH8ngtOglQROTJI6umZIW0YFr8I/puJXoJPWBE=;
        b=LwtgVWDu/y6UG7l/y6IJvN/faEW++/wvgQcLzARwW+TCKbjTfHWQMz6xp0YsYc6TSI
         ceI6kAb29zuw8qLCnQuGPXsz3VuVLmbLu9T9q9nt5BnweTVc9qovwPO4bQfC6X/UmN/x
         3nB3fDPUWTNpJ6vM6P56412dUFOir00ExnCLE/eEvNCr2+YM74fHdKvXAjpKsjk1O5uX
         p8Xc5iXNZsflE5o2qpoPx8GFnidMYd9Y7ljJA0BdIBOoAqkKGR2WkbE81RbPx8n1UUdy
         lzppYKbwnjMTGBmb8Ro+dkS9NVZ09tk6JDw2LN3uXaY2zzAQp0T/23D75s4jqvttU54j
         akOg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ99PpPytRsQALIP6DJWZvKwSHhEF0P94MTcVN/cspaas2l3Xeb0W0MUxiZ1zL7C269p0zl6Rqv51Nu5iK@lists.openembedded.org
X-Gm-Message-State: AOJu0YyzbffJ3jS8SkEWtXDArKivLpT9LqD0fjc+L3scsvNur3vel0l9
	04VVFhtzQxtDVn/pFlUTkfS2p/TrqL6S4LgkV/NkON93CBcS9hNPTsy+tSCtwMQ=
X-Gm-Gg: ASbGncs/74VN04O5L7ZNkqksR2ex2QkQl5BXlFP/k19Is099VvFSNHmcYzNjKzaEqWp
	MGBrOPaR0D21pgAOb0DQn+MW4cUyNFwhMUe30f1xkVKCUD7VMG1B1Vof7MVH2dXFV8Ux80r+SrU
	vQj5pxwMTHhxgwcFydkGjld5CJ051Pg+cXuTN402Ogtu8xRZQheRQiJ1fYQNRg4ZONpPUGL4kCb
	mc9W0Dix7AFebha5CDcp8k6FjIGh2CrwbSyEUdwIHkeFsXQvBs/bdDkBy4AhFuutlJ9vckudbBF
	BRtbucZE6SiOMJ3hRTG2PMbXTmmfndwcFM1XH0/576iaWY2E3RyoKSBWIS1aMzZe+1umf/DpnwT
	tUnvUnB7n/HIPetJKbZb/EkFBvl8/bJR14w==
X-Google-Smtp-Source: AGHT+IGu5sQB142bb4FVv1jMPX4ugMazHcd6+SnWQ467CutqPqZZInXjl7ylhP8pInyAovrcy+8buw==
X-Received: by 2002:a5d:5989:0:b0:38f:39e5:6b5d with SMTP id ffacd0b85a97d-3997f938670mr17356143f8f.44.1742943581555;
        Tue, 25 Mar 2025 15:59:41 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:367a:5014:d4b0:4e9f? ([2001:8b0:aba:5f3c:367a:5014:d4b0:4e9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceb780sm167500235e9.4.2025.03.25.15.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:59:40 -0700 (PDT)
Message-ID: <dcec82f72742c4ff71779e28a2c7b72d343af864.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 2/6] fetch2/wget: use long arguments
 for clarity
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ross.burton@arm.com, bitbake-devel@lists.openembedded.org
Date: Tue, 25 Mar 2025 22:59:39 +0000
In-Reply-To: <20250325122441.2521891-2-ross.burton@arm.com>
References: <20250325122441.2521891-1-ross.burton@arm.com>
	 <20250325122441.2521891-2-ross.burton@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 22:59:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17494

On Tue, 2025-03-25 at 12:24 +0000, Ross Burton via lists.openembedded.org w=
rote:
> @@ -106,7 +106,7 @@ class Wget(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dldir =3D os.path.realpa=
th(d.getVar("DL_DIR"))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localpath =3D os.path.jo=
in(dldir, ud.localfile) + ".tmp"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.utils.mkdirhier(os.pa=
th.dirname(localpath))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd +=3D " -O %s" % shle=
x.quote(localpath)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetchcmd +=3D " --output-docu=
ment-%s" % shlex.quote(localpath)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.user and ud.pswd:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
fetchcmd +=3D " --auth-no-challenge"

I think the typo above proves why sometimes making improvements like
this needs to be carefully balanced.

This broke the builds on the autobuilder in obscure ways...

Cheers,

Richard

