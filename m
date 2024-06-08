Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12552C25B76
	for <webhook@archiver.kernel.org>; Sat,  8 Jun 2024 10:22:07 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.3959.1717842122023509873
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 08 Jun 2024 03:22:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=C99yqzxk;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52962423ed8so3406387e87.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 08 Jun 2024 03:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717842120; x=1718446920; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TBKj1lTRRBdG/BcGVlrZlavZRURKS8pvKIKiVupyfZI=;
        b=C99yqzxkgL654nFGgekw0xmkpzex+mnIJLUdE8GL/BcRWaNHdzM9XqRtICC6ypqOym
         6qKe8sN2UOwAZw9v0h5fB6kWwcLUJw1EQrJs8ZJKnD2qI9IhaaPaWJxlK4TB2myUXqR2
         QO6pbX7CwX2l3nFwIinvN2KNED27jgbIbO0N6gX1g2H1tyeBbGbynW5cXamMoY3nnAAQ
         23ZMcIb4gVMRUkxJNO00d0ImGeOeC8IDEi9CQdOjl3C4uLgoHTP0d9R5DggbsFsAvY+C
         riKcvScoqlgOxOk7mttGb5NR/DVP0nbnbekLTj/C+L0wuUti6PL4Vkm0IW9jmOfCNLlr
         hyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717842120; x=1718446920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBKj1lTRRBdG/BcGVlrZlavZRURKS8pvKIKiVupyfZI=;
        b=NrI0w182ntgNfJFcLLpwtKgHIRiH1bMmre4SMsVYxMXWjYsJTvMs1BM6oczZnaud9W
         ufuiP7RGpt3ot++JLbRv7A9RR01asU57DmVKhdD1yopYMXBzTnFkTyWX4W5/L3+jXnPH
         Bi7NNfzfQFzpQjx7zjWO9WArcLM0AvChFxFsvOJhkU7PA92pqRtvbcgkn/rgN0ixKYd4
         sBPnf3JcpWtei/t2rf/C8rcACxCE0L5oxeHi5EYwMmPqeuYLVpe7bEek4Xx7+wdGYuKG
         FUwX3DPSOQg5VtrvsmYcFxQ3TiLU/q9PO0mMq46qVgpqV99mzCEgIUA/CO9O0jw++tnY
         55kg==
X-Forwarded-Encrypted: i=1; AJvYcCWAr7RM1d9LiplyAv5jZ2jooE1uMseUH7fK8vYL6i1384No34iTs8IKeERjJJl2iBNtUY2jr8F3pu+PtXU0+vjJqaCbQ91rP1NRAb19nXRHdNGUAo8=
X-Gm-Message-State: AOJu0YyYgGIolBLMUqVqO3er7zttlsarXPFCv7kqwCLvC54U0sePRVTY
	Txhv9icRuVvS18KRRvKDdj+lyS+m2TB5v/d44eQND2eU7r8AXuoaHWTmDJBQ1rSBlpO1lARSGcD
	lkM7b+x0wZsUXjVgdY4T5OIp0J7I=
X-Google-Smtp-Source: AGHT+IEpFcCdX0Y5IUHqyUuS/+8SZMy0VhR7iz116v8j0g5guOmr6fySbsF8dG7hUP6Ab6FzduZnVOjDzVqWjIj+kvQ=
X-Received: by 2002:ac2:4ec2:0:b0:52c:823a:2ab8 with SMTP id
 2adb3069b0e04-52c823a2bcemr308449e87.37.1717842119678; Sat, 08 Jun 2024
 03:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240604142803.3658144-1-richard.purdie@linuxfoundation.org>
 <202406081016282d36c3ad@mail.local> <28eec7ae10919151679dbaefb9db807c92b1f1cf.camel@linuxfoundation.org>
In-Reply-To: <28eec7ae10919151679dbaefb9db807c92b1f1cf.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 8 Jun 2024 12:21:48 +0200
Message-ID: <CANNYZj9QZ6Y4m+2ECwAtQLe784g0CQcQPxY-v-YmNwd+rQRvaA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] siggen: Drop copy_unihashes function
To: richard.purdie@linuxfoundation.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000052e582061a5e4961"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 08 Jun 2024 10:22:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16332

--00000000000052e582061a5e4961
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think it=E2=80=99s in my patch set for build replication that needs to be
reworked to not use the function and should be dropped until then.

Alex

On Sat 8. Jun 2024 at 12.18, Richard Purdie via lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:

