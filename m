Return-Path: <martin.jansa@gmail.com>
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
	[209.85.208.49])
	by mail.openembedded.org (Postfix) with ESMTP id 2852C6D7C1
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Nov 2019 14:59:08 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id a24so1586732edt.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Nov 2019 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=igyLOtITFCNsK7DhyDRwP2hWoyf5w7aZ380fc5/RNEo=;
	b=DYVuQYx+7qmNVBd3z3j2AMtv+4W5Pmxa93XNP+nIC4iBm7W9pcFlzUYJXKikAeYp0a
	uxukkY98xRvdxLBo1ebe1kM6Psu2ib8LR2dpEx+kqcpz7ALDwsRoLHEl4AhS1BIKOZGg
	cSJ+isxEL3m1AaTxtM1Zv7KOoNdDlOEoaqiSdw73HZCyiDH/8YRBoxmfr9L0efGZJPZG
	Sns31hzkBpT7dirJkQznni9VZC4ZFyZrQWKS2sjkYtuuuGLNX8WXFcvaMaHdJppcVk2t
	3Wu58VeV+4qJkLvCjHaVOh9d6DvFSRa/Idd/yBsQrjIpc9ev/kfk4UBrS4qnI964Nrqf
	fCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=igyLOtITFCNsK7DhyDRwP2hWoyf5w7aZ380fc5/RNEo=;
	b=aeCbSYDEcG9pjMRBnYwAfJ8/E/nLBgZFwRrS3vcOXeDzjUZpEeLiY8h2H4XhNKMznb
	hqFfu1BgrpMR/t4OYdrscVtuUKU/8/lUXLd0T+Tr2dIP/JFHIWbkwS5ALm5CFjn+G/OS
	XSG1Fyem2PWhLoWNIJkp/Q74zZsZu71w/x4FROXlL06vODAh/jnQe5jfLqXTNz89hJR+
	LS1I8YnIOm2nF2E8jwZa0J7wZ/7CkdtwIo79920DlEh1AIm/m/aGt3pJruh6H6WeQoSV
	zZ8rT4kW94K0FTqlclhD7p+wwbfu8MNIKfPnJt5PcgZd3AYKkAXsw6Sm0O0zVmJAYH+T
	KmUw==
X-Gm-Message-State: APjAAAWsNxja1gW1XJVQyQntOby1KOuI98wHimUbdQ5e09JvdmBfAstW
	cudwNt2Ub3SkDsH81Ou9+uKYIjmV2zainzCFGiro4Y7J
X-Google-Smtp-Source: APXvYqzzeR4eFv4YfoNNixJ2zvk5NgncBhjPCR3gr1DzcuwAW8ZfcBqsFIozJKKMRiof0xnVWbT5fhshaylEsF2wqdU=
X-Received: by 2002:a17:906:2786:: with SMTP id
	j6mr9033949ejc.206.1573225148815; 
	Fri, 08 Nov 2019 06:59:08 -0800 (PST)
MIME-Version: 1.0
References: <6f692d96-9b78-b317-d033-09d1f140da62@linux.intel.com>
In-Reply-To: <6f692d96-9b78-b317-d033-09d1f140da62@linux.intel.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 8 Nov 2019 15:58:57 +0100
Message-ID: <CA+chaQcOse_xmbyi0q=WXB1JQxV6AgGJtvrFZ_Wtmi-N2z0g6A@mail.gmail.com>
To: =?UTF-8?Q?Adrian_Ambro=C5=BCewicz?= <adrian.ambrozewicz@linux.intel.com>
Cc: Bitbake-Devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Patch idea - fetcher for gerrit patches
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
X-List-Received-Date: Fri, 08 Nov 2019 14:59:09 -0000
Content-Type: multipart/alternative; boundary="000000000000259e1b0596d70658"

--000000000000259e1b0596d70658
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Do we actually need separate fetcher for gerrit?

We're using gerrit for everything @LGE and to fetch from open reviews
instead of merged commits I'm just setting the gerrit reference in SRCREV
(e.g. refs/changes/61/252561/44) and normal git fetcher does the right
think and fetches it correctly.

