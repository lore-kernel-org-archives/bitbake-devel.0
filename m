Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5B4D560D04
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 11:44:19 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBIBhlNW032186; Wed, 18 Dec 2013 11:44:08 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PDNHMgAObqB0; Wed, 18 Dec 2013 11:44:08 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBIBi119032196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 18 Dec 2013 11:44:03 GMT
Message-ID: <1387367036.6402.37.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Wed, 18 Dec 2013 11:43:56 +0000
In-Reply-To: <1386866938-5932-4-git-send-email-olof.johansson@axis.com>
References: <1386866938-5932-1-git-send-email-olof.johansson@axis.com>
	<1386866938-5932-4-git-send-email-olof.johansson@axis.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC 3/5] bb.tests.fetch_git: initial set of tests for git fetcher
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
X-List-Received-Date: Wed, 18 Dec 2013 11:44:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2013-12-12 at 17:48 +0100, Olof Johansson wrote:
> This commit introduces a set of whitebox unit tests for the git
> fetcher, including some minor refactoring of the fetcher itself
> to increase testability.
> 
> Signed-off-by: Olof Johansson <olof.johansson@axis.com>
> ---
>  bin/bitbake-selftest      |   3 +-
>  lib/bb/fetch2/git.py      |  31 +++++++--
>  lib/bb/tests/fetch_git.py | 164 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 190 insertions(+), 8 deletions(-)
>  create mode 100644 lib/bb/tests/fetch_git.py
> 
> diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
> index 48a58fe..7f02fbf 100755
> --- a/bin/bitbake-selftest
> +++ b/bin/bitbake-selftest
> @@ -25,10 +25,11 @@ try:
>  except RuntimeError as exc:
>      sys.exit(str(exc))
>  
> -tests = ["bb.tests.codeparser", 
> +tests = ["bb.tests.codeparser",
>           "bb.tests.cow",
>           "bb.tests.data",
>           "bb.tests.fetch",
> +         "bb.tests.fetch_git",
>           "bb.tests.utils"]
>  
>  for t in tests:
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index bd107db..81bf282 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -87,14 +87,10 @@ class Git(FetchMethod):
>          init git specific variable within url data
>          so that the git method like latest_revision() can work
>          """
> -        if 'protocol' in ud.parm:
> -            ud.proto = ud.parm['protocol']
> -        elif not ud.host:
> -            ud.proto = 'file'
> -        else:
> -            ud.proto = "git"
>  
> -        if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
> +        ud.proto = self._fetch_url_proto(ud)
> +
> +        if not self._valid_protocol(ud.proto):
>              raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
>  
>          ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
> @@ -287,6 +283,27 @@ class Git(FetchMethod):
>      def supports_srcrev(self):
>          return True
>  
> +    def _fetch_url_proto(self, ud):
> +        """
> +        Identify protocol for Git URL.
> +
> +        The scheme prefix is used to couple the URL to this particular fetcher,
> +        but it's not necessarily the git protocol we will use. If a protocol
> +        URL parameter is supplied we will use that, otherwise we will use
> +        git:// if the URL contains a hostname or file:// if it does not.
> +
> +        """
> +        if 'protocol' in ud.parm:
> +            return ud.parm['protocol']
> +
> +        if not ud.host:
> +            return 'file'
> +
> +        return "git"
> +
> +    def _valid_protocol(self, proto):
> +        return proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync')
> +
>      def _contains_ref(self, ud, d, name):
>          cmd =  "%s branch --contains %s --list %s 2> /dev/null | wc -l" % (
>              ud.basecmd, ud.revisions[name], ud.branches[name])
> diff --git a/lib/bb/tests/fetch_git.py b/lib/bb/tests/fetch_git.py
> new file mode 100644
> index 0000000..89af515
> --- /dev/null
> +++ b/lib/bb/tests/fetch_git.py
> @@ -0,0 +1,164 @@
> +# ex:ts=4:sw=4:sts=4:et
> +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
> +#
> +# BitBake Tests for the git fetcher (fetch2/git.py)
> +#
> +# Copyright (C) 2013 Olof Johansson
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
> +
> +import unittest
> +from mock import Mock, patch

This is going to cause some headaches since we don't have Mock listed in
and of the prerequisite documentation, nor is it present in our prebuilt
tools tarball or do we have a recipe for it.

This is probably enough to block the patch until we can find someone to
look at fixing that :(

Would it be possible to separate out the tests from the other changes?

Cheers,

Richard


