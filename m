Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0047ECAAD4
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 20:55:58 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.4250.1661979356929294370
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Aug 2022 13:55:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=TrbQoKTn;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id t5so19957343edc.11
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Aug 2022 13:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9/cMeaEIX3LJT9h4GWHCk6EsNmbHIapQOQ662dmboOA=;
        b=TrbQoKTnKmn6Aal4S7lD3Ep3bMggX+yJnNW+Zww+QGYFtuNl45GI+pQzgGF+qnTyY4
         e+Fkum1BwGkpi44fRDzGZeG7Dp3uylkN/A0yNY1ywkjohSBjGrkpiKB5O1HNFh86W1nx
         uC5PBCqS7o4bnAaEPRwUPbCuoxg8OJvFBzispvAsW4LaCxbpMfMhmsMjPddgdPJDQokw
         VabhPZv8jR9XX/VhZ0TVFJn1KMfpIu5dLzDsLBLGBVhJmTpfs7ZIgg00ShxfnL1lpPEk
         GJG67JO8H58YDDi04hTA8mtRgZJuv5HhccpdF5sg/RkFGDBnJob0K3kV+129CyRZAu1y
         14mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9/cMeaEIX3LJT9h4GWHCk6EsNmbHIapQOQ662dmboOA=;
        b=pX7CkFepTKGkCwGR5F27XgE8lXDbrhmz5FkRLgHmcvfqmJ30abXKXH64TxBOBmetpo
         3H7mQvqC1kAHSNFhzsiUkXGptczNrFAx2J8w1SMUCxu2rUi2S4mP81shvdKESYjQYjse
         pL2mzZmSci5bixgDHJvLect2/hUPkCJKGhpPnRssAJQzy4dsVcE+Zwk6jFMBZfUu7KEv
         N20MOE2R//3EXkP0SMA1K0Hu/mxMe69aWQOb6b+usgrZvPbg0uwLk9P6RNN7at+6BRMQ
         mdBRbZXHDoTwch8QxogZDFaufA45DB0JDVaBPHMqrdylNr3Xc/1JfgDG97jznyBhC3qm
         1GhQ==
X-Gm-Message-State: ACgBeo0xYmTdzvKuTnCx4m+4uUiqUJ1uZBXBdzntIwCKL2Nro6k4faIN
	7F7waRQTLESMiehPwebh2Gk/91tF3fJ17TH6t8Y21g1MlGg=
X-Google-Smtp-Source: 
 AA6agR79q2HA3kKMH91CHR91GFi7RCaE/x6o5zlbI83rX22C55W+1yxiRunWT8BYup6KcQ9u4LcJQr1nqvKI7REMQTM=
X-Received: by 2002:aa7:d814:0:b0:447:b848:9e53 with SMTP id
 v20-20020aa7d814000000b00447b8489e53mr25301806edq.64.1661979354974; Wed, 31
 Aug 2022 13:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <170B7854B4242295.1911@lists.openembedded.org>
 <0abf1f86-d023-a445-0758-436f4767e7ef@windriver.com>
In-Reply-To: <0abf1f86-d023-a445-0758-436f4767e7ef@windriver.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 31 Aug 2022 13:55:43 -0700
Message-ID: 
 <CABcZAN=rSxhgebWTScxW6tL6+f7k-natKstYWyBVSb11rz1=wA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch: use BPN instead
To: "Yu, Mingli" <mingli.yu@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000013ccce05e78fb992"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Aug 2022 20:55:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13949

--00000000000013ccce05e78fb992
Content-Type: text/plain; charset="UTF-8"

BPN is not defined by bitbake, you're hardcoding OE-specifics into bitbake
with this patch.

On Sun, Aug 28, 2022 at 11:42 PM Yu, Mingli <mingli.yu@windriver.com> wrote:

> Ping.
>
> On 8/15/22 16:46, Yu, Mingli wrote:
> > From: Mingli Yu <mingli.yu@windriver.com>
> >
> > When checking for the non-existing file, BPN is actually the acutal
> recipe
> > name. And we should use BPN for the error message and it also fix the
> below
> > test when multilib is enabled.
> >   $ oe-selftest -r bbtests.BitbakeTests.test_invalid_recipe_src_uri
> >
> > Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> > ---
> >   lib/bb/fetch2/__init__.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index 0fb718b2..43d07e56 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -1236,7 +1236,7 @@ def get_checksum_file_list(d):
> >               if not found:
> >                   bb.fatal(("Unable to get checksum for %s SRC_URI entry
> %s: file could not be found"
> >                               "\nThe following paths were searched:"
> > -                            "\n%s") % (d.getVar('PN'),
> os.path.basename(f), '\n'.join(paths)))
> > +                            "\n%s") % (d.getVar('BPN'),
> os.path.basename(f), '\n'.join(paths)))
> >
> >       return " ".join(filelist)
> >
> >
> >
> >
> >
> >
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13942):
> https://lists.openembedded.org/g/bitbake-devel/message/13942
> Mute This Topic: https://lists.openembedded.org/mt/93032280/3617123
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> kergoth@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

-- 
Christopher Larson
chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com
Principal Software Engineer, Embedded Linux Solutions, Siemens Digital
Industries Software

--00000000000013ccce05e78fb992
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">BPN is not defined by bitbake, you&#39;re hardcoding OE-sp=
ecifics into bitbake with this patch.</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Sun, Aug 28, 2022 at 11:42 PM Yu, M=
ingli &lt;<a href=3D"mailto:mingli.yu@windriver.com">mingli.yu@windriver.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Ping.<br>
<br>
On 8/15/22 16:46, Yu, Mingli wrote:<br>
&gt; From: Mingli Yu &lt;<a href=3D"mailto:mingli.yu@windriver.com" target=
=3D"_blank">mingli.yu@windriver.com</a>&gt;<br>
&gt; <br>
&gt; When checking for the non-existing file, BPN is actually the acutal re=
cipe<br>
&gt; name. And we should use BPN for the error message and it also fix the =
below<br>
&gt; test when multilib is enabled.<br>
&gt;=C2=A0 =C2=A0$ oe-selftest -r bbtests.BitbakeTests.test_invalid_recipe_=
src_uri<br>
&gt; <br>
&gt; Signed-off-by: Mingli Yu &lt;<a href=3D"mailto:mingli.yu@windriver.com=
" target=3D"_blank">mingli.yu@windriver.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/bb/fetch2/__init__.py | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
&gt; index 0fb718b2..43d07e56 100644<br>
&gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt; @@ -1236,7 +1236,7 @@ def get_checksum_file_list(d):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not found:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb=
.fatal((&quot;Unable to get checksum for %s SRC_URI entry %s: file could no=
t be found&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\nThe following paths were s=
earched:&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;\n%s&quot;) % (d.getVar(&#39;PN&#39;), o=
s.path.basename(f), &#39;\n&#39;.join(paths)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;\n%s&quot;) % (d.getVar(&#39;BPN&#39;), =
os.path.basename(f), &#39;\n&#39;.join(paths)))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot; &quot;.join(filelist)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13942): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13942" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13942</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/93032280/3617=
123" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/93032280/3617123</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:kergoth@gmail.com" target=3D"_blan=
k">kergoth@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><font color=3D=
"#333333">Christopher Larson<br><a>chris_larson@mentor.com</a>,=C2=A0<a>chr=
is.larson@siemens.com</a>,=C2=A0<a>kergoth@gmail.com</a><br>Principal Softw=
are Engineer,=C2=A0Embedded Linux Solutions,=C2=A0Siemens Digital Industrie=
s Software</font><br></div></div></div>

--00000000000013ccce05e78fb992--

