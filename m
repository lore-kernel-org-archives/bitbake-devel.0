Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
	[209.85.208.195])
	by mail.openembedded.org (Postfix) with ESMTP id F2F9E7EFB8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2019 03:13:25 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id p17so50013097ljg.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jul 2019 20:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=vT7g+gh2wzr++dhYGAkiYNZk5IF99LRk1AKVnQH2JGk=;
	b=b9BpOz5ej+FuIhH3GDmumHe24zeq8Rc4bSVfS0Gbbe9NDGV78A6r0g6lgT9SW+IFek
	BokxEY/RyeV88vOizI+fB6HRieTndKeAjZ8L8+loj0EPqKXEmEsEXdiCIEkmQUEvHoWr
	LCCW1nL38othd7FeNn5qBfp0+roDSmuPx2MnJIHWzzFR2fYZQ2tVppGYsvfpUgbwFljH
	jzfKI0L2minYf/loXot1Cwcstko61ov4GhAmLsTxezUFZ6IO/7XlRM+uNLDFLEUQEpTJ
	YPdOSyrHnIxxfXUfeFF26TKSV4736akEAnba6Q0uG4FUsIoVrh0bZPKHAleKcpzC8K4n
	2JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=vT7g+gh2wzr++dhYGAkiYNZk5IF99LRk1AKVnQH2JGk=;
	b=TNA6GmE6LvCtetzRFkZT7NYL4e0PKQ6RQHUIaCiK63yLQfRi9k7kbiUs0H3EQDlY6q
	tozHGou6RNnWhvL3zLzJg09/J84A1M0Tj4lqi0ZBwZRlB0LM8BaVyIsxOhr8U4x04kAe
	e733kQUIHHsl6v/5EpvudOKsB89SzIVzCPpWLS8I7b8J4RQUzYu1Tl6I9VYOhuH4afYF
	fCbsTgxSuHgYz8Le5CZEcZe0SubAI3L64wmjl8ayd9IrvUB5A6w17WEVGH5Tr9VPfjt9
	uhKwk3wBn50QuuAVoRgSWh8r04naNTWz5bPF5AZkbFhoIFVhsqVeMef+wK8nVlLUnv8k
	Vj+g==
X-Gm-Message-State: APjAAAX9XGg5AE06knju1VAgkK47FnmlTVy5syCzQbNSbdbqQqtqZZOh
	KP13Hzs+4nfHc6n6nxE6tvxcqFuyiFONZs/nFfg=
X-Google-Smtp-Source: APXvYqy7FRk76N0Ixj3+Azlcxp9IJ+NQQF/auIvk3E5BkRz5O3hr/NKpZbkNWKpkeO34uL2UInGG4wD/r97CQuCn5Sc=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr5021072ljj.68.1564110806198;
	Thu, 25 Jul 2019 20:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<c7df70a3-d581-5e21-842b-0e941ec80a05@windriver.com>
	<CADySD0EkWkJ6mbg7jh3hRq3E7bjaqDFa=Aeax7OpertQ0XygSA@mail.gmail.com>
	<d69bc7b9-b946-582d-880c-ef41338affbe@windriver.com>
	<CADySD0HDCdVHnwzXN+POLEoQg73enGZ6XPht5HLZcySGj0XXww@mail.gmail.com>
	<CADySD0G-iSynqSRo9o-y_e0Hvz4L+GzvsBYm=9mHq25yAn0c6Q@mail.gmail.com>
	<9758178e3d22e58c18d4de719933d5957ea23ec2.camel@linuxfoundation.org>
	<CADySD0E7eWVYfEtMk-6+KMnb+WKAMyTEuHLotGQBf8sefFysgg@mail.gmail.com>
In-Reply-To: <CADySD0E7eWVYfEtMk-6+KMnb+WKAMyTEuHLotGQBf8sefFysgg@mail.gmail.com>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Thu, 25 Jul 2019 20:13:14 -0700
Message-ID: <CADySD0HXOc7RWpVs+nhD3810D3mQc62KiKdsZo0Q5FnEar27GQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel, 1.42, 1.40, v2] git.py: Handle space in git repo name for http/https protocol
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
X-List-Received-Date: Fri, 26 Jul 2019 03:13:26 -0000
Content-Type: text/plain; charset="UTF-8"

Hi,

Previous idea is stupid, please discard that.
Just checked quote/unquote were added as part of commit
b1dbc24ebcc4e5100c32568c2c41fd982fb4bcce

So explaining the situation again --> when fecthing from repo url
https://tfs.local/repos/foo%bar

During FetchData initialization, decodeurl(d.expand(url)) returns path
with %20 stripped

[log][__init__][decodeurl] Path returned /repos/foo bar

And when git method urldata_init() is called, it sets gitsrcname with
space instead of %20

[log][git][urldata_init] gitsrcname is tfs.local.repos.foo bar

And when git method _get_repo_url is called, it always returns Path
with space instead of %20

[log][git][_get_repo_url] Path returned /repos/foo bar

So I am bit confused now on how to handle it properly as unquote is
removing %20 and it cannot be added back in later stage.

Regards
Ankur


On Thu, Jul 25, 2019 at 7:23 PM Ankur Tyagi <ankur.tyagi85@gmail.com> wrote:
>
> Hi,
>
> Sorry for the late reply but I have figured out where %20 is being stripped out.
>
> File lib/bb/fetch2/__init__.py, method decodeurl(url) is returning
> path as urllib.parse.unquote(path) which strips out %20
> So if I return path as it is, then %20 is preserved and works as expected.
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index f6b5529b..97fd59e1 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -389,7 +389,7 @@ def decodeurl(url):
>                  s1, s2 = s.split('=')
>                  p[s1] = s2
>
> -    return type, host, urllib.parse.unquote(path), user, pswd, p
> +    return type, host, path, user, pswd, p
>
>
> Is above change acceptable?
>
> Regards
> Ankur
>
> On Wed, Jul 10, 2019 at 4:33 AM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >
> > On Wed, 2019-07-10 at 21:26 +1200, Ankur Tyagi wrote:
> > > Hi,
> > >
> > > Is there something else that needs to be done in this patch? Or
> > > perhaps there is a better to handle this?
> > > I am willing to learn and try it out if original patch is not good.
> >
> > I think Mark is right, we need to figure out where the %20 characters
> > are being stripped out and preserve them rather than injecting them
> > back in again.
> >
> > The question is therefore where they're being stripped out in the code?
> >
> > Cheers,
> >
> > Richard
> >

