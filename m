Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E43C43327
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 19:56:19 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43029.1782503775701358916
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jun 2026 12:56:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FKgTeI1e;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so722802b3a.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 12:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782503775; cv=none;
        d=google.com; s=arc-20260327;
        b=f50FibpyBWegTX4+FZOuNKhdMTfPakvP2WxrDVnmYA3WwEdruJV6xv+3gmkKC2uyGU
         xZztZugBpMed2XKE++d6qUa/qDkUQ1k+OEb/iQ6UDjjnI51unFpjN8MAdjbUyakQjtxm
         Fymxj0ONeiKIiNFtLVlV5lz1gjkZfydds/rEcdyvDLy09dn3Lt61G6zVhPqmNTBByzgd
         nDoAwU6dF2smWWTSQmpkYkCyU8B0CQFHYfFGwLB8+xHFCfw60egIej6kn+zD9GJdsEHB
         hcvG6NvumOgYxe4uWGzsw9ty4VBVApy3BAXrEM/cADGivUDoqGlqLaZCw9FaiWC7PvZm
         4w/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cV3mXDPP99M74O43KzRKEUkaT110kLR8fEuD/B8E6s8=;
        fh=EgFNkz8STZQHlg/2AAkOPjkFCAbEsj+IeaePDnNrync=;
        b=mKLeW8SmEndUAbJuESsHd9Udv08Lh6ngKHDGJFgyzUO4GJuJDLwwis4y6V1niHYE0H
         kqhpSCrVZKOCfJ3SBGiiFiKOFila+V+Y5MUXTrY4IxWdXAH/H0I5cAzL0XbeY24G/moj
         HLbgdIMqLoJaY2L/KedlQo0Jv6mQfDJ93mUnaL3rx+n/CV5TUaY89WtMR40asb4U6jH4
         7MhocdF2ljJvPQ1lUW/sKOg/xGc0nJ3hFebuvTjssRydn0RgoG/HfgbBiHnfwF/HgmWq
         yfCCbV1uqF7X+CpRw2ks2nbFnxsaQ0Fpmq9wkCap/fv6p7FxU0ZwcnsNO/HPevcMjvDn
         Ux7Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782503775; x=1783108575; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cV3mXDPP99M74O43KzRKEUkaT110kLR8fEuD/B8E6s8=;
        b=FKgTeI1e2vZTxrgY2JKkDBFhzTveR+VrMn/+ns68c3Wcbv5hwR281JQP5PGD03cGt5
         tiuM7gI635AEQkf7fDYIRlPuPA5li0vYDPYX383FYpvrSKmVMLJL/sIs6lzUPMzFFDhY
         Rk6y88/oZWwn4vZXc+xg3dDtZHH1fMBvngVrWxoc06sRp+8VyoZ2mbiZAcw1sTRuXqwH
         LK7GkePqf41WCDKGUc8wbOvXLB3P/ESwconE07VL8C050MB0i4UvcUQ8v5e73nHRnib4
         5lkKfE9MFy6lCs30TR2ojPhx6gqF19D97xALCSw9Y15M8SJANXYVGV5iX6XHvJHUxRz4
         KKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782503775; x=1783108575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV3mXDPP99M74O43KzRKEUkaT110kLR8fEuD/B8E6s8=;
        b=doSNytU/82kvVhG9DuUPDqdg0Qs+piGW0DxylfAviKTLby3sZrxXWU3Wa4m0vNGDoe
         uhjRipIHQJnSkUq08ZiQj8oZvIfHSBIS7GhyDNwef3JHDtIjbw7xumJvEzchensPhmz3
         Ezgkqp64JnstLTzF5hPR1izgHy0RbuM1TpbWGRBJ8BbCPeHoHHMbb3BVBh08I/8gjaYk
         rIJ/47vnXntXTxOhw5adikBtK0Vp73vVcfKsKJw0lH/1PKFGq5ydSwXnZjzeReQ+lUKg
         Xs+ZRIOTKktwm91dqBLShLo9jClLwRcs2xBGM/3b/aOLzvZg1UjCCWnlCEjjCHeWAFw+
         1qAg==
