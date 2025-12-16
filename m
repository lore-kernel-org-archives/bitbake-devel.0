Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40CED609BE
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 16:12:06 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26691.1765901517052601853
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Dec 2025 08:11:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=XUNHXWfv;
 spf=pass (domain: smile.fr, ip: 209.85.208.53, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6492e7925d2so5712693a12.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Dec 2025 08:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1765901515; x=1766506315; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1zj0bjkDQByIrZ5mdsfaTwWI6+H91UH18PFrL5q5evw=;
        b=XUNHXWfvej83IIYlUbxhuY6OjEsBzgOiXb42lnibJ9CLLxKzwqFXU3ywWxIixEB3y9
         Yb5hg41DHk4CmuqcRt7ol6cswIHQ0Pl0ARPXl6mMhdB8sJflTJflyDQGIQ6wKP61Kwqs
         51n9XlC0NFDmfX6e7vcDxVJ7z9OASust6niKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765901515; x=1766506315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zj0bjkDQByIrZ5mdsfaTwWI6+H91UH18PFrL5q5evw=;
        b=HwDavF4nsmM2si+4cXu7ulw2VWmEstLi1qr/8JOIemMOOcY45x6WeerDOSLzDmmysF
         /eeOmnqYmihUY0zZBd16doHD7+3IXS0oEQ46DS+NZ2tR04PW3NwXtH2S9RS5AbYyGpsO
         H94iNX6jJEfYwhVbdH+mnH0EQs62uj5cWyi1GIPvIH26Tzhv3CoV2xy0ziY+8ZUsFvxq
         5XUreYLLTYvWDhNXziLO2s3m7XloqeQmjl2tGQSsJCG2RU4Tena6LakXZzadTCuBPSAJ
         +Ud19cCfJfxi3+7+Pu+k5asiadOZJy6iIlGYyNkeSxeYT8oPXG+NZN41jF31yCiYJSEY
         x/gQ==
X-Gm-Message-State: AOJu0YwoGopJ+HNtCNsh4xOWhn/iOvZFmlZkk8/ZIJ3ZLmjysUR9ux38
	jgL5D3zVdpkbLr1DZbyIGnvdyMCvWOOAC6q1MYWHUX32SaS1aBxg8Y39t/ZUuBE2OfE3wA0+REJ
	rm85HZWtChTwQu0p1xlfJf/3LQGptkcU9aZ6DfB8adg==
X-Gm-Gg: AY/fxX4oijelezAJ+x03TROJdBgbT0FKkjRctNL5go0W/UyFVx/TXVJJ/1pPGmCQJez
	E76Jnsa3dmjFFestNi/iuQ99TzmWaaESMyVeFVo5LtSNAsG10TnCzaNlIempYp6x7vh+NNjaBQJ
	fYgGQEbnalsy8wqm0G+ccpnxy8OepEwLgt6BmZUYZppELwYkF3o8LQKaBYbCSrtazFBPwvstqN0
	t8Nc37+NPpNShNq7n3HIKmbPzzBfJDijKxjWDcoV73EP1ABgaRf83qTNn6IP6wC6PiCjL7HR3gh
	ZpdIIwx7U/MgNw1fN6ccJBlf0A==
X-Google-Smtp-Source: AGHT+IG71zAf+RwSwgVrC9jaE93NCMdVQ3mfOSkQjnhOIHlKly1HkWFnUa0Aw/lFBhcCHne2g0zay3sHDyKP8iQKX0A=
X-Received: by 2002:a05:6402:3551:b0:649:81f6:c35b with SMTP id
 4fb4d7f45d1cf-6499b118103mr15259465a12.7.1765901515336; Tue, 16 Dec 2025
 08:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20251215103256.902711-1-corentin.guillevic@smile.fr> <CANNYZj_4XFj2Sgv1Q4_=BwDBCAtCpj5X=XfQ2=CuiJjoqOrA4w@mail.gmail.com>
In-Reply-To: <CANNYZj_4XFj2Sgv1Q4_=BwDBCAtCpj5X=XfQ2=CuiJjoqOrA4w@mail.gmail.com>
From: Corentin GUILLEVIC <corentin.guillevic@smile.fr>
Date: Tue, 16 Dec 2025 17:11:44 +0100
X-Gm-Features: AQt7F2osqfTEthVxrmwl_A0VFjGS3rwJfLHEB4Udpnd-z-RqHQXw3oVnbSUL6Yw
Message-ID: <CAMFqQmq8G-JLzZ6zfkrXThSnCYQq16jjLY0spUhOrHv+=xA0DQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/3] bitbake-setup: add inline URI
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000087bb84064613fc37"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Dec 2025 16:12:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18601

