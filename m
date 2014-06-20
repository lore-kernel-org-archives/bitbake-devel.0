Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
	[209.85.217.170])
	by mail.openembedded.org (Postfix) with ESMTP id 60C417019B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jun 2014 16:08:53 +0000 (UTC)
Received: by mail-lb0-f170.google.com with SMTP id 10so2547001lbg.29
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jun 2014 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=oNvuDsy7BtQI4AOh9KhDEocxrYd0uU6a43+aVFAS1ts=;
	b=EeVRXZbCqWGbyJnVuWNyexLxDuTjFqg6Eys+tmlC/gq7/jnVlqtkWitONIqDDLJhqY
	u0TqLUXaBNLxfDV+4Y16BDJNM1YLoJjpZMCk5L4gKP90hOkXmdY4Av1dgW5cw/c4KYRd
	LiBbTAciOtXpvJRQdPYTwMDGDIQQH8ac5gpqEga3ZNEKVTpt0JRehUbfzAazMT+0zCME
	jqC0V2abspP/QKmFucyzSnOT+qukWv9B6heEDVrA74xfYWMBsdVJwsmL2NSe+SZvYorj
	qoV/F0++QofxQJUFon4+YfOS/nWcb0NdSeNfeb/A/hzImJZ3C3v1OB2tX3nCJkCFP5YH
	LySQ==
X-Received: by 10.112.13.137 with SMTP id h9mr3020422lbc.33.1403280533854;
	Fri, 20 Jun 2014 09:08:53 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.31.165 with HTTP; Fri, 20 Jun 2014 09:08:33 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1406201157320.11539@localhost>
References: <alpine.LFD.2.11.1406201157320.11539@localhost>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 20 Jun 2014 09:08:33 -0700
X-Google-Sender-Auth: UgATJDNnJ-Q_OaRS-XhiBdaNJNw
Message-ID: <CABcZAN=qpQ3FEO-bzj0hiGrNGcoghkK8UT0G4RXyhFXgJSutNA@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: are the fetch-related variables in bitbake's bitbake.conf of any value?
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
X-List-Received-Date: Fri, 20 Jun 2014 16:08:55 -0000
Content-Type: multipart/alternative; boundary=001a11c3d10abd9f9e04fc46b553

--001a11c3d10abd9f9e04fc46b553
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 20, 2014 at 9:00 AM, Robert P. J. Day <rpjday@crashcourse.ca>
wrote:

>
>   more specific question related to my earlier post -- is there any
> value whatever in the variables in bitbake's bitbake.conf file of the
> form:
>
>   FETCHCOMMAND*
>   RESUMECOMMAND*
>   UPDATECOMMAND*
>   MKTEMP*CMD
>
> nothing seems to use any of those. can they all just be deleted?
> certainly, the FETCHCOMMAND* variables have been superseded by the
> FETCHCMD* variables, no? i don't know about the remainder of them.


As far as I know, as you say, those were deprecated in favor of the
FETCHCMD vars, so can almost certainly be dropped.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c3d10abd9f9e04fc46b553
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jun 20, 2014 at 9:00 AM, Robert P. J. Day <span dir=3D"ltr">&lt;<a =
href=3D"mailto:rpjday@crashcourse.ca" target=3D"_blank">rpjday@crashcourse.=
ca</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"adM"><br></div>
=C2=A0 more specific question related to my earlier post -- is there any<br=
>
value whatever in the variables in bitbake&#39;s bitbake.conf file of the<b=
r>
form:<br>
<br>
=C2=A0 FETCHCOMMAND*<br>
=C2=A0 RESUMECOMMAND*<br>
=C2=A0 UPDATECOMMAND*<br>
=C2=A0 MKTEMP*CMD<br>
<br>
nothing seems to use any of those. can they all just be deleted?<br>
certainly, the FETCHCOMMAND* variables have been superseded by the<br>
FETCHCMD* variables, no? i don&#39;t know about the remainder of them.</blo=
ckquote></div><br></div><div class=3D"gmail_extra">As far as I know, as you=
 say, those were deprecated in favor of the FETCHCMD vars, so can almost ce=
rtainly be dropped.<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--001a11c3d10abd9f9e04fc46b553--