X-Gm-Message-State: AOJu0Yw5NDnMH+CLZ6bnxtmw9Jb3cXgpyGEK1Kp3ts5x/evNdBaFbydP
	k7pkceHftMEAotRbMdQSZRhyXuYO3+9YFtXriUFCxWbyHzPldJT9jzXMXXx6O4tIMMD3GLCfJ2r
	a1JY+7to4J4H4Bh9p0LmBcWIMI6t3rm8=
X-Gm-Gg: AfdE7clbGz64bMeZZMRE7h50GWnVERjwzcYz4CfadSo3KQC0dpd81pGkmCzhzVYbFRk
	KUUvG0zwpg/HTKKSAl+m+zciste0kHkKiY4NCVhEI92+/tN1eVeq9cU7PeNuZ4ECtpq5WkHoSsa
	DnbUCMtdKww1jplSS/ZuCQ6fMohczGfcwMSu09w0YGgw3vEKMnRe/FXivW1NccJImSczvr/nvj5
	b5rZiW2SqvZytdB+uoNXOIsJmJokOeLekW1qcTLaf8v++sk68gba1Q35daCiCQLFKBzprw0mIy7
	U9rlYa+Ys2osOxXQqretskSXowIU6niuiUqOjaKuOEoelR7T+uD5MRP3pFuNTb/hp2azZXxpeY0
	6DXhzwqY7WxydwrE=
X-Received: by 2002:a05:6a00:66e2:b0:845:bcab:568 with SMTP id
 d2e1a72fcca58-845bcab1081mr4783515b3a.20.1782503774853; Fri, 26 Jun 2026
 12:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260626191028.162111-1-danielwa@cisco.com>
In-Reply-To: <20260626191028.162111-1-danielwa@cisco.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Fri, 26 Jun 2026 15:56:02 -0400
X-Gm-Features: AVVi8CerZ2-MfZA6onpsuZoFO9TTb8VANAtcPTghDAhR9EsY6wiIm70R0YxIVyw
Message-ID: <CADkTA4MVj9Ja806ja_0y7zo2J4sFdOvvUbm2_aR3tcQig4brvA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: add reference option
To: danielwa@cisco.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000004fa34f06552d806c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 19:56:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19797

--0000000000004fa34f06552d806c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 3:10=E2=80=AFPM Daniel Walker via lists.openembedde=
d.org
<danielwa=3Dcisco.com@lists.openembedded.org> wrote:

> Adds a option to the git fetcher which can be used to specify a local
> reference for a given SRC_URI. Which is then fed into the clone command
> as "--reference-if-able" which make the option fault tolerant if the
> directory doesn't exist.
>

We tried this in the past (maybe 10 years ago now) to chunk the
kernel into different sets of blobs and do a set of references for
optimal sharing, repacking, etc.

In the end, it was discarded as unnecessary complexity.

I'm still of the opinion that is the case. What problem is this solving
that justifies the complexity ?

the patch doesn't show a real world use case, what the SRC_URI
would look like, where the referenced clone would be, what would
happen if the referenced repository was somehow cleaned, or
any number of different interactions (what happens if shallow is
specified, etc, etc).

Bruce


