Return-Path: <kergoth@gmail.com>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
	[209.85.216.182])
	by mail.openembedded.org (Postfix) with ESMTP id EA18E73CF8
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Apr 2015 22:04:56 +0000 (UTC)
Received: by qcrf4 with SMTP id f4so84485437qcr.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Apr 2015 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=4VUUXE0gB+kAvP+pXtEuESUYIA1nVaJ664fz5YLMPmw=;
	b=GC+rvjbZuMvUgQ1zPqHSzN+Omcf+4AoharJ/1ldCZ4b8i//aTaIE0S23QGhCG2b4Jo
	vJQl9vcErTXZfqumyHF28jGytqNTbnJP9l/5sOc2yB7pSQCfhAe/z0kldb9fnQORGW4y
	IEEIioVY6IR6RchwRRap+t57lu1jemqi2RDDEWguoGOFKO6Idaae9nBXXbkODCzsx2rb
	xhH6ZFUDIHBVS4NIlE5P4SOG3Hrnqh9lMFMwRIFE4h7CqJ3gYy8kDccyEjyLviNafrFs
	f8o/wKvvqlAIdIy25/QO6yxe/8LATw9MskeUdBPTP9tzKNBXUIFzHVrdsUsTAmrmhArG
	B/wg==
X-Received: by 10.55.43.220 with SMTP id r89mr8080580qkr.27.1428098697634;
	Fri, 03 Apr 2015 15:04:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.108.34 with HTTP; Fri, 3 Apr 2015 15:04:36 -0700 (PDT)
In-Reply-To: <1428098626-1947-1-git-send-email-kergoth@gmail.com>
References: <1428098626-1947-1-git-send-email-kergoth@gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 3 Apr 2015 15:04:36 -0700
Message-ID: <CABcZANm+Gy8LRzgZG2N74MXvKdx=L6V=Rvu1LzyfB5jWxkfxGg@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: bin/image-writer: Add ext4 as a deployable image type
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
X-List-Received-Date: Fri, 03 Apr 2015 22:04:57 -0000
Content-Type: multipart/alternative; boundary=001a1149442c93a9320512d92385

--001a1149442c93a9320512d92385
Content-Type: text/plain; charset=UTF-8

On Fri, Apr 3, 2015 at 3:03 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> This is particularly problematic since qemu images switched to ext4 by
> default and now cannot work properly with UIs like hob.
>
> This patch adds in ext4 to the appropriate variable fixing this.
>
> [YOCTO #7426]
>
> (Bitbake rev: a1431b1b85bf90ed5f771552d0ce91de288047d4)
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Er, ignore this, accidentally ran send-email in the wrong repo :P


-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1149442c93a9320512d92385
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Apr 3, 2015 at 3:03 PM, Christopher Larson <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1h3" class=
=3D"a3s" style=3D"overflow:hidden">From: Richard Purdie &lt;<a href=3D"mail=
to:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</=
a>&gt;<br>
<br>
This is particularly problematic since qemu images switched to ext4 by<br>
default and now cannot work properly with UIs like hob.<br>
<br>
This patch adds in ext4 to the appropriate variable fixing this.<br>
<br>
[YOCTO #7426]<br>
<br>
(Bitbake rev: a1431b1b85bf90ed5f771552d0ce91de288047d4)<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></blockquote><=
/div><br>Er, ignore this, accidentally ran send-email in the wrong repo :P<=
br><br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_signature"><=
div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder -=
 BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software=
 Engineer, Mentor Graphics</div></div>
</div></div>

--001a1149442c93a9320512d92385--