Advantage of using the same fetcher is to easily switch between tag/git
ref/gerrit ref just by small SRC_URI modification instead of replacing
whole repository (starting from fetcher change from git:// to gerrit://).

Adding optional parameter for git:// fetcher to make it easier to specify
which review to pull seems easier to use and less error prone (as you
probably never want to use e.g. review from glib gerrit project in dbus
recipe, so always including the project name and showing error when the
referenced review in change parameter doesn't point to the right project is
IMHO better then fetching something completely different).

For topic parameter I don't understand how would you fetch the reviews if
there are more then one with the same topic? Would you fetch multiple
repositories in some automatically generated destdir directories? Or fetch
just the patches and apply them on top of some other SRC_URI entry?

Regards,

On Fri, Nov 8, 2019 at 3:08 PM Adrian Ambro=C5=BCewicz <
adrian.ambrozewicz@linux.intel.com> wrote:

> Hello,
>
> As it is my first message here allow me to introduce myself. I'm Adrian
> Ambro=C5=BCewicz and I work at Intel Technology Poland. I love flexibilit=
y
> and features of Bitbake and I would like to propose new feature which
> will solve our problem.
>
> I would like to propose extension to already supported fetcher library -
> gerrit. Idea is to be able to apply gerrit patches by simply specifying:
> "SRC_URI +=3D gerrit://[gerrit_server];change=3D[change_id]". Fetcher wou=
ld
> then take care of downloading most recent patchset from given review.
> Further extensiosn of that fetcher could include ability to specify:
> - revision (get given revision instead of top)
> - topic (get all patches from given topic)
> - project (to be used in conjunction with 'topic' parameter)
> etc...
>
> I've prepared minimal PoC implementation without any error handling. It
> works just fine and is basing on wget command. Gerrit REST API is used
> to obtain base64-encoded patch which is then decoded to file with name
> [change_id].patch . I'm very interested in polishing that and
> upstreaming it for everyone to use.
>
> The question I have for you is the following: does this fetcher have a
> chance to be accepted upstream?
>
> Regards,
> Adrian
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--000000000000259e1b0596d70658
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Do we actually need separate fetcher for gerrit?<div><br><=
/div><div>We&#39;re using gerrit for everything=C2=A0@LGE and to fetch from=
 open reviews instead of merged commits I&#39;m just setting the gerrit ref=
erence in SRCREV (e.g.=C2=A0refs/changes/61/252561/44) and normal git fetch=
er does the right think and fetches it correctly.</div><div><br></div><div>=
Advantage of using the same fetcher is to easily switch between tag/git ref=
/gerrit ref just by small SRC_URI modification instead of replacing whole r=
epository (starting from fetcher change from git:// to gerrit://).</div><di=
v><br></div><div>Adding optional parameter for git:// fetcher to make it ea=
sier to specify which review to pull seems easier to use and less error pro=
ne (as you probably never want to use e.g. review from glib gerrit project =
in dbus recipe, so always including the project name and showing error when=
 the referenced review in change parameter doesn&#39;t point to the right p=
roject is IMHO better then fetching something completely different).</div><=
div><br></div><div>For topic parameter I don&#39;t understand how would you=
 fetch the reviews if there are more then one with the same topic? Would yo=
u fetch multiple repositories in some automatically generated destdir direc=
tories? Or fetch just the patches and apply them on top of some other SRC_U=
RI entry?</div><div><br></div><div>Regards,</div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 8, 2019 at 3:0=
8 PM Adrian Ambro=C5=BCewicz &lt;<a href=3D"mailto:adrian.ambrozewicz@linux=
.intel.com">adrian.ambrozewicz@linux.intel.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
As it is my first message here allow me to introduce myself. I&#39;m Adrian=
 <br>
Ambro=C5=BCewicz and I work at Intel Technology Poland. I love flexibility =
<br>
and features of Bitbake and I would like to propose new feature which <br>
will solve our problem.<br>
<br>
I would like to propose extension to already supported fetcher library - <b=
r>
gerrit. Idea is to be able to apply gerrit patches by simply specifying: <b=
r>
&quot;SRC_URI +=3D gerrit://[gerrit_server];change=3D[change_id]&quot;. Fet=
cher would <br>
then take care of downloading most recent patchset from given review.<br>
Further extensiosn of that fetcher could include ability to specify:<br>
- revision (get given revision instead of top)<br>
- topic (get all patches from given topic)<br>
- project (to be used in conjunction with &#39;topic&#39; parameter)<br>
etc...<br>
<br>
I&#39;ve prepared minimal PoC implementation without any error handling. It=
 <br>
works just fine and is basing on wget command. Gerrit REST API is used <br>
to obtain base64-encoded patch which is then decoded to file with name <br>
[change_id].patch . I&#39;m very interested in polishing that and <br>
upstreaming it for everyone to use.<br>
<br>
The question I have for you is the following: does this fetcher have a <br>
chance to be accepted upstream?<br>
<br>
Regards,<br>
Adrian<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--000000000000259e1b0596d70658--
