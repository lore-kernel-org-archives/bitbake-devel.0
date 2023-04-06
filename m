Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA3C76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 15:39:46 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.161791.1680795584943634398
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 08:39:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20210112 header.b=kd7bilbs;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso25766229wms.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680795583; x=1683387583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fvZ0LtA1wmjFVHrBhUa7sdbU2yljbJ86M93Uv+8NV9A=;
        b=kd7bilbspR3O9SnW+LX5K2KjLEJjyUvGbK8BdU8ryz2jbhSWlmECvH01NTiuNm4/lp
         vSR9Clf/dU0AjULyQHJiZnNp/hfGq+GUWND4NdiiClhEesTEFsU3/arhibC3b2m1+jG3
         JgOgf5YdolCS0auXZJWS75xW2q3EGCKgF2hgHJFD8pmk1FhqtZ1zazLmW066Ba5SRupy
         SDaMnfmR5vCv/p8ZNUnuct8TMjLuSArwk8j8kd17dg1E3vzDSEqpJRS74q4CL6/0cbf5
         8ehns5AoW0u+B0KM/laf9SYY67Se5Hhef7zvGwWV7Nllo75puHKoalm3FhwrT+ItKPYp
         gxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680795583; x=1683387583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvZ0LtA1wmjFVHrBhUa7sdbU2yljbJ86M93Uv+8NV9A=;
        b=7IdTVSfgGCB5Tv3Xbll1zRmbF3PeCnbzcnYWLVSM2nskveDB5hhYywaJC8rrPP1305
         mZ+k4eZYpFczxNKCb+0XxCO1HpCcbZTUDCsK1KM1s7qsjqxPNJSKepnZD05SvUL/eRdN
         YWJlp/so+x+21BAl8DiW4KUx2L87WQiEBSc+UK+Hcc6jEH/hB2ld1GDyFLz3jE1WDRi/
         RGP5mYoTZtFOf079GSCuEwA2oxwqFhFX0gs6xmZVQNd0KyydS99JuBqvyKIDhvNW7C8B
         /2rBc6F407d50AI0Es0VXpPbI3QDgzEbTrx6gFLtKCTxkSHZmoPHYC4DO9Y/oj5nZDsJ
         vMew==
X-Gm-Message-State: AAQBX9eaEG+LVchZXYxLHiclmxt7qH+9hUWeJMwOBAhWhaABBIyI2gfz
	3vKQ4WE6wOofNBtP9zuBsW0PPtF1/KHl1iu+1zQ=
X-Google-Smtp-Source: AKy350at9E/IlfAnf6nShu06Syi3Ma57Xm6Wq3q94iOPPRARaO+4N6+S9YoxX5jQjPGzZq5+HXg9COug8Sbz1iJqi6k=
X-Received: by 2002:a1c:4c19:0:b0:3ed:e577:49e9 with SMTP id
 z25-20020a1c4c19000000b003ede57749e9mr2473845wmf.3.1680795583081; Thu, 06 Apr
 2023 08:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <3bdf71527c3afcae7cd303826a3b59a52e28cc96.camel@infinera.com>
In-Reply-To: <3bdf71527c3afcae7cd303826a3b59a52e28cc96.camel@infinera.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 6 Apr 2023 17:39:24 +0200
Message-ID: <CA+chaQfYR76=q44-5co7p56CNC7KBA=nQaAqh4nR=5wG4p5=tg@mail.gmail.com>
Subject: Re: [bitbake-devel] Kirkstone : vs _ bugs
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000ab6f9805f8acb7b3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 15:39:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14679

--000000000000ab6f9805f8acb7b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

See openembedded-core/scripts/contrib/convert-overrides.py script which
does most of the heavy lifting and there is a plenty of examples how to
update the layers.

> PREFERRED_VERSION:xyz =3D 1.2.3
> does not work in Kirkstone but works in Dunfell,

This is side effect of the bitbake change which replaces all ':' with "_"
as a way to allow using new syntax with older bitbake, but unfortunately it
replaces it everywhere (even where it shouldn't be used at all in first
place), that's why it works in dunfell with older bitbake while kirkstone
correctly refuses it.

See
https://git.openembedded.org/bitbake/commit/?h=3D1.46&id=3Da6d5fb7554e3cf07=
1e453db56a1e7469ac44277c

Regards,

On Thu, Apr 6, 2023 at 5:27=E2=80=AFPM Joakim Tjernlund <
Joakim.Tjernlund@infinera.com> wrote:

> Porting to Kirkstone I stumbled over this:
>   PREFERRED_VERSION:xyz =3D 1.2.3
> does not work in Kirkstone but works in Dunfell, need to replace : with _
>
>
> FILES_${PN} is silently ignored in Kirkstone, replacing _ with : makes
> build happy again.
>
> It is unclear to me when to use : vs. _ in Yocto for Kirkstone, is there =
a
> list?
>
>  Jocke
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14678):
> https://lists.openembedded.org/g/bitbake-devel/message/14678
> Mute This Topic: https://lists.openembedded.org/mt/98107247/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000ab6f9805f8acb7b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">See=C2=A0openembedded-core/scripts/contrib/convert-overrid=
es.py script which does most of the heavy lifting and there is a plenty of =
examples how to update the layers.<div><br></div><div>&gt; PREFERRED_VERSIO=
N:xyz =3D 1.2.3</div>&gt; does not work in Kirkstone but works in Dunfell,<=
div><br></div><div>This is side effect of the bitbake change which replaces=
 all &#39;:&#39; with &quot;_&quot; as a way to allow using new syntax with=
 older bitbake, but unfortunately it replaces it everywhere (even where it =
shouldn&#39;t be used at all in first place), that&#39;s why it works in du=
nfell with older bitbake while kirkstone correctly refuses it.</div><div><b=
r></div><div>See=C2=A0<a href=3D"https://git.openembedded.org/bitbake/commi=
t/?h=3D1.46&amp;id=3Da6d5fb7554e3cf071e453db56a1e7469ac44277c">https://git.=
openembedded.org/bitbake/commit/?h=3D1.46&amp;id=3Da6d5fb7554e3cf071e453db5=
6a1e7469ac44277c</a></div><div><br></div><div>Regards,</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 6, =
2023 at 5:27=E2=80=AFPM Joakim Tjernlund &lt;<a href=3D"mailto:Joakim.Tjern=
lund@infinera.com">Joakim.Tjernlund@infinera.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Porting to Kirkstone I stum=
bled over this:<br>
=C2=A0 PREFERRED_VERSION:xyz =3D 1.2.3<br>
does not work in Kirkstone but works in Dunfell, need to replace : with _<b=
r>
<br>
<br>
FILES_${PN} is silently ignored in Kirkstone, replacing _ with : makes buil=
d happy again.<br>
<br>
It is unclear to me when to use : vs. _ in Yocto for Kirkstone, is there a =
list?<br>
<br>
=C2=A0Jocke<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14678): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14678" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14678</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/98107247/3617=
156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/98107247/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000ab6f9805f8acb7b3--

