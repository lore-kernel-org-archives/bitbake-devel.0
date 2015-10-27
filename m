Return-Path: <elliot.smith@intel.com>
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
	[209.85.223.178])
	by mail.openembedded.org (Postfix) with ESMTP id 2F45575D4A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 12:32:57 +0000 (UTC)
Received: by ioll68 with SMTP id l68so220404041iol.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 05:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel_com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=tcy9mnn9hoSQNJwiTnfjHQc8YnP77EEjm3wANChuPWk=;
	b=HTMT+7rR/eaGIIa7EDg9mhxG8qpqxMlBp7O6MgpoThQa0AsrAA15CZCROk4kZ24+ap
	1y4DpuAwGt3+V0z7pHuLS7BS3Opx5PMjncediVQsDNkfAvZfPxlk5TzEfozo9jJjR1J6
	cv9tN6wKH74vq/OhAvva0/YjZWlmGU8RUCYQc0wc9m07tq1geadQCMEG6Ucb6OdDrf5x
	+z8TJvH0HHU1Ris/PSkpqgeQ4471JMNwkkeLMF5g+e6vS1n7taNslCRZisEMLNy2XgqV
	vcZKYazDKsueBHuT2fVdHCnZOAvqha6/jrQOtcu5fFebnG2dDSpnFkd76J2nvBSiPJfF
	pN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=tcy9mnn9hoSQNJwiTnfjHQc8YnP77EEjm3wANChuPWk=;
	b=KOYli+PPMesV1Nrha/v/TQJ3H+Ziy+VetQUrcAT/masau3TMZ7I0lbBJ841cqJQxWx
	6Rwj/PuWNhpZECtYteXyX2w1dksNXIh93Np994AQ/slf2PRkTKSIi9Qsf+hJQ65NDvyw
	8OGxOFtdT2TSTZgXOzwq0EFxGVC6AsW5Fvg/K6dy9ZdFEhEMC2+fCQRg1N3fblA1CL6V
	rVrL0qAhQF8nAbrint/czDt9vt98s3q0WY0HwyBP2v38Nxzv1hUytJ90QZEaffRolwNm
	rErqCVgGHbc8igM3VN85DhodLQWEC/iWwTe/gf6h5R/YDAtmYBq4BQ5UJJDV1M2zWS+W
	vRbw==
X-Gm-Message-State: ALoCoQmjNLiLf1fUjZdLFwK69+l5C8ZlqdYkkBdI4eOBhWfaNX5DeXc6o8XXgVfTaoR+VY7hSo97
MIME-Version: 1.0
X-Received: by 10.107.133.22 with SMTP id h22mr45904596iod.109.1445949177368; 
	Tue, 27 Oct 2015 05:32:57 -0700 (PDT)
Received: by 10.64.7.67 with HTTP; Tue, 27 Oct 2015 05:32:57 -0700 (PDT)
In-Reply-To: <CA+1hgUi-zvaEe+gQd8VaCa=6miMk9-ceSTdMCczwbSSZ5D5ANg@mail.gmail.com>
References: <1444555346.14364.24.camel@linuxfoundation.org>
	<CA+1hgUj5Lty=V_jSWE1YA2CPJuaY5-PAoj+P8gEtzSKDN5gVjA@mail.gmail.com>
	<1445011191.17974.34.camel@linuxfoundation.org>
	<CA+1hgUg7=OhPXV=fHrXzLpSeWKZekx0BkYpu1BC8zaA1H7gG2w@mail.gmail.com>
	<1445685965.21913.58.camel@linuxfoundation.org>
	<CA+1hgUi-zvaEe+gQd8VaCa=6miMk9-ceSTdMCczwbSSZ5D5ANg@mail.gmail.com>
Date: Tue, 27 Oct 2015 12:32:57 +0000
Message-ID: <CA+1hgUhCPXYZLGq0r-HjDhhwpOxvkwvW7XMfnZs=6YEg5_xGng@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Ensure BB_CONSOLE remains correct over server resets
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
X-List-Received-Date: Tue, 27 Oct 2015 12:32:58 -0000
Content-Type: multipart/alternative; boundary=001a113fb1fe14b3c10523154745

--001a113fb1fe14b3c10523154745
Content-Type: text/plain; charset=UTF-8

On 27 October 2015 at 11:21, Smith, Elliot <elliot.smith@intel.com> wrote:

> On 24 October 2015 at 12:26, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> On Mon, 2015-10-19 at 13:27 +0100, Smith, Elliot wrote:
>> Given the other discussion I've seen, I'm assuming it would be ok to
>> merge these now?
>>
>
> Yes, as we're now writing our own logs for Toaster.
>
> Thanks for merging.
>

Richard, apologies, I just realised we have one patch outstanding:
https://lists.yoctoproject.org/pipermail/toaster/2015-October/003196.html

(This is the patch which actually does the work on the Toaster side.)

I thought this had been reviewed and submitted to bitbake-devel, but it
still hasn't. I will try to get this done today.

If we can get this in, as well as your patches to how bitbake sets
BB_CONSOLELOG, we won't lose any functionality in Toaster.

Thanks.
Elliot


> Elliot
>
>
>> Cheers,
>>
>> Richard
>>
>>
>>
>>
>
>
> --
> Elliot Smith
> Software Engineer
> Intel Open Source Technology Centre
>



-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a113fb1fe14b3c10523154745
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 2=
7 October 2015 at 11:21, Smith, Elliot <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:elliot.smith@intel.com" target=3D"_blank">elliot.smith@intel.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border=
-left-style:solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_ex=
tra"><div class=3D"gmail_quote"><span class=3D"">On 24 October 2015 at 12:2=
6, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@li=
nuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><span>On Mon, 2015-10-19 at 13:27 +0=
100, Smith, Elliot wrote:<br></span>Given the other discussion I&#39;ve see=
n, I&#39;m assuming it would be ok to<br>
merge these now?<br></blockquote><div><br></div></span><div>Yes, as we&#39;=
re now writing our own logs for Toaster.</div><div><br></div><div>Thanks fo=
r merging.</div></div></div></div></blockquote><div><br></div><div>Richard,=
 apologies, I just realised we have one patch outstanding:</div><div><a hre=
f=3D"https://lists.yoctoproject.org/pipermail/toaster/2015-October/003196.h=
tml">https://lists.yoctoproject.org/pipermail/toaster/2015-October/003196.h=
tml</a><br></div><div><br></div><div>(This is the patch which actually does=
 the work on the Toaster side.)<br></div><div><br></div><div>I thought this=
 had been reviewed and submitted to bitbake-devel, but it still hasn&#39;t.=
 I will try to get this done today.</div><div><br></div><div>If we can get =
this in, as well as your patches to how bitbake sets BB_CONSOLELOG, we won&=
#39;t lose any functionality in Toaster.</div><div><br></div><div>Thanks.</=
div><div>Elliot</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex"><div dir=3D"ltr"><div =
class=3D"gmail_extra"><div class=3D"gmail_quote"><div><br></div><div>Elliot=
<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);=
border-left-style:solid;padding-left:1ex">
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
</blockquote></div><span class=3D""><br><br clear=3D"all"><div><br></div>--=
 <br><div><div dir=3D"ltr"><div>Elliot Smith<br>Software Engineer<br>Intel =
Open Source Technology Centre</div></div></div>
</span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Elliot Smith<br>Software Enginee=
r<br>Intel Open Source Technology Centre</div></div></div>
</div></div>

--001a113fb1fe14b3c10523154745--
