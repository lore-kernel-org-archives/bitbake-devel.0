Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f196.google.com (mail-ig0-f196.google.com
	[209.85.213.196])
	by mail.openembedded.org (Postfix) with ESMTP id F382C6FFF7;
	Wed,  4 May 2016 21:19:53 +0000 (UTC)
Received: by mail-ig0-f196.google.com with SMTP id jn6so4492280igb.2;
	Wed, 04 May 2016 14:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=VquWGBUhYbQ3hJs/5XuMXhU8+l2xJBSD/MjR6jLH5/4=;
	b=YFDyOnfr3hMoLQVCke9C387cDweWUu4TrvcV1M0Z7+OEYi+kalzoqDBh9sQB86Yzg1
	aYO8ThPRndcXwYj0SyyLknV3ZroPEroT9Y2WwFKeXig54kWZwnd38MR+QTe+RM0M4jVy
	nWg6R6dCN6KKKcadVtkXVbwmc9h5nUAVqBW5Fxl2BdTboyxdjmSYeNZB04FFKyzI8V10
	cO7MGP1osxX6sUFiVymakD/YZZIRW8nvf9IN7YNwTuCQdDryMTVQeVI9knDfHK3u6Wys
	AWJZ/7YOYkRTRTfiZpeScZnFebrJa655MZl0lVbw/8kw0ZAaeu9EVM9qxXVPbM96n3bI
	x3ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=VquWGBUhYbQ3hJs/5XuMXhU8+l2xJBSD/MjR6jLH5/4=;
	b=xPCN5mqTvZdIObGMduHI/6QYv+HrK/gK+s5D8Ib0WzVFdTCWjbZp3ChJ9YiA0MY7KJ
	Zea+3n3NYsOu88cfhw3wTXg95jBp7LmuZI5OcETWrYZQDZxUY+pDcyG5/JiGWvaA00Tb
	UraSML/hPwaHO1MvgoOHVCBFXQqz5rWLy1MZQNxlXbTYOomfw7LTIhibj//QI7RDB0MC
	tWLELcQ9OUG9tPyz6o0Y/2w1VXCF7wJxEWSaEJQkUTzZ+3sV+wgahAjMeV2QYz4LZ3L5
	E5+ANjlyaQs+pXXGQ/R7QGaWSOagEWqNw4Nw0DUnSOi4nG+n0FGUqB+TyvbwC+COtmpE
	PxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=VquWGBUhYbQ3hJs/5XuMXhU8+l2xJBSD/MjR6jLH5/4=;
	b=nKuzNQ++QGu2H01OPOqOARH958g67P8TVsjlN/gYLhqfsPsdnRqTqBgPx+lQZKteWc
	TNqiq2Q/64evLgHg/euptDG2J5/IV1sqngDloiCoTbblY0IY0wD6GP21aubfqu2dC5yF
	yjBRKvJPcOg+OqkzHAu2YRDmBrg0gqELzLokM+wxjp3oaWDF+uIYPtQ8hitY9m+YOV7c
	iSjuNs2D8bs31Bo3vzKCjkwsVE/9upThZNPVRUB6nyQMAB++J/wCWumCyUJUghTTilbP
	bZBqQykHEkl4mWM7P11yfPaSIS7kfWP3ix5Euy+UmOtozhv/gUyB2PF+/YrHhnQoGZkW
	bO0g==
X-Gm-Message-State: AOPr4FXciGeiId7sHZvM24wqimaQGSZjg9YPXeClYSdUOX4jcVq7Qpis0kcDRVGVUnqV+F00DeJINk8p+skO+w==
X-Received: by 10.50.221.169 with SMTP id qf9mr13694466igc.13.1462396794159;
	Wed, 04 May 2016 14:19:54 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Wed, 4 May 2016 14:19:34 -0700 (PDT)
In-Reply-To: <1462352176.18407.11.camel@linuxfoundation.org>
References: <1462352176.18407.11.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 4 May 2016 21:19:34 +0000
X-Google-Sender-Auth: uwJLm2n233Bo2FwW_LZPsoWjOM4
Message-ID: <CABcZANmKOFJRgq5aS59e=oitQsz7P-1Wq1w6oYmCMfHmkJ0hKA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Python 3 for Bitbake
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
X-List-Received-Date: Wed, 04 May 2016 21:19:54 -0000
Content-Type: multipart/alternative; boundary=f46d042ac0206fce7b05320ac9f1

