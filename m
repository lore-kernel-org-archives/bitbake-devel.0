Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
	[209.85.215.42])
	by mail.openembedded.org (Postfix) with ESMTP id 8DAAE701CC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jun 2014 15:54:42 +0000 (UTC)
Received: by mail-la0-f42.google.com with SMTP id pn19so2558144lab.29
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jun 2014 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=Jv97XfGwY5b92vbFtHa36sitEF/qJCBR/+OZf8PI7fg=;
	b=ChM+86QyvNIl5ACj5ycXHpu8UQqKCgQbdHx7Xid3WpTIILJ3jhOfFTsWwo8bm7ny7X
	rmyovmdgZogHbu7huXIFVCoksKetn/lUzyjlrhiPEpjri5mUDXr3Exv0vXznIbvDx8T5
	4Ix9ENhGy/k79J2xOONe5kytR6wVgim6IwooPbQwp8f0e1EeARkWm9aRtEqnCNuXpgJC
	TtVxHssUWk3qLDjQw6tD5a1TzpzOuJM8JChXwJjMno0E6d16xwOjsaKChSCPFeInyxnF
	mhttd1MzhYey/I9+fYVMi+YyDCryvYj1NTkf6xixLD/gsTgdShtk0gaC6jhb7Pk6JJK+
	MY4A==
X-Received: by 10.112.13.137 with SMTP id h9mr2972114lbc.33.1403279682141;
	Fri, 20 Jun 2014 08:54:42 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.31.165 with HTTP; Fri, 20 Jun 2014 08:54:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1406200725340.5971@localhost>
References: <alpine.LFD.2.11.1406200725340.5971@localhost>
From: Christopher Larson <clarson@kergoth.com>
Date: Fri, 20 Jun 2014 08:54:22 -0700
X-Google-Sender-Auth: 4V2LOzr5JD9hp5MxZOlHUNwuX-0
Message-ID: <CABcZANn_x7Y9XJ-g861+9YEsXtVNwF-krtf7QBgrG50PxUdEPw@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: distinguishing between bitbake and "higher" layers WRT fetching variables [LONG]
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
X-List-Received-Date: Fri, 20 Jun 2014 15:54:44 -0000
Content-Type: multipart/alternative; boundary=001a11c3d10af984e804fc4682ea

--001a11c3d10af984e804fc4682ea
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 20, 2014 at 8:47 AM, Robert P. J. Day <rpjday@crashcourse.ca>
wrote:

>   (note: more annoying pedantry regarding bitbake configuration and
> documentation but, if i'm going to explain this to my students, i
> really need to understand it completely.)
>
>   some questions and observations about how bitbake defines some
> fetch-related variables as opposed to how those variables are defined
> in higher layers such as oe-core and poky. as richard purdie(?)
> pointed out recently, the goal should be to document bitbake as
> independently as possible from what happens in layers such as oe and
> poky, but it seems this is not as clean as it could be.
>
>   consider first bitbake's current bitbake.conf file. first, can we
> agree that this set of variables:
>

Before I dive into the remainder of the email, we should note that the
bitbake.conf in bitbake is never used when you use oe, it's solely as an
example / starting point for other non-oe projects wanting to use bitbake.
Presumably it gets forgotten about when changes to bitbake itself are made,
and so it's fallen behind.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c3d10af984e804fc4682ea
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jun 20, 2014 at 8:47 AM, Robert P. J. Day <span dir=3D"ltr">&lt;<a =
href=3D"mailto:rpjday@crashcourse.ca" target=3D"_blank">rpjday@crashcourse.=
ca</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":ax" class=3D"a3s" style=3D"overf=
low:hidden">=C2=A0 (note: more annoying pedantry regarding bitbake configur=
ation and<br>


documentation but, if i&#39;m going to explain this to my students, i<br>
really need to understand it completely.)<br>
<br>
=C2=A0 some questions and observations about how bitbake defines some<br>
fetch-related variables as opposed to how those variables are defined<br>
in higher layers such as oe-core and poky. as richard purdie(?)<br>
pointed out recently, the goal should be to document bitbake as<br>
independently as possible from what happens in layers such as oe and<br>
poky, but it seems this is not as clean as it could be.<br>
<br>
=C2=A0 consider first bitbake&#39;s current bitbake.conf file. first, can w=
e<br>
agree that this set of variables:</div></blockquote></div><br></div><div cl=
ass=3D"gmail_extra">Before I dive into the remainder of the email, we shoul=
d note that the bitbake.conf in bitbake is never used when you use oe, it&#=
39;s solely as an example / starting point for other non-oe projects wantin=
g to use bitbake. Presumably it gets forgotten about when changes to bitbak=
e itself are made, and so it&#39;s fallen behind.<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--001a11c3d10af984e804fc4682ea--
