Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
	[209.85.217.180])
	by mail.openembedded.org (Postfix) with ESMTP id E8D3D6C921
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2014 16:17:02 +0000 (UTC)
Received: by mail-lb0-f180.google.com with SMTP id n15so484172lbi.39
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2014 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=tErJyP6yu7LeQvoMxF7+1zUxSqTv1j2DFVS/cTUP8xg=;
	b=I9WiFCIZblNe2mxBvq8bd9BnzT84tMSChaoiyZrTcxOK1oj0MNeSitIBua34rYztMz
	dL3NRte5zq79ZPHniymszcSdFEYtfmK9raAMrPZcOcApbDSbUAKYOWa32OsHg3FJAN6c
	vvcJxNvIvnXXeAxFHQR4V06u84kq8Shmf12n+f5AI0E8s4xWDfViQMA9dZ/DOjWMMuk0
	BuLuIWFooYYP9qAzHh7UXGvM+pMklfjNSNmhPNxkgKoz7tuX3um5prIollTa39GF0v7Y
	mcaeqF2d3vycbF84+9O1O4LCJlIVJTSWxH8x9f1VGERrTFLsvRrZ3qGwzTNtQOCPVpWI
	L9kA==
X-Received: by 10.152.88.103 with SMTP id bf7mr1694610lab.0.1390407423344;
	Wed, 22 Jan 2014 08:17:03 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.55.135 with HTTP; Wed, 22 Jan 2014 08:16:43 -0800 (PST)
In-Reply-To: <1390343512.874.124.camel@ted>
References: <1390343512.874.124.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 22 Jan 2014 09:16:43 -0700
X-Google-Sender-Auth: Db1_EAyzHJUzM1IOy_8k7sMXoPs
Message-ID: <CABcZANnuhcDYMcsrC=2NUxv9q=EqUYqK0uDqi+=bwE+0y71u4g@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Only attempt to print closest matching task if there is a match
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
X-List-Received-Date: Wed, 22 Jan 2014 16:17:03 -0000
Content-Type: multipart/alternative; boundary=001a11c367728fc59e04f0917475

--001a11c367728fc59e04f0917475
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 21, 2014 at 3:31 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> +            if len(matches):


Minor quibble, this could almost be considered an antipattern in python :)
Whenever you see yourself doing this, you're almost always better off
removing the len(). Python can test if a container is empty.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c367728fc59e04f0917475
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Jan 21, 2014 at 3:31 PM, Richard Purdie <span dir=3D"ltr">&lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.pu=
rdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f len(matches):</blockquote></div><br>Minor quibble, this could almost be c=
onsidered an antipattern in python :) Whenever you see yourself doing this,=
 you&#39;re almost always better off removing the len(). Python can test if=
 a container is empty.<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--001a11c367728fc59e04f0917475--
