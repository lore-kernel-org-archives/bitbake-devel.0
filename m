Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
	[209.85.214.173])
	by mail.openembedded.org (Postfix) with ESMTP id 97D3465C63
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jun 2015 19:24:52 +0000 (UTC)
Received: by obew15 with SMTP id w15so16196472obe.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Jun 2015 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=GRcfYeG5tbagCgXGOc7yCY8hz4RaZKz8apFinKiMwMs=;
	b=bfe5mInwpA65wZk94dh2rOjDSiVSI6jHVCUgfreBDRzrNESjepoHX07USxOFxCxflh
	s/kCLriqTDbMKzNksOO+oANuiYxykynqI2798xCK0MlLnOdoLMUzke9HWoE3Sq/k8toT
	6KnjeB2b5dTXS1+8cGJYp8soG85cnzNQkLsAPRNHsLYOEeT3SQoU8r4zwfYqVzj17Wgw
	+VVK/rahO75cn9soE3dkaOTbfj0IItmZNVXAPzjyTGod3qej8HJLNY8cBB4AMjALdEK8
	V42+mZXh3VjQJqOa2U/Pbclwh6CSaru/jiUClFAk4v36f9jTih8ht6ufcERLBnZ0UxNM
	k0dQ==
X-Received: by 10.202.84.143 with SMTP id i137mr27027434oib.114.1433359494178; 
	Wed, 03 Jun 2015 12:24:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.211.143 with HTTP; Wed, 3 Jun 2015 12:24:33 -0700 (PDT)
In-Reply-To: <CAJTo0LYHok7aqeq5VG-bBq6L=tge_k40i2urOPp9=KWvLf894w@mail.gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
	<CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
	<CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
	<CADL-HDjq9+Q7+FDHvsCsK_u2K1ygmn_410jF0aF9kAaDg3hf4A@mail.gmail.com>
	<CAJTo0LYHok7aqeq5VG-bBq6L=tge_k40i2urOPp9=KWvLf894w@mail.gmail.com>
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Thu, 4 Jun 2015 00:54:33 +0530
Message-ID: <CADL-HDiPMeR7zdiW99j10TEAhjzUzaqzQkMLnvOWiqdSfPRMHA@mail.gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Wed, 03 Jun 2015 19:24:55 -0000
Content-Type: multipart/alternative; boundary=001a113debb87c6cb70517a20355

--001a113debb87c6cb70517a20355
Content-Type: text/plain; charset=UTF-8

Hi,

If I remove
FILES_${PN}-dev += "${libdir}/gstreamer-0.10/"

I get this error:

ERROR: QA Issue: non -dev/-dbg/-nativesdk package contains symlink .so:
gst-plugin-linux-user path
'/work/core2-32-poky-linux/gst-plugin-linux-user/git+master-r0/packages-split/gst-plugin-linux-user/lib/gstreamer-0.10/libgstfl.so'
ERROR: QA run found fatal errors. Please consider fixing them.
ERROR: Function failed: do_package_qa
ERROR: Logfile of failure stored in:
/media/git/yocto/yogesh/build/tmp/work/core2-32-poky-linux/gst-plugin-linux-user/git+master-r0/temp/log.do_package.26194
ERROR: Task 3193
(/media/sdb/git/yocto/yogesh/yocto/meta-ce/recipes-ce/gst-plugin/
gst-plugin-linux-user.bb, do_package) failed with exit code '1'

Thanks,
Yogesh


On Thu, Jun 4, 2015 at 12:47 AM, Burton, Ross <ross.burton@intel.com> wrote:

>
> On 3 June 2015 at 20:07, Yogesh Tyagi <yogesh.bit2006@gmail.com> wrote:
>
>> WARNING: QA Issue: gst-plugin-linux-user: Files/directories were
>> installed but not shipped
>>   /lib/gstreamer-0.10
>>   /lib/gstreamer-0.10/libgst................
>>
>> so I have added these lines to bb file:
>>
>> FILES_${PN} += "${libdir}/gstreamer-0.10/"
>> FILES_${PN}-dbg += "${libdir}/gstreamer-0.10/.debug"
>> FILES_${PN}-dev += "${libdir}/gstreamer-0.10/"
>>
>> Now library is not going to rootfs at all and no Warning is there.
>> Earlier it was installing to "/lib" in rootfs. I want the lib to install to
>> "/usr/lib/gstreamer-0.10" in rootfs. Please provide your suggestions.
>>
>
> Remove FILES_PN-dev, there's nothing in that directory that makes sense in
> the context of development and as PN-dev is packaged before PN all your
> files are in that package.
>
> Ross
>

