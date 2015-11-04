Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 52D0476FC4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Nov 2015 00:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id C9E4A2E1DD;
	Wed,  4 Nov 2015 01:36:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id drYeyO4e1j1f; Wed,  4 Nov 2015 01:36:12 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 69EDF2E1D7;
	Wed,  4 Nov 2015 01:36:12 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 572E2150;
	Wed,  4 Nov 2015 01:36:12 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 4A52FA9;
	Wed,  4 Nov 2015 01:36:12 +0100 (CET)
Received: from xmail4.se.axis.com (xmail4.se.axis.com [10.0.5.46])
	by thoth.se.axis.com (Postfix) with ESMTP id 4804F341F9;
	Wed,  4 Nov 2015 01:36:12 +0100 (CET)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail4.se.axis.com
	([fe80::2dfa:6a3a:302a:d4e8%14]) with mapi;
	Wed, 4 Nov 2015 01:36:12 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
Date: Wed, 4 Nov 2015 01:36:11 +0100
Thread-Topic: [bitbake-devel] [PATCH] bb.fetch2: added support for gclient
Thread-Index: AdEWUzDuQSeReRN3QkSntB/pdvq1vQAQvGAA
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7C6F013E5B9@xmail3.se.axis.com>
References: <1446567045-31179-1-git-send-email-zoltan.kuscsik@linaro.org>
In-Reply-To: <1446567045-31179-1-git-send-email-zoltan.kuscsik@linaro.org>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bb.fetch2: added support for gclient
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
X-List-Received-Date: Wed, 04 Nov 2015 00:36:14 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> devel-bounces@lists.openembedded.org] On Behalf Of Zoltan Kuscsik
> Sent: den 3 november 2015 17:11
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] bb.fetch2: added support for gclient
>=20
> Gclient is tool for updating source code from
> multiple SCM repository locations.
>=20
> Signed-off-by: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
> ---
>  lib/bb/fetch2/__init__.py |   3 +-
>  lib/bb/fetch2/gclient.py  | 151
> ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 153 insertions(+), 1 deletion(-)
>  create mode 100644 lib/bb/fetch2/gclient.py
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 288a1c8..5ca3bc7 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1529,7 +1529,6 @@ class Fetch(object):
>          fn =3D d.getVar('FILE', True)
>          if cache and fn and fn in urldata_cache:
>              self.ud =3D urldata_cache[fn]
> -

Restore the empty line.

>          for url in urls:
>              if url not in self.ud:
>                  try:
> @@ -1775,6 +1774,7 @@ from . import hg
>  from . import osc
>  from . import repo
>  from . import clearcase
> +from . import gclient
>=20
>  methods.append(local.Local())
>  methods.append(wget.Wget())
> @@ -1791,3 +1791,4 @@ methods.append(hg.Hg())
>  methods.append(osc.Osc())
>  methods.append(repo.Repo())
>  methods.append(clearcase.ClearCase())
> +methods.append(gclient.Gclient())
> diff --git a/lib/bb/fetch2/gclient.py b/lib/bb/fetch2/gclient.py
> new file mode 100644
> index 0000000..de06eb5
> --- /dev/null
> +++ b/lib/bb/fetch2/gclient.py
> @@ -0,0 +1,151 @@
> +# ex:ts=3D4:sw=3D4:sts=3D4:et
> +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
> +"""
> +BitBake "Fetch" gclient implementation
> +
> +gclient fetcher support the SRCU_URI in the following format:
                               ^^^^^^^^
Correct the spelling of SRC_URI.

> +
> +    SRC_URI =3D "gclient://some.host/path/;optionA=3Dxxx,optionB=3Dxy"
> +
> +Supported SRC_UIR options are:
             ^^^^^^^
Correct the spelling of SRC_URI.

> +
> +- branch
> +  The git branch of the root gclient project. The default is
> +  "master".
> +
> +- tag
> +  Git tag for gclient to retrieve.
> +
> +- protocol
> +  The method to use for accessing the gclient core project. The default
> +   is https.
> +
> +- project-name
> +  Passing the --name command line argument to gclient. Not default is em=
pty.

Change "Passing" to "Pass" and "Not" to "The".

> +
> +- rev
> +  Specify git commit id for gclient. Default is empty.
> +
> +- deps-file
> +  Set the --deps-file command line argument for gclient.
> +
> +"""
> +
> +# Copyright (C) 2015 Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
> +#
> +# Based on git.py which is:
> +# Copyright (C) 2005 Richard Purdie
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
> +# You should have received a copy of the GNU General Public License alon=
g
> +# with this program; if not, write to the Free Software Foundation, Inc.=
,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +import os
> +import bb
> +from   bb    import data
> +from   bb.fetch2 import FetchMethod
> +from   bb.fetch2 import runfetchcmd
> +import string
> +
> +class Gclient(FetchMethod):
> +    """Class to fetch a module or modules using gclient"""
> +
> +    def __fetch_url(self, ud):
> +        return "%s://%s%s" % (ud.proto, ud.host, ud.path)
> +
> +    def supports(self, ud, d):
> +        """
> +        Check to see if a given url can be fetched with repo.
                                                           ^^^^
Repo? I thought this was for gclient...

> +        """
> +        return ud.type in ["gclient"]
> +
> +    def urldata_init(self, ud, d):
> +        """
> +        Init gclient
> +        """
> +        ud.proto =3D ud.parm.get('protocol', 'https')
> +
> +        ud.branch =3D ud.parm.get('branch', 'master')
> +        ud.tag =3D ud.parm.get('tag','')
> +        ud.rev =3D ud.parm.get('rev','')
> +
> +        ud.deps_file =3D ud.parm.get('deps-file', '')
> +        ud.project_name =3D ud.parm.get('project-name', '')
> +
> +        if( ( ('tag' in ud.parm) + ('branch' in ud.parm) + ('res' in ud.=
parm)) > 1):

