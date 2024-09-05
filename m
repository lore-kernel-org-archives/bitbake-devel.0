Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2ACCE7A89
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 19:24:30 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.18308.1725564259883741831
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Sep 2024 12:24:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DWilx/y6;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: chuckwolber@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82a1741aa31so43093139f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Sep 2024 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725564259; x=1726169059; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOPlLcPL0Ks3VjS9QxROHCpSSzRx+zKXFSB46qmoYwg=;
        b=DWilx/y6EQulghuQibsmlgS4kp253nAecxi0QZjrf3mOFKm2gRXQGRShgH/U/MvvZL
         kTYSRoQ7RS+qZWL4S82xR8M27T7fQoqRrdLTwospkq75UxL+p39XL0vwAZ21Erx/k6W5
         1HLB3t/nPQTvSqQDbKvSsSBSe/DdmdJmmU9z9dsun5tFsLZMQowPji5A+hOyhVtPdyM4
         1N/nvxU2NgDT6y26fBJKfl9QcDcGLKHu3G/1aJXmCnKdkvRGhturqKMNNaT2mysSI5jS
         9nbFwBc3zjQKNNSD/Fya0pjP2PRqjRvmAtpYxY0Y77RNP7tSlBv2TtOXMINSPhU579Cq
         mcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725564259; x=1726169059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOPlLcPL0Ks3VjS9QxROHCpSSzRx+zKXFSB46qmoYwg=;
        b=vHprdbcqeINhVyn8uuNbUDCGTuOWThjHjnnFKEBOCafGBDH5SaR5bVnnHpOTCX2tXh
         8febfTxmbVXyxfrTGs+Gt5lEyQFiLiCWvbm9XbK2NVk1gqSjp0Weiv4sskJ0XwVvdoqu
         T35tCzXI4eNa4PXdXDITYBCfupFM4JbDFWM5JEYyszMR+oZzWjNStat9lOm8Z3z5T8+j
         h47ODgNRl2cq2u+7Bodm+8kVvH3gfUTHSf+H0KpwOTzL0nY4t9V0PG/2I18RyHKRilAC
         drqHgh03ETv+cwztRnewHQ45f0caLQeNXlgnMS2l0amOaRXzyBZKw+lOBIxMOjdJqi4/
         ea8A==
X-Forwarded-Encrypted: i=1; AJvYcCXhp67E/jns8kVojir2Xthvexez1GYJFY3l1v9ph4IohPhncHET6ZboRyexqfWqFzv7aAGYWd8ltHGjAdqD@lists.openembedded.org
X-Gm-Message-State: AOJu0YzhHzhIR8poGv3+8cY0rSbpuCMlSFRXGkwjGPRMU7yH4qKt1AB5
	Df0owSa5edQBG7zqh0ABanEBDQeU3XzZFPiRwWW/Rmf25/mu5HhqQk23+mbnxOVHpVEcSAbTVzm
	yNZkViap12V+BxQIkmWLaeKhxHzI=
X-Google-Smtp-Source: AGHT+IGRvnIkiYTOMoSXxLXqIM0RPrxCauexO816FQlaFB1wm4CGJamgyLJN0TPrf28+VSC26eyl5ZE+9cOfQC45GTs=
X-Received: by 2002:a05:6e02:13ae:b0:39f:d6a9:a6b9 with SMTP id
 e9e14a558f8ab-39fd6a9a712mr61703925ab.24.1725564258868; Thu, 05 Sep 2024
 12:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240905155909.1595157-1-richard.purdie@linuxfoundation.org> <DB5PR02MB1021347F5CAB0525949685060EF9D2@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB1021347F5CAB0525949685060EF9D2@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Thu, 5 Sep 2024 12:24:06 -0700
Message-ID: <CAB=6tBTf44Gxjw=kDgPQ2geNzTuZXo2Gb+VfCft6BLXXX_CKGg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] siggen: Fix rare file-checksum hash issue
To: peter.kjellerstedt@axis.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000afeb080621643c11"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Sep 2024 19:24:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16542

--000000000000afeb080621643c11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:58=E2=80=AFAM Peter Kjellerstedt via
lists.openembedded.org <peter.kjellerstedt=3Daxis.com@lists.openembedded.or=
g>
wrote:

