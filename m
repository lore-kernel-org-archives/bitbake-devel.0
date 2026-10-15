Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC57CC6B34
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 13:04:39 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39197.1792069474667998889
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Oct 2026 06:04:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dQzDeJbz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c6955a7c3so1526662f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792069473; x=1792674273; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/lbO53gvSfcIJmChAGmcErgCV/AlUPsvGTo6k6F712o=;
        b=dQzDeJbztYP4xXVZlZcaI1v6taTEuHX5WKAXe8RYGuNkK+Jt35eqmkNIt/BY1tmb5M
         ZgWYzPzWqvp9tVzBA77n8nfwdI4R+KIrf7Ov35E1kVWPPrTijuQYbatxkZJSV15M5wCt
         ffXxNRmOEAkxpniaL8hsfqINyD2oxC18bN80M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069473; x=1792674273;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lbO53gvSfcIJmChAGmcErgCV/AlUPsvGTo6k6F712o=;
        b=WXa11VCJvUv5d9qrDz51JuiIocl2hPFRE0alQqfVHbLgM1FdsaXGReqHxnCmiTMk+X
         tK3At58qjEG7aKk1PIvauJemiblyGT3L1WpUS9ZNgEKj40zJh9s7orAeiDniKLF2bSLt
         O+9a/WocO6t1TAZnr0/cPHng4oCCZ/p2JQGkCvnTClAv/0xh9nK/PBL4kbNtJukiiIiw
         +HGmH3hpJtvJG75EtWEMDgR0yhwZWf6apAnXngaUatSN9sAGlfOb0YJYmmLwsVLByLmC
         WVKPY9meOGTt8/MaUejzqsEA40vFt8RmqodPvyldtC5yHJr/siqvP20t8K/1ArueBM9J
         Ya+g==
X-Forwarded-Encrypted: i=1; AKwUvBzUWnxYaUtwRt36eg2Kn+xWSJ0npSUovhGsyZhJj4ST8MKbI9C3xiX9k8sRfIE/+uTQfkmiE58S+WN4vhDj@lists.openembedded.org
X-Gm-Message-State: AFq9FYJBpeJitPpPVhph575QT3JXf8Cm2gtwRIgjdH6sWOX1hR3FHaZj
	TtfZwSwefaW1YtkcX3gY3yI0ShzBHw4Oi1c8r38BNFbxyqKCSey+U1LZYhb4Vjbm8Vk=
X-Gm-Gg: AYBFou3kGf9uKJE1Ta55YNvtOrqqZVSQNMhlY+z1FmezG7sJUTC1pNpHRU8u/PDZKzl
	hc43erOdyPNzRvR4XXjBJdxrsqG5UV9FVaX8aMcU3BC01nS7ksczCZW1G5x4f3e+mO9XZOV0xYi
	L62Ao9Pz+DmkqlHZJvsRsPw8Sqaozzpvim1DFFnz1Co0JVn3CPXaTMDyeW8VDoJvXxXOLsTaO7O
	JBUxPEdXWJDlk9vCrdRubEdj1mx1zxihJNXpEQQkZHi43Dq+6pCL99J9qkuVSYPLHi3RGv5kI3r
	YVZOQxoxUXp/XLlRfKezEBAoczPhXFJYPR+nH2u9LxfcMjoFcfPhm2pTRRchEFp9aA2YZhT1/0t
	0WD/z+tky0k2SjkJ9ZHIMFlO9zsiQi4xbBr9TPrRJ8vJzU+1A8By8hhnVhT0IIaznQAiCPJjeId
	zdJUtJFQoAPYnaQYI6kz29EPO/7CJuHIwJKhtUPJRRVAJKxO4dPC19/maIlLkwh14UifU5XK2e5
	tqDrblL3dQqCzEcZP36FCfXC7h5bsC0kXGsdoGjJ7xt+/N+EIvoXFjUX/4xPgs=
