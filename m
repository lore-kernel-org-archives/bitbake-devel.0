Return-Path: <raj.khem@gmail.com>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
	[209.85.214.66])
	by mail.openembedded.org (Postfix) with ESMTP id 573256011F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 17:11:40 +0000 (UTC)
Received: by mail-it0-f66.google.com with SMTP id 188-v6so7754453ita.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to;
	bh=xS6DJJBLzs9GD21MFr0Q2I8eb9ujDYF1cmqmpZLgFuw=;
	b=P38bI9WWw5GMccXjmSlDG7IEMeQ0WwowAFyNQ6IIKZRPURchF5O48+80tD/AJUM95M
	zFMxvbq4i5iFfI9slW5/z+glvooZkXb/xjt5YuLilYHAZrK516HdGYgPpdTc8m4aaGTP
	ahgErwwFXGEfJnTz+JLq7NuotZ18mHLFRMkOquwopYwJRZD9k5BS+6XhU1jZZo8IqJqY
	npUeDm2N3ynaqclprR4x3bUh6BOjf3/t8lU91MJd4mCQf0d3u2qBama2t1wgB48lCw/P
	eDgjREernRfNkLzx1S2IVS/pnDeIV9un4+GTpff8ZH6IZcctOdWHcqvwOyokWXafW59v
	jqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to;
	bh=xS6DJJBLzs9GD21MFr0Q2I8eb9ujDYF1cmqmpZLgFuw=;
	b=rUn5XJdOazr+yMjpyH+NNDhDkWwKVs6FO1XfNGXttKA7UoI1ZrthDY0hl3we47sdHf
	TWrBR6xTHee3bimpKOrQEeG5oLQpkXNt/Yob4zQZwJrymgHV/owY2CYTWxp1Zkmsx1gV
	ZSf3WS5ap+KJM54FKAINHx36IB4OMxIGFXPfK0okYzJuKtj/dhbdfGO2mu+nTtVTG5VA
	ZmEJEeXOb0k/bQsJ7vhQqY9aFX/wlqVh8GxV/gUUfOiVOcoxCkQKWYeoWxGjawNpjb+1
	juP2aJeNvwrwUkvtvHRoJqWnYGCSUZD4LweLWOlAsY/WfxzucUFw8UTKSQcvLfDIjHQ6
	loSg==
X-Gm-Message-State: AOUpUlGwRmTcaOfCumw9CJKX11BfSHjoXmGzxnR9YvTGC21zeykD2xnM
	go+CveEKa6N84D8L0cnfk3+8TUbR
X-Google-Smtp-Source: AAOMgpevleVaL9chNIohyjuzn9k2SWfyYYn3M6csl/zstDFeAha6NDs+sp+ntPCtFP6YqoczbmkX9g==
X-Received: by 2002:a02:9bc1:: with SMTP id f1-v6mr2391241jal.90.1531415500780;
	Thu, 12 Jul 2018 10:11:40 -0700 (PDT)
Received: from ?IPv6:2620::2b10:e6:4878:c77d:126d:9c0?
	([2620:0:2b10:e6:4878:c77d:126d:9c0])
	by smtp.gmail.com with ESMTPSA id
	q204-v6sm843944itb.27.2018.07.12.10.11.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Jul 2018 10:11:40 -0700 (PDT)
To: "Clay D. Montgomery" <clay@montgomery1.com>,
	bitbake-devel@lists.openembedded.org
