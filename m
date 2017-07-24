Return-Path: <viditha@mpconsultants.org>
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com
	[209.85.217.177])
	by mail.openembedded.org (Postfix) with ESMTP id B5D1D78277
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 15:41:51 +0000 (UTC)
Received: by mail-ua0-f177.google.com with SMTP id w45so81696395uac.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mpconsultants.org; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=bom+qEkblNfLRH8bOWqaYBynPB95VDvK/VZV4vVfsTE=;
	b=IjWoBkuptkYgTbaZovH7hwHi1g8AumYI/HukDAl/jGa9TiKE4Zb8kkAjdB2oFXX4d1
	2VDNe/bFp2NZsO2M5XWYMQ2GF4GkXA9BTSuHg/n0QN2HI2UEUUlcqLHrrYF8nRxdmfjB
	lJExoIIwFQkEBa4pVlkoCsNSA2KJqY0TJSijI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=bom+qEkblNfLRH8bOWqaYBynPB95VDvK/VZV4vVfsTE=;
	b=aFPH6NLwAnFqAC8JDpyQ3x+0OisnYu9F2SbjqNQ5o72A6DM+NLduH6VYOYwBJDGXjG
	zIppmmAlZaXF+H0EJFZpymt//VIZoJe7VOCNThdbNXRZQYsy6l5Lf4Q3frLj9WNEiYQL
	YvmryEzX6OUq7sJv6JXoZFfhza8p7YPVrxyjJtcrTrrNWcztMp+lGnkZZ88odJeJ5N02
	P7c8pkL8u6bYk/AoLZMI/clgkVAaHDi7LjNjdOIk1tkzxan8Ge7IVvc/uGkW7aBIRt4N
	O6KEnIUZgtkDAdbsJ1e0XCCksyE07LadY4y0lYt+giOUoQLLQ+GM9iMJFzfXOHFRTXTU
	1naw==
X-Gm-Message-State: AIVw113hWfeAwyndTzKUWLIBDJRl54gpNyMQ+GThhUDW4090/zAFWHue
	8y8QHje6sqo+qfHxOJIPokwh63y95jL72us=
X-Received: by 10.31.168.143 with SMTP id r137mr3510345vke.50.1500910912481;
	Mon, 24 Jul 2017 08:41:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.78.159 with HTTP; Mon, 24 Jul 2017 08:41:52 -0700 (PDT)
In-Reply-To: <CAMKF1sqB1EBkqWYSGFfvr9=wpZhGYFtLTV7Z+VtdCSjfPr+rkw@mail.gmail.com>
References: <CAGCkR7pSFetC-P4unXU_nyGG9pQj8WrEWUQvwmewQe2aKWdZtQ@mail.gmail.com>
	<CAJ86T=VSTa2h9FBvkXnwRb9S5ZfBs89n_qg+1kOKtww94rS1Jw@mail.gmail.com>
	<CAMKF1sqB1EBkqWYSGFfvr9=wpZhGYFtLTV7Z+VtdCSjfPr+rkw@mail.gmail.com>
From: Viditha Murahari <viditha@mpconsultants.org>
Date: Mon, 24 Jul 2017 10:41:52 -0500
Message-ID: <CAGCkR7r=ver4B7j+hzhw2mA_USS_iXDBC7WQFewKQ3SWJgHukw@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: need help to write a recipe to link a static library to my application
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
X-List-Received-Date: Mon, 24 Jul 2017 15:41:52 -0000
Content-Type: multipart/alternative; boundary="001a1142783ac742c20555120d79"

--001a1142783ac742c20555120d79
Content-Type: text/plain; charset="UTF-8"

Hello Khem Raj,

I did a bitbake -e -c compile -f rttapp  , and this is how my  do_c0mpile
command looks

