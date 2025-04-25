Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECCAC369D5
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 12:35:49 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.5535.1745584544852296882
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 05:35:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B7ez7UPR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so1996317f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745584543; x=1746189343; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VSUSByd/KNUODBLW1ziA0v6UZ1z+apiPF2hcwmI+ki4=;
        b=B7ez7UPRFkCKu+yI/ecv6RlsNYAKF6w/ooo70jlzegOQn+OnzR11Y8TcbI+SwQI0bK
         npUr/oTf7PxImBhKE8NNT5WXlixjBA7oCrElnodwKUa7qfvdgKJCPbsjd1bKjm4TaYWY
         4Ma/HWY1tDRTzxXnA0HLgkff/SP7dAwX3jDow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745584543; x=1746189343;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSUSByd/KNUODBLW1ziA0v6UZ1z+apiPF2hcwmI+ki4=;
        b=CFJ6AwcpBmjypvtKfof979n+UR4crFaPGvDux8DQ9Srh9I/sHMeHMSI1piamlXCVHQ
         n4cmvifiDH01LioxsK3/EejQAxxQXSGogUbQlQhwFcNZoaA+nqmrKOhrotEHbtDOci9D
         J5gXJbXyZccxVdO7OdrxlL5f+hHekjU/VT0qi07Au0CEYFuVzUc2G5aWvgq1RQmXaE9E
         wV2wU1UDru7SQdjM5YlennzSbm+Q124V5HDxrs0+39QR2SF8rFxfFvuli9yBOSGV5Ilm
         oYfGxW3ppTZuzg8sXwyvyiirWnuIzi5Ati2irZz0iAsLKpxJS5GbV+GO8PCy0dM+Q7ke
         l0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXoSb1GYmObUcJBH8NpJdUyJ6AM6NZ5fppI51GQmB9Z0VYlsBwWDTkqIrDnzPHcXbJ/EA1LoS+kMjtopJ8V@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxv85DJLXQDz4tvXalJ3uT+p2CaF3rzuyVJLjRx9R/XH+A0Y86t
	RHdPwyoBmM151ZoaohkZNxewycVKeYPCcEYcbzK02tMvHaVf4cn4u7qrcQhVw8c=
X-Gm-Gg: ASbGncvDttz046MXDdN6qDluP5xSvzzz8xze1YslZ2+n2faLbVUccXoHoTSFpwWwakr
	/ksyhQOty+vs58Uf8aZTAo1lrCqhkJ9TF+1IZosei19pTuA92V1XbSZBB5AgApyknwDIzwecX3J
	7T8MSzmMJI2ly51qX59/xqjCliZIVrIaBwJ92iloeqdjXNxCdXMvGIFojYWY6JRLmu0NqOk7Hrf
	s48G+6oj0Drvan/nPOV2KDu/U9CFgg0bkopobWZpgpgk6oX7bn+aITadIbV0EteIfOTf0drOQsn
	lYSF/DJpHtJvBjXLA7EosslVin7NEkOBlG0lQWYX6I/PAUOpsdp+fx9phJS8aIYBI8dLJLLVdoF
	GvtpwA9lPItZoe/3k19kx2EOnCfxpZg==
