Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
	[209.85.215.44])
	by mail.openembedded.org (Postfix) with ESMTP id 0916D6D761
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Dec 2013 22:52:03 +0000 (UTC)
Received: by mail-la0-f44.google.com with SMTP id ep20so10182272lab.31
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Dec 2013 14:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=uZje2j0xfaCFxZsbJR3KIBdI5Ai/1yACBjBgL7oBSzU=;
	b=LiEhWhpjaeK/wYmSEfXPmtukVRoB2r3d/LzRBVxkIFtSVMeIIFE0Afr63ThithZZS6
	u9w9+ys2X2+QlTlV/DQOx8i60hqcZNQ/Mo+Lk8n4SN32ob6WwVMIa7xqg6gF/q+IrJFz
	7NckLwy042tSdc9PY/pc1UCMI3oK059p+kl9dpKdCgStjVzwAfXGYPY1c9p4/JqhC6qE
	6Al68ZxHQ9z/16+X9P3O3zoiG3h72rgeYkngLjwfIGNSml4TdULFqh3ZYIQx2ZLtB/+S
	BpEucnVIasVMHln+dDk5VUixsLCq6rSHzHQhbWpq+GUENTgC9PhOKf+BF5P70/5BmTS2
	qSJQ==
X-Received: by 10.152.234.170 with SMTP id uf10mr518985lac.43.1386197522878;
	Wed, 04 Dec 2013 14:52:02 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.176.201 with HTTP; Wed, 4 Dec 2013 14:51:42 -0800 (PST)
In-Reply-To: <1386171581-16533-1-git-send-email-konrad.scherer@windriver.com>
References: <1386171581-16533-1-git-send-email-konrad.scherer@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 4 Dec 2013 15:51:42 -0700
X-Google-Sender-Auth: 8z3V_0X78iBogM2d5Yz9CAy86B8
Message-ID: <CABcZANkn_G6XowZLLHctmpFrYnF3SoF8jAOaup72TDYMg83vxQ@mail.gmail.com>
To: Konrad Scherer <konrad.scherer@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: Unable to fetch URL should be a warning, not an error
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
X-List-Received-Date: Wed, 04 Dec 2013 22:52:05 -0000
Content-Type: multipart/alternative; boundary=001a1133ad0ef0970804ecbd42aa

--001a1133ad0ef0970804ecbd42aa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2013 at 8:39 AM, Konrad Scherer <konrad.scherer@windriver.co=
m
> wrote:

> From: Konrad Scherer <Konrad.Scherer@windriver.com>
>
> Running a build server with local sstate cache and running the
> oe-core sstate-cache-management.sh script on cron can cause errors if
> an sstate file is removed before it can be used. This is not an
> error because the package can be rebuilt from source. Changing
> the message to a warning is more appropriate in this case.
>
> Signed-off-by: Konrad Scherer <Konrad.Scherer@windriver.com>
>

FYI, there=E2=80=99s an open bug to resolve similar issues by getting rid o=
f the
message entirely, not just changing it to a warning:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D4499
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1133ad0ef0970804ecbd42aa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Dec 4, 2013 at 8:39 AM, Konrad Scherer <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:konrad.scherer@windriver.com" target=3D"_blank">konrad.scherer@=
windriver.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div id=3D":qr" style=3D"overflow:hidden">From: Konrad Sch=
erer &lt;<a href=3D"mailto:Konrad.Scherer@windriver.com">Konrad.Scherer@win=
driver.com</a>&gt;<br>


<br>
Running a build server with local sstate cache and running the<br>
oe-core sstate-cache-management.sh script on cron can cause errors if<br>
an sstate file is removed before it can be used. This is not an<br>
error because the package can be rebuilt from source. Changing<br>
the message to a warning is more appropriate in this case.<br>
<br>
Signed-off-by: Konrad Scherer &lt;<a href=3D"mailto:Konrad.Scherer@windrive=
r.com">Konrad.Scherer@windriver.com</a>&gt;</div></blockquote></div><br>FYI=
, there=E2=80=99s an open bug to resolve similar issues by getting rid of t=
he message entirely, not just changing it to a warning:=C2=A0<a href=3D"htt=
ps://bugzilla.yoctoproject.org/show_bug.cgi?id=3D4499">https://bugzilla.yoc=
toproject.org/show_bug.cgi?id=3D4499</a><br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--001a1133ad0ef0970804ecbd42aa--
