Return-Path: <tamtamis@gmail.com>
Received: from mail-vn0-f54.google.com (mail-vn0-f54.google.com
	[209.85.216.54])
	by mail.openembedded.org (Postfix) with ESMTP id 144BA6E26B
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 May 2015 09:29:03 +0000 (UTC)
Received: by vnbf7 with SMTP id f7so2747737vnb.13
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 May 2015 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=fRhrrdfKyO+XlsnIYeRDj2ifoCwh9uV93GXKakFYrJc=;
	b=Nr8QvYTpWqD6lkmcAjBHX1grDJOipVr99mB7S0N/jOJh7110jIMCopdXPVu3+u5Xpr
	ttVFOb5OTkyghqrWnrPTEONnSQ4lyTEuYvvALQVXtjvnhXeUjvEMZhBAuMG2STk2JjH2
	47MuWU42uPdc913+j/GTVcbpJsBL603/sPaAcqDeoFXEn6cNzsMYnXO6Kqv7ZvNDl9nB
	yDz+gNBqYA8i40vN44cI83ayekQKz7/nJ2YHP2L/PZs/PjcPpob/hfBmN7gQUm+FDd/x
	I9UIB0iuIiwJWx3TzHBSy9NEK948oyZNqRj/CJoRTG0ZJLbnvp7zTZn/S/8gjwjUfA64
	DrNg==
MIME-Version: 1.0
X-Received: by 10.52.163.166 with SMTP id yj6mr11237289vdb.66.1432373344451;
	Sat, 23 May 2015 02:29:04 -0700 (PDT)
Received: by 10.52.109.105 with HTTP; Sat, 23 May 2015 02:29:04 -0700 (PDT)
Date: Sat, 23 May 2015 12:29:04 +0300
Message-ID: <CAJq++8Q_oF0k8uqwEbcLuWsSfh3LaOwY6GP9inQFUrKUb+rE1Q@mail.gmail.com>
From: Panagiotis Tamtamis <tamtamis@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: QA Issue: python3 modules ELF binary has relocations in .text
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
X-List-Received-Date: Sat, 23 May 2015 09:29:05 -0000
Content-Type: multipart/alternative; boundary=001a11c227fe61c2b40516bc6849

--001a11c227fe61c2b40516bc6849
Content-Type: text/plain; charset=UTF-8

Hello,

After build I have the following warnings:

#bitbake python3


.......
WARNING: QA Issue: ELF binary
'/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/python3-misc/usr/lib/python3.3/lib-dynload/_
datetime.cpython-33m.so' has relocations in .text
WARNING: QA Issue: ELF binary
'/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/python3-misc/usr/lib/python3.3/lib-dynload/_
lzma.cpython-33m.so' has relocations in .text
WARNING: QA Issue: ELF binary
'/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/python3-misc/usr/lib/python3.3/lib-dynload/
xxlimited.cpython-33m.so' has relocations in .text
WARNING: QA Issue: ELF binary
'/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/python3-misc/usr/lib/python3.3/lib-dynload/_
testbuffer.cpython-33m.so' has relocations in .text
WARNING: QA Issue: ELF binary
'/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/python3-misc/usr/lib/python3.3/lib-dynload/_
testcapi.cpython-33m.so' has relocations in .text
WARNING: QA Issue: ELF binary
'/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/python3-misc/usr/lib/python3.3/lib-dynload/_
posixsubprocess.cpython-33m.so' has relocations in .text
WARNING: QA Issue: ELF binary
'/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/python3-misc/usr/lib/python3.3/lib-dynload/_
sha1.cpython-33m.so' has relocations in .text



I gone to build log and I saw the following:


.....
powerpc-linux-gnuspe-gcc  -m32 -mcpu=8548 -mabi=spe -mspe
-mfloat-gprs=double -DNDEBUG -fno-inline
--sysroot=/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/sysroots/p2020rdb
-c -Wno-unused-result -O2 -pipe -g -feliminate-unused-debug-types -O2 -pipe
-g -feliminate-unused-debug-types  -O2 -pipe -g
-feliminate-unused-debug-types   -I. -IInclude -I./Include   -fPIC
-DPy_BUILD_CORE -o Python/symtable.o Python/symtable.c
powerpc-linux-gnuspe-gcc  -m32 -mcpu=8548 -mabi=spe -mspe
-mfloat-gprs=double -DNDEBUG -fno-inline
--sysroot=/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/sysroots/p2020rdb
-c -Wno-unused-result -O2 -pipe -g -feliminate-unused-debug-types -O2 -pipe
-g -feliminate-unused-debug-types  -O2 -pipe -g
-feliminate-unused-debug-types   -I. -IInclude -I./Include   -fPIC
-DPy_BUILD_CORE -o Python/graminit.o Python/graminit.c
......

running build
running build_ext
INFO: Can't locate Tcl/Tk libs and/or headers
building '_struct' extension
creating build/temp.linux-powerpc-3.3
creating build/temp.linux-powerpc-3.3/home
creating build/temp.linux-powerpc-3.3/home/tamis
creating build/temp.linux-powerpc-3.3/home/tamis/straus
creating build/temp.linux-powerpc-3.3/home/tamis/straus/opt
creating build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk
creating build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build
creating
build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2
creating
build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp
creating
build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work
creating
build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe
creating
build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3
creating
build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0
creating
build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3
creating
build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3/Modules

