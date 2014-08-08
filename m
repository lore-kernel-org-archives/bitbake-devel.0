Return-Path: <sergio.almendros.diaz@gmail.com>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
	[74.125.82.175])
	by mail.openembedded.org (Postfix) with ESMTP id 333B2701A6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Aug 2014 12:41:48 +0000 (UTC)
Received: by mail-we0-f175.google.com with SMTP id t60so5453934wes.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Aug 2014 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=/6Ku3T1e9Y82H2zNDjmoQz02tWCCxBFSspoDITBDquM=;
	b=PmNAzNBfoq4OBYfWnkTKwRktDSjwNtQnxjfEoiz5Li2z22SizBOmO7RSiRkx6u474v
	TyTWC3mjOtrwbsjjUI2/0FluBRgsGomEdeOCgQ2LuttetG1bXT8A56ygWJ4toEmSJXCR
	x9ZW43BlO0unYNeuAN0/hYNTr10kN/btJ7yaCw7wv2/qsUHWYbLq2GvAZQ/XtvzfNzLQ
	Yxm3Mxo9c8K3mP0f2AzNYfazyBfGVKzxK+pzxnkF6rM229puOUHk3HYED2Nlo8A76LbI
	D7tAfCGHalDC7DnPb+aAcBJHYvjHKxaGgoR6hDacQD/NkTymPcvSNGithDuetLHrts/N
	taLw==
MIME-Version: 1.0
X-Received: by 10.194.59.42 with SMTP id w10mr31905605wjq.15.1407501709504;
	Fri, 08 Aug 2014 05:41:49 -0700 (PDT)
Received: by 10.216.158.74 with HTTP; Fri, 8 Aug 2014 05:41:49 -0700 (PDT)
Date: Fri, 8 Aug 2014 14:41:49 +0200
Message-ID: <CAEDEsJKfdQ+4kGQ8vN_pFZMgZPUX8HA0rDzdq9x-0VPagh7j9A@mail.gmail.com>
From: Sergio Almendros <sergio.almendros.diaz@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Chromium and Java for Yocto
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
X-List-Received-Date: Fri, 08 Aug 2014 12:41:51 -0000
Content-Type: multipart/alternative; boundary=047d7b86dde06a758e05001d8752

--047d7b86dde06a758e05001d8752
Content-Type: text/plain; charset=UTF-8

Hi,

I'm working for the first time with an i.MX6, yocto, and bitbake and I'm a
little bit lost. My goals are to install openjdk7 and chromium 36+, and all
I found is using bitbake, but it is really complicated to me to make it
work. Could someone give me some kind of guide on how to proceed?

Thanks,
Sergio.

--047d7b86dde06a758e05001d8752
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;m working for the first time =
with an i.MX6, yocto, and bitbake and I&#39;m a little bit lost. My goals a=
re to install openjdk7 and chromium 36+, and all I found is using bitbake, =
but it is really complicated to me to make it work. Could someone give me s=
ome kind of guide on how to proceed?</div>
<div><br></div><div>Thanks,</div><div>Sergio.</div></div>

--047d7b86dde06a758e05001d8752--