X-Received: by 2002:a05:6000:1788:b0:48d:dc6f:219a with SMTP id ffacd0b85a97d-48ddc6f2463mr24177672f8f.27.1792069472599;
        Thu, 15 Oct 2026 06:04:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8627:1727:8a8a:57f5? ([2001:8b0:aba:5f3c:8627:1727:8a8a:57f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967a0dsm18439287f8f.3.2026.10.15.06.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:04:31 -0700 (PDT)
Message-ID: <7dbc1fbb0314b61bbc2913aa004f8ebfd968cc03.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH 3/4] knotty: convert warnings to
 errors when -W is passed
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Antonin Godard <antonin.godard@bootlin.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	docs@lists.yoctoproject.org, Ross Burton <ross.burton@arm.com>
Date: Thu, 15 Oct 2026 14:04:30 +0100
In-Reply-To: <DM5EQUZ5TIGZ.1KG28FB6KB03G@bootlin.com>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
	 <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
	 <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org>
	 <DM5C7YSFK5Y8.14E684HX5TS18@bootlin.com>
	 <6563fc5659f06a1a6b1eb72ec05b9109dfe9f64a.camel@linuxfoundation.org>
	 <DM5EQUZ5TIGZ.1KG28FB6KB03G@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 13:04:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20347

On Thu, 2026-10-15 at 14:23 +0200, Antonin Godard wrote:
> On Thu Oct 15, 2026 at 1:49 PM CEST, Richard Purdie wrote:
> > On Thu, 2026-10-15 at 12:25 +0200, Antonin Godard wrote:
> > > On Thu Oct 15, 2026 at 10:58 AM CEST, Richard Purdie via lists.yoctop=
roject.org wrote:
> > > > On Tue, 2026-10-13 at 14:13 +0200, Antonin Godard via lists.openemb=
edded.org wrote:
> > > > > When -W is passed, modify the handlers to show warnings in red an=
d set
> > > > > the return value to 1. Add a summary line informing the user that=
 the -W
> > > > > option was used as it might not be obvious when looking at the bo=
ttom
> > > > > the end of the console log.
> > > >=20
> > > > The trouble is this doesn't make warnings behave exactly as errors =
and
> > > > I think that is going to confuse people :/.
> > > >=20
> > > > Specifically, if an error is encountered in a task, it will error a=
nd
> > > > fail. The warning will show an error but continue anyway. I also
> > > > suspect the warnings will still show as warnings in the log files a=
nd
> > > > only appear as errors on the console.
> > >=20
> > > Good point. So there's two directions this could take (if we want tha=
t feature):
> > >=20
> > > - Make this option change the behavior of warnings, and make them _ac=
t_ (not
> > > =C2=A0 just look) like errors, so a given task would stop in case of =
warning.
> > >=20
> > > - Rename the option and make it clearer: warnings are still warnings =
but the
> > > =C2=A0 return code will be 1 if there are any.
> > >=20
> > > =C2=A0 Maybe "-W,--fail-on-warnings: Make bitbake return 1 if any war=
ning is
> > > =C2=A0 emitted"?
> > >=20
> > > I feel like the second option might be best as the first one is chang=
ing the
> > > behavior of tasks and I also think this might not be desirable.
> > >=20
> > > With the second option it allows having a positive exit code on warni=
ngs while
> > > still being able to have a look at all of them (not only the single o=
ne that
> > > stopped the build as would happen with the first option), just as you=
 would with
> > > a normal bitbake execution.
> >=20
> > I think we need to see if there are others wanting this feature or not.
> > I think with new option additions like this, we need to see a clear
> > demand from the userbase for it. That feedback may also make it clearer
> > which behaviour people would want.
>=20
> Ross (copied here) was talking about it on IRC[1]. Hard to say which way =
or the
> other was desired from this conversation though. It did give me the idea =
to
> contribute this feature as I also need it sometimes.
>=20
> I personally have seen multiple projects where builds started in CI envir=
onments
> needed to stop when warnings are emitted. I'm happy to keep my scripts as=
 they
> are but I thought this series would make things a bit easier for users.

Do you really want to "stop" on warnings though? Usually you want a
list of *all* the warnings, not just the first one. You probably do
want to continue through all the rest of the tasks too.



That makes it sound like you want to just change the exit code, which
is a bit of a different discussion...

Cheers,

Richard

