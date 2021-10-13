Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23648C433EF
	for <webhook@archiver.kernel.org>; Wed, 13 Oct 2021 21:08:15 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net
 [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web11.714.1634159293311755451
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Oct 2021 14:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: 0leil.net, ip: 217.70.178.230,
 mailfrom: foss@0leil.net)
Received: (Authenticated sender: foss@0leil.net)
	by relay10.mail.gandi.net (Postfix) with ESMTPSA id 153E0240004;
	Wed, 13 Oct 2021 21:08:09 +0000 (UTC)
Date: Wed, 13 Oct 2021 23:08:07 +0200
From: Quentin Schulz <foss@0leil.net>
To: bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: =?US-ASCII?Q?Re=3A_=5Bbitbake-devel=5D_=5BPATC?=
 =?US-ASCII?Q?H_2/2=5D_siggen=3A_Change_file?=
 =?US-ASCII?Q?_format_of_siginfo_files_to_use_zstd_compressed_json?=
In-Reply-To: <20211013153540.2873636-2-richard.purdie@linuxfoundation.org>
References: <20211013153540.2873636-1-richard.purdie@linuxfoundation.org>
 <20211013153540.2873636-2-richard.purdie@linuxfoundation.org>
Message-ID: <EFA30A03-8DEA-4751-A51B-851C9B9EE7BB@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Oct 2021 21:08:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12772

Hi Richard,

On October 13, 2021 5:35:40 PM GMT+02:00, Richard Purdie <richard=2Epurdie=
@linuxfoundation=2Eorg> wrote:
>Since OE is about to change to zstd compression of sstate, it would make =
it
>timely to convert the siginfo files from pickle which isn't reproducible
>to json which is both reproducible and also human readable=2E At the same=
 time

I'm not sure this is actually true for python 3=2E6 according to my readin=
g of the docs=2E

"""
Note

This module=E2=80=99s encoders and decoders preserve input and output orde=
r by default=2E Order is only lost if the underlying containers are unorder=
ed=2E

Prior to Python 3=2E7, dict was not guaranteed to be ordered, so inputs an=
d outputs were typically scrambled unless collections=2EOrderedDict was spe=
cifically requested=2E Starting with Python 3=2E7, the regular dict became =
order preserving, so it is no longer necessary to specify collections=2EOrd=
eredDict for JSON generation and parsing=2E

"""

C=2Ef=2E second note https://docs=2Epython=2Eorg/3=2E8/library/json=2Ehtml

C=2Ef=2E https://docs=2Epython=2Eorg/3/whatsnew/3=2E6=2Ehtml#whatsnew36-co=
mpactdict
Says it is behaving this way but shouldn't be relied upon=2E

It seems we need to make sure dict are ordered by using collections=2EOrde=
redDict instead?

In json=2Eload, object_hook_pairs=3Dcollections=2EOrderedDict should do th=
e trick afaiu?

Or I guess we could do the same thing as for sets but for dicts?

Note that OrderedDict is not alphabetically ordered but ordered by "time-o=
f-insertion"=2E I assume that with sort_keys=3DTrue passed to JSON=2Edump, =
if OrderedDict is used for JSON=2Eload, the function will return a fully re=
producible dictionary which will happen to be alphabetically sorted too=2E

I'm not entirely sure of my reading and understanding of the docs but want=
ed to bring this up=2E

Hope this isn't just noise :)

Cheers,
Quentin

