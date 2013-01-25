Received: from mail-lb0-f174.google.com ([209.85.217.174])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TyrKo-0007s8-2V
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 23:01:18 +0100
Received: by mail-lb0-f174.google.com with SMTP id l12so1489851lbo.33
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2013 13:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=qwUUvzH90yrwLU1mDfqHzF/Gr/Kfk/DEKMiFa4rwS6Y=;
	b=mgij7EqsygDz5PRL6hNpyDvuUcSc2VE/2Sv0p1vVGX5DY3vZXkVoye1QTduBlV1ZRq
	fX8AtD5nDUJxf6pSm4d0viupLZpnjRlNbDm2iz5ASRyyngS0ITprggL1qzUWfIKW4R6C
	B0is0m+AJU3UqIsOOC/UbjGEP9RvBZuiyvL7+FoAvv28dDZGOciTVt1kwWNEvVIfp2+r
	6ExLVDits7YXKSYtX9Wt0J6e3lCEXz2Ik4+L3IIxe2VZqUdW4/Rwnu2A3ODhQeb5lwOi
	vllGxsL8HzNVFGL0kji7a3QanwigTQ3k2vWAhfF8MRNJekBbr4+QPZYb2KpOAiLOL04s
	edfw==
X-Received: by 10.112.87.194 with SMTP id ba2mr2787690lbb.84.1359150343045;
	Fri, 25 Jan 2013 13:45:43 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Fri, 25 Jan 2013 13:45:21 -0800 (PST)
In-Reply-To: <1359142708-24667-1-git-send-email-Martin.Jansa@gmail.com>
References: <1359142708-24667-1-git-send-email-Martin.Jansa@gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 25 Jan 2013 14:45:21 -0700
X-Google-Sender-Auth: VJqISo9shpOWZZl0M95wzJQqlIo
Message-ID: <CABcZANmTSLLfC=AvKjocVAN+Fj6n3Q3ZRQ=vON0EBw=5ahEiMw@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] world-image: add extra target
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 25 Jan 2013 22:01:18 -0000
Content-Type: multipart/alternative; boundary=f46d0401fdff64c4bf04d423d94e

--f46d0401fdff64c4bf04d423d94e
Content-Type: text/plain; charset=UTF-8

On Fri, Jan 25, 2013 at 12:38 PM, Martin Jansa <martin.jansa@gmail.com>wrote:

> * similar to world target, but collects all PACKAGES
> * recipes marked with EXCLUDE_FROM_WORLD are excluded from world as well
>   as world-image
> * recipes marked with EXCLUDE_FROM_WORLD_IMAGE are excluded completely
>   from world-image, sometimes you can build 2 recipes in same sysroot,
>   but cannot install them in the same image
> * PACKAGES listed in EXCLUDE_PACKAGES_FROM_WORLD_IMAGE are also
>   excluded. You can remove e.g. ${PN}-dbg, but keep all other PACKAGES.
>
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
>

bitbake should have zero knowledge of what an image even is, much less
hardcoding awareness of the IMAGE_INSTALL variable. Instead, we should
provide a means to hook into bitbake's knowledge of the recipes included in
the world image, and let a world-image recipe utilize that.
-- 
Christopher Larson

--f46d0401fdff64c4bf04d423d94e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jan 25, 2013 at 12:38 PM, Martin Jansa <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.co=
m</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":17r">* similar to world target, =
but collects all PACKAGES<br>
* recipes marked with EXCLUDE_FROM_WORLD are excluded from world as well<br=
>
=C2=A0 as world-image<br>
* recipes marked with EXCLUDE_FROM_WORLD_IMAGE are excluded completely<br>
=C2=A0 from world-image, sometimes you can build 2 recipes in same sysroot,=
<br>
=C2=A0 but cannot install them in the same image<br>
* PACKAGES listed in EXCLUDE_PACKAGES_FROM_WORLD_IMAGE are also<br>
=C2=A0 excluded. You can remove e.g. ${PN}-dbg, but keep all other PACKAGES=
.<br>
<br>
Signed-off-by: Martin Jansa &lt;<a href=3D"mailto:Martin.Jansa@gmail.com">M=
artin.Jansa@gmail.com</a>&gt;</div></blockquote></div><br>bitbake should ha=
ve zero knowledge of what an image even is, much less hardcoding awareness =
of the IMAGE_INSTALL variable. Instead, we should provide a means to hook i=
nto bitbake&#39;s knowledge of the recipes included in the world image, and=
 let a world-image recipe utilize that.<br>

-- <br>Christopher Larson</div></div>

--f46d0401fdff64c4bf04d423d94e--
