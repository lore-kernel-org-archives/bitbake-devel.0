Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11272CAC5A5
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 11:06:17 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web11.9892.1758711972120219826
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Sep 2025 04:06:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dTUIPT2o;
 spf=pass (domain: gmail.com, ip: 209.85.166.179, mailfrom: quaresma.jose@gmail.com)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-42571b8abbaso38841335ab.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 04:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758711971; x=1759316771; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Yy810n3bfJSkoyrVr14jZ+ZUvYwCGDdiBJenA3iITY=;
        b=dTUIPT2ojBQvN+0zkxpA7NVB7eggKJEg0Vch7IVM3/yQ2UTzRB3prtQ5BgAeORdjo5
         WWBWkcbpHmxzxQLXVGEG+iRZrBI1DlUPoMsN1MQJ4DoAwCIQPSV4QmAUxF+26kQhe4/A
         99dVRj9HDkPFTIv+F7S1iZdjjRwNhjTRu0CZaf/iFT/R113DpkLgeN2wPm1Jl8wy21R6
         g8Sohq/AEwAYw/hskK1WBqlxgBfxkM/PFk4nAC64mndFl0byCCkvcVOb43QSC/JDuguG
         mMuQ65Rczbh4MP2TWTw+3jIsLqYUvSYg7eyKdo3RT44UFzUSFnvJiWBaG2ocoUsqCSB9
         iTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758711971; x=1759316771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Yy810n3bfJSkoyrVr14jZ+ZUvYwCGDdiBJenA3iITY=;
        b=PDDUMLtC3ywARPTJvW5rB/PCR2Sr62nU9MxNUjjyiiA67Pv8yfEWoW4BOWp4Ew8wbv
         4ItlOkLHYaDdm5VLeXL//bQSPfdWgdzUfyEupAufOG+wkPeU6uwiZrZplaKBT8jwKXgO
         T2SJfyJmpTss9Y98lF9xB/Ki61ZPREW1xvnPHOadysWQrZOfsz+hnAmW8ShcLjBdpYtn
         9vvoMmr2cNf+ukWdcZmIFFi2aU/os3B1sqtDT2febWdE/F0owMuU4v43b9/OgMPbPPHt
         tCxf/Piq15pWa0hQrK0GAIqH3+xlLLOB+YeFWGGA6c6dnimJYIPunZZLJui7skm1YjLn
         /YlQ==
X-Gm-Message-State: AOJu0YyGasTrAJ2Q2qJZ75aSjrKYCY1h3IqEq4eMpc/vajRXhZpe03yP
	N8wncNoQgGRvzYey/M/m4Iw5LwX0cv3YWU7+l+N8vRcYe4XnT5BjXg5qA3v7npBR1v0Tuu+Z6Nb
	/+zOvQyInwQzFbTFp7tbSuqoo8CJg8rw=
X-Gm-Gg: ASbGncu6crJEAUBEIAiVbFa7WY8ztCEaU6xxhL7GjU7oLiO6Ur53qpcJ77zrNSk53ec
	mZ+GY7c1olCqUuESEL1cWJo7820+rXNCCa3LYMwCGn0RPvkGrvQ10YrsSnCWLfK+fnpETacYihi
	uli3MUEV8dA4jUuyuUUV0dCT/ucmhFe/UcGkQyzEQnZYTq/t83RyL5V13Sl1IsuBzLk24LGT4cU
	mYr8tgu
X-Google-Smtp-Source: AGHT+IEuaGE3JmzYt6HjL/eg0Duhf7KAGUZyCo4Ow/9U+I1wwuEAUm8ASAZ7UOBGqQ0OgHMVlSh61JJ0qZh5XdsSv38=
X-Received: by 2002:a05:6e02:152e:b0:424:80f2:2a3 with SMTP id
 e9e14a558f8ab-42581e1717cmr95971725ab.6.1758711971002; Wed, 24 Sep 2025
 04:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <18683160554EF259.24570@lists.openembedded.org>
 <CANPvuRk2n7t9YHThXATOT+zD9DYrzV36rU4r+Ku50Wy9y9Q=7g@mail.gmail.com> <CANNYZj9om4Ki1X9+91uDaf8WoR1z7USnbG++9qUmp-wUELai1Q@mail.gmail.com>
In-Reply-To: <CANNYZj9om4Ki1X9+91uDaf8WoR1z7USnbG++9qUmp-wUELai1Q@mail.gmail.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 24 Sep 2025 12:05:57 +0100
X-Gm-Features: AS18NWCZjCU-9emL6tbhPWWJeUh-wyPTQxkJLp203Mr_LyOPrJXpoI0S3pSlefg
Message-ID: <CANPvuRkpq1M_AEs7J5+pvo6F1SR8srEiPV=SZVGM4knqLD5OJQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] cooker: add support for more than one
 server in BB_HASHSERVE_UPSTREAM
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="0000000000004b3b12063f8a0a6f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 11:06:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18086

--0000000000004b3b12063f8a0a6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexander Kanavin <alex.kanavin@gmail.com> escreveu (quarta, 24/09/2025
=C3=A0(s) 11:47):

