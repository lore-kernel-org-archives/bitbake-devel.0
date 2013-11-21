Return-Path: <uvbapat@gmail.com>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
	[209.85.215.49])
	by mail.openembedded.org (Postfix) with ESMTP id ADBE960B60
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2013 15:45:03 +0000 (UTC)
Received: by mail-la0-f49.google.com with SMTP id er20so8462774lab.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2013 07:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=u1GSP/Crr/JgSIuI8q67owEBXOpoayZaAlDQDRd1o2A=;
	b=QEHc84sJZBRXswHcesVYo8fymbIQ6gM7DUPVzm/2OPZOW8VF4NP3YPFZJxxaeRDItB
	zbAkGnZdNey42lckF5wjsVcDesdCVidwFX15g5kPjVEOSY9CTf9dsl2S7mnI6k2vidpR
	Nl3vXXfAIb7VYfQaFlbICrQhzRJ2W9X+p4m6E05T7EI64lpCDP1JSnKKur0GzNwVcSeA
	jPYQq22AC9cYiSsAGrNfHFtgb6XbztUpeZNxfhiYVmnmPS0bFDPv1IGGYHKvrnox/RH3
	iZfXwhYFEeZQ+YxeS7Xhhk4ZqC3EZZbqx2kRbF1HHP2bqCOPfewLcCc3/yb5wcXQCtWv
	QJGQ==
MIME-Version: 1.0
X-Received: by 10.152.88.46 with SMTP id bd14mr105189lab.59.1385048702322;
	Thu, 21 Nov 2013 07:45:02 -0800 (PST)
Received: by 10.112.35.129 with HTTP; Thu, 21 Nov 2013 07:45:02 -0800 (PST)
Date: Thu, 21 Nov 2013 10:45:02 -0500
Message-ID: <CAJ7NSKpQnuc9gco8UnrMxoJ7=5TQbCtu9bkzhobxnuB6WzM3jg@mail.gmail.com>
From: Udayan Bapat <uvbapat@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Doing 'oerunmake configure' verses just 'configure'
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
X-List-Received-Date: Thu, 21 Nov 2013 15:45:04 -0000
Content-Type: multipart/alternative; boundary=001a11c351b6e60a9304ebb1c7e8

--001a11c351b6e60a9304ebb1c7e8
Content-Type: text/plain; charset=ISO-8859-1

Hi all

I am trying to build a custom recipe that heavily relies on autotools. Due
to some hierarchy (one package building other), I am not able to call
'oe_runmake configure' and 'oe_runmake make' directly from the .bb file.
Instead I manually cd into that directory and then issue ./configure
followed by 'make'

It seems when I try that it is failing on  -

|
/ADT/opensource/poky/build/tmp/sysroots/x86_64-linux/usr/share/automake-1.12/am/
ltlibrary.am: archiver requires 'AM_PROG_AR' in 'configure.ac'
|
| autoreconf: automake failed with exit status: 1

If I try to update configure.ac with -

+AC_CONFIG_MACRO_DIR([m4])
+AM_PROG_AR

then I hit this error -

 aclocal.m4:86: AC_LIBTOOL_SETUP is expanded from...
| aclocal.m4:66: _AC_PROG_LIBTOOL is expanded from...
| aclocal.m4:31: AC_PROG_LIBTOOL is expanded from...
| configure.ac:25: the top level
| configure.ac:19: error: possibly undefined macro: AM_PROG_AR
|       If this token and others are legitimate, please use
m4_pattern_allow.

Yocto uses automake 1.12.6 so I know it supports AM_PROG_AR



However, if I separate out the package and build it separately with
oe_runmake * it works correctly. It seems when I run manually, it is
skipping some steps (such as running aclocal may be?) so the package runs
into tool incompatibility issues.

Where can I find the script that runs oerunmake configure? Also what can be
done to allow manually ./configure and make? Is there any place where I can
see any guidelines about what care needs to be taken while using manual
build options?

Thanks
Udayan

--001a11c351b6e60a9304ebb1c7e8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><br></div>Hi all<br><br>I am trying to=
 build a custom recipe that heavily relies on autotools. Due to some hierar=
chy (one package building other), I am not able to call &#39;oe_runmake con=
figure&#39; and &#39;oe_runmake make&#39; directly from the .bb file. Inste=
ad I manually cd into that directory and then issue ./configure followed by=
 &#39;make&#39;<br>
<br></div>It seems when I try that it is failing on=A0 - <br><br>| /ADT/ope=
nsource/poky/build/tmp/sysroots/x86_64-linux/usr/share/automake-1.12/am/<a =
href=3D"http://ltlibrary.am">ltlibrary.am</a>: archiver requires &#39;AM_PR=
OG_AR&#39; in &#39;<a href=3D"http://configure.ac">configure.ac</a>&#39;<br=
>
| <br>| autoreconf: automake failed with exit status: 1<br><br></div><div>I=
f I try to update <a href=3D"http://configure.ac">configure.ac</a> with - <=
br><br>+AC_CONFIG_MACRO_DIR([m4])<br>+AM_PROG_AR<br><br></div><div>then I h=
it this error -<br>
<br>=A0aclocal.m4:86: AC_LIBTOOL_SETUP is expanded from...<br>| aclocal.m4:=
66: _AC_PROG_LIBTOOL is expanded from...<br>| aclocal.m4:31: AC_PROG_LIBTOO=
L is expanded from...<br>| <a href=3D"http://configure.ac:25">configure.ac:=
25</a>: the top level<br>
| <a href=3D"http://configure.ac:19">configure.ac:19</a>: error: possibly u=
ndefined macro: AM_PROG_AR<br>|=A0=A0=A0=A0=A0=A0 If this token and others =
are legitimate, please use m4_pattern_allow.<br><br></div><div>Yocto uses a=
utomake 1.12.6 so I know it supports AM_PROG_AR<br>
</div><div><br></div><div><br><br></div><div>However, if I separate out the=
 package and build it separately with oe_runmake * it works correctly. It s=
eems when I run manually, it is skipping some steps (such as running acloca=
l may be?) so the package runs into tool incompatibility issues.<br>
</div><br></div>Where can I find the script that runs oerunmake configure? =
Also what can be done to allow manually ./configure and make? Is there any =
place where I can see any guidelines about what care needs to be taken whil=
e using manual build options?<br>
<br>Thanks<br>Udayan<br></div>

--001a11c351b6e60a9304ebb1c7e8--
