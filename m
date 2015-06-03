Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
	[209.85.214.182])
	by mail.openembedded.org (Postfix) with ESMTP id 5A3C9757FA
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 15:37:35 +0000 (UTC)
Received: by objn8 with SMTP id n8so10829980obj.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=zAjBJb7mIvL/P4Cqu+RYT9DZX77S9xfugy4WXXp5j/c=;
	b=I+DLhh1ew0WK4HFlZOPLjWXbQGg7Hru/rHCsrTApP+uhP1PFLxx1LN3vbYh1GEqljf
	fKCq6ziUspiw88gwiFDbjk8w/a1URV52tFgjO7rN6H/3L8/VlR+XUXyXVvBkpjLoFtYS
	t/Y9mDHlbRCGjyFwzc1qTIBFyJLXu0ShrBjjnkyPk86eNZA5MX0rscN9p1zVEkQMALDB
	R/JACir7RpbxLfSg3GZMUWuC6aMSKLjOXXreMb1gt1/I9ERbDCGvvC74vZmPUXii9UQx
	s+HjByUHM1hq/fawKmNAFSIMMbsQHgRWT4p6hazMnFMQL85YmOx+ga5C77IF1Krro1Yt
	LAsg==
X-Received: by 10.182.130.135 with SMTP id oe7mr28336492obb.78.1433345856906; 
	Wed, 03 Jun 2015 08:37:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.211.143 with HTTP; Wed, 3 Jun 2015 08:37:16 -0700 (PDT)
In-Reply-To: <CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Wed, 3 Jun 2015 21:07:16 +0530
Message-ID: <CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Library not getting installed to intended path
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
X-List-Received-Date: Wed, 03 Jun 2015 15:37:36 -0000
Content-Type: multipart/alternative; boundary=089e012940daa42b3505179ed6a9

--089e012940daa42b3505179ed6a9
Content-Type: text/plain; charset=UTF-8

Hi,

I have added these two lines to my Makefile.am:

AC_PREFIX_DEFAULT(/usr/lib/gstreamer-0.10)
libdir='/usr/lib/gstreamer-0.10'

and following lines to bb file:

FILES_${PN} += "${libdir}/gstreamer-0.10/"
FILES_${PN}-dbg += "${libdir}/gstreamer-0.10/.debug"


do_install() {
  install -D -m 0755 ${S}/*.so* ${D}/{libdir}/gstreamer-0.10/
}

when rootfs is created I am getting QA warning:

WARNING: QA Issue: fsmd-gst-plugin-linux-user: Files/directories were
installed but not shipped
  /usr/lib
  /usr/lib/gstreamer-0.10
  /usr/lib/gstreamer-0.10/libgstflt.so

and libs are not going to rootfs.

Thanks,
Yogesh

On Wed, Jun 3, 2015 at 7:16 PM, Burton, Ross <ross.burton@intel.com> wrote:

>
> On 3 June 2015 at 13:16, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:
>
>> I am using yocto 1.6 and I have written a component and written bitbake
>> recipe file for this component. When rootfs is created my library is found
>> in "/lib" directory but I want it to be installed to
>> "/usr/lib/gstreamer-0.10" directory (which is already created by open
>> source gstreamer packages).
>
>
> This is under the control of your makefiles, so you'll need to share
> those.  My guess is that you're using a variable name in the makefile that
> has a defined meaning in automake so your assignment gets overridden.
>
> (also, this isn't anything to do with development of bitbake, so this
> discussion should be on yocto@)
>
> Ross
>

--089e012940daa42b3505179ed6a9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I have added these two lines to my =
Makefile.am:</div><div><br></div><div><div>AC_PREFIX_DEFAULT(/usr/lib/gstre=
amer-0.10)</div><div>libdir=3D&#39;/usr/lib/gstreamer-0.10&#39;</div></div>=
<div><br></div><div>and following lines to bb file:</div><div><br></div><di=
v><div>FILES_${PN} +=3D &quot;${libdir}/gstreamer-0.10/&quot;</div><div>FIL=
ES_${PN}-dbg +=3D &quot;${libdir}/gstreamer-0.10/.debug&quot;</div><div><br=
></div><div><br></div><div>do_install() {</div><div>=C2=A0 install -D -m 07=
55 ${S}/*.so* ${D}/{libdir}/gstreamer-0.10/</div><div>}</div></div><div><br=
></div><div>when rootfs is created I am getting QA warning:</div><div><br><=
/div><div><div>WARNING: QA Issue: fsmd-gst-plugin-linux-user: Files/directo=
ries were installed but not shipped</div><div>=C2=A0 /usr/lib</div><div>=C2=
=A0 /usr/lib/gstreamer-0.10</div><div>=C2=A0 /usr/lib/gstreamer-0.10/libgst=
flt.so</div><div><br></div></div><div>and libs are not going to rootfs.</di=
v><div><br></div><div>Thanks,</div><div>Yogesh</div></div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Wed, Jun 3, 2015 at 7:16 PM, Bu=
rton, Ross <span dir=3D"ltr">&lt;<a href=3D"mailto:ross.burton@intel.com" t=
arget=3D"_blank">ross.burton@intel.com</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote"><span class=3D"">On 3 June 2015 at 13:16, Yogesh Tyagi =
<span dir=3D"ltr">&lt;<a href=3D"mailto:yogesh.bit2006@gmail.com" target=3D=
"_blank">yogesh.bit2006@gmail.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">I am using yocto 1.6 and I have written a component and writ=
ten bitbake recipe file for this component. When rootfs is created my libra=
ry is found in &quot;/lib&quot; directory but I want it to be installed to =
&quot;/usr/lib/gstreamer-0.10&quot; directory (which is already created by =
open source gstreamer packages).</blockquote><div><br></div></span><div>Thi=
s is under the control of your makefiles, so you&#39;ll need to share those=
.=C2=A0 My guess is that you&#39;re using a variable name in the makefile t=
hat has a defined meaning in automake so your assignment gets overridden.</=
div><div><br></div><div>(also, this isn&#39;t anything to do with developme=
nt of bitbake, so this discussion should be on yocto@)</div><span class=3D"=
HOEnZb"><font color=3D"#888888"><div><br></div><div>Ross</div></font></span=
></div></div></div>
</blockquote></div><br></div>

--089e012940daa42b3505179ed6a9--
