Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B7CD3436
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 14:13:34 +0000 (UTC)
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14695.1778249611232356246
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 May 2026 07:13:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=F3Y3APJ6;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=nl0yqKk1;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.153, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4101E7A0101;
	Fri,  8 May 2026 10:13:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 08 May 2026 10:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1778249610; x=1778336010; bh=n4nvoSy2wh
	16ueqaSPoyJWYAfBsodORouORiSZEaMcM=; b=F3Y3APJ6cALo/BLg7qkjshwD13
	Rb8kbjKBSsNqBrXVu3CiUoWue8yCiUDFN7FyyQo5Cndte8QHo89Sy6e6TTLVxvd2
	/Hm6/PMcNDTYzY3mZXiBbgj4SS+cgI5h+3PeRBjWjO9fydsSgKtkaisXHhl1oWqx
	3O865AGx/NQ7LF5sOjQgnznUdNfPQghko4cjal3W9Eb3DakUWCaJ4OXibiJ9SIND
	VV2TDmutDMNhXGWyRgmQE8EeZJnYo/KLiPW+WcM0gw8WAze4vRfgGwAU6kDM/qQv
	18dZKS/GHvk+zj1cR0sPoDFoKak2oIoCtL34KvyjSa7k+91wB0CNBkrRkFCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778249610; x=1778336010; bh=n4nvoSy2wh16ueqaSPoyJWYAfBsodORouOR
	iSZEaMcM=; b=nl0yqKk18d7Tpk5qnmuQurLRY4PjA7V/sHTGXR+H4A7rdljfC8x
	CtkfwhC+HnQESehvcO0FjGR6N+oZy5J+hQNF2nhLonyTvBBu1IuOArwjJiWmIqfe
	pnLyAf5EdsSscxac8X3f7McbYwAuBZpMX+VVzVHCkXZ9W7J/vb2DxWE/XtL3x9C7
	36bf8iFgvCoo4ndb6B5Qln8tsoRf8gMFDyyvBf2YUB7hDk/THV0QsidxGE8Hjb5o
	vh+7H5fUJKpgcmsNVeyUfy7aa3s3XjdB5qV3r1EwbKpJ9Ijde1wuihFyh+M2FUhW
	rGjnJFrLmjkHHzCn2+Fz5whbBfeHdHfMtgQ==
X-ME-Sender: <xms:ie_9aYjs4fLuYtn_aCgK_kHIXKY0d3WIVrygO_npCXzEOpHcM8h-xQ>
    <xme:ie_9aXCFpzrFf-Ozqr1-dmOt4VUHJUmJsAz7978okYrgd1n3sTKAoXC6PxWEOUimD
    57NySn23eKowrHm8zm7F11PfLMvgQ1uocur0CBnmL2cLmTrrh1kmCk>
X-ME-Received: <xmr:ie_9adtmv9Jr7cZxDricrS_h-Q91il1IMzDoU-x9-HVRk6icKItd_T_qm0S2dpLRVd1UUykt6CXz7xqa_RRi5DV_PczksZvE_8yt_US4Bsfh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggesghdtreertd
    erjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepveegieelgfdvuedttedtkeduueejffetueehte
    duudetudekffduuefgveeijeejnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdr
    ohhrghdphhhtthhpphgrthhhfihouhhlughothhhvghrfihishgvrhgrtggvrghgrghinh
    hsthhthhgvfhhilhgvohhrihhguhgurdhithdphihotghtohhprhhojhgvtghtrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruh
    hlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehjhhhonhgrthgrrdhpohhmrgesghhmrghilhdrtghomhdprh
    gtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvggu
    uggvugdrohhrgh
