Return-Path: <raj.khem@gmail.com>
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com
	[209.85.217.173])
	by mail.openembedded.org (Postfix) with ESMTP id DDC7A60762
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Aug 2016 14:44:41 +0000 (UTC)
Received: by mail-ua0-f173.google.com with SMTP id m60so101043656uam.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Aug 2016 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=s87i4HuOmRXL5R/JC9g/OSvckLf3iQDplFb5NlJeQdM=;
	b=iydVTIejXoa7ka0kNaIgoTQ/uSuxBh2C3ezmkyAM+22ODJ15VDRK8uxF7KOLvFtQGq
	Np3ui6ks9gcNIw9J/ihQoRrvBnJRRxMMZtjaeXjPBNNA+Z9SGl3pCT6y+ouFN0qlrzwS
	Ot9Tj+dhsmRyIv68rEuhDJQJQobczctpeV/k9pHHRrNFdZMo/5xJRCDpRxbsoGjDMcoh
	HnYAV8DBMuTMl0UJRdIcJNilxGv6F+JQQ4WKjJ+qyQx6EVs4uQ754aU/+LTfpdI8/+8L
	hBbVhBhC4/aPHlmqjX46+K1962ZW+jHvuwemhdwJUT7wqoOxNPYOyRSoL3lEUWRax2Ti
	sRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=s87i4HuOmRXL5R/JC9g/OSvckLf3iQDplFb5NlJeQdM=;
	b=MNgglQ7VK+sNTInEEhaheQW1L5egbrGiITGmgOWE1aLEE/qHA3K3jaPeDNdDjYKltC
	JxrG7fflZ3x+pfak/sUaj3RBw9SWst+OLZweO84X8rJMEyYHaqNYSnzNd9cBiKZZbZAn
	p2kZ5o/iMiVaPJLh0cd3poUX4zL9VYGrfrF5rePSfDGDFTzrguTb/uyVOVF6PnozLwwl
	Xb9ng0KAhvwD4WY5/4mvqHbxthKSfrpPNMg1Aho6DSc+SBzPARvsIYKNVEUp49oFoJ7y
	mL7RKaxqcRPYGscYEUN5unADU6/IhMHnoK74KdZNIf/PNMsIV7RqfXc33GIWxaNc1OSt
	gMiA==
X-Gm-Message-State: AE9vXwMHZFxqfbc2X3zqtflhU4pRz/OBdFLlpu/alXGlqaD2AwHyp+PhKshIiZrPODRufYI9Nyr2G660CnaDGw==
X-Received: by 10.176.6.196 with SMTP id g62mr2349887uag.142.1472222681756;
	Fri, 26 Aug 2016 07:44:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.64.138 with HTTP; Fri, 26 Aug 2016 07:44:40 -0700 (PDT)
Received: by 10.176.64.138 with HTTP; Fri, 26 Aug 2016 07:44:40 -0700 (PDT)
In-Reply-To: <1472189699-6646-1-git-send-email-zzs213@126.com>
References: <1472189699-6646-1-git-send-email-zzs213@126.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 26 Aug 2016 07:44:40 -0700
Message-ID: <CAMKF1soRMSf9EvC5RMuVuJbyA4dRC=n+B9nSjCXovD_F_zvTwQ@mail.gmail.com>
To: zzs <zzs213@126.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] enable override for suffix just include digit and dot
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 26 Aug 2016 14:44:42 -0000
Content-Type: multipart/alternative; boundary=94eb2c1243baf9f9d0053afa8dfb

--94eb2c1243baf9f9d0053afa8dfb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Aug 25, 2016 10:35 PM, <zzs213@126.com> wrote:
>
> From: =E5=BC=A0=E5=BF=A0=E5=B1=B1 <zzs213@126.com>
>
> Without this patch, if we write these in recipe test.bb:
>
>         NAME_1.1.7   =3D 'version is 1.1.7'
>         NAME_develop =3D 'version is develop'
>
> Use 'bitbake test -e' to observe 'NAME':
>         #
>         # $NAME [2 operations]
>         #   override[develop]:set .../test.bb:10
>         #     "version is develop"
>         # pre-expansion value:
>         #   "version is develop"
>         NAME=3D"version is develop"
>
> Obviously, override for '1.1.7' missing.