Rewrite as:

        if ('tag' in ud.parm) + ('branch' in ud.parm) + ('res' in ud.parm) =
> 1:

> +            raise bb.fetch2.ParameterError("Confliting revision setting =
SRC_URI. Setting only one of the options: 'branch', 'tag', 'res'.", ud.url)
                                               ^^^^^^^^^^
Correct the spelling of "Conflicting". Change "revision setting SRC_URI"=20
to "revisions specified in SRC_URI" and "Setting only" to "Specify only".

> +
> +        dldir =3D d.getVar("DL_DIR", True)
> +
> +        gclient_src_name =3D 'gclient_%s%s' % (ud.host.replace(':', '.')=
, ud.path.replace('/', '.').replace('*', '.'))
> +
> +        ud.syncdir =3D os.path.join(dldir, gclient_src_name)
> +        ud.localfile =3D ud.syncdir
> +
> +        if ud.tag:
> +            ud.revision =3D  "refs/tags/%s" % ud.tag
                             ^
Remove unnecessary space.

> +        elif ud.rev:
> +            ud.revision =3D ud.rev
> +        else:
> +            ud.revision =3D "refs/heads/%s" % ud.branch
> +
> +    def download(self, ud, d):
> +        """Fetch url"""
> +
> +        if not os.path.exists(ud.localpath):
> +            bb.utils.mkdirhier(ud.localpath)
> +        os.chdir(ud.localpath)
> +        gclient_url =3D self.__fetch_url(ud)
> +
> +
> +        # Add optional parameters
> +        extra_params=3D[]
> +        if(ud.deps_file):

Rewrite as:

        if ud.deps_file:

> +            extra_params.append("--deps-file=3D%s" % ud.deps_file)
> +
> +        if(ud.project_name):

Rewrite as:

        if ud.project_name:

> +            extra_params.append("--name=3D%s" % ud.project_name)
> +
> +        extra_args =3D string.join(extra_params, sep =3D " ")
> +
> +        runfetchcmd("gclient config %s %s " % (gclient_url, extra_args),=
 d)
> +
> +        # Gclient parameters used
> +        # -f                    - force sync
> +        # -nohooks              - skip hooks execution at this time
> +        # --with_branch_heads   - gclient can't find a commit ID if it i=
s not in a branch
> +        #
> +        # Note: We should enable --no-history after some more testing
> +
> +        runfetchcmd("gclient sync --with_branch_heads -f  --nohooks --re=
vision %s" % ud.revision, d)
> +
> +    def unpack(self, ud, destdir, d):
> +        """ Unpack the src to destdir """
> +        destsuffix =3D "gclient/"
> +        destdir =3D ud.destdir =3D os.path.join(destdir, destsuffix)
> +        # Use rsync for copying. Creating a tar package here would be ve=
ry
> +        # time consuming.
> +        runfetchcmd("rsync -av %s/ %s/" %(ud.syncdir, destdir), d)
> +        return True
> +
> +    def need_update(self, ud, d):
> +        return True
> +
> +    def clean(self, ud, d):
> +        """ Clean the gclient directory """
> +        bb.utils.remove(ud.localpath, True)
> +
> +    def localpath(self, ud, dr):
> +        return ud.syncdir
> +
> +    def supports_srcrev(self):
> +        return False
> --
> 1.9.1

//Peter


