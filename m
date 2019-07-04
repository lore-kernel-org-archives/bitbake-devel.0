Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
	[209.85.208.180])
	by mail.openembedded.org (Postfix) with ESMTP id 7F4987C5F0
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jul 2019 00:57:46 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id t28so4349742lje.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jul 2019 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=VaDwrL0Zl3KiBEhNCQgO2ZUh8RnhGn8iN31IFBdD7Qk=;
	b=JsG6O257T7mgfteNmhmo62BeuJ3ha4pzB1Th0RzaZLqvSoLekowoCm+cnVqnvG7BW0
	cVtZXoW8JxAWSeU6zKOFES2DzmFOzESKtD44wTA5l6dw3ge1dyiY70gxoXHi9KpgPSmm
	pv7OZkdX5AmcTy7ycN/sl/XZnPdJfQpGVZ/d4s30z9xjFBlWNN5/tMml23Wpuj9/bcJA
	y1I8ppoKcOH8Bx2M3a7nuVEqbaHvd8aiL8yEWMQYQ3Y8S6JowyyeOKoTmJs8Yal9fG+/
	bfFIRWQc9VZ5LwmtfpdY/NxAw6CIlIKMtegAnpP5T92febvrk3cJPWY/RWZmn9bBYM4y
	1+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=VaDwrL0Zl3KiBEhNCQgO2ZUh8RnhGn8iN31IFBdD7Qk=;
	b=bleWWXLygAVGfYZGUkxVX82lsRiIWb5akcKIxNmN94eNBi90zp5zovS5my7vz/qygO
	2aJidtzsovmKznhOEubYUuOhD+4onWGTIyV9lkXKbzGJpHhddA4LesXhZLlYSwDEn0nJ
	aNHurnoDaqr3cvCokwol2YTyaaU5GZtwZq5I4QtxvsSXTDbyF36QNXFiRSxsGfFTe03u
	Jt9/u+eOd5Jez7cWFhruvoEXWBUd2Bux4b6pKXZqG5/DWtNnnZ0O5TIs3nH0Y9EorJea
	WWKs8oN+H/J2DFpNybztymLiLnbVEwfwciBmgnTbKig05ikiRcZS98cVtcMq4kP7MpwJ
	1UxQ==
X-Gm-Message-State: APjAAAXTSmKQ5DgAl55ZS+LfsTzj+n9MEQlvCpYDrwh6hd4E0FdXrJMl
	XTE6RVMM/+19bgpCpmZ3VjVOXdojupvpUfCb1m1tNQ==
X-Google-Smtp-Source: APXvYqx14wBV6+S2QMdOjwvtp/ZzypRFP9je8HLBlGAb97yrqtM7ObF0KIZQFcT5FbUngab5Nofu4tMJfccKShCDEeU=
X-Received: by 2002:a2e:a171:: with SMTP id u17mr16111421ljl.209.1562201866618;
	Wed, 03 Jul 2019 17:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.1.1562155201.10255.bitbake-devel@lists.openembedded.org>
In-Reply-To: <mailman.1.1562155201.10255.bitbake-devel@lists.openembedded.org>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Thu, 4 Jul 2019 12:57:56 +1200
Message-ID: <CADySD0Ed3fhSK2dTZ-DCJCSEF3DtONNTXgm0g46stwj3nMTzng@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake-devel Digest, Vol 99, Issue 4
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
X-List-Received-Date: Thu, 04 Jul 2019 00:57:46 -0000
Content-Type: text/plain; charset="UTF-8"

Hi,

So should I only fix the path if protocol is http/https and send v2 of patch?

Thanks
Ankur

> Message: 1
> Date: Tue, 2 Jul 2019 10:19:46 +0000
> From: Ernst Sj?strand <ernst.sjostrand@verisure.com>
> To: "bitbake-devel@lists.openembedded.org"
>         <bitbake-devel@lists.openembedded.org>
> Subject: Re: [bitbake-devel] [bitbake-devel, 1.42, 1.40] git.py:
>         Handle space in git repo name
> Message-ID:
>         <d86c3787f5e287b397f96be56c8f680c5c16f564.camel@verisure.com>
> Content-Type: text/plain; charset="utf-8"
>
> Hi,
>
> wouldn't this break the non-http protocols?
>
> Regards
> //Ernst
>
> tis 2019-07-02 klockan 21:07 +1200 skrev Ankur Tyagi:
> > Signed-off-by: Ankur Tyagi <
> > ankur.tyagi85@gmail.com
> > >
> > ---
> >  lib/bb/fetch2/git.py | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index e171aa7e..5300fa8f 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -236,7 +236,7 @@ class Git(FetchMethod):
> >                      ud.unresolvedrev[name] = ud.revisions[name]
> >                  ud.revisions[name] = self.latest_revision(ud, d,
> > name)
> >
> > -        gitsrcname = '%s%s' % (ud.host.replace(':', '.'),
> > ud.path.replace('/', '.').replace('*', '.'))
> > +        gitsrcname = '%s%s' % (ud.host.replace(':', '.'),
> > ud.path.replace('/', '.').replace('*', '.').replace(" ", "%20"))
> >          if gitsrcname.startswith('.'):
> >              gitsrcname = gitsrcname[1:]
> >
> > @@ -459,7 +459,7 @@ class Git(FetchMethod):
> >              readpathspec = ""
> >              def_destsuffix = "git/"
> >
> > -        destsuffix = ud.parm.get("destsuffix", def_destsuffix)
> > +        destsuffix = ud.parm.get("destsuffix",
> > def_destsuffix).replace(" ", "%20")
> >          destdir = ud.destdir = os.path.join(destdir, destsuffix)
> >          if os.path.exists(destdir):
> >              bb.utils.prunedir(destdir)
> > @@ -574,7 +574,7 @@ class Git(FetchMethod):
> >              username = ud.user + '@'
> >          else:
> >              username = ""
> > -        return "%s://%s%s%s" % (ud.proto, username, ud.host,
> > ud.path)
> > +        return "%s://%s%s%s" % (ud.proto, username, ud.host,
> > ud.path.replace(" ", "%20"))
> >
> >      def _revision_key(self, ud, d, name):
> >          """
> > --
> > 2.22.0.windows.1
> >
>
> ------------------------------
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>
> End of bitbake-devel Digest, Vol 99, Issue 4
> ********************************************