> On Sat, 2024-06-08 at 12:16 +0200, Alexandre Belloni wrote:
> > Hello Richard,
> >
> >
> > On 04/06/2024 15:28:02+0100, Richard Purdie wrote:
> > > The code in OE-Core using this has been replaced with something
> > > more fit
> > > for purpose. Drop these function calls as they were never a great
> > > idea in the
> > > first place and cause IO slowdown for runqueue needing to sync the
> > > cache.
> > >
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > ---
> > >  lib/bb/siggen.py | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> > > index 92066da00c..89b70fb6a4 100644
> > > --- a/lib/bb/siggen.py
> > > +++ b/lib/bb/siggen.py
> > > @@ -201,9 +201,6 @@ class SignatureGenerator(object):
> > >      def save_unitaskhashes(self):
> > >          return
> > >
> > > -    def copy_unitaskhashes(self, targetdir):
> > > -        return
> > > -
> > >      def set_setscene_tasks(self, setscene_tasks):
> > >          return
> > >
> > > @@ -418,9 +415,6 @@ class
> > > SignatureGeneratorBasic(SignatureGenerator):
> > >      def save_unitaskhashes(self):
> > >          self.unihash_cache.save(self.unitaskhashes)
> > >
> > > -    def copy_unitaskhashes(self, targetdir):
> > > -        self.unihash_cache.copyfile(targetdir)
> > > -
> >
> > It breaks sstatetests.SStateBundles.test_minimal_bundle which uses
> > copy_unitaskhashes
>
>
> Is that patch only in your -next branch? I didn't see this issue in my
> own testing which makes me wonder...
>
> Cheers,
>
> Richard
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16331):
> https://lists.openembedded.org/g/bitbake-devel/message/16331
> Mute This Topic: https://lists.openembedded.org/mt/106483284/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000052e582061a5e4961
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I think it=E2=80=99s in my patch set for build replicatio=
n that needs to be reworked to not use the function and should be dropped u=
ntil then.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Alex</div><di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On S=
at 8. Jun 2024 at 12.18, Richard Purdie via <a href=3D"http://lists.openemb=
edded.org">lists.openembedded.org</a> &lt;richard.purdie=3D<a href=3D"mailt=
o:linuxfoundation.org@lists.openembedded.org">linuxfoundation.org@lists.ope=
nembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;padding-left:1ex;border-left-color:rgb(204,204,204)">On Sat, 2024-06-08 a=
t 12:16 +0200, Alexandre Belloni wrote:<br>
&gt; Hello Richard,<br>
&gt; <br>
&gt; <br>
&gt; On 04/06/2024 15:28:02+0100, Richard Purdie wrote:<br>
&gt; &gt; The code in OE-Core using this has been replaced with something<b=
r>
&gt; &gt; more fit<br>
&gt; &gt; for purpose. Drop these function calls as they were never a great=
<br>
&gt; &gt; idea in the<br>
&gt; &gt; first place and cause IO slowdown for runqueue needing to sync th=
e<br>
&gt; &gt; cache.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdi=
e@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org=
</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; =C2=A0lib/bb/siggen.py | 6 ------<br>
&gt; &gt; =C2=A01 file changed, 6 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py<br>
&gt; &gt; index 92066da00c..89b70fb6a4 100644<br>
&gt; &gt; --- a/lib/bb/siggen.py<br>
&gt; &gt; +++ b/lib/bb/siggen.py<br>
&gt; &gt; @@ -201,9 +201,6 @@ class SignatureGenerator(object):<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 def save_unitaskhashes(self):<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0 def copy_unitaskhashes(self, targetdir):<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return<br>
&gt; &gt; -<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 def set_setscene_tasks(self, setscene_ta=
sks):<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; @@ -418,9 +415,6 @@ class<br>
&gt; &gt; SignatureGeneratorBasic(SignatureGenerator):<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0 def save_unitaskhashes(self):<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.unihash_cac=
he.save(self.unitaskhashes)<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0 def copy_unitaskhashes(self, targetdir):<br>
&gt; &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.unihash_cache.co=
pyfile(targetdir)<br>
&gt; &gt; -<br>
&gt; <br>
&gt; It breaks sstatetests.SStateBundles.test_minimal_bundle which uses<br>
&gt; copy_unitaskhashes<br>
<br>
<br>
Is that patch only in your -next branch? I didn&#39;t see this issue in my<=
br>
own testing which makes me wonder...<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16331): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16331" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16331</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/106483284/168=
6489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/106483284/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--00000000000052e582061a5e4961--

