Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FA6D3EE62
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 13:01:29 +0000 (UTC)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36550.1769086879204391019
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 05:01:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MV+C74am;
 spf=pass (domain: gmail.com, ip: 74.125.82.41, mailfrom: rybczynska@gmail.com)
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12336f33098so957138c88.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 05:01:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769086879; cv=none;
        d=google.com; s=arc-20240605;
        b=afafZmjYZIbSUZgkiR9wTbDXYCu7s7BT6XHwiN/ELOmNBNiG7DUTvLw7oH+o2JFwRS
         NUNWZDGUqgIDe3rxHyTyKEchU8cLp7z65+CIrthpa4o/H3+jkdGdngZT38RUAIokIywV
         m2qH6jI8PEOmf0c9CFjXgAITzMPa80O805+UU2q02um75Kc5xfU1AWqb3YQiWpOXqh3o
         1Qi/8ncF72kfr1YKRvA0JawJT6c9iGnhTRbxjgEe+t0SFoFdUahyFimKZfcIBRpcBYlJ
         mJ1uTFLyAoV4Ut06O3J2YDY7+Qb5L1HXP9Y4jk+KVmqGDdOt8hGKtd2EY1ePpDux0uDz
         azTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OMN7ZGKIyIiHaulMxan3WfcObHCxI2yDjtDAumvYgs8=;
        fh=nTTaCMLSXiKcsNq27TrJZaTuW3XGD70wCTeR+9P8VtA=;
        b=QlwdvSS7Z97VcDv0RO/VSc29I0Z7EYAykG08jR3hqsDCq3fkkQYuGyFM2BtN/5yDl4
         H/BHyh3g/FyPmfMHAdKE941wdzL1DSAIJFsDYIXap7glb3cPDvYqm++uFTqW1Ajo9A6l
         qGR4JiAnNk+cG6khCByBfscf5mGpPe97jHSpg5hiTJiYQtaUjFENAcyl1vM6UfQdrgMD
         LUpl3GZ8H8591Kwu3NSxkj8Qz0QQzNepLZLwVtIpTZA8cqHqKk9dSgzU7/Pscjs1eK0k
         X7264la+Vc31OV/ffrc+ZH/H/21ObUulf8DfJenY8Xm8lIoOxj/ok+9fhVUOqAOtmGba
         xkjA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769086879; x=1769691679; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OMN7ZGKIyIiHaulMxan3WfcObHCxI2yDjtDAumvYgs8=;
        b=MV+C74amrYKphCnpeERL12SdcLtPHBljg+QexR6UOAiJbSdlmUzhQZ2iE5VlWwvJEC
         91LjKB1ZiU+TD6kms07654sJHFjoLBMpeshmfaBZZ0nSb9unDCFd+jHEgc3hzKAwpSnM
         CV49vJyFatxKxg9eFEXvS7fDAUk3yuyD/pTE+qJwGiMhrAQhhyBIissOAFUb7oDpu+9d
         qKSN9s5RSoUyuEXBnYd24U64aDwqzC8WodZDj7fUCEEy62yUhrFn8nM9rMsh7CXwo3Eo
         hzgaUcVbNQ5CcP1g/z8S2Gv4IHwdoBaKVoeqSzI2uvjgqlJP0jioC/HV6vpm0bYR91G9
         VQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769086879; x=1769691679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMN7ZGKIyIiHaulMxan3WfcObHCxI2yDjtDAumvYgs8=;
        b=AhQ5mA4rzeAIjkohAsbH4BbqYPIj0LW3bQpu76MmijCij5NkAFmg2R9Ax3x0XdNG8q
         z8U+LklKDH8NOM2g24cIm1/n2YQhTtjYlB6uBNb3IEhnWFzilLPdsQITQbwtd0phDdsf
         meF2/xE5jFiaetlxWZmISwWZDy/76/VgDNJoblf1t2vd2zntQqLvnSODnVVYzQHIyS8O
         DeaFPYJ4vBrzoXsD7COjmBvfhwIzAbxtuG4jwKJ7Vlt9LbW2QmwXvleukxGumVFkEoxM
         dw2TevSYCeW+OjHNxSl61QmlcS/ugbf87aYNfkrjkoIA06wEnZHVUtxz7ifh+icy0rI9
         eq7Q==
