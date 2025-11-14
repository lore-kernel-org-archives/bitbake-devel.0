Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39226CDB464
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 06:16:07 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12084.1763100956826526548
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 22:15:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AOlow2Pt;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8824ce98111so20366316d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 22:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763100956; x=1763705756; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1p2w7FjU+uyEqMUP6Q/b++81YHV2L46wBKrXAqmEs8=;
        b=AOlow2PtIDprKWYOdSpWPTU5Nx2dQ+0tJTECionoTRavf8bNUhZ4kVDBPDrbxRxXvR
         0LnfGwAgO0j+ZZPFXhZsESHoky23Va1LEyk7vhh7oBv4cts8GqMd2XjA5rIrtSttU3+u
         /t6uLW5BxHXybmF5Qfla9uXL0rD74/p08SrA7CvSuVQAA9MXlxCrSnAVOO3PT4oaR1AJ
         2+s/dUAzdfihyHEjZiODY0I4FF8VIvadGkZTtz4gCAsxJgPItydp+Ss7hL13D5NIqKTR
         A5rKNH+g6NghViYnKXw8UlcDgR6egq7Qje1ldSPhPClYlzXtO2srk0b0IP8QHMNus+B9
         HC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763100956; x=1763705756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1p2w7FjU+uyEqMUP6Q/b++81YHV2L46wBKrXAqmEs8=;
        b=I7D9fEV4tFgdChOpQEPcqINOm5RVM3HSQ+fv9Lyxj6lrrrI5vgfvwJZ5ZMCF94Yume
         goVW2GGE3+zmzXyc3l6R2xsFrpOZ6owyHt113vDZ0vC9oS4n1Z5yT1LtxOHxBnnkfK4f
         7gCx3te1Y3XwQmlPs3UA2Jhi4IJkjWfeyMftRVqH9vh1EdAQOsq/j58Vla2vj7MSkZFB
         wr2K5qgWh/WxezU+nYeADqm9mbH451pEImd1tRO2GflO7MXyyN5lqpL+Z2/7zukiHVRK
         McGWmwBrJ2L+PrPOvBXXC3hLihThyBADC/HA4vMYEPBLGS3wjg6XHuaZY2fVEUyJjq3h
         fBVQ==
X-Gm-Message-State: AOJu0YzogPX+aq/fjUb0g4pbew9lt08K6QO49X2+F4k4cq8eKrfCfVSS
	8sCc+rGuvEUn+yzcePJbS02fTzPU291Btw2YwynM0mBLp6MPbyw/gmoBF/GegQ67T+0uUkInkrj
	ObrQVezYveonEEn2cvvHFojiQK2ZenhI=
X-Gm-Gg: ASbGncvb4T2tlM4ljr3y2vV282LLmd3syo7ekkSNr1057YrE/PzHjlD9USUituGo+KW
	ErR4rksXLB4RdI0yapqpuybmxpYl05xNSpDuQnhP2dAQ5ZxWzsfI7SU5kPu45WmrCLijP5Xa3nY
	6JMJWzi/yHle3FCS0XXNmjfiqXHd5XrX6zfEWRWKv14iQ9R08Nfk6dfbeDAx0R1XzuF8SIj9pi2
	R13EiAOz2zaooznnSExhHf+BrhB5mxvlxodNAlQqoGGsBn0c2MQVPfedmIRzVEVi8v1YZO4tjmV
	TK29xOOtK1V5PxHoUo819iGFgzow2Fl2Wj2hAx4i
X-Google-Smtp-Source: AGHT+IEezULaMpsKgjoE2IgoLNxXkYmUc8hTzEqZcP3Y51GozKk5uUITuEEFRqMosWe+BWfrzsRosfKFTeuz+N4tesk=
X-Received: by 2002:a05:6214:1c0e:b0:882:4fc3:5f1f with SMTP id
 6a1803df08f44-8829263b8damr25374656d6.38.1763100955279; Thu, 13 Nov 2025
 22:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
In-Reply-To: <20251114060211.1742728-1-Qi.Chen@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 14 Nov 2025 07:15:44 +0100
X-Gm-Features: AWmQ_bk-6dxOmZikRDEiD9PBSo01r8WqiYnoqYWyhFjBnMxvPQB_PZ-ikMikzYY
Message-ID: <CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
To: Qi.Chen@windriver.com
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Type: multipart/alternative; boundary="000000000000248504064387ee48"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 06:16:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18382

--000000000000248504064387ee48
Content-Type: text/plain; charset="UTF-8"

You need to explain the difference between v1 and v2 and why v2 is needed.
What was wrong with v1?

The environment pass through hack is horrible.

Alex

On Fri 14. Nov 2025 at 7.02, <Qi.Chen@windriver.com> wrote:

