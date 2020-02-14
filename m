Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by mail.openembedded.org (Postfix) with ESMTP id E9130610A2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Feb 2020 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=axis.com; l=1102; q=dns/txt; s=axis-central1;
	t=1581694328; x=1613230328;
	h=from:to:subject:date:message-id:references:in-reply-to:
	content-transfer-encoding:mime-version;
	bh=wHgUOdaXBAdkMvHC1CQ/4H5ryVAkTDIAXzn+tP6IsTI=;
	b=iYKVqEvvvSdFzq4KS174uokrIDP5jNSysITuV04l1BPqT739wFFz2PRK
	Ze7LUlF31OINcacMhVJk/uhvmmAqCQPlfmUhcAV3DS9C/DFGMxvG6gYDx
	tn5BMEPOID06wRC1O/zGuWHnRmiVz70Z84batKtw1vfWqW7UB4GEBebRQ
	TMRzvU3qOaXEIsqivIfvv8uSseAnJX+QSkxdppio2F9G6et2nA+6MAa4v
	p196jC6ejhkwoVrZgKZ1rqt+X2lggipFve98vry9FT6zP4GbLT1EWqhME
	88DQaG09EDA8aJTW7YKi1ZSMsnQ0m+vBpq+H3SDRE3eWIbVwr79w4brWj w==;
IronPort-SDR: vKTcZSqQdVjjjyyD1xYbB6RZ7Pp40Z6ILKy/7tDAuXMN5lYlEP0okGCsALXn8tzdNsfCZc6zkE
	XrnLr18T3Vkrg354aislA06QzfbW626iAZVGXYm4RtF9ya8EWMrn6W6IchwSsbtNoTN9Ara7Ew
	Klq39+vuzEow7ZYF9kbnEStaB3eoFhkBr0/UFMSwqV0+PgKhVo8lK5nRkvEObRvqm1Ni9YYxUJ
	iFvf2Bw4sLy23G7+GZ/qCVL15EDKlo0ek1I655TfGge9NhHKd/MASN98VyKotd2tvtxxaviO2F
	974=
X-IronPort-AV: E=Sophos;i="5.70,440,1574118000"; 
   d="scan'208";a="5433352"
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "dl9pf@gmx.de" <dl9pf@gmx.de>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] Fix bitbake-layerindex to checkout the
	requested branch
Thread-Index: AQHV40hdp7W2XT5rhE26JrC/Qzmxf6ga0MMA
Date: Fri, 14 Feb 2020 15:32:07 +0000
Message-ID: <8650a200f4274ea79ba23e1e6604004c@XBOX03.axis.com>
References: <20200214150109.29296-1-dl9pf@gmx.de>
In-Reply-To: <20200214150109.29296-1-dl9pf@gmx.de>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Subject: Re: [PATCH] Fix bitbake-layerindex to checkout the	requested branch
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
X-List-Received-Date: Fri, 14 Feb 2020 15:32:07 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of dl9pf@gmx.de
> Sent: den 14 februari 2020 16:01
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] Fix bitbake-layerindex to checkout the
> requested branch
>=20
> From: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>
>=20
> Bitbake-layerindex would not respect the branch given with -b .
> This fixes the clone command.
>=20
> V2: Corrected 'branch' back to 'branches' and added
>     a FIXME on multiple LAYERSERIES_CORENAMES.
> V3: After discussion on IRC use branches[-1] as well
>     educated guess for now but leave the FIXME in place.

Information about the various patch revisions should go below the "---"=20
below as they relate to the patch process and not the commit that=20
eventually ends up in the Git repository.

> Signed-off-by: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>
> ---
>  lib/bblayers/layerindex.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

//Peter


