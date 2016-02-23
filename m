Return-Path: <anibal.limon@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5310977324
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 14:29:55 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 23 Feb 2016 06:29:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,489,1449561600"; 
	d="asc'?scan'208";a="922105484"
Received: from alimonb-mobl1.zpn.intel.com (HELO [10.219.5.35]) ([10.219.5.35])
	by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2016 06:29:41 -0800
To: bitbake-devel@lists.openembedded.org
References: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
	<56CBAD68.6020704@linux.intel.com>
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Message-ID: <56CC6D5C.9060404@linux.intel.com>
Date: Tue, 23 Feb 2016 08:31:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <56CBAD68.6020704@linux.intel.com>
Cc: alexandru.c.georgescu@intel.com, stanciux.mihail@intel.com, "Randle,
	William C" <william.c.randle@intel.com>
Subject: Re: [[RFC][PATCH] 0/8] Toaster improve test suite
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
X-List-Received-Date: Tue, 23 Feb 2016 14:29:58 -0000
X-Groupsio-MsgNum: 7078
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PH6b1xd618U7LnLbgjEwh7aPjTTsEpbK3"

--PH6b1xd618U7LnLbgjEwh7aPjTTsEpbK3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

+ Bill

On 02/22/2016 06:52 PM, An=C3=ADbal Lim=C3=B3n wrote:
> I forget to comment that the changes can be also found in:
>=20
> http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dalimon/=
toaster_tests_squash
>=20
> Cheers,
> 	alimon
>=20
>=20
> On 02/22/2016 06:51 PM, An=C3=ADbal Lim=C3=B3n wrote:
>> This set of changes refactor/improve the current test suite now it can=
 be
>> parameterized from command line.
>>
>> The main goal for this set of patches are for integrate the toaster
>> test suite into AB. The AB part is already on master. [1] If this patc=
hset
>> is merged the way for run Toaster test suite will change for use it re=
ad
>> README in this patchset.
>>
>> Futher work are related to improve/fix the current test suite also i a=
dded
>> a TODO list.
>>
>> [1] http://git.yoctoproject.org/cgit/cgit.cgi/yocto-autobuilder/commit=
/?id=3D4ad04739d7414046775be84eeb2553d12acf94ef
>>
>> An=C3=ADbal Lim=C3=B3n (8):
>>   toaster/tests: Reorder/move current test code.
>>   toaster/tests: Add __init__.py and base.py.
>>   toaster/tests: Improve ui.py module.
>>   toaster/tests: Adds setup test case.
>>   toaster/tests: Add helpers.py module.
>>   toaster-test: Refactor and imporvements.
>>   toaster/tests: Add README, TODO and requeriments.
>>   toaster/tests: Adds Copyright information.
>>
>>  bin/toaster-test                                   |  238 ++
>>  .../contrib/tts/toasteruitest/run_toastertests.py  |  155 --
>>  .../tts/toasteruitest/toaster_automation_test.py   | 2376 -----------=
--------
>>  .../contrib/tts/toasteruitest/toaster_test.cfg     |   25 -
>>  lib/toaster/tests/README                           |   64 +
>>  lib/toaster/tests/TODO                             |   13 +
>>  lib/toaster/tests/__init__.py                      |    0
>>  lib/toaster/tests/base.py                          |   28 +
>>  lib/toaster/tests/helpers.py                       |  192 ++
>>  lib/toaster/tests/setup.py                         |   94 +
>>  lib/toaster/tests/toaster_test.cfg                 |   25 +
>>  lib/toaster/tests/ui.py                            | 2379 +++++++++++=
+++++++++
>>  toaster-tests-requirements.txt                     |    5 +
>>  13 files changed, 3038 insertions(+), 2556 deletions(-)
>>  create mode 100755 bin/toaster-test
>>  delete mode 100755 lib/toaster/contrib/tts/toasteruitest/run_toastert=
ests.py
>>  delete mode 100755 lib/toaster/contrib/tts/toasteruitest/toaster_auto=
mation_test.py
>>  delete mode 100644 lib/toaster/contrib/tts/toasteruitest/toaster_test=
=2Ecfg
>>  create mode 100644 lib/toaster/tests/README
>>  create mode 100644 lib/toaster/tests/TODO
>>  create mode 100644 lib/toaster/tests/__init__.py
>>  create mode 100644 lib/toaster/tests/base.py
>>  create mode 100755 lib/toaster/tests/helpers.py
>>  create mode 100644 lib/toaster/tests/setup.py
>>  create mode 100644 lib/toaster/tests/toaster_test.cfg
>>  create mode 100644 lib/toaster/tests/ui.py
>>  create mode 100644 toaster-tests-requirements.txt
>>
>=20


--PH6b1xd618U7LnLbgjEwh7aPjTTsEpbK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJWzG1fAAoJEGJqcE9h3glg4ssP/jg0sdCnDXxdO7oewVmSl4Sp
8NnOzpG4wzEEWxdKjNywHkNTr/5HjnoO/qa5OzTfztAH5GaKosSs42WbvDLfGwSD
4kuX+9c5GwVoYxBfGrjna6afeBBhRgHdMOh/fMXK8XYfIldKtBX5KvvNaCbLN+PX
rLbSBCguaLv878N15HFx415tKR4NnXVqyPb8HaYVIUBIVq/InBMZaAJ0210Nz6fG
aXgQFHRNVvfVxg+Or/STK9CZaKAOspukeDXJXAkgPROcgkMX+sdmMn0j5vlCnT3z
011KiQR9UVXL8erz1vh0EUAK81FP/qB2aCMVVwt/aPLl9RQnHTHdhYmAotKmozCj
pOnzCJaJy10/e21C4LKgnOItetpkDiWuGkMXvXl6fNvU9KI4gLUJb855ufxhp7A8
1Jafdf5iv5xdJYm+IoB37xeeQTu6VALPZVIJTyxAeCGc8k5a3OGBJ9rW1eSOxeKs
GolIBue9hE3zWx29lgSfoTpgG4sHGBWQBeQf5SZdRYOanZ+4ey5+Ti+A8oexMivk
ouTvK5GyKSnavrPCVDskqplbcNHQ/NkGRKHFYAh5drruqrprgSg6z+UyKIiFWVlj
ZhSQtXDMDXAbqONn2tQoZCh4D2yO+56r9UVnsJ/084ikoKT/Vj3ucMg1cZ/pKhpC
mcNZRJhJXR/ECytoNYsN
=0ILc
-----END PGP SIGNATURE-----

--PH6b1xd618U7LnLbgjEwh7aPjTTsEpbK3--
