Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB841CA0ED3
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 13:59:10 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.635.1725285541834583617
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Sep 2024 06:59:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L7JVeOaD;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: adam.blank.g@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2da4ea973bdso169372a91.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725285541; x=1725890341; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YAvbNzK81E6LBWuEd2qlCXOY78bPlf1tybq4l/3Zl6I=;
        b=L7JVeOaDxyPXpTNdx+KF2f7voFrXjvMhwyHS9OyDzKhj+IOAtdjoROcB0J405wWj61
         jJo/hHCyr6AN2fCeRSIZFbp/wX+eSrUH9b6+ZajcemwCIyRvoGzUBxj3nrBf8iMhTEt9
         u5YRpJzMQ1pVOSc8xXI5HYyd4dfIvlTw64eG1OlO1LRSykogLk27Ld/0dJ6GbA7cOovp
         66ZGt34brT0l1u3dY3j6bbqv/ICxiR+oYPXIMlAXqiAjLUALqrSgHzHRd1xTGUggI2a0
         osbHXjbcxMigWNSbZyl/A+GNEK3pGx0JNEMo/TEW3UCxsx+rYGVuxBecXkhv6vC+LRLq
         FlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725285541; x=1725890341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAvbNzK81E6LBWuEd2qlCXOY78bPlf1tybq4l/3Zl6I=;
        b=RieOO6obnvSdSarw8i4mpJhiE2j7bp0NvRQ4hQU8SGNSUmJIih4VKwBAEqBvm3qT79
         WD2u/KutuiQvL5meDWCan5cEzItESN19aTJECN4Mwe6cIBsVMf2VwDrZ5BqRC5Aj3t4X
         ka/F7NAOpB6w0lDMYU9+d9VAJ6cXGpkv0vhSBlI6K/w3EGLtAaq2wb9am/0XFspSFYea
         QWkkCEeswBLyaF/kpzzTh2Ypms9h+Q4AY6y1Hz0sw/6RCj3mMXer9zFzamstc1kaBDtB
         qVXcvY1Vi2wddu9vN8JVW0yH1yrG+RjPTD4AMhOqud7wM7XH28s3a9L1nRdVqAH+Q/3P
         J76g==
X-Gm-Message-State: AOJu0YzNNLEoqFkXSMeOHFy9BNneO4MJwPjnOCgGPgtGh7GCbC3LcWmb
	80xvnGRW8FoITDsynLtRkTGaHW8/XZp0wYpBqnwg0bZUA9NdiHufPhSF3ut+IwWcsUI7CLaJ4Cd
	RkMVYkstBggB5qk91bQHuGbefJRa/PKm4bIh7GQ==
X-Google-Smtp-Source: AGHT+IEBrYkHemB6SQNz/AFBbL9hxd6lRMBK1rkluE3LiHPNOmrpJACgz3N20T1/teVKDbZ7XAUCg3qcQ5LlB6PZRyc=
X-Received: by 2002:a17:90a:ea90:b0:2d8:7970:726 with SMTP id
 98e67ed59e1d1-2d879700fcbmr9529401a91.12.1725285541088; Mon, 02 Sep 2024
 06:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <083be01b5a70c46bedcdfca1c403c87b18299bf1.camel@linuxfoundation.org>
 <17365.1725273736587575150@lists.openembedded.org> <65ec906f864408329f7435f8123d4a254019cf04.camel@linuxfoundation.org>
In-Reply-To: <65ec906f864408329f7435f8123d4a254019cf04.camel@linuxfoundation.org>
From: Adam Blank <adam.blank.g@gmail.com>
Date: Mon, 2 Sep 2024 15:58:49 +0200
Message-ID: <CAFAffzzbpNY+fKdHQxWgjMdKCBe3v89nojx7sKtLsKmfkVLdyg@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][kirkstone][2.0] Appends discarded by expandVarref
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d01c9e0621235700"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Sep 2024 13:59:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16537

--000000000000d01c9e0621235700
Content-Type: text/plain; charset="UTF-8"

Allright, I get the idea and share the sense of the associated risk.
For the sake of formality though, I don't think that

ABC = "${@d.getVar('LAYERDIR')}"

has any point of contact with my proposal :-)
Both before and after the change, there's this line:

ref = '${%s}' % variable

which by the way renders this d.getVar() expression unusable for LAYERDIR
(always yields None).

Thanks for the discussion!
Adam