--00000000000087bb84064613fc37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your review, I have taken it into account.

However, what is it expected of the registered remote(s) once the source
has been cloned? When using several remotes for one source, I discovered
that they are all cloned but only one is registered in the final layer (in
the layers/ directory). For example, we can add another remote to the
bitbake layer in the 'oe-nodistro-master' configuration, but this results
in only one remote in bitbake-builds/oe-nodistro-master/layers/bitbake/.

How to reproduce:
# In-place edition, add a new remote called "origin-2"
$ jq --indent 4 '.sources.bitbake."git-remote".remotes +=3D {"origin-2":
{"uri": "https://github.com/distro-core-curated-mirrors/bitbake/"}}' \
  default-registry/configurations/oe-nodistro-master.conf.json | sponge
default-registry/configurations/oe-nodistro-master.conf.json
# Clear previous work
$ rm -rf bitbake-builds/oe-nodistro-master/
# Choose 'oe-nodistro-master'
$ ./bin/bitbake-setup init
$ git -C bitbake-builds/oe-nodistro-master/layers/bitbake/ remote -v
origin  https://github.com/distro-core-curated-mirrors/bitbake/ (fetch)
origin  https://github.com/distro-core-curated-mirrors/bitbake/ (push)

What should print the command "git remote -v"?

Corentin

Le lun. 15 d=C3=A9c. 2025 =C3=A0 12:01, Alexander Kanavin <alex.kanavin@gma=
il.com> a
=C3=A9crit :

> On Mon, 15 Dec 2025 at 11:33, Corentin Guillevic via
> lists.openembedded.org
> <corentin.guillevic=3Dsmile.fr@lists.openembedded.org> wrote:
> > +        if 'remotes' in r_remote:
> > +            if not 'bitbake-setup-uri' in r_remote['remotes']:
> > +                r_name =3D 'bitbake-setup-uri'
> > +            else:
> > +                idx =3D 1
> > +                while 'bitbake-setup-uri_{}'.format(idx) in
> r_remote['remotes']:
> > +                    idx +=3D 1
> > +                r_name =3D 'bitbake-setup-uri_{}'.format(idx)
> > +        else:
> > +            r_name =3D 'bitbake-setup-uri'
> > +
> > +        remotes.update({r_name: {'uri': r_remote['uri']}})
>
> Thanks for continuing to work on this.
>
> I think we can avoid adding the above code, see below.
>
> > -        remotes =3D r_remote['remotes']
> > +
> > +        remotes =3D _get_remotes(r_remote)
> >
> >          for remote in remotes:
> >              prot,host,path,user,pswd,params =3D
> bb.fetch.decodeurl(remotes[remote]["uri"])
>
> The names of the remotes are not actually used anywhere for anything.
> So the _get_remotes() can return a flat list of URIs instead, and then
> it doesn't have to do complicated name calculations like implemented
> above. Then this loop can iterate directly on URIs in the list.
>
> Alex
>

--00000000000087bb84064613fc37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Thank you for your =
review, I have taken it into account.</div><div><br></div><div>However, wha=
t is it expected of the registered remote(s) once the source has been clone=
d? When using several remotes for one source,=C2=A0I discovered that=C2=A0t=
hey are all cloned but only one is registered in the final layer (in the la=
yers/ directory). For example, we can add another remote to the bitbake lay=
er in the &#39;oe-nodistro-master&#39; configuration, but this results in o=
nly one remote in=C2=A0bitbake-builds/oe-nodistro-master/layers/bitbake/.</=
div><div><br></div><div>How to reproduce:</div><div># In-place edition, add=
 a new remote called &quot;origin-2&quot;</div><div>$ jq --indent 4 &#39;.s=
ources.bitbake.&quot;git-remote&quot;.remotes +=3D {&quot;origin-2&quot;: {=
&quot;uri&quot;: &quot;<a href=3D"https://github.com/distro-core-curated-mi=
rrors/bitbake/" target=3D"_blank">https://github.com/distro-core-curated-mi=
rrors/bitbake/</a>&quot;}}&#39; \<br>=C2=A0 default-registry/configurations=
/oe-nodistro-master.conf.json | sponge default-registry/configurations/oe-n=
odistro-master.conf.json<br></div><div># Clear previous work</div><div>$ rm=
 -rf bitbake-builds/oe-nodistro-master/</div><div># Choose &#39;oe-nodistro=
-master&#39;</div><div>$ ./bin/bitbake-setup init<br>$ git -C bitbake-build=
s/oe-nodistro-master/layers/bitbake/ remote -v<br>origin =C2=A0<a href=3D"h=
ttps://github.com/distro-core-curated-mirrors/bitbake/" target=3D"_blank">h=
ttps://github.com/distro-core-curated-mirrors/bitbake/</a> (fetch)<br>origi=
n =C2=A0<a href=3D"https://github.com/distro-core-curated-mirrors/bitbake/"=
 target=3D"_blank">https://github.com/distro-core-curated-mirrors/bitbake/<=
/a> (push)</div><div><br></div><div>What should print the command &quot;git=
 remote -v&quot;?</div><div><br></div><div>Corentin</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0lun. 15 d=
=C3=A9c. 2025 =C3=A0=C2=A012:01, Alexander Kanavin &lt;<a href=3D"mailto:al=
ex.kanavin@gmail.com" target=3D"_blank">alex.kanavin@gmail.com</a>&gt; a =
=C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Mon, 15 Dec 2025 at 11:33, Corentin Guillevic via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a><br>
&lt;corentin.guillevic=3D<a href=3D"mailto:smile.fr@lists.openembedded.org"=
 target=3D"_blank">smile.fr@lists.openembedded.org</a>&gt; wrote:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;remotes&#39; in r_remote:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not &#39;bitbake-setup-u=
ri&#39; in r_remote[&#39;remotes&#39;]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r_name =3D &#=
39;bitbake-setup-uri&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 idx =3D 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while &#39;bi=
tbake-setup-uri_{}&#39;.format(idx) in r_remote[&#39;remotes&#39;]:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 idx +=3D 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r_name =3D &#=
39;bitbake-setup-uri_{}&#39;.format(idx)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r_name =3D &#39;bitbake-set=
up-uri&#39;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 remotes.update({r_name: {&#39;uri&#39;: r=
_remote[&#39;uri&#39;]}})<br>
<br>
Thanks for continuing to work on this.<br>
<br>
I think we can avoid adding the above code, see below.<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 remotes =3D r_remote[&#39;remotes&#39;]<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 remotes =3D _get_remotes(r_remote)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for remote in remotes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot,host,path,user,ps=
wd,params =3D bb.fetch.decodeurl(remotes[remote][&quot;uri&quot;])<br>
<br>
The names of the remotes are not actually used anywhere for anything.<br>
So the _get_remotes() can return a flat list of URIs instead, and then<br>
it doesn&#39;t have to do complicated name calculations like implemented<br=
>
above. Then this loop can iterate directly on URIs in the list.<br>
<br>
Alex<br>
</blockquote></div>
</div>
</div>

--00000000000087bb84064613fc37--

