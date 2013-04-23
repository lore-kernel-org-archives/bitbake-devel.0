Received: from mail-wg0-f51.google.com ([74.125.82.51])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <zafrullahmehdi@gmail.com>) id 1UUabM-0007Zu-R8
	for bitbake-devel@lists.openembedded.org;
	Tue, 23 Apr 2013 12:37:34 +0200
Received: by mail-wg0-f51.google.com with SMTP id b12so194712wgh.30
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Apr 2013 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:from:date:message-id:subject:to
	:content-type; bh=tBngEXx43V6XlWBOAf2AjQn3NpGeMxuX+cC5Ad+iVtY=;
	b=wsRWXqtTpkm4tT1Bfo3nUbacGFfcBvtBgPDyi0EUr8vi3wWz+qOQEULrzTQWEVStFw
	coAs538MzApt1/e/swAHG8PoHKcXi6ZdNFQauUoG2bR9r8iqAe1sB/WzRluUw95A6AMc
	H1KYWaEIYhl05rzQNV9z/E26e/vv4V0JXRK0arYk+LR5hMFU52H7296sBBY86lJQL28I
	u5i6u0ooeSO2adiicGIA3hqmqLhZSBbUwkKBms0JpKnZVHhpvejWb4R0BT4ziV4vzrbw
	aU2+hKzHreanmlYetwhee3lNhylhAtG2XuXN1Ls2egOdTCoJWWKUVirfnytDsSZ7fw4K
	Kh7Q==
X-Received: by 10.180.94.196 with SMTP id de4mr12059337wib.23.1366712392554;
	Tue, 23 Apr 2013 03:19:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.40.163 with HTTP; Tue, 23 Apr 2013 03:19:32 -0700 (PDT)
From: Zafrullah Syed <zafrullahmehdi@gmail.com>
Date: Tue, 23 Apr 2013 12:19:32 +0200
Message-ID: <CAAGt+t0kqekY4n8QX9DpZR+9H=N++hK6A8hZZphqC+0hGwyenQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: error in building basic root file system
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 23 Apr 2013 10:37:35 -0000
Content-Type: multipart/alternative; boundary=f46d044517f5ab1f4904db048637

--f46d044517f5ab1f4904db048637
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

While building gumstix basic root file system image (bitbake
gumstix-basic-image) according to
http://gumstix.org/software-development/yocto-project/190-verdex-svn-repository.html
i
get the following error:

NOTE: Handling BitBake files: \ (4957/4958) [99 %]ERROR: opening
/home/zaif/gumstix/gumstix-oe/user.collection/packages/*/*.bb: [Errno 2] No
such file or directory:
'/home/zaif/gumstix/gumstix-oe/user.collection/packages/*/*.bb'

NOTE: Parsing finished. 4720 cached, 0 parsed, 237 skipped, 0 masked.
NOTE: build 201304231212: started

OE Build Configuration:
BB_VERSION     = "1.8.10"
OE_REVISION    = "<unknown>"
TARGET_ARCH    = "arm"
TARGET_OS      = "linux-gnueabi"
MACHINE        = "gumstix-custom-verdex"
DISTRO         = "angstrom"
DISTRO_VERSION = "2007.9-test-20130423"
TARGET_FPU     = "soft"

NOTE: Resolving any missing task queue dependencies
NOTE: preferred version 2.5 of glibc not available (for item
virtual/arm-angstrom-linux-gnueabi-libc-for-gcc)
NOTE: Preparing runqueue
NOTE: Executing runqueue
NOTE: Running task 69 of 1391 (ID: 317,
/home/zaif/gumstix/gumstix-oe/org.openembedded.snapshot/packages/binutils/
binutils-cross_2.18.bb, do_fetch)
NOTE: package binutils-cross-2.18: started
NOTE: package binutils-cross-2.18-r1: task do_fetch: started
NOTE: The MD5Sums did not match. Wanted: '9d22ee4dafa3a194457caf4706f9cf01'
and Got: 'ccd264a5fa9ed992a21427c69cba91d3'
NOTE: Task failed: Checksum of '
ftp://ftp.gnu.org/gnu/binutils/binutils-2.18.tar.bz2' failed
NOTE: package binutils-cross-2.18-r1: task do_fetch: failed
ERROR: TaskFailed event exception, aborting
NOTE: package binutils-cross-2.18: failed
ERROR: Build of
/home/zaif/gumstix/gumstix-oe/org.openembedded.snapshot/packages/binutils/
binutils-cross_2.18.bb do_fetch failed
ERROR: Task 317
(/home/zaif/gumstix/gumstix-oe/org.openembedded.snapshot/packages/binutils/
binutils-cross_2.18.bb, do_fetch) failed
NOTE: Tasks Summary: Attempted 68 tasks of which 68 didn't need to be rerun
and 1 failed.
ERROR:
'/home/zaif/gumstix/gumstix-oe/org.openembedded.snapshot/packages/binutils/
binutils-cross_2.18.bb' failed

I couldn't find any root file system and kernel image in
(~/gumstix/gumstix-oe/tmp/deploy/glibc/images/gumstix-custom-verdex).
Infact after tmp the red marked folder is missing. *~/gumstix/gumstix-oe/tmp
/deploy/glibc/images/gumstix-custom-verdex*

Any Ideas where I am doing wrong?

-- 
Regards,
Zafrullah Syed