> On Wed, 24 Sept 2025 at 12:39, Jose Quaresma via
> lists.openembedded.org
> <quaresma.jose=3Dgmail.com@lists.openembedded.org> wrote:
> > With that we can have for example:
> >
> > BB_HASHSERVE_UPSTREAM =3D "wss://hashserv.yoctoproject.org/ws
> hashserv.yoctoproject.org:8686"
>
> I'd like Joshua and Michael to comment on this ^^^
> Specifically, are there performance implications in using one or the
> other? Are both officially supported and maintained?
>

AFAIK the two are still supported because kirkstone only supports the raw
sockets.
We will still prefer the first one and fallback only on hosts that don't
have the python-websockets
I think with time they will become available widely and we can also add it
as a mandatory dependency of bitbake.

About the performance I will defer it Joshua and Michael


> >> +                if hashserve_upstream_list:
> >> +                    for hashserve_upstream in
> hashserve_upstream_list.split():
> >> +                        try:
> >> +                            with
> hashserv.create_client(hashserve_upstream) as client:
> >> +                                client.ping()
> >> +                                upstream =3D hashserve_upstream
> >> +                                break
> >> +                        except ImportError as e:
> >> +                            bb.warn("Unable to connect to hash
> equivalence server at '%s' due to missing or incorrect python module:\n%s=
"
> >> +                                    % (hashserve_upstream, repr(e)))
> >> +                        except ConnectionError as e:
> >> +                            bb.warn("Unable to connect to hash
> equivalence server at '%s':\n%s"
> >> +                                    % (hashserve_upstream, repr(e)))
> >> +
> >> +                if hashserve_upstream_list and not upstream:
> >> +                    bb.fatal("""Unable to use hash equivalence server=
:
> >> +    You can also remove the BB_HASHSERVE_UPSTREAM setting, but this
> may result in significantly longer build times as bitbake will be unable =
to
> reuse prebuilt sstate artefacts.""")
>
> This needs to be rebased on master-next, as it changes the error
> message. Also you can use for...else to put the newly added bb.fatal
> into the else block. The bb.fatal message should also be improved, and
> say that none of the configured servers could be used due to warnings
> above.
>

I will do it.

Jose


>
> Alex
>


--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000004b3b12063f8a0a6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Alexander Kanavin &l=
t;<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">alex.kanavin@=
gmail.com</a>&gt; escreveu (quarta, 24/09/2025 =C3=A0(s) 11:47):<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 24 Sept 2025 at 12=
:39, Jose Quaresma via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a><br>
&lt;quaresma.jose=3D<a href=3D"mailto:gmail.com@lists.openembedded.org" tar=
get=3D"_blank">gmail.com@lists.openembedded.org</a>&gt; wrote:<br>
&gt; With that we can have for example:<br>
&gt;<br>
&gt; BB_HASHSERVE_UPSTREAM =3D &quot;wss://<a href=3D"http://hashserv.yocto=
project.org/ws" rel=3D"noreferrer" target=3D"_blank">hashserv.yoctoproject.=
org/ws</a> <a href=3D"http://hashserv.yoctoproject.org:8686" rel=3D"norefer=
rer" target=3D"_blank">hashserv.yoctoproject.org:8686</a>&quot;<br>
<br>
I&#39;d like Joshua and Michael to comment on this ^^^<br>
Specifically, are there performance implications in using one or the<br>
other? Are both officially supported and maintained?<br></blockquote><div><=
br></div><div>AFAIK the two are still supported because kirkstone only supp=
orts the raw sockets.</div><div>We will still prefer the first one and fall=
back only on hosts that don&#39;t have the python-websockets<br>I think wit=
h time they will become=C2=A0available widely=C2=A0and we can also add it a=
s a mandatory dependency=C2=A0of bitbake.</div><div><br></div><div>About th=
e performance I will defer it Joshua and Michael</div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if hashse=
rve_upstream_list:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 for hashserve_upstream in hashserve_upstream_list.split():<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 try:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with hashserv.create_client(hashserve_up=
stream) as client:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 client.ping()<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream =3D hashserve_ups=
tream<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 except ImportError as e:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Unable to connect to hash =
equivalence server at &#39;%s&#39; due to missing or incorrect python modul=
e:\n%s&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % (hashserve=
_upstream, repr(e)))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 except ConnectionError as e:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Unable to connect to hash =
equivalence server at &#39;%s&#39;:\n%s&quot;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % (hashserve=
_upstream, repr(e)))<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if hashse=
rve_upstream_list and not upstream:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bb.fatal(&quot;&quot;&quot;Unable to use hash equivalence server:<br=
>
&gt;&gt; +=C2=A0 =C2=A0 You can also remove the BB_HASHSERVE_UPSTREAM setti=
ng, but this may result in significantly longer build times as bitbake will=
 be unable to reuse prebuilt sstate artefacts.&quot;&quot;&quot;)<br>
<br>
This needs to be rebased on master-next, as it changes the error<br>
message. Also you can use for...else to put the newly added bb.fatal<br>
into the else block. The bb.fatal message should also be improved, and<br>
say that none of the configured servers could be used due to warnings<br>
above.<br></blockquote><div><br></div><div>I will do it.<br><br>Jose</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></=
div></div></div>
</div>

--0000000000004b3b12063f8a0a6f--

