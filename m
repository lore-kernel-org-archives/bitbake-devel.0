Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0B7C83F14
	for <webhook@archiver.kernel.org>; Thu, 29 Aug 2024 12:42:34 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.12930.1724935351412615286
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Aug 2024 05:42:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UctxQ5z+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bb885f97eso1764515e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Aug 2024 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724935350; x=1725540150; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qi2Gg8YJObu+l/aVcCO3bv+ZdbO7e4rSZcudCNStPc=;
        b=UctxQ5z+KV5G2NAL9SvIc442h62IWRPeO4rbDFDTWsmXEG9vY2Ymfw1jsK13sCylkX
         jsDxiw+ktekvJ8OQAhVLwRr7wtH4noSabANkQJZhQGUWTtBQhxZ2RBP//tVjbei5DhM9
         8jasPi6DHCmdYY6Hxwz3S6cwvaT1PH121jCS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935350; x=1725540150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Qi2Gg8YJObu+l/aVcCO3bv+ZdbO7e4rSZcudCNStPc=;
        b=Xq/fVc+iStpHypBIfnJt2AwMqBVyT+O32XabZm0Y2DgHS5p5u5AgFbq4g2jxZjAqq7
         JnzgR4Np1xnTXpFcHmfCM4Jw8fQZ30Rt8wIVDu1MtH2gqnzqUoKF2Zad9IdkJHa6In8K
         OCPGBXDDKkILK71Rs6V7BM8IWMUflR3ZOKhYf3mv7qNrmCZsHuSYkiJtkw9VDwY3v6nW
         k0VzZ3quxzDSvJxfw1fVx826CPRZmpQp2rIFMPeCOnvUwUi4tWE9IuNUUnc6rF+IeEXx
         u+E/FkOi6HJsS5wA/XnSA29dTB4HHzWH8rNzW4q9rTjZ5d6Rzzelon/3AWw4F6KebRAJ
         KDwg==
X-Forwarded-Encrypted: i=1; AJvYcCWCIjcZUiaCEn2GZaag8BaI+M9w3btsw0KRo9Fkq0Zj9M88nYjqOJswP4b6W+UHYLs88oHg+Dd7ZJtNKZDg@lists.openembedded.org
X-Gm-Message-State: AOJu0YzCpL/OD1dCoo0i38Ixvd/L8pPIuLWFw00dbGjYqhFeeF//r/m6
	4rZ1044COwp3NtWkrfs/sI121ZmzojrXgamxQbzLqB+/w7JtVhIS/rMQFuZbEIc=
