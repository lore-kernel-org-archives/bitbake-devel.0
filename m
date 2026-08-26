Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9F7C5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:05:55 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21245.1787774752720653873
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Aug 2026 13:05:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=T1TdbIrF;
 spf=pass (domain: gmail.com, ip: 209.85.128.176, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-855c26cf490so15514457b3.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 13:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787774752; cv=none;
        d=google.com; s=arc-20260327;
        b=m0I38Ji7SdMzMnC19SPFO/M9Hs7esSy6Cgqb5s1lIDa2veYOElFFmbDvAjPgbSEN9a
         /nXsVcjfK6MOhpZ3dSlm8xBUt9TWRJZY6HGBMh8lAFMrd9VYXFWGJzn/AP52jIlPxdhC
         TLaFYEU2HqxS9E2GZ+T7UYdXhF4arBamj3CP1UayevR1y2SJCLaT8Mvzy2MGsNNbxrVE
         Jl7jv9uFH3lEMTykeYwKlqQU67cRucxvpYfFi2sPn22h8VWoG2VgGBbeVuaihPcyNCky
         oWzKjv/Zm8/pU/C++x6/+qhYsL3PQ6eR9fQ1SZw6JRZKTkKcxjh2I5iAbybGU56x4Kgs
         +yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N0WSH1a5sxPY6IzStem1iivvwwpugZSzGeH+XyiVuMg=;
        fh=Ba+/dzH5NL8AUm91fhgpMkjNnMNLHS/w2isJVJ+9V3o=;
        b=QTIJiVruHv0E+J9ZWP5suBon9i1FoBXQc9ObuTmrlnRYnLP8PpN+KX5xfEcwLYqsDd
         mr6FOZRIxnDaSuEBPE0CjNhCUHp7HhmsmfsvssLtwjmwtWi++IqeEtVf7IqwpJIPQ8nh
         8NG6U3XEbo5kfHqM+MVrHUPB1RnySCufbsc6Ou4oMEzli9/LgyfYXutGX8v7DyL8kuTc
         eSLGVlQn6k7ducIVKAZ/B5EKAz8GAKGHlMP9OCXV1FLd3nH39AK9sPaYBqmt7qEjje+B
         a+GuvZWY4lhuaEiAR0oJHp8/hd69oOIsyqnwXnOVgJqFcI3xzQIZITQZhYqPAQEOIMSF
         tSKg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787774752; x=1788379552; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0WSH1a5sxPY6IzStem1iivvwwpugZSzGeH+XyiVuMg=;
        b=T1TdbIrF5Dt09ClI0DjTDnPiAeg8y2x3YW4dP0pmUbcbcHbYhi+3zxN7q4gEquJMWt
         xvU2rJu7o/oiGrdNXsFMLd35ZvOsJH9FYS2QkeY6+EDuO2GBowLIeCS79C3CKVnUoD1F
         N7j//hxOjOu+ma7g+Noz0Ve1eBvp34eklAkANuSj45zbbvmZodO1hxWYXmGPl7wmLCp8
         heyxSObau1u1OTrb8vDrFUH9cHrlQX6WCGzoXYGdmXwTW6SO6Vk99mj3pG+EI78Jfzyv
         Y4NeNRE58I4ckfQIDysonz6q3qZIxg6GUNrjoAzCe7yEuD9MUsRZholkJrmpwB23nRKs
         09MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787774752; x=1788379552;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N0WSH1a5sxPY6IzStem1iivvwwpugZSzGeH+XyiVuMg=;
        b=M72hJZXq7QHscQcCeuxnG9fqPzRxZfRV/2kR7kVXOnB8YI3or4HRtlQtP6IYTHG6EG
         pw1t2BxAEKsXuylOT5G7zQosErhYHKPjjxZ1NNdHms2PXmJ8EoP/U8rhUIenO1VCjLbo
         Qgds54T2NnGpq/KdWPzlpAcaEtWlifMUj45KtPCYS1gpgWqEjC5FEzA41gwpz/q5hwFx
         oM22b6v39TSQhhNbfP9PdOgeiRtI3JxdzjIlN/b2Y0bPv1Jf9LEdjA1x0y/gGfYFYrU0
         W9gScmMO4u+qdINCB4WypAHoF226N9iAA3v5kWmwvnBVbhwRQ+Ltou46GPiJG3KatdX0
         BKeA==
X-Gm-Message-State: AFuF++mDCCfVB8N0fa4+vH47XQvqNGJJ/AGIQpiAfbh15GjVAwGnBH90
	RMc4bStYcZa2IyEBI7zkPKHP1i9CaFqWBtFUepEi0nR+3tDZv+eXIvGT7+8l7l1NlwdUAWiiqGk
	SmgZRwlj2Oe2P7MHbdNtqYgelfvgmvqotTg==
X-Gm-Gg: AR+sD10/8X59B4UXjhPLmYZcme/gkTXNdNCTUM+oSjd5AOB5JSO/F2hfHdH4441zwOk
	+Vh1a9HW515VE0dkj/2TIOdd11hgW9dJSEDYxj7foU3RH4/KkBJYG3EmQy3FoppUDsxILrfmahy
	MwAygwflWDFLHErsfQQ5eIIwcMy26tsFjXWM+wqXIOtpPHIiW82nklA3717/OGOEPwUdEELh0xD
	ec0KNhWXgnjr4SSEDPgNM11D/oFeQ/W4H+u6CE3gRyF0woLpyIw0mMqkXVN7Gxr8y/vawtUQzIr
	pSicaqVlSeuW5q/eUa0W5l9o7cBtG0ZmHuRKgZ7piRZLt9jUcOrui+8tSjI=
X-Received: by 2002:a05:690c:ec2:b0:80c:2874:67c6 with SMTP id
 00721157ae682-857400b3834mr40887537b3.24.1787774751511; Wed, 26 Aug 2026
 13:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
 <20260730183254.793698-1-JPEWhacker@gmail.com> <1147544.1785503145144982751@lists.openembedded.org>
In-Reply-To: <1147544.1785503145144982751@lists.openembedded.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 26 Aug 2026 14:05:40 -0600
X-Gm-Features: AcwNN1V1R95BDtr4cfNMwZ1I-QF5qoPx_BO36SIGm435NhQ7j47Z3on4L5z3Umk
Message-ID: <CAJdd5Ga8omZNt_KBBrrLvLhhUYgBa7ptq20vcd3zNX+ZpNiJAw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 00/10] hashserv: Pipeline Upstream Queries
To: michalwsieron@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000009bdd0659f8bf50"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 20:05:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20061

