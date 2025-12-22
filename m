Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62AFE69165
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 19:53:34 +0000 (UTC)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87497.1766433213561800708
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Dec 2025 11:53:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=3Zprt0MP;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.54, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-640e065991dso3734180d50.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 11:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1766433213; x=1767038013; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ydBFACTojfTEPDk//MCSHKCfyfi+gNzLEu1jGCb0qCc=;
        b=3Zprt0MP6RMezsUKzl7z2A8fEWCHC5qSLdxsxw7DxDEGl3MMCGwQdRbPNpfERi27nP
         oULGNf4XI/9CCrwGFt4CoJeGG7bybqLvJZ2y0wE/5A03lslxdHzGklimwpDwtWqQ2XwD
         2oMAN1oqTs3KActW99IL2HsU8p0bUqIvDxWQZ1IV2x8VihYm/jxhs9Vz0gej6ciTEuyL
         vdPbB9fCEeDoHGQtgmFJFp/h1BsEuOUYZuGzUULT0MrveC5ZvKuUZ8nRwy0yMLcrnMnl
         prjHqy3LbrrV9gzyav3Cppa1SYLvKE1rh3LV1phpFvMPFw4rxDp6edQV9FkCYsWUCZJH
         DSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766433213; x=1767038013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydBFACTojfTEPDk//MCSHKCfyfi+gNzLEu1jGCb0qCc=;
        b=FLiuzLJrKuAMYZ3L6wR/PnXDOdFWbhWaWjXMInwMaMOGslwrLOrEeFFLKElK9C0hH9
         6p8anYArmxNiqliHmUHGV0fzpPH9yei1P//LOqyRo+dwwzDdCwTSRfdRunrEJWFZp+WA
         UWXA7M/tdx2FqmJmwzBiszZBCO5J7buDL90+kNJWxKVCmWsykmdM7sk790bGBFyjMAsh
         N8Sm2kaaseWvd+1jx/Qr3tPhWNXO1kV2HPQuhUabJ7JTWLhgY2+RYqAsN2AK6OzHZN70
         yOuUg39r0oDdpEG6cAW82gVwcEJUBB0YxrTNLuYyaZPfAjaRPgr26Rm82hNc/wYx+x2A
         h1Ew==
X-Gm-Message-State: AOJu0YxgTLjPtMjUHGRlnJh63vaS8zouXTbvfHllwbVWktcJxV8Xwhqz
	B8kA5F1Rk2XZIwfXr1nx5bBEcz2tuyMKj4cN7eVadS/wMbkTBdeVI5Wm9FfWdsafbE80MnWQlI7
	QOH+uXmRKR7CLCPP29Uido732jlR68/4IILZ+H+TltA==
X-Gm-Gg: AY/fxX7oDlVt7MFlwPVUhXZe6GLGpEMKhpWPGKByzvXdWbavcyL7ehJeL69yYfJgvIz
	kHueArsrs/xy24YFGL5099r+oNhTFrnMqp89zLUbbtxz/IT1TLQxNKI6b7m/haRrCUCGUD3DsAQ
	C0J90znJolwI3Ij+cJQ18h8ytrqd8bQOFw6+iPAD0+BXL3FkAIz/3B9k/X6f9g2rpG/3MyRyFfJ
	wqzFsOLt8Wz00uEF1+oEdBDi9V7D7pQwt4+YKVtaqR0CFIukKOqmr7eyQfj1lKRgz0Zr11DZCbV
	B+5gGXL2EasB2bMZN1Kc2HaelgwThNAitcMRDJinb3g6DLHiHAerebAnnA==
X-Google-Smtp-Source: AGHT+IE6RB7RVpwBQlAWHy/p+R8DKsS5CPABaWlr/nHQpeY5QpYJfBid3KXZymhG7nHIkd2T7nFTlCuWMbVJwgc5fFM=
X-Received: by 2002:a53:d00a:0:b0:644:60d9:7528 with SMTP id
 956f58d0204a3-6466a8dea7dmr8813447d50.90.1766433212610; Mon, 22 Dec 2025
 11:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20251222181527.2424323-1-anibal@limonsoftware.com> <CANNYZj-=2r9VFg4AGfKiYbOp5Eh57uvVQt11UTT0xVWPhfxbhw@mail.gmail.com>