>
> AI-Generated: OpenAI Codex
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> Change-Id: Ib5eb685ddfb48fa19f1c65cfc468894806f99e83
> ---
>  .../bitbake-user-manual-fetching.rst                 |  7 +++++++
>  lib/bb/fetch2/git.py                                 | 12 +++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index b96018a4e..6e4fc0800 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -398,6 +398,13 @@ This fetcher supports the following parameters:
>     preserve the local cache carefully for future use. The default value
>     for this parameter is "0".
>
> +-  *"reference":* Specifies a local directory to use as a reference
> +   repository. When set, the fetcher passes the directory to ``git clone=
``
> +   with ``--reference-if-able``. Git uses the reference repository's
> +   objects when possible, reducing the amount of object data copied or
> +   fetched. If the reference directory cannot be used, Git continues
> +   cloning without it.
> +
>  -  *"nobranch":* Tells the fetcher to not check the SHA validation for
>     the branch when set to "1". The default is "0". Set this option for
>     the recipe that refers to the commit that is valid for any namespace
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 0fbd85441..df1c4415f 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -22,6 +22,10 @@ Supported SRC_URI options are:
>     remind fetcher to preserve local cache carefully for future use.
>     The default value is "0", set rebaseable=3D1 for rebaseable git repo.
>
> +- reference
> +   Use the specified local directory as a reference repository by passin=
g
> it
> +   to git clone with --reference-if-able.
> +
>  - nocheckout
>     Don't checkout source code when unpacking. set this option for the
> recipe
>     who has its own routine to checkout code.
> @@ -195,6 +199,12 @@ class Git(FetchMethod):
>          if ud.bareclone:
>              ud.cloneflags.append("--mirror")
>
> +        ud.reference_args =3D []
> +        ud.reference =3D ud.parm.get("reference")
> +        if ud.reference:
> +            ud.reference_args =3D ["--reference-if-able", ud.reference]
> +            ud.cloneflags.extend(ud.reference_args)
> +
>          ud.shallow_skip_fast =3D False
>          ud.shallow =3D d.getVar("BB_GIT_SHALLOW") =3D=3D "1"
>          ud.shallow_extra_refs =3D (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS")=
 or
> "").split()
> @@ -436,7 +446,7 @@ class Git(FetchMethod):
>                  objects =3D os.path.join(repourl_path, 'objects')
>                  if os.path.isdir(objects) and not os.path.islink(objects=
):
>                      repourl =3D repourl_path
> -            clone_cmd =3D ud.basecmd + ['clone', '--bare', '--mirror',
> repourl, ud.clonedir, '--progress']
> +            clone_cmd =3D ud.basecmd + ['clone', '--bare', '--mirror'] +
> ud.reference_args + [repourl, ud.clonedir, '--progress']
>              if ud.proto.lower() !=3D 'file':
>                  bb.fetch2.check_network_access(d, clone_cmd, ud.url)
>              progresshandler =3D GitProgressHandler(d)
> --
> 2.44.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19794):
> https://lists.openembedded.org/g/bitbake-devel/message/19794
> Mute This Topic: https://lists.openembedded.org/mt/119994628/1050810
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--0000000000004fa34f06552d806c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 26, 2026 at 3:10=
=E2=80=AFPM Daniel Walker via <a href=3D"http://lists.openembedded.org">lis=
ts.openembedded.org</a> &lt;danielwa=3D<a href=3D"mailto:cisco.com@lists.op=
enembedded.org">cisco.com@lists.openembedded.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Adds a option to the git fe=
tcher which can be used to specify a local<br>
reference for a given SRC_URI. Which is then fed into the clone command<br>
as &quot;--reference-if-able&quot; which make the option fault tolerant if =
the<br>
directory doesn&#39;t exist.<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">We tried this in the past (may=
be 10 years ago now) to chunk the</div><div class=3D"gmail_default" style=
=3D"font-size:small">kernel into different sets=C2=A0<span style=3D"backgro=
und-color:transparent">of blobs and do a set of references for=C2=A0</span>=
</div><div class=3D"gmail_default" style=3D"font-size:small"><span style=3D=
"background-color:transparent">optimal=C2=A0sharing, repacking,=C2=A0</span=
><span style=3D"background-color:transparent">etc.</span></div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">In the end, it was discarded=C2=A0as unn=
ecessary=C2=A0complexity.<br><br>I&#39;m still of the opinion that is the c=
ase. What=C2=A0problem is this solving</div><div class=3D"gmail_default" st=
yle=3D"font-size:small">that justifies the complexity ?</div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">the patch doesn&#39;t show a real world use =
case, what the SRC_URI</div><div class=3D"gmail_default" style=3D"font-size=
:small">would look like, where the referenced clone would be, what would</d=
iv><div class=3D"gmail_default" style=3D"font-size:small">happen if the ref=
erenced repository was somehow=C2=A0cleaned, or</div><div class=3D"gmail_de=
fault" style=3D"font-size:small">any number of different interactions (what=
 happens if shallow is</div><div class=3D"gmail_default" style=3D"font-size=