X-ME-Proxy: <xmx:ie_9aUbWpZVb6yXaQQprZbpgrj96mIDjSy2I3RitsBepYQ4biH1yIQ>
    <xmx:ie_9aYWdbdzHedvBUmCZpEHmI1Ok2QGhmK3MNVoHzEUtPZ95iEjqaw>
    <xmx:ie_9aQ57ZYDtEQmCghstY1kOoSWJKozq2xgW4CGjIHguNGSEc64UPw>
    <xmx:ie_9abirQEj1SXWEJF7Us_GBfX_LlF4yHMnk2SqSvG5x16ZqEKk9Aw>
    <xmx:iu_9afzOFa58NMQk2da6u8PbCvifOGxccketb0rSJFSWUH5jhb7rd56K>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 10:13:29 -0400 (EDT)
Message-ID: <162413fca4aa8fa53472aa6ba1e12b56c1a5c5c9.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH] fetch2/local: verify checksums for
 file:// urls
From: Paul Barker <paul@pbarker.dev>
To: Jhonata.poma@gmail.com, bitbake-devel@lists.openembedded.org
Date: Fri, 08 May 2026 15:13:26 +0100
In-Reply-To: <20260430-b4-yocto-9993-v1-1-a54d842cd0fd@gmail.com>
References: <20260430-b4-yocto-9993-v1-1-a54d842cd0fd@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-D2Hx8J2P0wmlyNuI/UGR"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 14:13:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19478


