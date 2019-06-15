Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by mail.openembedded.org (Postfix) with ESMTP id D24647EAAC
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 17:56:44 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id q10so3326633pff.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=382hRH2Er0ugVeEk2x6nrtbHzDC/7KoOaZ/DrcBWwd4=;
	b=bFpU/t86pOJnPFb9sdbS+oD46X1lk403D/6VtE1SrjZfZgLTaaOkzqW72CgKqvJ3CT
	gTXEKBzDHf4oGsVmaPnmicCdRcm666tvKbC1UR9DXkDmnPvazztCZmBGGJ0eWmPVZdDz
	WvSL9g0lHrY8H7irvCrRnPeu0GmaHoLxkEDUwrBgNk+xxTpugpbyieyMpQzhRU2xifIF
	b1ybzbBKgmWdiA2wRj9i8q9M2N8TKIwcQaLTcCODjM2FyojfAMswWjAKr7QmZci0U6BJ
	Vv5K915R1CxUMBmdT4jj39rqJwGf4EE3StHohMbEqs+CNLRzGbYpY3bPbcgihY8aCZB6
	XGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=382hRH2Er0ugVeEk2x6nrtbHzDC/7KoOaZ/DrcBWwd4=;
	b=B2ck3ISnhsxCp5mvlBPUk8NKAKWRC4ZTQNgFrN1z2AZHHzZOzDgWJ6nqhsdTwGdURl
	3MfGiTnRU06+hxGwzDNQFqq30dUzV4kNOV9VXMeXO9tfggTFHq5N2pSAq3lXSpo1c2j+
	fP88E4OihW1J7z9ssHf3Rm2fh1/y0TISC8iyeENzbqfT1vQQGjO0mruIfEBRmkYYgGfw
	qYZ7F3846F676eJppIpncToKnb2Z51X6ZS38L4IZ2qVHUcRFiAS81IlGC/cMZSnXHVas
	RcXIjOcHSRbvmai/Z+had4WS5LXbuBMst3sQXkDKwYBplA5PwUOGv3jSzx/s4Uq4bTNW
	usoA==
X-Gm-Message-State: APjAAAXEo8bnYWjJybOmUtuFEJQ5ZdS62w6IQWpcZDpOZHLgUuoIJ4ka
	9ikLEvJuXjohway/PtW3pxx5Zu/r
X-Google-Smtp-Source: APXvYqz8CLSK4/K/zUz9DzI00ehtRZAS69FqNOZN8iKUgBkaJlc5Ql4F4l7h6tjgjKUNo8F6HwZ+kA==
X-Received: by 2002:a62:3741:: with SMTP id
	e62mr106362446pfa.213.1560621405786; 
	Sat, 15 Jun 2019 10:56:45 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:5942:80bf:dc9c:15ab?
	([2601:202:4180:c33:5942:80bf:dc9c:15ab])
	by smtp.gmail.com with ESMTPSA id
	v10sm959794pfe.163.2019.06.15.10.56.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 15 Jun 2019 10:56:45 -0700 (PDT)
To: Armin Kuster <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org
References: <cover.1560620937.git.akuster808@gmail.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <0aeb439f-d690-d88d-f2b6-b67764b48848@gmail.com>
Date: Sat, 15 Jun 2019 10:56:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1560620937.git.akuster808@gmail.com>
Subject: Re: [Warror][ 00/23] Patch review
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
X-List-Received-Date: Sat, 15 Jun 2019 17:56:45 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US


sorry, cut and paste error in email adder.

