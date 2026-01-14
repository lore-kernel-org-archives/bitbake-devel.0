Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EBED38FFE
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 17:25:16 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15776.1768411511018553747
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 09:25:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZXMEoPb8;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014453a0faso194671cf.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 09:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768411510; x=1769016310; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJlUHEGhx4cKNks57jPsFe0804anehhR/d26pqeICK8=;
        b=ZXMEoPb8dVltY8kRgN3ZH4uCt+O6DDeivK50WaIExjmmSeP8SnwrDSoxwkn43yi24p
         ZorsgJ/oujGSOG+XuqrzRKyTllrBgrMDLwmfuE5tyIwbvTomAcqUALN5Bm0V7E3h80hD
         FHTNNMDEOERJ9/0cUfQ+8pD4gRHbrzK5lqMXs35NOUORd9RZBczlKsqRqQ1wOg12F3aC
         zrCKz0uaf2lo1A923Vy4riuhhlGkR7zwUBs9+oTA2ud6RcQTWzZy91ON+LoYVQlI4ruK
         AJUAElsd9KWkiUD0Qy0vITHwt/r4iQqYZMOxfLbq1x3Tu90AHWwaC9wsMjX4L0wYJc6y
         7KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411510; x=1769016310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJlUHEGhx4cKNks57jPsFe0804anehhR/d26pqeICK8=;
        b=VrI/gp6EvfQEteQJTXuwYnBpTyhe5dblK+MV0lpnj2YjKZeFjm+3FXapEi2FOAf+Ko
         a3CfAMJLONCa98vI1jUe6hfJI2YEQbd/ikrDK2Ysfe7JxZ/vJRi/L9H0peQY1fvvwp0W
         crXAwGNeuezH/sc0TwrjaYjdYqnByytHX6p5wT0yIJ/GFvYufD/d4XbRm/4qHglwQt8L
         gTmOSk6b9m3bXTUmbEubJyrfhuk59LCHIf6BZPYsdVxi4+syevZlU3OI1Y41OEm3O1t4
         LG/0rW5wdL+RrktFpE59yCabt68AZ0bb1P5/IZ59JsJMVTkWOSjMN48XQevbzUFQ0IB5
         9l0g==
X-Gm-Message-State: AOJu0Yx8qfHhtJlFT/Pe7GqUqIDUiizCXhbYTpNyIE3wsZNRpidbW6Ej
	wY+rSVRQzbU0vyJju771yIseO9u5ny7voBvMrX2V0444c4WaaWSV9kETj9CDRKpWi1+MXfiRxVI
	ffuU5TiPkgNM2etVB0NrMNiDjSIjuZKa5AVF3
X-Gm-Gg: AY/fxX6wyhmuxQJu1GUkU8Lr9TCRMgsz+0kZqmHxc2Ja1tG4IOxXElL9tM5D47uXj1S
	D8EDT7BmcGV4x2BGJlZmAcUOEbKCu3a/Cv3zRQ00T8ymxvxAwRglHX9vjuHqzpyuUDndhG9db1y
	lm60vuFZm6R/ZXWoP5MorSwYmF4Y23WOq2jMkgBX3lW3F604tYoQEw6OfEpeR2bkBafgcZeVDIB
	mwr6RRWCGXp2COnQMbPFYW9GsgTSkEeqdqeD1bQC/TMrrv29SK+7T5uddxtOq4NBJVc+wNqVi2D
	NRHn/Vo=
X-Received: by 2002:ac8:5e4e:0:b0:4ee:9b1:e32 with SMTP id d75a77b69052e-501481e4e78mr51679811cf.12.1768411509544;
 Wed, 14 Jan 2026 09:25:09 -0800 (PST)
MIME-Version: 1.0
References: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com>
In-Reply-To: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 14 Jan 2026 18:24:57 +0100
X-Gm-Features: AZwV_QhJ_vecZy8qYfPhvoYtaP5BwpBwZpZB1bA2yIJfz68Kps9v4q_mPWYbm3g
Message-ID: <CANNYZj_ERuqEY6w49NRKO5OsBr-HqG8hDSHiAB-e55LVhZq=cQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC] bitbake-setup: Documentation terminology
 and tooling suggestions
