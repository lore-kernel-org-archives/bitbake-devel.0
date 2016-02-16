Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
	[209.85.223.175])
	by mail.openembedded.org (Postfix) with ESMTP id ECD37731A4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Feb 2016 15:02:01 +0000 (UTC)
Received: by mail-io0-f175.google.com with SMTP id 9so196162112iom.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Feb 2016 07:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:content-type; bh=zmh55fzpzONdI+UBX97tQrtJMM0eRyUg3HZlPbJY4R8=;
	b=JxCzvWNtWQvmLEU7PABV8IfLdCUfi8Uw4tovd8cN1psuWcoLHYp67U2veSWsd1wfs4
	jpphZEiowMX7/+SUbjJE2sRdGrZG7y8WH6jP4Hi7HxwUp9tHd7LzEoeukQeYlQ/glcix
	oGE+iPdNaGhmkAsXgnWHdWTMjSqNhaP9JfWOLPyZIsK2E4Td5tPCzDQ9nIyKgkOEzhb6
	dTvZ4ZpokXKnz+BnS+QNIv/CSkFyqUF2FDzqfJ0lnomvcJcteRkC1/+Y/kINCrmH6tcV
	nl9bklftBhRn3ucb3B6dum+rm4nFOPL6eedVljl3i1/u75+7KbIBGWl/cX2ZxVYF0vh/
	ebzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:content-type;
	bh=zmh55fzpzONdI+UBX97tQrtJMM0eRyUg3HZlPbJY4R8=;
	b=D++BIgnvHam+IIcJr5MD4nP5cIEZNLkHcCPkEH+9A/Gca2YDGZx3nk9d3NYo3Gv8Fk
	KfdDffdqpXfFfMYpibfCC2arOK4FeZtHqV81VP2rPRdv5AyiywUIPwH0kCmldYRhvqhT
	2IRCN+U3jH4sfViKtK0dikhuQZdYnmtqyRtOYpxiDR8i2VUNAEUKzcZInzgwpq/0Kf56
	6AwapSdRfAzUu7Mqqa4VEArwwibSApC34qLKIkLRf96HtTtQS21CoksO7OdQe8mmwwmX
	BsGw1z7pEVL0f69vWemlyy94P9wKAGvJXzZ5EJFUtthRyY0C09oY0bERICUfkYGb7ZLI
	sCxQ==
X-Gm-Message-State: AG10YOSQ5enebvSLRXE5wcVKPYxSfPoifhjVb2LXAzVDjiZKRPIpJZJ2N9iQlvm0TkSKwVUsuiEqw028QdAa/g==
X-Received: by 10.107.29.209 with SMTP id d200mr22854682iod.27.1455634921945; 
	Tue, 16 Feb 2016 07:02:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1455235907.git.chris_larson@mentor.com>
	<bfefd7e111665ad68f9c30a115cf307921561f7d.1455235907.git.chris_larson@mentor.com>
	<CABcZANkGAQohdYSYsotAyTShaCqDWz441WPUHHf6jF+5J8bP=Q@mail.gmail.com>
	<1455463095.16142.412.camel@linuxfoundation.org>
	<1455621297.16142.430.camel@linuxfoundation.org>
In-Reply-To: <1455621297.16142.430.camel@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Tue, 16 Feb 2016 15:01:52 +0000
Message-ID: <CABcZAN=W4Mem+LNx+vpkqsHLrAPA+bDRgHPiGnDgO=sew+gohA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/1] bb.ui.knotty: prefix task messages with recipe/task
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
X-List-Received-Date: Tue, 16 Feb 2016 15:02:02 -0000
Content-Type: multipart/alternative; boundary=001a11408e9e71fe34052be46a82

--001a11408e9e71fe34052be46a82
Content-Type: text/plain; charset=UTF-8

On Tue, Feb 16, 2016 at 4:15 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Sun, 2016-02-14 at 15:18 +0000, Richard Purdie wrote:
> > On Fri, 2016-02-12 at 00:15 +0000, Christopher Larson wrote:
> > > On Thu, Feb 11, 2016 at 5:13 PM Christopher Larson <
> > > kergoth@gmail.com
> > > > wrote:
> > > > From: Christopher Larson <chris_larson@mentor.com>
> > > >
> > > > An example prefix: `perl-5.22.1-r0 do_compile:`
> > > >
> > > > Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> > > I realize this may well be something to do for 2.2 rather than 2.1,
> > > but I wanted to throw it out and get thoughts on it, as I'm sick of
> > > manually prefixing our log messages in tasks :)
> >
> > I like the idea and actually wondered why this was an RFC, shouldn't
> > we
> > just do it?
> >
> > Having watched oe-selftest having a problems with this, I can see why
> > we may need to be more cautious :/.
> >
> > Still trying to assess how bad the issues there are.
>
> Fixed the issues in selftest so decided to merge this as it is an issue
> we've needed to address for a while.
>
> Thanks!
>

NP, Thanks for taking the time to look into and test this.

--001a11408e9e71fe34052be46a82
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue=
, Feb 16, 2016 at 4:15 AM Richard Purdie &lt;<a href=3D"mailto:richard.purd=
ie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">On Sun, 2016-02-14 at 15:18 +0000, R=
ichard Purdie wrote:<br>
&gt; On Fri, 2016-02-12 at 00:15 +0000, Christopher Larson wrote:<br>
&gt; &gt; On Thu, Feb 11, 2016 at 5:13 PM Christopher Larson &lt;<br>
&gt; &gt; <a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gm=
ail.com</a><br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; From: Christopher Larson &lt;<a href=3D"mailto:chris_larson@=
mentor.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; An example prefix: `perl-5.22.1-r0 do_compile:`<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chri=
s_larson@mentor.com" target=3D"_blank">chris_larson@mentor.com</a>&gt;<br>
&gt; &gt; I realize this may well be something to do for 2.2 rather than 2.=
1,<br>
&gt; &gt; but I wanted to throw it out and get thoughts on it, as I&#39;m s=
ick of<br>
&gt; &gt; manually prefixing our log messages in tasks :)<br>
&gt;<br>
&gt; I like the idea and actually wondered why this was an RFC, shouldn&#39=
;t<br>
&gt; we<br>
&gt; just do it?<br>
&gt;<br>
&gt; Having watched oe-selftest having a problems with this, I can see why<=
br>
&gt; we may need to be more cautious :/.<br>
&gt;<br>
&gt; Still trying to assess how bad the issues there are.<br>
<br>
Fixed the issues in selftest so decided to merge this as it is an issue<br>
we&#39;ve needed to address for a while.<br>
<br>
Thanks!<br></blockquote><div><br></div><div>NP, Thanks for taking the time =
to look into and test this.=C2=A0</div></div></div>

--001a11408e9e71fe34052be46a82--
