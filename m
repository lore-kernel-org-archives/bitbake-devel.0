Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by mail.openembedded.org (Postfix) with ESMTP id 4723B60273
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 09:26:40 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id b29so1113008lfq.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=GHu5AscaDrHJZtKvhceVGbWXBF2ojqkcPqSfV31JXsE=;
	b=CcFiyrAlN4PxiEoXfUCkS1J8jwwzxXc/2o+g07sWjVxOY5i+7+1q6fDgV8AIC4Me32
	D5Gav4N2xVazoC/SVX4L/kPOOsyAtEs96PxX4xVp9yomvmC2dEvu7EnCB0ahsW9j8rPz
	q75yJRzER5cBrH4kdscUwobzYpUUHq+i5D5Enx4wPmlgbnSjPwE312TE0Saxy/9j9cBm
	VLIyJiexjGNPOYTMfsQTade2aTZ06enu30fosj3ttZnhhFeWgymi/ZokkBP0stg45tqL
	/CQjxpifD64AG9E3zYBD8gg/xpbwrOoN2KUKDbyh7FkP1MOkeoGudYabYx9Wc7Dmm57U
	tsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=GHu5AscaDrHJZtKvhceVGbWXBF2ojqkcPqSfV31JXsE=;
	b=pSJ2lW0Csbr7CGMskDOCn6ByYafA3GeeRFJ3DXGBMk2wsb6SR8jZakeMC/v1V57cui
	wWo1YByiRqxLveCyN5H6/aHWVtFbaE74ygFtpt6pAUeWh5LP6Yah0ZOaEo96hUM8EYtK
	ETz9IOqJHYWb8EXPwH5aRLcNpXDZdw0QIiPwKRdB7zx8x01u6PSq4Ct7zSsKpqSqF+nI
	fdIkP0ijFwa4KxsCHUKIsbOJptYxex4JyQG/Rly3zDTce2bo3TcO2xuBjdyfCWjVcyog
	RxIjPq+0sCefGTE3HyAB+niU+2qV2v+20YRzCOQnx8tOq+OKvS/f/nqVzSW7sS0npw/N
	i17g==
X-Gm-Message-State: APjAAAUpXQt/J29X0p07Q/hbO4866XCiTu3lxTQ8FLBB/RYf2wKOhFPM
	8LgHg5O3FQ27NM8YFzXp0RxitAh91F6dldVn/Bk=
X-Google-Smtp-Source: APXvYqx0Ac4k7t83MODrjD2wLKZrjx+DjNjnNlhIX+wSkLEIiopocWgpB5Vj7bdSXY6nEh45h2IdsmYKJlR/P8Z59xQ=
X-Received: by 2002:a19:a83:: with SMTP id 125mr14984206lfk.150.1562750800603; 
	Wed, 10 Jul 2019 02:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<c7df70a3-d581-5e21-842b-0e941ec80a05@windriver.com>
	<CADySD0EkWkJ6mbg7jh3hRq3E7bjaqDFa=Aeax7OpertQ0XygSA@mail.gmail.com>
	<d69bc7b9-b946-582d-880c-ef41338affbe@windriver.com>
	<CADySD0HDCdVHnwzXN+POLEoQg73enGZ6XPht5HLZcySGj0XXww@mail.gmail.com>
In-Reply-To: <CADySD0HDCdVHnwzXN+POLEoQg73enGZ6XPht5HLZcySGj0XXww@mail.gmail.com>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Wed, 10 Jul 2019 21:26:31 +1200
Message-ID: <CADySD0G-iSynqSRo9o-y_e0Hvz4L+GzvsBYm=9mHq25yAn0c6Q@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
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
X-List-Received-Date: Wed, 10 Jul 2019 09:26:40 -0000
Content-Type: text/plain; charset="UTF-8"

Hi,

Is there something else that needs to be done in this patch? Or
perhaps there is a better to handle this?
I am willing to learn and try it out if original patch is not good.

Thanks
Ankur

On Tue, Jul 9, 2019 at 11:50 AM Ankur Tyagi <ankur.tyagi85@gmail.com> wrote:
>
> On Tue, Jul 9, 2019 at 11:01 AM Mark Hatle <mark.hatle@windriver.com> wrote:
> >
> > On 7/8/19 4:12 PM, Ankur Tyagi wrote:
> > > We are using TFS in our company and within TFS we have different
> > > project names that can have spaces.
> > > With new version of TFS, git repo can also be created inside it and
> > > the path of those repo also includes the project name that can have
> > > space.
> >
> > Yes, spaces are valid.  I don't dispute that.. but however are you entering them?
>
> I am entering the url in SRC_URI with %20 in place of space
>
> > > Hence the SRC_URI will have a space and that's when I started seeing errors.
> >
> >
> > SRC_URI = "https://foo.com/bar foobar bar"
>
> In my case, it is SRC_URI = "https://foo.com/bar%20foobar%20bar"
>
> > That will result in -three- entries:
> >
> > https://foo.com/bar
> > foobar
> > bar
> >
> > The later two are invalid, because SRC_URI is split on whitespace (spaces and tabs.)
> >
> > So what I don't understand is how are spaces being entered into the SRC_URI
> > (other then with %20) unless they are coming in via gitsm?
>
> Then during the fetch task, git clone command looks like this
> "git clone https://foo.com/bar foobar bar" which results in errors
>
> That's why I am trying to insert "%20" back
>
> Regards
> Ankur
> >
> > --Mark
> >
> > > Hope it answers your question
> > >
> > > regards
> > > Ankur
> > >
> > > On Tue, Jul 9, 2019 at 6:28 AM Mark Hatle <mark.hatle@windriver.com> wrote:
> > >>
> > >> How is a space being added?  I'm a bit confused by this.  Is it due to the gitsm
> > >> fetching?  or has someone figured out a way in SRC_URI to included spaces?
> > >>
> > >> If it's only in the gitsm fetching, then maybe we need to do the conversion
> > >> there instead.
> > >>
> > >> --Mark
> > >>
> > >> On 7/3/19 11:46 PM, Ankur Tyagi wrote:
> > >>> Signed-off-by: Ankur Tyagi <ankur.tyagi85@gmail.com>
> > >>> ---
> > >>>  lib/bb/fetch2/git.py | 3 +++
> > >>>  1 file changed, 3 insertions(+)
> > >>>
> > >>> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > >>> index 59a2ee8f..a8fcc2bf 100644
> > >>> --- a/lib/bb/fetch2/git.py
> > >>> +++ b/lib/bb/fetch2/git.py
> > >>> @@ -156,6 +156,9 @@ class Git(FetchMethod):
> > >>>          if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
> > >>>              raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
> > >>>
> > >>> +        if ud.proto in ('http', 'https'):
> > >>> +            ud.path = ud.path.replace(" ", "%20")
> > >>> +
> > >>>          ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
> > >>>
> > >>>          ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
> > >>>
> > >>
> >