--f46d044517f5ab1f4904db048637
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>While building gumstix basic ro=
ot file system image (<span style=3D"background-color:rgb(224,232,240);colo=
r:rgb(51,51,51);font-family:Monaco,Consolas,&#39;Courier News&#39;,monospac=
e;font-size:12px;line-height:18px">bitbake gumstix-basic-image</span>) acco=
rding to=A0<a href=3D"http://gumstix.org/software-development/yocto-project=
/190-verdex-svn-repository.html">http://gumstix.org/software-development/yo=
cto-project/190-verdex-svn-repository.html</a>=A0i get the following error:=
</div>

<div><br></div><div><div>NOTE: Handling BitBake files: \ (4957/4958) [99 %]=
ERROR: opening /home/zaif/gumstix/gumstix-oe/user.collection/packages/*/*.b=
b: [Errno 2] No such file or directory: &#39;/home/zaif/gumstix/gumstix-oe/=
user.collection/packages/*/*.bb&#39;</div>

<div><br></div><div>NOTE: Parsing finished. 4720 cached, 0 parsed, 237 skip=
ped, 0 masked.</div><div>NOTE: build 201304231212: started</div><div><br></=
div><div>OE Build Configuration:</div><div>BB_VERSION =A0 =A0 =3D &quot;1.8=
.10&quot;</div>

<div>OE_REVISION =A0 =A0=3D &quot;&lt;unknown&gt;&quot;</div><div>TARGET_AR=
CH =A0 =A0=3D &quot;arm&quot;</div><div>TARGET_OS =A0 =A0 =A0=3D &quot;linu=
x-gnueabi&quot;</div><div>MACHINE =A0 =A0 =A0 =A0=3D &quot;gumstix-custom-v=
erdex&quot;</div><div>DISTRO =A0 =A0 =A0 =A0 =3D &quot;angstrom&quot;</div>

<div>DISTRO_VERSION =3D &quot;2007.9-test-20130423&quot;</div><div>TARGET_F=
PU =A0 =A0 =3D &quot;soft&quot;</div><div><br></div><div>NOTE: Resolving an=
y missing task queue dependencies</div><div>NOTE: preferred version 2.5 of =
glibc not available (for item virtual/arm-angstrom-linux-gnueabi-libc-for-g=
cc)</div>

<div>NOTE: Preparing runqueue</div><div>NOTE: Executing runqueue</div><div>=
NOTE: Running task 69 of 1391 (ID: 317, /home/zaif/gumstix/gumstix-oe/org.o=
penembedded.snapshot/packages/binutils/<a href=3D"http://binutils-cross_2.1=
8.bb">binutils-cross_2.18.bb</a>, do_fetch)</div>

<div>NOTE: package binutils-cross-2.18: started</div><div>NOTE: package bin=
utils-cross-2.18-r1: task do_fetch: started</div><div>NOTE: The MD5Sums did=
 not match. Wanted: &#39;9d22ee4dafa3a194457caf4706f9cf01&#39; and Got: &#3=
9;ccd264a5fa9ed992a21427c69cba91d3&#39;</div>

<div>NOTE: Task failed: Checksum of &#39;<a href=3D"ftp://ftp.gnu.org/gnu/b=
inutils/binutils-2.18.tar.bz2">ftp://ftp.gnu.org/gnu/binutils/binutils-2.18=
.tar.bz2</a>&#39; failed</div><div>NOTE: package binutils-cross-2.18-r1: ta=
sk do_fetch: failed</div>

<div>ERROR: TaskFailed event exception, aborting</div><div>NOTE: package bi=
nutils-cross-2.18: failed</div><div>ERROR: Build of /home/zaif/gumstix/gums=
tix-oe/org.openembedded.snapshot/packages/binutils/<a href=3D"http://binuti=
ls-cross_2.18.bb">binutils-cross_2.18.bb</a> do_fetch failed</div>

<div>ERROR: Task 317 (/home/zaif/gumstix/gumstix-oe/org.openembedded.snapsh=
ot/packages/binutils/<a href=3D"http://binutils-cross_2.18.bb">binutils-cro=
ss_2.18.bb</a>, do_fetch) failed</div><div>NOTE: Tasks Summary: Attempted 6=
8 tasks of which 68 didn&#39;t need to be rerun and 1 failed.</div>

<div>ERROR: &#39;/home/zaif/gumstix/gumstix-oe/org.openembedded.snapshot/pa=
ckages/binutils/<a href=3D"http://binutils-cross_2.18.bb">binutils-cross_2.=
18.bb</a>&#39; failed</div></div><div><br></div><div><div style>I couldn&#3=
9;t find any root file system and kernel image in (~/gumstix/gumstix-oe/tmp=
/deploy/glibc/images/gumstix-custom-verdex). Infact after tmp the red marke=
d folder is missing. <i>~/gumstix/gumstix-oe/tmp<span style=3D"background-c=
olor:rgb(255,0,0)">/deploy/glibc/images/gumstix-custom-verdex</span></i></d=
iv>

<div style><br></div><div style>Any Ideas where I am doing wrong?</div><div=
 style><br></div><div style>--=A0<br></div><span style=3D"font-family:arial=
,sans-serif;font-size:13px;border-collapse:collapse;color:rgb(136,136,136)"=
>Regards,<br>

Zafrullah Syed</span><div><font color=3D"#888888" face=3D"arial, sans-serif=
"><span style=3D"border-collapse:collapse"><br></span></font></div>
</div></div>

--f46d044517f5ab1f4904db048637--
