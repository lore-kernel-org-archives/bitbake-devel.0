Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FFDC433F5
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 09:14:53 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web08.2968.1636103691787313463
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 02:14:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=AwV4Bzdl;
 spf=pass (domain: gmail.com, ip: 209.85.216.44,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-pj1-f44.google.com with SMTP id
 o6-20020a17090a0a0600b001a64b9a11aeso2942583pjo.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6R1p7n3PZVXaITa3fApsNt+hZbHf8K2ELmDKYlojRWI=;
        b=AwV4BzdlXIFZugyA8FrroAB3BCEnw0NVDNwEmvAxWOQalKcf8kjR94Hofk8euul0nR
         veRJSwRQKoylbc1e/eWfyXB83yx/6CSTXvORpMxSF6oDuhNRQ2hGOL+ikyi2tTO+WVFt
         JZW13Ye7IkbaA/EUtIauG5ZCxAL0j0uN7wAebcaIKbPrFqTJk5SNfHLfF2JXg+OadyfU
         X3MMNxwkrabXEEVNQghCZaHZcTWyXBX8iSlbtfyyN406yrnKhgzNYg99AiGhxzaEpz1M
         CIX6aQe3R1OizpO+/c/x+sL8Z7/5iRA9K16AQvSgpphw4RqmoEJprlZ8bEuKs+Fubu2i
         viYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6R1p7n3PZVXaITa3fApsNt+hZbHf8K2ELmDKYlojRWI=;
        b=Ix1jzBg+ve/XuQ2dg1rezRMbhz4x8wBp8Ce2KO7YkgAf46JfOK2L2trCe36P1o3agC
         koT0pVlj1zgAiqLpPxVEWgVxvynhe5sR5kzEkaF0UQJSulUu2+f1/mdfU7najcHoRtom
         UFhtBOAe0QbaHvq1alIg3eeEAvGqtB5Y376WHTJpxLuYEhEcYbblsF6iK4FKSmsCWaK7
         VRE8xjT4WlEz5o7zhga39ZIeVi8HZem7JYgKep/Sp4Zgzbejsct3ulys/mbyMFDonLoa
         hdLlxeEn4FL3yVVkWh9yKodnK4k4bV0ZpXMCso2oliB7zAAzc8yZgYO5Epc4asVLXb7Z
         HEug==
X-Gm-Message-State: AOAM530DPqBL/cntX5XnO5UPieRr76AduSUEgRX36Zs6Mz3n//qbvak4
	LE9cvL9P/r8KTnlqaXnHwOa8ZaGpDiCJrW8sYKk=
X-Google-Smtp-Source: 
 ABdhPJwF1qmTCNeRZJuHLMiYveLjQrX+RYnFUtMPo1njFTcdwixzDgSBoCGeNxl5JrgsWYNlmkpQBY3hF1VWXvLPCCc=
X-Received: by 2002:a17:90a:c091:: with SMTP id
 o17mr11526033pjs.35.1636103691342;
 Fri, 05 Nov 2021 02:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211104135848.3621936-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20211104135848.3621936-1-richard.purdie@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 5 Nov 2021 10:14:40 +0100
Message-ID: 
 <CA+chaQeU31hZp74hHtjAF044B5wtVi+iwjaghy8HkeY8gShzOA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] parse/ast: Show errors for
 append/prepend/remove operators combined with +=/.=
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000056980005d007130b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 09:14:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12886

--00000000000056980005d007130b
Content-Type: text/plain; charset="UTF-8"

Hi,

this seems to be merged in 1.52 branch now and not in master, was that
intentional?

I think this should go only into master branch, right?

On Thu, Nov 4, 2021 at 2:58 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Operations like XXX:append += "YYY" are almost always wrong and this
> is a common mistake made in the metadata. Show warnings for these usages
> with a view to making it a fatal error eventually.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/parse/ast.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> index 743ea0dfc0..93cbf285ef 100644
> --- a/lib/bb/parse/ast.py
> +++ b/lib/bb/parse/ast.py
> @@ -130,6 +130,10 @@ class DataNode(AstNode):
>          else:
>              val = groupd["value"]
>
> +        if ":append" in key or ":remove" in key or ":prepend" in key:
> +            if op in ["append", "prepend", "postdot", "predot"]:
> +                bb.warn(key + " " + groupd[op] + " is not a recommended
> operator combination, please replace it.")
> +
>          flag = None
>          if 'flag' in groupd and groupd['flag'] is not None:
>              flag = groupd['flag']
> --
> 2.32.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12877):
> https://lists.openembedded.org/g/bitbake-devel/message/12877
> Mute This Topic: https://lists.openembedded.org/mt/86816155/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--00000000000056980005d007130b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>this seems to be merged in 1.52 bra=
nch now and not in master, was that intentional?</div><div><br></div><div>I=
 think this should go only into master branch, right?</div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 4, 2=
021 at 2:58 PM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Operations like XXX:append +=
=3D &quot;YYY&quot; are almost always wrong and this<br>
is a common mistake made in the metadata. Show warnings for these usages<br=
>
with a view to making it a fatal error eventually.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/parse/ast.py | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py<br>
index 743ea0dfc0..93cbf285ef 100644<br>
--- a/lib/bb/parse/ast.py<br>
+++ b/lib/bb/parse/ast.py<br>
@@ -130,6 +130,10 @@ class DataNode(AstNode):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D groupd[&quot;value&=
quot;]<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;:append&quot; in key or &quot;:remove=
&quot; in key or &quot;:prepend&quot; in key:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if op in [&quot;append&quot;, &q=
uot;prepend&quot;, &quot;postdot&quot;, &quot;predot&quot;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(key + &quo=
t; &quot; + groupd[op] + &quot; is not a recommended operator combination, =
please replace it.&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flag =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;flag&#39; in groupd and groupd[&#=
39;flag&#39;] is not None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flag =3D groupd[&#39;flag&#=
39;]<br>
-- <br>
2.32.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12877): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12877" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12877</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86816155/3617=
156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86816155/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--00000000000056980005d007130b--

