Return-Path: <elliot.smith@intel.com>
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com
	[209.85.223.180])
	by mail.openembedded.org (Postfix) with ESMTP id 9BA9E755F4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 11:21:09 +0000 (UTC)
Received: by iofz202 with SMTP id z202so216613178iof.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel_com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=g094LoCkdXWUCN61uTJrxTlLQMWseBk04sIwI3xmN/g=;
	b=dkPME5IQQSm2lzhJuUv901o5GOXHY5QKroiixC8CqNQmzY7bcd/0apPe1Fw2W9J8HS
	xXo30yusr9G1hNwTzjKtKFdUgXNPL7PAB8wVlSHLkWR89X4L4JgyiksqN8Mh9qXWuwX5
	sRE9wRdtYcfTwPHKbOF95vscR9e+/dRhFwDb4vIMlegCef1M2W/TrN2YdXPG0KfT3s83
	XqL6mbOMB3NASzQB4fj2v++BWTZ7QAY31rXINozBoJ73aSHZ/Q9I/bGcQxdRDLoDiR1e
	BXMi/ZM4laoq+3hPUIzQ03Ndaj+AcjwlZU+kahIjkAWme7IpgXA5joX6FBx6lAIbSB1U
	4j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=g094LoCkdXWUCN61uTJrxTlLQMWseBk04sIwI3xmN/g=;
	b=fATWjtbWr+6KRJ9cHGC3senp6szk/iLWkfYed3alQToBC1wmnrl2lGSeAiCEZTZ9gm
	hqWWPVPbap6eZBDy11Ya2AhYCbObCpuFt/S1R2gN8aYgRfJ3RWFJs+9RpvAaolBiPh2b
	jbay0MjHW79KynniVMcf4vv2ny56Edk90lWHCiT55OH2gz2ouuf6bsUMYOtIFiKmm2D5
	bbUBH3uqjwhx9afG5OHvxNDN++zoMe2ha6PBihbqzWgXjVfh6COAy0N6aokOFbitslrs
	VlnTMw/bhsRG/Hl8ptFLYSpSASL7n1/Ud5uFVZKM5jOEFXsEkrYRGWPvwIHkxxBtSZOS
	tVhw==
X-Gm-Message-State: ALoCoQlz5T1BZC0A3dZXWSnSSejBK94mw0xZw5LSYJyh5a4GymIKxGB4EZTI22KcOJ49dkADTYCB
MIME-Version: 1.0
X-Received: by 10.107.167.197 with SMTP id q188mr39974218ioe.141.1445944870199;
	Tue, 27 Oct 2015 04:21:10 -0700 (PDT)
Received: by 10.64.7.67 with HTTP; Tue, 27 Oct 2015 04:21:10 -0700 (PDT)
In-Reply-To: <1445685965.21913.58.camel@linuxfoundation.org>
References: <1444555346.14364.24.camel@linuxfoundation.org>
	<CA+1hgUj5Lty=V_jSWE1YA2CPJuaY5-PAoj+P8gEtzSKDN5gVjA@mail.gmail.com>
	<1445011191.17974.34.camel@linuxfoundation.org>
	<CA+1hgUg7=OhPXV=fHrXzLpSeWKZekx0BkYpu1BC8zaA1H7gG2w@mail.gmail.com>
	<1445685965.21913.58.camel@linuxfoundation.org>
Date: Tue, 27 Oct 2015 11:21:10 +0000
Message-ID: <CA+1hgUi-zvaEe+gQd8VaCa=6miMk9-ceSTdMCczwbSSZ5D5ANg@mail.gmail.com>
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
X-List-Received-Date: Tue, 27 Oct 2015 11:21:11 -0000
Content-Type: multipart/alternative; boundary=001a1141ca945a89230523144627

--001a1141ca945a89230523144627
Content-Type: text/plain; charset=UTF-8

On 24 October 2015 at 12:26, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2015-10-19 at 13:27 +0100, Smith, Elliot wrote:
> > Thanks for clarifying.
> >
> > Will these patches be in 2.0? From the toaster point of view, it would
> > be better if the current behaviour remained for now, even though it is
> > broken.
> >
> > We are working on a solution which will write separate build logs from
> > within Toaster itself, which will mean we can keep our log download
> > working when your patches do go in.
> >
> > However, we may not get this finished for 2.0, and it would be good if
> > we could keep the Toaster log download feature working in the
> > meantime.
> >
> Given the other discussion I've seen, I'm assuming it would be ok to
> merge these now?
>

Yes, as we're now writing our own logs for Toaster.

Thanks for merging.

Elliot


> Cheers,
>
> Richard
>
>
>
>


-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a1141ca945a89230523144627
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 2=
4 October 2015 at 12:26, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@l=
inuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<span class=3D"">On Mon, 2015-10-19 at 13:27 +0100, Smith, Elliot wrote:<br=
>
&gt; Thanks for clarifying.<br>
&gt;<br>
&gt; Will these patches be in 2.0? From the toaster point of view, it would=
<br>
&gt; be better if the current behaviour remained for now, even though it is=
<br>
&gt; broken.<br>
&gt;<br>
&gt; We are working on a solution which will write separate build logs from=
<br>
&gt; within Toaster itself, which will mean we can keep our log download<br=
>
&gt; working when your patches do go in.<br>
&gt;<br>
&gt; However, we may not get this finished for 2.0, and it would be good if=
<br>
&gt; we could keep the Toaster log download feature working in the<br>
&gt; meantime.<br>
&gt;<br>
</span>Given the other discussion I&#39;ve seen, I&#39;m assuming it would =
be ok to<br>
merge these now?<br></blockquote><div><br></div><div>Yes, as we&#39;re now =
writing our own logs for Toaster.</div><div><br></div><div>Thanks for mergi=
ng.</div><div><br></div><div>Elliot<br></div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Elliot Smith<br>Software Enginee=
r<br>Intel Open Source Technology Centre</div></div></div>
</div></div>

--001a1141ca945a89230523144627--