powerpc-linux-gnuspe-gcc -m32 -mcpu=8548 -mabi=spe -mspe
-mfloat-gprs=double -DNDEBUG -fno-inline
--sysroot=/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/sysroots/p2020rdb
-O2 -pipe -g -feliminate-unused-debug-types
-I/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3/Include
-I/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3
-c
/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3/Modules/_struct.c
-o
build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3/Modules/_struct.o

powerpc-linux-gnuspe-gcc -m32 -mcpu=8548 -mabi=spe -mspe
-mfloat-gprs=double -DNDEBUG -fno-inline
--sysroot=/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/sysroots/p2020rdb
-shared -L.
-L/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/sysroots/p2020rdb/usr/lib
-Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -Wl,-O1 -Wl,--hash-style=gnu
-Wl,--as-needed -O2 -pipe -g -feliminate-unused-debug-types
build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3/Modules/_struct.o
-L=/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/sysroots/p2020rdb/usr/lib
-lpython3.3m -o build/lib.linux-powerpc-3.3/_struct.cpython-33m.so
building '_ctypes_test' extension

.....


At first the -fPIC compile option exists but then at the modules /
extensions compile it disappears. And the compile options are not exactly
the same.
Can please explain me why this is happening and not the same options are
not used?






-- 
Think simple!

--001a11c227fe61c2b40516bc6849
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>After build I have the following=
 warnings:</div><div><br></div><div><div>#bitbake python3</div><div><br></d=
iv><div><br></div><div>.......</div><div>WARNING: QA Issue: ELF binary &#39=
;/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e=
500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/pyt=
hon3-misc/usr/lib/python3.3/lib-dynload/_<a href=3D"http://datetime.cpython=
-33m.so">datetime.cpython-33m.so</a>&#39; has relocations in .text</div><di=
v>WARNING: QA Issue: ELF binary &#39;/home/tamis/straus/opt/eldk/build/p202=
0-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/p=
ython3/3.3.3-r0.0/packages-split/python3-misc/usr/lib/python3.3/lib-dynload=
/_<a href=3D"http://lzma.cpython-33m.so">lzma.cpython-33m.so</a>&#39; has r=
elocations in .text</div><div>WARNING: QA Issue: ELF binary &#39;/home/tami=
s/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/w=
ork/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/python3-misc/u=
sr/lib/python3.3/lib-dynload/<a href=3D"http://xxlimited.cpython-33m.so">xx=
limited.cpython-33m.so</a>&#39; has relocations in .text</div><div>WARNING:=
 QA Issue: ELF binary &#39;/home/tamis/straus/opt/eldk/build/p2020-v5.6_201=
50512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3=
.3-r0.0/packages-split/python3-misc/usr/lib/python3.3/lib-dynload/_<a href=
=3D"http://testbuffer.cpython-33m.so">testbuffer.cpython-33m.so</a>&#39; ha=
s relocations in .text</div><div>WARNING: QA Issue: ELF binary &#39;/home/t=
amis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tm=
p/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/python3-mis=
c/usr/lib/python3.3/lib-dynload/_<a href=3D"http://testcapi.cpython-33m.so"=
>testcapi.cpython-33m.so</a>&#39; has relocations in .text</div><div>WARNIN=
G: QA Issue: ELF binary &#39;/home/tamis/straus/opt/eldk/build/p2020-v5.6_2=
0150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3=
.3.3-r0.0/packages-split/python3-misc/usr/lib/python3.3/lib-dynload/_<a hre=
f=3D"http://posixsubprocess.cpython-33m.so">posixsubprocess.cpython-33m.so<=
/a>&#39; has relocations in .text</div><div>WARNING: QA Issue: ELF binary &=
#39;/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f1=
0-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/packages-split/=
python3-misc/usr/lib/python3.3/lib-dynload/_<a href=3D"http://sha1.cpython-=
33m.so">sha1.cpython-33m.so</a>&#39; has relocations in .text</div><div><br=
></div><div><br></div><div><br></div><div>I gone to build log and I saw the=
 following:</div><div><br></div><div><br></div><div>.....</div><div><div><d=
