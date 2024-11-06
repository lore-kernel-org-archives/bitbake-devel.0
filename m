Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD32D44D4C
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 11:07:56 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
 by mx.groups.io with SMTP id smtpd.web11.43336.1730891268983178834
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Nov 2024 03:07:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Slg5/UsO;
 spf=pass (domain: gmail.com, ip: 209.85.222.46, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84fcb49691fso2434217241.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 03:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730891268; x=1731496068; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BJffMp605YvlxnJmOp5cvXT/p2JSCZKTArMZHISQ1G4=;
        b=Slg5/UsOaUh9bB236miH/VwmVL7pd+sx2FJf8QtnJFzIVkIAaOibCp29DpRZREkTYN
         BQXO09mgv0OuO/IxyKl/0M3sogRwu0Wr345DctFhxHEvgJcw4HASuKsfcPk/t52TekrZ
         qdaeMA3eXpzTgjcLbz4vUg73RDbfrpXz1osmF7/GB7uojSLr0+nFTTb4HqYwvQqM2fVs
         8pVYvW1v8jhDH6lsh0Icdh74pem5RZmOFcMxe5mX1FNQgU0T1j/3ZBDwV2DlU+jSO26x
         bkcj2O3mCjETLswhNOHuNn+VbI5VF4zx2LU7Iev/U/ZJVrGb9zrj66tSEMoxgpuGdYUZ
         Pm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730891268; x=1731496068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJffMp605YvlxnJmOp5cvXT/p2JSCZKTArMZHISQ1G4=;
        b=tqMdAt2ZnTFLrO1ImMJ6OqjlG3H7M4EQ25UDolfMA/RBtqo2DUPPrInNSYQfmQHnMW
         S2f1UGMFA8KlBEKwkwXR3uLfTklgXe6SS8OajFuXZ35QOtzlFWJalrRmNy23G+qgVPkI
         x2Gc0lpGS1lEE2+WTfdptpmxzORMWL89lw76L7bQg4wDe3Xw4xpVmmg+JEZLR2K7Qe1/
         A3zGw/J+U86MwjQDOByQWggxLOUCAJufXnwuK2rZ1x/pwFjbXUrcXtku4ElHPloQCLRP
         b3dk65/zolW1bJu4xjY4RALcR622AY4JfVUGH+vt6UNGDt462CuoDKDbAOHEThWLvfPN
         c4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYidWOvFZwATHezu9PoyaBYDCotPVqrY6mzik9W+/ZK88vGl60dwAfntTVPw1HveYvj1MxGBiPHucPmqEv@lists.openembedded.org
X-Gm-Message-State: AOJu0YzJASX4yByHdQyHW6Iwz99nnu/WHQ4tJWQjipb2FMQS+QS/H6Xy
	G1cB9GvHhjAPKG+sU9h0TjK/WorhDxCcRMkDg+XEZmtljkiBzt4NJdXWWEzjOsX8iUxTie/+rQ5
	aLWw23ZX8ScrIC6NLtqufBpIE9YA=
X-Google-Smtp-Source: AGHT+IFYv9MPNWhLSkJaczfueYKr8jfuXRgCmhrRMnFFvwnls74dxhdbI+Wcbj700hcShwbSHdkpoFteF78k98kTFfY=
X-Received: by 2002:a05:6102:54a3:b0:4a4:8493:cf99 with SMTP id
 ada2fe7eead31-4a900f2ef46mr25714862137.19.1730891267918; Wed, 06 Nov 2024
 03:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20241031120015.3651707-1-jose.quaresma@foundries.io>
 <863880dddca8a8e37fa350e0baf69ac682c9bd07.camel@linuxfoundation.org> <CAJdd5Gb6c0yUx9HB8eH6vfQ6hhwjrAA0biNvSnqtTKXkn1Nyqw@mail.gmail.com>
In-Reply-To: <CAJdd5Gb6c0yUx9HB8eH6vfQ6hhwjrAA0biNvSnqtTKXkn1Nyqw@mail.gmail.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 6 Nov 2024 11:07:37 +0000
Message-ID: <CANPvuR=KMHguwZkT8x-Y+Nuifws1Q0sG0TsVxzmMmvgV88+Skg@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][PATCH 1/2] bitbake: hashserv: client:
 immediately test the server address
To: Joshua Watt <jpewhacker@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Jose Quaresma <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="0000000000002b52fa06263c875b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 11:07:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16784

--0000000000002b52fa06263c875b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Joshua Watt <jpewhacker@gmail.com> escreveu (s=C3=A1bado, 2/11/2024 =C3=A0(=
s) 15:55):

