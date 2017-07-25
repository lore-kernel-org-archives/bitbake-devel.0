Return-Path: <raj.khem@gmail.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 3DA9E781F4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jul 2017 17:40:58 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id t201so52291944wmt.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jul 2017 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=vO6EF0/1TOxng3UWHCDWb9Bh5eg8EToCXHWJLLV7U6k=;
	b=C7jUHZ1u078h+LG/9RGfp+khBACJPggn349ma0Cu6qVdVj81ffwuPGvV6WdPk5dTOD
	7XDlzHM+7E+ukwrK8/Sb5Reh2+vHdeUFS1OgWckXSU5uM+QFPhZ2iIWB3k846NbXKy/c
	itrVwLB4F1hSe6HR4ITu3ew8tXfusPDDtcrmyzjrhi565dKdgti+gzFFA3Jw9urw+pU7
	rUcp3fKvlYj2mrlJnbiOA2iCE1ZEvJIOtSfd1tP7loPM2RS6Z2HbjeacS7JHp4FT3wtH
	YT+EtOuLtcVQUDGtcjzzc9NMGKcARoeq3sWBkmrOxzW/YwfkPp9AQQY6mA/1GSJ+PeIw
	pO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=vO6EF0/1TOxng3UWHCDWb9Bh5eg8EToCXHWJLLV7U6k=;
	b=LtImBwhod/P6h1dDt8QElLpzM3aBQf+0gCvM6CxytIaPyC8bKjasFDqM1IDtFi97Ke
	g4ahk5Y6lJA4/JXPAluwAXaoMrYNfcdaPhqxNzDD57NaGKyR6P3MJicCozpDdvJj+WuX
	CazdmoxR3wSbiVq+cou2kmGXxwg7JdpSZrRO4pkWHEqQ5oPw4bqsP++b4/bGf+pVsD0f
	4vzBG9sqXhI5pwW5mU5W9YMu7IPp4XTM6eBard7ecCN8SwznMijYjxXZpsvcIWq268oG
	5bepIoG8e3vRud1f8l+77siAvbHevb6tJq0n8XdynbIbRPuF4eRX9EwPsFNjxBC5qnpp
	xbSA==
X-Gm-Message-State: AIVw112SksVr8fEeHzIxNQFHHGQj2p2Q+lGNwpWodk/BsQ/p2DG63ZKt
	CzajHVDUUvAPEQCN0/1PxXzp0nJ3xA==
X-Received: by 10.80.164.18 with SMTP id u18mr4168088edb.250.1501004459550;
	Tue, 25 Jul 2017 10:40:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.149.181 with HTTP; Tue, 25 Jul 2017 10:40:29 -0700 (PDT)
In-Reply-To: <CAGCkR7qiBto2+Sc0KMBfNQsLdfayGBBqmVg6xL8xVFexiCOc8w@mail.gmail.com>
References: <CAGCkR7pSFetC-P4unXU_nyGG9pQj8WrEWUQvwmewQe2aKWdZtQ@mail.gmail.com>
	<CAJ86T=VSTa2h9FBvkXnwRb9S5ZfBs89n_qg+1kOKtww94rS1Jw@mail.gmail.com>
	<CAMKF1sqB1EBkqWYSGFfvr9=wpZhGYFtLTV7Z+VtdCSjfPr+rkw@mail.gmail.com>
	<CAGCkR7r=ver4B7j+hzhw2mA_USS_iXDBC7WQFewKQ3SWJgHukw@mail.gmail.com>
	<CAGCkR7qiBto2+Sc0KMBfNQsLdfayGBBqmVg6xL8xVFexiCOc8w@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 25 Jul 2017 10:40:29 -0700
