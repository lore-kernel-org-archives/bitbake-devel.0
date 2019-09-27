Return-Path: <akuster@mvista.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id 8ED7F7F359
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 15:17:22 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id o10so3673919pgs.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=Lw9HxdetfPlhKhg2X1bEjf1pIGcLdmdPU5YRUTWkq/g=;
	b=rVNnXHlZAh7MzJn9eWCpfV6br1eFH/KZSo36hk0T3uVDnTNILVl5sZAL7pVX+lOch1
	OPB44ZiZkDxA+fwBMYaNF9sdjYmFtYaUoz7Qcc/4EJiviTsH3i3gmnxgrV7yUki/5fo6
	tEi1gqT9Jmsd86FeVUly0m0gU9c0r5sp4uXqlqAw4dmrnBkqs8YUJNjSIEK0je5zTTPb
	NxArkND142I66/xZuVjDqtI2dBr0NrkSJ22jbyrA9BAMY3+GaB43TPEhxsKEMr24RM3g
	1ZCMrdr4qxYuC6kG29JTWnPLnVwpMaUbEcw+VCZoi9o6WW+Ye6b4gJRNOnMv9dSqiFY5
	F75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=Lw9HxdetfPlhKhg2X1bEjf1pIGcLdmdPU5YRUTWkq/g=;
	b=bTYmIQKjgpX6u14K+KYSrn4CMmjf8PBzkN1y1Tn/i45raQ6invziGBjxEcxgdA+Rhx
	GNP21H5yySaFHmq6nxH93YIFCqvEEgi4yDDfS7zGd0gFGxHXZMBWxMTV3mR/WBCLSWUu
	GDBM9sejz3h5kfOWkzzaxMOCIcVuO6PSZ7Ivv35iBNYbs0jDbB5mXczLw8dJOFUVsNbL
	nus9Om/xdT619aEkQFq4arfdARD/Lt6Mg95KZIFiV/6JkWHzr/dWqdfAum4DVnJlerqA
	DrxvyeBVnCu4KQ6tUof4dc1dkPF8RgqTUN3C7iJzcauKfsgTcgH2xsR4B+brI1dpcqSD
	lR7Q==
X-Gm-Message-State: APjAAAX+Z0ZxY6cQ7gewvSq5FHJ4PJziBZaxap1ppu/L7RRieuZdv/CQ
	asq0xqkRZA0WUZ2rRd5TlHU9b020ais=
X-Google-Smtp-Source: APXvYqzvQAlCmxg64zWwN5DoFiDgZmBH1FWWAzVUpk6s0WHLoNizX4PvxaDg+2HkTk3EoI64mvTINQ==
X-Received: by 2002:a63:3c08:: with SMTP id j8mr9584737pga.72.1569597442781;
	Fri, 27 Sep 2019 08:17:22 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:a5c0:40e0:1cd6:848:14bf?
	([2601:202:4180:a5c0:40e0:1cd6:848:14bf])
	by smtp.gmail.com with ESMTPSA id
	w188sm5283269pgw.26.2019.09.27.08.17.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 27 Sep 2019 08:17:22 -0700 (PDT)
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
References: <cover.1569582663.git.liezhi.yang@windriver.com>
	<a375d82d5287417286d50ebbfb3d6d2b386731cd.1569582663.git.liezhi.yang@windriver.com>
From: akuster <akuster@mvista.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster@mvista.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <f759b566-62cc-1d43-ae9b-fcc5da364259@mvista.com>
Date: Fri, 27 Sep 2019 08:17:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a375d82d5287417286d50ebbfb3d6d2b386731cd.1569582663.git.liezhi.yang@windriver.com>
Subject: Re: [PATCH 2/2] net-snmp: Fix PACKAGECONFIG for perl
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
X-List-Received-Date: Fri, 27 Sep 2019 15:17:22 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 9/27/19 4:12 AM, Robert Yang wrote:
> * Remove perl-lib since it had been removed by oe-core:
>   commit 68552c353255188de3d5b42135360a30e7eac535
>   Author: Alexander Kanavin <alex.kanavin@gmail.com>
>   Date:   Sun Dec 2 12:46:37 2018 +0100
>
>       perl: remove the previous version of the recipe
>
>   Now the files are in perl pacakge.
>
> * Fix perl paths when perl is enabled.
>
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>

Wrong mailing list

- armin
> ---
>  meta-networking/recipes-protocols/net-snmp/net-snmp_5.8.bb | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/meta-networking/recipes-protocols/net-snmp/net-snmp_5.8.bb b/meta-networking/recipes-protocols/net-snmp/net-snmp_5.8.bb
> index 60b2b38..192b6b5 100644
> --- a/meta-networking/recipes-protocols/net-snmp/net-snmp_5.8.bb
> +++ b/meta-networking/recipes-protocols/net-snmp/net-snmp_5.8.bb
> @@ -50,7 +50,7 @@ PACKAGECONFIG[libnl] = "--with-nl, --without-nl, libnl"
>  PACKAGECONFIG[ipv6] = "--enable-ipv6,--disable-ipv6,,"
>  
>  PACKAGECONFIG[perl] = "--enable-embedded-perl --with-perl-modules=yes, --disable-embedded-perl --with-perl-modules=no,\
> -                       perl, perl perl-lib"
> +                       perl,"
>  PACKAGECONFIG[des] = "--enable-des,--disable-des"
>  
>  EXTRA_OECONF = "--enable-shared \
> @@ -88,8 +88,8 @@ do_configure_prepend() {
>  
>      if [ "${HAS_PERL}" = "1" ]; then
>          # this may need to be changed when package perl has any change.
> -        cp -f ${STAGING_DIR_TARGET}/usr/lib*/perl/*/Config.pm ${WORKDIR}/
> -        cp -f ${STAGING_DIR_TARGET}/usr/lib*/perl/*/Config_heavy.pl ${WORKDIR}/
> +        cp -f ${STAGING_DIR_TARGET}/usr/lib*/perl?/*/Config.pm ${WORKDIR}/
> +        cp -f ${STAGING_DIR_TARGET}/usr/lib*/perl?/*/*/Config_heavy.pl ${WORKDIR}/
>          sed -e "s@libpth => '/usr/lib.*@libpth => '${STAGING_DIR_TARGET}/${libdir} ${STAGING_DIR_TARGET}/${base_libdir}',@g" \
>              -e "s@privlibexp => '/usr@privlibexp => '${STAGING_DIR_TARGET}/usr@g" \
>              -e "s@scriptdir => '/usr@scriptdir => '${STAGING_DIR_TARGET}/usr@g" \
> @@ -190,7 +190,8 @@ ALLOW_EMPTY_${PN} = "1"
>  ALLOW_EMPTY_${PN}-server = "1"
>  ALLOW_EMPTY_${PN}-libs = "1"
>  
> -FILES_${PN}-perl-modules = "${libdir}/perl/*"
> +FILES_${PN}-perl-modules = "${libdir}/perl?/*"
> +RDEPENDS_${PN}-perl-modules = "perl"
>  
>  FILES_${PN}-libs = ""
>  FILES_${PN}-mibs = "${datadir}/snmp/mibs"


