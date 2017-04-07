Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com
	[209.85.223.177])
	by mail.openembedded.org (Postfix) with ESMTP id 984FE72F39
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Apr 2017 16:25:46 +0000 (UTC)
Received: by mail-io0-f177.google.com with SMTP id b140so52954393iof.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Apr 2017 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=4FuYqY0dnCc+aCXqbt6tdONTNpenNxwPMue0iju8DMg=;
	b=lToTTLWPITj76GV6rsfWKs+l14MvZAiBZWEtEuCPyFkx4EeTk/5csiSLH3lLYpVCay
	q/FDRhHZ2NGQawGJtyrYE3Ry3uFi79CF7C7+ukMeYtWIzmKyQUfs3PB1hPQJhlHjNdlo
	9kp6a+qigH/52UlAxrZT8YI0tl1kABet6aE5mNuOYd6HBNJmJD2fSZzkHNjAc21p0LiP
	Iz8ovn54p4YcBmxSrXycka80o8HFadfigpFPFgC1fkSlXKgpXVLZ7BI7IJBBTYm8oORK
	a6IrDaQiWIP8nyG8p9dO/QPlRLvbigwBju/O6xI1KSQuQVoicURF8NEyB5ZVCiN3mK40
	d8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=4FuYqY0dnCc+aCXqbt6tdONTNpenNxwPMue0iju8DMg=;
	b=Ew+BP36oVOzMT8QFApCzrxT5DZUteexnqvZ+JllJnPag9we5RPeJzfYwTvmIRNN/q6
	rnpsEb53s95dlHBZ4AIOGxBjPpi78NdP1Mm5Ws5usYXBvIrnEivPGxuX+5fJt88V6ehe
	4jKzroBIuRkCQm6AmfcBsDhA+1zzSwWkJQ903vv0c9/FVo2PUZzRC7kRniACoLX09kBL
	OSqoIXr1OmbVOEk7O1kL5SPLw4hJdJ7xQkbaiFH3mGH++xKd6qz08A6CMoDjAr+EJOz4
	5zRbk4n8X7VK4NET+mryT+5b1SIc6mquGIO99AdAjSszmJLIuMMchwR98EtQv2/FoqGW
	MF3g==
X-Gm-Message-State: AFeK/H2r8U9u6Z5X5xxw3h4DxJw8yrBmXyVnQbhtPFn/Y+BvcWjjcSUuM261WueCh6vjelBM
X-Received: by 10.107.34.75 with SMTP id i72mr40872458ioi.48.1491582348144;
	Fri, 07 Apr 2017 09:25:48 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8EAD9.dip0.t-ipconnect.de. [93.232.234.217])
	by smtp.gmail.com with ESMTPSA id
	e134sm11906629itc.23.2017.04.07.09.25.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Apr 2017 09:25:47 -0700 (PDT)
Message-ID: <1491582344.10884.79.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 07 Apr 2017 18:25:44 +0200
In-Reply-To: <01748f01da49c1a0d7ccdb114c6822b4969ff40d.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
	<01748f01da49c1a0d7ccdb114c6822b4969ff40d.1491514854.git.paul.eggleton@linux.intel.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 03/11] bitbake-diffsigs: properly report which signature is missing
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
X-List-Received-Date: Fri, 07 Apr 2017 16:25:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-04-07 at 09:52 +1200, Paul Eggleton wrote:
> If just one of the two signatures we want to compare aren't available,
> report that one rather than misleadingly claiming both are missing.

I just noticed that bitbake-diffsigs -t ... do_build recursively dumps
differences in other tasks - cool, I don't know it could do that. It
worked fine for all-arch ca-certificates, but not for 

$ bitbake-diffsigs -d -t gdb-cross-x86_64 do_build -s 68a82197720db0f0dbad8955635bc1c0 5631f484d848541bdbf6a4c1f8117f79
DEBUG: Signature file (previous): /fast/build/nodistro/x86/tmp-glibc/stamps/x86_64-linux/gdb-cross-x86_64/7.12.1-r0.do_build.sigdata.68a82197720db0f0dbad8955635bc1c0
DEBUG: Signature file (latest): /fast/build/nodistro/x86/tmp-glibc/stamps/x86_64-linux/gdb-cross-x86_64/7.12.1-r0.do_build.sigdata.5631f484d848541bdbf6a4c1f8117f79
Hash for dependent task gdb/gdb-cross_7.12.1.bb.do_populate_sysroot changed from 6247000d87570135b704fcfd3e4e7cd4 to 554c1ce69bf0538a91436e5f7c256488
Unable to find matching sigdata for /fast/work/openembedded-core/meta/recipes-devtools/gdb/gdb-cross_7.12.1.bb.do_populate_sysroot with hashes 6247000d87570135b704fcfd3e4e7cd4 or 554c1ce69bf0538a91436e5f7c256488

$ bitbake-diffsigs -d -t gdb-cross-x86_64 do_populate_sysroot -s 6247000d87570135b704fcfd3e4e7cd4 554c1ce69bf0538a91436e5f7c256488
DEBUG: Signature file (previous): /fast/build/nodistro/x86/tmp-glibc/stamps/x86_64-linux/gdb-cross-x86_64/7.12.1-r0.do_populate_sysroot.sigdata.6247000d87570135b704fcfd3e4e7cd4
DEBUG: Signature file (latest): /fast/build/nodistro/x86/tmp-glibc/stamps/x86_64-linux/gdb-cross-x86_64/7.12.1-r0.do_populate_sysroot.sigdata.554c1ce69bf0538a91436e5f7c256488
Hash for dependent task gdb/gdb-cross_7.12.1.bb.do_install changed from 0786db89020b877d443da848548b3d1d to 746c2815e180fa2a4ff28608c7c1b9d5
Unable to find matching sigdata for /fast/work/openembedded-core/meta/recipes-devtools/gdb/gdb-cross_7.12.1.bb.do_install with hashes 0786db89020b877d443da848548b3d1d or 746c2815e180fa2a4ff28608c7c1b9d5

In other words, automatic diff fails to find files, while manual diff finds them?!

This situation can be triggered with a local patch of mine (to be posted soon) and using
yocto-compat-layer.py -n --machines intel-corei7-64 intel-core2-32 qemux86 qemux86-64 -- /fast/work/meta-intel

The test uses MACHINE=... bitbake -S none world to generate the signatures for
different machines and then looks for tasks that are shared between
machines with different signatures.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




