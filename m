Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id AFC15775DA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jul 2017 22:42:59 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id e131so24709072wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jul 2017 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=wVp876JstIWiVUeUBJm4s6rH/UXbbV1HltnhpGKiXOk=;
	b=YYmefeD+7ofAKLaajx4lVhw4cclr5pKyhVZYD+GslARK5oTxN4pbq5gQrpbvvdGA/3
	CDCyUYDs4yIDz18gnq9B449yufNv5/RMmmdzJukoq1OTNYR4D3gVZUIWmXP88SnEt4Xe
	1VOiljQcViICzTJ739Wh2panL78IJtvRJxnaPQ/d+yhkMMtuay7vGtehe4y6duh7PpQT
	5uemn/qUDW5XprQlnXo1DCRi0lYijotpBY/ELQ0ckOruLrUd74fqyT4oHzZv5fAP+fmY
	FRaYwOjEuaHNrJVnq/GqISVRqMH1SZiblrJ6WuDg3Y0d1jLquz3OMvuqXSqP7htGgtK4
	TcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=wVp876JstIWiVUeUBJm4s6rH/UXbbV1HltnhpGKiXOk=;
	b=E1Dx9DsvHaKRENhTD5TFLGiTiUMgPvuZB8+Itiqx2bwEiBVDmsiilopWv80vgWQGhC
	nOtmaUKuwsHy8oakN61mDNpjRXiAJKJbqFyluDodRvTt5uxIgkB5q5wbsf9zcpgG8bAc
	LaNZh1wcD+SRofmhyJRpC9JW8ZsORLYri9+o0MJxGodxi3B+3uBseyfzIbWzk4WC6aRD
	B/Hj/pa2hzji/ZNzi0r8qMp8H5NQAYyzrOie/QrLvC6bX3/4g4mtRjMopsk0wfX2ALO4
	GBagP3/phhiAqt6SsGNSJK/8k50B28YOTGJfLhp0X2ALW7ZgCT305aOPoPc2aiT7py+7
	/GJQ==
X-Gm-Message-State: AIVw110r4+CBJaF1gfy50FO5Cb6UOAUpve1kR/k006wdmO/9bj8jhS/V
	ZQCm3DSVh4dAtBYToE8kU/61Lq/3l851
X-Received: by 10.28.37.193 with SMTP id l184mr375344wml.24.1500676980423;
	Fri, 21 Jul 2017 15:43:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.175.16 with HTTP; Fri, 21 Jul 2017 15:42:59 -0700 (PDT)
In-Reply-To: <CAGCkR7pSFetC-P4unXU_nyGG9pQj8WrEWUQvwmewQe2aKWdZtQ@mail.gmail.com>
References: <CAGCkR7pSFetC-P4unXU_nyGG9pQj8WrEWUQvwmewQe2aKWdZtQ@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Fri, 21 Jul 2017 15:42:59 -0700
Message-ID: <CAJ86T=VSTa2h9FBvkXnwRb9S5ZfBs89n_qg+1kOKtww94rS1Jw@mail.gmail.com>
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
X-List-Received-Date: Fri, 21 Jul 2017 22:43:00 -0000
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 21, 2017 at 12:11 PM, Viditha Murahari
<viditha@mpconsultants.org> wrote:
> I'm new to yocto and bitbake and I'm building a voip application for a
> custom imx6 board. I want to use  pjsip libraries to build my application, I
> have compiled pjsip in my yocto build and generated pjsip libraries ( all
> pjsip libraries r static). I'm having issues building a recipe for my
> application that calls the pjsip functions. Below is how my recipe looks
>
>
> Filename: rttapp.bb
>
> DESCRIPTION = "Simple voip application"
> SECTION = "examples"
> LICENSE = "MIT"
> LIC_FILES_CHKSUM
> ="file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
> PR = "r1"
>
> SRC_URI += "file://rttapp.c"
> SRC_URI += "file://include"
> SRC_URI += "file://lib"
>
> S = "${WORKDIR}"
>
> CFLAGS_prepend += "-I${WORKDIR}/include -DPJ_AUTOCONF=1 -DPJ_IS_BIG_ENDIAN=0
> -DPJ_IS_LITTLE_ENDIAN=1"
> LDFLAGS_append += "-L${WORKDIR}/lib -lpjsua2-arm-poky-linux-gnueabi -lstdc++
> -lpjsua-arm-poky-linux-gnueabi -lm -lrt -lpthread -lasound"
>
> do_compile() {
> ${CC} ${CFLAGS} ${LDFLAGS} rttapp.c -o rttapp

Try splitting this into two commands. First compile rttapp.c to
rttapp.o and then link the final application as a second step. When
linking the application, ensure that rttapp.o is listed on the command
line before the libraries which provide the symbols it requires.

> }
>
>
> When i do bitbake rttapp, the error i see is as below
>
>
> Log data follows:
> DEBUG: Executing shell function do_compile
> /tmp/cc6nn4Dp.o: In function `main':
> /usr/src/debug/rttapp/1.0-r1/rttapp.c:159: undefined reference to
> `pjsua_create'
> collect2: error: ld returned 1 exit status
> WARNING: exit code 1 from a shell command.
>
>
> Please advise
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