On Mon, 2 Sept 2024 at 13:58, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2024-09-02 at 03:42 -0700, Adam Blank via
> lists.openembedded.org wrote:
> > > To fix it we really need to avoid expanding any variables at all
> > > and
> > > just do a search/replace on the variable contents.
> > I'd like to propose something like that:
> >
> > --- a/lib/bb/data_smart.py
> > +++ b/lib/bb/data_smart.py
> > @@ -1007,9 +1007,34 @@ class DataSmart(MutableMapping):
> >          ref = '${%s}' % variable
> >          value = self.getVar(variable, False)
> >          for key in keys:
> > -            referrervalue = self.getVar(key, False)
> > -            if referrervalue and isinstance(referrervalue, str) and
> > ref in referrervalue:
> > -                self.setVar(key, referrervalue.replace(ref, value))
> > +            cow = False
> > +            if not key in self.dict:
> > +                local_var, _ = self._findVar(key)
> > +                cow = True
> > +            else:
> > +                local_var = self.dict[key]
> > +
> > +            for sKey in ["_content", "_defaultval", ":append",
> > ":prepend", ":remove"]:
> > +                val = local_var[sKey] if sKey in local_var else None
> > +
> > +                if isinstance(val, str) and ref in val:
> > +                    val2 = val.replace(ref, value)
> > +                    if cow:
> > +                        self._makeShadowCopy(key)
> > +                        cow = False
> > +                    self.dict[key][sKey] = val2
> > +                elif isinstance(val, list):
> > +                    val2 = None
> > +                    for i, (r, o) in enumerate(val):
> > +                        if ref in r:
> > +                            if not val2:
> > +                                val2 = list(val)
> > +                            val2[i] = [r.replace(ref, value), o]
> > +                    if val2:
> > +                        if cow:
> > +                            self._makeShadowCopy(key)
> > +                            cow = False
> > +                        self.dict[key][sKey] = val2
> >
> > Efficiency wise it does not do more that the original code, and it
> > gets straight to the point.
>
> The downside of this is that firstly, it is using a lot of internal
> knowledge of the data store which I worry may make changes more fragile
> in that code.
>
> Secondly, it does break some usages, for example:
>
> ABC = "${@d.getVar('LAYERDIR')}"
>
> would no longer work after that change (as a simple example).
>
> I'm torn on this but I would note that you're sending the patch for
> kirkstone and we definitely can't make a breaking change like that in
> kirkstone at this point.
>
> Cheers,
>
> Richard
>

--000000000000d01c9e0621235700
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">All=
right, I get the idea and share the sense of the associated risk.</div><div=
 class=3D"gmail_default" style=3D"font-size:small">For the sake of formalit=
y though, I don&#39;t think that</div><div class=3D"gmail_default" style=3D=
"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size=
:small">ABC =3D &quot;${@d.getVar(&#39;LAYERDIR&#39;)}&quot;<br></div><div =
class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"g=
mail_default" style=3D"font-size:small">has any point of contact with my pr=
oposal :-)</div><div class=3D"gmail_default" style=3D"font-size:small">Both=
 before and after the change, there&#39;s this line:</div><div class=3D"gma=
il_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default=
" style=3D"font-size:small">ref =3D &#39;${%s}&#39; % variable<br></div><di=
v class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">which by the way renders this d.g=
etVar() expression unusable for LAYERDIR (always yields None).</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gma=
il_default" style=3D"font-size:small">Thanks for the discussion!</div><div =
class=3D"gmail_default" style=3D"font-size:small">Adam</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 2 Sept =
2024 at 13:58, Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2024-09-02 at 03:42 =
-0700, Adam Blank via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a> wrote:<br>
&gt; &gt; To fix it we really need to avoid expanding any variables at all<=
br>
&gt; &gt; and<br>
&gt; &gt; just do a search/replace on the variable contents.<br>
&gt; I&#39;d like to propose something like that:<br>
&gt; =C2=A0<br>
&gt; --- a/lib/bb/data_smart.py<br>
&gt; +++ b/lib/bb/data_smart.py<br>
&gt; @@ -1007,9 +1007,34 @@ class DataSmart(MutableMapping):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ref =3D &#39;${%s}&#39; % variable<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D self.getVar(variable, Fals=
e)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for key in keys:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0referrervalue =3D self.getV=
ar(key, False)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if referrervalue and isinst=
ance(referrervalue, str) and<br>
&gt; ref in referrervalue:<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.setVar(k=
ey, referrervalue.replace(ref, value))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cow =3D False<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not key in self.dict:<br=
>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_var, _ =
=3D self._findVar(key)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cow =3D True<=
br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_var =3D=
 self.dict[key]<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for sKey in [&quot;_content=
&quot;, &quot;_defaultval&quot;, &quot;:append&quot;,<br>
&gt; &quot;:prepend&quot;, &quot;:remove&quot;]:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D local=
_var[sKey] if sKey in local_var else None<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if isinstance=
(val, str) and ref in val:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0val2 =3D val.replace(ref, value)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if cow:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0self._makeShadowCopy(key)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0cow =3D False<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.dict[key][sKey] =3D val2<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif isinstan=
ce(val, list):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0val2 =3D None<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0for i, (r, o) in enumerate(val):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if ref in r:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not val2:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val2 =3D list(val)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val2[i] =3D [r.replace(ref, value), o]<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if val2:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if cow:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._makeShadowCopy(key)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cow =3D False<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0self.dict[key][sKey] =3D val2<br>
&gt; =C2=A0<br>
&gt; Efficiency wise it does not do more that the original code, and it<br>
&gt; gets straight to the point.<br>
<br>
The downside of this is that firstly, it is using a lot of internal<br>
knowledge of the data store which I worry may make changes more fragile<br>
in that code.=C2=A0<br>
<br>
Secondly, it does break some usages, for example:<br>
<br>
ABC =3D &quot;${@d.getVar(&#39;LAYERDIR&#39;)}&quot;<br>
<br>
would no longer work after that change (as a simple example).<br>
<br>
I&#39;m torn on this but I would note that you&#39;re sending the patch for=
<br>
kirkstone and we definitely can&#39;t make a breaking change like that in<b=
r>
kirkstone at this point.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--000000000000d01c9e0621235700--

