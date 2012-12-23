Received: from mail-la0-f53.google.com ([209.85.215.53])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TmsWW-0003YK-7e
	for bitbake-devel@lists.openembedded.org;
	Sun, 23 Dec 2012 21:51:52 +0100
Received: by mail-la0-f53.google.com with SMTP id w12so7823191lag.12
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Dec 2012 12:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=y4LIJYRtR+mlUQBVRx9qaxEAsd/av8ctizmy8F7J/EQ=;
	b=VKYBTD635p1zC81WWT1R2aLUs8w2eDFO+byrAAs4Uxo1OgBS0APaIEULZVNzipP13r
	8UKls9OORA2IVvZPmvWvnkLqtAjGHsFJSHlAS8BBZRTpwG3jDhGoGimgs7S7fHB2v2/0
	4lKr6SsQVLE5LHijVYcl6jef/ZYUZCtiwk+7Z/i94cMeitsflHjCNOjr/rK5CGPwWLKC
	BXxIzoxu76adfWUTsAoa/804L6WmPpLF/uE9GnK/Ouus9KHCpMl1FVogam/MxmFiJzpY
	xtPSOxSaCDJ0Eb6DAXg1N9hS2HNdGyHa49POV+Ew4tQA0eW3xsQa0H9q5HAfVmwqT6L0
	t7DQ==
Received: by 10.112.16.69 with SMTP id e5mr7990913lbd.43.1356295022980; Sun,
	23 Dec 2012 12:37:02 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Sun, 23 Dec 2012 12:36:42 -0800 (PST)
In-Reply-To: <1356294176-12058-1-git-send-email-Martin.Jansa@gmail.com>
References: <1356294176-12058-1-git-send-email-Martin.Jansa@gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Sun, 23 Dec 2012 13:36:42 -0700
X-Google-Sender-Auth: 3p9qxJ3PfJWr-265k26zi28thMg
Message-ID: <CABcZANmR7JKetymVnVD4TorB+DoMXPPN-sQ-BDsDegeWWwph5w@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cache: allow to set EXCLUDE_FROM_WORLD outside recipe
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
X-List-Received-Date: Sun, 23 Dec 2012 20:51:52 -0000
Content-Type: multipart/alternative; boundary=f46d0401fb410e2e3c04d18b0b78

--f46d0401fb410e2e3c04d18b0b78
Content-Type: text/plain; charset=UTF-8

On Sun, Dec 23, 2012 at 1:22 PM, Martin Jansa <martin.jansa@gmail.com>wrote:

> * sometimes it's useful for distro/builder to set EXCLUDE_FROM_WORLD_foo =
> "1"
>   to exclude recipes not supported by distro/builder in some include file
>
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
>

EXCLUDE_FROM_WORLD_pn-foo = "1"
-- 
Christopher Larson

--f46d0401fb410e2e3c04d18b0b78
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quo=
te">On Sun, Dec 23, 2012 at 1:22 PM, Martin Jansa <span dir=3D"ltr">&lt;<a =
href=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail=
.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":1dt">* sometimes it&#39;s useful=
 for distro/builder to set EXCLUDE_FROM_WORLD_foo =3D &quot;1&quot;<br>
=C2=A0 to exclude recipes not supported by distro/builder in some include f=
ile<br>
<br>
Signed-off-by: Martin Jansa &lt;<a href=3D"mailto:Martin.Jansa@gmail.com">M=
artin.Jansa@gmail.com</a>&gt;</div></blockquote></div><br>EXCLUDE_FROM_WORL=
D_pn-foo =3D &quot;1&quot;</div><div class=3D"gmail_extra">--=C2=A0<br></di=
v><div class=3D"gmail_extra">

Christopher Larson</div></div>

--f46d0401fb410e2e3c04d18b0b78--
