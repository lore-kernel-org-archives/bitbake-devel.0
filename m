Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D254C76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 16:26:36 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.163242.1680798390116711658
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 09:26:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20210112 header.b=dVwrf1CJ;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so6100739wmb.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680798388; x=1683390388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k+ctxlranttfKFI42m7jy3yNYsRaaKOxlD/CViq2lZE=;
        b=dVwrf1CJEastmmP0p55HIMf5jT8MMuY1tTz87lHXB6jqX/IWv4saLNFnYbTKEMNAVD
         2lNC0KL/KtzTiySkQ7McquZyy2UH/3nwonpDb9XCyn3Nl9PqF8NcAa2ImJUv8a/zJTm3
         OS/DeF5pdxWbgIK/HRSuLgpgRsDfGsifq73qkLcjRjyjjo5KneVeg9FS9X5sqCc/gwUU
         t4w47da6fl7VLkrEELYFy9OSzG9ArLd8U7XBqaos2zXfDdLvbnPtM1dUc0IpGiVf+TdR
         +RgkEZAy3cOatS83veCdhDt4fCiKcdWIhIcQI9mhBPTYXhKiX1UNeZtUSwQIrQrBl51H
         qJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680798388; x=1683390388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+ctxlranttfKFI42m7jy3yNYsRaaKOxlD/CViq2lZE=;
        b=i/pvWvN4LqXN8f0Z3fF74vIxz212YamWPb0lFqGA48z0GYXyUohnSQjWHupUYz+aGl
         Zn7yW0Qk522l5+YLQ4NCWhXlPNLvCWRKYRrlGvzOhamwYyINHvZBBojBFOwphLTOMaNW
         xSZRSarDRce4s6aPNBurQF1pSw9gqIRPHmCW36WoXMUS/QxMTY72dvphJG2roBw5gZP8
         3NrMBzjSsEYLdsnlmqd116UAb+VWCQgBlfpbM/5PvGX0abm/ybXnZ9CUgkT2W3FkaMWj
         SCwnKwCrZkw1DtrgRsjqEdLKcn3tpySTgGZin/rDPmXTelSyPNXmM8GmWNesG95ol7Nz
         BGTQ==
X-Gm-Message-State: AAQBX9drK9IBHJ/0w/WXUHbh/vjykxVaFkNQJ7D80QU2thNIknOYyMHS
	weQmNoThef0h3F5kY2Lhn3NK/BmbrwPtlq2KIYc=
X-Google-Smtp-Source: AKy350aCg9Y34NMy6IxoLLvmLjF/se3tSMR8Baf/SpoDjleV89EYe9f4vnwt9C3yA/xwZ/Sl5dj6GCl7lMGOCQoLtwI=
X-Received: by 2002:a7b:ce83:0:b0:3df:97b0:ba02 with SMTP id
 q3-20020a7bce83000000b003df97b0ba02mr2622018wmj.3.1680798388306; Thu, 06 Apr
 2023 09:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <3bdf71527c3afcae7cd303826a3b59a52e28cc96.camel@infinera.com>
 <CA+chaQfYR76=q44-5co7p56CNC7KBA=nQaAqh4nR=5wG4p5=tg@mail.gmail.com> <17260794c494f1e8dd0e7e3d0bab2550df0185d0.camel@infinera.com>
In-Reply-To: <17260794c494f1e8dd0e7e3d0bab2550df0185d0.camel@infinera.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 6 Apr 2023 18:26:09 +0200
Message-ID: <CA+chaQcaTTBjfeZ2_GiLRAD8AOLo8PzdBN5a=r9iRATKvGazrQ@mail.gmail.com>
Subject: Re: [bitbake-devel] Kirkstone : vs _ bugs
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000dfd76605f8ad5e39"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 16:26:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14681

--000000000000dfd76605f8ad5e39
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Problem is that it is not clear the the avage user when/where to use : vs
_.

Examples of already migrated layers don't help?

> Why is PREFERRED_VERSION:xyz wrong ?

Because xyz is not an override.


On Thu, Apr 6, 2023 at 5:56=E2=80=AFPM Joakim Tjernlund <
Joakim.Tjernlund@infinera.com> wrote:

> Problem is that it is not clear the the avage user when/where to use : vs
> _ and only some cases of wrong use makes bitbake throw an error.
> It can take a long time to figure out where the error is.
> Why is PREFERRED_VERSION:xyz wrong ?
>
>  Jocke
> On Thu, 2023-04-06 at 17:39 +0200, Martin Jansa wrote:
>
> See openembedded-core/scripts/contrib/convert-overrides.py script which
> does most of the heavy lifting and there is a plenty of examples how to
> update the layers.
>
> > PREFERRED_VERSION:xyz =3D 1.2.3
> > does not work in Kirkstone but works in Dunfell,
>
> This is side effect of the bitbake change which replaces all ':' with "_"
> as a way to allow using new syntax with older bitbake, but unfortunately =
it
> replaces it everywhere (even where it shouldn't be used at all in first
> place), that's why it works in dunfell with older bitbake while kirkstone
> correctly refuses it.
>
> See
> https://git.openembedded.org/bitbake/commit/?h=3D1.46&id=3Da6d5fb7554e3cf=
071e453db56a1e7469ac44277c
>
> Regards,
>
> On Thu, Apr 6, 2023 at 5:27=E2=80=AFPM Joakim Tjernlund <
> Joakim.Tjernlund@infinera.com> wrote:
>
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
>

