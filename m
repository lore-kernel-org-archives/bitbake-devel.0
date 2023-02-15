Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E99C636CC
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 16:45:49 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.20315.1676479543645115080
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 08:45:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=jF77jkBZ;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id m14so19780650wrg.13
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G6piSy9m6oRpgHviQUmjkatw+wVP9YGMYcOpc5mRa3w=;
        b=jF77jkBZJ1iWPUw7yQ6ln7lqTrwXDLJN9xvTSVMU06+9G3GAbVzZx1c5GYiE34j8H7
         xv4bsMVqcIYP8avz8AjskrhfgzktuMeMfPlpzAl1JHXDOkiGDfJu4yqv07Y90quo+DlQ
         K2jkx8vhR86jcqBLb5XHGrLSdb0b2xFkZnjwidXrs1iQ+tfj802H9ZBKJURB3BH9cjQy
         0LHqlmcZAtFVswgtguPHjRBb1CxHdtzDLunsuYHBx2vpKamfXP6Ul9I89pF3J740SVEw
         gFM8fKwsBaCxRKTZMhItvk8AgctkOQezxVRXb9tGXEb6SqzhaKWjGIh+AsRVmhilOQXJ
         qNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6piSy9m6oRpgHviQUmjkatw+wVP9YGMYcOpc5mRa3w=;
        b=v1Up9WPuneWbyyJDCJJPfiJoa7Gi8XOaQKyXp94bTvR2tsJ/zokdYK6t8LbZEkygmY
         W3vXbUuDKo3TD2wQ05b86u5RPXhjEOQ7xbx9Z2rmSD/GLyOZRDSm0BqB0CPyPp8VlpTe
         IqbTl43xWVHSrFbXn7HbrNuaC8TJ62gMnY9OhRbRngHAiVHoNWRCdalGpJERQ1a5tFZb
         cH1WODAocnAUJWE0TCjjtW1ljJb2FgyBHJA5+JUm/YK29ZarEfLIDjyEleAuXdGNbX/Z
         xxJfZl0xvUoYccFTO7Xi3iuwTAzEahwvhPeM+nK4tT1scVUSxGv89fzcAQ7RTTRN/xtw
         Rjvw==
X-Gm-Message-State: AO0yUKUP+L3Rl2JP4M/tMQpqll+OI/3m2owSSHLU8p1cSK+i7buopnW5
	6mucQ9Jgu3qSKMFJWgzR5SNcldJHr4S/b2YBQoY=
X-Google-Smtp-Source: AK7set+nUt5I/OJVeXcvqrqgcGmvXatS5Sgr2T4WU1oWakv4db0AUaV05sJhEvLGjqf+8IIoKM4L1H68Ya2u/Nz5rwQ=
X-Received: by 2002:a5d:4a11:0:b0:2c4:24a:b51d with SMTP id
 m17-20020a5d4a11000000b002c4024ab51dmr73273wrq.92.1676479542049; Wed, 15 Feb
 2023 08:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20221212160334.54431-1-richard.purdie@linuxfoundation.org>
 <CA+chaQdrzVxHjKGPGSaoWxkr_pYShj5z9o8QFV5b585cG-9Z7g@mail.gmail.com> <1256aaa44ee27adace8686a37393d68d75cab1f9.camel@linuxfoundation.org>
In-Reply-To: <1256aaa44ee27adace8686a37393d68d75cab1f9.camel@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 15 Feb 2023 17:45:28 +0100
Message-ID: <CA+chaQc28ET-4g5RqjLy_2DdgiNYd0JJq7FfqgYtDejnQtVLZg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] ast/data/codeparser: Add dependencies
 from python module functions
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/mixed; boundary="00000000000094105405f4bfcfa0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 16:45:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14437

--00000000000094105405f4bfcfa0
Content-Type: multipart/alternative; boundary="00000000000094105205f4bfcf9e"

--00000000000094105205f4bfcf9e
Content-Type: text/plain; charset="UTF-8"

No, I haven't seen any error in bitbake-cookerdaemon.log, see attachment
(created with this change reverted and the same syntax error in qa.py).