References: <5B477CE2.2040602@montgomery1.com>
From: Khem Raj <raj.khem@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=raj.khem@gmail.com; prefer-encrypt=mutual; keydata=
	xsDiBEqXaJERBACUvFofpD3FsxD9675wcPv+rzguIfsRWilrrpSZ61JHjLHwkUnmDLpLSdfv
	Zw2ZDXeaQbGU2thctxXTyYf6N1fY6P5Tww6mWKInuGU3yAv8Mg5p+Xd8itwOoVR41DOBkftV
	miO2G7FtXsnqonB6F43a2yvc+h9OwPRVxAFss5mSmwCglSXPWndN1Ka4M/hzt7g+FmeyEssD
	/1V/G8lLeAS9gQCNjS7jch+uHMFJuWgHzMXdw99e1ywlIkvXN77NPkW+FLVxKxNAHyWZZ3wO
	4BQ9/GVR2y0s/rrF1lQSIcfnUmzZrh/Bh0b1wVOSLhl0Vx4MI0/MbdL3xx17JAWy+s67evuK
	ER4Y8ycTq3gbIGJtVrIJjWPCzWF8BACAA2u52uDmJ2pS8SIhEW0jMK/zYQ5Od9l9fM6BmS6Q
	jnIlzzcuMvRdZn2IrnuE/YoC8yyzBK3mN+MVc2jWN9rfSg6ml7r14Zjem9Ee0O5Ca7Jg3ZvN
	6g3vSlrRJqKgsnq3vdatDF+5rd0NJ7ZKUy6x2i1Pavgtv3qaAgPGa1qQdM0dS2hlbSBSYWog
	PHJhai5raGVtQGdtYWlsLmNvbT7CYAQTEQIAIAUCSpdokQIbAwYLCQgHAwIEFQIIAwQWAgMB
	Ah4BAheAAAoJELsFM1WRnTMUhOMAoJJleT2hdT7uw9Fyn26+w+/K4i0gAJ9wRt36PqfjNe90
	4evWolFf5cMmp87DTQRKl2iREBAAjjbVQ55RAouAe0l0nPsKkWdtMuUHwBdLBkpF3rGM/f0u
	DlPaQzYGLjKT7xDoyRh8x2tFwWvOfiqrZFArxX8e4fsACmJdL0kahTbxC/8SmSWVHXi10JUX
	2fmZ5ufzlXAnl0ivXkWnrUfLX9DdNwL6DR4DeFK9qBFqtHmK5TQXMu87G+MJwgNJIwCKQX4i
	I9YJILMuqInVwaxg5/ALdKfE3QPmtadnKb/cuUm4gICdaJeyQfI6qdYLcSuyBWCbAEMM1wmh
	RAhw5RgzMRRIquZlxPt7lZkXXjals7M6juh87VGRoIJwYoQi97Q1ZHzPBo3AlMPe3haNihkd
	6D3lwvdB4pmjYG4I6bHCgtEhEss3hHvsBaqV9jV1dMUSs95ZxQtT9qtkOxydHgOlwRX3CG+r
	584J/s4vWm+iPQtLvDY1u4UFwOLjCOFe709BcLJdPR2GQiOPoyZF7lVY8nu/dtTrAEuiZFk4
	HD7afUlcr/IKwPWID1V9kRLoDlzdbNuoUy/XfVErK8wcoiGowerEMed4ajNoKxCxBweIkjxq
	KMt8CKgp30n9UxljglEcgf+/UumwSHxqZcCPVbWXtdhy/hwMk27shOdUvaiynep8OsVGqAzS
	seL4qZIJ5XzCcyV4KJCmwmdQzt5+ZylcVmeq6R4ob+d8JIDU0ELqdwxwIDiTj0cAAwUP/inN
	3/r8IFDms4g5xafPrCw31o2jIYahkIfN0WVPWI5K/hFCo2PczPStzDcTsZx7mN2qwpGOe3Lz
	9/0krZeksrz1ZIHNi5LTasuzXyFJbO05Y+eiHgV1rV7VVEipOrpV1496w112Y/0SZ/FhOfEm
	EA1TeDejy2sZiTOUW4gyzewbHMpE07d27F2qM2NfMMhKQCcvzr+N0VJmAOeATEivxPUHn+Dp
	X/NniBWOcWv++wHlxv0Xr63gsRKSt62eFKGjgF50hHD5lM31ziqycc42sbgcqAZ+rYFlb9k0
	3JcKyq1XdVUSm+xcC2DMSstTI6iqFMGo6FnEO+gyE5VdceajbuZ1GOmJXJUCyYIdGuvCyIoK
	jTE9lcIYSEEDZQej5xdiGk9eUz0MPmZEUwSR/nLmmwjHDJi0prVvs9xqe5bvS3ddPAqepvZ5
	UrisgtWD+TDI8ktkt5VLh3XsG9FuXUVAaahOvFMGiZtsioDXTorL4AfMeuA9f+yLwrCVQO3x
	mH/WA0Tgf/5gYB3t9KoHPjLBNruVOuQbAjubi0pvRAOUcMdBfmPofksK4uWS1zGtPWS7Uu1c
	suq7Hnb7vszlFYdbzeqjY81LSyxA0kcpgJxdLv9o7UuCEnHDZLPbHdQ83PmyyBKSI31AKe7R
	XlQNlB5grwH9o6uNtPbV7q/uRqmKq5EiwkkEGBECAAkFAkqXaJECGwwACgkQuwUzVZGdMxR1
	VACcCkdaO3rb8/gRprldmAH6eR49eo4AnjD3h3aTwv/1bl+BAz1twmZmz8ul
Message-ID: <5cd8d33e-435c-a6ad-9b0a-bd64a23c0fd7@gmail.com>
Date: Thu, 12 Jul 2018 11:11:35 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
	Gecko/20100101 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5B477CE2.2040602@montgomery1.com>
