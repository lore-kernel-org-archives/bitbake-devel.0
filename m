Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0B24B731F8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 00:50:40 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 22 Feb 2016 16:50:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,487,1449561600"; 
	d="asc'?scan'208";a="751273252"
Received: from alimonb-mobl1.zpn.intel.com (HELO [10.219.5.35]) ([10.219.5.35])
	by orsmga003.jf.intel.com with ESMTP; 22 Feb 2016 16:50:40 -0800
To: bitbake-devel@lists.openembedded.org
References: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Message-ID: <56CBAD68.6020704@linux.intel.com>
Date: Mon, 22 Feb 2016 18:52:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
Cc: alexandru.c.georgescu@intel.com, stanciux.mihail@intel.com
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
X-List-Received-Date: Tue, 23 Feb 2016 00:50:41 -0000
X-Groupsio-MsgNum: 7075
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="7JL9rVon8aXoNwOjUjAsbcEQggFSjsm5r"

--7JL9rVon8aXoNwOjUjAsbcEQggFSjsm5r
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I forget to comment that the changes can be also found in:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=3Dalimon/to=
aster_tests_squash

Cheers,
	alimon


On 02/22/2016 06:51 PM, An=C3=ADbal Lim=C3=B3n wrote:
> This set of changes refactor/improve the current test suite now it can =
be
> parameterized from command line.
>=20
> The main goal for this set of patches are for integrate the toaster
> test suite into AB. The AB part is already on master. [1] If this patch=
set
> is merged the way for run Toaster test suite will change for use it rea=
d
> README in this patchset.
>=20
> Futher work are related to improve/fix the current test suite also i ad=
ded
> a TODO list.
>=20
> [1] http://git.yoctoproject.org/cgit/cgit.cgi/yocto-autobuilder/commit/=
?id=3D4ad04739d7414046775be84eeb2553d12acf94ef
>=20
> An=C3=ADbal Lim=C3=B3n (8):
>   toaster/tests: Reorder/move current test code.
>   toaster/tests: Add __init__.py and base.py.
>   toaster/tests: Improve ui.py module.
>   toaster/tests: Adds setup test case.
>   toaster/tests: Add helpers.py module.
>   toaster-test: Refactor and imporvements.
>   toaster/tests: Add README, TODO and requeriments.
>   toaster/tests: Adds Copyright information.
>=20
>  bin/toaster-test                                   |  238 ++
>  .../contrib/tts/toasteruitest/run_toastertests.py  |  155 --
>  .../tts/toasteruitest/toaster_automation_test.py   | 2376 ------------=
-------
>  .../contrib/tts/toasteruitest/toaster_test.cfg     |   25 -
>  lib/toaster/tests/README                           |   64 +
>  lib/toaster/tests/TODO                             |   13 +
>  lib/toaster/tests/__init__.py                      |    0
>  lib/toaster/tests/base.py                          |   28 +
>  lib/toaster/tests/helpers.py                       |  192 ++
>  lib/toaster/tests/setup.py                         |   94 +
>  lib/toaster/tests/toaster_test.cfg                 |   25 +
>  lib/toaster/tests/ui.py                            | 2379 ++++++++++++=
++++++++
>  toaster-tests-requirements.txt                     |    5 +
>  13 files changed, 3038 insertions(+), 2556 deletions(-)
>  create mode 100755 bin/toaster-test
>  delete mode 100755 lib/toaster/contrib/tts/toasteruitest/run_toasterte=
sts.py
>  delete mode 100755 lib/toaster/contrib/tts/toasteruitest/toaster_autom=
ation_test.py
>  delete mode 100644 lib/toaster/contrib/tts/toasteruitest/toaster_test.=
cfg
>  create mode 100644 lib/toaster/tests/README
>  create mode 100644 lib/toaster/tests/TODO
>  create mode 100644 lib/toaster/tests/__init__.py
>  create mode 100644 lib/toaster/tests/base.py
>  create mode 100755 lib/toaster/tests/helpers.py
>  create mode 100644 lib/toaster/tests/setup.py
>  create mode 100644 lib/toaster/tests/toaster_test.cfg
>  create mode 100644 lib/toaster/tests/ui.py
>  create mode 100644 toaster-tests-requirements.txt
>=20


--7JL9rVon8aXoNwOjUjAsbcEQggFSjsm5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJWy61qAAoJEGJqcE9h3glgn9oP/1xy2/Ws7368m7ioMgVsAvZG
JdAUipyDnwNb0VN2MqdKnIAiM/dP34sYOeVorgTKVSzjU/JBkMv4rGvwn0UuPcYC
mIJ6Vkv9ftmbngzDXE9FRHnOR2d5Cmo0I3QFDOT0u4RRbnvZVISDsB1d+C4M8+m4
22NzIkHC0HHsqb6xUxzp57OuSwXb4m2X00MOloGOMi89U4a3CU0o8AVGyX/Q9AGd
U8nQef7arT5mi9LsBC6L6WTUyc6YaJjY9N6DWJ2rsJcWuYIoOBrCl9e+cqfBi+A+
ue4frG2ZBqth6F2lDEzIO59/nXv8dTIiXKtji/DbGrU+Ibge6aXL1vv3jDbvpfrs
vCZA7aSgiNN7FgJK34yUOr+E7LRovoHMuayccguxU/wx1ubBh4WsPoOxQ8YxlJ22
UY2zE8/juaZXcpUn/EYBH4KSorVRGTbhND8akK/VRy5FBqry4jBRE6EwoYPhClhd
EEdiVrqcfvGGvBGQ+YVPlxku8GxE5o6dIxP3MQepK54iS8BsPD2oc4dPyUTZXFxA
IoodQMp/H1e/Xj4TeM+VpD9DUU7INzrWWLXU+O9m3SeD+IBkwMWy2SCCLqB6wt+l
Mz8DYu9Zr5rSidHBeqONr/VFR2tlDoM6irFOXAHdnII5REzV8OrkkmMY+B9hCvRj
sQUiynvBn/Oh0v4rBgum
=Zf9h
-----END PGP SIGNATURE-----

--7JL9rVon8aXoNwOjUjAsbcEQggFSjsm5r--