Dot is not allowed in variable names intentionally since its file extension
separator. I am not sure if its a good idea to allow it in variable names
>
> Signed-off-by: =E5=BC=A0=E5=BF=A0=E5=B1=B1 <zzs213@126.com>
> ---
>  lib/bb/data_smart.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 59621b7..ea4ff80 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -559,7 +559,7 @@ class DataSmart(MutableMapping):
>          # aka pay the cookie monster
>          override =3D var[var.rfind('_')+1:]
>          shortvar =3D var[:var.rfind('_')]
> -        while override and override.islower():
> +        while override and (override + 'a').islower():
>              if shortvar not in self.overridedata:
>                  self.overridedata[shortvar] =3D []
>              if [var, override] not in self.overridedata[shortvar]:
> @@ -637,7 +637,7 @@ class DataSmart(MutableMapping):
>          if '_' in var:
>              override =3D var[var.rfind('_')+1:]
>              shortvar =3D var[:var.rfind('_')]
> -            while override and override.islower():
> +            while override and (override + 'a').islower():
>                  try:
>                      if shortvar in self.overridedata:
>                          # Force CoW by recreating the list first
> --
> 1.9.1
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--94eb2c1243baf9f9d0053afa8dfb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Aug 25, 2016 10:35 PM, &lt;<a href=3D"mailto:zzs213@126.c=
om">zzs213@126.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: =E5=BC=A0=E5=BF=A0=E5=B1=B1 &lt;<a href=3D"mailto:zzs213@126.com=
">zzs213@126.com</a>&gt;<br>
&gt;<br>
&gt; Without this patch, if we write these in recipe <a href=3D"http://test=
.bb">test.bb</a>:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 NAME_1.1.7=C2=A0 =C2=A0=3D &#39;version is=
 1.1.7&#39;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 NAME_develop =3D &#39;version is develop&#=
39;<br>
&gt;<br>
&gt; Use &#39;bitbake test -e&#39; to observe &#39;NAME&#39;:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 # $NAME [2 operations]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0override[develop]:set .../<a=
 href=3D"http://test.bb:10">test.bb:10</a><br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0&quot;version is deve=
lop&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 # pre-expansion value:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0&quot;version is develop&quo=
t;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 NAME=3D&quot;version is develop&quot;<br>
&gt;<br>
&gt; Obviously, override for &#39;1.1.7&#39; missing.</p>
<p dir=3D"ltr">Dot is not allowed in variable names intentionally since its=
 file extension separator. I am not sure if its a good idea to allow it in =
variable names<br>
&gt;<br>
&gt; Signed-off-by: =E5=BC=A0=E5=BF=A0=E5=B1=B1 &lt;<a href=3D"mailto:zzs21=
3@126.com">zzs213@126.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/data_smart.py | 4 ++--<br>
&gt; =C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py<br>
&gt; index 59621b7..ea4ff80 100644<br>
&gt; --- a/lib/bb/data_smart.py<br>
&gt; +++ b/lib/bb/data_smart.py<br>
&gt; @@ -559,7 +559,7 @@ class DataSmart(MutableMapping):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# aka pay the cookie monster<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0override =3D var[var.rfind(&#39;_&#3=
9;)+1:]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shortvar =3D var[:var.rfind(&#39;_&#=
39;)]<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 while override and override.islower():<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while override and (override + &#39;a&#39=
;).islower():<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if shortvar not in sel=
f.overridedata:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ove=
rridedata[shortvar] =3D []<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [var, override] not=
 in self.overridedata[shortvar]:<br>
&gt; @@ -637,7 +637,7 @@ class DataSmart(MutableMapping):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;_&#39; in var:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0override =3D var[var.r=
find(&#39;_&#39;)+1:]<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shortvar =3D var[:var.=
rfind(&#39;_&#39;)]<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while override and override=
.islower():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while override and (overrid=
e + &#39;a&#39;).islower():<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if shortvar in self.overridedata:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0# Force CoW by recreating the list first<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; _______________________________________________<br>
&gt; bitbake-devel mailing list<br>
&gt; <a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@=
lists.openembedded.org</a><br>
&gt; <a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l">http://lists.openembedded.org/mailman/listinfo/bitbake-devel</a><br></p>

--94eb2c1243baf9f9d0053afa8dfb--
