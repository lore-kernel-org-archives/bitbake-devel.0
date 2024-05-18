Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F78EC25B74
	for <webhook@archiver.kernel.org>; Sat, 18 May 2024 16:00:42 +0000 (UTC)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
 by mx.groups.io with SMTP id smtpd.web11.21565.1716048040556396475
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 18 May 2024 09:00:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=J2q/hoQn;
 spf=pass (domain: gmail.com, ip: 209.85.217.52, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-47efcb120feso459389137.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 18 May 2024 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716048039; x=1716652839; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g6Uj+YLdMHJrMbmoJ3pe/XXpRG4Ws6BDK5p1MJ4DK5k=;
        b=J2q/hoQnzhWQUSjVn7IaB99y4HLTzoQZ11UiDpTo4Gf+LXZItuNLgZk31fSTDcC1Wp
         m4WXlIToLD8b2DSaFSzr/lA/VuPGUgDd8e+fLeQRMqMUJeJb0QCl+LQD2yzxOWXqt4Hm
         UYoT0LDXYRdEIqDwLT3enRzi9y4Jj/MwoQd61L5uzy/4hByM6FMtnd8Qe3GA+Fd/OGXu
         79YvVJIbc4OjxEsOlJxclQ8NiaZd4SjjTnCPaERUcHkGc4fy1FnFwdrDjpRoG2xqNRXw
         lFDlxnBgJfOKYtVvpE3wgqU/xXrQRQ6cTJx7fgl9BYybunlC5xmpj/tT9I0uzknfIWUl
         H7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716048039; x=1716652839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6Uj+YLdMHJrMbmoJ3pe/XXpRG4Ws6BDK5p1MJ4DK5k=;
        b=N9CnzzWOitTWige/joj20rb8l7SxxT8CKx8ewn/5VyZSy2pPsXQqGWqQi67Q7znr7s
         mqVcAsqsKeVrUK3CyNHUKc9rfx8wmC2syQkyxIO9QVnCejUQ3KoTG+zTJ1548Y0Em5/k
         kFzeTQYHq64FP8y9zC16zKL0pv8kKTcEnOXyw+gnCxicnj1leDYmqZzqQoCBKdmFNiEs
         lTTvl4cubUbNS0KhFsYcsRFQRtPldaVvcF0r64ZwWU032A7z9kLEyZ4hPLb348x/gEzX
         4j2iZCdSPgXyRbegnZSSM2DqUjyJuU7cXkNKoSevag0BkMxNOhZJfBDhcZ7Ezqw+8/J3
         Cshg==
X-Gm-Message-State: AOJu0Yy0sG+itT9tqiN983qe6HWZRVdFk5D5FnsSp5wacawnHtx7s+3K
	QhLY8OaJN/sCIeVDY1bsBDIDg9cxgVkrkno9JUhdlM2kyfUA2Zm8fVtKJVl/IK+UmDrlpGWeoRI
	/9dmaM0Q8d5xEqmVYQDNUO+rJOv4=
X-Google-Smtp-Source: AGHT+IE4S9rz67elRduRAaTliGY/Tr9skCrhTyO069auQV3gqrxLp0tvo+8ASyPmpfKe0LO7Ty0AMNRcrlgGc3I+txA=
X-Received: by 2002:a05:6102:511e:b0:485:9ea8:d777 with SMTP id
 ada2fe7eead31-4859ea8d835mr8739361137.27.1716048038069; Sat, 18 May 2024
 09:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSkHJ9opKaxq01b62+TztjqXWipHrayAwU=vCN3ZRAbO+G1-A@mail.gmail.com>
In-Reply-To: <CAFSkHJ9opKaxq01b62+TztjqXWipHrayAwU=vCN3ZRAbO+G1-A@mail.gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Sat, 18 May 2024 18:00:26 +0200
Message-ID: <CA+cAkepZ=ho2QzO6sCsSPKP_uOhoFPU0TgEd1+izE5y_HX6ONw@mail.gmail.com>
Subject: Re: [bitbake-devel] Possible kirkstone 4.0.17 variable dependency bug
To: eric.sun@meraki.net
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ba0f710618bc91b0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 18 May 2024 16:00:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16229

--000000000000ba0f710618bc91b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Do you mind elaborate a little about the issue? How it broke bitbake
variable dependencies? Do you have a minimal example that show the problem?

Thanks.


Le ven. 17 mai 2024, 18:33, Eric Sun via lists.openembedded.org <eric.sun=
=3D
meraki.net@lists.openembedded.org> a =C3=A9crit :

> Hello,
>
> I believe commit 8ec4f29e432feec9d8deedc06bfb90d57e7436cf to the
> kirkstone branch broke some variable dependency calculations in python
> 3.6 (and likely 3.7).
>
> Specifically, those python versions still parse string arguments to
> functions in python expressions into ast.Str, rather than
> ast.Constant. And so the code in question is no longer able to
> determine dependencies involving e.g. bb.utils.contains.
>
> As an illustrative example, consider the results of the following:
> import ast; print(ast.dump(ast.parse('f("a", "b", "c")')))
>
> Python 3.6:
> Module(body=3D[Expr(value=3DCall(func=3DName(id=3D'f', ctx=3DLoad()),
> args=3D[Str(s=3D'a'), Str(s=3D'b'), Str(s=3D'c')], keywords=3D[]))])
>
> Python 3.8:
> Module(body=3D[Expr(value=3DCall(func=3DName(id=3D'f', ctx=3DLoad()),
> args=3D[Constant(value=3D'a', kind=3DNone), Constant(value=3D'b', kind=3D=
None),
> Constant(value=3D'c', kind=3DNone)], keywords=3D[]))], type_ignores=3D[])
>
> Happy to try to submit a patch if that'd be helpful. This is only an
> issue on kirkstone where the minimum required python version is 3.6.
>
> Thanks,
> Eric Sun
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16228):
> https://lists.openembedded.org/g/bitbake-devel/message/16228
> Mute This Topic: https://lists.openembedded.org/mt/106157110/6213388
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> frederic.martinsons@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000ba0f710618bc91b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hello,<div dir=3D"auto"><br></div><div dir=3D"auto">=
Do you mind elaborate a little about the issue? How it broke bitbake variab=
le dependencies? Do you have a minimal example that show the problem?=C2=A0=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks.=C2=A0</div><br>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le ven=
. 17 mai 2024, 18:33, Eric Sun via <a href=3D"http://lists.openembedded.org=
">lists.openembedded.org</a> &lt;eric.sun=3D<a href=3D"mailto:meraki.net@li=
sts.openembedded.org">meraki.net@lists.openembedded.org</a>&gt; a =C3=A9cri=
t=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">Hello,<br>
<br>
I believe commit 8ec4f29e432feec9d8deedc06bfb90d57e7436cf to the<br>
kirkstone branch broke some variable dependency calculations in python<br>
3.6 (and likely 3.7).<br>
<br>
Specifically, those python versions still parse string arguments to<br>
functions in python expressions into ast.Str, rather than<br>
ast.Constant. And so the code in question is no longer able to<br>
determine dependencies involving e.g. bb.utils.contains.<br>
<br>
As an illustrative example, consider the results of the following:<br>
import ast; print(ast.dump(ast.parse(&#39;f(&quot;a&quot;, &quot;b&quot;, &=
quot;c&quot;)&#39;)))<br>
<br>
Python 3.6:<br>
Module(body=3D[Expr(value=3DCall(func=3DName(id=3D&#39;f&#39;, ctx=3DLoad()=
),<br>
args=3D[Str(s=3D&#39;a&#39;), Str(s=3D&#39;b&#39;), Str(s=3D&#39;c&#39;)], =
keywords=3D[]))])<br>
<br>
Python 3.8:<br>
Module(body=3D[Expr(value=3DCall(func=3DName(id=3D&#39;f&#39;, ctx=3DLoad()=
),<br>
args=3D[Constant(value=3D&#39;a&#39;, kind=3DNone), Constant(value=3D&#39;b=
&#39;, kind=3DNone),<br>
Constant(value=3D&#39;c&#39;, kind=3DNone)], keywords=3D[]))], type_ignores=
=3D[])<br>
<br>
Happy to try to submit a patch if that&#39;d be helpful. This is only an<br=
>
issue on kirkstone where the minimum required python version is 3.6.<br>
<br>
Thanks,<br>
Eric Sun<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16228): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16228" rel=3D"noreferrer noreferrer" target=3D"_blank">h=
ttps://lists.openembedded.org/g/bitbake-devel/message/16228</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/106157110/621=
3388" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.openemb=
edded.org/mt/106157110/6213388</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank" rel=3D"noreferrer">bitbake-devel+owner@lists.openembedd=
ed.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.openembedd=
ed.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto:frederic.martinsons@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">frederic.martinsons@gmail.com<=
/a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div></div>

--000000000000ba0f710618bc91b0--