--=-D2Hx8J2P0wmlyNuI/UGR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-04-30 at 16:25 +0200, Jhonata Poma-Hansen via
lists.openembedded.org wrote:
> Local.urldata_init unconditionally cleared ud.needdonestamp, which
> short-circuited the donestamp + verify_checksum cycle for every
> file:// url. As a result, a checksum supplied as a url parameter
> (for instance UNINATIVE_CHECKSUM expanded into the uninative
> tarball's file:// url) was never compared against the file's
> actual contents - the fetcher silently used whatever bytes were
> at the path.
>=20
> Keep needdonestamp at the FetchData default (True) when the url
> carries any of the known checksum parameters, so the standard
> verify_checksum flow runs and a mismatch raises ChecksumError just
> like it does for http:// and friends. The check uses CHECKSUM_LIST
> and handles both the bare ;<algo>sum=3D form and the named
> ;name=3Dfoo;foo.<algo>sum=3D form that recipes (and UNINATIVE_CHECKSUM)
> actually use. When no checksum is supplied (the common case for
> file:// recipe patches) needdonestamp stays False and behavior is
> unchanged - no .done / .lock files appear in DL_DIR for those urls.
>=20
> For checksummed file:// urls, the donestamp + lockfile do land in
> DL_DIR (keyed by basename, alongside the existing http(s) state
> for the same basename); this is intentional and matches how every
> other fetcher tracks verified content.
>=20
> An earlier fix (b8b14d975a25 "fetch2: Ensure we don't have file
> downloads overwriting each other", 2017) added a short-circuit at
> the top of verify_donestamp() so that when origud is a file:// url
> with needdonestamp=3DFalse, the function returns True early. That
> short-circuit was protecting the SSTATE_MIRRORS case where a
> file:// url is mapped to an http:// mirror and the http path would
> otherwise race against the file:// origud. It still does the
> right thing under this change: the only file:// origud whose
> needdonestamp now flips to True is one that carries an explicit
> checksum parameter, and in that case we actively want the mirror
> to run verify_donestamp(), not bypass it. The unchecksummed
> file:// origud case (the original SSTATE_MIRRORS scenario) keeps
> needdonestamp=3DFalse and the 2017 short-circuit fires unchanged.
>=20
> Two related changes in fetch2 are worth pointing at:
>=20
> * commit 6424f4b7e9c1 ("fetch2: Ensure mirror tarballs don't enforce
>   checksum", 2022) marks SSTATE_MIRRORS targets with
>   newud.ignore_checksums =3D True. Its commit message states "local
>   file fetches now validate checksums" - this fix is what finally
>   makes that statement true. The ignore_checksums flag also acts as
>   the safety hatch that prevents flipping needdonestamp on for
>   checksummed file:// urls from propagating verification onto
>   mirror-of-git-repo tarballs (whose checksums by design do not
>   match).
> * commit 4b8de2e7d126 ("wget: Avoid bad checksum race issues",
>   2022) established the don't-mutate-on-mismatch doctrine for
>   downloaded artifacts via the localpath=3D and fatal_nochecksum=3D
>   parameters. The rename_bad_checksum() early-return below applies
>   the same doctrine to a fetcher whose 'localpath' is the user's
>   source tree.
>=20
> A checksum mismatch on a file:// url must not mutate the user's
> source tree the way it does for downloaded artifacts in DL_DIR.
> The standard error path renames <localpath> to
> <localpath>_bad-checksum_<sha> via rename_bad_checksum(), which
> for file:// would rename a recipe-shipped patch or an absolute
> path the user had supplied. Skip that rename inside
> rename_bad_checksum() when ud.type =3D=3D 'file' so all four call
> sites stay consistent and a ChecksumError surfaces cleanly without
> on-disk side effects.
>=20
> Add unit tests in FetcherLocalTest covering: the no-checksum hot
> path keeps needdonestamp=3DFalse (no regression for recipe patches);
> matching and mismatching sha256 and md5 checksums; the named
> ;name=3Dfoo;foo.sha256sum=3D form; and that a directory url with a
> checksum is silently ignored (supports_checksum() is False for
> directories). The mismatch tests assert that the source file is
> not renamed.
>=20
> Link: https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D9993
> [YOCTO #9993]
>=20
> Signed-off-by: Jhonata Poma-Hansen <jhonata.poma@gmail.com>

Hi,

The commit message here is incredibly verbose, to the point that it is
difficult to read. While being verbose, it fails to mention that
UNINATIVE_URL uses 'https://' in our metadata and so the issue only
arises when you replace this with a local 'file://' URL (this is
mentioned in the description of issue #9993).

Please simplify the commit message and focus on the relevant
information.=20

> ---
>  lib/bb/fetch2/__init__.py |   8 ++++
>  lib/bb/fetch2/local.py    |  19 ++++++++-
>  lib/bb/tests/fetch.py     | 104 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 129 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 52d5556d..35874e25 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1075,6 +1075,14 @@ def rename_bad_checksum(ud, suffix):
>      if ud.localpath is None:
>          return
> =20
> +    # For file:// URLs the localpath points at the user's source tree
> +    # (e.g. recipe-shipped files under FILESPATH or an absolute path the
> +    # user passed in). Renaming those out from under the user is
> +    # destructive and surprising; surface the ChecksumError without
> +    # mutating their files.
> +    if ud.type =3D=3D 'file':
> +        return

We should not be adding special cases for specific fetchers in
__init__.py. Perhaps we could instead check if ud.localpath is under
DL_DIR, or move this function to the FetchMethod class so that the Local
fetcher can override it with an empty function.

> +
>      new_localpath =3D "%s_bad-checksum_%s" % (ud.localpath, suffix)
>      bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
>      if not bb.utils.movefile(ud.localpath, new_localpath):
> diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
> index fda56a56..2abcc5eb 100644
> --- a/lib/bb/fetch2/local.py
> +++ b/lib/bb/fetch2/local.py
> @@ -17,7 +17,7 @@ import os
>  import urllib.request, urllib.parse, urllib.error
>  import bb
>  import bb.utils
> -from   bb.fetch2 import FetchMethod, FetchError, ParameterError
> +from   bb.fetch2 import CHECKSUM_LIST, FetchMethod, FetchError, Paramete=
rError
>  from   bb.fetch2 import logger
> =20
>  class Local(FetchMethod):
> @@ -31,7 +31,22 @@ class Local(FetchMethod):
>          # We don't set localfile as for this fetcher the file is already=
 local!
>          ud.basename =3D os.path.basename(ud.path)
>          ud.basepath =3D ud.path
> -        ud.needdonestamp =3D False
> +        # Without a donestamp the verify_checksum path is bypassed entir=
ely
> +        # for file:// urls, so an explicit checksum on the url (for inst=
ance
> +        # UNINATIVE_CHECKSUM expanded into the uninative tarball file://=
 url)
> +        # is never compared against the file's actual contents. Keep
> +        # needdonestamp at the FetchData default (True) when any of the
> +        # known checksum parameters is present, so the standard
> +        # donestamp + verify_checksum cycle runs and a mismatch raises
> +        # ChecksumError. When no checksum is supplied (the common case f=
or
> +        # recipe patches under file://) needdonestamp stays False and
> +        # behavior is unchanged.
> +        name =3D ud.parm.get("name")
> +        ud.needdonestamp =3D any(
> +            (name and "%s.%ssum" % (name, a) in ud.parm)
> +            or "%ssum" % a in ud.parm
> +            for a in CHECKSUM_LIST
> +        )

The comment here is of about the right level of detail for the commit
message. A one or two line comment here to explain the conditional may
be useful, but more than that is probably too verbose.

>          if "*" in ud.path:
>              raise bb.fetch2.ParameterError("file:// urls using globbing =
are no longer supported. Please place the files in a directory and referenc=
e that instead.", ud.url)
>          return
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 077f741e..3347c60d 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -813,6 +813,110 @@ class FetcherLocalTest(FetcherTest):
>          tree =3D self.fetchUnpack(['file://archive.tar.bz2;subdir=3Dbar;=
striplevel=3D1'])
>          self.assertEqual(tree, ['bar/c', 'bar/d', 'bar/subdir/e'])
> =20
> +    def test_local_no_checksum_no_donestamp(self):
> +        # The common case: file:// recipe patches without a checksum
> +        # parameter must keep the historical "no donestamp tracking"
> +        # behavior so this fix does not regress the hot path. After
> +        # download(), no .done / .lock entries must appear in DL_DIR
> +        # for the bare file:// url.
> +        with open(os.path.join(self.localsrcdir, 'plain'), 'wb') as f:
> +            f.write(b"plain\n")
> +        fetcher =3D bb.fetch.Fetch(['file://plain'], self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +        self.assertFalse(ud.needdonestamp)
> +        # When needdonestamp is False, FetchData leaves ud.donestamp
> +        # unset (None); we assert that no .done / .lock entries are
> +        # written to DL_DIR for the bare file:// url after download.
> +        fetcher.download()
> +        for entry in os.listdir(self.dldir):
> +            self.assertFalse(entry.startswith('plain.done'))
> +            self.assertFalse(entry.startswith('plain.lock'))

I don't think this test case adds much value.

> +
> +    def test_local_checksum_match(self):
> +        # A correct sha256 must drive the verify_checksum cycle to
> +        # completion: download() returns without raising AND the
> +        # donestamp lands in DL_DIR. The donestamp is the on-disk
> +        # evidence that update_stamp() ran after verify_checksum()
> +        # passed - without the fix, needdonestamp=3DFalse short-circuits
> +        # update_stamp() and no donestamp is written even on "match".
> +        import hashlib
> +        content =3D b"file:// checksum match test\n"
> +        with open(os.path.join(self.localsrcdir, 'sumfile'), 'wb') as f:
> +            f.write(content)
> +        good =3D hashlib.sha256(content).hexdigest()
> +        fetcher =3D bb.fetch.Fetch(['file://sumfile;sha256sum=3D' + good=
], self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +        self.assertTrue(ud.needdonestamp)
> +        fetcher.download()
> +        self.assertTrue(os.path.exists(ud.donestamp))

This test case looks good, but the comment is again too verbose, please
simplify it.

> +
> +    def test_local_checksum_mismatch(self):
> +        content =3D b"file:// checksum mismatch test\n"
> +        srcpath =3D os.path.join(self.localsrcdir, 'sumfile')
> +        with open(srcpath, 'wb') as f:
> +            f.write(content)
> +        bad =3D "0" * 64
> +        fetcher =3D bb.fetch.Fetch(['file://sumfile;sha256sum=3D' + bad]=
, self.d)
> +        with self.assertRaises(bb.fetch2.FetchError):
> +            fetcher.download()
> +        # The user's source tree must not be mutated. rename_bad_checksu=
m
> +        # would otherwise leave a <path>_bad-checksum_<sha> sibling and
> +        # remove the original.
> +        self.assertTrue(os.path.exists(srcpath))
> +        with open(srcpath, 'rb') as f:
> +            self.assertEqual(f.read(), content)
> +        for entry in os.listdir(self.localsrcdir):
> +            self.assertNotIn('_bad-checksum_', entry)

This test case is mostly good. I don't think we need to loop through the
whole of the directory listing, can we just confirm that the
bad-checksum marker for sumfile doesn't exist?

> +
> +    def test_local_checksum_mismatch_md5(self):
> +        # Coverage for an algorithm other than sha256 so a regression
> +        # that special-cased sha256 detection does not slip through.
> +        # Mirror the sha256 mismatch assertions: source file present,
> +        # contents unchanged, no _bad-checksum_ sibling left behind.
> +        content =3D b"file:// md5 mismatch test\n"
> +        srcpath =3D os.path.join(self.localsrcdir, 'sumfile_md5')
> +        with open(srcpath, 'wb') as f:
> +            f.write(content)
> +        bad =3D "0" * 32
> +        fetcher =3D bb.fetch.Fetch(['file://sumfile_md5;md5sum=3D' + bad=
], self.d)
> +        with self.assertRaises(bb.fetch2.FetchError):
> +            fetcher.download()
> +        self.assertTrue(os.path.exists(srcpath))
> +        with open(srcpath, 'rb') as f:
> +            self.assertEqual(f.read(), content)
> +        for entry in os.listdir(self.localsrcdir):
> +            self.assertNotIn('_bad-checksum_', entry)

I don't think this test case adds value, the implementation is not
sha256sum specific.

> +
> +    def test_local_checksum_named(self):
> +        # UNINATIVE_CHECKSUM (the original reproducer for this bug) and
> +        # several other recipe-driven file:// urls use the name=3D prefi=
x
> +        # form: foo.sha256sum=3D rather than bare sha256sum=3D. Confirm =
the
> +        # named form flips needdonestamp AND that the verify cycle runs
> +        # (donestamp on disk after download).
> +        import hashlib
> +        content =3D b"file:// named checksum test\n"
> +        with open(os.path.join(self.localsrcdir, 'sumfile_named'), 'wb')=
 as f:
> +            f.write(content)
> +        good =3D hashlib.sha256(content).hexdigest()
> +        fetcher =3D bb.fetch.Fetch(
> +            ['file://sumfile_named;name=3Dblob;blob.sha256sum=3D' + good=
], self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +        self.assertTrue(ud.needdonestamp)
> +        fetcher.download()
> +        self.assertTrue(os.path.exists(ud.donestamp))

This is a case of testing at the wrong level of detail. Do we already
have test coverage that setting foo.some_property for a SRC_URI entry
with name=3Dfoo results in the property being set for the appropriate
entry? If so, we don't need further test coverage here. If not, we
should add a generic test case for that.=20

> +
> +    def test_local_checksum_directory_ignored(self):
> +        # Local supports directory urls; supports_checksum returns False
> +        # for directories. A checksum parm on a directory url should
> +        # therefore be a no-op rather than a hard error: verify_checksum
> +        # short-circuits on supports_checksum() and no ChecksumError is
> +        # raised even when the checksum value is bogus.
> +        bad =3D "0" * 64
> +        fetcher =3D bb.fetch.Fetch(['file://dir;sha256sum=3D' + bad], se=
lf.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +        self.assertFalse(ud.method.supports_checksum(ud))
> +        fetcher.download()

This tests that we suppress an error that we should actually be raising.
If the checksum is invalid, then we should raise an error.

Best regards,

--=20
Paul Barker


--=-D2Hx8J2P0wmlyNuI/UGR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaf3vhhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bmfzAP4p5wOMG6yd4vUfkHwVg/KQOuK9Mpqh9Ypv
QhCi36bwcgEAqVIsJra+qHd2M71FnL1KTMd9u+yJk00pTjlQh46dRQk=
=P/1X
-----END PGP SIGNATURE-----

--=-D2Hx8J2P0wmlyNuI/UGR--

