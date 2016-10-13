Return-Path: <nitishjha16@gmail.com>
Received: from mail-qt0-f169.google.com (mail-qt0-f169.google.com
	[209.85.216.169])
	by mail.openembedded.org (Postfix) with ESMTP id 9C0EF719CE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Oct 2016 11:57:25 +0000 (UTC)
Received: by mail-qt0-f169.google.com with SMTP id f6so41727109qtd.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Oct 2016 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=5rNJirws0Gzs/c8wBsWR9QY2ChDprUD65H27o0vYahI=;
	b=Eh6kKw/Mywaee4kJDoqXFI/bV9ESlfMtEde9roc46x7Il5Vm/rgX6YpPlV0+V1064c
	p4OA0sze/MdXqgP2WjVeisYta3vq6iLvvaBqyFuG0cmAC2yDJBpne/xbWM3C5P1a3sYZ
	coBMjsQS3MkLSUah3Z/nNL/RC2Ef3Vxtt4YEh6LATaQxZj1046+gxKJgpn1RsWhOv3Pj
	+Df4Bn3kxlc64Kng0Fj6/3cTCO0zzb+wmB0TenAppoiEBV30SWsKTX6lqcrlb1GiEKEw
	ZRaPd3bTXdMgsIP+BglSt6ev0Yz3lIT3QaO9ztNf+y2tM/i5thrIJlMa/FoODECJVqg3
	ZPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=5rNJirws0Gzs/c8wBsWR9QY2ChDprUD65H27o0vYahI=;
	b=JA05QjePXvEkpQVIgEbaCs0gz9bHUFPn49GjPFfz7auuFEPyggTsEeUI1Qr4FjluF6
	MMGJoslG20ZzPoNYIr2CrfghT8tmHcwadO/pgOf0PH87ZqvTXV80K/VaA/5ve8xMs6Ef
	Keos6eKgGfH0Nh9e2JB1ZC50Fpv2NZnmUG2AakE0qUL9OwiFsNcGAfjSehC3e3cKw6QE
	elZwnq77gnyJHLCvdF1WAKUo22viA6i8Me7pKmn+0iGLl3WSOhKyJvvBDWU7BhunHXMw
	2EbPSJspti2cCsNyjJ19K2TIlYqcOA9oce62o3KyJOy1mkeLI4HQ/+8068mwOZkFskwy
	wghg==
X-Gm-Message-State: AA6/9RlD0R7aqDq5GWkMMuMRpo1QgH4mf3G0CId34UfqDygXtGupS6xyYfNTDlMicbB868htS1r/ZH23RCxotQ==
X-Received: by 10.28.31.194 with SMTP id f185mr1866282wmf.24.1476359846640;
	Thu, 13 Oct 2016 04:57:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.131.200 with HTTP; Thu, 13 Oct 2016 04:57:26 -0700 (PDT)
In-Reply-To: <CAJTo0Lb2Wh9Godxx2tDOGxbpm3OjMzdnvmv_=Rt2N7z0vvqN2w@mail.gmail.com>
References: <CABh+foZtU_KQ0+2WUC0J=oef-EcbKHH60Fc+yDqGtW79Jc7tBQ@mail.gmail.com>
	<CAJTo0Lb2Wh9Godxx2tDOGxbpm3OjMzdnvmv_=Rt2N7z0vvqN2w@mail.gmail.com>
From: nitish jha <nitishjha16@gmail.com>
Date: Thu, 13 Oct 2016 13:57:26 +0200
Message-ID: <CABh+foZJcLBTQLLVU8a3axbOF+f+Die6ws15U-9B4s3L0PySFA@mail.gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: changing content of configuration parameters of Cmakelist file from .bb file
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
X-List-Received-Date: Thu, 13 Oct 2016 11:57:26 -0000
Content-Type: multipart/alternative; boundary=001a114b367c384509053ebdd03d

--001a114b367c384509053ebdd03d
Content-Type: text/plain; charset=UTF-8

Hello Ross,

Thanks for the help, it worked.

I need one more help, if you could.

I want to assign value to a variable in my recipe file by using awk command


do_configure_prepend() {

var_lib = awk -F '/'  '{$2}'  '${libdir}'
}