X-Google-Smtp-Source: AGHT+IE81DBQGcKUHQ/44PIUPXTbJQvNRvFz3e+chqbjycuJLDWrZjk74vKZIAsFcbmp9IWxAnv8Qg==
X-Received: by 2002:a05:600c:4447:b0:42a:a6dc:3083 with SMTP id 5b1f17b1804b1-42bb744e377mr13311395e9.13.1724935349663;
        Thu, 29 Aug 2024 05:42:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:19db:d42a:7902:cfcf? ([2001:8b0:aba:5f3c:19db:d42a:7902:cfcf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee94265sm1331340f8f.47.2024.08.29.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:42:29 -0700 (PDT)
Message-ID: <083be01b5a70c46bedcdfca1c403c87b18299bf1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][kirkstone][2.0] Appends discarded by
 expandVarref
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: adam.blank.g@gmail.com, bitbake-devel@lists.openembedded.org
Date: Thu, 29 Aug 2024 13:42:28 +0100
In-Reply-To: <zAtt.1724925180061037156.a5Q8@lists.openembedded.org>
References: <zAtt.1724925180061037156.a5Q8@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Aug 2024 12:42:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16529

On Thu, 2024-08-29 at 02:53 -0700, Adam Blank via lists.openembedded.org wr=
ote:
> expandVarref is called during the parsing stage, to expand special purpos=
e variables, in my case LAYERDIR.
> Internally it calls setVar without letting it know that parsing is True, =
which removes any possible appends for the variable being processed by it.
> This has interesting side effects - I doubt they were intended, but fixin=
g it shows how rife they are.
> =C2=A0
> 1. Real life example for BBMASK
> =C2=A0 =C2=A0 - BBMASK:append:qemuarm64 =3D " meta-foo/recipes-bar"
> =C2=A0 =C2=A0 - BBMASK +=3D "${LAYERDIR}/recipes-kernel/linux/linux-yocto=
_5.15.bbappend"
> =C2=A0 =C2=A0
> =C2=A0 =C2=A0 When this is parsed in layer.conf, OVERRIDES have not been =
appended with 'qemuarm64' yet.
> =C2=A0 =C2=A0 Before the change (self.setVar(key, referrervalue.replace(r=
ef, value))):
> =C2=A0 =C2=A0 =C2=A0 The call to expandVarref ends up setting BBMASK to s=
ome appended value with LAYERDIR expanded, but removing the conditional app=
end for qemuarm64.
> =C2=A0 =C2=A0 =C2=A0 The qemuarm64 append although perfectly good syntax-=
wise, is never applied.
> =C2=A0 =C2=A0 After the change (self.setVar(key, referrervalue.replace(re=
f, value), parsing=3DTrue)):
> =C2=A0 =C2=A0 =C2=A0 The call to expandVarref ends up setting BBMASK to s=
ome appended value with LAYERDIR expanded, the conditional append for qemua=
rm64 remains in place.
> =C2=A0 =C2=A0 =C2=A0 As soon as the OVERRIDES start containing 'qemuarm64=
', the conditional append also starts being considered - as intended.
> 2. Real life example for BBFILES
> =C2=A0 =C2=A0 - BBFILES:append =3D " ${LAYERDIR}/recipes-core/wpa-supplic=
ant/wpa-supplicant_%.bbappend"
> =C2=A0 =C2=A0
> =C2=A0 =C2=A0 Before the change (self.setVar(key, referrervalue.replace(r=
ef, value))):
> =C2=A0 =C2=A0 =C2=A0 The call to expandVarref ends up setting BBFILES to =
some appended value with LAYERDIR expanded, but removing the append.
> =C2=A0 =C2=A0 =C2=A0 This time the effect is exactly as the author intend=
ed, but only accidentally - contrary to what the syntax would suggest.
> =C2=A0 =C2=A0 After the change (self.setVar(key, referrervalue.replace(re=
f, value), parsing=3DTrue)):
> =C2=A0 =C2=A0 =C2=A0 The call to expandVarref ends up setting BBFILES to =
some appended value with LAYERDIR expanded, the append remains in place.
> =C2=A0 =C2=A0 =C2=A0 For every subsequently parsed layer, the BBFILES end=
 up being appended with gibberish (based on its own LAYERDIR).
> =C2=A0 =C2=A0 =C2=A0 Definitely not intended by the author.
> =C2=A0 =C2=A0
> So now I'm wondering what the situation is really. Are the above just exa=
mples of bad style? Perhaps it would be worth it to extend the documentatio=
n for LAYERDIR type variables, to warn about their special handling?
> My hunch is that this is a defect (at least the fact, that expandVarref i=
s used truly during parsing, and setVar which it calls is not notified abou=
t it).
> It can be easily circumvented by a simple indirection, i.e. placing the e=
xpressions with LAYERDIR in them in a separate variable, and then referenci=
ng this variable. But this feels like a hack.
> =C2=A0
> Please let me know your opinions.

As you have realised, the way we expand LAYERDIR in layer.conf files
has drawbacks. Ideally we'd find a different mechanism to do it with
less side effects but nobody has been concerned enough to do that as
yet. It probably is worth opening a bug for the issue.

As you've noted, we can't just add the parsing parameter as that just
causes a different set of problems and you swap one set of problems for
another.

To fix it we really need to avoid expanding any variables at all and
just do a search/replace on the variable contents.

Or we drop this idea entirely and use a new convention for LAYERDIR,
maybe changing the name to be layer specific.

Cheers,

Richard

