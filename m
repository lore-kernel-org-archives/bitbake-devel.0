Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC91C79FB6
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 16:30:52 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16803.1788971449644240429
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2026 09:30:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VFCI5Zzo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-482e257a23aso4139275f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788971448; x=1789576248; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fZrrYRvAtUWiHF5ndB/1cXP/qnd54P8nPVBqcRBhnn8=;
        b=VFCI5ZzoDqWrqVxnZhp2uXjNMm/6zgT1VKI++1C2X9f9rc+SL/hLgPxm9LM0BhR+vr
         cHX9lIvfy/muXD1ldkZLdwWv3UYAJDm2R0b2gmYJdcX1b3JTNlhED04XGe4+I2rFVwkA
         41VBap0z8Cr51ZVv1gU2md41UTDQhICgaLUFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788971448; x=1789576248;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fZrrYRvAtUWiHF5ndB/1cXP/qnd54P8nPVBqcRBhnn8=;
        b=KfZOvj1fh4YQlMKwF6wn6FumlICyr62FLuGy6m0Quczyee4KRKKGX8cCtQvl9JXh73
         gtHuglwDR4UB6q+a26hz7Uk4JLBL5DT4p0llMNi96jqItf6Fpu+24gRvPI28zmpeXCAk
         WzCcBTH7rUeorCViWCrz82LpVzs6f+YMPU/S1uJgxRCT43p6fA8LdWXJIdGR1gc+ATFV
         SRgUkqRuL0hG2oqWUmutU3Xe/H+3Rttwwd0u0hUcGo3rtcR5LzO9IJqE+LZGan426878
         UljHf9GC44lonApqzolOrYsPz7FNIETCGvxQn6DEkTXzj0ymkinvk0q2nJu3semTa6Js
         78pQ==
X-Gm-Message-State: AFuF++kX/yqDEl68M5Q+WuqRGaw/7kJxZRzff8/xHJpX6nqjJvvMzm/r
	rAeVlh9FB8Xf6PJ83A0yVMUJuGnzRi42EIdCOMJyXwCshTHp1xXbMX3h7sXF2hitCfI=
X-Gm-Gg: AYBFou2wtbm3J4XBGjSjZbcxN5z4M1XsUDZlzfTLGKkv2P7ezHpewS+jSIBJyOUKYD6
	ajryAenGuqbMgMECfG1I5mWU1oNijTB6mOs38iGIK+J8AAixghWnjlIEdNZi5Mki4KvQf3rYi6X
	LHFF2ph/JbVBljgEC1MnGJ0ADF4YQbpq/g+d9eqVHZYNwS3Gj9xpE3r4M48hluf3CM5nszv4XzJ
	VUFZrfFmZSqdjOV8eiwbil+g5NJ5esv9hSS6AgXMTP5v8IFXt97tmJmQbhXKsuRJSaUBWxTuK1L
	Lbyd+rA+zVT+Tz+LARmo9l1SKhZEYbnBbcyDIDNEg6ang2o5Lq9qD0NYR55e2oloDqyT4AW/DbZ
	OKqrITgpVechce9j6B2yRAbpuKj3WlEiIJWrrgc39nmzhMf9zuhML/Uz0nwgrf9x/iIhGQOXzoX
	0IW1YNtEJ8XAYn3/FICeKzFm6RD/bQdR1ejF20YchNjXYTsFgc0pSyILnTI+aUHm5lydek77OWd
	Xb24A20fYy/VtyFuIcasnnQZfxFqVD96EsBYVJHv4WWUhJGRxNH00ONxecBWRXGw5Po78wvrg==
X-Received: by 2002:a05:6000:2885:b0:485:ac55:dca1 with SMTP id ffacd0b85a97d-485ac55dddamr6042280f8f.50.1788971447463;
        Wed, 09 Sep 2026 09:30:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a320:8b5c:de4:61f9? ([2001:8b0:aba:5f3c:a320:8b5c:de4:61f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485aa2c9acasm9259630f8f.36.2026.09.09.09.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 09:30:45 -0700 (PDT)
Message-ID: <be7db34b8490d72d362af3eb7b82cc43b086ea4f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH RFC 0/2] bitbake: Add basic landlock
 support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: David =?ISO-8859-1?Q?Nystr=F6m?= <david.nystrom@est.tech>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 09 Sep 2026 17:30:43 +0100
In-Reply-To: <9c697498-9771-31c3-667c-32a038e3d8ed@est.tech>
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
	 <a4ad8dcdef504155bebebe81125b68bb66692c2e.camel@linuxfoundation.org>
	 <9c697498-9771-31c3-667c-32a038e3d8ed@est.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 16:30:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20177

Hi David,

On Thu, 2026-07-16 at 17:50 +0200, David Nystr=C3=B6m wrote:
> On Thu, 16 Jul 2026, Richard Purdie wrote:
> > On Fri, 2026-06-12 at 13:38 +0200, David Nystr=C3=B6m via lists.openemb=
edded.org wrote:
> > > When current implementation runs in an unprivileged docker container,
> > > basic networking will be allowed by default in all steps, ignoring th=
e
> > > network varflags intention.
> > > Introduce support for landlock blocking of bind and connect, providin=
g
> > > basic support for blocking TCP.
> > > UDP is corrently beeing worked on upstream, but not yet supported.
> > >=20
> > > Landlock requires PR_SET_NO_NEW_PRIVS to prevent escape,
> > > which is also attempted, this prevents privilege escalation from chil=
d.
> > > devshell and related are already tagged with network varflag and
> > > can sudo at will.
> > >=20
> > > syscall ABI is asm-generic, 5.13+ for all archs except alpha.
> > > On alpha, we leak 2 fd:s in the childs context before graceful exit,
> > > which is cleaned up at child termination.
> > > Don't have an alpha target, so this is not tested, evaluated via
> > > static analysis only.
> > >=20
> > > Landlock also provides a future possibility for filesystem
> > > limitations with the purpose of catching bugs, and preventing
> > > persistance of supply chain releated payloads. writes to f.ex.
> > > .bashrc and friends.
> > >=20
> > > Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
> > > ---
> > > David Nystr=C3=B6m (2):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 utils: Add landlock_restrict_network f=
unction
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitbake-worker: Call landlock_restrict=
_network for tasks without network
> > >=20
> > > =C2=A0bin/bitbake-worker |=C2=A0 2 ++
> > > =C2=A0lib/bb/utils.py=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++++++=
++
> > > =C2=A02 files changed, 28 insertions(+)
> >=20
> > I think this has generally has positive comments, we just need to take
> > Paul's review comments into account about the magic numbers. Would you
> > be able to send a version with those tweaks?
>=20
> Yes, thanks for the review, and sorry for the late reply.
> Will reroll with comments.

These still are in the queue and desired, do you think you'll get a
chance to look at them?

Cheers,

Richard

