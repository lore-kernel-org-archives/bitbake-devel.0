Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 78A8B610F5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Aug 2014 10:59:31 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 18 Aug 2014 03:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,885,1400050800"; d="scan'208";a="589604475"
Received: from sdoherty-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.63])
	by orsmga002.jf.intel.com with ESMTP; 18 Aug 2014 03:59:30 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: info@sd-kyber.com
Date: Mon, 18 Aug 2014 11:59:29 +0100
Message-ID: <3739004.e7d85eEqT1@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.13.3 (Linux/3.15.10-200.fc20.x86_64; KDE/4.13.3; x86_64; ;
	)
In-Reply-To: <0D8F1464-990E-47E6-A965-C3BF6F020BE2@sd-kyber.com>
References: <0D8F1464-990E-47E6-A965-C3BF6F020BE2@sd-kyber.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake debugging...
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
X-List-Received-Date: Mon, 18 Aug 2014 10:59:36 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Michael,

On Wednesday 13 August 2014 14:06:11 info@sd-kyber.com wrote:
> Is there any document, suggestion what is the best practice to trace =
/ step
> through the bitbake  execution?
>=20
> For example, is it possible to put =E2=80=98the break point=E2=80=99 =
 at the moment the
> fetcher module I=E2=80=99m specifying is called? If that possible =E2=
=80=94 and I think it
> is - what python environments are common to be used? ActiveSense, som=
ething
> else?
>=20
> Is there any document describing how to set such a =E2=80=98bitbake d=
evelopment=E2=80=99
> environment?

I think the answer is that we don't really have such a method, at least=
 not=20
that BitBake developers themselves use. Speaking for myself, I usually =
just=20
add print / bb.warn() statements into the code where I need to see the =
value=20
of something or know when that part of the code is executed. It's defin=
itely=20
crude, but it works.

Cheers,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre

