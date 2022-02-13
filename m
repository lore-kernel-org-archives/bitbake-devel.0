Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8CAC433EF
	for <webhook@archiver.kernel.org>; Sun, 13 Feb 2022 22:13:21 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web08.27103.1644790400072794852
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Feb 2022 14:13:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=NYZzLcNS;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1644790402;
  x=1676326402;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Fd1odH0NRFxN433xx0F8pZ59mp6xWhVpH/ZYnTs2Lwc=;
  b=NYZzLcNSz1JDORRmATLSYlhBh2hJ+tvjLTtGn4MG5iwEI9yQH0os5HY+
   zkU3Z69xB4EQgt7ws9USosfjUWUCwQ4CB8ufpvsnneiAbVhNtIUPaqOeQ
   tfNteDdhUdjCGnWwFFz3EJHx+gtvAfv0z3drRcHgS6Tz0DtifPF4fDZIp
   Wtg2ahybhPNvx0vZ7URbGSelvPaMYDtuMUx49n94i3OYp/e59P16QYaIj
   ghqX3g1QY4yRe6b/J0VuquJb6vj6pT1DratsVyhSyFJAgsAv8bCoevXb3
   YSlFiKw0aVlc+apasNANQtZ13o4IJKbqdLrLzd/g11esMgqykgCWSC9Nt
   Q==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] fetch2/cooker: Fix source revision
 handling with floating upstreams
Thread-Topic: [bitbake-devel] [PATCH] fetch2/cooker: Fix source revision
 handling with floating upstreams
Thread-Index: AQHYHqdMQP8fGlOvZk+vm476bsVWD6ySA7FA
Date: Sun, 13 Feb 2022 22:13:17 +0000
Message-ID: <bbab3b39fefc448199235b2c458ba378@axis.com>
References: <20220210175426.2695614-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20220210175426.2695614-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 13 Feb 2022 22:13:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13343

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 10 februari 2022 18:54
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] fetch2/cooker: Fix source revision handl=
ing with floating upstreams
>=20
> Where a git url uses a tag instead of a full source revision, breakage
> can currently occur in builds. Issues include:
>=20
> * the revision being looked up in multiple tasks (fetch and unpack)
> * the risk a different revision may be obtained in those tasks
> * that some tasks may not be allowed to access the network
> * that a revision may not be consistent throughout a given build
> * rerunning a specific task may given inconsistent results
>=20
> To fix this, stop the workers from cleaning out the source revision store=
. This
> should only be done in the cooker itself (based on current policy).
>=20
> Also, where the code "sees" an upstream access, mark the recipe as not to=
 be
> cached. The reparse re-triggers the upstream lookup by the server.
>=20
> Add a test to ensure that if get_srcrev isn't called, the user is told th=
ey're
> using a configuration that is known to break.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bin/bitbake-worker        | 2 +-
>  lib/bb/cookerdata.py      | 4 ++--
>  lib/bb/fetch2/__init__.py | 1 +
>  lib/bb/fetch2/git.py      | 6 ++++++
>  4 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 063cf37926..9d850ec77c 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -440,7 +440,7 @@ class BitbakeWorker(object):
>      def handle_cookercfg(self, data):
>          self.cookercfg =3D pickle.loads(data)
>          self.databuilder =3D bb.cookerdata.CookerDataBuilder(self.cooker=
cfg, worker=3DTrue)
> -        self.databuilder.parseBaseConfiguration()
> +        self.databuilder.parseBaseConfiguration(worker=3DTrue)
>          self.data =3D self.databuilder.data
>=20
>      def handle_extraconfigdata(self, data):
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 397b43dfa7..a961f36574 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -258,12 +258,12 @@ class CookerDataBuilder(object):
>          self.data =3D self.basedata
>          self.mcdata =3D {}
>=20
> -    def parseBaseConfiguration(self):
> +    def parseBaseConfiguration(self, worker=3DFalse):
>          data_hash =3D hashlib.sha256()
>          try:
>              self.data =3D self.parseConfigurationFiles(self.prefiles, se=
lf.postfiles)
>=20
> -            if self.data.getVar("BB_WORKERCONTEXT", False) is None:
> +            if self.data.getVar("BB_WORKERCONTEXT", False) is None and n=
ot worker:
>                  bb.fetch.fetcher_init(self.data)
>              bb.parse.init_parser(self.data)
>              bb.codeparser.parser_cache_init(self.data)
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 28a3e54c7f..d099cd1092 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -765,6 +765,7 @@ def get_srcrev(d, method_name=3D'sortable_revision'):
>      that fetcher provides a method with the given name and the same sign=
ature as sortable_revision.
>      """
>=20
> +    d.setVar("__BBSEENSRCREV", "1")
>      recursion =3D d.getVar("__BBINSRCREV")
>      if recursion:
>          raise FetchError("There are recursive references in fetcher vari=
ables, likely through SRC_URI")
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 30da8e95b7..836ef1c49a 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -727,6 +727,12 @@ class Git(FetchMethod):
>          """
>          Compute the HEAD revision for the url
>          """
> +        if not d.getVar("__BBSEENSRCREV"):
> +            raise bb.fetch2.FetchError("Recipe uses a floating tag/branc=
h without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV=
 in PV for OE).")

This does not seem correct. We use SRCREV =3D "<tag>" for all our own recip=
es.=20
However, we never use ${SRCPV} if SRCREV is set to a tag that matches PV.=20
Why should we? We only use it if the SRCREV _does not_ match PV.

> +
> +        # Ensure we mark as not cached
> +        bb.fetch2.get_autorev(d)
> +

How will this affect us that use BB_SRCREV_POLICY =3D "cache", which we do =
to=20
avoid unnecessary `git ls-remote` since we know our own tags do not move?

>          output =3D self._lsremote(ud, d, "")
>          # Tags of the form ^{} may not work, need to fallback to other f=
orm
>          if ud.unresolvedrev[name][:5] =3D=3D "refs/" or ud.usehead:
> --
> 2.32.0

//Peter