--001a113debb87c6cb70517a20355
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>If I remove=C2=A0</div><=
div><span style=3D"color:rgb(80,0,80);font-size:12.8000001907349px">FILES_$=
{PN}-dev +=3D &quot;${libdir}/gstreamer-0.10/&quot;</span></div><div><br></=
div><div>I get this error:</div><div><br></div><div>ERROR: QA Issue: non -d=
ev/-dbg/-nativesdk package contains symlink .so: gst-plugin-linux-user path=
 &#39;/work/core2-32-poky-linux/gst-plugin-linux-user/git+master-r0/package=
s-split/gst-plugin-linux-user/lib/gstreamer-0.10/libgstfl.so&#39;</div><div=
>ERROR: QA run found fatal errors. Please consider fixing them.<br></div><d=
iv>ERROR: Function failed: do_package_qa</div><div>ERROR: Logfile of failur=
e stored in: /media/git/yocto/yogesh/build/tmp/work/core2-32-poky-linux/gst=
-plugin-linux-user/git+master-r0/temp/log.do_package.26194</div><div>ERROR:=
 Task 3193 (/media/sdb/git/yocto/yogesh/yocto/meta-ce/recipes-ce/gst-plugin=
/<a href=3D"http://gst-plugin-linux-user.bb">gst-plugin-linux-user.bb</a>, =
do_package) failed with exit code &#39;1&#39;</div><div><br></div><div>Than=
ks,</div><div>Yogesh</div><div><br></div></div><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">On Thu, Jun 4, 2015 at 12:47 AM, Burton, Ross=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:ross.burton@intel.com" target=3D"_=
blank">ross.burton@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div dir=3D"ltr"><span class=3D""><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">On 3 June 2015 at 20:07, Yogesh Tyagi <span dir=
=3D"ltr">&lt;<a href=3D"mailto:yogesh.bit2006@gmail.com" target=3D"_blank">=
yogesh.bit2006@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div><div><span style=3D"font-size:12.8000001907349px">WARNING: QA Is=
sue: gst-plugin-linux-user: Files/directories were installed but not shippe=
d</span></div><div><span style=3D"font-size:12.8000001907349px">=C2=A0 /lib=
/gstreamer-0.10</span></div><div><span style=3D"font-size:12.8000001907349p=
x">=C2=A0 /lib/gstreamer-0.10/libgst................</span></div></div><div=
><span style=3D"font-size:12.8000001907349px"><br></span></div><div><span s=
tyle=3D"font-size:12.8000001907349px">so I have added these lines to bb fil=
e:</span></div><div><span style=3D"font-size:12.8000001907349px"><br></span=
></div><div><span><div>FILES_${PN} +=3D &quot;${libdir}/gstreamer-0.10/&quo=
t;</div><div>FILES_${PN}-dbg +=3D &quot;${libdir}/gstreamer-0.10/.debug&quo=
t;</div></span><div>FILES_${PN}-dev +=3D &quot;${libdir}/gstreamer-0.10/&qu=
ot;</div><div><br></div><div>Now library is not going to rootfs at all and =
no Warning is there. Earlier it was installing to &quot;/lib&quot; in rootf=
s. I want the lib to install to &quot;/usr/lib/gstreamer-0.10&quot; in root=
fs. Please provide your suggestions.</div></div></blockquote></div><br></di=
v></span><div class=3D"gmail_extra">Remove FILES_PN-dev, there&#39;s nothin=
g in that directory that makes sense in the context of development and as P=
N-dev is packaged before PN all your files are in that package.</div><span =
class=3D"HOEnZb"><font color=3D"#888888"><div class=3D"gmail_extra"><br></d=
iv><div class=3D"gmail_extra">Ross</div></font></span></div>
</blockquote></div><br></div>

--001a113debb87c6cb70517a20355--
