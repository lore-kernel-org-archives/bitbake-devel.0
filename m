Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by mail.openembedded.org (Postfix) with ESMTP id 1DFBB7D71B
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 28 Jul 2019 09:15:25 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id v24so55645992ljg.13
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 28 Jul 2019 02:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=DtThZ6R1fUL6jRidC5716dlWv4tDplzrE+IOKOVVRRQ=;
	b=hnsmh5q+r8vFEuOdUQRRh/EhCYs1MrsE/vsLYiX4k7AMdhq3+wOqAvwevdzlod0Vn0
	/35W61c/HMn819e22WGs4znRol5H1ikTBPA+V6P+ls1wKjnW9X6cZGJv165P/pCTEAo3
	fHTFPYKrzjdKjXDkPVA/Re2+Y5LsUd6bD+ZesC6zeleohNNqAwaN9fZxUt2ylQSNYKPg
	2PdsCsDkNzc5lvf4C4brRPRANUoI07DaK0B7mz50xsYa+gkc1vV3M5SP2eKdE9U57NY+
	hMbkKFSc8cqUOYzuxLtfRF4oKMSlh7TVnRQfo3KwVozNb+V9sB+5SHJ0tZH+V0ny5amc
	u4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=DtThZ6R1fUL6jRidC5716dlWv4tDplzrE+IOKOVVRRQ=;
	b=Jj3kUaU2RU++fhRhsw3DNbZ7P6Pw4KEuNVflByH+tXftj/yH/jjHm5CHi1d3lup1Hk
	Fhgtm4Aq7g2MssRWdlPoPoxxKR4kwYG4AGDvZVzvaNwOlvNYOSucnH5Cp8SZV53nXF4x
	hrBb4USqGZVqsZMWW8RSq66wSznmIKB0CIk3EcxjxLMEBx0/9GUGFvs9HZxHIdrXAjy/
	lYnl1eS+SZ+MrKmp7h7iM4Fve39EJPod+QH7uXXeFyxlPKRiI8iIWKFuTFX5X0RFgDWB
	q7rUNaAMTMURK2zmKu+r6Eo7dbQwmTAZBLqMG0UuyH+MPB3GeAdSVsBBZPO2BsI/HMAC
	Hugg==
X-Gm-Message-State: APjAAAVw49Emdqc0gBClYIjPkuoLEkBmBAM4Sudsh0J8DQOrfbgqHYHP
	U/Pg6QJnmcUYf9YqIV0DZj/CraH6/OAuqJyTV2M=
X-Google-Smtp-Source: APXvYqxmy94ZM67/7aVKqcC9EC5b8m1aOvvmJyX1lmcnHkAMxBx33bZhNMnnKBZ2K8JSPXpzpL8wrk/6Tv9+Fxwww3c=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr11422286ljj.68.1564305326347; 
	Sun, 28 Jul 2019 02:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<c7df70a3-d581-5e21-842b-0e941ec80a05@windriver.com>
	<CADySD0EkWkJ6mbg7jh3hRq3E7bjaqDFa=Aeax7OpertQ0XygSA@mail.gmail.com>
	<d69bc7b9-b946-582d-880c-ef41338affbe@windriver.com>
	<CADySD0HDCdVHnwzXN+POLEoQg73enGZ6XPht5HLZcySGj0XXww@mail.gmail.com>
	<CADySD0G-iSynqSRo9o-y_e0Hvz4L+GzvsBYm=9mHq25yAn0c6Q@mail.gmail.com>
	<9758178e3d22e58c18d4de719933d5957ea23ec2.camel@linuxfoundation.org>
	<CADySD0E7eWVYfEtMk-6+KMnb+WKAMyTEuHLotGQBf8sefFysgg@mail.gmail.com>
	<CADySD0HXOc7RWpVs+nhD3810D3mQc62KiKdsZo0Q5FnEar27GQ@mail.gmail.com>
In-Reply-To: <CADySD0HXOc7RWpVs+nhD3810D3mQc62KiKdsZo0Q5FnEar27GQ@mail.gmail.com>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Sun, 28 Jul 2019 21:15:23 +1200
Message-ID: <CADySD0EhCzQFTXb40wknh=Fr6VSBVocppVOe_ssuxS5U0vL3vQ@mail.gmail.com>
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
X-List-Received-Date: Sun, 28 Jul 2019 09:15:26 -0000
Content-Type: text/plain; charset="UTF-8"

How about something like this:

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f6b5529b..fa1f9e27 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -380,6 +380,9 @@ def decodeurl(url):
         user = ''
         pswd = ''

+    if type not in ['git']:
+        path = urllib.parse.unquote(path)
+
     p = collections.OrderedDict()
     if parm:
         for s in parm.split(';'):
@@ -389,7 +392,7 @@ def decodeurl(url):
                 s1, s2 = s.split('=')
                 p[s1] = s2

-    return type, host, urllib.parse.unquote(path), user, pswd, p
+    return type, host, path, user, pswd, p

 def encodeurl(decoded):
     """Encodes a URL from tokens (scheme, network location, path,

regards
Ankur

On Fri, Jul 26, 2019 at 3:13 PM Ankur Tyagi <ankur.tyagi85@gmail.com> wrote:
>
> Hi,
>
> Previous idea is stupid, please discard that.
> Just checked quote/unquote were added as part of commit
> b1dbc24ebcc4e5100c32568c2c41fd982fb4bcce
>
> So explaining the situation again --> when fecthing from repo url
> https://tfs.local/repos/foo%bar
>
> During FetchData initialization, decodeurl(d.expand(url)) returns path
> with %20 stripped
>
> [log][__init__][decodeurl] Path returned /repos/foo bar
>
> And when git method urldata_init() is called, it sets gitsrcname with
> space instead of %20
>
> [log][git][urldata_init] gitsrcname is tfs.local.repos.foo bar
>
> And when git method _get_repo_url is called, it always returns Path
> with space instead of %20
>
> [log][git][_get_repo_url] Path returned /repos/foo bar
>
> So I am bit confused now on how to handle it properly as unquote is
> removing %20 and it cannot be added back in later stage.
>
> Regards
> Ankur
>
>
> On Thu, Jul 25, 2019 at 7:23 PM Ankur Tyagi <ankur.tyagi85@gmail.com> wrote:
> >
> > Hi,
> >
> > Sorry for the late reply but I have figured out where %20 is being stripped out.
> >
> > File lib/bb/fetch2/__init__.py, method decodeurl(url) is returning
> > path as urllib.parse.unquote(path) which strips out %20
> > So if I return path as it is, then %20 is preserved and works as expected.
> >
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index f6b5529b..97fd59e1 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -389,7 +389,7 @@ def decodeurl(url):
> >                  s1, s2 = s.split('=')
> >                  p[s1] = s2
> >
> > -    return type, host, urllib.parse.unquote(path), user, pswd, p
> > +    return type, host, path, user, pswd, p
> >
> >
> > Is above change acceptable?
> >
> > Regards
> > Ankur
> >
> > On Wed, Jul 10, 2019 at 4:33 AM Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > >
> > > On Wed, 2019-07-10 at 21:26 +1200, Ankur Tyagi wrote:
> > > > Hi,
> > > >
> > > > Is there something else that needs to be done in this patch? Or
> > > > perhaps there is a better to handle this?
> > > > I am willing to learn and try it out if original patch is not good.
> > >
> > > I think Mark is right, we need to figure out where the %20 characters
> > > are being stripped out and preserve them rather than injecting them
> > > back in again.
> > >
> > > The question is therefore where they're being stripped out in the code?
> > >
> > > Cheers,
> > >
> > > Richard
> > >

