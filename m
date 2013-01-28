Received: from mail-we0-f182.google.com ([74.125.82.182])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1Tzr7Q-0006f9-2N
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 Jan 2013 16:59:37 +0100
Received: by mail-we0-f182.google.com with SMTP id t57so1620954wey.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Jan 2013 07:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=8ta/134Yy1nOHaHAAC1APtUTrQA95wsYM0u+gLTAAMU=;
	b=NPA6mcs14mS17jO/PcbawLu/EAggTUO7/ziCsMBGPR8dnhTcO6te12+hr53Z3w6aQF
	F+A4Kv9lNiATLiHNQjf8S/AEoSK3bvRWuLcK/iX6FifQ0i304RL5o3braKNTtQO0+H6A
	fd3HDV0SaiZBBrYlqSv4W49y5i/0VpIM5JidaQ+zm9dVjYdu/rjRfjQSiVMTR9kXM8Rk
	QwZ0Bx1yy5YDGoHZQ3WwtMF4oT5CDJZIUkZ97qQ6TjZBLwyuIYXmLYbyU824rzYCZXrl
	o7VWw8lxQq4VZqVhego9jXgpCfSURqKwUMnAdQNa/LiEZJzH8unHhwnPGn1uC4wfI3la
	XqoQ==
X-Received: by 10.194.20.231 with SMTP id q7mr22070427wje.44.1359387835418;
	Mon, 28 Jan 2013 07:43:55 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id g2sm14007964wiy.0.2013.01.28.07.43.54
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Mon, 28 Jan 2013 07:43:54 -0800 (PST)
Date: Mon, 28 Jan 2013 16:43:58 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Olof Johansson <olof.johansson@axis.com>
Message-ID: <20130128154358.GD16904@jama.palm1.palmone.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
	<1358759883-7566-7-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
In-Reply-To: <1358759883-7566-7-git-send-email-olof.johansson@axis.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 6/6] fetch2: Add SFTP fetcher
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
X-List-Received-Date: Mon, 28 Jan 2013 15:59:37 -0000
X-Groupsio-MsgNum: 3191
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FSGgxso9lj1d9SFz"
Content-Disposition: inline