In-Reply-To: <CANNYZj-=2r9VFg4AGfKiYbOp5Eh57uvVQt11UTT0xVWPhfxbhw@mail.gmail.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Mon, 22 Dec 2025 13:53:21 -0600
X-Gm-Features: AQt7F2ol4bGnJDONabAnxkIwcy2ygVdDVb1gxztgQB2HeLJMSywRRCDegsW_uyQ
Message-ID: <CAOU5ZMthyn3+Y9axBKSdVy3qukFo2j_eU0VnJupTZ6pX7PoPag@mail.gmail.com>
Subject: Re: [PATCH] bitbake-setup: _symlink_local fix case when update
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Type: multipart/alternative; boundary="000000000000284cf106468fc857"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Dec 2025 19:53:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18642

--000000000000284cf106468fc857
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 1:18=E2=80=AFPM Alexander Kanavin <alex.kanavin@gma=
il.com>
wrote:

> On Mon, 22 Dec 2025 at 19:15, Anibal Limon <anibal@limonsoftware.com>
> wrote:
>
> > +        if os.path.islink(dst):
> > +            if not os.path.samefile(src, dst):
> > +                logger.plain("Updating symbolic link {} pointing to
> {}".format(dst, src))
> > +                os.remove(src)
> > +                do_symlink =3D True
>
> dst is the symlink, but os.remove is taking src parameter. Is that correc=
t?
>

It is wrong, updating.


>
> > +        else:
> > +            logger.plain("Making a symbolic link {} pointing to
> {}".format(dst, src))
> > +            do_symlink =3D True
> > +
> > +        if do_symlink:
> > +            os.symlink(src, dst)
>
> Is this logic complete? It seems to cover the use case when one local
> path is replaced with another local path in a json config, or when
> local path is unchanged, but maybe we should cover the situation where
> a git checkout is replaced by a local source as well?
>

Right,
I think it should cover switching from local to remote or vice-versa too.

I'm using local sources, on the manifest:

```
....
        "ls-layers": {
            "local": {
                "path": "/home/workspaces/ls/meta-ls/layers'"
            }
        }
...
```

Then we run an update for a change on the manifest; it tries to make the
symlink again and fails.


>
> This and the previous patch expose a gap in testing, perhaps
> status/update tests should be extended to cover local sources?
>

Ack. I will look at the tests and send v2.


>
> Alex
>

--000000000000284cf106468fc857
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 22,=
 2025 at 1:18=E2=80=AFPM Alexander Kanavin &lt;<a href=3D"mailto:alex.kanav=
in@gmail.com">alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Mon, 22 Dec 2025 at 19:15, Anibal Li=
mon &lt;<a href=3D"mailto:anibal@limonsoftware.com" target=3D"_blank">aniba=
l@limonsoftware.com</a>&gt; wrote:<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.islink(dst):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.samefile(src=
, dst):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.plain(=
&quot;Updating symbolic link {} pointing to {}&quot;.format(dst, src))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.remove(src=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_symlink =
=3D True<br>
<br>
dst is the symlink, but os.remove is taking src parameter. Is that correct?=
<br></blockquote><div><br></div><div>It is wrong, updating.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.plain(&quot;Making a=
 symbolic link {} pointing to {}&quot;.format(dst, src))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_symlink =3D True<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if do_symlink:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(src, dst)<br>
<br>
Is this logic complete? It seems to cover the use case when one local<br>
path is replaced with another local path in a json config, or when<br>
local path is unchanged, but maybe we should cover the situation where<br>
a git checkout is replaced by a local source as well?<br></blockquote><div>=
<br></div><div>Right,=C2=A0</div><div>I think it should cover switching fro=
m local to remote or vice-versa too.</div><div><br></div><div>I&#39;m using=
 local sources, on the manifest:</div><div><br></div><div>```</div><div>...=
.</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ls-layers&quot;: {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;local&quot;: {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;path&quot;: &quot;/home/wor=
kspaces/ls/meta-ls/layers&#39;&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></div><div>...</div><div>```</=
div><div><br></div><div>Then we run an update for a change on the manifest;=
 it tries to make the symlink again and fails.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
This and the previous patch expose a gap in testing, perhaps<br>
status/update tests should be extended to cover local sources?<br></blockqu=
ote><div><br></div><div>Ack. I will look at the tests and send v2.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div></div>

--000000000000284cf106468fc857--

