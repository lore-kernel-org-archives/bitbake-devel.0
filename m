Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mx.groups.io with SMTP id smtpd.web12.14804.1590680164035172597
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 08:36:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: linux.intel.com, ip: 134.134.136.20, mailfrom: timothy.t.orling@linux.intel.com)
IronPort-SDR: LZagfqHOIbHukaJ1+eTJA5iUkk0J3aK54BF31fKTC6eqUW7CyBrwUk/ibYrWTWHXBGqNLIlr1d
 erfcuLGXrP7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:36:03 -0700
IronPort-SDR: vPea4FgyC4Ub5Wb4byfuH4cmMblpT3ZJme+K13D3vGp4MH/YzsKt6X5CnDPbdlPOkZNFiFBukJ
 WyExQeUUlyCQ==
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="302515723"
Received: from ravithir-mobl.amr.corp.intel.com ([10.255.231.83])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:36:02 -0700
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [bitbake-devel] [dunfell][1.46][PATCH] toaster-requirements.txt: require Django 2.2
From: "Tim Orling" <timothy.t.orling@linux.intel.com>
In-Reply-To: <16130638236101B8.10634@lists.openembedded.org>
Date: Thu, 28 May 2020 08:36:00 -0700
Cc: david.reyna@windriver.com,
 steve@sakoman.com
Message-Id: <F6E54FD5-F4C8-4D90-8F60-12557D0C25D9@linux.intel.com>
References: <16130638236101B8.10634@lists.openembedded.org>
To: bitbake-devel@lists.openembedded.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

+CC: Steve Sakoman (dunfell maintainer)

> On May 27, 2020, at 4:25 PM, Tim Orling <timothy.t.orling@linux.intel.co=
m> wrote:
>=20
> In commit 9730f95686b2ac72cf1fa513c555f7c7787e2667
> Django 2.2 was enabled.
>=20
> Django 1.11 was EOL on April 1, 2020
>=20
> Signed-off-by: Tim Orling <timothy.t.orling@linux.intel.com>
> ---
> toaster-requirements.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/toaster-requirements.txt b/toaster-requirements.txt
> index a682b085..735b6145 100644
> --- a/toaster-requirements.txt
> +++ b/toaster-requirements.txt
> @@ -1,3 +1,3 @@
> -Django>1.8,<1.12
> +Django>2.2,<2.3
> beautifulsoup4>=3D4.4.0
> pytz
> --=20
> 2.24.0
>=20
>=20

