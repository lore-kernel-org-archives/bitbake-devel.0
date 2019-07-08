Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by mail.openembedded.org (Postfix) with ESMTP id 567C17DE87
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Jul 2019 23:50:31 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id m23so17664028lje.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Jul 2019 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=VEyYp8uCK2VS42ogVN6LpF8t1e9DyXY6FX4nbe/Wkv4=;
	b=tG9qLNEkl0I6o+VK6TsvvTbppvi4s5nLDLHYMO1PdWfhI5Jv0EihI2NmcP/GjvZrup
	+NvnzQYvaxXvh9KeKEfN2QHztb5ytswL3rRke5JtlDjkhJ7sQ/F624K2tQ7btyI3UCRz
	fam873r+5Pn15awMbwH60+75od49Mdpv4gKxAiV9jTcn193dxEnrI8svMkSJvpkYXHGL
	ZGODcFhhmBPoAitrQa4vDpBSJUy8VzO6uHtNzBbglQfJGJiGa5N+OoRCBMbISyZtmjGt
	cTDxmBV1fyD0om9NxvkJt3OcHQq45YlkRyfRUlFjwovISlXwPJXwdGmzmyU1ATSFix3U
	Ep+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=VEyYp8uCK2VS42ogVN6LpF8t1e9DyXY6FX4nbe/Wkv4=;
	b=XoWgvPYZtRMsg8xe4aDWk/yG1ujoCgJ4wOf+vhDpuAsu2Oz99wtwOA6DZvquxyoDQR
	kfbRta6UBXhMTdHwM3tea2gh1wapMhngaK/Xq5tLjtywipP393koAp1/GaYLMbIvR33K
	xpvRyECT+EM3VpC+4oct4971W/umj6LtHaHmtdocmPtxA1xXC2TWoYONZttkI7gfHxla
	IeQSvLnPbtSHwTNq/xCdSBAj6eHwo7x1Zz+NtbyZKbiTc+zkU7b8FD0uT49lULbie0f9
	sC47crnWDTxP8bgawxWD2Ys43K1/SU2iPgD8Tp52DQBRZoQGcGVzC/KzH5hg6XbRPvJv
	e1Kw==
X-Gm-Message-State: APjAAAXYcjpA8v2cUCou0qgYgXTrQmc9QnOHs8IONGRt/Gs6zuMAxrvo
	t65F+dyRh4mPSNPo0Yxvqq5+1x7yZQVLpmuIStNn3G8y
X-Google-Smtp-Source: APXvYqyH2ZMQdP+t/UcgZbVsUxXHuS3Wr23v7ENtdxyawlIlSoC4mWS2uDiyAyLF0tp+uN0TPzbW7xWn052FuHPT20M=
X-Received: by 2002:a2e:8155:: with SMTP id t21mr11709684ljg.80.1562629831683; 
	Mon, 08 Jul 2019 16:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<c7df70a3-d581-5e21-842b-0e941ec80a05@windriver.com>
	<CADySD0EkWkJ6mbg7jh3hRq3E7bjaqDFa=Aeax7OpertQ0XygSA@mail.gmail.com>
	<d69bc7b9-b946-582d-880c-ef41338affbe@windriver.com>
In-Reply-To: <d69bc7b9-b946-582d-880c-ef41338affbe@windriver.com>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Tue, 9 Jul 2019 11:50:44 +1200
Message-ID: <CADySD0HDCdVHnwzXN+POLEoQg73enGZ6XPht5HLZcySGj0XXww@mail.gmail.com>
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
X-List-Received-Date: Mon, 08 Jul 2019 23:50:31 -0000
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 9, 2019 at 11:01 AM Mark Hatle <mark.hatle@windriver.com> wrote:
>
> On 7/8/19 4:12 PM, Ankur Tyagi wrote:
> > We are using TFS in our company and within TFS we have different
> > project names that can have spaces.
> > With new version of TFS, git repo can also be created inside it and
> > the path of those repo also includes the project name that can have
> > space.
>
> Yes, spaces are valid.  I don't dispute that.. but however are you entering them?

I am entering the url in SRC_URI with %20 in place of space

> > Hence the SRC_URI will have a space and that's when I started seeing errors.
>
>
> SRC_URI = "https://foo.com/bar foobar bar"

In my case, it is SRC_URI = "https://foo.com/bar%20foobar%20bar"

> That will result in -three- entries:
>
> https://foo.com/bar
> foobar
> bar
>
> The later two are invalid, because SRC_URI is split on whitespace (spaces and tabs.)
>
> So what I don't understand is how are spaces being entered into the SRC_URI
> (other then with %20) unless they are coming in via gitsm?

Then during the fetch task, git clone command looks like this
"git clone https://foo.com/bar foobar bar" which results in errors

That's why I am trying to insert "%20" back

Regards
Ankur
>
> --Mark
>
> > Hope it answers your question
> >
> > regards
> > Ankur
> >
> > On Tue, Jul 9, 2019 at 6:28 AM Mark Hatle <mark.hatle@windriver.com> wrote:
> >>
> >> How is a space being added?  I'm a bit confused by this.  Is it due to the gitsm
> >> fetching?  or has someone figured out a way in SRC_URI to included spaces?
> >>
> >> If it's only in the gitsm fetching, then maybe we need to do the conversion
> >> there instead.
> >>
> >> --Mark
> >>
> >> On 7/3/19 11:46 PM, Ankur Tyagi wrote:
> >>> Signed-off-by: Ankur Tyagi <ankur.tyagi85@gmail.com>
> >>> ---
> >>>  lib/bb/fetch2/git.py | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> >>> index 59a2ee8f..a8fcc2bf 100644
> >>> --- a/lib/bb/fetch2/git.py
> >>> +++ b/lib/bb/fetch2/git.py
> >>> @@ -156,6 +156,9 @@ class Git(FetchMethod):
> >>>          if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
> >>>              raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
> >>>
> >>> +        if ud.proto in ('http', 'https'):
> >>> +            ud.path = ud.path.replace(" ", "%20")
> >>> +
> >>>          ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
> >>>
> >>>          ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
> >>>
> >>
>