Subject: Re: Can't start menuconfig with Bitbake
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
X-List-Received-Date: Thu, 12 Jul 2018 17:11:40 -0000
X-Groupsio-MsgNum: 9386
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="kZ2f4SJcCkD8QrTynuaMkfQ9s4Xg50QeW"

--kZ2f4SJcCkD8QrTynuaMkfQ9s4Xg50QeW
Content-Type: multipart/mixed; boundary="FD2WZzhGO6GSzQhnYvFVQXwyNTCoJYhQN";
 protected-headers="v1"
From: Khem Raj <raj.khem@gmail.com>
To: "Clay D. Montgomery" <clay@montgomery1.com>,
 bitbake-devel@lists.openembedded.org
Message-ID: <5cd8d33e-435c-a6ad-9b0a-bd64a23c0fd7@gmail.com>
Subject: Re: [bitbake-devel] Can't start menuconfig with Bitbake
References: <5B477CE2.2040602@montgomery1.com>
In-Reply-To: <5B477CE2.2040602@montgomery1.com>

--FD2WZzhGO6GSzQhnYvFVQXwyNTCoJYhQN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/12/18 10:08 AM, Clay D. Montgomery wrote:
> Hello,
>=20
> =C2=A0=C2=A0 I am having a basic problem with trying to use Bitbake to =
run
> menuconfig.
> Bitbake otherwise works fine for me. I have done many large builds of
> Yocto.
>=20
> =C2=A0I am running on a Ubuntu 14.04 32-bit system which is up to date,=
 but
> the RAM is limited to 4 GB.
> I have pasted a sample of the errors I get below.=C2=A0 I shortened thi=
s
> considerably.
>=20
> I would appreciate any advice on how to resolve this.
>=20
> Thanks, Clay Montgomery
>=20
>=20
>=20
> bitbake -c menuconfig virtual/kernel
>=20
>=20
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0 ./Makefile
> =C2=A0 HOSTLD=C2=A0 scripts/kconfig/mconf
> scripts/kconfig/mconf.o: In function `show_help':
> mconf.c:(.text+0x927): undefined reference to `stdscr'
> scripts/kconfig/lxdialog/checklist.o: In function `print_arrows':
> checklist.c:(.text+0x31): undefined reference to `wmove'
> checklist.c:(.text+0x4e): undefined reference to `acs_map'
> checklist.c:(.text+0x5a): undefined reference to `waddch'
> util.c:(.text+0x1826): undefined reference to `keypad'
> util.c:(.text+0x182e): undefined reference to `wgetch'
> util.c:(.text+0x1838): undefined reference to `wgetch'
> menubox.c:(.text+0x11db): undefined reference to `acs_map'
> menubox.c:(.text+0x11eb): undefined reference to `waddch'
> menubox.c:(.text+0x1278): undefined reference to `scrollok'
> scripts/kconfig/lxdialog/menubox.o: In function `do_print_item':
> menubox.c:(.text+0x1ab): undefined reference to `wrefresh'
> scripts/kconfig/lxdialog/menubox.o: In function `print_buttons':
> menubox.c:(.text+0x356): undefined reference to `wrefresh'
> scripts/kconfig/lxdialog/menubox.o: In function `print_arrows.constprop=
=2E0':
> menubox.c:(.text+0x478): undefined reference to `wrefresh'
> collect2: error: ld returned 1 exit status
> make[3]: *** [scripts/kconfig/mconf] Error 1
> make[2]: *** [menuconfig] Error 2
> make[1]: *** [sub-make] Error 2
> make: *** [__sub-make] Error 2
> Command failed.
> Press any key to continue...
>=20
>=20

it means its missing ncurses library and development headers on your
build host. this task should generally depend on ncurses-native as here

meta/classes/cml1.bbclass:do_menuconfig[depends] +=3D
"ncurses-native:do_populate_sysroot"

I don't know why this is not working in your case. May be another
workaround is to just install ncurses-dev on your build host.


--FD2WZzhGO6GSzQhnYvFVQXwyNTCoJYhQN--

--kZ2f4SJcCkD8QrTynuaMkfQ9s4Xg50QeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSPpVvapDR0rgZCCc27BTNVkZ0zFAUCW0eLxwAKCRC7BTNVkZ0z
FC9kAJ9hstCt7oEjTTZKZuRuEqr49kWBmACcCHTt52L31uDwhx8pyD3DVcwHYWw=
=Sfub
-----END PGP SIGNATURE-----

--kZ2f4SJcCkD8QrTynuaMkfQ9s4Xg50QeW--
