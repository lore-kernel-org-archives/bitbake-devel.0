Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706F6E67802
	for <webhook@archiver.kernel.org>; Sat,  2 Nov 2024 15:55:10 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web10.19499.1730562909473507460
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Nov 2024 08:55:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L9iMOOUs;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539d9fffea1so3016351e87.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 02 Nov 2024 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730562907; x=1731167707; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7wD+ulkkVxBl6P49pTMazfN9YYGHDX6stPBX2gAbEDQ=;
        b=L9iMOOUscdvSQPuL2u1L9FAqnFuDWNgLR7R/uksL5vMdJSSsAJ6m0YU7eKjT++ec4W
         u66mGndU7X5FLMryTmjDygQa1XHNcCb0uZrrLERXAxu4VlY4nc41XNPaHT1CWGEoV52/
         ynt0Wj228+MZKhSzTGPTYu4l6vj3yxJ5TV49/EWv4HwbdN1H+NYFNJgEuj5kyKc4jMbF
         c/o3ldogsi2uKHYZbL/GmxONhhnuaX56Y/TOuKM12L78BpArK5ch0trht16F9A/CxLqZ
         AH9ufpdJ8qFZnS9PLxKs739Ie0X12Jhg2ikaZ0rvVToLkh2Yn8pdzLgGZBb3qw1K1RKe
         pxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730562907; x=1731167707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wD+ulkkVxBl6P49pTMazfN9YYGHDX6stPBX2gAbEDQ=;
        b=VLgFI3hfhYXQOSon3r/ct1P+RkTaxskOdqgLKnJ2gb0aoBf0udCSHNZONU3RRuGSj0
         k8JkFt7Ys6VYuceHTmiLTTeQOrYOmQYDUo1K7zEY3YKrETRmp4A1cl2uN/8s3HW2Oobm
         E5/iZJ0OruObcA2iMeJkx8Kc9Jn4HCjeilupCZIQOdgbf7jLpdlI4tK91ny0zRWXGPON
         fJr3hwVLGfsrNys1O3yZfJu1zKqcrCNmG4QR4YsCuRwwGP1hJWSiuzXfknW2wb16r+mh
         D0V3LkG90AzIieGyrHVaqQcG3eFWGghzaktfdoeaaa3XSRd7+/qT5zZC8wICcIIkTLYw
         94Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUfhsIlj+NXyJ9rKTj8RsOpgV598km0aKcBmbfFDuxlD+OjOVlD+DvOywTxTDaSSW6wK2rdcSkpQKXNZKDr@lists.openembedded.org
X-Gm-Message-State: AOJu0YxFADIGKngMqrWlNdiWhuvVkhmBtd2wgrogqJsrO7ZBX/1hzU5R
	ay1qJY5bCHRm3mhpwBpMut/aElJFKmWYxrSOZFE1/RG5TSu5FqUtZk5ARN0l409meXmC41cGzNE
	11AoYnzATYXpHM8GeGaYcMET/dR0=
X-Google-Smtp-Source: AGHT+IFH0S9CqwDw6vObn1YKz/Amt6F8UlmAi+FEdEHSk9htgsEZUFzCZTehJomqpTDTUVKS8G38XTmhWY9VU7T1HQA=
X-Received: by 2002:a05:6512:159d:b0:539:e23a:9eaa with SMTP id
 2adb3069b0e04-53b34c8db64mr13874613e87.50.1730562907077; Sat, 02 Nov 2024
 08:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241031120015.3651707-1-jose.quaresma@foundries.io> <863880dddca8a8e37fa350e0baf69ac682c9bd07.camel@linuxfoundation.org>
In-Reply-To: <863880dddca8a8e37fa350e0baf69ac682c9bd07.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Sat, 2 Nov 2024 09:54:55 -0600
Message-ID: <CAJdd5Gb6c0yUx9HB8eH6vfQ6hhwjrAA0biNvSnqtTKXkn1Nyqw@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][PATCH 1/2] bitbake: hashserv: client:
 immediately test the server address
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Jose Quaresma <quaresma.jose@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Jose Quaresma <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="0000000000005682840625f0137e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 02 Nov 2024 15:55:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16770

--0000000000005682840625f0137e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I don't have the code in front of me, but this is almost certainly because
the websockets and TCP sockets take different address types. IIRC TCP uses
a tuple of (address, port), while websockets takes a URL. As such, I don't
think you can use create_connection for both.