> I don't have the code in front of me, but this is almost certainly becaus=
e
> the websockets and TCP sockets take different address types. IIRC TCP use=
s
> a tuple of (address, port), while websockets takes a URL. As such, I don'=
t
> think you can use create_connection for both.
>

To be fair I only debugged and tested on the raw tests which were the ones
that were failing.
I hope to get back to this quickly.

Jose


>
> On Sat, Nov 2, 2024, 8:14=E2=80=AFAM Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> On Thu, 2024-10-31 at 12:00 +0000, Jose Quaresma via
>> lists.openembedded.org wrote:
>> > Test as soon as possible if it is possible to connect to the server
>> > and use raw socket for this, which is much simpler and works for what
>> you want.
>> >
>> > Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
>> > ---
>> >  bitbake/lib/hashserv/__init__.py | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/bitbake/lib/hashserv/__init__.py
>> b/bitbake/lib/hashserv/__init__.py
>> > index ac891e0174..47b25fa6ab 100644
>> > --- a/bitbake/lib/hashserv/__init__.py
>> > +++ b/bitbake/lib/hashserv/__init__.py
>> > @@ -82,6 +82,15 @@ def create_client(addr, username=3DNone,
>> password=3DNone):
>> >              c.connect_websocket(*a)
>> >          else:
>> >              c.connect_tcp(*a)
>> > +
>> > +        # test the connection now
>> > +        import socket
>> > +        try:
>> > +            sock =3D socket.create_connection(a, timeout=3D5)
>> > +            sock.close()
>> > +        except socket.error as e:
>> > +            raise ConnectionError
>> > +
>> >          return c
>> >      except Exception as e:
>> >          c.close()
>>
>> This didn't work, see below. Copying Joshua for comment on these.
>>
>> ERROR: Running idle function
>> Traceback (most recent call last):
>>   File "/usr/lib/python3.11/contextlib.py", line 137, in
>> _GeneratorContextManager.__enter__():
>>              try:
>>     >            return next(self.gen)
>>              except StopIteration:
>>   File "/mnt/b/yoe/master/sources/poky/bitbake/lib/bb/siggen.py", line
>> 589, in SignatureGeneratorOEEquivHash.client():
>>                  if getattr(self, '_client', None) is None:
>>     >                self._client =3D hashserv.create_client(self.server=
,
>> **self.get_hashserv_creds())
>>                  yield self._client
>>   File "/mnt/b/yoe/master/sources/poky/bitbake/lib/hashserv/__init__.py"=
,
>> line 97, in create_client(addr=3D'unix:///mnt/b/yoe/master/hashserve.soc=
k',
>> username=3DNone, password=3DNone):
>>              c.close()
>>     >        raise e
>>
>>   File "/mnt/b/yoe/master/sources/poky/bitbake/lib/hashserv/__init__.py"=
,
>> line 89, in create_client(addr=3D'unix:///mnt/b/yoe/master/hashserve.soc=
k',
>> username=3DNone, password=3DNone):
>>              try:
>>     >            sock =3D socket.create_connection(a, timeout=3D5)
>>                  sock.close()
>>   File "/usr/lib/python3.11/socket.py", line 825, in
>> create_connection(address=3D('/mnt/b/yoe/master/hashserve.sock',), timeo=
ut=3D5,
>> source_address=3DNone, all_errors=3DFalse):
>>
>>     >    host, port =3D address
>>          exceptions =3D []
>> ValueError: not enough values to unpack (expected 2, got 1)
>>
>>
>> Cheers,
>>
>> Richard
>>
>>

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000002b52fa06263c875b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Joshua Watt &lt;<a href=3D"mailto:jpe=
whacker@gmail.com">jpewhacker@gmail.com</a>&gt; escreveu (s=C3=A1bado, 2/11=
/2024 =C3=A0(s) 15:55):<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"auto">I don&#39;t have the code in front of me, but thi=
s is almost certainly because the websockets and TCP sockets take different=
 address types. IIRC TCP uses a tuple of (address, port), while websockets =
takes a URL. As such, I don&#39;t think you can use create_connection for b=
oth.</div></blockquote><div><br></div><div>To be fair I only debugged and t=
ested on the raw tests which were the ones that were failing.<br>I hope to =
get back to this quickly.<br><br>Jose</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Nov 2, 2024, 8:14=E2=80=AFAM Richard =
Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">richard.purdie@linuxfoundation.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Thu, 2024-10-31 at 12:00 +0000, Jose Quaresma via <a href=3D"http://lists.o=
penembedded.org" rel=3D"noreferrer noreferrer noreferrer noreferrer" target=
=3D"_blank">lists.openembedded.org</a> wrote:<br>
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
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div>

--0000000000002b52fa06263c875b--