Message-ID: <CAMKF1srSHAPjDrtA-J8578V=kq79cRMaGi8VGf+Dsw5CSZPvYQ@mail.gmail.com>
To: Viditha Murahari <viditha@mpconsultants.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Tue, 25 Jul 2017 17:40:59 -0000
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 25, 2017 at 8:46 AM, Viditha Murahari
<viditha@mpconsultants.org> wrote:
> Figured out the issue, it was actually a silly mistake
>
> ${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp
> should have been
> ${CC} rttapp.c ${CFLAGS} ${LDFLAGS} -o rttapp
>
good. yes link order is important

> On Mon, Jul 24, 2017 at 10:41 AM, Viditha Murahari
> <viditha@mpconsultants.org> wrote:
>>
>> Hello Khem Raj,
>>
>> I did a bitbake -e -c compile -f rttapp  , and this is how my  do_c0mpile
>> command looks
>>
>> do_compile() {
>>         arm-poky-linux-gnueabi-gcc  -march=armv7ve -mfpu=neon
>> -mfloat-abi=hard -mcpu=cortex-a7
>> --sysroot=/home/jeesu/viditha/imx6ul-evk-audio/build/tmp/sysroots/imx6ulevk
>> -I/home/jeesu/viditha/imx6ul-evk-audio/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/rttapp/1.0-r1/include
>> -DPJ_AUTOCONF=1 -DPJ_IS_BIG_ENDIAN=0 -DPJ_IS_LITTLE_ENDIAN=1 -O2 -pipe -g
>> -feliminate-unused-debug-types
>> -fdebug-prefix-map=/home/jeesu/viditha/imx6ul-evk-audio/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/rttapp/1.0-r1=/usr/src/debug/rttapp/1.0-r1
>> -fdebug-prefix-map=/home/jeesu/viditha/imx6ul-evk-audio/build/tmp/sysroots/x86_64-linux=
>> -fdebug-prefix-map=/home/jeesu/viditha/imx6ul-evk-audio/build/tmp/sysroots/imx6ulevk=
>> -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed
>> -L/home/jeesu/viditha/imx6ul-evk-audio/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/rttapp/1.0-r1/lib
>> -lpjsua2-arm-poky-linux-gnueabi -lstdc++ -lpjsua-arm-poky-linux-gnueabi -lm
>> -lrt -lpthread -lasound rttapp.c -o rttapp
>> }
>>
>> and i tried
>>
>> ls
>> /home/jeesu/viditha/imx6ul-evk-audio/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/rttapp/1.0-r1/lib
>>
>>
>> jeesu@MPCLinux:~/viditha/imx6ul-evk-audio/build/tmp/work/cortexa7hf-neon-poky-linux-gnueabi/rttapp/1.0-r1/lib$
>> ls
>> libg7221codec-arm-poky-linux-gnueabi.a
>> libgsmcodec-arm-poky-linux-gnueabi.a
>> libilbccodec-arm-poky-linux-gnueabi.a
>> libpj-arm-poky-linux-gnueabi.a
>> libpjlib-util-arm-poky-linux-gnueabi.a
>> libpjmedia-arm-poky-linux-gnueabi.a
>> libpjmedia-audiodev-arm-poky-linux-gnueabi.a
>> libpjmedia-codec-arm-poky-linux-gnueabi.a
>> libpjmedia-videodev-arm-poky-linux-gnueabi.a
>> libpjnath-arm-poky-linux-gnueabi.a
>> libpjsip-arm-poky-linux-gnueabi.a
>> libpjsip-simple-arm-poky-linux-gnueabi.a
>> libpjsip-ua-arm-poky-linux-gnueabi.a
>> libpjsua2-arm-poky-linux-gnueabi.a
>> libpjsua-arm-poky-linux-gnueabi.a
>> libresample-arm-poky-linux-gnueabi.a
>> libspeex-arm-poky-linux-gnueabi.a
>> libsrtp-arm-poky-linux-gnueabi.a
>> pkgconfig
>>
>> It looks like -L in my compile command is pointing to the right location
>> for my libraries. So im not clear what im missing. Please help.
>>
>> On Fri, Jul 21, 2017 at 7:25 PM, Khem Raj <raj.khem@gmail.com> wrote:
>>>
>>>
>>> On Fri, Jul 21, 2017 at 6:43 PM Andre McCurdy <armccurdy@gmail.com>
>>> wrote:
>>>>
>>>> On Fri, Jul 21, 2017 at 12:11 PM, Viditha Murahari
>>>> <viditha@mpconsultants.org> wrote:
>>>> > I'm new to yocto and bitbake and I'm building a voip application for a
>>>> > custom imx6 board. I want to use  pjsip libraries to build my
>>>> > application, I
>>>> > have compiled pjsip in my yocto build and generated pjsip libraries (
>>>> > all
>>>> > pjsip libraries r static). I'm having issues building a recipe for my
>>>> > application that calls the pjsip functions. Below is how my recipe
>>>> > looks
>>>> >
>>>> >
>>>> > Filename: rttapp.bb
>>>> >
>>>> > DESCRIPTION = "Simple voip application"
>>>> > SECTION = "examples"
>>>> > LICENSE = "MIT"
>>>> > LIC_FILES_CHKSUM
>>>> >
>>>> > ="file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
>>>> > PR = "r1"
>>>> >
>>>> > SRC_URI += "file://rttapp.c"
>>>> > SRC_URI += "file://include"
>>>> > SRC_URI += "file://lib"
>>>> >
>>>> > S = "${WORKDIR}"
>>>> >
>>>> > CFLAGS_prepend += "-I${WORKDIR}/include -DPJ_AUTOCONF=1
>>>> > -DPJ_IS_BIG_ENDIAN=0
>>>> > -DPJ_IS_LITTLE_ENDIAN=1"
>>>> > LDFLAGS_append += "-L${WORKDIR}/lib -lpjsua2-arm-poky-linux-gnueabi
>>>> > -lstdc++
>>>> > -lpjsua-arm-poky-linux-gnueabi -lm -lrt -lpthread -lasound"
>>>> >
>>>> > do_compile() {
>>>> > ${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp
>>>>
>>>> Try splitting this into two commands. First compile rttapp.c to
>>>> rttapp.o and then link the final application as a second step. When
>>>> linking the application, ensure that rttapp.o is listed on the command
>>>> line before the libraries which provide the symbols it requires.
>>>>
>>>> > }
>>>> >
>>>> >
>>>> > When i do bitbake rttapp, the error i see is as below
>>>> >
>>>> >
>>>> > Log data follows:
>>>> > DEBUG: Executing shell function do_compile
>>>> > /tmp/cc6nn4Dp.o: In function `main':
>>>> > /usr/src/debug/rttapp/1.0-r1/rttapp.c:159: undefined reference to
>>>> > `pjsua_create'
>>>> > collect2: error: ld returned 1 exit status
>>>> > WARNING: exit code 1 from a shell command.
>>>> >
>>>> >
>>>> > Please advise
>>>
>>>
>>> You are not having the said libraries in your workdir ensure that either
>>> you have them via fetcher or via depends
>>>>
>>>>
>>>> >
>>>> > --
>>>> > _______________________________________________
>>>> > bitbake-devel mailing list
>>>> > bitbake-devel@lists.openembedded.org
>>>> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>>> >
>>>> --
>>>> _______________________________________________
>>>> bitbake-devel mailing list
>>>> bitbake-devel@lists.openembedded.org
>>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>>
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