> From: Chen Qi <Qi.Chen@windriver.com>
>
> When an internal fragment is enabled, and there's already a value
> for the corresponding variable, we should error out to avoid any
> confusion.
>
> For example, when 'machine/qemux86-64' fragement is enabled, and
> we get some "MACHINE = xxx" in local.conf or env, we should error
> out and recomment users to use 'bitbake-config-build disable-fragment'.
>
> We should be tolerating weak assignments. For example, DISTRO defaults
> to "nodistro", and when 'distro/poky" fragment is enabled, there should
> be no confusion.
>
> The implementation hacks the environment variable as a way to tell
> bitbake that we're using 'bitbake-config-build'. Because we recommend
> users to use bitbake-config-build, then it should not error out.
>
> Fixes [YOCTO #16060]
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  bin/bitbake-layers  | 3 +++
>  lib/bb/parse/ast.py | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/bin/bitbake-layers b/bin/bitbake-layers
> index 341ecbcd9..c4569c6c3 100755
> --- a/bin/bitbake-layers
> +++ b/bin/bitbake-layers
> @@ -64,6 +64,9 @@ def main():
>          if global_args.force > 1:
>              bbpaths = []
>          else:
> +            if toolname == "bitbake-config-build":
> +                os.environ["BB_ENV_PASSTHROUGH_ADDITIONS"] =
> os.getenv("BB_ENV_PASSTHROUGH_ADDITIONS") + "
> _BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_"
> +                os.environ["_BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_"] = "1"
>              tinfoil.prepare(True)
>              bbpaths = tinfoil.config_data.getVar('BBPATH').split(':')
>
> diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> index e6ff1ff76..70a2a37a6 100644
> --- a/lib/bb/parse/ast.py
> +++ b/lib/bb/parse/ast.py
> @@ -364,6 +364,13 @@ class AddFragmentsNode(AstNode):
>          def check_and_set_builtin_fragment(fragment, data,
> builtin_fragments):
>              prefix, value = fragment.split('/', 1)
>              if prefix in builtin_fragments.keys():
> +                if data.getVar(builtin_fragments[prefix],
> noweakdefault=True) != None:
> +                    if not
> os.getenv("_BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_"):
> +                        bb.fatal(
> +                            ("A builtin fragment '%s' is used while %s
> has already got an assignment.\n"
> +                             "Please either disable the fragment or
> remove the value assignment.\n"
> +                             "To disable the fragment, use
> 'bitbake-config-build disable-fragment %s'."
> +                             ) % (fragment, builtin_fragments[prefix],
> fragment))
>                  fragment_history =
> data.varhistory.variable(self.fragments_variable)
>                  loginfo={}
>                  for fh in fragment_history[::-1]:
> --
> 2.34.1
>
>

--000000000000248504064387ee48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">You need to explain the difference between v1 and v2 and =
why v2 is needed. What was wrong with v1?</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">The environment pass through hack is horrible.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Alex</div><div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On =
Fri 14. Nov 2025 at 7.02, &lt;<a href=3D"mailto:Qi.Chen@windriver.com">Qi.C=
hen@windriver.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:=
solid;padding-left:1ex;border-left-color:rgb(204,204,204)">From: Chen Qi &l=
t;<a href=3D"mailto:Qi.Chen@windriver.com" target=3D"_blank">Qi.Chen@windri=
ver.com</a>&gt;<br>
<br>
When an internal fragment is enabled, and there&#39;s already a value<br>
for the corresponding variable, we should error out to avoid any<br>
confusion.<br>
<br>
For example, when &#39;machine/qemux86-64&#39; fragement is enabled, and<br=
>
we get some &quot;MACHINE =3D xxx&quot; in local.conf or env, we should err=
or<br>
out and recomment users to use &#39;bitbake-config-build disable-fragment&#=
39;.<br>
<br>
We should be tolerating weak assignments. For example, DISTRO defaults<br>
to &quot;nodistro&quot;, and when &#39;distro/poky&quot; fragment is enable=
d, there should<br>
be no confusion.<br>
<br>
The implementation hacks the environment variable as a way to tell<br>
bitbake that we&#39;re using &#39;bitbake-config-build&#39;. Because we rec=
ommend<br>
users to use bitbake-config-build, then it should not error out.<br>
<br>
Fixes [YOCTO #16060]<br>
<br>
Signed-off-by: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.com" target=
=3D"_blank">Qi.Chen@windriver.com</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-layers=C2=A0 | 3 +++<br>
=C2=A0lib/bb/parse/ast.py | 7 +++++++<br>
=C2=A02 files changed, 10 insertions(+)<br>
<br>
diff --git a/bin/bitbake-layers b/bin/bitbake-layers<br>
index 341ecbcd9..c4569c6c3 100755<br>
--- a/bin/bitbake-layers<br>
+++ b/bin/bitbake-layers<br>
@@ -64,6 +64,9 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if global_args.force &gt; 1:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bbpaths =3D []<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if toolname =3D=3D &quot;bitbake=
-config-build&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&quot;B=
B_ENV_PASSTHROUGH_ADDITIONS&quot;] =3D os.getenv(&quot;BB_ENV_PASSTHROUGH_A=
DDITIONS&quot;) + &quot; _BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&quot;_=
BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_&quot;] =3D &quot;1&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tinfoil.prepare(True)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bbpaths =3D tinfoil.config_=
data.getVar(&#39;BBPATH&#39;).split(&#39;:&#39;)<br>
<br>
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py<br>
index e6ff1ff76..70a2a37a6 100644<br>
--- a/lib/bb/parse/ast.py<br>
+++ b/lib/bb/parse/ast.py<br>
@@ -364,6 +364,13 @@ class AddFragmentsNode(AstNode):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def check_and_set_builtin_fragment(fragme=
nt, data, builtin_fragments):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prefix, value =3D fragment.=
split(&#39;/&#39;, 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if prefix in builtin_fragme=
nts.keys():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if data.getVar(bui=
ltin_fragments[prefix], noweakdefault=3DTrue) !=3D None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if n=
ot os.getenv(&quot;_BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bb.fatal(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (&quot;A builtin fragment &#39;%s&#39; is used whi=
le %s has already got an assignment.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Please either disable the fragment or =
remove the value assignment.\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;To disable the fragment, use &#39;bitb=
ake-config-build disable-fragment %s&#39;.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0) % (fragment, builtin_fragments[prefix], fr=
agment))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fragment_hist=
ory =3D data.varhistory.variable(self.fragments_variable)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loginfo=3D{}<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for fh in fra=
gment_history[::-1]:<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000248504064387ee48--