do_compile() {
        arm-poky-linux-gnueabi-gcc  -march=armv7ve -mfpu=neon
 -mfloat-abi=hard -mcpu=cortex-a7 --sysroot=/home/jeesu/viditha/
imx6ul-evk-audio/build/tmp/sysroots/imx6ulevk  -I/home/jeesu/viditha/imx6ul-
evk-audio/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/rttapp/1.0-r1/include
-DPJ_AUTOCONF=1 -DPJ_IS_BIG_ENDIAN=0 -DPJ_IS_LITTLE_ENDIAN=1 -O2 -pipe -g
-feliminate-unused-debug-types -fdebug-prefix-map=/home/
jeesu/viditha/imx6ul-evk-audio/build/tmp/work/cortexa7hf-neon-poky-linux-
gnueabi/rttapp/1.0-r1=/usr/src/debug/rttapp/1.0-r1 -fdebug-prefix-map=/home/
jeesu/viditha/imx6ul-evk-audio/build/tmp/sysroots/x86_64-linux=
-fdebug-prefix-map=/home/jeesu/viditha/imx6ul-evk-audio/build/tmp/sysroots/imx6ulevk=
 -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -L/home/jeesu/viditha/imx6ul-
evk-audio/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/rttapp/1.0-r1/lib
-lpjsua2-arm-poky-linux-gnueabi -lstdc++ -lpjsua-arm-poky-linux-gnueabi -lm
-lrt -lpthread -lasound rttapp.c -o rttapp
}

and i tried

ls /home/jeesu/viditha/imx6ul-evk-audio/build/tmp/work/
cortexa7hf-neon-poky-linux-gnueabi/rttapp/1.0-r1/lib

jeesu@MPCLinux:~/viditha/imx6ul-evk-audio/build/tmp/
work/cortexa7hf-neon-poky-linux-gnueabi/rttapp/1.0-r1/lib$ ls


libg7221codec-arm-poky-linux-gnueabi.a
libgsmcodec-arm-poky-linux-gnueabi.a
libilbccodec-arm-poky-linux-gnueabi.a
libpj-arm-poky-linux-gnueabi.a
libpjlib-util-arm-poky-linux-gnueabi.a
libpjmedia-arm-poky-linux-gnueabi.a
libpjmedia-audiodev-arm-poky-linux-gnueabi.a
libpjmedia-codec-arm-poky-linux-gnueabi.a
libpjmedia-videodev-arm-poky-linux-gnueabi.a
libpjnath-arm-poky-linux-gnueabi.a
libpjsip-arm-poky-linux-gnueabi.a
libpjsip-simple-arm-poky-linux-gnueabi.a
libpjsip-ua-arm-poky-linux-gnueabi.a
libpjsua2-arm-poky-linux-gnueabi.a
libpjsua-arm-poky-linux-gnueabi.a
libresample-arm-poky-linux-gnueabi.a
libspeex-arm-poky-linux-gnueabi.a
libsrtp-arm-poky-linux-gnueabi.a
pkgconfig

It looks like -L in my compile command is pointing to the right location
for my libraries. So im not clear what im missing. Please help.

On Fri, Jul 21, 2017 at 7:25 PM, Khem Raj <raj.khem@gmail.com> wrote:

>
> On Fri, Jul 21, 2017 at 6:43 PM Andre McCurdy <armccurdy@gmail.com> wrote:
>
>> On Fri, Jul 21, 2017 at 12:11 PM, Viditha Murahari
>> <viditha@mpconsultants.org> wrote:
>> > I'm new to yocto and bitbake and I'm building a voip application for a
>> > custom imx6 board. I want to use  pjsip libraries to build my
>> application, I
>> > have compiled pjsip in my yocto build and generated pjsip libraries (
>> all
>> > pjsip libraries r static). I'm having issues building a recipe for my
>> > application that calls the pjsip functions. Below is how my recipe looks
>> >
>> >
>> > Filename: rttapp.bb
>> >
>> > DESCRIPTION = "Simple voip application"
>> > SECTION = "examples"
>> > LICENSE = "MIT"
>> > LIC_FILES_CHKSUM
>> > ="file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f3
>> 02"
>> > PR = "r1"
>> >
>> > SRC_URI += "file://rttapp.c"
>> > SRC_URI += "file://include"
>> > SRC_URI += "file://lib"
>> >
>> > S = "${WORKDIR}"
>> >
>> > CFLAGS_prepend += "-I${WORKDIR}/include -DPJ_AUTOCONF=1
>> -DPJ_IS_BIG_ENDIAN=0
>> > -DPJ_IS_LITTLE_ENDIAN=1"
>> > LDFLAGS_append += "-L${WORKDIR}/lib -lpjsua2-arm-poky-linux-gnueabi
>> -lstdc++
>> > -lpjsua-arm-poky-linux-gnueabi -lm -lrt -lpthread -lasound"
>> >
>> > do_compile() {
>> > ${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp
>>
>> Try splitting this into two commands. First compile rttapp.c to
>> rttapp.o and then link the final application as a second step. When
>> linking the application, ensure that rttapp.o is listed on the command
>> line before the libraries which provide the symbols it requires.
>>
>> > }
>> >
>> >
>> > When i do bitbake rttapp, the error i see is as below
>> >
>> >
>> > Log data follows:
>> > DEBUG: Executing shell function do_compile
>> > /tmp/cc6nn4Dp.o: In function `main':
>> > /usr/src/debug/rttapp/1.0-r1/rttapp.c:159: undefined reference to
>> > `pjsua_create'
>> > collect2: error: ld returned 1 exit status
>> > WARNING: exit code 1 from a shell command.
>> >
>> >
>> > Please advise
>
>
> You are not having the said libraries in your workdir ensure that either
> you have them via fetcher or via depends
>
>>
>> >
>> > --
>> > _______________________________________________
>> > bitbake-devel mailing list
>> > bitbake-devel@lists.openembedded.org
>> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>> >
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>

--001a1142783ac742c20555120d79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">Hello Khem Raj,</span><di=
v style=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8px">I di=
d a bitbake -e -c compile -f rttapp =C2=A0, and this is how my =C2=A0do_c0m=
pile command looks</div><div style=3D"font-size:12.8px"><br></div><div styl=
e=3D"font-size:12.8px"><div>do_compile() {</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 arm-poky-linux-gnueabi-gcc =C2=A0-march=3Darmv7ve -mfpu=3Dneon =C2=
=A0-mfloat-abi=3Dhard -mcpu=3Dcortex-a7 --sysroot=3D/home/jeesu/viditha/<wb=
r>imx6ul-evk-audio/build/tmp/<wbr>sysroots/imx6ulevk =C2=A0-I/home/jeesu/vi=
ditha/imx6ul-<wbr>evk-audio/build/tmp/work/<wbr>cortexa7hf-neon-poky-linux-=
<wbr>gnueabi/rttapp/1.0-r1/include -DPJ_AUTOCONF=3D1 -DPJ_IS_BIG_ENDIAN=3D0=
 -DPJ_IS_LITTLE_ENDIAN=3D1 -O2 -pipe -g -feliminate-unused-debug-types -fde=
bug-prefix-map=3D/home/<wbr>jeesu/viditha/imx6ul-evk-<wbr>audio/build/tmp/w=
ork/<wbr>cortexa7hf-neon-poky-linux-<wbr>gnueabi/rttapp/1.0-r1=3D/usr/<wbr>=
src/debug/rttapp/1.0-r1 -fdebug-prefix-map=3D/home/<wbr>jeesu/viditha/imx6u=
l-evk-<wbr>audio/build/tmp/sysroots/x86_<wbr>64-linux=3D -fdebug-prefix-map=
=3D/home/<wbr>jeesu/viditha/imx6ul-evk-<wbr>audio/build/tmp/sysroots/<wbr>i=
mx6ulevk=3D =C2=A0-Wl,-O1 -Wl,--hash-style=3Dgnu -Wl,--as-needed -L/home/je=
esu/viditha/imx6ul-<wbr>evk-audio/build/tmp/work/<wbr>cortexa7hf-neon-poky-=
linux-<wbr>gnueabi/rttapp/1.0-r1/lib -lpjsua2-arm-poky-linux-<wbr>gnueabi -=
lstdc++ -lpjsua-arm-poky-linux-gnueabi -lm -lrt -lpthread -lasound rttapp.c=
 -o rttapp</div><div>}</div></div><div style=3D"font-size:12.8px"><br></div=
><div style=3D"font-size:12.8px">and i tried =C2=A0</div><div style=3D"font=
-size:12.8px"><br></div><div style=3D"font-size:12.8px">ls /home/jeesu/vidi=
tha/imx6ul-<wbr>evk-audio/build/tmp/work/<wbr>cortexa7hf-neon-poky-linux-<w=
br>gnueabi/rttapp/1.0-r1/lib</div><div style=3D"font-size:12.8px"><br></div=
><div style=3D"font-size:12.8px"><div>jeesu@MPCLinux:~/viditha/<wbr>imx6ul-=
evk-audio/build/tmp/<wbr>work/cortexa7hf-neon-poky-<wbr>linux-gnueabi/rttap=
p/1.0-r1/<wbr>lib$ ls =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>libg7221code=
c-arm-poky-linux-<wbr>gnueabi.a</div><div>libgsmcodec-arm-poky-linux-<wbr>g=
nueabi.a</div><div>libilbccodec-arm-poky-linux-<wbr>gnueabi.a</div><div>lib=
pj-arm-poky-linux-gnueabi.a</div><div>libpjlib-util-arm-poky-linux-<wbr>gnu=
eabi.a</div><div>libpjmedia-arm-poky-linux-<wbr>gnueabi.a</div><div>libpjme=
dia-audiodev-arm-poky-<wbr>linux-gnueabi.a</div><div>libpjmedia-codec-arm-p=
oky-<wbr>linux-gnueabi.a</div><div>libpjmedia-videodev-arm-poky-<wbr>linux-=
gnueabi.a</div><div>libpjnath-arm-poky-linux-<wbr>gnueabi.a</div><div>libpj=
sip-arm-poky-linux-<wbr>gnueabi.a</div><div>libpjsip-simple-arm-poky-<wbr>l=
inux-gnueabi.a</div><div>libpjsip-ua-arm-poky-linux-<wbr>gnueabi.a</div><di=
v>libpjsua2-arm-poky-linux-<wbr>gnueabi.a</div><div>libpjsua-arm-poky-linux=
-<wbr>gnueabi.a</div><div>libresample-arm-poky-linux-<wbr>gnueabi.a</div><d=
iv>libspeex-arm-poky-linux-<wbr>gnueabi.a</div><div>libsrtp-arm-poky-linux-=
<wbr>gnueabi.a</div><div>pkgconfig</div></div><div style=3D"font-size:12.8p=
x"><br></div><div style=3D"font-size:12.8px">It looks like -L in my compile=
 command is pointing to the right location for my libraries. So im not clea=
r what im missing. Please help.</div></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Fri, Jul 21, 2017 at 7:25 PM, Khem Raj <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:raj.khem@gmail.com" target=3D"_blank">raj.=
khem@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
><br><div class=3D"gmail_quote"><div><div class=3D"h5"><div dir=3D"auto">On=
 Fri, Jul 21, 2017 at 6:43 PM Andre McCurdy &lt;<a href=3D"mailto:armccurdy=
@gmail.com" target=3D"_blank">armccurdy@gmail.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On Fri, Jul 21, 2017 at 12:11 PM, Viditha Mur=
ahari<br>
&lt;<a href=3D"mailto:viditha@mpconsultants.org" target=3D"_blank">viditha@=
mpconsultants.org</a>&gt; wrote:<br>
&gt; I&#39;m new to yocto and bitbake and I&#39;m building a voip applicati=
on for a<br>
&gt; custom imx6 board. I want to use=C2=A0 pjsip libraries to build my app=
lication, I<br>
&gt; have compiled pjsip in my yocto build and generated pjsip libraries ( =
all<br>
&gt; pjsip libraries r static). I&#39;m having issues building a recipe for=
 my<br>
&gt; application that calls the pjsip functions. Below is how my recipe loo=
ks<br>
&gt;<br>
&gt;<br>
&gt; Filename: <a href=3D"http://rttapp.bb" rel=3D"noreferrer" target=3D"_b=
lank">rttapp.bb</a><br>
&gt;<br>
&gt; DESCRIPTION =3D &quot;Simple voip application&quot;<br>
&gt; SECTION =3D &quot;examples&quot;<br>
&gt; LICENSE =3D &quot;MIT&quot;<br>
&gt; LIC_FILES_CHKSUM<br>
&gt; =3D&quot;file://${COMMON_LICENSE_DIR}<wbr>/MIT;md5=3D<wbr>0835ade698e0=
bcf8506ecda2f7b4f3<wbr>02&quot;<br>
&gt; PR =3D &quot;r1&quot;<br>
&gt;<br>
&gt; SRC_URI +=3D &quot;file://rttapp.c&quot;<br>
&gt; SRC_URI +=3D &quot;file://include&quot;<br>
&gt; SRC_URI +=3D &quot;file://lib&quot;<br>
&gt;<br>
&gt; S =3D &quot;${WORKDIR}&quot;<br>
&gt;<br>
&gt; CFLAGS_prepend +=3D &quot;-I${WORKDIR}/include -DPJ_AUTOCONF=3D1 -DPJ_=
IS_BIG_ENDIAN=3D0<br>
&gt; -DPJ_IS_LITTLE_ENDIAN=3D1&quot;<br>
&gt; LDFLAGS_append +=3D &quot;-L${WORKDIR}/lib -lpjsua2-arm-poky-linux-<wb=
r>gnueabi -lstdc++<br>
&gt; -lpjsua-arm-poky-linux-gnueabi -lm -lrt -lpthread -lasound&quot;<br>
&gt;<br>
&gt; do_compile() {<br>
&gt; ${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp<br>
<br>
Try splitting this into two commands. First compile rttapp.c to<br>
rttapp.o and then link the final application as a second step. When<br>
linking the application, ensure that rttapp.o is listed on the command<br>
line before the libraries which provide the symbols it requires.<br>
<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt; When i do bitbake rttapp, the error i see is as below<br>
&gt;<br>
&gt;<br>
&gt; Log data follows:<br>
&gt; DEBUG: Executing shell function do_compile<br>
&gt; /tmp/cc6nn4Dp.o: In function `main&#39;:<br>
&gt; /usr/src/debug/rttapp/1.0-r1/<wbr>rttapp.c:159: undefined reference to=
<br>
&gt; `pjsua_create&#39;<br>
&gt; collect2: error: ld returned 1 exit status<br>
&gt; WARNING: exit code 1 from a shell command.<br>
&gt;<br>
&gt;<br>
&gt; Please advise</blockquote><div dir=3D"auto"><br></div></div></div><div=
 dir=3D"auto">You are not having the said libraries in your workdir ensure =
that either you have them via fetcher or via depends</div><span class=3D"">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br>
&gt;<br>
&gt; --<br>
&gt; ______________________________<wbr>_________________<br>
&gt; bitbake-devel mailing list<br>
&gt; <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_bla=
nk">bitbake-devel@lists.<wbr>openembedded.org</a><br>
&gt; <a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l" rel=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>=
mailman/listinfo/bitbake-devel</a><br>
&gt;<br>
--<br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
</blockquote></span></div></div>
</blockquote></div><br></div>

--001a1142783ac742c20555120d79--
