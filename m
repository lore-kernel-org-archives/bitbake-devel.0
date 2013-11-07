Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
	[209.85.217.179])
	by mail.openembedded.org (Postfix) with ESMTP id 520EB6D2FB
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2013 16:47:10 +0000 (UTC)
Received: by mail-lb0-f179.google.com with SMTP id w6so656366lbh.38
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Nov 2013 08:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=zZX2L9TDPSfKgXcfym74FLXjkRDJXQSyxh/zZQZV0p4=;
	b=pUFQCmHejPhEFBc2MOIL2wJyCEjI4cansVv36x8xAFfDWFQQwVN0DAcHxK9OIU7L+v
	ABjwd6a2y84hZx3jxouRouwy8k1FmiNExe2SHinmapeenFez3I+DdZMSG5MSpfA87rIs
	e1jztEonHy6tW9lCqP+HP/QLHFJz3RJWsMvtELsdBi1oehOtsPgfL77haDaYYEFLbr06
	1ogcWZLqaImfxaIENu5FdETffvGEk7ytY2K6VIoWfV6H7wOsETdszP+w/snKBa8jFpyG
	6W2RoFF/vL4GypWbj9kKM+M9rb2QU5zxyQjZjWdgIGA+mxB5yStoZ3C/N7RjpNOdle8p
	B4Tw==
X-Received: by 10.152.9.198 with SMTP id c6mr2265411lab.36.1383842831233; Thu,
	07 Nov 2013 08:47:11 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.53.197 with HTTP; Thu, 7 Nov 2013 08:46:51 -0800 (PST)
In-Reply-To: <527BC186.5040406@mlbassoc.com>
References: <527BAC0F.3090901@mlbassoc.com> <7286154.LbYKCCWHqH@helios>
	<527BC186.5040406@mlbassoc.com>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 7 Nov 2013 09:46:51 -0700
X-Google-Sender-Auth: CCQ2s4eT20LQR70SEWefiuZJVwM
Message-ID: <CABcZANkDuRL2bMgoy=zNbguwT6xWXw0ktDhy0KPOMZwAiS4kfg@mail.gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Ross Burton <ross.burton@intel.com>
Subject: Re: Some 'depexp' nits
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
X-List-Received-Date: Thu, 07 Nov 2013 16:47:10 -0000
Content-Type: multipart/alternative; boundary=001a1132f83e61782f04ea9904e7

--001a1132f83e61782f04ea9904e7
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 7, 2013 at 9:36 AM, Gary Thomas <gary@mlbassoc.com> wrote:

> On 2013-11-07 09:25, Paul Eggleton wrote:
>
>> Hi Gary,
>>
>> On Thursday 07 November 2013 08:04:47 Gary Thomas wrote:
>>
>>> I hope this is the correct list.
>>>
>>> I was just using '-u depexp' and noticed a few small things.
>>>     $ bitbake my-qt5-image -u depexp
>>>     This UI is only compatible with the -g option
>>>
>>> Perhaps this should be worded more strongly, like this?
>>>     This UI requires the -g option
>>>
>>
>> Sounds like a good idea yes.
>>
>>  Also, after running successfully, I closed the window (using
>>> the close WM button) and got this:
>>>     $ bitbake my-qt5-image -u depexp -g
>>>     Unable to cleanly stop: No such command
>>>
>>> There didn't seem to be any other way to exit the program, so
>>> at least this should be clean.
>>>
>>
>> There is now a bug open for the latter issue:
>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=5445
>>
>>  Are these valid concerns/observations?  Would you entertain patches
>>> for these items?
>>>
>>
>> Yes, that would be great.
>>
>
> Can I send them against the Poky/Yocto tree?  Or should it be the
> separate bitbake tree (which is where?)?


http://git.openembedded.org/, mirrored at https://github.com/openembedded/.
Submit the patches against the separate bitbake repo to the bitbake-devel
list.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1132f83e61782f04ea9904e7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Nov 7, 2013 at 9:36 AM, Gary Thomas <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gary@mlbassoc.com" target=3D"_blank">gary@mlbassoc.com</a>&gt;</=
span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 2013-11-07 09:25, Paul =
Eggleton wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Gary,<br>
<br>
On Thursday 07 November 2013 08:04:47 Gary Thomas wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I hope this is the correct list.<br>
<br>
I was just using &#39;-u depexp&#39; and noticed a few small things.<br>
=C2=A0 =C2=A0 $ bitbake my-qt5-image -u depexp<br>
=C2=A0 =C2=A0 This UI is only compatible with the -g option<br>
<br>
Perhaps this should be worded more strongly, like this?<br>
=C2=A0 =C2=A0 This UI requires the -g option<br>
</blockquote>
<br>
Sounds like a good idea yes.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Also, after running successfully, I closed the window (using<br>
the close WM button) and got this:<br>
=C2=A0 =C2=A0 $ bitbake my-qt5-image -u depexp -g<br>
=C2=A0 =C2=A0 Unable to cleanly stop: No such command<br>
<br>
There didn&#39;t seem to be any other way to exit the program, so<br>
at least this should be clean.<br>
</blockquote>
<br>
There is now a bug open for the latter issue:<br>
<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D5445" target=
=3D"_blank">https://bugzilla.yoctoproject.<u></u>org/show_bug.cgi?id=3D5445=
</a><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Are these valid concerns/observations? =C2=A0Would you entertain patches<br=
>
for these items?<br>
</blockquote>
<br>
Yes, that would be great.<br>
</blockquote>
<br></div>
Can I send them against the Poky/Yocto tree? =C2=A0Or should it be the<br>
separate bitbake tree (which is where?)?</blockquote></div><br><a href=3D"h=
ttp://git.openembedded.org/">http://git.openembedded.org/</a>, mirrored at =
<a href=3D"https://github.com/openembedded/">https://github.com/openembedde=
d/</a>. Submit the patches against the separate bitbake repo to the bitbake=
-devel list.<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--001a1132f83e61782f04ea9904e7--
