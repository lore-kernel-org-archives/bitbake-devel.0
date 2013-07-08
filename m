Return-Path: <martin.jansa@gmail.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 8BFE46AF70
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Jul 2013 16:27:51 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id m6so9230811wiv.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Jul 2013 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=Zf01fHP+9CSVZsdLRyqNbt3d6aml86fZeQVYNjKEUXw=;
	b=nqAwOMSe2AkQeqRoXMEkf7C492/FUutAGfgix70m2bH4DXNuZiKq/L6iijP9OWexu9
	RJt8AncZsjYY1C8IO6WdPGXwm/f1+03Pj7IKvi/2S+H/OORIyvVS/JmR7uSxi7jIZhrF
	0W43MhcxDNRED8NavQopPSmmb9LjzfPuHJxqg3DCoHfqO5g/BCe4XYKOaKzHUTH9ZHPm
	1p5rWm313dJYFnBi5jEb/gdsoFvMu77E6FZbOwtp3s6hkg5ahpOQ5Jar8pM9aWvFsA2E
	/JACjT9Q5FHLInsFeh5OJo3AgjetwnrYZR3WAarjdGyhEOGtckCOJMHNxm7As1z6eFKs
	u+5w==
MIME-Version: 1.0
X-Received: by 10.180.19.200 with SMTP id h8mr17944144wie.17.1373300871784;
	Mon, 08 Jul 2013 09:27:51 -0700 (PDT)
Received: by 10.194.16.136 with HTTP; Mon, 8 Jul 2013 09:27:51 -0700 (PDT)
In-Reply-To: <1371761594.20823.244.camel@ted>
References: <1371761594.20823.244.camel@ted>
Date: Mon, 8 Jul 2013 18:27:51 +0200
Message-ID: <CA+chaQfWUHbGwjV+1HS1Jpit3a4tbJAb34Xv0oVF4n7Zncc=Wg@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data_smart: Ensure variable flags are accounted for in config data hash
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 08 Jul 2013 16:27:52 -0000
Content-Type: multipart/alternative; boundary=bcaec53d5eb7a20ac504e10286f5

--bcaec53d5eb7a20ac504e10286f5
Content-Type: text/plain; charset=UTF-8

Can we get this backported into bitbake-1.18 please?


On Thu, Jun 20, 2013 at 10:53 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Currently if the flags set against a variable in the base data store
> change, it doesn't automatically trigger a reparse when it really
> should. For example with the blacklist class setting:
>
> PNBLACKLIST[qemu] = "bar"
> PNBLACKLIST[bash] = "foo"
>
> will not trigger a reparse if only one entry is changed and a
> blacklisted recipe can still be built.
>
> I did consider using BB_SIGNATURE_EXCLUDE_FLAGS in here however it
> doesn't make sense, we want to trigger a reparse when any of the
> flags change too (which is different to the sstate signatures which
> we wouldn't want to change in those cases).
>
> [YOCTO #4627]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
> index 2fd8ccd..fa7811e 100644
> --- a/bitbake/lib/bb/data_smart.py
> +++ b/bitbake/lib/bb/data_smart.py
> @@ -738,6 +738,12 @@ class DataSmart(MutableMapping):
>              value = d.getVar(key, False) or ""
>              data.update({key:value})
>
> +            varflags = d.getVarFlags(key)
> +            if not varflags:
> +                continue
> +            for f in varflags:
> +                data.update({'%s[%s]' % (key, f):varflags[f]})
> +
>          for key in ["__BBTASKS", "__BBANONFUNCS", "__BBHANDLERS"]:
>              bb_list = d.getVar(key, False) or []
>              bb_list.sort()
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--bcaec53d5eb7a20ac504e10286f5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Can we get this backported into bitbake-1.18 please?</div>=
<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu, Jun 2=
0, 2013 at 10:53 PM, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto=
:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linux=
foundation.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Currently if the flags set against a variabl=
e in the base data store<br>
change, it doesn&#39;t automatically trigger a reparse when it really<br>
should. For example with the blacklist class setting:<br>
<br>
PNBLACKLIST[qemu] =3D &quot;bar&quot;<br>
PNBLACKLIST[bash] =3D &quot;foo&quot;<br>
<br>
will not trigger a reparse if only one entry is changed and a<br>
blacklisted recipe can still be built.<br>
<br>
I did consider using BB_SIGNATURE_EXCLUDE_FLAGS in here however it<br>
doesn&#39;t make sense, we want to trigger a reparse when any of the<br>
flags change too (which is different to the sstate signatures which<br>
we wouldn&#39;t want to change in those cases).<br>
<br>
[YOCTO #4627]<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;<br>
---<br>
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py<br=
>
index 2fd8ccd..fa7811e 100644<br>
--- a/bitbake/lib/bb/data_smart.py<br>
+++ b/bitbake/lib/bb/data_smart.py<br>
@@ -738,6 +738,12 @@ class DataSmart(MutableMapping):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D d.getVar(key, Fal=
se) or &quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.update({key:value})<br=
>
<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0varflags =3D d.getVarFlags(key)<=
br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not varflags:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for f in varflags:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.update({&#39;=
%s[%s]&#39; % (key, f):varflags[f]})<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for key in [&quot;__BBTASKS&quot;, &quot;=
__BBANONFUNCS&quot;, &quot;__BBHANDLERS&quot;]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb_list =3D d.getVar(key, F=
alse) or []<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb_list.sort()<br>
<br>
<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
</blockquote></div><br></div>

--bcaec53d5eb7a20ac504e10286f5--