>
>
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-
> > devel@lists.openembedded.org> On Behalf Of Richard Purdie
> > Sent: den 5 september 2024 17:59
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH] siggen: Fix rare file-checksum hash
> issue
> >
> > There is a subtle issue with full pathnames being included in the
> > file checksums since the sorting might be different depending upon
> > how layers are being setup causing hash mismatches for recipes appenede=
d
> > from other layers with differing directory layouts.
> >
> > Avoid this by filtering out to the path basename which is what is writt=
en
> > into the sig data anyway later in the code.
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/siggen.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> > index 8f24535528..a6163b55ea 100644
> > --- a/lib/bb/siggen.py
> > +++ b/lib/bb/siggen.py
> > @@ -878,7 +878,7 @@ def clean_checksum_file_path(file_checksum_tuple):
> >      f, cs =3D file_checksum_tuple
> >      if "/./" in f:
> >          return "./" + f.split("/./")[1]
>
> Wouldn't it make sense to remove the if-statement above then too?
>


I believe that would break the ability to detect changes to in-tree code.

Refer to the following two commits for background:

https://git.openembedded.org/bitbake/commit/?id=3Db4975d2ecf615ac4c240808fb=
c5a3f879a93846b
https://git.openembedded.org/bitbake/commit/?id=3D5293a1b36eeb89f57577cb709=
ec7f293909039a1

..Ch:W..



--=20
*"Perfection must be reached by degrees; she requires the slow hand of
time." - Voltaire*

--000000000000afeb080621643c11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Sep 5, 2024 at 10:58=E2=80=AFAM P=
eter Kjellerstedt via <a href=3D"http://lists.openembedded.org">lists.opene=
mbedded.org</a> &lt;peter.kjellerstedt=3D<a href=3D"mailto:axis.com@lists.o=
penembedded.org">axis.com@lists.openembedded.org</a>&gt; wrote:</div><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=
=3D"_blank">bitbake-devel@lists.openembedded.org</a> &lt;bitbake-<br>
&gt; <a href=3D"mailto:devel@lists.openembedded.org" target=3D"_blank">deve=
l@lists.openembedded.org</a>&gt; On Behalf Of Richard Purdie<br>
&gt; Sent: den 5 september 2024 17:59<br>
&gt; To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"=
_blank">bitbake-devel@lists.openembedded.org</a><br>
&gt; Subject: [bitbake-devel] [PATCH] siggen: Fix rare file-checksum hash i=
ssue<br>
&gt; <br>
&gt; There is a subtle issue with full pathnames being included in the<br>
&gt; file checksums since the sorting might be different depending upon<br>
&gt; how layers are being setup causing hash mismatches for recipes appened=
ed<br>
&gt; from other layers with differing directory layouts.<br>
&gt; <br>
&gt; Avoid this by filtering out to the path basename which is what is writ=
ten<br>
&gt; into the sig data anyway later in the code.<br>
&gt; <br>
&gt; Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/siggen.py | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py<br>
&gt; index 8f24535528..a6163b55ea 100644<br>
&gt; --- a/lib/bb/siggen.py<br>
&gt; +++ b/lib/bb/siggen.py<br>
&gt; @@ -878,7 +878,7 @@ def clean_checksum_file_path(file_checksum_tuple):=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 f, cs =3D file_checksum_tuple<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if &quot;/./&quot; in f:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;./&quot; + f.split(&quo=
t;/./&quot;)[1]<br>
<br>
Wouldn&#39;t it make sense to remove the if-statement above then too?<br></=
blockquote><div><br></div><div><br></div><div>I believe that would break th=
e ability to detect changes to in-tree code.</div><div><br></div><div>Refer=
 to the following two commits for background:<br></div><div><br></div><div>=
<a href=3D"https://git.openembedded.org/bitbake/commit/?id=3Db4975d2ecf615a=
c4c240808fbc5a3f879a93846b">https://git.openembedded.org/bitbake/commit/?id=
=3Db4975d2ecf615ac4c240808fbc5a3f879a93846b</a><br></div><div><a href=3D"ht=
tps://git.openembedded.org/bitbake/commit/?id=3D5293a1b36eeb89f57577cb709ec=
7f293909039a1">https://git.openembedded.org/bitbake/commit/?id=3D5293a1b36e=
eb89f57577cb709ec7f293909039a1</a></div><div><br></div><div>..Ch:W..<br></d=
iv><div>=C2=A0</div></div><br clear=3D"all"><br><span class=3D"gmail_signat=
ure_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div><b><span style=3D"font-family:monospace">&quot;Perfection m=
ust be reached by degrees; she requires the slow hand of time.&quot; - Volt=
aire</span></b></div></div></div></div>

--000000000000afeb080621643c11--

