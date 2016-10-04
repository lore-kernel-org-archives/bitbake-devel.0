Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id B1E667199D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Oct 2016 21:15:42 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga103.fm.intel.com with ESMTP; 04 Oct 2016 14:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,445,1473145200"; 
	d="asc'?scan'208";a="16193140"
Received: from alimonb-mobl1.zpn.intel.com (HELO [10.219.5.33]) ([10.219.5.33])
	by fmsmga006.fm.intel.com with ESMTP; 04 Oct 2016 14:15:43 -0700
To: bitbake-devel@lists.openembedded.org
References: <1475615756-3556-1-git-send-email-anibal.limon@linux.intel.com>
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Message-ID: <57F41C39.2070406@linux.intel.com>
Date: Tue, 4 Oct 2016 16:16:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1475615756-3556-1-git-send-email-anibal.limon@linux.intel.com>
Cc: joshua.g.lock@intel.com, clarson@kergoth.com
Subject: Re: [PATCHv2] bb/event.py: fire_ui_handlers enable threading lock support
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
X-List-Received-Date: Tue, 04 Oct 2016 21:15:43 -0000
X-Groupsio-MsgNum: 8105
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="fXUEu5St3klKb0tCQCJ17vl0DQaIoEATk"

--fXUEu5St3klKb0tCQCJ17vl0DQaIoEATk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sorry it was a typo on acquire/release.

	alimon

On 10/04/2016 04:15 PM, An=C3=ADbal Lim=C3=B3n wrote:
> In some cases there is a need to fire bb events into multiple
> python threads so locking is needed (writing to a fd/socket).
>=20
> Adding a helper functions for disable/enable by request to avoid
> overhead.
>=20
> [YOCTO #10330]
>=20
> Signed-off-by: An=C3=ADbal Lim=C3=B3n <anibal.limon@linux.intel.com>
> ---
>  lib/bb/event.py                     | 21 +++++++++++++++++++++
>  lib/toaster/tests/functional/README |  0
>  2 files changed, 21 insertions(+)
>  create mode 100644 lib/toaster/tests/functional/README
>=20
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index 42745e2..65b7ebb 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -29,6 +29,8 @@ import logging
>  import atexit
>  import traceback
>  import ast
> +import threading
> +
>  import bb.utils
>  import bb.compat
>  import bb.exceptions
> @@ -68,12 +70,22 @@ _event_handler_map =3D {}
>  _catchall_handlers =3D {}
>  _eventfilter =3D None
>  _uiready =3D False
> +_thread_lock =3D threading.Lock()
> +_thread_lock_enabled =3D False
> =20
>  if hasattr(__builtins__, '__setitem__'):
>      builtins =3D __builtins__
>  else:
>      builtins =3D __builtins__.__dict__
> =20
> +def enable_threadlock():
> +    global _thread_lock_enabled
> +    _thread_lock_enabled =3D True
> +
> +def disable_threadlock():
> +    global _thread_lock_enabled
> +    _thread_lock_enabled =3D False
> +
>  def execute_handler(name, handler, event, d):
>      event.data =3D d
>      addedd =3D False
> @@ -146,11 +158,17 @@ def print_ui_queue():
>                  logger.handle(event)
> =20
>  def fire_ui_handlers(event, d):
> +    global _thread_lock
> +    global _thread_lock_enabled
> +
>      if not _uiready:
>          # No UI handlers registered yet, queue up the messages
>          ui_queue.append(event)
>          return
> =20
> +    if _thread_lock_enabled:
> +        _thread_lock.acquire()
> +
>      errors =3D []
>      for h in _ui_handlers:
>          #print "Sending event %s" % event
> @@ -169,6 +187,9 @@ def fire_ui_handlers(event, d):
>      for h in errors:
>          del _ui_handlers[h]
> =20
> +    if _thread_lock_enabled:
> +        _thread_lock.release()
> +
>  def fire(event, d):
>      """Fire off an Event"""
> =20
> diff --git a/lib/toaster/tests/functional/README b/lib/toaster/tests/fu=
nctional/README
> new file mode 100644
> index 0000000..e69de29
>=20


--fXUEu5St3klKb0tCQCJ17vl0DQaIoEATk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJX9Bw7AAoJEGJqcE9h3glggb8P/A59wQqGmaI1DYkJP7AdXpZ0
kUoQlLD1Uq3mHb8uSHi77yFIfrZKc/nG+8rM8GXx1942PabJwpksvkEDWOylT0oc
/VFUZ5KPCamJe0yQwSiFTvwqizrs47PKKQo7xxfBZpr1R0YODQZObqJF1qD7ohU7
pRTb4lMSrClX1ybIbO+cuUNtT3ntX17x1R7mWFMNeiwKQ2+Uyk3atlzVbx7fMyqM
h316Q/ZbG56OUg5n9ANmuUN3JR4tiEWYBO4ddF1yBwOU4pbftJ6IJjRyfVlx92jO
41e3CATtjf8XipjRXA3PHJ0mB9yrbBRdsdbOZuuWEEBFPQIXQ94c+zYdMVkiYOa+
2lM6V6nSev7hzlu0mzoLzInkJ600V3GNGa+LAuC69CfXFI2+ChxjQ7GG6Tja/mdt
sTnMm1MLMYIwkdq+xCiaHNeOVmWksH9gRjYbMGUi/lrH3a1xo4UDZje2qu3iDSJn
U65R/eFiUfAJ37x7Imxni3+nZ2OdzTOVx+13wjAvU4CxD1CyGJv0dSYLZ5QhfBtH
oJ2VF7u45gQTV3FlCCsA0kpJOD1MUUSSbx2OE//2FRuSro5yQMzcvyLaAkjeQh9P
dhcsDR1UpLh/+fhGsQSPUtRVFzFQUfXy4FmK1XicCgK7uW/WRpOo3Zc/2Pb8YeBq
SSJX1PKIvdz5FdIAU6XN
=3JjI
-----END PGP SIGNATURE-----

--fXUEu5St3klKb0tCQCJ17vl0DQaIoEATk--