On Sat, Nov 2, 2024, 8:14=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2024-10-31 at 12:00 +0000, Jose Quaresma via
> lists.openembedded.org wrote:
> > Test as soon as possible if it is possible to connect to the server
> > and use raw socket for this, which is much simpler and works for what
> you want.
> >
> > Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
> > ---
> >  bitbake/lib/hashserv/__init__.py | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/bitbake/lib/hashserv/__init__.py
> b/bitbake/lib/hashserv/__init__.py
> > index ac891e0174..47b25fa6ab 100644
> > --- a/bitbake/lib/hashserv/__init__.py
> > +++ b/bitbake/lib/hashserv/__init__.py
> > @@ -82,6 +82,15 @@ def create_client(addr, username=3DNone, password=3D=
None):
> >              c.connect_websocket(*a)
> >          else:
> >              c.connect_tcp(*a)
> > +
> > +        # test the connection now
> > +        import socket
> > +        try:
> > +            sock =3D socket.create_connection(a, timeout=3D5)
> > +            sock.close()
> > +        except socket.error as e:
> > +            raise ConnectionError
> > +
> >          return c
> >      except Exception as e:
> >          c.close()
>
> This didn't work, see below. Copying Joshua for comment on these.
>
> ERROR: Running idle function
> Traceback (most recent call last):
>   File "/usr/lib/python3.11/contextlib.py", line 137, in
> _GeneratorContextManager.__enter__():
>              try:
>     >            return next(self.gen)
>              except StopIteration:
>   File "/mnt/b/yoe/master/sources/poky/bitbake/lib/bb/siggen.py", line
> 589, in SignatureGeneratorOEEquivHash.client():
>                  if getattr(self, '_client', None) is None:
>     >                self._client =3D hashserv.create_client(self.server,
> **self.get_hashserv_creds())
>                  yield self._client
>   File "/mnt/b/yoe/master/sources/poky/bitbake/lib/hashserv/__init__.py",
> line 97, in create_client(addr=3D'unix:///mnt/b/yoe/master/hashserve.sock=
',
> username=3DNone, password=3DNone):
>              c.close()
>     >        raise e
>
>   File "/mnt/b/yoe/master/sources/poky/bitbake/lib/hashserv/__init__.py",
> line 89, in create_client(addr=3D'unix:///mnt/b/yoe/master/hashserve.sock=
',
> username=3DNone, password=3DNone):
>              try:
>     >            sock =3D socket.create_connection(a, timeout=3D5)
>                  sock.close()
>   File "/usr/lib/python3.11/socket.py", line 825, in
> create_connection(address=3D('/mnt/b/yoe/master/hashserve.sock',), timeou=
t=3D5,
> source_address=3DNone, all_errors=3DFalse):
>
>     >    host, port =3D address
>          exceptions =3D []
> ValueError: not enough values to unpack (expected 2, got 1)
>
>
> Cheers,
>
> Richard
>
>

--0000000000005682840625f0137e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I don&#39;t have the code in front of me, but this is alm=
ost certainly because the websockets and TCP sockets take different address=
 types. IIRC TCP uses a tuple of (address, port), while websockets takes a =
URL. As such, I don&#39;t think you can use create_connection for both.</di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On S=
at, Nov 2, 2024, 8:14=E2=80=AFAM Richard Purdie &lt;<a href=3D"mailto:richa=
rd.purdie@linuxfoundation.org" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">On Thu, 2024-10-31 at 12:00 +0000, Jose Quaresma via <a =
href=3D"http://lists.openembedded.org" rel=3D"noreferrer noreferrer norefer=
rer noreferrer" target=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; Test as soon as possible if it is possible to connect to the server<br=
>
&gt; and use raw socket for this, which is much simpler and works for what =
you want.<br>
&gt; <br>
&gt; Signed-off-by: Jose Quaresma &lt;<a href=3D"mailto:jose.quaresma@found=
ries.io" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">jose.qu=
aresma@foundries.io</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0bitbake/lib/hashserv/__init__.py | 9 +++++++++<br>
&gt; =C2=A01 file changed, 9 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/_=
_init__.py<br>
&gt; index ac891e0174..47b25fa6ab 100644<br>
&gt; --- a/bitbake/lib/hashserv/__init__.py<br>
&gt; +++ b/bitbake/lib/hashserv/__init__.py<br>
&gt; @@ -82,6 +82,15 @@ def create_client(addr, username=3DNone, password=
=3DNone):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 c.connect_websocket(*a)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 c.connect_tcp(*a)<br>
&gt; +<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # test the connection now<=
br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 import socket<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 so=
ck =3D socket.create_connection(a, timeout=3D5)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 so=
ck.close()<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except socket.error as e:<=
br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ra=
ise ConnectionError<br>
&gt; +<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return c<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 except Exception as e:<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c.close()<br>
<br>
This didn&#39;t work, see below. Copying Joshua for comment on these.<br>
<br>
ERROR: Running idle function<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;/usr/lib/python3.11/contextlib.py&quot;, line 137, in _Ge=
neratorContextManager.__enter__():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return next(sel=
f.gen)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except StopIteration:<br>
=C2=A0 File &quot;/mnt/b/yoe/master/sources/poky/bitbake/lib/bb/siggen.py&q=
uot;, line 589, in SignatureGeneratorOEEquivHash.client():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if getattr(se=
lf, &#39;_client&#39;, None) is None:<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
elf._client =3D hashserv.create_client(self.server, **self.get_hashserv_cre=
ds())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0yield self._c=
lient<br>
=C2=A0 File &quot;/mnt/b/yoe/master/sources/poky/bitbake/lib/hashserv/__ini=
t__.py&quot;, line 97, in create_client(addr=3D&#39;unix:///mnt/b/yoe/maste=
r/hashserve.sock&#39;, username=3DNone, password=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c.close()<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise e<br>
<br>
=C2=A0 File &quot;/mnt/b/yoe/master/sources/poky/bitbake/lib/hashserv/__ini=
t__.py&quot;, line 89, in create_client(addr=3D&#39;unix:///mnt/b/yoe/maste=
r/hashserve.sock&#39;, username=3DNone, password=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sock =3D socket=
.create_connection(a, timeout=3D5)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sock.close()<=
br>
=C2=A0 File &quot;/usr/lib/python3.11/socket.py&quot;, line 825, in create_=
connection(address=3D(&#39;/mnt/b/yoe/master/hashserve.sock&#39;,), timeout=
=3D5, source_address=3DNone, all_errors=3DFalse):<br>
<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 host, port =3D address<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exceptions =3D []<br>
ValueError: not enough values to unpack (expected 2, got 1)<br>
<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--0000000000005682840625f0137e--