>add zstd compression=2E This makes the siginfo files smaller, reprodubicl=
e
>and easier to debug=2E
>
>Backwards compatibility mixing the two formats hasn't been supported sinc=
e
>in reality if sstate changes at the same time, files will be in one forma=
t
>or the new one but comparing mixed formats won't make much sense=2E
>
>Since json doesn't support sets, we translate them into lists in the file=
s
>themselves=2E We only use sets in bitbake since it makes things easier in
>the internal code, sorted lists are fine for the file format=2E
>
>[YOCTO #13973]
>
>Signed-off-by: Richard Purdie <richard=2Epurdie@linuxfoundation=2Eorg>
>---
> lib/bb/siggen=2Epy | 29 +++++++++++++++++------------
> 1 file changed, 17 insertions(+), 12 deletions(-)
>
>diff --git a/lib/bb/siggen=2Epy b/lib/bb/siggen=2Epy
>index 625a9cf3bb=2E=2Ef526792efd 100644
>--- a/lib/bb/siggen=2Epy
>+++ b/lib/bb/siggen=2Epy
>@@ -11,6 +11,8 @@ import pickle
> import bb=2Edata
> import difflib
> import simplediff
>+import json
>+import bb=2Ecompress=2Ezstd
> from bb=2Echecksum import FileChecksumCache
> from bb import runqueue
> import hashserv
>@@ -19,6 +21,12 @@ import hashserv=2Eclient
> logger =3D logging=2EgetLogger('BitBake=2ESigGen')
> hashequiv_logger =3D logging=2EgetLogger('BitBake=2ESigGen=2EHashEquiv')
>=20
>+class SetEncoder(json=2EJSONEncoder):
>+    def default(self, obj):
>+        if isinstance(obj, set):
>+            return list(sorted(obj))
>+        return json=2EJSONEncoder=2Edefault(self, obj)
>+
> def init(d):
>     siggens =3D [obj for obj in globals()=2Evalues()
>                       if type(obj) is type and issubclass(obj, Signature=
Generator)]
>@@ -398,9 +406,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
>=20
>         fd, tmpfile =3D tempfile=2Emkstemp(dir=3Dos=2Epath=2Edirname(sig=
file), prefix=3D"sigtask=2E")
>         try:
>-            with os=2Efdopen(fd, "wb") as stream:
>-                p =3D pickle=2Edump(data, stream, -1)
>-                stream=2Eflush()
>+            with bb=2Ecompress=2Ezstd=2Eopen(fd, "wt", encoding=3D"utf-8=
", num_threads=3D1) as f:
>+                json=2Edump(data, f, sort_keys=3DTrue, separators=3D(","=
, ":"), cls=3DSetEncoder)
>+                f=2Eflush()
>             os=2Echmod(tmpfile, 0o664)
>             bb=2Eutils=2Erename(tmpfile, sigfile)
>         except (OSError, IOError) as err:
>@@ -794,12 +802,10 @@ def compare_sigfiles(a, b, recursecb=3DNone, color=
=3DFalse, collapsed=3DFalse):
>         formatparams=2Eupdate(values)
>         return formatstr=2Eformat(**formatparams)
>=20
>-    with open(a, 'rb') as f:
>-        p1 =3D pickle=2EUnpickler(f)
>-        a_data =3D p1=2Eload()
>-    with open(b, 'rb') as f:
>-        p2 =3D pickle=2EUnpickler(f)
>-        b_data =3D p2=2Eload()
>+    with bb=2Ecompress=2Ezstd=2Eopen(a, "rt", encoding=3D"utf-8", num_th=
reads=3D1) as f:
>+        a_data =3D json=2Eload(f)
>+    with bb=2Ecompress=2Ezstd=2Eopen(b, "rt", encoding=3D"utf-8", num_th=
reads=3D1) as f:
>+        b_data =3D json=2Eload(f)
>=20
>     def dict_diff(a, b, whitelist=3Dset()):
>         sa =3D set(a=2Ekeys())
>@@ -1031,9 +1037,8 @@ def calc_taskhash(sigdata):
> def dump_sigfile(a):
>     output =3D []
>=20
>-    with open(a, 'rb') as f:
>-        p1 =3D pickle=2EUnpickler(f)
>-        a_data =3D p1=2Eload()
>+    with bb=2Ecompress=2Ezstd=2Eopen(a, "rt", encoding=3D"utf-8", num_th=
reads=3D1) as f:
>+        a_data =3D json=2Eload(f)
>=20
>     output=2Eappend("basewhitelist: %s" % (a_data['basewhitelist']))
>=20

