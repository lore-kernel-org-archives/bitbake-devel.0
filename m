Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
	[209.85.223.171])
	by mail.openembedded.org (Postfix) with ESMTP id 8BD447661D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 18:41:20 +0000 (UTC)
Received: by ioii16 with SMTP id i16so93951667ioi.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=fW6MdlxIpn2nL0v/6urPZnxa9yQ9LzzZp/PlvL6EcXA=;
	b=d6Dq+CvSl+6Ghs007upQvbmo0p4g7EIkvFW8Q6oYu7zotbHdPm37hSfXehdrbC98rP
	TdpRwoa1ePW99r6rd4Se0lNLqkXl6uyjP1+RfEh+KFC+YaMyLoyNksznnQWMdJxWC6Vt
	w+V23ma44/6ETbUMAoCjVrFK2yRjAI22ilQOiPsaQJ2UNWPB8ErITCvt38pel/4ZFypH
	UX+PcGPI9UUHYaAP2+cWOQCNX8tbR0o9CGZgCznr+mKrawLqB53pHDSQYTwwXa/wmCWC
	nnmmetKnGpZppcYIAksO02IZ8jD8pcECoRi8AcVcMflzwi+fgcx7UD8lVu9z4H5HdlRq
	bZOg==
X-Received: by 10.107.158.197 with SMTP id h188mr7223297ioe.99.1438368080364; 
	Fri, 31 Jul 2015 11:41:20 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.199 with HTTP; Fri, 31 Jul 2015 11:41:00 -0700 (PDT)
In-Reply-To: <1438363893-11812-1-git-send-email-kergoth@gmail.com>
References: <1438363893-11812-1-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 31 Jul 2015 11:41:00 -0700
X-Google-Sender-Auth: HEWotRsgU0c9fqGkmTgnBti6IpI
Message-ID: <CABcZANkVY3Xf8kS7SktwRjCzDxY=YfHJPWXdp+2b9X8mJccYGA@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH] bb.build: let addtask undo a deltask
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
X-List-Received-Date: Fri, 31 Jul 2015 18:41:21 -0000
Content-Type: multipart/alternative; boundary=001a1141becc7c89dc051c302ac0

--001a1141becc7c89dc051c302ac0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 10:31 AM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> While we're in that part of the code, also fix 'not foo in bar' to 'foo
> not in
> bar', as is preferred in python.
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
>

Hold off on applying this. While it=E2=80=99s a start, it=E2=80=99s not nec=
essarily ideal
either, since it doesn=E2=80=99t reset the intra-recipe inter-task dependen=
cies.
Re-adding a deleted task will resurrect it exactly as it was, rather than
with new specified dependencies. I=E2=80=99m looking into a more thorough d=
eletion
now.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1141becc7c89dc051c302ac0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jul 31, 2015 at 10:31 AM, Christopher Larson <span dir=3D"ltr">&lt;=
<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1dz" clas=
s=3D"a3s" style=3D"overflow:hidden">From: Christopher Larson &lt;<a href=3D=
"mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
While we&#39;re in that part of the code, also fix &#39;not foo in bar&#39;=
 to &#39;foo not in<br>
bar&#39;, as is preferred in python.<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;</div></blockquote></div><br>Hold off =
on applying this. While it=E2=80=99s a start, it=E2=80=99s not necessarily =
ideal either, since it doesn=E2=80=99t reset the intra-recipe inter-task de=
pendencies. Re-adding a deleted task will resurrect it exactly as it was, r=
ather than with new specified dependencies. I=E2=80=99m looking into a more=
 thorough deletion now.<br>-- <br><div class=3D"gmail_signature"><div dir=
=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics</div></div>
</div></div>

--001a1141becc7c89dc051c302ac0--
