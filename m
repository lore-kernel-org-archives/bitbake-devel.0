Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
	[209.85.218.53])
	by mail.openembedded.org (Postfix) with ESMTP id C6A8565C63
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 19:07:20 +0000 (UTC)
Received: by oihb142 with SMTP id b142so14804816oih.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=qaWBkGlMPuAUpOJq19CZLudKSS/I2e9ssVSrwT4YZk0=;
	b=NIJ8MfaGiY9QRk3+/4duJeg9UZXnUwZAdmoY71sKRXkOC9X9Z7vq/K22JF+diO6LMU
	NIs6JcsG95+TKHBdOleBIwTUUhEhhJiNWXbszvE0Y4Mo9IBJfrgq2QGeB4oUoSxYBbe5
	Zdi4yp4ShzlnjofJYKCxD3frvApXIuxfCYQ8VYKvViR0g+1+hrLIaJyVOChV8tKnnLqF
	LMewPPQFy+7ENEWo445mDcYNJ5DGvWezQYYLlJc3YtnFC6aUdjcecy/QcfzzP7nszk2i
	QB7Xp46SBYYAHizaoIhH7rL+tP/K+odEd3Zx6XOJuQ+Zo/mvx3XoRPIP3aHu7iJdGNDo
	glZQ==
X-Received: by 10.182.130.135 with SMTP id oe7mr29128704obb.78.1433358442028; 
	Wed, 03 Jun 2015 12:07:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.211.143 with HTTP; Wed, 3 Jun 2015 12:07:01 -0700 (PDT)
In-Reply-To: <CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
	<CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
	<CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Thu, 4 Jun 2015 00:37:01 +0530
Message-ID: <CADL-HDjq9+Q7+FDHvsCsK_u2K1ygmn_410jF0aF9kAaDg3hf4A@mail.gmail.com>
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
X-List-Received-Date: Wed, 03 Jun 2015 19:07:22 -0000
Content-Type: multipart/alternative; boundary=089e012940dac5e5fc0517a1c498

--089e012940dac5e5fc0517a1c498
Content-Type: text/plain; charset=UTF-8

Hi,

I have added

gstlibdir=$(libdir)/gstreamer-0.10

gstlib_LTLIBRARIES = ....

to my Makefile.am

and removed overiding do_install() from bb file.

While creating roots ,my package was throwing QA warning

WARNING: QA Issue: gst-plugin-linux-user: Files/directories were installed
but not shipped
  /lib/gstreamer-0.10
  /lib/gstreamer-0.10/libgst................

so I have added these lines to bb file:

FILES_${PN} += "${libdir}/gstreamer-0.10/"
FILES_${PN}-dbg += "${libdir}/gstreamer-0.10/.debug"
FILES_${PN}-dev += "${libdir}/gstreamer-0.10/"

Now library is not going to rootfs at all and no Warning is there. Earlier
it was installing to "/lib" in rootfs. I want the lib to install to
"/usr/lib/gstreamer-0.10" in rootfs. Please provide your suggestions.

Thanks,
Yogesh




On Wed, Jun 3, 2015 at 10:26 PM, Burton, Ross <ross.burton@intel.com> wrote:

>
> On 3 June 2015 at 16:37, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:
>
>> AC_PREFIX_DEFAULT(/usr/lib/gstreamer-0.10)
>> libdir='/usr/lib/gstreamer-0.10'
>>
>
> Yeah, don't do that.  Do this instead:
>
> gstlibdir = $(libdir)/gstreamer-0.10
> gstlib_LTLIBRARIES = ...
>
> You don't need to override do_install as automake's install will do the
> right thing if you inherit autotools.
>
> Ross
>

--089e012940dac5e5fc0517a1c498
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I have added=C2=A0</div><div><br></=
div><div><div>gstlibdir=3D$(libdir)/gstreamer-0.10</div><div><br></div><div=
>gstlib_LTLIBRARIES =3D ....</div></div><div><br></div><div>to my Makefile.=
am</div><div><br></div><div>and removed overiding=C2=A0<span style=3D"font-=
size:12.8000001907349px">do_install() from bb file.</span></div><div><span =
style=3D"font-size:12.8000001907349px"><br></span></div><div><span style=3D=
"font-size:12.8000001907349px">While creating roots ,my package was throwin=
g QA warning</span></div><div><span style=3D"font-size:12.8000001907349px">=
<br></span></div><div><div style><span style=3D"font-size:12.8000001907349p=
x">WARNING: QA Issue: gst-plugin-linux-user: Files/directories were install=
ed but not shipped</span></div><div style><span style=3D"font-size:12.80000=
01907349px">=C2=A0 /lib/gstreamer-0.10</span></div><div style><span style=
=3D"font-size:12.8000001907349px">=C2=A0 /lib/gstreamer-0.10/libgst........=
........</span></div></div><div style><span style=3D"font-size:12.800000190=
7349px"><br></span></div><div style><span style=3D"font-size:12.80000019073=
49px">so I have added these lines to bb file:</span></div><div style><span =
style=3D"font-size:12.8000001907349px"><br></span></div><div style><div>FIL=
ES_${PN} +=3D &quot;${libdir}/gstreamer-0.10/&quot;</div><div>FILES_${PN}-d=
bg +=3D &quot;${libdir}/gstreamer-0.10/.debug&quot;</div><div>FILES_${PN}-d=
ev +=3D &quot;${libdir}/gstreamer-0.10/&quot;</div><div><br></div><div>Now =
library is not going to rootfs at all and no Warning is there. Earlier it w=
as installing to &quot;/lib&quot; in rootfs. I want the lib to install to &=
quot;/usr/lib/gstreamer-0.10&quot; in rootfs. Please provide your suggestio=
ns.</div><div><br></div><div>Thanks,</div><div>Yogesh</div></div><div style=
><span style=3D"font-size:12.8000001907349px"><br></span></div><div style><=
span style=3D"font-size:12.8000001907349px"><br></span></div><div><br></div=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Ju=
n 3, 2015 at 10:26 PM, Burton, Ross <span dir=3D"ltr">&lt;<a href=3D"mailto=
:ross.burton@intel.com" target=3D"_blank">ross.burton@intel.com</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On 3 June 2015 at 16:37, Yoges=
h Tyagi <span dir=3D"ltr">&lt;<a href=3D"mailto:yogesh.bit2006@gmail.com" t=
arget=3D"_blank">yogesh.bit2006@gmail.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><div>AC_PREFIX_DEFAULT(/usr/lib/gstreamer-0.10)</div=
><div>libdir=3D&#39;/usr/lib/gstreamer-0.10&#39;</div></blockquote></div><b=
r>Yeah, don&#39;t do that.=C2=A0 Do this instead:</div><div class=3D"gmail_=
extra"><br></div><div class=3D"gmail_extra">gstlibdir =3D $(libdir)/gstream=
er-0.10</div><div class=3D"gmail_extra">gstlib_LTLIBRARIES =3D ...</div><di=
v class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">You don&#39;t =
need to override do_install as automake&#39;s install will do the right thi=
ng if you inherit autotools.</div><span class=3D"HOEnZb"><font color=3D"#88=
8888"><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross<=
/div></font></span></div>
</blockquote></div><br></div>

--089e012940dac5e5fc0517a1c498--