--f46d042ac0206fce7b05320ac9f1
Content-Type: text/plain; charset=UTF-8

On Wed, May 4, 2016 at 8:56 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> We've come to a cross roads for bitbake and python. Currently we run on
> python 2.7 but python 2.x is getting old and we really need to move to
> 3.X.
>
> Whilst there are a number of tools out there which can translate
> between the two, we have the complexity that we have python both in
> bitbake itself and spread throughout the metadata. We could try and
> migrate, attempting to support both versions but it would require a lot
> of effort and I'm not sure we get much return for it. Its more likely
> we'd end up with a lot of subtle bugs.
>
> An alternative is we just have a flag day and switch, putting in
> patches to bitbake and the metadata to migrate to 3.X in one go. The
> advantage of this is much cleaner code without any workarounds for
> compatibility.
>
> I did some work on this a couple of years ago, I've dusted off those
> patches and improved upon them to get to the ones in:
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=rpurdie/wip
>
> Right now, this is enough to be able to run "bitbake bash", there are a
> ton of things which still need to be done. The patches above are rather
> rough, the aim just being to find out if we can get the basics working
> which it appears we can.
>
> My proposal is we decide to have the flag day, we queue up the patches
> on a python3 branch both in oe-core and bitbake, then we switch when we
> get successful autobuilder builds. I'd ideally like to do this quite
> soon and get one with it (within a few weeks), leaving plenty of time
> to handle issues and the other changes planned for this release cycle
> and give other layers time to adapt.
>
> I will likely push things so the basics in the core work, I'll then
> need help for things like toaster, the QA framework, the supporting
> tools (devtool, recipetool and so on).
>
> Does anyone object to this?


I fully support this effort, and the use of a flag day to switch and not
maintain compatibility. We've wanted to move to 3 for a long time, after
all.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--f46d042ac0206fce7b05320ac9f1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, May 4, 2016 at 8:56 AM, Richard Purdie <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richa=
rd.purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">We&#39;ve come to a cross roads for bitbake and python. Currentl=
y we run on<br>
python 2.7 but python 2.x is getting old and we really need to move to<br>
3.X.<br>
<br>
Whilst there are a number of tools out there which can translate<br>
between the two, we have the complexity that we have python both in<br>
bitbake itself and spread throughout the metadata. We could try and<br>
migrate, attempting to support both versions but it would require a lot<br>
of effort and I&#39;m not sure we get much return for it. Its more likely<b=
r>
we&#39;d end up with a lot of subtle bugs.<br>
<br>
An alternative is we just have a flag day and switch, putting in<br>
patches to bitbake and the metadata to migrate to 3.X in one go. The<br>
advantage of this is much cleaner code without any workarounds for<br>
compatibility.<br>
<br>
I did some work on this a couple of years ago, I&#39;ve dusted off those<br=
>
patches and improved upon them to get to the ones in:<br>
<br>
<a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Drpurd=
ie/wip" rel=3D"noreferrer" target=3D"_blank">http://git.yoctoproject.org/cg=
it.cgi/poky-contrib/log/?h=3Drpurdie/wip</a><br>
<br>
Right now, this is enough to be able to run &quot;bitbake bash&quot;, there=
 are a<br>
ton of things which still need to be done. The patches above are rather<br>
rough, the aim just being to find out if we can get the basics working<br>
which it appears we can.<br>
<br>
My proposal is we decide to have the flag day, we queue up the patches<br>
on a python3 branch both in oe-core and bitbake, then we switch when we<br>
get successful autobuilder builds. I&#39;d ideally like to do this quite<br=
>
soon and get one with it (within a few weeks), leaving plenty of time<br>
to handle issues and the other changes planned for this release cycle<br>
and give other layers time to adapt.<br>
<br>
I will likely push things so the basics in the core work, I&#39;ll then<br>
need help for things like toaster, the QA framework, the supporting<br>
tools (devtool, recipetool and so on).<br>
<br>
Does anyone object to this?</blockquote><div><br></div><div>I fully support=
 this effort, and the use of a flag day to switch and not maintain compatib=
ility. We&#39;ve wanted to move to 3 for a long time, after all.</div></div=
>-- <br><div class=3D"gmail_signature">Christopher Larson<br>clarson at ker=
goth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer -=
 Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--f46d042ac0206fce7b05320ac9f1--