X-Google-Smtp-Source: AGHT+IHyp8eh2V+c+pulN4bHNXRy7FhjAT3rjpn/F5j9S7rlRY6JHNcS/zIS94sAjD2XcL03qDdxhg==
X-Received: by 2002:a05:6000:18a8:b0:39c:2678:302e with SMTP id ffacd0b85a97d-3a074f1089bmr1746963f8f.45.1745584542832;
        Fri, 25 Apr 2025 05:35:42 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4b43:cc8c:5e78:12c1? ([2001:8b0:aba:5f3c:4b43:cc8c:5e78:12c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbdb78sm2219945f8f.41.2025.04.25.05.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:35:41 -0700 (PDT)
Message-ID: <522a15ccc1ed1597a5a6b92803536484a3f008a4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/8] Fix gitsm LFS support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: philip.lorenz@bmw.de, bitbake-devel@lists.openembedded.org
Cc: mathieu.dubois-briand@bootlin.com
Date: Fri, 25 Apr 2025 13:35:41 +0100
In-Reply-To: <20250425101155.2905972-1-philip.lorenz@bmw.de>
References: <20250425101155.2905972-1-philip.lorenz@bmw.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 12:35:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17565

On Fri, 2025-04-25 at 12:11 +0200, Philip Lorenz via lists.openembedded.org=
 wrote:
> This patch series fixes a number of issues we observed when using the
> gitsm fetcher in conjunction with git-lfs.
>=20
> I'd like to highlight two patches in this series:
> * 0004-fetch2-Simplify-git-LFS-detection: I could not come up with a
> =C2=A0 good reason on why the code so far preferred the content of
> =C2=A0`.gitattributes` on the repository's branch instead of always
> =C2=A0 considering the state of the target revision. Please let me know
> =C2=A0 if there's something I didn't take into account.
> * 0005-fetch2-Use-git-lfs-fetch-to-download-objects.patch: I could not
> =C2=A0 replicate the `git-lfs fetch` behaviour in versions going back to
> =C2=A0 2.13.2 released in 2021. This leads me to believe that the issue
> =C2=A0 leading to this workaround is no longer in place. However, if anyo=
ne
> =C2=A0 remembers the actual issue / versions involved I can also retest t=
o
> =C2=A0 confirm that there are no regression.
>=20
> ---
> V1 -> V2:
> * The correct parameter is now passed for each submodule URL when LFS is
> =C2=A0 explicitly disabled
> * Smudging for submodules is now skipped when LFS is explcitly disabled.
> =C2=A0 This ensures consistent behaviour in setups where git-lfs is insta=
lled
> =C2=A0 but should not be used.
> * Test cases are extended to test the LFS disabled state.
> * Explicitly install git lfs into submodule in the test cases to make
> =C2=A0 sure that git-lfs is actually used for storing the files.
>=20
> Philip Lorenz (8):
> =C2=A0 fetch2: Clean up no longer used name parameter
> =C2=A0 tests/fetch: Move commonly used imports to top
> =C2=A0 fetch2: Check for git-lfs existence before using it
> =C2=A0 fetch2: Simplify git LFS detection
> =C2=A0 fetch2: Use git-lfs fetch to download objects
> =C2=A0 fetch2: Fix incorrect lfs parametrization for submodules
> =C2=A0 fetch2: Fix LFS object checkout in submodules
> =C2=A0 tests/fetch: Test gitsm with LFS
>=20
> =C2=A0lib/bb/fetch2/git.py=C2=A0=C2=A0 |=C2=A0 69 ++++++----------
> =C2=A0lib/bb/fetch2/gitsm.py |=C2=A0 13 ++-
> =C2=A0lib/bb/tests/fetch.py=C2=A0 | 183 ++++++++++++++++++++++++++++++---=
--------
> =C2=A03 files changed, 163 insertions(+), 102 deletions(-)

With this series applied, OE-Core throws a lot of errors, see below.
I'm not convinced we have that much LFS use so something seems wrong...

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/1465/ste=
ps/13/logs/stdio

Cheers,

Richard

stdio: ERROR: acpica-20240827-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/acpica/acpica has LFS content, install git=
-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: acpica-native-20240827-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/acpica/acpica has LFS content, inst=
all git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: argp-standalone-1.4.1-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/ericonr/argp-standalone has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: asciidoc-10.2.1-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/asciidoc/asciidoc-py has LFS content, inst=
all git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: asciidoc-native-10.2.1-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/asciidoc/asciidoc-py has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: avahi-libnss-mdns-0.15.1-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/lathiat/nss-mdns has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: babeltrace-1.5.11-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://git.efficios.com/babeltrace.git has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: babeltrace2-2.1.0-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://git.efficios.com/babeltrace.git has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: baremetal-helloworld-0.1+git-r0 do_fetch: Bitbake Fetcher Err=
or: FetchError('Repository https://github.com/ahcbb6/baremetal-helloqemu.gi=
t has LFS content, install git-lfs on host to download (or set lfs=3D0 to i=
gnore it)', None)
stdio: ERROR: bindgen-cli-0.71.1-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/rust-lang/rust-bindgen.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: bindgen-cli-native-0.71.1-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/rust-lang/rust-bindgen.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: binutils-2.44-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://sourceware.org/git/binutils-gdb.git has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: binutils-cross-canadian-x86-64-2.44-r0 do_fetch: Bitbake Fetc=
her Error: FetchError('Repository https://sourceware.org/git/binutils-gdb.g=
it has LFS content, install git-lfs on host to download (or set lfs=3D0 to =
ignore it)', None)
stdio: ERROR: binutils-crosssdk-x86_64-pokysdk-linux-2.44-r0 do_fetch: Bitb=
ake Fetcher Error: FetchError('Repository https://sourceware.org/git/binuti=
ls-gdb.git has LFS content, install git-lfs on host to download (or set lfs=
=3D0 to ignore it)', None)
stdio: ERROR: binutils-cross-x86_64-2.44-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://sourceware.org/git/binutils-gdb.git has LF=
S content, install git-lfs on host to download (or set lfs=3D0 to ignore it=
)', None)
stdio: ERROR: binutils-native-2.44-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://sourceware.org/git/binutils-gdb.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: binutils-testsuite-2.44-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://sourceware.org/git/binutils-gdb.git has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: blktrace-1.3.0+git-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://git.kernel.dk/blktrace.git has LFS content, instal=
l git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: bmaptool-3.9.0+git-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/yoctoproject/bmaptool has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: bmaptool-native-3.9.0+git-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/yoctoproject/bmaptool has LFS co=
ntent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', =
None)
stdio: ERROR: boost-build-native-1_1.87.0-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://github.com/boostorg/build has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: bootchart2-0.14.9-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://github.com/xrmx/bootchart.git has LFS content, inst=
all git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: bootchart2-native-0.14.9-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/xrmx/bootchart.git has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: btrfs-tools-6.14-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://github.com/kdave/btrfs-progs.git has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: btrfs-tools-native-6.14-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://github.com/kdave/btrfs-progs.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: build-appliance-image-15.0.0-r0 do_fetch: Bitbake Fetcher Err=
or: FetchError('Repository git://git.yoctoproject.org/poky has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: bzip2-1.0.8-r0 do_fetch: Bitbake Fetcher Error: FetchError('R=
epository https://sourceware.org/git/bzip2-tests.git has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: connman-gnome-0.7-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://github.com/connectivity/connman-gnome.git has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: cracklib-2.10.3-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/cracklib/cracklib has LFS content, install=
 git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: cracklib-native-2.10.3-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/cracklib/cracklib has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: createrepo-c-1.2.1-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/rpm-software-management/createrepo_c ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)', None)
stdio: ERROR: createrepo-c-native-1.2.1-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/rpm-software-management/createre=
po_c has LFS content, install git-lfs on host to download (or set lfs=3D0 t=
o ignore it)', None)
stdio: ERROR: cross-localedef-native-2.41+git-r0 do_fetch: Bitbake Fetcher =
Error: FetchError('Repository https://sourceware.org/git/glibc.git has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: cryptodev-linux-1.14-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/cryptodev-linux/cryptodev-linux has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: cryptodev-linux-native-1.14-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://github.com/cryptodev-linux/cryptodev-linu=
x has LFS content, install git-lfs on host to download (or set lfs=3D0 to i=
gnore it)', None)
stdio: ERROR: cryptodev-module-1.14-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/cryptodev-linux/cryptodev-linux has =
LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore =
it)', None)
stdio: ERROR: cryptodev-tests-1.14-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/cryptodev-linux/cryptodev-linux has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: dbus-wait-0.1+git-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://git.yoctoproject.org/dbus-wait has LFS content, ins=
tall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: debianutils-5.21-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://salsa.debian.org/debian/debianutils.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: debianutils-native-5.21-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://salsa.debian.org/debian/debianutils.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: devtool-upgrade-test2-0.1+git-r2 do_fetch: Bitbake Fetcher Er=
ror: FetchError('Repository git://git.yoctoproject.org/dbus-wait has LFS co=
ntent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', =
None)
stdio: ERROR: dhcpcd-10.2.2-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://github.com/NetworkConfiguration/dhcpcd has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: distcc-3.4-r0 do_fetch: Bitbake Fetcher Error: FetchError('Re=
pository https://github.com/distcc/distcc.git has LFS content, install git-=
lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: dnf-4.22.0-r0 do_fetch: Bitbake Fetcher Error: FetchError('Re=
pository https://github.com/rpm-software-management/dnf.git has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: dnf-native-4.22.0-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://github.com/rpm-software-management/dnf.git has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: dos2unix-7.5.2-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://git.code.sf.net/p/dos2unix/dos2unix has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: dos2unix-native-7.5.2-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://git.code.sf.net/p/dos2unix/dos2unix has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: dpkg-1.22.11-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://salsa.debian.org/dpkg-team/dpkg.git has LFS content, ins=
tall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: dpkg-native-1.22.11-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://salsa.debian.org/dpkg-team/dpkg.git has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: dtc-1.7.2-r0 do_fetch: Bitbake Fetcher Error: FetchError('Rep=
ository https://git.kernel.org/pub/scm/utils/dtc/dtc.git has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: dtc-native-1.7.2-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://git.kernel.org/pub/scm/utils/dtc/dtc.git has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: e2fsprogs-1.47.1-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git has LFS=
 content, install git-lfs on host to download (or set lfs=3D0 to ignore it)=
', None)
stdio: ERROR: e2fsprogs-native-1.47.1-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git =
has LFS content, install git-lfs on host to download (or set lfs=3D0 to ign=
ore it)', None)
stdio: ERROR: efibootmgr-18-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://github.com/rhinstaller/efibootmgr.git has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: efivar-39-r0 do_fetch: Bitbake Fetcher Error: FetchError('Rep=
ository https://github.com/rhinstaller/efivar.git has LFS content, install =
git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: efivar-native-39-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://github.com/rhinstaller/efivar.git has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: erofs-utils-1.8.5-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs=
-utils.git has LFS content, install git-lfs on host to download (or set lfs=
=3D0 to ignore it)', None)
stdio: ERROR: erofs-utils-native-1.8.5-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://git.kernel.org/pub/scm/linux/kernel/git/xian=
g/erofs-utils.git has LFS content, install git-lfs on host to download (or =
set lfs=3D0 to ignore it)', None)
stdio: ERROR: fastfloat-8.0.2-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/fastfloat/fast_float.git has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: file-5.46-r0 do_fetch: Bitbake Fetcher Error: FetchError('Rep=
ository https://github.com/file/file.git has LFS content, install git-lfs o=
n host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: fmt-11.1.4-r0 do_fetch: Bitbake Fetcher Error: FetchError('Re=
pository https://github.com/fmtlib/fmt has LFS content, install git-lfs on =
host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: fmt-native-11.1.4-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://github.com/fmtlib/fmt has LFS content, install git-=
lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: fts-1.2.7-r0 do_fetch: Bitbake Fetcher Error: FetchError('Rep=
ository https://github.com/pullmoll/musl-fts.git has LFS content, install g=
it-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: gcompat-1.1.0-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://git.adelielinux.org/adelie/gcompat.git has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: gi-docgen-2025.3-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://gitlab.gnome.org/GNOME/gi-docgen.git has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: gi-docgen-native-2025.3-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://gitlab.gnome.org/GNOME/gi-docgen.git has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: gitrepotest-1.0-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://git.yoctoproject.org/git/matchbox-panel-2 has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: git-submodule-test-1.0-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository git://git.yoctoproject.org/git-submodule-test has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: gitunpackoffline-0.0+git-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://git.yoctoproject.org/git/matchbox-panel-2 ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)', None)
stdio: ERROR: gitunpackoffline-fail-1.0-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://git.yoctoproject.org/git/matchbox-panel-2 h=
as LFS content, install git-lfs on host to download (or set lfs=3D0 to igno=
re it)', None)
stdio: ERROR: glibc-2.41+git-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://sourceware.org/git/glibc.git has LFS content, install =
git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: glibc-testsuite-2.41+git-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://sourceware.org/git/glibc.git has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: glibc-y2038-tests-2.41+git-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://sourceware.org/git/glibc.git has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: glslang-1_1.4.309.0-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/KhronosGroup/glslang.git has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: glslang-native-1_1.4.309.0-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://github.com/KhronosGroup/glslang.git has LF=
S content, install git-lfs on host to download (or set lfs=3D0 to ignore it=
)', None)
stdio: ERROR: gnome-desktop-testing-2021.1-r0 do_fetch: Bitbake Fetcher Err=
or: FetchError('Repository https://gitlab.gnome.org/GNOME/gnome-desktop-tes=
ting.git has LFS content, install git-lfs on host to download (or set lfs=
=3D0 to ignore it)', None)
stdio: ERROR: gnu-config-20240823+git-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://git.savannah.gnu.org/git/config.git has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: gnu-config-native-20240823+git-r0 do_fetch: Bitbake Fetcher E=
rror: FetchError('Repository https://git.savannah.gnu.org/git/config.git ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)', None)
stdio: ERROR: gnu-efi-4.0.0-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://github.com/ncroxon/gnu-efi has LFS content, install git=
-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: gnu-efi-native-4.0.0-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/ncroxon/gnu-efi has LFS content, inst=
all git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: go-helloworld-0.1-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://go.googlesource.com/example has LFS content, instal=
l git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: gst-examples-1.18.6-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://gitlab.freedesktop.org/gstreamer/gst-examples.git=
 has LFS content, install git-lfs on host to download (or set lfs=3D0 to ig=
nore it)', None)
stdio: ERROR: hello-rs-0.1.0-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/akiernan/hello-bin.git has LFS content, ins=
tall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: hwdata-0.394-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://github.com/vcrhonek/hwdata.git has LFS content, install =
git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: hwdata-native-0.394-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/vcrhonek/hwdata.git has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: hwlatdetect-1_2.8-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git =
has LFS content, install git-lfs on host to download (or set lfs=3D0 to ign=
ore it)', None)
stdio: ERROR: ifupdown-0.8.44-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://salsa.debian.org/debian/ifupdown.git has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: igt-gpu-tools-1.30-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://gitlab.freedesktop.org/drm/igt-gpu-tools.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: init-system-helpers-1.68-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://salsa.debian.org/debian/init-system-helpers.=
git has LFS content, install git-lfs on host to download (or set lfs=3D0 to=
 ignore it)', None)
stdio: ERROR: iputils-20240905-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://github.com/iputils/iputils has LFS content, install =
git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: iso-codes-4.17.0-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://salsa.debian.org/iso-codes-team/iso-codes.git has LF=
S content, install git-lfs on host to download (or set lfs=3D0 to ignore it=
)', None)
stdio: ERROR: iso-codes-native-4.17.0-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://salsa.debian.org/iso-codes-team/iso-codes.git=
 has LFS content, install git-lfs on host to download (or set lfs=3D0 to ig=
nore it)', None)
stdio: ERROR: kern-tools-native-0.3+git-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://git.yoctoproject.org/yocto-kernel-tools.git=
 has LFS content, install git-lfs on host to download (or set lfs=3D0 to ig=
nore it)', None)
stdio: ERROR: kmscube-0.0.1+git-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://gitlab.freedesktop.org/mesa/kmscube has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: l3afpad-0.8.18.1.11+git-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://github.com/stevenhoneyman/l3afpad.git has LFS=
 content, install git-lfs on host to download (or set lfs=3D0 to ignore it)=
', None)
stdio: ERROR: libaio-0.3.113-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://pagure.io/libaio.git has LFS content, install git-lfs =
on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libaio-native-0.3.113-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://pagure.io/libaio.git has LFS content, install g=
it-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libcap-ng-0.8.5-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/stevegrubb/libcap-ng.git has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libcap-ng-native-0.8.5-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/stevegrubb/libcap-ng.git has LFS co=
ntent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', =
None)
stdio: ERROR: libcap-ng-python-0.8.5-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/stevegrubb/libcap-ng.git has LFS co=
ntent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', =
None)
stdio: ERROR: libcap-ng-python-native-0.8.5-r0 do_fetch: Bitbake Fetcher Er=
ror: FetchError('Repository https://github.com/stevegrubb/libcap-ng.git has=
 LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore=
 it)', None)
stdio: ERROR: libcomps-0.1.21-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/rpm-software-management/libcomps.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: libcomps-native-0.1.21-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/rpm-software-management/libcomps.gi=
t has LFS content, install git-lfs on host to download (or set lfs=3D0 to i=
gnore it)', None)
stdio: ERROR: libc-test-0+git-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://repo.or.cz/libc-test has LFS content, install git-lfs=
 on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libdisplay-info-0.2.0-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://gitlab.freedesktop.org/emersion/libdisplay-info=
.git has LFS content, install git-lfs on host to download (or set lfs=3D0 t=
o ignore it)', None)
stdio: ERROR: libdnf-0.74.0-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://github.com/rpm-software-management/libdnf has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: libdnf-native-0.74.0-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/rpm-software-management/libdnf has LF=
S content, install git-lfs on host to download (or set lfs=3D0 to ignore it=
)', None)
stdio: ERROR: libepoxy-1.5.10-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/anholt/libepoxy has LFS content, install g=
it-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libepoxy-native-1.5.10-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/anholt/libepoxy has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libfakekey-0.3+git-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://git.yoctoproject.org/libfakekey has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libgit2-1.9.0-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://github.com/libgit2/libgit2.git has LFS content, install=
 git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libgit2-native-1.9.0-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/libgit2/libgit2.git has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libgloss-4.4.0+git-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://sourceware.org/git/newlib-cygwin.git has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: libhandy-1.8.3-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://gitlab.gnome.org/GNOME/libhandy.git has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libinput-1.28.1-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://gitlab.freedesktop.org/libinput/libinput.git has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: libjitterentropy-3.6.2-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/smuellerDD/jitterentropy-library.gi=
t has LFS content, install git-lfs on host to download (or set lfs=3D0 to i=
gnore it)', None)
stdio: ERROR: libmatchbox-1.13-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://git.yoctoproject.org/libmatchbox has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libmodulemd-2.15.0-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/fedora-modularity/libmodulemd has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: libmodulemd-native-2.15.0-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/fedora-modularity/libmodulemd ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)', None)
stdio: ERROR: libnsl2-2.0.1-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://github.com/thkukuk/libnsl has LFS content, install git-=
lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libnsl2-native-2.0.1-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/thkukuk/libnsl has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libnss-nis-3.2-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/thkukuk/libnss_nis has LFS content, install=
 git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libnss-nis-native-3.2-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/thkukuk/libnss_nis has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libportal-0.9.1-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/flatpak/libportal.git has LFS content, ins=
tall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libproxy-0.5.9-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/libproxy/libproxy has LFS content, install =
git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: librepo-1.19.0-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/rpm-software-management/librepo.git has LFS=
 content, install git-lfs on host to download (or set lfs=3D0 to ignore it)=
', None)
stdio: ERROR: librepo-native-1.19.0-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/rpm-software-management/librepo.git =
has LFS content, install git-lfs on host to download (or set lfs=3D0 to ign=
ore it)', None)
stdio: ERROR: libsass-3.6.6-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://github.com/sass/libsass.git has LFS content, install gi=
t-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libsass-native-3.6.6-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/sass/libsass.git has LFS content, ins=
tall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libseccomp-2.6.0-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://github.com/seccomp/libseccomp.git has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libslirp-4.9.0-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://gitlab.freedesktop.org/slirp/libslirp.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: libslirp-native-4.9.0-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://gitlab.freedesktop.org/slirp/libslirp.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: libsolv-0.7.31-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/openSUSE/libsolv.git has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libsolv-native-0.7.31-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/openSUSE/libsolv.git has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libtraceevent-1.8.4-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://git.kernel.org/pub/scm/libs/libtrace/libtraceeven=
t.git has LFS content, install git-lfs on host to download (or set lfs=3D0 =
to ignore it)', None)
stdio: ERROR: libubootenv-0.3.6-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://github.com/sbabic/libubootenv has LFS content, inst=
all git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libubootenv-native-0.3.6-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/sbabic/libubootenv has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: libucontext-1.2-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/kaniini/libucontext has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libuv-1.50.0-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://github.com/libuv/libuv.git has LFS content, install git-=
lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libuv-native-1.50.0-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/libuv/libuv.git has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libva-utils-2.22.0-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/intel/libva-utils.git has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libxcrypt-4.4.38-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://github.com/besser82/libxcrypt.git has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libxcrypt-compat-4.4.38-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://github.com/besser82/libxcrypt.git has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: libxcrypt-compat-native-4.4.38-r0 do_fetch: Bitbake Fetcher E=
rror: FetchError('Repository https://github.com/besser82/libxcrypt.git has =
LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore =
it)', None)
stdio: ERROR: libxcrypt-native-4.4.38-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://github.com/besser82/libxcrypt.git has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: libxcvt-0.1.3-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://gitlab.freedesktop.org/xorg/lib/libxcvt.git has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: libxkbcommon-1.8.1-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/xkbcommon/libxkbcommon has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libxkbcommon-native-1.8.1-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/xkbcommon/libxkbcommon has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: libxmlb-0.3.22-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/hughsie/libxmlb.git has LFS content, instal=
l git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: libxmlb-native-0.3.22-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/hughsie/libxmlb.git has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: linux-yocto-6.12.23+git-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://git.yoctoproject.org/linux-yocto.git has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: llvm-20.1.2-r0 do_fetch: Bitbake Fetcher Error: FetchError('R=
epository https://github.com/KhronosGroup/SPIRV-LLVM-Translator has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: llvm-native-20.1.2-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/KhronosGroup/SPIRV-LLVM-Translator has =
LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore =
it)', None)
stdio: ERROR: lsof-4.99.4-r0 do_fetch: Bitbake Fetcher Error: FetchError('R=
epository https://github.com/lsof-org/lsof has LFS content, install git-lfs=
 on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: ltp-20250130-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://github.com/linux-test-project/ltp.git has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: lz4-1_1.10.0-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://github.com/lz4/lz4.git has LFS content, install git-lfs =
on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: lz4-native-1_1.10.0-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/lz4/lz4.git has LFS content, install g=
it-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: makedumpfile-1.7.6-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/makedumpfile/makedumpfile has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: matchbox-config-gtk-0.2+git-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://git.yoctoproject.org/matchbox-config-gtk =
has LFS content, install git-lfs on host to download (or set lfs=3D0 to ign=
ore it)', None)
stdio: ERROR: matchbox-desktop-2.3-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://git.yoctoproject.org/matchbox-desktop-2 has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: matchbox-keyboard-0.1.1-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://git.yoctoproject.org/matchbox-keyboard has LF=
S content, install git-lfs on host to download (or set lfs=3D0 to ignore it=
)', None)
stdio: ERROR: matchbox-panel-2-2.12-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://git.yoctoproject.org/matchbox-panel-2 has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: matchbox-terminal-0.2+git-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://git.yoctoproject.org/matchbox-terminal has =
LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore =
it)', None)
stdio: ERROR: matchbox-theme-sato-0.2-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://git.yoctoproject.org/matchbox-sato has LFS co=
ntent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', =
None)
stdio: ERROR: matchbox-wm-1.2.3-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://git.yoctoproject.org/matchbox-window-manager has LF=
S content, install git-lfs on host to download (or set lfs=3D0 to ignore it=
)', None)
stdio: ERROR: mdadm-4.4-r0 do_fetch: Bitbake Fetcher Error: FetchError('Rep=
ository https://git.kernel.org/pub/scm/utils/mdadm/mdadm.git has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: mmc-utils-0.1+git-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git has =
LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore =
it)', None)
stdio: ERROR: mobile-broadband-provider-info-1_20240407-r0 do_fetch: Bitbak=
e Fetcher Error: FetchError('Repository https://gitlab.gnome.org/GNOME/mobi=
le-broadband-provider-info.git has LFS content, install git-lfs on host to =
download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: mtd-utils-2.3.0-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository git://git.infradead.org/mtd-utils.git has LFS content, instal=
l git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: mtd-utils-native-2.3.0-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository git://git.infradead.org/mtd-utils.git has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: mtd-utils-selftest-2.1.4-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository git://git.infradead.org/mtd-utils.git has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: mtd-utils-selftest-native-2.1.4-r0 do_fetch: Bitbake Fetcher =
Error: FetchError('Repository git://git.infradead.org/mtd-utils.git has LFS=
 content, install git-lfs on host to download (or set lfs=3D0 to ignore it)=
', None)
stdio: ERROR: musl-1.2.5+git-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository git://git.musl-libc.org/musl has LFS content, install git-lfs =
on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: musl-obstack-1.2.3-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/void-linux/musl-obstack has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: musl-utils-20170421-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/boltlinux/musl-utils has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-acpica-20240827-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/acpica/acpica has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-asciidoc-10.2.1-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/asciidoc/asciidoc-py has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: nativesdk-babeltrace-1.5.11-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://git.efficios.com/babeltrace.git has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: nativesdk-babeltrace2-2.1.0-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://git.efficios.com/babeltrace.git has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: nativesdk-binutils-2.44-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://sourceware.org/git/binutils-gdb.git has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: nativesdk-bmaptool-3.9.0+git-r0 do_fetch: Bitbake Fetcher Err=
or: FetchError('Repository https://github.com/yoctoproject/bmaptool has LFS=
 content, install git-lfs on host to download (or set lfs=3D0 to ignore it)=
', None)
stdio: ERROR: nativesdk-btrfs-tools-6.14-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://github.com/kdave/btrfs-progs.git has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: nativesdk-bzip2-1.0.8-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://sourceware.org/git/bzip2-tests.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: nativesdk-cracklib-2.10.3-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/cracklib/cracklib has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: nativesdk-createrepo-c-1.2.1-r0 do_fetch: Bitbake Fetcher Err=
or: FetchError('Repository https://github.com/rpm-software-management/creat=
erepo_c has LFS content, install git-lfs on host to download (or set lfs=3D=
0 to ignore it)', None)
stdio: ERROR: nativesdk-cryptodev-linux-1.14-r0 do_fetch: Bitbake Fetcher E=
rror: FetchError('Repository https://github.com/cryptodev-linux/cryptodev-l=
inux has LFS content, install git-lfs on host to download (or set lfs=3D0 t=
o ignore it)', None)
stdio: ERROR: nativesdk-dnf-4.22.0-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/rpm-software-management/dnf.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: nativesdk-dos2unix-7.5.2-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://git.code.sf.net/p/dos2unix/dos2unix has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: nativesdk-dpkg-1.22.11-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://salsa.debian.org/dpkg-team/dpkg.git has LFS co=
ntent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', =
None)
stdio: ERROR: nativesdk-dtc-1.7.2-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://git.kernel.org/pub/scm/utils/dtc/dtc.git has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: nativesdk-e2fsprogs-1.47.1-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.g=
it has LFS content, install git-lfs on host to download (or set lfs=3D0 to =
ignore it)', None)
stdio: ERROR: nativesdk-erofs-utils-1.8.5-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://git.kernel.org/pub/scm/linux/kernel/git/x=
iang/erofs-utils.git has LFS content, install git-lfs on host to download (=
or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-file-5.46-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/file/file.git has LFS content, install=
 git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-fmt-11.1.4-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/fmtlib/fmt has LFS content, install g=
it-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-gi-docgen-2025.3-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://gitlab.gnome.org/GNOME/gi-docgen.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: nativesdk-glibc-2.41+git-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://sourceware.org/git/glibc.git has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-glibc-testsuite-2.41+git-r0 do_fetch: Bitbake Fetch=
er Error: FetchError('Repository https://sourceware.org/git/glibc.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: nativesdk-glslang-1_1.4.309.0-r0 do_fetch: Bitbake Fetcher Er=
ror: FetchError('Repository https://github.com/KhronosGroup/glslang.git has=
 LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore=
 it)', None)
stdio: ERROR: nativesdk-gnu-config-20240823+git-r0 do_fetch: Bitbake Fetche=
r Error: FetchError('Repository https://git.savannah.gnu.org/git/config.git=
 has LFS content, install git-lfs on host to download (or set lfs=3D0 to ig=
nore it)', None)
stdio: ERROR: nativesdk-libaio-0.3.113-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://pagure.io/libaio.git has LFS content, instal=
l git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-libcap-ng-0.8.5-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/stevegrubb/libcap-ng.git has LFS=
 content, install git-lfs on host to download (or set lfs=3D0 to ignore it)=
', None)
stdio: ERROR: nativesdk-libcap-ng-python-0.8.5-r0 do_fetch: Bitbake Fetcher=
 Error: FetchError('Repository https://github.com/stevegrubb/libcap-ng.git =
has LFS content, install git-lfs on host to download (or set lfs=3D0 to ign=
ore it)', None)
stdio: ERROR: nativesdk-libcomps-0.1.21-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/rpm-software-management/libcomps=
.git has LFS content, install git-lfs on host to download (or set lfs=3D0 t=
o ignore it)', None)
stdio: ERROR: nativesdk-libdnf-0.74.0-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://github.com/rpm-software-management/libdnf has=
 LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore=
 it)', None)
stdio: ERROR: nativesdk-libepoxy-1.5.10-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/anholt/libepoxy has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-libmodulemd-2.15.0-r0 do_fetch: Bitbake Fetcher Err=
or: FetchError('Repository https://github.com/fedora-modularity/libmodulemd=
 has LFS content, install git-lfs on host to download (or set lfs=3D0 to ig=
nore it)', None)
stdio: ERROR: nativesdk-libnsl2-2.0.1-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://github.com/thkukuk/libnsl has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-libnss-nis-3.2-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/thkukuk/libnss_nis has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: nativesdk-librepo-1.19.0-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/rpm-software-management/librepo.g=
it has LFS content, install git-lfs on host to download (or set lfs=3D0 to =
ignore it)', None)
stdio: ERROR: nativesdk-libslirp-4.9.0-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://gitlab.freedesktop.org/slirp/libslirp.git ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)', None)
stdio: ERROR: nativesdk-libsolv-0.7.31-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/openSUSE/libsolv.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: nativesdk-libxcrypt-4.4.38-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://github.com/besser82/libxcrypt.git has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: nativesdk-libxcrypt-compat-4.4.38-r0 do_fetch: Bitbake Fetche=
r Error: FetchError('Repository https://github.com/besser82/libxcrypt.git h=
as LFS content, install git-lfs on host to download (or set lfs=3D0 to igno=
re it)', None)
stdio: ERROR: nativesdk-llvm-20.1.2-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/KhronosGroup/SPIRV-LLVM-Translator h=
as LFS content, install git-lfs on host to download (or set lfs=3D0 to igno=
re it)', None)
stdio: ERROR: nativesdk-lz4-1_1.10.0-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/lz4/lz4.git has LFS content, instal=
l git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-mtd-utils-2.3.0-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository git://git.infradead.org/mtd-utils.git has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: nativesdk-mtd-utils-selftest-2.1.4-r0 do_fetch: Bitbake Fetch=
er Error: FetchError('Repository git://git.infradead.org/mtd-utils.git has =
LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore =
it)', None)
stdio: ERROR: nativesdk-ncurses-6.5-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/ThomasDickey/ncurses-snapshots.git h=
as LFS content, install git-lfs on host to download (or set lfs=3D0 to igno=
re it)', None)
stdio: ERROR: nativesdk-net-tools-2.10-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://git.code.sf.net/p/net-tools/code has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: nativesdk-ninja-1.12.1-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/ninja-build/ninja.git has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: nativesdk-opkg-utils-0.7.0-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://git.yoctoproject.org/opkg-utils has LFS co=
ntent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', =
None)
stdio: ERROR: nativesdk-p11-kit-0.25.5-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/p11-glue/p11-kit has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-patchelf-0.18.0-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/NixOS/patchelf has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-pkgconfig-0.29.2+git-r0 do_fetch: Bitbake Fetcher E=
rror: FetchError('Repository https://gitlab.freedesktop.org/pkg-config/pkg-=
config.git has LFS content, install git-lfs on host to download (or set lfs=
=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-pseudo-1.9.0+git-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://git.yoctoproject.org/pseudo has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: nativesdk-python3-calver-2025.04.02-r0 do_fetch: Bitbake Fetc=
her Error: FetchError('Repository https://github.com/di/calver has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: nativesdk-python3-dtc-1.7.2-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository git://git.kernel.org/pub/scm/utils/dtc/dtc.git ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)', None)
stdio: ERROR: nativesdk-python3-pefile-2024.8.26-r0 do_fetch: Bitbake Fetch=
er Error: FetchError('Repository https://github.com/erocarrera/pefile has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: nativesdk-python3-unittest-automake-output-0.2-r0 do_fetch: B=
itbake Fetcher Error: FetchError('Repository https://gitlab.com/rossburton/=
python-unittest-automake-output has LFS content, install git-lfs on host to=
 download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-repo-2.53-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://gerrit.googlesource.com/git-repo.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: nativesdk-rpcsvc-proto-1.4.4-r0 do_fetch: Bitbake Fetcher Err=
or: FetchError('Repository https://github.com/thkukuk/rpcsvc-proto has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: nativesdk-rpm-1_4.20.0-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/rpm-software-management/rpm has LFS=
 content, install git-lfs on host to download (or set lfs=3D0 to ignore it)=
', None)
stdio: ERROR: nativesdk-shaderc-2025.1-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/google/shaderc.git has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: nativesdk-shared-mime-info-2.4-r0 do_fetch: Bitbake Fetcher E=
rror: FetchError('Repository https://gitlab.freedesktop.org/xdg/shared-mime=
-info.git has LFS content, install git-lfs on host to download (or set lfs=
=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-spirv-headers-1_1.4.309.0-r0 do_fetch: Bitbake Fetc=
her Error: FetchError('Repository https://github.com/KhronosGroup/SPIRV-Hea=
ders has LFS content, install git-lfs on host to download (or set lfs=3D0 t=
o ignore it)', None)
stdio: ERROR: nativesdk-spirv-tools-1_1.4.309.0-r0 do_fetch: Bitbake Fetche=
r Error: FetchError('Repository https://github.com/KhronosGroup/SPIRV-Tools=
.git has LFS content, install git-lfs on host to download (or set lfs=3D0 t=
o ignore it)', None)
stdio: ERROR: nativesdk-squashfs-tools-4.6.1-r0 do_fetch: Bitbake Fetcher E=
rror: FetchError('Repository https://github.com/plougher/squashfs-tools.git=
 has LFS content, install git-lfs on host to download (or set lfs=3D0 to ig=
nore it)', None)
stdio: ERROR: nativesdk-systemtap-5.2-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://sourceware.org/git/systemtap.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: nativesdk-systemtap-native-5.2-r0 do_fetch: Bitbake Fetcher E=
rror: FetchError('Repository https://sourceware.org/git/systemtap.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: nativesdk-u-boot-tools-1_2025.04-r0 do_fetch: Bitbake Fetcher=
 Error: FetchError('Repository https://source.denx.de/u-boot/u-boot.git has=
 LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore=
 it)', None)
stdio: ERROR: nativesdk-unfs3-0.10.0-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/unfs3/unfs3.git has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-update-rc.d-0.8+git-r0 do_fetch: Bitbake Fetcher Er=
ror: FetchError('Repository https://git.yoctoproject.org/update-rc.d has LF=
S content, install git-lfs on host to download (or set lfs=3D0 to ignore it=
)', None)
stdio: ERROR: nativesdk-vim-9.1.1198-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/vim/vim.git has LFS content, instal=
l git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-virglrenderer-1.1.0-r0 do_fetch: Bitbake Fetcher Er=
ror: FetchError('Repository https://gitlab.freedesktop.org/virgl/virglrende=
rer.git has LFS content, install git-lfs on host to download (or set lfs=3D=
0 to ignore it)', None)
stdio: ERROR: nativesdk-xxhash-0.8.3-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/Cyan4973/xxHash.git has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: nativesdk-zstd-1.5.7-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/facebook/zstd.git has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: ncurses-6.5-r0 do_fetch: Bitbake Fetcher Error: FetchError('R=
epository https://github.com/ThomasDickey/ncurses-snapshots.git has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: ncurses-native-6.5-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/ThomasDickey/ncurses-snapshots.git has =
LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore =
it)', None)
stdio: ERROR: neard-0.19-r0 do_fetch: Bitbake Fetcher Error: FetchError('Re=
pository https://git.kernel.org/pub/scm/network/nfc/neard.git has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: net-tools-2.10-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://git.code.sf.net/p/net-tools/code has LFS content, inst=
all git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: net-tools-native-2.10-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://git.code.sf.net/p/net-tools/code has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: newlib-4.4.0+git-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://sourceware.org/git/newlib-cygwin.git has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: ninja-1.12.1-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://github.com/ninja-build/ninja.git has LFS content, instal=
l git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: ninja-native-1.12.1-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/ninja-build/ninja.git has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: numactl-2.0.19-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/numactl/numactl has LFS content, install gi=
t-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: opensbi-1.6-r0 do_fetch: Bitbake Fetcher Error: FetchError('R=
epository https://github.com/riscv/opensbi.git has LFS content, install git=
-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: opkg-utils-0.7.0-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://git.yoctoproject.org/opkg-utils has LFS content, ins=
tall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: opkg-utils-native-0.7.0-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://git.yoctoproject.org/opkg-utils has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: ovmf-edk2-stable202411-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/tianocore/edk2.git has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: ovmf-native-edk2-stable202411-r0 do_fetch: Bitbake Fetcher Er=
ror: FetchError('Repository https://github.com/tianocore/edk2.git has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: p11-kit-0.25.5-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/p11-glue/p11-kit has LFS content, install g=
it-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: p11-kit-native-0.25.5-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/p11-glue/p11-kit has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: patchelf-0.18.0-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/NixOS/patchelf has LFS content, install gi=
t-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: patchelf-native-0.18.0-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/NixOS/patchelf has LFS content, ins=
tall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: piglit-1.0+gitr-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://gitlab.freedesktop.org/mesa/piglit.git has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: pkgconfig-0.29.2+git-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://gitlab.freedesktop.org/pkg-config/pkg-config.git=
 has LFS content, install git-lfs on host to download (or set lfs=3D0 to ig=
nore it)', None)
stdio: ERROR: pkgconfig-native-0.29.2+git-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://gitlab.freedesktop.org/pkg-config/pkg-con=
fig.git has LFS content, install git-lfs on host to download (or set lfs=3D=
0 to ignore it)', None)
stdio: ERROR: powertop-2.15-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://github.com/fenrus75/powertop has LFS content, install g=
it-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: procps-4.0.5-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://gitlab.com/procps-ng/procps.git has LFS content, install=
 git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: pseudo-1.9.0+git-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://git.yoctoproject.org/pseudo has LFS content, install=
 git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: pseudo-native-1.9.0+git-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://git.yoctoproject.org/pseudo has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: psmisc-23.7-r0 do_fetch: Bitbake Fetcher Error: FetchError('R=
epository https://gitlab.com/psmisc/psmisc.git has LFS content, install git=
-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: psplash-0.1+git-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://git.yoctoproject.org/psplash has LFS content, install=
 git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: ptest-runner-2.4.5.1-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://git.yoctoproject.org/ptest-runner2 has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: puzzles-2_0.0+git-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://git.tartarus.org/simon/puzzles.git has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: python3-calver-2025.04.02-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/di/calver has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: python3-calver-native-2025.04.02-r0 do_fetch: Bitbake Fetcher=
 Error: FetchError('Repository https://github.com/di/calver has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: python3-dtc-1.7.2-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository git://git.kernel.org/pub/scm/utils/dtc/dtc.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: python3-dtc-native-1.7.2-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository git://git.kernel.org/pub/scm/utils/dtc/dtc.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: python3-guessing-game-0.1.0-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://git.yoctoproject.org/guessing-game.git ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)', None)
stdio: ERROR: python3-pefile-2024.8.26-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/erocarrera/pefile has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: python3-pefile-native-2024.8.26-r0 do_fetch: Bitbake Fetcher =
Error: FetchError('Repository https://github.com/erocarrera/pefile has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: python3-unittest-automake-output-0.2-r0 do_fetch: Bitbake Fet=
cher Error: FetchError('Repository https://gitlab.com/rossburton/python-uni=
ttest-automake-output has LFS content, install git-lfs on host to download =
(or set lfs=3D0 to ignore it)', None)
stdio: ERROR: python3-unittest-automake-output-native-0.2-r0 do_fetch: Bitb=
ake Fetcher Error: FetchError('Repository https://gitlab.com/rossburton/pyt=
hon-unittest-automake-output has LFS content, install git-lfs on host to do=
wnload (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: repo-2.53-r0 do_fetch: Bitbake Fetcher Error: FetchError('Rep=
ository https://gerrit.googlesource.com/git-repo.git has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: repo-native-2.53-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://gerrit.googlesource.com/git-repo.git has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: resolvconf-1.92-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://salsa.debian.org/debian/resolvconf.git has LFS conten=
t, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None=
)
stdio: ERROR: rng-tools-6.17-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/nhorman/rng-tools.git has LFS content, inst=
all git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: rpcsvc-proto-1.4.4-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/thkukuk/rpcsvc-proto has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: rpcsvc-proto-native-1.4.4-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/thkukuk/rpcsvc-proto has LFS con=
tent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', N=
one)
stdio: ERROR: rpm-1_4.20.0-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://github.com/rpm-software-management/rpm has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: rpm-native-1_4.20.0-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/rpm-software-management/rpm has LFS co=
ntent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', =
None)
stdio: ERROR: rpm-sequoia-1.7.0-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://github.com/rpm-software-management/rpm-sequoia.git =
has LFS content, install git-lfs on host to download (or set lfs=3D0 to ign=
ore it)', None)
stdio: ERROR: rpm-sequoia-crypto-policy-git-r0 do_fetch: Bitbake Fetcher Er=
ror: FetchError('Repository https://gitlab.com/redhat-crypto/fedora-crypto-=
policies.git has LFS content, install git-lfs on host to download (or set l=
fs=3D0 to ignore it)', None)
stdio: ERROR: rpm-sequoia-crypto-policy-native-git-r0 do_fetch: Bitbake Fet=
cher Error: FetchError('Repository https://gitlab.com/redhat-crypto/fedora-=
crypto-policies.git has LFS content, install git-lfs on host to download (o=
r set lfs=3D0 to ignore it)', None)
stdio: ERROR: rpm-sequoia-native-1.7.0-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/rpm-software-management/rpm-sequo=
ia.git has LFS content, install git-lfs on host to download (or set lfs=3D0=
 to ignore it)', None)
stdio: ERROR: rt-tests-1_2.8-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git has=
 LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore=
 it)', None)
stdio: ERROR: rust-c-lib-example-bin-git-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://gitlab.com/fmartinsonsHome/rust-c-lib-exam=
ple.git has LFS content, install git-lfs on host to download (or set lfs=3D=
0 to ignore it)', None)
stdio: ERROR: rust-c-lib-example-git-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://gitlab.com/fmartinsonsHome/rust-c-lib-example.=
git has LFS content, install git-lfs on host to download (or set lfs=3D0 to=
 ignore it)', None)
stdio: ERROR: sassc-3.6.2-r0 do_fetch: Bitbake Fetcher Error: FetchError('R=
epository https://github.com/sass/sassc.git has LFS content, install git-lf=
s on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: sassc-native-3.6.2-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/sass/sassc.git has LFS content, install=
 git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: sato-icon-theme-git-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://git.yoctoproject.org/sato-icon-theme.git has LFS =
content, install git-lfs on host to download (or set lfs=3D0 to ignore it)'=
, None)
stdio: ERROR: sato-screenshot-0.3-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://git.yoctoproject.org/screenshot has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: scdoc-1.11.3-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://git.sr.ht/~sircmpwn/scdoc has LFS content, install git-l=
fs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: scdoc-native-1.11.3-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://git.sr.ht/~sircmpwn/scdoc has LFS content, instal=
l git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: seatd-0.9.1-r0 do_fetch: Bitbake Fetcher Error: FetchError('R=
epository https://git.sr.ht/~kennylevinsen/seatd has LFS content, install g=
it-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: settings-daemon-0.0.2+git-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://git.yoctoproject.org/xsettings-daemon has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: shaderc-2025.1-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/google/shaderc.git has LFS content, install=
 git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: shaderc-native-2025.1-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/google/shaderc.git has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: shared-mime-info-2.4-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://gitlab.freedesktop.org/xdg/shared-mime-info.git =
has LFS content, install git-lfs on host to download (or set lfs=3D0 to ign=
ore it)', None)
stdio: ERROR: shared-mime-info-native-2.4-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://gitlab.freedesktop.org/xdg/shared-mime-in=
fo.git has LFS content, install git-lfs on host to download (or set lfs=3D0=
 to ignore it)', None)
stdio: ERROR: spirv-headers-1_1.4.309.0-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/KhronosGroup/SPIRV-Headers has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: spirv-headers-native-1_1.4.309.0-r0 do_fetch: Bitbake Fetcher=
 Error: FetchError('Repository https://github.com/KhronosGroup/SPIRV-Header=
s has LFS content, install git-lfs on host to download (or set lfs=3D0 to i=
gnore it)', None)
stdio: ERROR: spirv-tools-1_1.4.309.0-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://github.com/KhronosGroup/SPIRV-Tools.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: spirv-tools-native-1_1.4.309.0-r0 do_fetch: Bitbake Fetcher E=
rror: FetchError('Repository https://github.com/KhronosGroup/SPIRV-Tools.gi=
t has LFS content, install git-lfs on host to download (or set lfs=3D0 to i=
gnore it)', None)
stdio: ERROR: squashfs-tools-4.6.1-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://github.com/plougher/squashfs-tools.git has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: squashfs-tools-native-4.6.1-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://github.com/plougher/squashfs-tools.git ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)', None)
stdio: ERROR: stress-ng-0.18.12-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://github.com/ColinIanKing/stress-ng.git has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: sysdig-selftest-0.28.0-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/draios/sysdig.git has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: sysfsutils-2.1.1-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://github.com/linux-ras/sysfsutils.git has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: sysklogd-2.7.2-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/troglobit/sysklogd.git has LFS content, ins=
tall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: sysstat-12.7.7-r0 do_fetch: Bitbake Fetcher Error: FetchError=
('Repository https://github.com/sysstat/sysstat.git has LFS content, instal=
l git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: systemd-boot-257.5-r0 do_fetch: Bitbake Fetcher Error: FetchE=
rror('Repository https://github.com/systemd/systemd.git has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: systemd-boot-native-257.5-r0 do_fetch: Bitbake Fetcher Error:=
 FetchError('Repository https://github.com/systemd/systemd.git has LFS cont=
ent, install git-lfs on host to download (or set lfs=3D0 to ignore it)', No=
ne)
stdio: ERROR: systemd-systemctl-native-257.5-r0 do_fetch: Bitbake Fetcher E=
rror: FetchError('Repository https://github.com/systemd/systemd.git has LFS=
 content, install git-lfs on host to download (or set lfs=3D0 to ignore it)=
', None)
stdio: ERROR: systemtap-5.2-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://sourceware.org/git/systemtap.git has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: systemtap-native-5.2-r0 do_fetch: Bitbake Fetcher Error: Fetc=
hError('Repository https://sourceware.org/git/systemtap.git has LFS content=
, install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: tcf-agent-1.8.0+git-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://gitlab.eclipse.org/eclipse/tcf/tcf.agent.git has =
LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore =
it)', None)
stdio: ERROR: ttyrun-2.37.0-r0 do_fetch: Bitbake Fetcher Error: FetchError(=
'Repository https://github.com/ibm-s390-linux/s390-tools has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: u-boot-1_2025.04-r0 do_fetch: Bitbake Fetcher Error: FetchErr=
or('Repository https://source.denx.de/u-boot/u-boot.git has LFS content, in=
stall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: u-boot-tools-1_2025.04-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://source.denx.de/u-boot/u-boot.git has LFS conte=
nt, install git-lfs on host to download (or set lfs=3D0 to ignore it)', Non=
e)
stdio: ERROR: u-boot-tools-native-1_2025.04-r0 do_fetch: Bitbake Fetcher Er=
ror: FetchError('Repository https://source.denx.de/u-boot/u-boot.git has LF=
S content, install git-lfs on host to download (or set lfs=3D0 to ignore it=
)', None)
stdio: ERROR: unfs3-0.10.0-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://github.com/unfs3/unfs3.git has LFS content, install git-=
lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: unfs3-native-0.10.0-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/unfs3/unfs3.git has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: update-rc.d-0.8+git-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://git.yoctoproject.org/update-rc.d has LFS content,=
 install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: update-rc.d-native-0.8+git-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://git.yoctoproject.org/update-rc.d has LFS c=
ontent, install git-lfs on host to download (or set lfs=3D0 to ignore it)',=
 None)
stdio: ERROR: utfcpp-4.0.6-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://github.com/nemtrif/utfcpp has LFS content, install git-l=
fs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: vim-9.1.1198-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://github.com/vim/vim.git has LFS content, install git-lfs =
on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: vim-native-9.1.1198-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/vim/vim.git has LFS content, install g=
it-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: vim-tiny-9.1.1198-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://github.com/vim/vim.git has LFS content, install git=
-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: virglrenderer-1.1.0-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://gitlab.freedesktop.org/virgl/virglrenderer.git ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)', None)
stdio: ERROR: virglrenderer-native-1.1.0-r0 do_fetch: Bitbake Fetcher Error=
: FetchError('Repository https://gitlab.freedesktop.org/virgl/virglrenderer=
.git has LFS content, install git-lfs on host to download (or set lfs=3D0 t=
o ignore it)', None)
stdio: ERROR: vulkan-headers-1.4.309.0-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Repository https://github.com/KhronosGroup/Vulkan-Headers.git h=
as LFS content, install git-lfs on host to download (or set lfs=3D0 to igno=
re it)', None)
stdio: ERROR: vulkan-loader-1.4.309.0-r0 do_fetch: Bitbake Fetcher Error: F=
etchError('Repository https://github.com/KhronosGroup/Vulkan-Loader.git has=
 LFS content, install git-lfs on host to download (or set lfs=3D0 to ignore=
 it)', None)
stdio: ERROR: vulkan-tools-1.4.309.0-r0 do_fetch: Bitbake Fetcher Error: Fe=
tchError('Repository https://github.com/KhronosGroup/Vulkan-Tools.git has L=
FS content, install git-lfs on host to download (or set lfs=3D0 to ignore i=
t)', None)
stdio: ERROR: vulkan-utility-libraries-1.4.309.0-r0 do_fetch: Bitbake Fetch=
er Error: FetchError('Repository https://github.com/KhronosGroup/Vulkan-Uti=
lity-Libraries.git has LFS content, install git-lfs on host to download (or=
 set lfs=3D0 to ignore it)', None)
stdio: ERROR: vulkan-validation-layers-1.4.309.0-r0 do_fetch: Bitbake Fetch=
er Error: FetchError('Repository https://github.com/KhronosGroup/Vulkan-Val=
idationLayers.git has LFS content, install git-lfs on host to download (or =
set lfs=3D0 to ignore it)', None)
stdio: ERROR: vulkan-volk-1.4.309.0-r0 do_fetch: Bitbake Fetcher Error: Fet=
chError('Repository https://github.com/zeux/volk.git has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: waffle-1.8.1-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://gitlab.freedesktop.org/mesa/waffle.git has LFS content, =
install git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: xcursor-transparent-theme-0.1.1+git-r0 do_fetch: Bitbake Fetc=
her Error: FetchError('Repository https://git.yoctoproject.org/xcursor-tran=
sparent-theme has LFS content, install git-lfs on host to download (or set =
lfs=3D0 to ignore it)', None)
stdio: ERROR: xf86-video-intel-2_2.99.917+git-r0 do_fetch: Bitbake Fetcher =
Error: FetchError('Repository https://gitlab.freedesktop.org/xorg/driver/xf=
86-video-intel.git has LFS content, install git-lfs on host to download (or=
 set lfs=3D0 to ignore it)', None)
stdio: ERROR: xinetd-2.3.15.4-r0 do_fetch: Bitbake Fetcher Error: FetchErro=
r('Repository https://github.com/openSUSE/xinetd.git has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: xinput-calibrator-0.7.5+git-r0 do_fetch: Bitbake Fetcher Erro=
r: FetchError('Repository https://github.com/kreijack/xinput_calibrator.git=
 has LFS content, install git-lfs on host to download (or set lfs=3D0 to ig=
nore it)', None)
stdio: ERROR: xmlto-0.0.29-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://pagure.io/xmlto.git has LFS content, install git-lfs on =
host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: xmlto-native-0.0.29-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://pagure.io/xmlto.git has LFS content, install git-=
lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: xxhash-0.8.3-r0 do_fetch: Bitbake Fetcher Error: FetchError('=
Repository https://github.com/Cyan4973/xxHash.git has LFS content, install =
git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: xxhash-native-0.8.3-r0 do_fetch: Bitbake Fetcher Error: Fetch=
Error('Repository https://github.com/Cyan4973/xxHash.git has LFS content, i=
nstall git-lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: zstd-1.5.7-r0 do_fetch: Bitbake Fetcher Error: FetchError('Re=
pository https://github.com/facebook/zstd.git has LFS content, install git-=
lfs on host to download (or set lfs=3D0 to ignore it)', None)
stdio: ERROR: zstd-native-1.5.7-r0 do_fetch: Bitbake Fetcher Error: FetchEr=
ror('Repository https://github.com/facebook/zstd.git has LFS content, insta=
ll git-lfs on host to download (or set lfs=3D0 to ignore it)', None)


