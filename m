Subject: Cmake build fails in yocto
To: bitbake-devel@lists.openembedded.org
From: "Ishu Goel" <ishu.goel@nobleo.nl>
X-Originating-Location: Eindhoven, North Brabant, NL (81.173.75.97)
X-Originating-Platform: Linux Firefox 88
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 05 May 2021 02:28:06 -0700
Message-ID: <JcWz.1620206886052771323.gFoj@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="Vn0PwVlO8ig0FKmKcYFe"

--Vn0PwVlO8ig0FKmKcYFe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am using CMake with Yocto and working on the hellocmake example provided=
 here: https://github.com/joaocfernandes/Learn-Yocto/blob/master/develop/Re=
cipe-CMake.md
When I bake the hellocmake recipe it builds perfectly the first time. But =
when I make any change in the source file 'hellocmake.cpp' and bake, I get =
the following error:

ERROR: hellocmake-1.0-r0 do_install: Execution of '/home/developer/work/bu=
ild/tmp-glibc/work/cortexa72-oe-linux/hellocmake/1.0-r0/temp/run.do_install=
.147' failed with exit code 1:
abort()ing pseudo client by server request. See https://wiki.yoctoproject.=
org/wiki/Pseudo_Abort for more details on this.
Check logfile: /home/developer/work/build/tmp-glibc/work/cortexa72-oe-linu=
x/hellocmake/1.0-r0/pseudo//pseudo.log
Child aborted
CMake Error: Generator: execution of make failed. Make command was: ninja =
-v -j 4 install &&
WARNING: exit code 1 from a shell command.

ERROR: Logfile of failure stored in: /home/developer/work/build/tmp-glibc/=
work/cortexa72-oe-linux/hellocmake/1.0-r0/temp/log.do_install.147

I want to know what I am doing wrong? I noticed that if I clean the previo=
us build of hellocmake, I do not get this error. How can I make sure that C=
Make works every time with yocto?

With regards,
Ishu Goel

--Vn0PwVlO8ig0FKmKcYFe
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,<br /><br />I am using CMake with Yocto and working on the hellocmake=
 example provided here: https://github.com/joaocfernandes/Learn-Yocto/blob/=
master/develop/Recipe-CMake.md<br />When I bake the hellocmake recipe it bu=
ilds perfectly the first time. But when I make any change in the source fil=
e 'hellocmake.cpp' and bake, I get the following error:<br /><br />ERROR: h=
ellocmake-1.0-r0 do_install: Execution of '/home/developer/work/build/tmp-g=
libc/work/cortexa72-oe-linux/hellocmake/1.0-r0/temp/run.do_install.147' fai=
led with exit code 1:<br />abort()ing pseudo client by server request. See =
https://wiki.yoctoproject.org/wiki/Pseudo_Abort for more details on this.<b=
r />Check logfile: /home/developer/work/build/tmp-glibc/work/cortexa72-oe-l=
inux/hellocmake/1.0-r0/pseudo//pseudo.log<br />Child aborted<br />CMake Err=
or: Generator: execution of make failed. Make command was: ninja -v -j 4 in=
stall &amp;&amp; <br />WARNING: exit code 1 from a shell command.<br /><br =
/>ERROR: Logfile of failure stored in: /home/developer/work/build/tmp-glibc=
/work/cortexa72-oe-linux/hellocmake/1.0-r0/temp/log.do_install.147<br /><br=
 /><br />I want to know what I am doing wrong? I noticed that if I clean th=
e previous build of hellocmake, I do not get this error. How can I make sur=
e that CMake works every time with yocto?<br /><br />With regards,<br />Ish=
u Goel

--Vn0PwVlO8ig0FKmKcYFe--