- armin
On 6/15/19 10:50 AM, Armin Kuster wrote:
> Most of these where back port requests so I am giving a short review window.
> Commnets by Sunday.
>
> The following changes since commit 21cbe3ec166696b4d67d2ef5486a394d14d29269:
>
>   aufs-util: prevent native aufs-util depending on target kernel (2019-05-18 07:38:39 -0700)
>
> are available in the git repository at:
>
>   https://git.openembedded.org/meta-openembedded-contrib stable/warrior-nmut
>   http://cgit.openembedded.org//log/?h=stable/warrior-nmut
>
> Changqing Li (1):
>   netkit-telnet: add rconflicts
>
> Hongxu Jia (1):
>   crash: do not use unstable github archive tarballs
>
> Liwei Song (1):
>   turbostat: copy bits.h from kernel to turbostat
>
> Martin Jansa (16):
>   gtkwave: add distro_features_check
>   ndctl: make MACHINE_ARCH and ignore from libblockdev
>   oprofile: make MACHINE_ARCH
>   umip: make MACHINE_ARCH
>   mscgen: fix SRC_URI for multilib
>   triggerhappy: fix issues
>   python-cassandra-driver.inc: fix DEPENDS
>   opencv: use the same package name in PACKAGES and RDEPENDS
>   igmpproxy: remove
>     0001-src-igmpproxy.h-Include-sys-types.h-for-u_short-u_in.patch and
>     _GNU_SOURCE
>   libvncserver: set PV in the recipe
>   ccid: fix SRC_URI
>   ne10, libopus: add armv7ve override as well
>   hunspell: use git fetcher instead of github archive
>   ttf-mplus, ttf-vlgothic: add ttf-mplus license
>   libmikmod: fix SRC_URI
>   leptonica: fix SRC_URI
>
> Mingli Yu (1):
>   mariadb: Upgrade to 10.3.15
>
> Qi.Chen@windriver.com (1):
>   polkit: fix CVE-2019-6133
>
> Scott Ellis (1):
>   wireguard: Upgrade 20190123 -> 20190406
>
> nick83ola (1):
>   uthash: do not use unstable github archive tarballs
>
>  .../recipes-connectivity/umip/umip_1.0.bb          |   3 +
>  ...xy.h-Include-sys-types.h-for-u_short-u_in.patch |  25 ---
>  .../recipes-daemons/igmpproxy/igmpproxy_0.2.1.bb   |   6 +-
>  ...0190123.bb => wireguard-module_0.0.20190406.bb} |   0
>  ...20190123.bb => wireguard-tools_0.0.20190406.bb} |   0
>  .../recipes-kernel/wireguard/wireguard.inc         |   4 +-
>  .../netkit-telnet/netkit-telnet_0.17.bb            |   1 +
>  meta-oe/conf/layer.conf                            |   6 +
>  meta-oe/licenses/ttf-mplus                         |  16 ++
>  meta-oe/recipes-core/ndctl/ndctl_v63.bb            |   3 +
>  .../packagegroups/packagegroup-meta-oe.bb          |   3 +-
>  ...native_10.3.13.bb => mariadb-native_10.3.15.bb} |   0
>  meta-oe/recipes-dbs/mysql/mariadb.inc              |   4 +-
>  .../{mariadb_10.3.13.bb => mariadb_10.3.15.bb}     |   0
>  ...pare-PolkitUnixProcess-uids-for-temporary.patch | 186 +++++++++++++++++++++
>  meta-oe/recipes-extended/polkit/polkit_0.115.bb    |   7 +-
>  .../{triggerhappy_0.5.0.bb => triggerhappy_git.bb} |  22 +--
>  meta-oe/recipes-graphics/gtkwave/gtkwave_3.3.98.bb |   4 +
>  .../recipes-graphics/leptonica/leptonica_1.74.4.bb |   2 +-
>  .../libvncserver/libvncserver_git.bb               |   2 +-
>  .../recipes-graphics/ttf-fonts/ttf-mplus_027.bb    |   2 +-
>  .../ttf-fonts/ttf-vlgothic_20141206.bb             |   2 +-
>  meta-oe/recipes-kernel/crash/crash_7.2.5.bb        |   8 +-
>  meta-oe/recipes-kernel/oprofile/oprofile_1.3.0.bb  |   3 +
>  meta-oe/recipes-kernel/turbostat/turbostat_3.4.bb  |   2 +
>  .../recipes-multimedia/libopus/libopus_1.1.3.bb    |   3 +-
>  .../recipes-multimedia/mikmod/libmikmod_3.3.6.bb   |   2 +-
>  meta-oe/recipes-support/ccid/ccid_1.4.24.bb        |   4 +-
>  meta-oe/recipes-support/hunspell/hunspell_1.7.0.bb |   7 +-
>  meta-oe/recipes-support/mscgen/mscgen_0.20.bb      |   2 +-
>  meta-oe/recipes-support/ne10/ne10_1.2.1.bb         |   4 +-
>  meta-oe/recipes-support/opencv/opencv_3.4.5.bb     |   2 +-
>  meta-oe/recipes-support/uthash/uthash_2.1.0.bb     |   7 +-
>  .../python/python-cassandra-driver.inc             |   2 +-
>  34 files changed, 272 insertions(+), 72 deletions(-)
>  delete mode 100644 meta-networking/recipes-daemons/igmpproxy/igmpproxy/0001-src-igmpproxy.h-Include-sys-types.h-for-u_short-u_in.patch
>  rename meta-networking/recipes-kernel/wireguard/{wireguard-module_0.0.20190123.bb => wireguard-module_0.0.20190406.bb} (100%)
>  rename meta-networking/recipes-kernel/wireguard/{wireguard-tools_0.0.20190123.bb => wireguard-tools_0.0.20190406.bb} (100%)
>  create mode 100644 meta-oe/licenses/ttf-mplus
>  rename meta-oe/recipes-dbs/mysql/{mariadb-native_10.3.13.bb => mariadb-native_10.3.15.bb} (100%)
>  rename meta-oe/recipes-dbs/mysql/{mariadb_10.3.13.bb => mariadb_10.3.15.bb} (100%)
>  create mode 100644 meta-oe/recipes-extended/polkit/polkit/0001-backend-Compare-PolkitUnixProcess-uids-for-temporary.patch
>  rename meta-oe/recipes-extended/triggerhappy/{triggerhappy_0.5.0.bb => triggerhappy_git.bb} (73%)
>


