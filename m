Return-Path: <info@sd-kyber.com>
Received: from relais.videotron.net (relais.videotron.net [24.201.245.25])
	by mail.openembedded.org (Postfix) with ESMTP id 9F0EF65DD0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Aug 2014 02:59:13 +0000 (UTC)
MIME-version: 1.0
Received: from [192.168.1.190]
	(modemcable250.171-70-69.static.videotron.ca [69.70.171.250])
	by VL-VM-MRA001.ip.videotron.ca
	(Oracle Communications Messaging Exchange Server 7u4-18.01 64bit (built
	Jul 15
	2010)) with ESMTPA id <0NAO00JJMTMNVR00@VL-VM-MRA001.ip.videotron.ca>
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Aug 2014 22:59:14 -0400 (EDT)
From: info@sd-kyber.com
Message-id: <D435FD3B-FAF6-4EA2-BADF-95F56CD6775F@sd-kyber.com>
Date: Thu, 21 Aug 2014 22:59:11 -0400
To: bitbake-devel@lists.openembedded.org
X-Mailer: Apple Mail (2.1973.6)
Subject: *-dbg package...
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
X-List-Received-Date: Fri, 22 Aug 2014 02:59:17 -0000
Content-type: multipart/alternative;
	boundary="Boundary_(ID_W2I5IzbnCOlH5lAU5DGyWg)"

--Boundary_(ID_W2I5IzbnCOlH5lAU5DGyWg)
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable

Hi,=20
I=E2=80=99m trying to write ( and to use ) a recipe which should build a =
simple  .rpm,  which contains the /usr/lib/libaffinity.so and a  few =
header files within /usr/include/affinity/* subdir.

However, it looks like bitbake is trying / =E2=80=9Cforcing=E2=80=9D me =
to  build a ${PN}-dbg package=E2=80=A6.:

I=E2=80=99m doing the following steps:

1. recipe:
=E2=80=9C
=E2=80=A6
inherit  cmake pkgconfig

PACKAGES =3D "${PN}"
FILES_${PN} =3D "${libdir}/libaffinity.so /usr/include/affinity/*=E2=80=9D=
  =20
=E2=80=A6
=E2=80=9C
So, I assume  I=E2=80=99 m asking to build only 1 package.

2. During the bitbake processing, as the compilation, build,  and =
installation are over, the  files are copied into the ${D} directory, as =
expected:
=E2=80=9C
michael@localhost image]$ pwd=20
=
/home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp-poky-linux=
-gnueabi/affinityng/0.1-r0/image
[michael@localhost image]$ cd usr
[michael@localhost usr]$ ls -la
total 16
drwxr-xr-x. 4 michael michael 4096 Aug 21 19:57 .
drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 ..
drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 include
drwxr-xr-x. 2 michael michael 4096 Aug 21 19:57 lib
=E2=80=9C
So far, everything as expected in accordance with the Yocto reference.=20=


3. According to the manual reference  - "The do_package and =
do_packagedata tasks combine to analyze the files found in the D =
<http://www.yoctoproject.org/docs/current/ref-manual/ref-manual.html#var-D=
> directory=E2=80=A6=E2=80=9D,  I would expect that the package would be =
build.
However, the  attempt to build is failing. with the error:
=E2=80=9C=E2=80=A6
ERROR: QA Issue: affinityng: Files/directories were installed but not =
shipped
  /usr/src
  /usr/lib/.debug
  /usr/lib/.debug/libaffinity.so
  /usr/src/debug
  /usr/src/debug/affinityng
  /usr/src/debug/affinityng/0.1-r0
  /usr/src/debug/affinityng/0.1-r0/kernel
=E2=80=A6
=E2=80=9C

4. Following the reference, I checked the PKGD directory, where the =
files should be before split=E2=80=A6.
And I noticed that there is the src directory there,  in addition to  =
directories =E2=80=94 include and lib =E2=80=94 the only ones I was =
expecting to see there.
( see log below ) .

=E2=80=9C
=
/home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp-poky-linux=
-gnueabi/affinityng/0.1-r0/package/usr
=E2=80=A6.
[michael@localhost usr]$ ls -la
total 20
drwxr-xr-x. 5 michael michael 4096 Aug 21 19:57 .
drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 ..
drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 include
drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 lib
drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 src
[michael@localhost usr]$ pwd=20
=
/home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp-poky-linux=
-gnueabi/affinityng/0.1-r0/package/usr
[michael@localhost usr]$ cd src
[michael@localhost src]$ ls -la
total 12
drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 .
drwxr-xr-x. 5 michael michael 4096 Aug 21 19:57 ..
drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 debug
[michael@localhost src]$=20
=E2=80=9C
5. It looks like that as result of package split, the  include & lib =
directories are used properly to build affinityng package, at least it =
is shown in packages-split properly.
But then ,  the content of the src directory is causing the problem with =
QA.

6. At the same time, if I ask to build  ${PN}-dbg package in addition - =
both packages are build, no QA complains, and all src/debug/* are going =
into the -dbg package=E2=80=A6=20

I wonder,
- why does the src directory appear within  PKGD/usr? ( If there is no =
such directory within the ${D} directory...)
- where is the definition for  -dbg package is coming from, and is it =
possible to disable it?=20

May be somebody have the answer or suggestion what to check next=E2=80=A6.=
 =20

Thanks for a kind attention to the matter.=20

Have a great day,
Michael.


--Boundary_(ID_W2I5IzbnCOlH5lAU5DGyWg)
Content-type: text/html; charset=utf-8
Content-transfer-encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hi,&nbsp;<div class=3D"">I=E2=80=99m trying to write ( and to =
use ) a recipe which should build a simple &nbsp;.rpm, &nbsp;which =
contains the /usr/lib/libaffinity.so and a &nbsp;few header files within =
/usr/include/affinity/* subdir.</div><div class=3D""><br =
class=3D""></div><div class=3D"">However, it looks like bitbake is =
trying / =E2=80=9Cforcing=E2=80=9D me to &nbsp;build a ${PN}-dbg =
package=E2=80=A6.:</div><div class=3D""><br class=3D""></div><div =
class=3D"">I=E2=80=99m doing the following steps:</div><div class=3D""><br=
 class=3D""></div><div class=3D"">1. recipe:</div><div =
class=3D"">=E2=80=9C</div><div class=3D"">=E2=80=A6</div><div =
class=3D""><div class=3D"">inherit &nbsp;cmake pkgconfig</div><div =
class=3D""><br class=3D""></div><div class=3D"">PACKAGES =3D =
"${PN}"</div><div class=3D"">FILES_${PN} =3D "${libdir}/libaffinity.so =
/usr/include/affinity/*=E2=80=9D &nbsp;&nbsp;</div></div><div =
class=3D"">=E2=80=A6</div><div class=3D"">=E2=80=9C</div><div =
class=3D"">So, I assume &nbsp;I=E2=80=99 m asking to build only 1 =
package.</div><div class=3D""><br class=3D""></div><div class=3D"">2. =
During the bitbake processing, as the compilation, build, &nbsp;and =
installation are over, the &nbsp;files are copied into the ${D} =
directory, as expected:</div><div class=3D"">=E2=80=9C</div><div =
class=3D"">michael@localhost image]$ pwd&nbsp;</div><div class=3D""><div =
class=3D"">/home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp=
-poky-linux-gnueabi/affinityng/0.1-r0/image</div><div =
class=3D"">[michael@localhost image]$ cd usr</div><div =
class=3D"">[michael@localhost usr]$ ls -la</div><div class=3D"">total =
16</div><div class=3D"">drwxr-xr-x. 4 michael michael 4096 Aug 21 19:57 =
.</div><div class=3D"">drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 =
..</div><div class=3D"">drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 =
include</div><div class=3D"">drwxr-xr-x. 2 michael michael 4096 Aug 21 =
19:57 lib</div></div><div class=3D"">=E2=80=9C</div><div class=3D"">So =
far, everything as expected in accordance with the Yocto =
reference.&nbsp;</div><div class=3D""><br class=3D""></div><div =
class=3D"">3. According to the manual reference &nbsp;- "<span =
style=3D"color: rgb(51, 51, 51); line-height: 24px; background-color: =
rgb(255, 255, 255);" class=3D"">The&nbsp;</span><code class=3D"filename" =
style=3D"color: rgb(51, 51, 51); line-height: =
24px;">do_package</code><span style=3D"color: rgb(51, 51, 51); =
line-height: 24px; background-color: rgb(255, 255, 255);" =
class=3D"">&nbsp;and&nbsp;</span><code class=3D"filename" style=3D"color: =
rgb(51, 51, 51); line-height: 24px;">do_packagedata</code><span =
style=3D"color: rgb(51, 51, 51); line-height: 24px; background-color: =
rgb(255, 255, 255);" class=3D"">&nbsp;tasks combine to analyze the files =
found in the&nbsp;</span><a class=3D"link" =
href=3D"http://www.yoctoproject.org/docs/current/ref-manual/ref-manual.htm=
l#var-D" title=3D"D" style=3D"color: rgb(68, 68, 68); line-height: =
24px;"><code class=3D"filename">D</code></a><span =
style=3D"background-color: rgb(255, 255, 255);" class=3D""><font =
color=3D"#333333" class=3D""><span style=3D"line-height: 24px;" =
class=3D"">&nbsp;directory=E2=80=A6=E2=80=9D, &nbsp;I would expect that =
the package would be build.</span></font></span></div><div =
class=3D""><font color=3D"#333333" class=3D""><span style=3D"line-height: =
24px; background-color: rgb(255, 255, 255);" class=3D"">However, the =
&nbsp;attempt to build is failing. with the =
error:</span></font></div><div class=3D""><font color=3D"#333333" =
class=3D""><span style=3D"line-height: 24px;" =
class=3D"">=E2=80=9C</span></font><span style=3D"line-height: 24px; =
color: rgb(51, 51, 51);" class=3D"">=E2=80=A6</span></div><div =
class=3D""><div class=3D"">ERROR: QA Issue: affinityng: =
Files/directories were installed but not shipped</div><div =
class=3D"">&nbsp; /usr/src</div><div class=3D"">&nbsp; =
/usr/lib/.debug</div><div class=3D"">&nbsp; =
/usr/lib/.debug/libaffinity.so</div><div class=3D"">&nbsp; =
/usr/src/debug</div><div class=3D"">&nbsp; =
/usr/src/debug/affinityng</div><div class=3D"">&nbsp; =
/usr/src/debug/affinityng/0.1-r0</div><div class=3D"">&nbsp; =
/usr/src/debug/affinityng/0.1-r0/kernel</div></div><div =
class=3D"">=E2=80=A6</div><div class=3D"">=E2=80=9C</div><div =
class=3D""><br class=3D""></div><div class=3D"">4. Following the =
reference, I checked the PKGD directory, where the files should be =
before split=E2=80=A6.</div><div class=3D"">And I noticed that there is =
the src directory there, &nbsp;in addition to &nbsp;directories =E2=80=94 =
include and lib =E2=80=94 the only ones I was expecting to see =
there.</div><div class=3D"">( see log below ) .</div><div class=3D""><br =
class=3D""></div><div class=3D"">=E2=80=9C</div><div class=3D""><div =
class=3D"">/home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp=
-poky-linux-gnueabi/affinityng/0.1-r0/package/usr</div><div =
class=3D"">=E2=80=A6.</div><div class=3D"">[michael@localhost usr]$ ls =
-la</div><div class=3D"">total 20</div><div class=3D"">drwxr-xr-x. 5 =
michael michael 4096 Aug 21 19:57 .</div><div class=3D"">drwxr-xr-x. 3 =
michael michael 4096 Aug 21 19:57 ..</div><div class=3D"">drwxr-xr-x. 3 =
michael michael 4096 Aug 21 19:57 include</div><div class=3D"">drwxr-xr-x.=
 3 michael michael 4096 Aug 21 19:57 lib</div><div class=3D"">drwxr-xr-x. =
3 michael michael 4096 Aug 21 19:57 src</div><div =
class=3D"">[michael@localhost usr]$ pwd&nbsp;</div><div =
class=3D"">/home/michael/Devlab/poky/build-atmel/tmp/work/cortexa5t2hf-vfp=
-poky-linux-gnueabi/affinityng/0.1-r0/package/usr</div><div =
class=3D"">[michael@localhost usr]$ cd src</div><div =
class=3D"">[michael@localhost src]$ ls -la</div><div class=3D"">total =
12</div><div class=3D"">drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 =
.</div><div class=3D"">drwxr-xr-x. 5 michael michael 4096 Aug 21 19:57 =
..</div><div class=3D"">drwxr-xr-x. 3 michael michael 4096 Aug 21 19:57 =
debug</div><div class=3D"">[michael@localhost =
src]$&nbsp;</div></div><div class=3D"">=E2=80=9C</div><div class=3D"">5. =
It looks like that as result of package split, the &nbsp;include &amp; =
lib directories are used properly to build affinityng package, at least =
it is shown in packages-split properly.</div><div class=3D"">But then , =
&nbsp;the content of the src directory is causing the problem with =
QA.</div><div class=3D""><br class=3D""></div><div class=3D"">6. At the =
same time, if I ask to build &nbsp;${PN}-dbg package in addition - both =
packages are build, no QA complains, and all src/debug/* are going into =
the -dbg package=E2=80=A6&nbsp;</div><div class=3D""><br =
class=3D""></div><div class=3D"">I wonder,</div><div class=3D"">- why =
does the src directory appear within &nbsp;PKGD/usr? ( If there is no =
such directory within the ${D} directory...)</div><div class=3D"">- =
where is the definition for &nbsp;-dbg package is coming from, and is it =
possible to disable it?&nbsp;</div><div class=3D""><br =
class=3D""></div><div class=3D"">May be somebody have the answer or =
suggestion what to check next=E2=80=A6. &nbsp;</div><div class=3D""><br =
class=3D""></div><div class=3D"">Thanks for a kind attention to the =
matter.&nbsp;</div><div class=3D""><br class=3D""></div><div =
class=3D"">Have a great day,</div><div class=3D"">Michael.</div><div =
class=3D""><br class=3D""></div></body></html>=

--Boundary_(ID_W2I5IzbnCOlH5lAU5DGyWg)--