X-Gm-Message-State: AOJu0YzZixCeBeBk0zAW/BBZ20fo/IC1jqaiPRjHCLZDi1rtgeVgxhFt
	o+JBxQpKF+7TQLz98LaZv/HOa4hM8+Edxit5ibZ0qV1xGESyLdIyZxDgX+QOB0m1UTOJ/Rx9MRd
	9eNO4ikk0tScwv1FULJy5GN43VRG6H3g=
X-Gm-Gg: AZuq6aIAz1LdYzCk3oGws+RQFYRv/sW9k/gFTkM/sb6/LkaG9iPvT26BUS9BhmtSXC5
	BpI1nqK3Fo1NLqfzrj66hqwn9mU1k/UBUB0yvQG/CO2UfCmCVg3STObofwK1hq+aJgvNZnK5r1W
	UMmf9JfOMuuiQ58hvEYQIWIpSQ3d6EiFSPVEwcuyEJVDV0vktGa8Yrgp8QzrA8DLeJOfqnWpKBI
	YRkNlytIRnRwu0o3Ib0RnFGWbbyXAytnaxe7ecS597oSrBwJFXbTIvSSjpW8Ji9dtUEEWsDM9hr
	7+AEvXCNbcDpyo+wBm7q0+0lwVODAZgLfyJOXA4=
X-Received: by 2002:a05:7022:438c:b0:123:3488:8969 with SMTP id
 a92af1059eb24-1244b37e3bemr12708242c88.45.1769086877634; Thu, 22 Jan 2026
 05:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20260122080922.1695912-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20260122080922.1695912-1-richard.purdie@linuxfoundation.org>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Thu, 22 Jan 2026 14:01:05 +0100
X-Gm-Features: AZwV_Qjr4JwOXSnpTrF5U8hfAq-dpuCMeEar7MRrPywYq3Qo1oSdO5bGvQ7g6Do
Message-ID: <CAApg2=R1ek+YS44f++taB-N2WpJkZ+3vJWD_dukZ+=WVhzuqnw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/npm/npmsw: Disable npm and
 npmsw fetchers due to security concerns
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000eb16040648f9a2e9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 13:01:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18844

--000000000000eb16040648f9a2e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 9:09=E2=80=AFAM Richard Purdie via lists.openembedd=
ed.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:

> We've been made aware that are security issues within the npm/npmsw
> fetchers.
> The issue is that the code accepts data like checksums from the upstream
> servers, rather than verifying it against local data from the recipes. Th=
is
> means the upstream servers could feed aritrary data into the build.
>
> There have been maintainance issues on these fetchers for a while and
> despite
> asking in multiple forums, we've been unable to find anyone to help fix t=
he
> issues. Until that issue is resolved and we can be convinced the fetcher =
is
> secure and modelling best practices for reproduciblity (inc. mirroring),
> this
> patch disables the fetchers. This has been discussed and agreed by the OE
> TSC.
>
> Parsing will not show errors but the recipes using these fetchers will no=
t
> be
> available. Recipes will be skipped at parsing and will show an error if a
> user
> tries to build a recipe using them.
>
> The import is local to the function to avoid circular dependencies within
> the hashserv selftests.
>
> [YOCTO #16105]
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/npm.py   | 6 +++++-
>  lib/bb/fetch2/npmsw.py | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index e469d667687..72a24c8c35f 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -150,7 +150,11 @@ class Npm(FetchMethod):
>
>      def supports(self, ud, d):
>          """Check if a given url can be fetched with npm"""
> -        return ud.type in ["npm"]
> +        #return ud.type in ["npm"]
> +        if ud.type in ["npm"]:
> +            from bb.parse import SkipRecipe
> +            raise SkipRecipe("The npm fetcher has been disabled due to
> security issues and there is maintainer to address them")
> +        return False
>
>      def urldata_init(self, ud, d):
>          """Init npm specific variables within url data"""
> diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
> index 2f9599ee9e2..322c7b331e5 100644
> --- a/lib/bb/fetch2/npmsw.py
> +++ b/lib/bb/fetch2/npmsw.py
> @@ -64,6 +64,10 @@ class NpmShrinkWrap(FetchMethod):
>      def supports(self, ud, d):
>          """Check if a given url can be fetched with npmsw"""
>          return ud.type in ["npmsw"]
> +        if ud.type in ["npmsw"]:
> +            from bb.parse import SkipRecipe
> +            raise SkipRecipe("The npmsw fetcher has been disabled due to
> security issues and there is maintainer to address them")
> +        return False
>
>      def urldata_init(self, ud, d):
>          """Init npmsw specific variables within url data"""
>
>
Hello Richard,
I think there's still a missing word in the error message: "and there is"
-> "and until there is".

Cheers,
Marta

--000000000000eb16040648f9a2e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 22,=
 2026 at 9:09=E2=80=AFAM Richard Purdie via <a href=3D"http://lists.openemb=
edded.org">lists.openembedded.org</a> &lt;richard.purdie=3D<a href=3D"mailt=
o:linuxfoundation.org@lists.openembedded.org">linuxfoundation.org@lists.ope=
nembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">We&#39;ve been made aware that are security issues within the =
npm/npmsw fetchers.<br>
The issue is that the code accepts data like checksums from the upstream<br=
>
servers, rather than verifying it against local data from the recipes. This=
<br>
means the upstream servers could feed aritrary data into the build.<br>
<br>
There have been maintainance issues on these fetchers for a while and despi=
te<br>
asking in multiple forums, we&#39;ve been unable to find anyone to help fix=
 the<br>
issues. Until that issue is resolved and we can be convinced the fetcher is=
<br>
secure and modelling best practices for reproduciblity (inc. mirroring), th=
is<br>
patch disables the fetchers. This has been discussed and agreed by the OE T=
SC.<br>
<br>
Parsing will not show errors but the recipes using these fetchers will not =
be<br>
available. Recipes will be skipped at parsing and will show an error if a u=
ser<br>
tries to build a recipe using them.<br>
<br>
The import is local to the function to avoid circular dependencies within<b=
r>
the hashserv selftests.<br>
<br>
[YOCTO #16105]<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/fetch2/npm.py=C2=A0 =C2=A0| 6 +++++-<br>
=C2=A0lib/bb/fetch2/npmsw.py | 4 ++++<br>
=C2=A02 files changed, 9 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
index e469d667687..72a24c8c35f 100644<br>
--- a/lib/bb/fetch2/npm.py<br>
+++ b/lib/bb/fetch2/npm.py<br>
@@ -150,7 +150,11 @@ class Npm(FetchMethod):<br>
<br>
=C2=A0 =C2=A0 =C2=A0def supports(self, ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Check if a given url ca=
n be fetched with npm&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ud.type in [&quot;npm&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #return ud.type in [&quot;npm&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.type in [&quot;npm&quot;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from bb.parse import SkipRecipe<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise SkipRecipe(&quot;The npm f=
etcher has been disabled due to security issues and there is maintainer to =
address them&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
<br>
=C2=A0 =C2=A0 =C2=A0def urldata_init(self, ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Init npm specific varia=
bles within url data&quot;&quot;&quot;<br>
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py<br>
index 2f9599ee9e2..322c7b331e5 100644<br>
--- a/lib/bb/fetch2/npmsw.py<br>
+++ b/lib/bb/fetch2/npmsw.py<br>
@@ -64,6 +64,10 @@ class NpmShrinkWrap(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0def supports(self, ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Check if a given url ca=
n be fetched with npmsw&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ud.type in [&quot;npmsw&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.type in [&quot;npmsw&quot;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from bb.parse import SkipRecipe<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise SkipRecipe(&quot;The npmsw=
 fetcher has been disabled due to security issues and there is maintainer t=
o address them&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
<br>
=C2=A0 =C2=A0 =C2=A0def urldata_init(self, ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Init npmsw specific var=
iables within url data&quot;&quot;&quot;<br>
<br></blockquote><div><br></div><div>Hello Richard,</div><div>I think there=
&#39;s still a missing word in the error message: &quot;and there is&quot; =
-&gt; &quot;and until there is&quot;.</div><div><br></div><div>Cheers,</div=
><div>Marta <br></div></div></div>

--000000000000eb16040648f9a2e9--