--FSGgxso9lj1d9SFz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2013 at 10:18:03AM +0100, Olof Johansson wrote:
> This fetcher differs from the SSH fetcher in that it adheres more
> strictly to the SECSH URI internet draft --- it uses the sftp://
> instead of the ssh:// scheme, and it uses sftp instead of scp.
>=20
> Signed-off-by: Olof Johansson <olof.johansson@axis.com>
> ---
>  lib/bb/fetch2/__init__.py |    2 +
>  lib/bb/fetch2/sftp.py     |  104 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 lib/bb/fetch2/sftp.py
>=20
> diff --git lib/bb/fetch2/__init__.py lib/bb/fetch2/__init__.py
> index 549e261..86302f7 100644
> --- lib/bb/fetch2/__init__.py
> +++ lib/bb/fetch2/__init__.py
> @@ -1448,6 +1448,7 @@ from . import svn
>  from . import wget
>  from . import svk
>  from . import ssh
> +from . import sftp
>  from . import perforce
>  from . import bzr
>  from . import hg
> @@ -1461,6 +1462,7 @@ methods.append(git.Git())
>  methods.append(cvs.Cvs())
>  methods.append(svk.Svk())
>  methods.append(ssh.SSH())
> +methods.append(sftp.SFTP())
>  methods.append(perforce.Perforce())
>  methods.append(bzr.Bzr())
>  methods.append(hg.Hg())
> diff --git lib/bb/fetch2/sftp.py lib/bb/fetch2/sftp.py
> new file mode 100644
> index 0000000..0902ce7
> --- /dev/null
> +++ lib/bb/fetch2/sftp.py
> @@ -0,0 +1,104 @@
> +# ex:ts=3D4:sw=3D4:sts=3D4:et
> +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
> +"""
> +BitBake SFTP Fetch implementation
> +
> +Class for fetching files via SFTP. It tries to adhere to the (now
> +expired) IETF Internet Draft for "Uniform Resource Identifier (URI)
> +Scheme for Secure File Transfer Protocol (SFTP) and Secure Shell
> +(SSH)" (SECSH URI).
> +
> +It uses SFTP (as to adhere to the SECSH URI specification). It only
> +supports key based authentication, not password. This class, unlike
> +the SSH fetcher, does not support fetching a directory tree from the
> +remote.
> +
> +  http://tools.ietf.org/html/draft-ietf-secsh-scp-sftp-ssh-uri-04
> +  https://www.iana.org/assignments/uri-schemes/prov/sftp
> +  https://tools.ietf.org/html/draft-ietf-secsh-filexfer-13
> +
> +"""
> +
> +# Copyright (C) 2013, Olof Johansson <olof.johansson@axis.com>
> +#
> +# Based in part on bb.fetch2.wget:
> +#    Copyright (C) 2003, 2004  Chris Larson
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Based on functions from the base bb module, Copyright 2003 Holger Schu=
rig
> +
> +import os
> +import bb
> +import urllib
> +import commands
> +from bb import data
> +from bb.fetch2 import URI
> +from bb.fetch2 import FetchMethod
> +from bb.fetch2 import runfetchcmd
> +
> +
> +class SFTP(FetchMethod):
> +    """Class to fetch urls via 'sftp'"""
> +    def supports(self, url, ud, d):
> +        """
> +        Check to see if a given url can be fetched with sftp.
> +        """
> +        return ud.type in ['sftp']
> +
> +    def recommends_checksum(self, urldata):
> +        return True
> +
> +    def urldata_init(self, ud, d):
> +        if 'protocol' in ud.parm and ud.parm['protocol'] =3D=3D 'git':
> +            raise bb.fetch2.ParameterError(
> +                "Invalid protocol - if you wish to fetch from a git " +
> +                "repository using ssh, you need to instead use the " +
> +                "git:// prefix with protocol=3Dssh", ud.url)
> +
> +        if 'downloadfilename' in ud.parm:
> +            ud.basename =3D ud.parm['downloadfilename']
> +        else:
> +            ud.basename =3D os.path.basename(ud.path)
> +
> +        ud.localfile =3D data.expand(urllib.unquote(ud.basename), d)
> +
> +    def download(self, uri, ud, d):
> +        """Fetch urls"""
> +
> +        urlo =3D URI(uri)
> +        basecmd =3D 'sftp -oPasswordAuthentication=3Dno'
> +        port =3D ''
> +        if urlo.port:
> +            port =3D '-P %d' % urlo.port
> +            urlo.port =3D None
> +
> +        dldir =3D data.getVar('DL_DIR', d, True)
> +        lpath =3D os.path.join(dldir, ud.localfile)
> +
> +        user =3D ''
> +        if urlo.userinfo:
> +            user =3D urlo.userinfo + '@'
> +
> +        remote =3D '%s%s:%s' % (user, urlo.hostname, urlo.path)

Please add some SRC_URI examples, it always surprise me that there isn't
':' as host-path separator, but '/' and error as returned from bitbake
ia not so easy to read.

Also it looks like optional ~ syntax is not supported
sftp://user@host.example.com/~/file.txt

But it should be easy to implement if you remove '^/~/' from urlo.path.

Cheers,
> +
> +        cmd =3D '%s %s %s %s' % (basecmd, port, commands.mkarg(remote),
> +                               commands.mkarg(lpath))
> +
> +        bb.fetch2.check_network_access(d, cmd, uri)
> +        runfetchcmd(cmd, d)
> +        return True
> +
> +    def checkstatus(self, uri, ud, d):
> +        return self.download(uri, ud, d, True)
> --=20
> 1.7.10.4
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--FSGgxso9lj1d9SFz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlEGnL4ACgkQN1Ujt2V2gBzORgCfdnzNy0EANadRUJzW+wHgoRlV
Rx0AnidCwZQEDHJk0nSA4mdeD5TVkkWZ
=i+N6
-----END PGP SIGNATURE-----

--FSGgxso9lj1d9SFz--
