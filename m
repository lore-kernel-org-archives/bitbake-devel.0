Return-Path: <mhalstead@linuxfoundation.org>
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
	[209.85.210.49])
	by mail.openembedded.org (Postfix) with ESMTP id C87E4606B3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2020 18:59:53 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id f66so1570212otf.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2020 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=ATLBVZjQ0GKcSc9fHlTjYbhawWCKHgXS0NTjtCYAILg=;
	b=J1ESmFqfu1rB/vM9KNJlgM0kyoBO5xymEsuODXg2rBiOVRWXfwjssl9vu8qypzi5+4
	wNpgdLRDdqwiEfWzsUfuYjPLBw0VEillDq8mspDHz5FM236I6BGaj+tLY855c8LWGjlP
	ak4OZUtV7btofUgLZOzOVTt2zREkLJJU6c3Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=ATLBVZjQ0GKcSc9fHlTjYbhawWCKHgXS0NTjtCYAILg=;
	b=aJuqYIQtCKWVVIW13qkQ/sE8Q2cHAIrDH7MWwG+wMg1h4lskx+GZSrEeCxzWCPgqla
	i60JC3KmMVRl+UiM0GGn6UvPy/2IIkSWAZDyl/GKuMmU0Dl9QZPGdpo2u4Z+vHsQNaon
	FpDGlEI6Symeh6Lwf/1J9N/l6bb6GOKZJ9aBqTTcyJKc8ZLbtD8fFAUg3Rovnq4EAI4G
	6vGTwS3Fgs2chvR7B6esrcq7nHZ6KyD9WCCjcLxIaFXGUBys5TK7GHjJA3Bt+BoUBvMW
	qizXr+TSiq432HK97HPn/mHvaQUFXf2E4o6OdCWcrwyQT6yCrbRCVnV8bH6hy4zctjEu
	BuWQ==
X-Gm-Message-State: ANhLgQ1i4IVsl0/qwBtusRY6d8F4PXr6rQEimi8rTulqyGsz8E9pIUgn
	LZXRsSFU11BWl7gIAOS0c6WLx5CWVNEi3xfXkP/Vi7hbIdWuQA==
X-Google-Smtp-Source: ADFU+vtEd5Rz+zKdA1a1ya+Px26LKMKdyZTjjUAxkTSWBoE2ktGHiEcqndGXTvp66Hc8Q/1t9GBWddpN5NXEKjqfShU=
X-Received: by 2002:a9d:12b4:: with SMTP id g49mr8453384otg.50.1584730793953; 
	Fri, 20 Mar 2020 11:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <CADfgfobNNXr9HSOiwyamzbZ4q1uc8wgD5PzobDF56cDyYui-HQ@mail.gmail.com>
	<CADfgfoYCjVip=oc_U0TdFzOVst5U-KU+R31JhdckRv77APzQ-g@mail.gmail.com>
In-Reply-To: <CADfgfoYCjVip=oc_U0TdFzOVst5U-KU+R31JhdckRv77APzQ-g@mail.gmail.com>
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Fri, 20 Mar 2020 11:59:42 -0700
Message-ID: <CADfgfob4=Zeh=jn9b9uMqq6Wnt83oGmJ-8yf1wSXYEFTppv2Bg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org, 
	openembedded-core <openembedded-core@lists.openembedded.org>, 
	openembedded-architecture@lists.openembedded.org, 
	openembeded-devel <Openembedded-devel@lists.openembedded.org>
Subject: Re: Mailing list platform change March 20th
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
X-List-Received-Date: Fri, 20 Mar 2020 18:59:53 -0000
Content-Type: multipart/alternative; boundary="00000000000009e18a05a14de442"

--00000000000009e18a05a14de442
Content-Type: text/plain; charset="UTF-8"

The migration will begin shortly. List mail will be delayed until the
process is complete. E-mail sent during downtime should eventually be
delivered. However waiting to send until after the switch is recommended.