--000000000000009bdd0659f8bf50
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Michal,

Any chance you've had time to look at this more? I've been unable to
reproduce this particular issue. It looks like the server is just crashing
or stuck somewhere where it's no longer responding, but I can't quite
figure out where that might be occurring.

Thanks,
Joshua Watt

On Fri, Jul 31, 2026 at 7:05=E2=80=AFAM Michal Sieron via lists.openembedde=
d.org
<michalwsieron=3Dgmail.com@lists.openembedded.org> wrote:

> Hi,
>
> something is not working for me...
>
> In the first run I got it stuck for an hour at:
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 192
> messages but only received 49
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 115
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 115
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 165
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 9
> messages but only received 4
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 99
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 15
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 9
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 1
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 4
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 47
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 1
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 116
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 112
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 117
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 277
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 66
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 72
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 157
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 45
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 52
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 75
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 18
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 10
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 98
> messages but only received 0
> Initialising tasks:  44%
> |##########################################################
>                                                           | ETA:  1:03:30
>
> Then in another run, after reporting that 8 messages were sent, but 0
> received, hashserve.sock disappeared!
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 8
> messages but only received 0
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: [Errno 2] No
> such file or directory
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: [Errno 2] No
> such file or directory
> WARNING: Error contacting Hash Equivalence Server
> unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: [Errno 2] No
> such file or directory
> Although that might be a different issue after killing previous run and
> not making sure all Cooker processes are actually dead?
>
> Anyway, after properly making sure there are no lingering processes, I am
> still getting stuck at:
> WARNING: [...] Sent 192 messages but only received 26
> WARNING: [...] Sent 115 messages but only received 0
> WARNING: [...] Sent 115 messages but only received 0
> WARNING: [...] Sent 165 messages but only received 0
> WARNING: [...] Sent 9 messages but only received 1
>
> I will be going on vacation now, so unfortunately, I won't be able to tes=
t
> more if you come up with anything new.
>
> Best regards,
> Michal
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19895):
> https://lists.openembedded.org/g/bitbake-devel/message/19895
> Mute This Topic: https://lists.openembedded.org/mt/120523853/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> JPEWhacker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000009bdd0659f8bf50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Michal,</div><div><br></div><div>Any chance you&#39;v=
e had time to look at this more? I&#39;ve been unable to reproduce this par=
ticular issue. It looks like the server is just crashing or stuck somewhere=
 where it&#39;s no longer responding, but I can&#39;t quite figure out wher=
