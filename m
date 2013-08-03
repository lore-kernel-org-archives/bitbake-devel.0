Return-Path: <joe@deserted.net>
Received: from mail-oa0-f46.google.com (mail-oa0-f46.google.com
	[209.85.219.46])
	by mail.openembedded.org (Postfix) with ESMTP id 7B74A6066A
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 Aug 2013 01:07:15 +0000 (UTC)
Received: by mail-oa0-f46.google.com with SMTP id l10so2686358oag.33
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2013 18:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:x-gm-message-state;
	bh=91NOw4MTOEewdJ3XWkFm5OWhBB3U9LvQQWivvrTDA6o=;
	b=X9de5LqLrZenPhHisRr2d1kdeLjSgDiTrbV341DwwLZzikmNa/0af4vJKUfgSq8TD/
	hunrHs2qeXunVYXE57ruaweuVjc3dfvo34K1LxKcBWnCUaoW1aHIHdV0RXwLSZSfAfpt
	2qz0dLhQ3dQh5fle3WuQjAaGBG3nQo1I5vEgGGTZ5m95rq0iVYy28+NBX3P5i5nh7wjE
	M7LBuOY1LfHSNT4SCfEL4CfM0FKwkCryGW3q0GS9F1wdaaC+v/E59olgo1i0VGoiBFrW
	iRyVjQba+Ep02JoQ53GqjMCUUvqv4VG5ZmNrpf7j3zytDywB1wqI8D44fLsmA3GNfVN+
	5LsA==
MIME-Version: 1.0
X-Received: by 10.43.138.66 with SMTP id ir2mr866100icc.40.1375492035467; Fri,
	02 Aug 2013 18:07:15 -0700 (PDT)
Received: by 10.43.17.73 with HTTP; Fri, 2 Aug 2013 18:07:15 -0700 (PDT)
In-Reply-To: <CABcZANmaaKPj5Fno3aBiA0_DZyg6sEH4+QP8J_g=GODfAgwFag@mail.gmail.com>
References: <1375366786-16892-1-git-send-email-joe@deserted.net>
	<CABcZANmaaKPj5Fno3aBiA0_DZyg6sEH4+QP8J_g=GODfAgwFag@mail.gmail.com>
Date: Fri, 2 Aug 2013 21:07:15 -0400
Message-ID: <CANBf+V2Qx4rxbQ2KYL+-t+jA4ds9gMFeKPD1rQBQrqFsfYpj3A@mail.gmail.com>
From: Joe MacDonald <joe@deserted.net>
To: Chris Larson <clarson@kergoth.com>
X-Gm-Message-State: ALoCoQlxdo+3wbd+tcLUAUgpGlGMb1ZmuGDZHmXbSqXnpqqGPz4GR82KXBnPRHXVGE6blcK+SDYx
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: enable pdb tracing
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
X-List-Received-Date: Sat, 03 Aug 2013 01:07:16 -0000
Content-Type: multipart/alternative; boundary=001a11c258382a6cb704e300b2d8

--001a11c258382a6cb704e300b2d8
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Aug 2, 2013 at 5:05 PM, Chris Larson <clarson@kergoth.com> wrote:

> On Thu, Aug 1, 2013 at 7:19 AM, <joe@deserted.net> wrote:
>
>> From: Joe MacDonald <joe@deserted.net>
>>
>> Based on:
>>
>>    http://blog.devork.be/2009/07/how-to-bring-running-python-program.html
>>
>> register a signal handler to dynamically start pdb tracing on receiving
>> SIGUSR1.
>>
>> Signed-off-by: Joe MacDonald <joe@deserted.net>
>>
>
> As long as you keep in mind this will only affect the UI, not the forked
> off server, this could be useful. I'd suggest adding something for the
> server as well, but it'd need to listen to a socket for the input, lacking
> access to the user's tty, or would need to interface with the UI to do it :)
>

That's a really good idea.  It seemed like anything was better than what I
had at the time, but now that you mention it being able to use pdb (or
something like it) to talk to one of the forked processes would be a really
helpful with the current problem I'm looking at.  I'll see what I can do
about extending this (since it doesn't sound like it's a fundamentally bad
idea, just of limited applicability here) to more than just the UI.

Thanks Chris.

-- 
Joe MacDonald
:wq

--001a11c258382a6cb704e300b2d8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Aug 2, 2013 at 5:05 PM, Chris La=
rson <span dir=3D"ltr">&lt;<a href=3D"mailto:clarson@kergoth.com" target=3D=
"_blank">clarson@kergoth.com</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
hu, Aug 1, 2013 at 7:19 AM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:joe@de=
serted.net" target=3D"_blank">joe@deserted.net</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">


<div style=3D"overflow:hidden">From: Joe MacDonald &lt;<a href=3D"mailto:jo=
e@deserted.net" target=3D"_blank">joe@deserted.net</a>&gt;<br>
<br>
Based on:<br>
<br>
=A0 =A0<a href=3D"http://blog.devork.be/2009/07/how-to-bring-running-python=
-program.html" target=3D"_blank">http://blog.devork.be/2009/07/how-to-bring=
-running-python-program.html</a><br>
<br>
register a signal handler to dynamically start pdb tracing on receiving<br>
SIGUSR1.<br>
<br>
Signed-off-by: Joe MacDonald &lt;<a href=3D"mailto:joe@deserted.net" target=
=3D"_blank">joe@deserted.net</a>&gt;</div></blockquote></div><br>As long as=
 you keep in mind this will only affect the UI, not the forked off server, =
this could be useful. I&#39;d suggest adding something for the server as we=
ll, but it&#39;d need to listen to a socket for the input, lacking access t=
o the user&#39;s tty, or would need to interface with the UI to do it :)</d=
iv>
</div></blockquote><div><br></div><div>That&#39;s a really good idea. =A0It=
 seemed like anything was better than what I had at the time, but now that =
you mention it being able to use pdb (or something like it) to talk to one =
of the forked processes would be a really helpful with the current problem =
I&#39;m looking at. =A0I&#39;ll see what I can do about extending this (sin=
ce it doesn&#39;t sound like it&#39;s a fundamentally bad idea, just of lim=
ited applicability here) to more than just the UI.=A0</div>
</div><div><br></div><div>Thanks Chris.</div><div><br></div>-- <br>Joe MacD=
onald<br>:wq

--001a11c258382a6cb704e300b2d8--
