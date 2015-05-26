Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id BC11665D6E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 15:40:09 +0000 (UTC)
Received: by paza2 with SMTP id a2so86336107paz.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:mime-version:to:from:subject:date:in-reply-to:references
	:content-type; bh=28QgrTHpoB40VjDWob+u/Qb1egtAHr3mE97tEA6iGWw=;
	b=ZxSRfX+ZXV8v87JkHY8jR+yWKx77R6/hZo43/YP9e1YCS9KvJFZ2jNBw2vgzO9v3wH
	b+ySjtHSmyOIQtUByVPKpLmT6IAupiNrVOs3ghoQl81Hh/tUADvlR8jzn5XCFfJ/Yw5x
	faXoh9/akGEc+Tbv6A6XdmWJYk/SJeTaPoncINIm3Z5TmwQEox6OTG/a+d1DwfHCEhh9
	pqKiibgSO3pcyR9oCdegh3g8c1ggrLLUkRohBcbbFj6GhHe2ygEQ/i+agCu7tNQmnkUS
	J8HFt9ZNsL+gk5KXs/nuRTxO4u1Inu9ZVwwJs4OTPNZV2T5WN7ZUxEke3QDUzfSn29vJ
	dtQw==
X-Received: by 10.70.87.195 with SMTP id ba3mr50533274pdb.154.1432654810867;
	Tue, 26 May 2015 08:40:10 -0700 (PDT)
Received: from [192.168.1.3] ([117.205.88.23]) by mx.google.com with ESMTPSA id
	pp6sm13426150pbb.17.2015.05.26.08.40.06
	for <bitbake-devel@lists.openembedded.org>
	(version=SSLv3 cipher=RC4-SHA bits=128/128);
	Tue, 26 May 2015 08:40:08 -0700 (PDT)
Message-ID: <556493d8.2687440a.0ded.66ab@mx.google.com>
MIME-Version: 1.0
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Tue, 26 May 2015 21:10:06 +0530
In-Reply-To: <CAJTo0LbbmGMuDXKJcqg+QPnzT-EcPQoTRViYRVxnTEHXvs+rXA@mail.gmail.com>
References: <CADL-HDgAGgapu7xNC9N0zMutZ8qOytSZv4+zNNUp04j5Bx8dSA@mail.gmail.com>
	<CAJTo0LbbmGMuDXKJcqg+QPnzT-EcPQoTRViYRVxnTEHXvs+rXA@mail.gmail.com>
Subject: Re: gst-plugin-base libs not going to rootfs
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
X-List-Received-Date: Tue, 26 May 2015 15:40:11 -0000
Content-Type: multipart/alternative;
	boundary="_6BB292E0-2D7E-4804-9262-321EDF555059_"

--_6BB292E0-2D7E-4804-9262-321EDF555059_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Ross,

Thanks for replying. I have checked that when gst-plugins-base is build, it=
 contains complete source and all the libraries are also getting created. H=
ow come this is an empty package?       =20
How do I know it's an empty package? I am a novice in bitbake/yocto.

Thanks,
Yogesh

-----Original Message-----
From: "Burton, Ross" <ross.burton@intel.com>
Sent: =E2=80=8E26/=E2=80=8E05/=E2=80=8E2015 07:52 PM
To: "Yogesh Tyagi" <yogesh.bit2006@gmail.com>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] gst-plugin-base libs not going to rootfs



On 26 May 2015 at 14:10, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:

and I have also added "gst-plugin-base" to packagegroup bb file of my proje=
ct but still gst-plugins-base libs are not going to rootfs. Please help.

gst-plugins-base is an empty package.  If you want all plugins. install gst=
-plugins-base-meta.


Ross=

--_6BB292E0-2D7E-4804-9262-321EDF555059_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body><div><div style=3D"font-family: Calibri,sans-serif; =
font-size: 11pt;">Hi Ross,<br><br>Thanks for replying. I have checked that =
when gst-plugins-base is build, it contains complete source and all the lib=
raries are also getting created. How come this is an empty package?&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>How do I know it's an empty package?=
 I am a novice in bitbake/yocto.<br><br>Thanks,<br>Yogesh</div></div><div d=
ir=3D"ltr"><hr><span style=3D"font-family: Calibri,sans-serif; font-size: 1=
1pt; font-weight: bold;">From: </span><span style=3D"font-family: Calibri,s=
ans-serif; font-size: 11pt;"><a href=3D"mailto:ross.burton@intel.com">Burto=
n, Ross</a></span><br><span style=3D"font-family: Calibri,sans-serif; font-=
size: 11pt; font-weight: bold;">Sent: </span><span style=3D"font-family: Ca=
libri,sans-serif; font-size: 11pt;">=E2=80=8E26/=E2=80=8E05/=E2=80=8E2015 0=
7:52 PM</span><br><span style=3D"font-family: Calibri,sans-serif; font-size=
: 11pt; font-weight: bold;">To: </span><span style=3D"font-family: Calibri,=
sans-serif; font-size: 11pt;"><a href=3D"mailto:yogesh.bit2006@gmail.com">Y=
ogesh Tyagi</a></span><br><span style=3D"font-family: Calibri,sans-serif; f=
ont-size: 11pt; font-weight: bold;">Cc: </span><span style=3D"font-family: =
Calibri,sans-serif; font-size: 11pt;"><a href=3D"mailto:bitbake-devel@lists=
.openembedded.org">bitbake-devel</a></span><br><span style=3D"font-family: =
Calibri,sans-serif; font-size: 11pt; font-weight: bold;">Subject: </span><s=
pan style=3D"font-family: Calibri,sans-serif; font-size: 11pt;">Re: [bitbak=
e-devel] gst-plugin-base libs not going to rootfs</span><br><br></div><div =
dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 26=
 May 2015 at 14:10, Yogesh Tyagi <span dir=3D"ltr">&lt;<a href=3D"mailto:yo=
gesh.bit2006@gmail.com" target=3D"_blank">yogesh.bit2006@gmail.com</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px=
 0px 0.8ex; padding-left: 1ex; border-left-color: rgb(204, 204, 204); borde=
r-left-width: 1px; border-left-style: solid;"><div>and I have also added "g=
st-plugin-base" to&nbsp;packagegroup bb file of my project but still gst-pl=
ugins-base libs are not going to rootfs. Please help.</div><div></div></blo=
ckquote></div><br>gst-plugins-base is an empty package.&nbsp; If you want a=
ll plugins. install gst-plugins-base-meta.</div><div class=3D"gmail_extra">=
<br></div><div class=3D"gmail_extra">Ross</div></div>=0A=
</body></html>=

--_6BB292E0-2D7E-4804-9262-321EDF555059_--
