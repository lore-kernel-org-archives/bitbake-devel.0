Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <peter.kjellerstedt@axis.com>) id 1U3oYK-0005bP-Iy
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Feb 2013 15:03:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 88FDF19E6E;
	Fri,  8 Feb 2013 14:47:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iu1Bu9+TQgtH; Fri,  8 Feb 2013 14:47:49 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id EB84E19DEF;
	Fri,  8 Feb 2013 14:47:48 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by thoth.se.axis.com (Postfix) with ESMTP id B35C234222;
	Fri,  8 Feb 2013 14:47:48 +0100 (CET)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
	([10.0.5.75]) with mapi; Fri, 8 Feb 2013 14:47:48 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Feb 2013 14:47:47 +0100
Thread-Topic: [bitbake-devel] [PATCH] utils: Use rm -rf in remove()
Thread-Index: Ac4FjpudX0vsiOWcQ76TJMqGSvUqkgAcSg4A
Message-ID: <A612847CFE53224C91B23E3A5B48BAC755FD6C1E82@xmail3.se.axis.com>
References: <1360281302.10722.68.camel@ted>
In-Reply-To: <1360281302.10722.68.camel@ted>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
Subject: Re: [PATCH] utils: Use rm -rf in remove()
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 08 Feb 2013 14:03:45 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Richard Purdie
> Sent: den 8 februari 2013 00:55
> To: bitbake-devel
> Subject: [bitbake-devel] [PATCH] utils: Use rm -rf in remove()
>=20
> Whilst shutils.rmtree() is pythonic, its also slow. Its faster to
> use rm -rf which makes optimal use of the right syscalls.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 484fb2d..94ef447 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -533,13 +533,15 @@ def remove(path, recurse=3DFalse):
>      """Equivalent to rm -f or rm -rf"""
>      if not path:
>          return
> -    import os, errno, shutil, glob
> +    import os, errno, glob, subprocess
>      for name in glob.glob(path):
>          try:
>              os.unlink(name)
>          except OSError as exc:
>              if recurse and exc.errno =3D=3D errno.EISDIR:
> -                shutil.rmtree(name)
> +                # shutil.rmtree(name) would be ideal but its too slow

its -> it is

> +                subprocess.call('rm -rf %s' % path, shell=3DTrue)
> +                return

Shouldn't the last two lines above be:

                   subprocess.call('rm -rf %s' % name, shell=3DTrue)

to maintain behavior.

>              elif exc.errno !=3D errno.ENOENT:
>                  raise

Alternatively, wouldn't it be better to check for recurse=20
first:

    if recurse:
        import subprocess
        subprocess.call('rm -rf %s' % path, shell=3DTrue)
    else:
        import os, errno, glob
        for name in glob.glob(path):
            try:
                os.unlink(name)
            except OSError as exc:
                if exc.errno !=3D errno.ENOENT:
                    raise

//Peter