To: otavio.salvador@ossystems.com.br
Cc: bitbake-devel@lists.openembedded.org, 
	Patches and discussions about the oe-core layer <openembedded-core@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000d7d9e106485c6333"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 17:25:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18762

--000000000000d7d9e106485c6333
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 01:03, Otavio Salvador via lists.openembedded.org
<otavio.salvador=ossystems.com.br@lists.openembedded.org> wrote:

> 1. pip-installed bitbake-setup Cannot Access Default Registries
>
> When installing bitbake-setup via pip and running bitbake-setup init, the
> command fails because it cannot locate the default registry files that
> would normally be at ./bitbake/default-registry/.
>
> This creates a confusing first experience for users who expect a
> pip-installed tool to work out of the box. Having to clone the full BitBake
> repository defeats the convenience of pip installation.
>
bitbake-setup in pip is known to be broken and not ready. Please do not try
to use it until it has an announcement and a place in the official
documentation.

We put it there just to avoid someone else squatting on the pypi project
name, and that required uploading 'something'. I worried even then that
users will find the package and make assumptions about using it, and now it
happened.

> 3. Unclear Error When Using Non-Raw URLs
>
> When running bitbake-setup init with a URL to a .conf.json file hosted on
> platforms like GitHub or GitLab, users naturally copy the URL from their
> browser. This URL points to an HTML page rather than the raw JSON content,
> causing the command to fail.
>
> The error message does not clearly indicate that a raw/plain URL is
> required. A clearer error message or guidance would help users understand
> the issue more quickly.
>
This shouldn't be difficult to fix. Can you propose a patch?

> 4. Tool to Generate Templates from Existing Environments
>
> Currently, there is no way to generate a BitBake Setup Template from:
>
>    - An existing BitBake Setup Instance
>    - A traditional workspace set up manually with oe-init-build-env
>    - Any working Yocto/OpenEmbedded build environment
>
> A tool to export a working environment as a template would:
>
>    - Help users migrate existing projects to the new bitbake-setup
>    workflow
>    - Make it easier to share working configurations with colleagues or
>    the community
>    - Reduce the barrier to adoption for users with established projects
>
> This might be harder than you think. Making a config template from an
existing bitbake-setup driven build (with an empty local.conf) is not hard,
but converting legacy setups requires decomposing local.conf into
fragments, giving them correct names and placing them into correct layers,
something that only a human can do well.

Or the tool can try to do it half-way: put local.conf/bblayers.conf into a
openembedded template into some layer, and then generate a bitbake-setup
with oe-template entry in it. But that in itself is legacy; fragments and
empty local.conf are the future.

For converting established projects the best feasible option might be to
write migration guidelines.