Thank you,
--
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer

On Thu, Mar 19, 2020 at 9:44 AM Michael Halstead <
mhalstead@linuxfoundation.org> wrote:

> Everything is proceeding smoothly and this work will continue as planned.
> The migration starts at noon PDT tomorrow.
>
> List owners please take care of all outstanding moderation in the next 24
> hours to ensure a smooth transition.
>
> Thank you,
> --
> Michael Halstead
> Linux Foundation / Yocto Project
> Systems Operations Engineer
>
> On Fri, Mar 13, 2020 at 4:58 PM Michael Halstead <
> mhalstead@linuxfoundation.org> wrote:
>
>> We are moving our lists from Mailman to Groups.io. E-mail to lists will
>> be delayed during the move window. We are aiming to complete the migration
>> during business hours in the Pacific time zone.
>>
>> A new account will be created for you on the Groups.io platform if you
>> don't already have one.
>>
>> You can read more about the change on the wiki:
>> https://www.openembedded.org/wiki/GroupsMigration
>>
>> If there are serious issues we will rollback the changes. We will e-mail
>> all lists when work is complete.
>>
>> --
>> Michael Halstead
>> Linux Foundation / Yocto Project
>> Systems Operations Engineer
>>
>>

--00000000000009e18a05a14de442
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The migration will begin shortly. List mail will be delaye=
d until the process is complete. E-mail sent during downtime should eventua=
lly be delivered. However waiting to send until after the switch is recomme=
nded.<div><br></div><div>Thank you,<br>--<br>Michael Halstead<br>Linux Foun=
dation / Yocto Project<br>Systems Operations Engineer<br></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar =
19, 2020 at 9:44 AM Michael Halstead &lt;<a href=3D"mailto:mhalstead@linuxf=
oundation.org">mhalstead@linuxfoundation.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Everything is =
proceeding smoothly and this work will continue as planned. The migration s=
tarts at noon PDT tomorrow.<div><br></div><div>List owners please take care=
 of all outstanding moderation in the next 24 hours to ensure a smooth tran=
sition.</div><div><br></div><div>Thank you,</div><div>--<br>Michael Halstea=
d<br>Linux Foundation / Yocto Project<br>Systems Operations Engineer<br></d=
iv></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Fri, Mar 13, 2020 at 4:58 PM Michael Halstead &lt;<a href=3D"mailto:m=
halstead@linuxfoundation.org" target=3D"_blank">mhalstead@linuxfoundation.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div>We are moving our lists from Mailman to=C2=A0<span>=
Groups</span>.<span>io</span>. E-mail to lists will be delayed during the m=
ove window. We are aiming to complete the migration during business hours i=
n the Pacific time zone.<br></div><div><br></div><div>A new account will be=
 created for you on the=C2=A0<span>Groups</span>.<span>io</span>=C2=A0platf=
orm if you don&#39;t already have one.<br></div><div><br></div><div>You can=
 read more about the change on the wiki:<br></div><a href=3D"https://www.op=
enembedded.org/wiki/GroupsMigration" target=3D"_blank">https://www.openembe=
dded.org/wiki/GroupsMigration</a><br><div><br></div><div>If there are serio=
us issues we will rollback the changes. We will e-mail<br>all lists when wo=
rk is complete.<br></div><div><br></div><div><span style=3D"color:rgb(136,1=
36,136)">--</span><br style=3D"color:rgb(136,136,136)"><span style=3D"color=
:rgb(136,136,136)">Michael Halstead</span><br style=3D"color:rgb(136,136,13=
6)"><span style=3D"color:rgb(136,136,136)">Linux Foundation / Yocto Project=
</span><br style=3D"color:rgb(136,136,136)"><span style=3D"color:rgb(136,13=
6,136)">Systems Operations Engineer</span><br></div><div><br></div></div>
</blockquote></div>
</blockquote></div>

--00000000000009e18a05a14de442--