#EXTRA_OECMAKE += "-DEF_INSTALL_CMAKE_DIR:PATH=${var_lib}/cmake/vsomeip"

EXTRA_OECMAKE += "-DINSTALL_LIB_DIR:PATH=${var_lib}"

EXTRA_OECMAKE += "-DINSTALL_CMAKE_DIR:PATH=${var_lib}/cmake/vsomeip"




*here libdir = /usr/lib64.*

But when I compile it give me error while running command in do_configure
append

Do I need to inherit anything to run shell command through recipes.

Thanks and Regards

Nitish Jha


On Wed, Oct 12, 2016 at 5:23 PM, Burton, Ross <ross.burton@intel.com> wrote:

>
> On 12 October 2016 at 12:33, nitish jha <nitishjha16@gmail.com> wrote:
>
>> do_configure_append() {
>>     cmake -INSTALL_LIB_DIR=/usr/lib64
>> }
>>
>
> http://www.yoctoproject.org/docs/2.1/ref-manual/ref-
> manual.html#ref-classes-cmake covers this.
>
> Use EXTRA_OECMAKE to pass your extra options to cmake, i.e.
>
> EXTRA_OECMAKE = "-DINSTALL_LIB_DIR=${libdir}"
>
> Ross
>

--001a114b367c384509053ebdd03d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Ross,<div><br></div><div>Thanks for the help, it wor=
ked.</div><div><br></div><div>I need one more help, if you could.</div><div=
><br></div><div>I want to assign value to a variable in my recipe file by u=
sing awk command</div><div><br></div><div><div><br></div><div>do_configure_=
prepend() {</div><div><br></div><div><span class=3D"gmail-Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>var_lib =3D awk -F &#39;/&#39; =C2=A0&#39;=
{$2}&#39; =C2=A0&#39;${libdir}&#39;</div><div>}</div><div><br></div><div><b=
r></div><div>#EXTRA_OECMAKE +=3D &quot;-DEF_INSTALL_CMAKE_DIR:PATH=3D${var_=
lib}/cmake/vsomeip&quot;</div><div><br></div><div>EXTRA_OECMAKE +=3D &quot;=
-DINSTALL_LIB_DIR:PATH=3D${var_lib}&quot;</div><div><br></div><div>EXTRA_OE=
CMAKE +=3D &quot;-DINSTALL_CMAKE_DIR:PATH=3D${var_lib}/cmake/vsomeip&quot;<=
/div><div><br></div><div><br></div></div><div><br></div><div><br></div><div=
><b>here libdir =3D /usr/lib64.</b></div><div><br></div><div>But when I com=
pile it give me error while running command in do_configure append</div><di=
v><br></div><div>Do I need to inherit anything to run shell command through=
 recipes.</div><div><br></div><div>Thanks and Regards</div><div><br></div><=
div>Nitish Jha</div><div><br></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Wed, Oct 12, 2016 at 5:23 PM, Burton, Ross <span dir=
=3D"ltr">&lt;<a href=3D"mailto:ross.burton@intel.com" target=3D"_blank">ros=
s.burton@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 12 October 2016 at 12:33, nitish jha <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:nitishjha16@gmail.com" target=3D"_blank">nitishjha16@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-=
left-style:solid;padding-left:1ex"><div>do_configure_append() {
<br>=C2=A0=C2=A0=C2=A0 cmake -INSTALL_LIB_DIR=3D/usr/lib64
<br>}
</div></blockquote></div><br></div><div class=3D"gmail_extra"><a href=3D"ht=
tp://www.yoctoproject.org/docs/2.1/ref-manual/ref-manual.html#ref-classes-c=
make" target=3D"_blank">http://www.yoctoproject.org/<wbr>docs/2.1/ref-manua=
l/ref-<wbr>manual.html#ref-classes-cmake</a> covers this.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Use EXTRA_OECMAKE to =
pass your extra options to cmake, i.e.</div><div class=3D"gmail_extra"><br>=
</div><div class=3D"gmail_extra">EXTRA_OECMAKE =3D &quot;-DINSTALL_LIB_DIR=
=3D${libdir}&quot;</div><span class=3D"HOEnZb"><font color=3D"#888888"><div=
 class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</div></fon=
t></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>
</div></div>

--001a114b367c384509053ebdd03d--
