Return-Path: <david.good1@gmail.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id 6CF8760DED
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 05:18:44 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w61so2020363wes.15
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 21:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=P12mY5pwfFxQcOP3CURDC6atj9Y2X3Z/cmB0ydptr3E=;
	b=ert6u+jC1edtSD7gbMe8ynVSfYKTG9BnhCUwMIp/mAREZnYNMWKZ7MFi6d+0+icjpG
	9CPd1VmvAT68eqnshHsTY5CV2NkjSUPzkBfkwnvQM/l6C2F47a2wCJOoJw9DnT0WHCAy
	4Yu27WLSqVYsuA0ze90s011XRIWWBTryW8WrtsVtjMn4gLnQOc74CWuCYAykX2Ld2VBE
	V2Z6EJK/00C9BrNgtQKat4Cx02Vvjkv1RfBdqIZylHze5JGSurEzavHhOcA5wThpPhMz
	Qrp4vfbr870M2K8NFblDcu5dd6FOUuqkLuuCEp4flpi6617xRl12si604FaLFh5A80L0
	qUfA==
X-Received: by 10.180.104.42 with SMTP id gb10mr6050348wib.51.1387516723961;
	Thu, 19 Dec 2013 21:18:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.171.202 with HTTP; Thu, 19 Dec 2013 21:18:23 -0800 (PST)
From: David Good <david.good1@gmail.com>
Date: Thu, 19 Dec 2013 23:18:23 -0600
Message-ID: <CALMFhSzPCspAJ6BbgD0dYk7EVP780zQPb8enJ7YCYY05mBdf8g@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Fri, 20 Dec 2013 09:50:02 +0000
Subject: Running configure script up one dir
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
X-List-Received-Date: Fri, 20 Dec 2013 05:18:45 -0000
Content-Type: multipart/alternative; boundary=f46d041826f673a70d04edf06946

--f46d041826f673a70d04edf06946
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I hope that this is the right list for my question.  I'm trying to write a
bb recipe for Angstrom v2012_12 (BeagleBone Black) for the tDOM package
which uses autotools in a strange way (to me anyhow).  configure is
expected to be run from /(project root)/unix, like this:

cd (git checkout of project)/unix
../configure; make; make install

How do I get bitbake to run configure in this way?

Here's my bb file if it helps:

DESCRIPTION = "XML data processing in Tcl"
LICENSE = "MPL-1"
SECTION = "devel/tcltk"
HOMEPAGE = "http://tdom.github.io/"
DEPENDS = "tcl-native"
LIC_FILES_CHKSUM = "file://../LICENSE;md5=4673aaff544d4c9b9a521cb8e0860bfb"
PR = "r0"

SRC_URI = "git://github.com/tDOM/tdom.git;protocol=git;tag=master"

S = "${WORKDIR}/git/unix"

inherit autotools

---

Any thoughts would be appreciated!

--David

--f46d041826f673a70d04edf06946
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>Hi all,<br><br></div>I =
hope that this is the right list for my question.=A0 I&#39;m trying to writ=
e a bb recipe for Angstrom v2012_12 (BeagleBone Black) for the tDOM package=
 which uses autotools in a strange way (to me anyhow).=A0 configure is expe=
cted to be run from /(project root)/unix, like this:<br>

<br></div>cd (git checkout of project)/unix<br></div>../configure; make; ma=
ke install<br><br></div>How do I get bitbake to run configure in this way?<=
br><br></div>Here&#39;s my bb file if it helps:<br><br>DESCRIPTION =3D &quo=
t;XML data processing in Tcl&quot;<br>

LICENSE =3D &quot;MPL-1&quot;<br>SECTION =3D &quot;devel/tcltk&quot;<br>HOM=
EPAGE =3D &quot;<a href=3D"http://tdom.github.io/">http://tdom.github.io/</=
a>&quot;<br>DEPENDS =3D &quot;tcl-native&quot;<br>LIC_FILES_CHKSUM =3D &quo=
t;file://../LICENSE;md5=3D4673aaff544d4c9b9a521cb8e0860bfb&quot;<br>

PR =3D &quot;r0&quot;<br><br>SRC_URI =3D &quot;git://<a href=3D"http://gith=
ub.com/tDOM/tdom.git;protocol=3Dgit;tag=3Dmaster">github.com/tDOM/tdom.git;=
protocol=3Dgit;tag=3Dmaster</a>&quot;<br><br>S =3D &quot;${WORKDIR}/git/uni=
x&quot;<br>
<br>
inherit autotools<br><br>---<br><br></div>Any thoughts would be appreciated=
!<br><br></div>--David<br></div>

--f46d041826f673a70d04edf06946--