--000000000000dfd76605f8ad5e39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; Problem is that it is not clear the the avage user wh=
en/where to use : vs _.<div><br></div><div>Examples of already migrated lay=
ers don&#39;t help?</div><div><br></div><div>&gt; Why is PREFERRED_VERSION:=
xyz wrong ?</div><div><br></div><div>Because xyz is not an override.</div><=
div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Apr 6, 2023 at 5:56=E2=80=AFPM Joakim Tjernlund &lt=
;<a href=3D"mailto:Joakim.Tjernlund@infinera.com">Joakim.Tjernlund@infinera=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">



<div>
<div>Problem is that it is not clear the the avage user when/where to use :=
 vs _ and only some cases of wrong use makes bitbake throw an error.</div>
<div>It can take a long time to figure out where the error is.</div>
<div>Why is PREFERRED_VERSION:xyz wrong ?</div>
<div><br>
</div>
<div>=C2=A0Jocke=C2=A0</div>
<div>On Thu, 2023-04-06 at 17:39 +0200, Martin Jansa wrote:</div>
<blockquote type=3D"cite" style=3D"margin:0px 0px 0px 0.8ex;border-left:2px=
 solid rgb(114,159,207);padding-left:1ex">
<div dir=3D"ltr">See=C2=A0openembedded-core/scripts/contrib/convert-overrid=
es.py script which does most of the heavy lifting and there is a plenty of =
examples how to update the layers.
<div><br>
</div>
<div>&gt; PREFERRED_VERSION:xyz =3D 1.2.3</div>
&gt; does not work in Kirkstone but works in Dunfell,
<div><br>
</div>
<div>This is side effect of the bitbake change which replaces all &#39;:&#3=
9; with &quot;_&quot; as a way to allow using new syntax with older bitbake=
, but unfortunately it replaces it everywhere (even where it shouldn&#39;t =
be used at all in first place), that&#39;s why it works in
 dunfell with older bitbake while kirkstone correctly refuses it.</div>
<div><br>
</div>
<div>See=C2=A0<a href=3D"https://git.openembedded.org/bitbake/commit/?h=3D1=
.46&amp;id=3Da6d5fb7554e3cf071e453db56a1e7469ac44277c" target=3D"_blank">ht=
tps://git.openembedded.org/bitbake/commit/?h=3D1.46&amp;id=3Da6d5fb7554e3cf=
071e453db56a1e7469ac44277c</a></div>
<div><br>
</div>
<div>Regards,</div>
</div>
<div><br>
</div>
<div class=3D"gmail_quote">
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 6, 2023 at 5:27=E2=80=AFP=
M Joakim Tjernlund &lt;<a href=3D"mailto:Joakim.Tjernlund@infinera.com" tar=
get=3D"_blank">Joakim.Tjernlund@infinera.com</a>&gt; wrote:<br>
</div>
<blockquote type=3D"cite" style=3D"margin:0px 0px 0px 0.8ex;border-left:2px=
 solid rgb(114,159,207);padding-left:1ex">
<div>Porting to Kirkstone I stumbled over this:<br>
=C2=A0 PREFERRED_VERSION:xyz =3D 1.2.3<br>
does not work in Kirkstone but works in Dunfell, need to replace : with _<b=
r>
</div>
<div><br>
</div>
<div><br>
FILES_${PN} is silently ignored in Kirkstone, replacing _ with : makes buil=
d happy again.<br>
</div>
<div><br>
It is unclear to me when to use : vs. _ in Yocto for Kirkstone, is there a =
list?<br>
</div>
<div><br>
=C2=A0Jocke<br>
</div>
<div><br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14678): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14678" rel=3D"noreferrer" target=3D"_blank">
https://lists.openembedded.org/g/bitbake-devel/message/14678</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/98107247/3617=
156" rel=3D"noreferrer" target=3D"_blank">
https://lists.openembedded.org/mt/98107247/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">
bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">
https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto=
:Martin.Jansa@gmail.com" target=3D"_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
</div>
<div><br>
</div>
</blockquote>
</div>
</blockquote>
<div><br>
</div>
<div><span></span></div>
</div>

</blockquote></div>

--000000000000dfd76605f8ad5e39--

