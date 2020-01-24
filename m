Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by mail.openembedded.org (Postfix) with ESMTP id 3D5987FBCD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 15:36:20 +0000 (UTC)
IronPort-SDR: cPU7zc3oEmamR1aS9+b/a+8bLFZdPWOkOQp4xr/jMIRMc/R08fqi1iJp1jsk6rGirddDOG8CQZ
	Pfgsmk4PHmL7Vsn1YJJZlkwP5K+b/MvLgg8L2cSFsNmWPKGsQ4SjytcCUg0ujCUDLQ5+4H4jmR
	cE7FxluvDLl0UU8SkUmAWJ+0+6GiQNQHzcR7QDUJnYm0RVDCQuFvB3eff7ti0BimxJ/FTwPn5V
	hNN3sg8vnrAUqQV6eBOpHJ+ABQMaedFPoaGg8q4vpVWv1kKqwRYUtwkVtnRR6PBpsvW0iqgtmo
	6MY=
X-IronPort-AV: E=Sophos;i="5.70,358,1574118000"; 
   d="scan'208";a="4740120"
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH v5 00/12] NPM refactoring
Thread-Index: AQHVz3x/QnusXLsZr0K56uOPTx2QGqf594kA
Date: Fri, 24 Jan 2020 15:36:21 +0000
Message-ID: <1ef81c85f9184cf8a60983369b6d155a@XBOX03.axis.com>
References: <20200120102720.20868-1-jean-marie.lemetayer@savoirfairelinux.com>
In-Reply-To: <20200120102720.20868-1-jean-marie.lemetayer@savoirfairelinux.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
Cc: "paul.eggleton@linux.intel.com" <paul.eggleton@linux.intel.com>,
	"rennes-dev@savoirfairelinux.com" <rennes-dev@savoirfairelinux.com>
Subject: Re: [PATCH v5 00/12] NPM refactoring
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
X-List-Received-Date: Fri, 24 Jan 2020 15:36:21 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

You should remove the "bitbake: " prefix from the subject line for=20
all the patches in this series. It is added automatically when the=20
bitbake repository is "merged" to the poky repository. Otherwise=20
you will see them as "bitbake: bitbake: ..." in poky, which you=20
can see now on the master-next branch.

//Peter

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> bounces@lists.openembedded.org> On Behalf Of Jean-Marie LEMETAYER
> Sent: den 20 januari 2020 11:27
> To: bitbake-devel@lists.openembedded.org
> Cc: rennes-dev@savoirfairelinux.com; paul.eggleton@linux.intel.com
> Subject: [bitbake-devel] [PATCH v5 00/12] NPM refactoring
>=20
> Hi folks and happy new year,
>=20
> These patches are part of a set which are mainly in OE-core.
> More infos can be found on the openembedded-core list.
>=20
> For readability here is a link if you want the history of this patchset:
> http://lists.openembedded.org/pipermail/openembedded-core/2019-
> December/290298.html
>=20
> --- V4
>=20
> These patches can be found here:
> https://github.com/savoirfairelinux/bitbake/tree/npm-refactoring-v4
>=20
>  - As suggested by Richard, a new npmsw fetcher have been implemented to
> handle
>    the npm dependencies. Now the fetch of the main package is separated
> from the
>    fetch of its dependencies.
>=20
>  - Add the support of "proxy" fetchers. These fetchers (npm and npmsw)
> just
>    resolves an url and forwards it to a "raw" fetcher (wget, git, ...).
>    For example an npm url like:
>      npm://registry...;package=3D...;version=3D...
>    is converted as:
>      https://registry.../...tgz;downloadfilename=3Dnpm2/...tgz;sha256sum=
=3D...
>=20
>  - Add more hash functions for checksum verification to be able to suppor=
t
> the
>    subresource integrity [1] returned by the npm registry. The supported
> hash
>    functions are now: md5, sha1, sha256, sha384, sah512
>=20
>  - More tests have been added for the npm and the npmsw fetchers includin=
g
> tests
>    for the proxy forwarding thing (checksum, mirrors).
>=20
> 1: https://www.w3.org/TR/SRI/
>=20
> --- V5
>=20
> These patches can be found here:
> https://github.com/savoirfairelinux/bitbake/tree/npm-refactoring-v5
>=20
>  - As suggested by Christopher, the fetchers now use the shlex.quote()
> function
>    to handle arguments to shell function.
>=20
> Jean-Marie LEMETAYER (12):
>   bitbake: utils: add sha384_file and sha512_file functions
>   bitbake: utils: add is_semver function
>   bitbake: fetch2: refactor checksum verification
>   bitbake: fetch2: add more hash functions for checksum verification
>   bitbake: fetch2: allow fetchers to forward the donestamp management
>   bitbake: fetch2: allow fetchers to forward the mirrors management
>   bitbake: fetch2: allow fetchers to forward the done condition
>   bitbake: fetch2/wget: fix downloadfilename parameter
>   bitbake: fetch2/npm: refactor the npm fetcher
>   bitbake: tests/fetch: add npm tests
>   bitbake: fetch2: add the npmsw fetcher
>   bitbake: tests/fetch: add npmsw tests
>=20
>  lib/bb/fetch2/__init__.py | 215 +++++++++------
>  lib/bb/fetch2/npm.py      | 538 +++++++++++++++++++-------------------
>  lib/bb/fetch2/npmsw.py    | 255 ++++++++++++++++++
>  lib/bb/fetch2/wget.py     |   7 +-
>  lib/bb/tests/fetch.py     | 434 ++++++++++++++++++++++++++++++
>  lib/bb/utils.py           |  40 +++
>  6 files changed, 1129 insertions(+), 360 deletions(-)
>  create mode 100644 lib/bb/fetch2/npmsw.py
>=20
> --
> 2.20.1
>=20
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

