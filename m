Return-Path: <jose.a.lamego@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 805E471B2C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Dec 2016 16:31:07 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga104.jf.intel.com with ESMTP; 01 Dec 2016 08:31:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,282,1477983600"; 
	d="asc'?scan'208";a="36237122"
Received: from jalamego-mobl2.zpn.intel.com (HELO [10.219.5.138])
	([10.219.5.138])
	by orsmga004.jf.intel.com with ESMTP; 01 Dec 2016 08:31:09 -0800
To: bitbake-devel@lists.openembedded.org
From: Jose Lamego <jose.a.lamego@linux.intel.com>
Message-ID: <d34a30ab-5658-62cd-095e-ecc5d8ea60b8@linux.intel.com>
Date: Thu, 1 Dec 2016 10:31:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.4.0
MIME-Version: 1.0
Subject: Re: [V2] bitbake: cooker: convert type which needs to be marshalled
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
X-List-Received-Date: Thu, 01 Dec 2016 16:31:08 -0000
X-Groupsio-MsgNum: 8245
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="L6SalOu9jhr91vKPfADoX32o0glfw7Ntc"

--L6SalOu9jhr91vKPfADoX32o0glfw7Ntc
Content-Type: multipart/mixed; boundary="pqiXtC0OAuQM1aj0SVkbxADR3lF7Ir8f9";
 protected-headers="v1"
From: Jose Lamego <jose.a.lamego@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <d34a30ab-5658-62cd-095e-ecc5d8ea60b8@linux.intel.com>
Subject: re: [V2] bitbake: cooker: convert type which needs to be marshalled

--pqiXtC0OAuQM1aj0SVkbxADR3lF7Ir8f9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sujit,

Seems that you edited the original patch message to submit your V2
patch. This causes the V2 message to have the same message id as the V1,
which produces an error when Patchwork tries to process it and the new
revision is not displayed at your patch series. You can can see what I'm
talking about in:
https://patchwork.openembedded.org/series/4136/

Next time please the new revisions as replies to the first message to
keep the message chain.

Regards
Jose


--pqiXtC0OAuQM1aj0SVkbxADR3lF7Ir8f9--

--L6SalOu9jhr91vKPfADoX32o0glfw7Ntc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJYQFBRAAoJEFJAtowlSEbnyUIH/j8BLKwzptSf6t8vrnuRW40n
bHSEIPBYSpbtr4JFpbKy1n31fk3QDkTu1qdTBGw4U8rZML9WFripLodqLspuyuwy
0izlO/Kh+e59OjHMJqEOAFcnhh5/1SMFo/BwNJZL1ICv/CNogvN0gYdFm2PU5lIQ
AAcFWTxjhJL8U9RsIcmvM4ZYerWJyCB4FS0eNOVfSmxlgv8beNt9z0OHOw0UjMks
unw6w/vOHz8YRv3dOiNkcTCK7Twxe5fPqJcnbeLA6DgHbYBxX5cBBt+8oq+r4c1Q
ApmAm1jM224cZ0qgdkZ7ko3J4ksaKOSM+vL5dt1x6Qtb0l+UAUHoQ8W0TQfy9VE=
=8ar1
-----END PGP SIGNATURE-----

--L6SalOu9jhr91vKPfADoX32o0glfw7Ntc--