>
>
> 5. Fragment Discovery on OpenEmbedded Layer Index
>
> The OpenEmbedded Layer Index (https://layers.openembedded.org) is an
> excellent resource for discovering layers. However, there is no equivalent
> discovery mechanism for configuration fragments.
>
> Adding a tab or section for fragments would help users discover available
> fragments and understand what problems they solve.
>
Yes, this would be a useful addition.



> ------------------------------
>
> We hope this feedback is helpful. We are happy to discuss any of these
> points further or assist with documentation improvements.
>

Certainly very useful, thanks for writing it up, those are perspectives and
points that I wouldn't be able to come up with.

The only issue I don't quite understand yet is "allow empty variants in
templates".

Alex

--000000000000d7d9e106485c6333
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">On Wed, 14 Jan=
 2026 at 01:03, Otavio Salvador via <a href=3D"http://lists.openembedded.or=
g" target=3D"_blank">lists.openembedded.org</a> &lt;otavio.salvador=3D<a hr=
ef=3D"mailto:ossystems.com.br@lists.openembedded.org" target=3D"_blank">oss=
ystems.com.br@lists.openembedded.org</a>&gt; wrote:</div><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div><h3>1. pip-installed bitbake-setup Cannot Access Default Registries</=
h3>
<p>When installing <code>bitbake-setup</code> via pip and running <code>bit=
bake-setup init</code>, the command fails because it cannot locate the defa=
ult registry files that would normally be at <code>./bitbake/default-regist=
ry/</code>.</p>
<p>This creates a confusing first experience for users who expect a pip-ins=
talled tool to work out of the box. Having to clone the full BitBake reposi=
tory defeats the convenience of pip installation.</p></div></div></blockquo=
te><div>bitbake-setup in pip is known to be broken and not ready. Please do=
 not try to use it until it has an announcement and a place in the official=
 documentation.</div><div><br></div><div>We put it there just to avoid some=
one else squatting on the pypi project name, and that required uploading &#=
39;something&#39;. I worried even then that users will find the package and=
 make assumptions about using it, and now it happened.<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><h3>3. Unclear=
 Error When Using Non-Raw URLs</h3>
<p>When running <code>bitbake-setup init</code> with a URL to a <code>.conf=
.json</code> file hosted on platforms like GitHub or GitLab, users naturall=
y copy the URL from their browser. This URL points to an HTML page rather t=
han the raw JSON content, causing the command to fail.</p>
<p>The error message does not clearly indicate that a raw/plain URL is requ=
ired. A clearer error message or guidance would help users understand the i=
ssue more quickly.</p></div></div></blockquote><div>This shouldn&#39;t be d=
ifficult to fix. Can you propose a patch? <br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr"><div>
<h3>4. Tool to Generate Templates from Existing Environments</h3>
<p>Currently, there is no way to generate a BitBake Setup Template from:</p=
>
<ul>
<li>An existing BitBake Setup Instance</li>
<li>A traditional workspace set up manually with <code>oe-init-build-env</c=
ode></li>
<li>Any working Yocto/OpenEmbedded build environment</li>
</ul>
<p>A tool to export a working environment as a template would:</p>
<ul>
<li>Help users migrate existing projects to the new <code>bitbake-setup</co=
de> workflow</li>
<li>Make it easier to share working configurations with colleagues or the c=
ommunity</li>
<li>Reduce the barrier to adoption for users with established projects</li>=
</ul></div></div></blockquote><div>This might be harder than you think. Mak=
ing a config template from an existing bitbake-setup driven build (with an =
empty local.conf) is not hard, but converting legacy setups requires decomp=
osing local.conf into fragments, giving them correct names and placing them=
 into correct layers, something that only a human can do well.</div><div><b=
r></div><div>Or the tool can try to do it half-way: put local.conf/bblayers=
.conf into a openembedded template into some layer, and then generate a bit=
bake-setup with oe-template entry in it. But that in itself is legacy; frag=
ments and empty local.conf are the future.<br></div><div>=C2=A0<br></div><d=
iv>For converting established projects the best feasible option might be to=
 write migration guidelines.<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><div><ul>
</ul>
<h3>5. Fragment Discovery on OpenEmbedded Layer Index</h3>
<p>The OpenEmbedded Layer Index (<a href=3D"https://layers.openembedded.org=
" target=3D"_blank">https://layers.openembedded.org</a>) is an excellent re=
source for discovering layers. However, there is no equivalent discovery me=
chanism for configuration fragments.</p>
<p>Adding a tab or section for fragments would help users discover availabl=
e fragments and understand what problems they solve.</p></div></div></block=
quote><div>Yes, this would be a useful addition.</div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div>
<hr>
<p>We hope this feedback is helpful. We are happy to discuss any of these p=
oints further or assist with documentation improvements.</p></div></div></b=
lockquote></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_qu=
ote">Certainly very useful, thanks for writing it up, those are perspective=
s and points that I wouldn&#39;t be able to come up with.<br></div><div cla=
ss=3D"gmail_quote"><br></div><div class=3D"gmail_quote">The only issue I do=
n&#39;t quite understand yet is &quot;allow empty variants in templates&quo=
t;.</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Al=
ex<br></div></div>
</div>
</div>
</div>
</div>
</div>
</div>

--000000000000d7d9e106485c6333--