iv>powerpc-linux-gnuspe-gcc =C2=A0-m32 -mcpu=3D8548 -mabi=3Dspe -mspe -mflo=
at-gprs=3Ddouble -DNDEBUG -fno-inline --sysroot=3D/home/tamis/straus/opt/el=
dk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/sysroots/p2020rd=
b -c -Wno-unused-result -O2 -pipe -g -feliminate-unused-debug-types -O2 -pi=
pe -g -feliminate-unused-debug-types =C2=A0-O2 -pipe -g -feliminate-unused-=
debug-types =C2=A0 -I. -IInclude -I./Include =C2=A0 -fPIC -DPy_BUILD_CORE -=
o Python/symtable.o Python/symtable.c</div><div>powerpc-linux-gnuspe-gcc =
=C2=A0-m32 -mcpu=3D8548 -mabi=3Dspe -mspe -mfloat-gprs=3Ddouble -DNDEBUG -f=
no-inline --sysroot=3D/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512=
-2015-03-03-3449f10-e500v2/tmp/sysroots/p2020rdb -c -Wno-unused-result -O2 =
-pipe -g -feliminate-unused-debug-types -O2 -pipe -g -feliminate-unused-deb=
ug-types =C2=A0-O2 -pipe -g -feliminate-unused-debug-types =C2=A0 -I. -IInc=
lude -I./Include =C2=A0 -fPIC -DPy_BUILD_CORE -o Python/graminit.o Python/g=
raminit.c</div></div><div>......</div><div><br></div><div>running build</di=
v><div>running build_ext</div><div>INFO: Can&#39;t locate Tcl/Tk libs and/o=
r headers</div><div>building &#39;_struct&#39; extension</div><div>creating=
 build/temp.linux-powerpc-3.3</div><div>creating build/temp.linux-powerpc-3=
.3/home</div><div>creating build/temp.linux-powerpc-3.3/home/tamis</div><di=
v>creating build/temp.linux-powerpc-3.3/home/tamis/straus</div><div>creatin=
g build/temp.linux-powerpc-3.3/home/tamis/straus/opt</div><div>creating bui=
ld/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk</div><div>creating bui=
ld/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build</div><div>creati=
ng build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6=
_20150512-2015-03-03-3449f10-e500v2</div><div>creating build/temp.linux-pow=
erpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-34=
49f10-e500v2/tmp</div><div>creating build/temp.linux-powerpc-3.3/home/tamis=
/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/wo=
rk</div><div>creating build/temp.linux-powerpc-3.3/home/tamis/straus/opt/el=
dk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-l=
inux-gnuspe</div><div>creating build/temp.linux-powerpc-3.3/home/tamis/stra=
us/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/pp=
ce500v2-linux-gnuspe/python3</div><div>creating build/temp.linux-powerpc-3.=
3/home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e=
500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0</div><div>creating=
 build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_2=
0150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/3=
.3.3-r0.0/Python-3.3.3</div><div>creating build/temp.linux-powerpc-3.3/home=
/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/=
tmp/work/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3/Modules</di=
v><div><br></div><div>powerpc-linux-gnuspe-gcc -m32 -mcpu=3D8548 -mabi=3Dsp=
e -mspe -mfloat-gprs=3Ddouble -DNDEBUG -fno-inline --sysroot=3D/home/tamis/=
straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/sys=
roots/p2020rdb -O2 -pipe -g -feliminate-unused-debug-types -I/home/tamis/st=
raus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/=
ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3/Include -I/home/tami=
s/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/w=
ork/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3 -c /home/tamis/s=
traus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work=
/ppce500v2-linux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3/Modules/_struct.c -=
o build/temp.linux-powerpc-3.3/home/tamis/straus/opt/eldk/build/p2020-v5.6_=
20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-linux-gnuspe/python3/=
3.3.3-r0.0/Python-3.3.3/Modules/_struct.o</div><div><br></div><div>powerpc-=
linux-gnuspe-gcc -m32 -mcpu=3D8548 -mabi=3Dspe -mspe -mfloat-gprs=3Ddouble =
-DNDEBUG -fno-inline --sysroot=3D/home/tamis/straus/opt/eldk/build/p2020-v5=
.6_20150512-2015-03-03-3449f10-e500v2/tmp/sysroots/p2020rdb -shared -L. -L/=
home/tamis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e50=
0v2/tmp/sysroots/p2020rdb/usr/lib -Wl,-O1 -Wl,--hash-style=3Dgnu -Wl,--as-n=
eeded -Wl,-O1 -Wl,--hash-style=3Dgnu -Wl,--as-needed -O2 -pipe -g -felimina=
te-unused-debug-types build/temp.linux-powerpc-3.3/home/tamis/straus/opt/el=
dk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp/work/ppce500v2-l=
inux-gnuspe/python3/3.3.3-r0.0/Python-3.3.3/Modules/_struct.o -L=3D/home/ta=
mis/straus/opt/eldk/build/p2020-v5.6_20150512-2015-03-03-3449f10-e500v2/tmp=
/sysroots/p2020rdb/usr/lib -lpython3.3m -o build/lib.linux-powerpc-3.3/_<a =
href=3D"http://struct.cpython-33m.so">struct.cpython-33m.so</a></div><div>b=
uilding &#39;_ctypes_test&#39; extension</div></div><div><br></div><div>...=
..</div><div><br></div><div><br></div><div>At first the -fPIC compile optio=
n exists but then at the modules / extensions compile it disappears. And th=
e compile options are not exactly the same.</div><div>Can please explain me=
 why this is happening and not the same options are not used?</div><div><br=
></div><div><br></div><div><br></div><div><br></div><div><br></div><div><br=
></div>-- <br><div class=3D"gmail_signature">Think simple!</div>
</div></div>

--001a11c227fe61c2b40516bc6849--