:small">specified, etc, etc).</div><div class=3D"gmail_default" style=3D"fo=
nt-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sm=
all">Bruce</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
AI-Generated: OpenAI Codex<br>
Signed-off-by: Daniel Walker &lt;<a href=3D"mailto:danielwa@cisco.com" targ=
et=3D"_blank">danielwa@cisco.com</a>&gt;<br>
Change-Id: Ib5eb685ddfb48fa19f1c65cfc468894806f99e83<br>
---<br>
=C2=A0.../bitbake-user-manual-fetching.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +++++++<br>
=C2=A0lib/bb/fetch2/git.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +=
++++++++++-<br>
=C2=A02 files changed, 18 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc=
/bitbake-user-manual/bitbake-user-manual-fetching.rst<br>
index b96018a4e..6e4fc0800 100644<br>
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst<br>
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst<br>
@@ -398,6 +398,13 @@ This fetcher supports the following parameters:<br>
=C2=A0 =C2=A0 preserve the local cache carefully for future use. The defaul=
t value<br>
=C2=A0 =C2=A0 for this parameter is &quot;0&quot;.<br>
<br>
+-=C2=A0 *&quot;reference&quot;:* Specifies a local directory to use as a r=
eference<br>
+=C2=A0 =C2=A0repository. When set, the fetcher passes the directory to ``g=
it clone``<br>
+=C2=A0 =C2=A0with ``--reference-if-able``. Git uses the reference reposito=
ry&#39;s<br>
+=C2=A0 =C2=A0objects when possible, reducing the amount of object data cop=
ied or<br>
+=C2=A0 =C2=A0fetched. If the reference directory cannot be used, Git conti=
nues<br>
+=C2=A0 =C2=A0cloning without it.<br>
+<br>
=C2=A0-=C2=A0 *&quot;nobranch&quot;:* Tells the fetcher to not check the SH=
A validation for<br>
=C2=A0 =C2=A0 the branch when set to &quot;1&quot;. The default is &quot;0&=
quot;. Set this option for<br>
=C2=A0 =C2=A0 the recipe that refers to the commit that is valid for any na=
mespace<br>
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
index 0fbd85441..df1c4415f 100644<br>
--- a/lib/bb/fetch2/git.py<br>
+++ b/lib/bb/fetch2/git.py<br>
@@ -22,6 +22,10 @@ Supported SRC_URI options are:<br>
=C2=A0 =C2=A0 remind fetcher to preserve local cache carefully for future u=
se.<br>
=C2=A0 =C2=A0 The default value is &quot;0&quot;, set rebaseable=3D1 for re=
baseable git repo.<br>
<br>
+- reference<br>
+=C2=A0 =C2=A0Use the specified local directory as a reference repository b=
y passing it<br>
+=C2=A0 =C2=A0to git clone with --reference-if-able.<br>
+<br>
=C2=A0- nocheckout<br>
=C2=A0 =C2=A0 Don&#39;t checkout source code when unpacking. set this optio=
n for the recipe<br>
=C2=A0 =C2=A0 who has its own routine to checkout code.<br>
@@ -195,6 +199,12 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ud.bareclone:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.cloneflags.append(&quot;=
--mirror&quot;)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.reference_args =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.reference =3D ud.parm.get(&quot;reference&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.reference:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.reference_args =3D [&quot;--r=
eference-if-able&quot;, ud.reference]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.cloneflags.extend(ud.referenc=
e_args)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.shallow_skip_fast =3D False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.shallow =3D d.getVar(&quot;BB_GIT_SHAL=
LOW&quot;) =3D=3D &quot;1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.shallow_extra_refs =3D (d.getVar(&quot=
;BB_GIT_SHALLOW_EXTRA_REFS&quot;) or &quot;&quot;).split()<br>
@@ -436,7 +446,7 @@ class Git(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0objects =3D o=
s.path.join(repourl_path, &#39;objects&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.is=
dir(objects) and not os.path.islink(objects):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0repourl =3D repourl_path<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clone_cmd =3D ud.basecmd + [&#39=
;clone&#39;, &#39;--bare&#39;, &#39;--mirror&#39;, repourl, ud.clonedir, &#=
39;--progress&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clone_cmd =3D ud.basecmd + [&#39=
;clone&#39;, &#39;--bare&#39;, &#39;--mirror&#39;] + ud.reference_args + [r=
epourl, ud.clonedir, &#39;--progress&#39;]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ud.proto.lower() !=3D &#=
39;file&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fetch2.che=
ck_network_access(d, clone_cmd, ud.url)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0progresshandler =3D GitProg=
ressHandler(d)<br>
-- <br>
2.44.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19794): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19794" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19794</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/119994628/105=
0810" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/119994628/1050810</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:bruce.ashfield@gmail.com" target=
=3D"_blank">bruce.ashfield@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">- Thou shalt not follow the NULL pointer, for chaos and madness a=
wait thee at its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star T=
rek II<br><br></div></div>

--0000000000004fa34f06552d806c--

