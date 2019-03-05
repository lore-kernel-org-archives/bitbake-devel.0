Return-Path: <ross.burton@intel.com>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail.openembedded.org (Postfix) with ESMTP id 0039D7C6F9
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Mar 2019 10:58:31 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id p196so6653644iod.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 05 Mar 2019 02:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=w/KVZsSOfcnqcPvP2at3b6M0PuxRB23GoMCd2BK+f8g=;
	b=KAR3DRmA1D9vPCZAFk+Fac5WCvilGnFYw0/7MQ5Ko15KZq4gMzOszJ9eFANsR4OQsT
	Mycmtn2xC0xw7RDMWzesvGbmrP9aNJK9jVya02MNyjmzvkwSot+qLQgM9LHtNyTgAs69
	bjrmlH3dSu36UVVEzIab4/K89hdBRPrRYw7xELfGnit2mmUIxvzIHuTIiQtoQxZAXTVK
	Q5mI8tvSg/BMYj6Buqsl2ei1PZS5ns1yT38wKILcCVO9iRGQgn/so3fVuki8ffOYLMEn
	18oDhrtFtrQnhTlaK3IbgLOBqtoXdKSZykPeaoi3Hs9OnaeACBinNO0MFBU3dToyrQSv
	ZLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=w/KVZsSOfcnqcPvP2at3b6M0PuxRB23GoMCd2BK+f8g=;
	b=bORitcYC9T3RFXAR51bxVR8FSZuXqypaefOb41RajwZXG6F6jsfXH9XrVkKig783um
	hCD6jPg5K6BjCDB8huDnLTPSFFqwlagw9JQUgwf5nyirHbnF3ifpyB+cIuotdTMhgWAd
	4HVYMSpTQzGr9GcAT3NJevEQQBbLxioomY+AE3lGydvm9bW/ca2vBQYgtJ+ZQHV+u32g
	Knyjo9EdLoU0dB47CZqhb08YWn3oyDcaQ72YWRwKA3WIaFjKiIjMJ/CEnGSSnd8KF2VH
	6oiUlUbvvEUT1Va1x2u9uOi+4jlgiPasMODVAovaeTmXDNKiKK2IZxe4wiIu8CDwCj7V
	zBFA==
X-Gm-Message-State: APjAAAUTj/5lW0DGr/X2el6HQhidurNBjWqtiwomX05rg9y06P6c1Vf0
	3sd4mKd8P4LcUmK7c2i6pPt3o1Ulz3NRgNwfPcxd9w==
X-Google-Smtp-Source: APXvYqzIFAMbdOZad9dKo59NbWIsKxsH/j1NE0vSSGoWxWgJ+SyJX3NmTLAnW8PgHLExk9fXlAGaP0sun8xSkOBHdYc=
X-Received: by 2002:a5d:818d:: with SMTP id u13mr12103150ion.20.1551783513020; 
	Tue, 05 Mar 2019 02:58:33 -0800 (PST)
MIME-Version: 1.0
References: <CAPybu_1GLgMMBysaCD0GDiPSmJr6jEqVptzX6+DQmU7ZBOigMA@mail.gmail.com>
In-Reply-To: <CAPybu_1GLgMMBysaCD0GDiPSmJr6jEqVptzX6+DQmU7ZBOigMA@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 5 Mar 2019 10:58:21 +0000
Message-ID: <CAJTo0LYEFB4GyiyP=JK3vj2vFqzT1tzJiERKqezb9BO3N_K25g@mail.gmail.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Daniel Gomez <daniel@qtec.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Two recipes providing the same .so... How it should not be done :)
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
X-List-Received-Date: Tue, 05 Mar 2019 10:58:32 -0000
Content-Type: text/plain; charset="UTF-8"

Does they literally just provide a libgl.so and no headers, etc?

Ross

On Fri, 1 Mar 2019 at 11:29, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
>
> Hello
>
> I have a build system that supports some aarch64 machines. For most of
> the them, the only difference is the kernel configuration, kernel
> version.
>
> I am using multiconfig on my build server and the build goes really
> fast thanks to all the shared binaries/artifacts.
>
> But I have a problem adding a new machine. This machine is also
> aarch64, with a special kernel (nothing new here), but in this case
> the vendor provides a binary .so for libgl that is required to get
> hardware acceleation.
>
> I could .bbappend mesa and on the installation part replace libgl with
> the new .so. But then everything that depends on mesa needs to be
> rebuilt for that machine and I could not use multiconfig.
>
> Instead I have created a new recipe: mesa-gl-replace.bb that has the
> file. This breakes completely the design of OE, but works.
>
> Some snipsets of the "magic" to make it work:
>
> #Force that the version is allways higher than the one from mesa:
> PE = "5"
>
> #Rprovide the same as mesa
> RPROVIDES_libgl-mesa += "libgl"
>
> #Do not overwrite pkgdata of mesa
> PACKAGEFUNCS_append = " rm_pkgdata_runtime"
> rm_pkgdata_runtime() {
> rm -rf ${WORKDIR}/pkgdata/runtime/*
> rm -rf ${WORKDIR}/pkgdata/shlibs2/*
> }
>
> #Keep this on machine
> PACKAGE_ARCH = "${MACHINE_ARCH}"
>
> #Make sure we are not saved as providers for libgl
> PRIVATE_LIBS = "libGL.so.1"
>
> #Avoid sanity checks
> read_subpackage_metadata () {
> }
>
>
> If your eyes have not fallen as this point, this means you have a lot
> of tolerance for crappy code, congrats :)
>
> Now the question. Is there a better way to do this?
>
> PS: I already tried and failed with update_alternatives
>
>
> Best regards!
>
>
> --
> Ricardo Ribalda
> --
> _______________________________________________
> Openembedded-core mailing list
> Openembedded-core@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/openembedded-core

