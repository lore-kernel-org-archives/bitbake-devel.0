Return-Path: <juro.bystricky@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id A7F51601D3
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491488854; x=1523024854;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=ArGy4Wxyufmsu/BVDBykBIAPWdD47dFy92unO7XJyoU=;
	b=GgbtXTUyfLJR+5zyts3NMi1o3LD37yaQOkanSpxP01ZdPhnxukuHHYqc
	/f2GVONbNfm4N7v67w7200TPVvJoiA==;
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Apr 2017 07:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,160,1488873600"; d="scan'208";a="70301473"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
	by orsmga002.jf.intel.com with ESMTP; 06 Apr 2017 07:27:32 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.213]) by
	ORSMSX102.amr.corp.intel.com ([169.254.3.105]) with mapi id
	14.03.0319.002; Thu, 6 Apr 2017 07:23:23 -0700
From: "Bystricky, Juro" <juro.bystricky@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Ohly, Patrick"
	<patrick.ohly@intel.com>
Thread-Topic: [bitbake-devel] [PATCH] cooker.py: multiconfig support for
	findBestProvider
Thread-Index: AQHSrlRh08WmcleoWEWmz01mw3pJq6G4fE4AgAAzBoD//7Y7rA==
Date: Thu, 6 Apr 2017 14:23:22 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B61193F75E@ORSMSX112.amr.corp.intel.com>
References: <1491428045-10132-1-git-send-email-juro.bystricky@intel.com>
	<1491468186.10884.38.camel@intel.com>,
	<1491479143.17200.36.camel@linuxfoundation.org>
In-Reply-To: <1491479143.17200.36.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.9.41]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker.py: multiconfig support for findBestProvider
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
X-List-Received-Date: Thu, 06 Apr 2017 14:27:32 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks, v2 coming soon. This clarifies some other issues as well.=0A=
=0A=
Juro=0A=
________________________________________=0A=
From: Richard Purdie [richard.purdie@linuxfoundation.org]=0A=
Sent: Thursday, April 06, 2017 4:45 AM=0A=
To: Ohly, Patrick; Bystricky, Juro=0A=
Cc: bitbake-devel@lists.openembedded.org=0A=
Subject: Re: [bitbake-devel] [PATCH] cooker.py: multiconfig support for fin=
dBestProvider=0A=
=0A=
On Thu, 2017-04-06 at 10:43 +0200, Patrick Ohly wrote:=0A=
> On Wed, 2017-04-05 at 14:34 -0700, Juro Bystricky wrote:=0A=
> >=0A=
> > In a multiconfig environment, a tinfoil call such as=0A=
> >=0A=
> >     tinfoil.parse_recipe("multiconfig:arduino-101-sss:gcc")=0A=
> >=0A=
> > can fail with an error such as:=0A=
> >=0A=
> >   File "/data/master/poky/bitbake/lib/bb/tinfoil.py", line 373, in=0A=
> > get_recipe_file=0A=
> >     raise bb.providers.NoProvider('Unable to find any recipe file=0A=
> > matching "%s"' % pn)=0A=
> > bb.providers.NoProvider: Unable to find any recipe file matching=0A=
> > "multiconfig:arduino-101-sss:gcc"=0A=
> >=0A=
> > The culprit is findBestProvider (only called from tinfoil), which=0A=
> > does not=0A=
> > handle multiconfig. This patch fixes the error and the tinfoil call=0A=
> > returns absolute path=0A=
> > to the recipe, i.e:=0A=
> >=0A=
> >   "/data/master/poky/meta/recipes-devtools/gcc/gcc_6.3.bb"=0A=
> So tinfoil.parse_recipe("multiconfig:arduino-101-sss:gcc") and=0A=
> tinfoil.parse_recipe("gcc") then return identical data, because both=0A=
> end=0A=
> up parsing "/data/master/poky/meta/recipes-devtools/gcc/gcc_6.3.bb"=0A=
> without taking the "arduino-101-sss" config into account?=0A=
>=0A=
> That wouldn't be correct.=0A=
>=0A=
> As far as I understand it, the mapping has to be:=0A=
> multiconfig:arduino-101-sss:gcc ->=0A=
> multiconfig:arduino-101-sss:/data/master/poky/meta/recipes-=0A=
> devtools/gcc/gcc_6.3.bb=0A=
=0A=
I agree with Patrick. At a quick glance, I think the caller=0A=
of findBestProvider is going to need to handle the mc, which is=0A=
why findBestProvider takes it as a parameter.=0A=
=0A=
Cheers,=0A=
=0A=
Richard=0A=