On Wed, Feb 15, 2023 at 5:28 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2023-02-15 at 16:19 +0100, Martin Jansa wrote:
> > On Mon, Dec 12, 2022 at 5:03 PM Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > > Moving code into python modules is a very effective way to reduce
> > > parsing
> > > time and overhead in recipes. The downside has always been that any
> > > dependency information on which variables those functions access is
> > > lost
> > > and the hashes can therefore become less reliable.
> > >
> > > This patch adds parsing of the imported module functions and that
> > > dependency
> > > information is them injected back into the hash dependency
> > > information.
> > >
> > > Intermodule function references are resolved to the full function
> > > call names in our module namespace to ensure interfunction
> > > dependencies
> > > are correctly handled too.
> > >
> > > (Bitbake rev: 605c478ce14cdc3c02d6ef6d57146a76d436a83c)
> > >
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > >
> >
> > ...
> > > diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> > > index 862087c77d..375ba3cb79 100644
> > > --- a/lib/bb/parse/ast.py
> > > +++ b/lib/bb/parse/ast.py
> > > @@ -290,6 +290,18 @@ class PyLibNode(AstNode):
> > >              toimport = getattr(bb.utils._context[self.namespace],
> > > "BBIMPORTS", [])
> > >              for i in toimport:
> > >                  bb.utils._context[self.namespace] =
> > > __import__(self.namespace + "." + i)
> > > +                mod = getattr(bb.utils._context[self.namespace],
> > > i)
> > > +                fn = getattr(mod, "__file__")
> > > +                funcs = {}
> > > +                for f in dir(mod):
> > > +                    if f.startswith("_"):
> > > +                        continue
> > > +                    fcall = getattr(mod, f)
> > > +                    if not callable(fcall):
> > > +                        continue
> > > +                    funcs[f] = fcall
> > > +                bb.codeparser.add_module_functions(fn, funcs,
> > > "%s.%s" % (self.namespace, i))
> > > +
> > >          except AttributeError as e:
> > >              bb.error("Error importing OE modules: %s" % str(e))
> > >
> >
> >
> > Hi,
> >
> > a while ago I've mentioned that after making syntax error in metadata
> > I got no output at all from bitbake.
> >
> > I've narrowed it down to this chunk and the issue is that my syntax
> > error was in qa.py and it was failing in:
> > bb.utils._context[self.namespace] = __import__(self.namespace + "." +
> > i)
>
> Was there a traceback in bitbake-cookerdeamon.log for this before your
> patch?
>
> Cheers,
>
> Richard
>

--00000000000094105205f4bfcf9e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">No, I haven&#39;t seen any error in bitbake-cookerdaemon.l=
og, see attachment (created with this change reverted and the same syntax e=
rror in qa.py).</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Feb 15, 2023 at 5:28 PM Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundati=
on.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Wed, 2023-02-15 at 16:19 +0100, Martin Jansa wrote:<br>
&gt; On Mon, Dec 12, 2022 at 5:03 PM Richard Purdie<br>
&gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_b=
lank">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br>
&gt; &gt; Moving code into python modules is a very effective way to reduce=
<br>
&gt; &gt; parsing<br>
&gt; &gt; time and overhead in recipes. The downside has always been that a=
ny<br>
&gt; &gt; dependency information on which variables those functions access =
is<br>
&gt; &gt; lost<br>
&gt; &gt; and the hashes can therefore become less reliable.<br>
&gt; &gt; <br>
&gt; &gt; This patch adds parsing of the imported module functions and that=
<br>
&gt; &gt; dependency<br>
&gt; &gt; information is them injected back into the hash dependency<br>
&gt; &gt; information.<br>
&gt; &gt; <br>
&gt; &gt; Intermodule function references are resolved to the full function=
<br>
&gt; &gt; call names in our module namespace to ensure interfunction<br>
&gt; &gt; dependencies<br>
&gt; &gt; are correctly handled too.<br>
&gt; &gt; <br>
&gt; &gt; (Bitbake rev: 605c478ce14cdc3c02d6ef6d57146a76d436a83c)<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdi=
e@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org=
</a>&gt;<br>
&gt; &gt; <br>
&gt; <br>
&gt; ...=C2=A0<br>
&gt; &gt; diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py<br>
&gt; &gt; index 862087c77d..375ba3cb79 100644<br>
&gt; &gt; --- a/lib/bb/parse/ast.py<br>
&gt; &gt; +++ b/lib/bb/parse/ast.py<br>
&gt; &gt; @@ -290,6 +290,18 @@ class PyLibNode(AstNode):<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0toimport =3D geta=
ttr(bb.utils._context[self.namespace],<br>
&gt; &gt; &quot;BBIMPORTS&quot;, [])<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for i in toimport=
:<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.=
utils._context[self.namespace] =3D<br>
&gt; &gt; __import__(self.namespace + &quot;.&quot; + i)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod =3D =
getattr(bb.utils._context[self.namespace],<br>
&gt; &gt; i)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn =3D g=
etattr(mod, &quot;__file__&quot;)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 funcs =
=3D {}<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in=
 dir(mod):<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if f.startswith(&quot;_&quot;):<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 continue<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fcall =3D getattr(mod, f)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if not callable(fcall):<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 continue<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 funcs[f] =3D fcall<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.codep=
arser.add_module_functions(fn, funcs,<br>
&gt; &gt; &quot;%s.%s&quot; % (self.namespace, i))<br>
&gt; &gt; +<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except AttributeError as e:<br>
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.error(&quot;Er=
ror importing OE modules: %s&quot; % str(e))<br>
&gt; &gt; <br>
&gt; <br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; a while ago I&#39;ve mentioned that after making syntax error in metad=
ata<br>
&gt; I got no output at all from bitbake.<br>
&gt; <br>
&gt; I&#39;ve narrowed it down to this chunk and the issue is that my synta=
x<br>
&gt; error was in qa.py and it was failing in:<br>
&gt; bb.utils._context[self.namespace] =3D __import__(self.namespace + &quo=
t;.&quot; +<br>
&gt; i)<br>
<br>
Was there a traceback in bitbake-cookerdeamon.log for this before your<br>
patch?<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--00000000000094105205f4bfcf9e--

--00000000000094105405f4bfcfa0
Content-Type: text/x-log; charset="US-ASCII"; name="bitbake-cookerdaemon.log"
Content-Disposition: attachment; filename="bitbake-cookerdaemon.log"
Content-Transfer-Encoding: base64
Content-ID: <f_le5wlydo0>
X-Attachment-Id: f_le5wlydo0

NjAzOTgyIDE3OjQzOjI3Ljg0MDU3NiAtLS0gU3RhcnRpbmcgYml0YmFrZSBzZXJ2ZXIgcGlkIDYw
Mzk4MiBhdCAyMDIzLTAyLTE1IDE3OjQzOjI3Ljg0MDU0OSAtLS0KNjAzOTgyIDE3OjQzOjI3Ljg0
MTk4MiBTdGFydGVkIGJpdGJha2Ugc2VydmVyIHBpZCA2MDM5ODIKNjAzOTgyIDE3OjQzOjI3Ljg0
MjE3MSBFbnRlcmluZyBzZXJ2ZXIgY29ubmVjdGlvbiBsb29wCjYwMzk4MiAxNzo0MzoyNy44NDIy
MDkgTG9ja2ZpbGUgaXM6IC9PRS9idWlsZC9vZS1jb3JlL2JpdGJha2UubG9jawpTb2NrZXQgaXMg
L09FL2J1aWxkL29lLWNvcmUvYml0YmFrZS5zb2NrIChUcnVlKQo2MDM5ODIgMTc6NDM6MjcuODQy
OTI2IEFjY2VwdGluZyBbPHNvY2tldC5zb2NrZXQgZmQ9NiwgZmFtaWx5PTEsIHR5cGU9MSwgcHJv
dG89MCwgbGFkZHI9Yml0YmFrZS5zb2NrPl0gKFtdKQo2MDM5ODIgMTc6NDM6MjcuODQ0Mzc0IFBy
b2Nlc3NpbmcgQ2xpZW50CjYwMzk4MiAxNzo0MzoyNy44NDQ0MTkgQ29ubmVjdGluZyBDbGllbnQK
NjAzOTgyIDE3OjQzOjI3Ljg0NDczOSBSdW5uaW5nIGNvbW1hbmQgWydzZXRGZWF0dXJlcycsIFsy
LCAxXV0KNjAzOTgyIDE3OjQzOjI3Ljg0NDg5MiBDb21tYW5kIENvbXBsZXRlZCAoc29ja2V0OiBU
cnVlKQo2MDM5ODIgMTc6NDM6MjcuODQ2MDU4IFJ1bm5pbmcgY29tbWFuZCBbJ3VwZGF0ZUNvbmZp
ZycsIHsnaGFsdCc6IEZhbHNlLCAnZm9yY2UnOiBGYWxzZSwgJ2ludmFsaWRhdGVfc3RhbXAnOiBO
b25lLCAnZHJ5X3J1bic6IEZhbHNlLCAnZHVtcF9zaWduYXR1cmVzJzogW10sICdleHRyYV9hc3N1
bWVfcHJvdmlkZWQnOiBbXSwgJ3Byb2ZpbGUnOiBGYWxzZSwgJ3ByZWZpbGUnOiBbXSwgJ3Bvc3Rm
aWxlJzogW10sICdzZXJ2ZXJfdGltZW91dCc6IE5vbmUsICdub3NldHNjZW5lJzogRmFsc2UsICdz
ZXRzY2VuZW9ubHknOiBGYWxzZSwgJ3NraXBzZXRzY2VuZSc6IEZhbHNlLCAncnVuYWxsJzogW10s
ICdydW5vbmx5JzogTm9uZSwgJ3dyaXRlZXZlbnRsb2cnOiBOb25lLCAnYnVpbGRfdmVyYm9zZV9z
aGVsbCc6IEZhbHNlLCAnYnVpbGRfdmVyYm9zZV9zdGRvdXQnOiBGYWxzZSwgJ2RlZmF1bHRfbG9n
bGV2ZWwnOiAyMCwgJ2RlYnVnX2RvbWFpbnMnOiB7fX0sIHsnU0hFTEwnOiAnL2Jpbi9iYXNoJywg
J0JCX0VOVl9QQVNTVEhST1VHSF9BRERJVElPTlMnOiAnTUFDSElORSBESVNUUk8gaHR0cF9wcm94
eSBmdHBfcHJveHkgaHR0cHNfcHJveHkgYWxsX3Byb3h5IEFMTF9QUk9YWSBub19wcm94eSBTU0hf
QUdFTlRfUElEIFNTSF9BVVRIX1NPQ0sgQkJfU1JDUkVWX1BPTElDWSBTREtNQUNISU5FIEJCX05V
TUJFUl9USFJFQURTIEdJVF9QUk9YWV9DT01NQU5EIFBTRVVET19ESVNBQkxFRCBQU0VVRE9fQlVJ
TEQnLCAnU1NIX0FVVEhfU09DSyc6ICcvdG1wL3NzaC1YWFhYWFg3YXVtSzYvYWdlbnQuMjA0Mycs
ICdTU0hfQUdFTlRfUElEJzogJzIwNDQnLCAnUFdEJzogJy9PRS9idWlsZC9vZS1jb3JlJywgJ0xP
R05BTUUnOiAnJywgJ0hPTUUnOiAnL2hvbWUvdXNlcicsICdNQUNISU5FJzogJ3FlbXV4ODYtNjQn
LCAnVVNFUic6ICd1c2VyJywgJ0xDX0FMTCc6ICdlbl9VUy5VVEYtOCcsICdQQVRIJzogJy9PRS9i
dWlsZC9vZS1jb3JlL29wZW5lbWJlZGRlZC1jb3JlL3NjcmlwdHM6L09FL2J1aWxkL29lLWNvcmUv
Yml0YmFrZS9iaW46L2hvbWUvdXNlci9iaW46L3Vzci9sb2NhbC9zYmluOi91c3IvbG9jYWwvYmlu
Oi91c3IvYmluOi9vcHQvYmluOi91c3IvbGliL2xsdm0vMTUvYmluOi9vcHQvYW5kcm9pZC1zZGst
dXBkYXRlLW1hbmFnZXIvdG9vbHM6L29wdC9hbmRyb2lkLXNkay11cGRhdGUtbWFuYWdlci9wbGF0
Zm9ybS10b29sczovZXRjL2VzZWxlY3Qvd2luZS9iaW46L3Vzci9saWI2NC9vcGVuY2FzY2FkZS9i
aW46L3Zhci9saWIvc25hcGQvc25hcC9iaW4nLCAnU0VTU0lPTl9NQU5BR0VSJzogJ2xvY2FsL2ph
bWE6QC90bXAvLklDRS11bml4LzE5OTcsdW5peC9qYW1hOi90bXAvLklDRS11bml4LzE5OTcnLCAn
V0lORE9XSUQnOiAnMzM1NTQ0MzUnLCAnQ09MT1JURVJNJzogJ3RydWVjb2xvcicsICdDU0ZfTURU
VlRleHR1cmVzRGlyZWN0b3J5JzogJy91c3Ivc2hhcmUvb3BlbmNhc2NhZGUvcmVzb3VyY2VzL1Rl
eHR1cmVzJywgJ1hER19DT05GSUdfRElSUyc6ICcvZXRjL3hkZycsICdMRVNTJzogJy1SIC1NIC0t
c2hpZnQgNScsICdYREdfU0VTU0lPTl9QQVRIJzogJy9vcmcvZnJlZWRlc2t0b3AvRGlzcGxheU1h
bmFnZXIvU2Vzc2lvbjEnLCAnWERHX01FTlVfUFJFRklYJzogJ3hmY2UtJywgJ0pES19IT01FJzog
Jy9ldGMvamF2YS1jb25maWctMi9jdXJyZW50LXN5c3RlbS12bScsICdDT05GSUdfUFJPVEVDVF9N
QVNLJzogJy9ldGMvc2FuZGJveC5kIC9ldGMvZm9udHMvZm9udHMuY29uZiAvZXRjL2dlbnRvby1y
ZWxlYXNlIC9ldGMvZGNvbmYgL2V0Yy9jYS1jZXJ0aWZpY2F0ZXMuY29uZiAvZXRjL3JldmRlcC1y
ZWJ1aWxkJywgJ1RFUk1DQVAnOiAnU0N8c2NyZWVuLnh0ZXJtLTI1NmNvbG9yfFZUIDEwMC9BTlNJ
IFgzLjY0IHZpcnR1YWwgdGVybWluYWw6RE89XFxFWyVkQjpMRT1cXEVbJWREOlJJPVxcRVslZEM6
VVA9XFxFWyVkQTpiczpidD1cXEVbWjpjZD1cXEVbSjpjZT1cXEVbSzpjbD1cXEVbSFxcRVtKOmNt
PVxcRVslaSVkOyVkSDpjdD1cXEVbM2c6ZG89Xko6bmQ9XFxFW0M6cHQ6cmM9XFxFODpycz1cXEVj
OnNjPVxcRTc6c3Q9XFxFSDp1cD1cXEVNOmxlPV5IOmJsPV5HOmNyPV5NOml0Izg6aG89XFxFW0g6
bnc9XFxFRTp0YT1eSTppcz1cXEUpMDpsaSM2MzpjbyMyMzg6YW06eG46eHY6TFA6c3I9XFxFTTph
bD1cXEVbTDpBTD1cXEVbJWRMOmNzPVxcRVslaSVkOyVkcjpkbD1cXEVbTTpETD1cXEVbJWRNOmRj
PVxcRVtQOkRDPVxcRVslZFA6aW09XFxFWzRoOmVpPVxcRVs0bDptaTpJQz1cXEVbJWRAOmtzPVxc
RVs/MWhcXEU9OmtlPVxcRVs/MWxcXEU+OnZpPVxcRVs/MjVsOnZlPVxcRVszNGhcXEVbPzI1aDp2
cz1cXEVbMzRsOnRpPVxcRVs/MTA0OWg6dGU9XFxFWz8xMDQ5bDp1cz1cXEVbNG06dWU9XFxFWzI0
bTpzbz1cXEVbM206c2U9XFxFWzIzbTptYj1cXEVbNW06bWQ9XFxFWzFtOm1oPVxcRVsybTptcj1c
XEVbN206bWU9XFxFW206bXM6Q28jODpwYSM2NDpBRj1cXEVbMyVkbTpBQj1cXEVbNCVkbTpvcD1c
XEVbMzk7NDltOkFYOnZiPVxcRWc6RzA6YXM9XFxFKDA6YWU9XFxFKEI6YWM9XFwxNDBcXDE0MGFh
ZmZnZ2pqa2tsbG1tbm5vb3BwcXFycnNzdHR1dXZ2d3d4eHl5enp7e3x8fX1+fi4uLS0rKywsaGhJ
STAwOnBvPVxcRVs1aTpwZj1cXEVbNGk6WjA9XFxFWz8zaDpaMT1cXEVbPzNsOkttPVxcRVs8Omsw
PVxcRVsxMH46azE9XFxFT1A6azI9XFxFT1E6azM9XFxFT1I6azQ9XFxFT1M6azU9XFxFWzE1fjpr
Nj1cXEVbMTd+Oms3PVxcRVsxOH46azg9XFxFWzE5fjprOT1cXEVbMjB+Oms7PVxcRVsyMX46RjE9
XFxFWzIzfjpGMj1cXEVbMjR+OmtCPVxcRVtaOmtoPVxcRVsxfjpAMT1cXEVbMX46a0g9XFxFWzR+
OkA3PVxcRVs0fjprTj1cXEVbNn46a1A9XFxFWzV+OmtJPVxcRVsyfjprRD1cXEVbM346a3U9XFxF
T0E6a2Q9XFxFT0I6a3I9XFxFT0M6a2w9XFxFT0Q6a206JywgJ0pBVkFfSE9NRSc6ICcvZXRjL2ph
dmEtY29uZmlnLTIvY3VycmVudC1zeXN0ZW0tdm0nLCAnQ1NGX01JR1JBVElPTl9UWVBFUyc6ICcv
dXNyL3NoYXJlL29wZW5jYXNjYWRlL3Jlc291cmNlcy9TdGRSZXNvdXJjZS9NaWdyYXRpb25TaGVl
dC50eHQnLCAnV0lORE9XJzogJzInLCAnQU5UX0hPTUUnOiAnL3Vzci9zaGFyZS9hbnQnLCAnREVT
S1RPUF9TRVNTSU9OJzogJy91c3Ivc2hhcmUveHNlc3Npb25zL3hmY2UnLCAnQ1NGX1NURVBEZWZh
dWx0cyc6ICcvdXNyL3NoYXJlL29wZW5jYXNjYWRlL3Jlc291cmNlcy9YU1RFUFJlc291cmNlJywg
J0VESVRPUic6ICd2aW0nLCAnR1RLX01PRFVMRVMnOiAnY2FuYmVycmEtZ3RrLW1vZHVsZScsICdY
REdfU0VBVCc6ICdzZWF0MCcsICdDT05GSUdfUFJPVEVDVCc6ICcvdXNyL3NoYXJlL2dudXBnL3F1
YWxpZmllZC50eHQgL3Vzci9zaGFyZS9lYXN5LXJzYSAvdXNyL3NoYXJlL2NvbmZpZyAvdXNyL2xp
YjY0L2xpYnJlb2ZmaWNlL3Byb2dyYW0vc29mZmljZXJjJywgJ1hER19TRVNTSU9OX0RFU0tUT1An
OiAnWEZDRScsICdYREdfU0VTU0lPTl9UWVBFJzogJ3gxMScsICdQQU5FTF9HREtfQ09SRV9ERVZJ
Q0VfRVZFTlRTJzogJzAnLCAnTUFOUEFUSCc6ICcvZXRjL2phdmEtY29uZmlnLTIvY3VycmVudC1z
eXN0ZW0tdm0vbWFuOi91c3Ivc2hhcmUvZ2NjLWRhdGEveDg2XzY0LXBjLWxpbnV4LWdudS8xMi9t
YW46L3Vzci9zaGFyZS9iaW51dGlscy1kYXRhL3g4Nl82NC1wYy1saW51eC1nbnUvMi40MC9tYW46
L2V0Yy9qYXZhLWNvbmZpZy0yL2N1cnJlbnQtc3lzdGVtLXZtL21hbi86L3Vzci9sb2NhbC9zaGFy
ZS9tYW46L3Vzci9zaGFyZS9tYW46L3Vzci9saWIvcnVzdC9tYW46L3Vzci9saWIvbGx2bS8xNS9z
aGFyZS9tYW46L2V0Yy9lc2VsZWN0L3dpbmUvc2hhcmUvbWFuJywgJ1hBVVRIT1JJVFknOiAnL2hv
bWUvdXNlci8uWGF1dGhvcml0eScsICdDU0ZfU3RhbmRhcmRMaXRlRGVmYXVsdHMnOiAnL3Vzci9z
aGFyZS9vcGVuY2FzY2FkZS9yZXNvdXJjZXMvU3RkUmVzb3VyY2UnLCAnT1BFTkNMX1BST0ZJTEUn
OiAnbnZpZGlhJywgJ01PVERfU0hPV04nOiAncGFtJywgJ0dETV9MQU5HJzogJ0MuVVRGLTgnLCAn
TEFORyc6ICdDJywgJ0xTX0NPTE9SUyc6ICdycz0wOmRpPTAxOzM0OmxuPTAxOzM2Om1oPTAwOnBp
PTQwOzMzOnNvPTAxOzM1OmRvPTAxOzM1OmJkPTQwOzMzOzAxOmNkPTQwOzMzOzAxOm9yPTAxOzA1
OzM3OzQxOm1pPTAxOzA1OzM3OzQxOnN1PTM3OzQxOnNnPTMwOzQzOmNhPTAwOnR3PTMwOzQyOm93
PTM0OzQyOnN0PTM3OzQ0OmV4PTAxOzMyOioudGFyPTAxOzMxOioudGd6PTAxOzMxOiouYXJjPTAx
OzMxOiouYXJqPTAxOzMxOioudGF6PTAxOzMxOioubGhhPTAxOzMxOioubHo0PTAxOzMxOioubHpo
PTAxOzMxOioubHptYT0wMTszMToqLnRsej0wMTszMToqLnR4ej0wMTszMToqLnR6bz0wMTszMToq
LnQ3ej0wMTszMToqLnppcD0wMTszMToqLno9MDE7MzE6Ki5kej0wMTszMToqLmd6PTAxOzMxOiou
bHJ6PTAxOzMxOioubHo9MDE7MzE6Ki5sem89MDE7MzE6Ki54ej0wMTszMToqLnpzdD0wMTszMToq
LnR6c3Q9MDE7MzE6Ki5iejI9MDE7MzE6Ki5iej0wMTszMToqLnRiej0wMTszMToqLnRiejI9MDE7
MzE6Ki50ej0wMTszMToqLmRlYj0wMTszMToqLnJwbT0wMTszMToqLmphcj0wMTszMToqLndhcj0w
MTszMToqLmVhcj0wMTszMToqLnNhcj0wMTszMToqLnJhcj0wMTszMToqLmFsej0wMTszMToqLmFj
ZT0wMTszMToqLnpvbz0wMTszMToqLmNwaW89MDE7MzE6Ki43ej0wMTszMToqLnJ6PTAxOzMxOiou
Y2FiPTAxOzMxOioud2ltPTAxOzMxOiouc3dtPTAxOzMxOiouZHdtPTAxOzMxOiouZXNkPTAxOzMx
OiouYXZpZj0wMTszNToqLmpwZz0wMTszNToqLmpwZWc9MDE7MzU6Ki5tanBnPTAxOzM1OioubWpw
ZWc9MDE7MzU6Ki5naWY9MDE7MzU6Ki5ibXA9MDE7MzU6Ki5wYm09MDE7MzU6Ki5wZ209MDE7MzU6
Ki5wcG09MDE7MzU6Ki50Z2E9MDE7MzU6Ki54Ym09MDE7MzU6Ki54cG09MDE7MzU6Ki50aWY9MDE7
MzU6Ki50aWZmPTAxOzM1OioucG5nPTAxOzM1Oiouc3ZnPTAxOzM1Oiouc3Znej0wMTszNToqLm1u
Zz0wMTszNToqLnBjeD0wMTszNToqLm1vdj0wMTszNToqLm1wZz0wMTszNToqLm1wZWc9MDE7MzU6
Ki5tMnY9MDE7MzU6Ki5ta3Y9MDE7MzU6Ki53ZWJtPTAxOzM1Oioud2VicD0wMTszNToqLm9nbT0w
MTszNToqLm1wND0wMTszNToqLm00dj0wMTszNToqLm1wNHY9MDE7MzU6Ki52b2I9MDE7MzU6Ki5x
dD0wMTszNToqLm51dj0wMTszNToqLndtdj0wMTszNToqLmFzZj0wMTszNToqLnJtPTAxOzM1Oiou
cm12Yj0wMTszNToqLmZsYz0wMTszNToqLmF2aT0wMTszNToqLmZsaT0wMTszNToqLmZsdj0wMTsz
NToqLmdsPTAxOzM1OiouZGw9MDE7MzU6Ki54Y2Y9MDE7MzU6Ki54d2Q9MDE7MzU6Ki55dXY9MDE7
MzU6Ki5jZ209MDE7MzU6Ki5lbWY9MDE7MzU6Ki5vZ3Y9MDE7MzU6Ki5vZ3g9MDE7MzU6Ki5jZmc9
MDA7MzI6Ki5jb25mPTAwOzMyOiouZGlmZj0wMDszMjoqLmRvYz0wMDszMjoqLmluaT0wMDszMjoq
LmxvZz0wMDszMjoqLnBhdGNoPTAwOzMyOioucGRmPTAwOzMyOioucHM9MDA7MzI6Ki50ZXg9MDA7
MzI6Ki50eHQ9MDA7MzI6Ki5hYWM9MDA7MzY6Ki5hdT0wMDszNjoqLmZsYWM9MDA7MzY6Ki5tNGE9
MDA7MzY6Ki5taWQ9MDA7MzY6Ki5taWRpPTAwOzM2OioubWthPTAwOzM2OioubXAzPTAwOzM2Oiou
bXBjPTAwOzM2Oioub2dnPTAwOzM2OioucmE9MDA7MzY6Ki53YXY9MDA7MzY6Ki5vZ2E9MDA7MzY6
Ki5vcHVzPTAwOzM2Oiouc3B4PTAwOzM2OioueHNwZj0wMDszNjoqfj0wMDs5MDoqIz0wMDs5MDoq
LmJhaz0wMDs5MDoqLm9sZD0wMDs5MDoqLm9yaWc9MDA7OTA6Ki5wYXJ0PTAwOzkwOioucmVqPTAw
OzkwOiouc3dwPTAwOzkwOioudG1wPTAwOzkwOiouZHBrZy1kaXN0PTAwOzkwOiouZHBrZy1vbGQ9
MDA7OTA6Ki51Y2YtZGlzdD0wMDs5MDoqLnVjZi1uZXc9MDA7OTA6Ki51Y2Ytb2xkPTAwOzkwOiou
cnBtbmV3PTAwOzkwOioucnBtb3JpZz0wMDs5MDoqLnJwbXNhdmU9MDA7OTA6JywgJ1hER19DVVJS
RU5UX0RFU0tUT1AnOiAnWEZDRScsICdWVEVfVkVSU0lPTic6ICc3MDAzJywgJ0NTRl9HcmFwaGlj
U2hyJzogJy91c3IvbGliNjQvb3BlbmNhc2NhZGUvbGliVEtPcGVuR2wuc28nLCAnT1BFTkdMX1BS
T0ZJTEUnOiAneG9yZy14MTEnLCAnWERHX1NFQVRfUEFUSCc6ICcvb3JnL2ZyZWVkZXNrdG9wL0Rp
c3BsYXlNYW5hZ2VyL1NlYXQwJywgJ1FUX0dSQVBISUNTU1lTVEVNJzogJ3Jhc3RlcicsICdYWl9P
UFQnOiAnLVQwJywgJ0NTRl9TaGFkZXJzRGlyZWN0b3J5JzogJy91c3Ivc2hhcmUvb3BlbmNhc2Nh
ZGUvcmVzb3VyY2VzL1NoYWRlcnMnLCAnQ1NGX1htbE9jYWZSZXNvdXJjZSc6ICcvdXNyL3NoYXJl
L29wZW5jYXNjYWRlL3Jlc291cmNlcy9YbWxPY2FmUmVzb3VyY2UnLCAnSU5GT1BBVEgnOiAnL3Vz
ci9zaGFyZS9nY2MtZGF0YS94ODZfNjQtcGMtbGludXgtZ251LzEyL2luZm86L3Vzci9zaGFyZS9i
aW51dGlscy1kYXRhL3g4Nl82NC1wYy1saW51eC1nbnUvMi40MC9pbmZvOi91c3Ivc2hhcmUvaW5m
bycsICdNT1pfR01QX1BBVEgnOiAnL3Vzci9saWI2NC9uc2Jyb3dzZXIvcGx1Z2lucy9nbXAtZ21w
b3BlbmgyNjQvc3lzdGVtLWluc3RhbGxlZCcsICdDU0ZfU0hNZXNzYWdlJzogJy91c3Ivc2hhcmUv
b3BlbmNhc2NhZGUvcmVzb3VyY2VzL1NITWVzc2FnZScsICdKQVZBQyc6ICcvZXRjL2phdmEtY29u
ZmlnLTIvY3VycmVudC1zeXN0ZW0tdm0vYmluL2phdmFjJywgJ1hER19TRVNTSU9OX0NMQVNTJzog
J3VzZXInLCAnQU5EUk9JRF9IT01FJzogJy9vcHQvYW5kcm9pZC1zZGstdXBkYXRlLW1hbmFnZXIn
LCAnVEVSTSc6ICdzY3JlZW4ueHRlcm0tMjU2Y29sb3InLCAnTEVTU09QRU4nOiAnfGxlc3NwaXBl
ICVzJywgJ0FORFJPSURfU1dUJzogJy91c3Ivc2hhcmUvc3d0LTMuNy9saWInLCAnQ1NGX1N0YW5k
YXJkRGVmYXVsdHMnOiAnL3Vzci9zaGFyZS9vcGVuY2FzY2FkZS9yZXNvdXJjZXMvU3RkUmVzb3Vy
Y2UnLCAnQ1NGX0lHRVNEZWZhdWx0cyc6ICcvdXNyL3NoYXJlL29wZW5jYXNjYWRlL3Jlc291cmNl
cy9YU1RFUFJlc291cmNlJywgJ01BTlBBR0VSJzogJ21hbnBhZ2VyJywgJ05QTV9DT05GSUdfR0xP
QkFMQ09ORklHJzogJy9ldGMvbnBtL25wbXJjJywgJ0RJU1BMQVknOiAnOjAuMCcsICdDU0ZfWENB
RkRlZmF1bHRzJzogJy91c3Ivc2hhcmUvb3BlbmNhc2NhZGUvcmVzb3VyY2VzL1N0ZFJlc291cmNl
JywgJ1NITFZMJzogJzInLCAnUEFHRVInOiAnL3Vzci9iaW4vbGVzcycsICdMRVgnOiAnZmxleCcs
ICdYREdfVlROUic6ICcxJywgJ0NTRl9QbHVnaW5EZWZhdWx0cyc6ICcvdXNyL3NoYXJlL29wZW5j
YXNjYWRlL3Jlc291cmNlcy9TdGRSZXNvdXJjZScsICdYREdfU0VTU0lPTl9JRCc6ICcyJywgJ0NB
U1JPT1QnOiAnL3VzcicsICdMRF9MSUJSQVJZX1BBVEgnOiAnJywgJ1hER19SVU5USU1FX0RJUic6
ICcvcnVuL3VzZXIvMTAyNicsICdHQ0NfU1BFQ1MnOiAnJywgJ0dTRVRUSU5HU19CQUNLRU5EJzog
J2Rjb25mJywgJ0NTRl9YU01lc3NhZ2UnOiAnL3Vzci9zaGFyZS9vcGVuY2FzY2FkZS9yZXNvdXJj
ZXMvWFNNZXNzYWdlJywgJ1hER19EQVRBX0RJUlMnOiAnL3Vzci9sb2NhbC9zaGFyZTovdXNyL3No
YXJlOi9ldGMvZXNlbGVjdC93aW5lL3NoYXJlOi92YXIvbGliL3NuYXBkL2Rlc2t0b3AnLCAnQ1NG
X1VuaXRzRGVmaW5pdGlvbic6ICcvdXNyL3NoYXJlL29wZW5jYXNjYWRlL3Jlc291cmNlcy9Vbml0
c0FQSS9Vbml0cy5kYXQnLCAnU1RZJzogJzIyODIueCcsICdWQk9YX0FQUF9IT01FJzogJy91c3Iv
bGliNjQvdmlydHVhbGJveCcsICdEQlVTX1NFU1NJT05fQlVTX0FERFJFU1MnOiAndW5peDpwYXRo
PS9ydW4vdXNlci8xMDI2L2J1cycsICdCVUlMRERJUic6ICcvT0UvYnVpbGQvb2UtY29yZScsICdN
QUlMJzogJy92YXIvbWFpbC91c2VyJywgJ09MRFBXRCc6ICcvT0UvYnVpbGQvb2UtY29yZS9iaXRi
YWtlJywgJ18nOiAnL09FL2J1aWxkL29lLWNvcmUvYml0YmFrZS9iaW4vYml0YmFrZSd9LCBbJy9P
RS9idWlsZC9vZS1jb3JlL2JpdGJha2UvYmluL2JpdGJha2UnLCAnLWsnLCAnemxpYi1uYXRpdmUn
XV0KL09FL2J1aWxkL29lLWNvcmUvb3BlbmVtYmVkZGVkLWNvcmUvbWV0YS9saWIvb2UvcGFja2Fn
ZS5weToxMTogRGVwcmVjYXRpb25XYXJuaW5nOiAncGlwZXMnIGlzIGRlcHJlY2F0ZWQgYW5kIHNs
YXRlZCBmb3IgcmVtb3ZhbCBpbiBQeXRob24gMy4xMwogIGltcG9ydCBwaXBlcwo2MDM5ODIgMTc6
NDM6MjguNDQzNzg0IENvbW1hbmQgQ29tcGxldGVkIChzb2NrZXQ6IFRydWUpCjYwMzk4MiAxNzo0
MzoyOC41OTUyODcgUHJvY2Vzc2luZyBDbGllbnQKNjAzOTgyIDE3OjQzOjI4LjU5NTM5OSBEaXNj
b25uZWN0aW5nIENsaWVudCAoc29ja2V0OiBUcnVlKQo2MDM5ODIgMTc6NDM6MjguNTk1NTc4IE5v
IHRpbWVvdXQsIGV4aXRpbmcuCjYwMzk4MiAxNzo0MzoyOC42OTU4NTggRXhpdGluZyAoc29ja2V0
OiBUcnVlKQo2MDM5ODIgMTc6NDM6MjguNzAwMzI3IEV4aXRpbmcgYXMgd2UgY291bGQgb2J0YWlu
IHRoZSBsb2NrCnN5czoxOiBSZXNvdXJjZVdhcm5pbmc6IHVuY2xvc2VkIGZpbGUgPF9pby5UZXh0
SU9XcmFwcGVyIG5hbWU9Jy9PRS9idWlsZC9vZS1jb3JlL2JpdGJha2UtY29va2VyZGFlbW9uLmxv
ZycgbW9kZT0nYSsnIGVuY29kaW5nPSdVVEYtOCc+Cg==
--00000000000094105405f4bfcfa0--

