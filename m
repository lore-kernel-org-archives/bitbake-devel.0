Return-Path: <yogesh.bit2006@gmail.com>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
	[209.85.214.176])
	by mail.openembedded.org (Postfix) with ESMTP id A7FC075658
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 13:10:46 +0000 (UTC)
Received: by obbnx5 with SMTP id nx5so73719354obb.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=xmaKMfnik2V/vpMm32RShS1m+DJ2xHKDQVizqePiKOk=;
	b=LyxMONIJBTT88j+guCRtradH4T/EQ1fV47Qd4V/hFDwAaZGjdkdthCjyeboRdCqeek
	eEXtxe6HeLnpuU/MzMlPNPwBsM26hEd7jC5zcw6rkzxCHUwxDRG7ZBTV26ukacUgVpBt
	8W7EmHtoTGhhOHm06CClniNei9dc2W/5vDZaccrBQoBLz3sTHPH9VU5uplxe8Dm114Yc
	8aGSbgOJWCBmsRrLO9aD+POivpwOLxwUG7ZIbLll/qfqjyEsBGsQ4S7Fr+Q3q4RWBIR4
	DEIHlp3BhmEqji2gzaHdMKcL3tNTXNz0EOmeHDBxzACLFbcBKkWQxvBh5eOhXzaCk0XF
	T8pA==
X-Received: by 10.182.130.135 with SMTP id oe7mr21818195obb.78.1432645847326; 
	Tue, 26 May 2015 06:10:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.211.143 with HTTP; Tue, 26 May 2015 06:10:27 -0700 (PDT)
From: Yogesh Tyagi <yogesh.bit2006@gmail.com>
Date: Tue, 26 May 2015 18:40:27 +0530
Message-ID: <CADL-HDgAGgapu7xNC9N0zMutZ8qOytSZv4+zNNUp04j5Bx8dSA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: gst-plugin-base libs not going to rootfs
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
X-List-Received-Date: Tue, 26 May 2015 13:10:49 -0000
Content-Type: multipart/alternative; boundary=089e012940dad1a66a0516fbda11

--089e012940dad1a66a0516fbda11
Content-Type: text/plain; charset=UTF-8

Hi,

I am using yocto 1.5 in my project. The problem is, gst-plugin-base
libraries are not going to rootfs in my build.

I have tried to write a bbappend file "gst-plugins-base_0.10.36.bbappend"
with below content:

S = "${WORKDIR}"

FILES_${PN} += " ${libdir}/gstreamer-0.10/*.so"
FILES_${PN}-dev += " ${libdir}/gstreamer-0.10/*.la
${libdir}/gstreamer-0.10/*.a"
FILES_${PN}-dbg += " ${libdir}/gstreamer-0.10/.debug/
${libexecdir}/gstreamer-0.10/.debug/"


do_install_append () {
         install -m 0755 ${S}/package/usr/lib/gstreamer-0.10/*
${D}${libdir}/gstreamer-0.10/
}

and I have also added "gst-plugin-base" to packagegroup bb file of my
project but still gst-plugins-base libs are not going to rootfs. Please
help.


Thanks,
Yogesh

--089e012940dad1a66a0516fbda11
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am using yocto 1.5 in my project.=
 The problem is, gst-plugin-base libraries are not going to rootfs in my bu=
ild.</div><div><br></div><div>I have tried to write a bbappend file &quot;g=
st-plugins-base_0.10.36.bbappend&quot; with below content:</div><div><br></=
div><div><div>S =3D &quot;${WORKDIR}&quot;</div><div><br></div><div>FILES_$=
{PN} +=3D &quot; ${libdir}/gstreamer-0.10/*.so&quot;</div><div>FILES_${PN}-=
dev +=3D &quot; ${libdir}/gstreamer-0.10/*.la ${libdir}/gstreamer-0.10/*.a&=
quot;</div><div>FILES_${PN}-dbg +=3D &quot; ${libdir}/gstreamer-0.10/.debug=
/ ${libexecdir}/gstreamer-0.10/.debug/&quot;</div><div><br></div><div><br><=
/div><div>do_install_append () {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0install -m 0755 ${S}/package/usr/lib/gstreamer-0.10/* =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ${D}${libdir}/gstreamer-0.10/</div><div>}</div></div><div><br></=
div><div>and I have also added &quot;gst-plugin-base&quot; to=C2=A0packageg=
roup bb file of my project but still gst-plugins-base libs are not going to=
 rootfs. Please help.</div><div><br></div><div><br></div><div>Thanks,</div>=
<div>Yogesh</div></div>

--089e012940dad1a66a0516fbda11--