e that might be occurring.</div><div><br></div><div>Thanks,</div><div>Joshu=
a Watt</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Jul 31, 2026 at 7:05=E2=80=AFAM Micha=
l Sieron via <a href=3D"http://lists.openembedded.org">lists.openembedded.o=
rg</a> &lt;michalwsieron=3D<a href=3D"mailto:gmail.com@lists.openembedded.o=
rg">gmail.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div>Hi,</div>
<div>=C2=A0</div>
<div>something is not working for me...</div>
<div>=C2=A0</div>
<div>In the first run I got it stuck for an hour at:</div>
<div>WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/w=
orkdir/builds/yoctobuild/hashserve.sock: Sent 192 messages but only receive=
d 49<br>WARNING: Error contacting Hash Equivalence Server unix:///path/to/m=
y/workdir/builds/yoctobuild/hashserve.sock: Sent 115 messages but only rece=
ived 0<br>WARNING: Error contacting Hash Equivalence Server unix:///path/to=
/my/workdir/builds/yoctobuild/hashserve.sock: Sent 115 messages but only re=
ceived 0<br>WARNING: Error contacting Hash Equivalence Server unix:///path/=
to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 165 messages but only =
received 0<br>WARNING: Error contacting Hash Equivalence Server unix:///pat=
h/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 9 messages but only =
received 4<br>WARNING: Error contacting Hash Equivalence Server unix:///pat=
h/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 99 messages but only=
 received 0<br>WARNING: Error contacting Hash Equivalence Server unix:///pa=
th/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 15 messages but onl=
y received 0<br>WARNING: Error contacting Hash Equivalence Server unix:///p=
ath/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 9 messages but onl=
y received 0<br>WARNING: Error contacting Hash Equivalence Server unix:///p=
ath/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 1 messages but onl=
y received 0<br>WARNING: Error contacting Hash Equivalence Server unix:///p=
ath/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 4 messages but onl=
y received 0<br>WARNING: Error contacting Hash Equivalence Server unix:///p=
ath/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 47 messages but on=
ly received 0<br>WARNING: Error contacting Hash Equivalence Server unix:///=
path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 1 messages but on=
ly received 0<br>WARNING: Error contacting Hash Equivalence Server unix:///=
path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 116 messages but =
only received 0<br>WARNING: Error contacting Hash Equivalence Server unix:/=
//path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 112 messages bu=
t only received 0<br>WARNING: Error contacting Hash Equivalence Server unix=
:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 117 messages =
but only received 0<br>WARNING: Error contacting Hash Equivalence Server un=
ix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 277 message=
s but only received 0<br>WARNING: Error contacting Hash Equivalence Server =
unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 66 messag=
es but only received 0<br>WARNING: Error contacting Hash Equivalence Server=
 unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 72 messa=
ges but only received 0<br>WARNING: Error contacting Hash Equivalence Serve=
r unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 157 mes=
sages but only received 0<br>WARNING: Error contacting Hash Equivalence Ser=
ver unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 45 me=
ssages but only received 0<br>WARNING: Error contacting Hash Equivalence Se=
rver unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 52 m=
essages but only received 0<br>WARNING: Error contacting Hash Equivalence S=
erver unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 75 =
messages but only received 0<br>WARNING: Error contacting Hash Equivalence =
Server unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 18=
 messages but only received 0<br>WARNING: Error contacting Hash Equivalence=
 Server unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent 1=
0 messages but only received 0<br>WARNING: Error contacting Hash Equivalenc=
e Server unix:///path/to/my/workdir/builds/yoctobuild/hashserve.sock: Sent =
98 messages but only received 0<br>Initialising tasks: =C2=A044% |#########=
################################################# =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | ETA: =C2=A01:03:30</div>
<div>=C2=A0</div>
<div>Then in another run, after reporting that 8 messages were sent, but 0 =
received, hashserve.sock disappeared!</div>
<div>WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/w=
orkdir/builds/yoctobuild/hashserve.sock: Sent 8 messages but only received =
0<br>WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/w=
orkdir/builds/yoctobuild/hashserve.sock: [Errno 2] No such file or director=
y<br>WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/w=
orkdir/builds/yoctobuild/hashserve.sock: [Errno 2] No such file or director=
y</div>
<div>WARNING: Error contacting Hash Equivalence Server unix:///path/to/my/w=
orkdir/builds/yoctobuild/hashserve.sock: [Errno 2] No such file or director=
y</div>
<div>Although that might be a different issue after killing previous run an=
d not making sure all Cooker processes are actually dead?</div>
<div>=C2=A0</div>
<div>Anyway, after properly making sure there are no lingering processes, I=
 am still getting stuck at:</div>
<div>WARNING: [...] Sent 192 messages but only received 26<br>WARNING: [...=
] Sent 115 messages but only received 0</div>
<div>WARNING: [...] Sent 115 messages but only received 0</div>
<div>WARNING: [...] Sent 165 messages but only received 0</div>
<div>WARNING: [...] Sent 9 messages but only received 1</div>
<div>=C2=A0</div>
<div>I will be going on vacation now, so unfortunately, I won&#39;t be able=
 to test more if you come up with anything new.</div>
<div>=C2=A0</div>
<div>Best regards,</div>
<div>Michal</div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19895): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19895" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19895</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/120523853/361=
6693" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/120523853/3616693</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:JPEWhacker@gmail.com" target=3D"_b=
lank">JPEWhacker@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000009bdd0659f8bf50--

