Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CAAC982FA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 12:52:29 +0000 (UTC)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6205.1790167945038483073
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 05:52:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qScLiHit;
 spf=pass (domain: gmail.com, ip: 74.125.229.204, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so780206e87.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 05:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790167943; cv=none;
        d=google.com; s=arc-20260327;
        b=tDIS353SG5gDiN3RY8SSjLNTqYjVJbnXszKpmnBjAQfFX0DmJZyx5uAaZNoO+VaOnA
         vBC7a9t9pA+spYpLPJY+xrSfDFEBHiYaLLJVb9gD1nxOK1tf9g9se2jKYCkpG1nAYQ7V
         JBlrd4Elke+hocx9jK1P1yqIYZl8tQiU9CoU8rvFdvTR7uA7v/Q2fNwra3G0ZDUQ471j
         8UY06Sbd24+2dFTISiX9ZXO3onOo8dZbimP8CxS+LDqacVN4YJXBWC++P9yZkIWDrYqj
         O6TfN/EVB+te0yWyZ37TodnmnFKask3EsHpB/v5bweI16RUgImMImjDbMArxD4O0huA/
         4APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lC0ZZRa4tLNXLJ/nQCz34dcLJU5jifmwBvGtybPggRo=;
        fh=QMXCXb6zIPzTXvb9eU0X+ocFzAdAeMYHJ/Q4bYD1uHg=;
        b=V+I03YZivvoXue7zkuCbMJ/IWFSZYR2YawTTmxHOUn+jkcrksjfn52YediQRj0lzv1
         A84icYW36lffp69c4sIhYwHL/vP5m3aiTKiIsap42oFhw7w7Wqm+Nr9bXc35zJhZUqLy
         JtlXS7aevoNBOB2Kqks5QtixI38O3vtzqkEBUYE0wyewJyaLgTTY3DddD64UsnrikQ/6
         yqSWxPPDNJwCe3kgUqG1xlVEhSo/ciwCpu3EX9A+nRiccAxCNiIcCHizSz4yFjv6/qcw
         y7i/GDFd/haoCBrpUIEubnvkDOEgYOHSUuEJ1md5ZxhrYgO8ws6qG1mqHeepQaXMwHZr
         BvGg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790167943; x=1790772743; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lC0ZZRa4tLNXLJ/nQCz34dcLJU5jifmwBvGtybPggRo=;
        b=qScLiHitOBlRIfgDZdNgXhOOpBue9w/oEND04rx5dp0AtKT8qBa/QQr9DSfZSVsMK6
         yv4jxiHTHxqukFETqUrhWudM5evD6pvQnHLUFjCSrmV6Tbf5TCLPUHNC+PPb/qPmq7iQ
         XG1tpOvtssA0L4HUM32HvJ9rxa4Qm9lIa9UfuNv7zCF34qYjEzQiITLWLoLO1zjdJdwF
         bNDuGrndpUuVvKTqFQs/h7XF2J91v2zGHJCIONfzV75eQEWPzEbQ7k8iWdDkPr66b9xv
         gsBo90GW0Pdl7ckw7z5+FPZwLT8vImLR6xkWgPcJEgaAbWmCSTGrRTGJawk3OjStg5Vy
         EvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167943; x=1790772743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lC0ZZRa4tLNXLJ/nQCz34dcLJU5jifmwBvGtybPggRo=;
        b=ZM//TCwFtqhAQ8F0VndF4Kux76BVl4kte4bFvyyOBW3T6lt5rYa7Ff+vj0D9tBG8B3
         CgPtyks22WSjp8xFNSx2QHJCFRBgOerr6U/jWDiYk9vtctRzcSintGB6ZIqNwozLsXb+
         UgyDGz71P3U3eolPNkpBoYJkqNZbvcqWpchWSXFw4KHOZUSfDAOTBT/KxHqYZpodtuR3
         csQ1HsBjn2ey/dTwN/T6Lo2VRPPEGn2aUIhbdwLtkMRGhG9qybMxhPWXBcCuBctRcbHl
         n+DqHFA/25sCykW1hLT3P5P2QoGsjobE89Lf62ItUnNNSXGtRlDQxgqFmfXmV2fY+Xf7
         WW+A==
X-Forwarded-Encrypted: i=1; AKwUvBymM9KFIFdSvYJcPe9FaQ7cXWHMKj5K2qqiF0tiYYqWBQ9h+oZbE+t6QeG/abBHYSAej5r6cFBJ/a3+mDyG@lists.openembedded.org
X-Gm-Message-State: AFuF++kBG/0ta/bOMHcqkaujVFMHtAhe14PECcXWcxs2SF+QEWXzjuCc
	O/D6SK4lJDIEqZpl8l4XJqHzEcYn3rxs0DCvk+76AHJgeYrFuPLG0JANJ5h8rwi41XLtrhFew/U
	040zdwCKPcK59xWa5rnWIDHmWO45wfeo=
X-Gm-Gg: AYBFou2ezWJVLITeY3FD9c73BMaeK/TQJCsTUk1w4O1IGdMkZ1tRE0hSxE2sh+fheC5
	JG68FoIavtdc3FPrVfqbSrpaKcVioTpUmOUYTss5+wroH8eLwdLazIEO/N2yWIHfIqqUuqh4icC
	YGHrNJTRPHhQ89YoSxuiViQ8hawrCXr3YkynWneNmje6oJf9bhV/LWAl0VxlJxPX8/Q42yPgtJi
	kHOtkssL1iASUAKpCcRWQlanISkcU3cyppsL7NzJMX3aryd83OK5UPcKexKgM1ez3dp95nxhYxF
	fNVDz9xAsBo+TW63biQJNqwCzJhFqbNwL74hFit0tneAtj8+iv8kvU3g5NNHBjW+NWVqidY0mAg
	VgRyl2LwLhoMfNVYWnKHqLWf6PV/DvzpR+3yNg2Z4KOefSnU=
X-Received: by 2002:a05:6512:3046:b0:5b6:6af:4e0e with SMTP id
 2adb3069b0e04-5b8d8960644mr905917e87.3.1790167942482; Wed, 23 Sep 2026
 05:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-dev-tprrt-fix-npm-v2-0-67b65c67de4e@bootlin.com>
 <20260731-dev-tprrt-fix-npm-v2-1-67b65c67de4e@bootlin.com> <18D7E2638B607DE0.2356414@lists.openembedded.org>
In-Reply-To: <18D7E2638B607DE0.2356414@lists.openembedded.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 23 Sep 2026 14:52:10 +0200
X-Gm-Features: AclHuK-v-KA5gCXE7sHaM6M9OwceEf_n0h4m16AHeJ5uoXLhGIHcR1AAXAcRUag
Message-ID: <CA+chaQcJfRs2HL5xwJOUR_yCqJb-WNiLXaeGHoEDoz2581VnoA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] fetch/{npm,npmsw}: re-enable
 fetchers now that checksums come from SRC_URI
To: martin.jansa@gmail.com
Cc: thomas.perrot@bootlin.com, bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 12:52:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20241

Hi,

my bad, I didn't realize that you can and should use the checksum in
the devtool/recipetool call as well. Now it works better, there might
be some issues with parsing detected LICENSE values, but that's a
separate issue. Sorry for noise.

Regards,

On Wed, Sep 23, 2026 at 9:24=E2=80=AFAM Martin Jansa via
lists.openembedded.org <martin.jansa=3Dgmail.com@lists.openembedded.org>
wrote:
>
> Hello,
>
> after long time I came across a recipe using npm:// in blacksail build
> and noticed that devtool/recipetool doesn't seem to work anymore after
> this change.
>
> $ devtool add "npm://registry.npmjs.org/;package=3Dfoo;version=3D1.1.0"
> WARNING: /OE/build/oe-core/openembedded-core/meta/recipes-recipetool/reci=
petool/tmp-recipetool-6k7q0cqb.bb:
> Exception during build_dependencies for fetcher_hashes_dummyfunc:
> ExpansionError('fetcher_hashes_dummyfunc[vardepvalue]',
> '${@bb.fetch.get_hashvalue(d)}', MissingParameterError("Missing
> checksum for npm package 'foo@1.1.0': a compromised registry could
> otherwise serve a tampered tarball undetected. Add one of sha512sum,
> sha256sum, sha384sum, sha1sum to SRC_URI.",
> 'npm://registry.npmjs.org/;package=3Dfoo;version=3D1.1.0'))
> WARNING: /OE/build/oe-core/openembedded-core/meta/recipes-recipetool/reci=
petool/tmp-recipetool-6k7q0cqb.bb:
> Error during finalise of
> /OE/build/oe-core/openembedded-core/meta/recipes-recipetool/recipetool/tm=
p-recipetool-6k7q0cqb.bb
> ERROR: ExpansionError during parsing
> /OE/build/oe-core/openembedded-core/meta/recipes-recipetool/recipetool/tm=
p-recipetool-6k7q0cqb.bb
> bb.data_smart.ExpansionError: Failure expanding variable
> fetcher_hashes_dummyfunc[vardepvalue], expression was
> ${@bb.fetch.get_hashvalue(d)} which triggered exception
> MissingParameterError: URL:
> 'npm://registry.npmjs.org/;package=3Dfoo;version=3D1.1.0' is missing the
> required parameter 'Missing checksum for npm package 'foo@1.1.0': a
> compromised registry could otherwise serve a tampered tarball
> undetected. Add one of sha512sum, sha256sum, sha384sum, sha1sum to
> SRC_URI.'
> The variable dependency chain for the failure is:
> fetcher_hashes_dummyfunc[vardepvalue]
>
> Am I missing some pending change or is it just nobody had time yet to
> work on recipetool?
>
> Regards,
>
> On Fri, Jul 31, 2026 at 2:46=E2=80=AFPM Thomas Perrot via
> lists.openembedded.org
> <thomas.perrot=3Dbootlin.com@lists.openembedded.org> wrote:
> >
> > The npm and npmsw fetchers were disabled in 355cd226 because the npm
> > fetcher accepted checksums from the remote registry rather than from
> > the recipe. A compromised registry controls both the tarball and its
> > advertised hash, making checksum verification meaningless.
> >
> > npmsw was also disabled at that point, but its security model is
> > already correct: checksums come from the locally-committed
> > npm-shrinkwrap.json file, not from the network. Re-enable it with a
> > fix for the missing FetchError import that would cause a NameError on
> > malformed shrinkwrap files. Also fix two correctness bugs:
> > - change 'if not packages' to 'if packages is None' in
> >   foreach_dependencies so a valid zero-dependency shrinkwrap
> >   (packages=3D{}) no longer raises FetchError.
> > - add 'elif resolved is None' guard before the startswith chain in
> >   _resolve_dependency so missing 'resolved' fields raise
> >   ParameterError instead of AttributeError.
> >
> > For npm, fix the root cause by separating URL resolution from checksum
> > handling:
> > - _resolve_proxy_url now stores only the bare tarball URL in the
> >   .resolved file; the registry-supplied dist.integrity / dist.shasum
> >   values are ignored entirely.
> > - _setup_proxy builds the proxy URL from that bare tarball URL and
> >   injects the checksum from the recipe's SRC_URI parameters
> >   (sha512sum=3D, sha256sum=3D, etc.).  uri.params is cleared before
> >   rebuilding so that a .resolved file written by the npmsw fetcher
> >   (which stores the full URI with checksum params) cannot smuggle a
> >   registry-sourced checksum into the npm proxy URL.
> > - A checksum is now mandatory: urldata_init raises
> >   MissingParameterError if none of sha512sum/sha256sum/sha384sum/
> >   sha1sum is present in SRC_URI. Unlike wget, npm has no independent
> >   anchor for the fetched content (no pinned commit, no fixed path) --
> >   the registry is exactly the party this fetcher was disabled for not
> >   trusting -- so, unlike the rest of BitBake's fetchers, this
> >   requirement is unconditional and does not depend on
> >   BB_STRICT_CHECKSUM.
> > - version=3Dlatest is now a hard ParameterError instead of a warning;
> >   it is inherently non-reproducible. The dead
> >   'if ud.version =3D=3D "latest": return True' branch in need_update() =
is
> >   also removed, since version=3Dlatest is rejected at urldata_init time=
.
> > - Narrow the broad 'except Exception' in _npm_view to only catch
> >   json.JSONDecodeError; FetchError and ParameterError now propagate
> >   directly to the caller instead of being re-wrapped as a generic
> >   FetchError, fixing typed exception handling for version mismatches.
> >   Fall back to str(error) when 'summary' is absent in the registry
> >   error dict so the message is never silently None.
> >
> > Note: existing .resolved files written by the old fetcher embed a
> > registry-sourced checksum in the URL and must be removed before
> > rebuilding.
> >
> > [YOCTO #16105]
> >
> > Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> > ---
> >  lib/bb/fetch2/npm.py   | 111 +++++++++++++++++++++++++++++------------=
--------
> >  lib/bb/fetch2/npmsw.py |  12 +++---
> >  2 files changed, 72 insertions(+), 51 deletions(-)
> >
> > diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> > index 3c0cd9ff098c..a429a8292677 100644
> > --- a/lib/bb/fetch2/npm.py
> > +++ b/lib/bb/fetch2/npm.py
> > @@ -16,6 +16,11 @@ Supported SRC_URI options are:
> >  - version
> >      The npm package version. This is a mandatory parameter.
> >
> > +- sha512sum / sha256sum / sha384sum / sha1sum
> > +    The expected checksum of the downloaded tarball. Exactly one is
> > +    mandatory: the registry cannot be trusted to supply its own tamper
> > +    detection, so the checksum must come from the recipe.
> > +
> >  - downloadfilename
> >      Specifies the filename used when storing the downloaded file.
> >
> > @@ -33,6 +38,7 @@ import bb
> >  from bb.fetch2 import Fetch
> >  from bb.fetch2 import FetchError
> >  from bb.fetch2 import FetchMethod
> > +from bb.fetch2 import MalformedUrl
> >  from bb.fetch2 import MissingParameterError
> >  from bb.fetch2 import ParameterError
> >  from bb.fetch2 import URI
> > @@ -40,6 +46,9 @@ from bb.fetch2 import check_network_access
> >  from bb.fetch2 import runfetchcmd
> >  from bb.utils import is_semver
> >
> > +# Preference order matches strength; the first one present in SRC_URI =
wins.
> > +CHECKSUM_PARMS =3D ("sha512sum", "sha256sum", "sha384sum", "sha1sum")
> > +
> >  def npm_package(package):
> >      """Convert the npm package name to remove unsupported character"""
> >      # For scoped package names ('@user/package') the '/' is replaced b=
y a '-'.
> > @@ -148,11 +157,7 @@ class Npm(FetchMethod):
> >
> >      def supports(self, ud, d):
> >          """Check if a given url can be fetched with npm"""
> > -        #return ud.type in ["npm"]
> > -        if ud.type in ["npm"]:
> > -            from bb.parse import SkipRecipe
> > -            raise SkipRecipe("The npm fetcher has been disabled due to=
 security issues and there is no maintainer to address them")
> > -        return False
> > +        return ud.type in ["npm"]
> >
> >      def urldata_init(self, ud, d):
> >          """Init npm specific variables within url data"""
> > @@ -174,11 +179,32 @@ class Npm(FetchMethod):
> >          if not ud.version:
> >              raise MissingParameterError("Parameter 'version' required"=
, ud.url)
> >
> > -        if not is_semver(ud.version) and not ud.version =3D=3D "latest=
":
> > +        if ud.version =3D=3D "latest":
> > +            raise ParameterError(
> > +                "Version 'latest' is not reproducible; specify an exac=
t semver version",
> > +                ud.url)
> > +
> > +        if not is_semver(ud.version):
> >              raise ParameterError("Invalid 'version' parameter", ud.url=
)
> >
> >          # Extract the 'registry' part of the url
> >          ud.registry =3D re.sub(r"^npm://", "https://", ud.url.split(";=
")[0])
> > +        if not ud.url.split(";")[0][len("npm://"):]:
> > +            raise MalformedUrl(ud.url)
> > +
> > +        # A checksum is mandatory: the registry cannot be trusted to s=
upply
> > +        # its own tamper detection, so the recipe must commit to one.
> > +        for cp in CHECKSUM_PARMS:
> > +            if cp in ud.parm:
> > +                ud.checksum_name =3D cp
> > +                ud.checksum_expected =3D ud.parm[cp]
> > +                break
> > +        else:
> > +            raise MissingParameterError(
> > +                "Missing checksum for npm package '%s@%s': a compromis=
ed "
> > +                "registry could otherwise serve a tampered tarball und=
etected. "
> > +                "Add one of %s to SRC_URI." % (ud.package, ud.version,=
 ", ".join(CHECKSUM_PARMS)),
> > +                ud.url)
> >
> >          # Using the 'downloadfilename' parameter as local filename
> >          # or the npm package name.
> > @@ -200,6 +226,13 @@ class Npm(FetchMethod):
> >          ud.resolvefile =3D self.localpath(ud, d) + ".resolved"
> >
> >      def _resolve_proxy_url(self, ud, d):
> > +        """Resolve the tarball URL from the registry and cache it with=
out any checksum.
> > +
> > +        Checksums must never be sourced from the registry: a compromis=
ed registry
> > +        controls both the tarball and its advertised hash, so any chec=
ksum obtained
> > +        there provides no tamper detection. Checksums are applied in _=
setup_proxy
> > +        from the recipe-provided SRC_URI parameters instead.
> > +        """
> >          def _npm_view():
> >              args =3D []
> >              args.append(("json", "true"))
> > @@ -215,50 +248,27 @@ class Npm(FetchMethod):
> >
> >              try:
> >                  view =3D json.loads(view_string)
> > -
> > -                error =3D view.get("error")
> > -                if error is not None:
> > -                    raise FetchError(error.get("summary"), ud.url)
> > -
> > -                if ud.version =3D=3D "latest":
> > -                    bb.warn("The npm package %s is using the latest " =
\
> > -                            "version available. This could lead to " \
> > -                            "non-reproducible builds." % pkgver)
> > -                elif ud.version !=3D view.get("version"):
> > -                    raise ParameterError("Invalid 'version' parameter"=
, ud.url)
> > -
> > -                return view
> > -
> > -            except Exception as e:
> > +            except json.JSONDecodeError as e:
> >                  raise FetchError("Invalid view from npm: %s" % str(e),=
 ud.url)
> >
> > -        def _get_url(view):
> > -            tarball_url =3D view.get("dist", {}).get("tarball")
> > +            error =3D view.get("error")
> > +            if error is not None:
> > +                raise FetchError(error.get("summary") or str(error), u=
d.url)
> >
> > -            if tarball_url is None:
> > -                raise FetchError("Invalid 'dist.tarball' in view", ud.=
url)
> > +            if ud.version !=3D view.get("version"):
> > +                raise ParameterError("Invalid 'version' parameter", ud=
.url)
> >
> > -            uri =3D URI(tarball_url)
> > -            uri.params["downloadfilename"] =3D ud.localfile
> > -
> > -            integrity =3D view.get("dist", {}).get("integrity")
> > -            shasum =3D view.get("dist", {}).get("shasum")
> > +            return view
> >
> > -            if integrity is not None:
> > -                checksum_name, checksum_expected =3D npm_integrity(int=
egrity)
> > -                uri.params[checksum_name] =3D checksum_expected
> > -            elif shasum is not None:
> > -                uri.params["sha1sum"] =3D shasum
> > -            else:
> > -                raise FetchError("Invalid 'dist.integrity' in view", u=
d.url)
> > +        view =3D _npm_view()
> > +        tarball_url =3D view.get("dist", {}).get("tarball")
> >
> > -            return str(uri)
> > -
> > -        url =3D _get_url(_npm_view())
> > +        if tarball_url is None:
> > +            raise FetchError("Invalid 'dist.tarball' in view", ud.url)
> >
> >          bb.utils.mkdirhier(os.path.dirname(ud.resolvefile))
> >          with open(ud.resolvefile, "w") as f:
> > -            f.write(url)
> > +            f.write(tarball_url)
> >
> >      def _setup_proxy(self, ud, d):
> >          if ud.proxy is None:
> > @@ -266,13 +276,26 @@ class Npm(FetchMethod):
> >                  self._resolve_proxy_url(ud, d)
> >
> >              with open(ud.resolvefile, "r") as f:
> > -                url =3D f.read()
> > +                tarball_url =3D f.read().strip()
> > +
> > +            uri =3D URI(tarball_url)
> > +            # Discard any params that may have been embedded in the st=
ored URL
> > +            # (e.g. from an npmsw-written .resolved file) and rebuild =
from
> > +            # scratch so that registry-sourced checksums can never flo=
w through.
> > +            uri.params =3D {}
> > +            uri.params["downloadfilename"] =3D ud.localfile
> > +
> > +            # Inject the recipe-provided checksum into the proxy URL.
> > +            # Checksums from the remote registry are never used; only =
the
> > +            # value validated in urldata_init, sourced from the recipe=
, is
> > +            # trusted.
> > +            uri.params[ud.checksum_name] =3D ud.checksum_expected
> >
> >              # Avoid conflicts between the environment data and:
> >              # - the proxy url checksum
> >              data =3D bb.data.createCopy(d)
> >              data.delVarFlags("SRC_URI")
> > -            ud.proxy =3D Fetch([url], data)
> > +            ud.proxy =3D Fetch([str(uri)], data)
> >
> >      def _get_proxy_method(self, ud, d):
> >          self._setup_proxy(ud, d)
> > @@ -296,8 +319,6 @@ class Npm(FetchMethod):
> >          """Force a fetch, even if localpath exists ?"""
> >          if not os.path.exists(ud.resolvefile):
> >              return True
> > -        if ud.version =3D=3D "latest":
> > -            return True
> >          proxy_m, proxy_ud, proxy_d =3D self._get_proxy_method(ud, d)
> >          return proxy_m.need_update(proxy_ud, proxy_d)
> >
> > diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
> > index 5255e8b465e1..f09ea5794856 100644
> > --- a/lib/bb/fetch2/npmsw.py
> > +++ b/lib/bb/fetch2/npmsw.py
> > @@ -21,6 +21,7 @@ import json
> >  import os
> >  import re
> >  import bb
> > +from bb.fetch2 import FetchError
> >  from bb.fetch2 import Fetch
> >  from bb.fetch2 import FetchMethod
> >  from bb.fetch2 import ParameterError
> > @@ -44,7 +45,7 @@ def foreach_dependencies(shrinkwrap, callback=3DNone,=
 dev=3DFalse):
> >              location =3D the location of the package (string)
> >      """
> >      packages =3D shrinkwrap.get("packages")
> > -    if not packages:
> > +    if packages is None:
> >          raise FetchError("Invalid shrinkwrap file format")
> >
> >      for location, data in packages.items():
> > @@ -63,11 +64,7 @@ class NpmShrinkWrap(FetchMethod):
> >
> >      def supports(self, ud, d):
> >          """Check if a given url can be fetched with npmsw"""
> > -        #return ud.type in ["npmsw"]
> > -        if ud.type in ["npmsw"]:
> > -            from bb.parse import SkipRecipe
> > -            raise SkipRecipe("The npmsw fetcher has been disabled due =
to security issues and there is no maintainer to address them")
> > -        return False
> > +        return ud.type in ["npmsw"]
> >
> >      def urldata_init(self, ud, d):
> >          """Init npmsw specific variables within url data"""
> > @@ -126,6 +123,9 @@ class NpmShrinkWrap(FetchMethod):
> >                  extrapaths.append(resolvefile)
> >
> >              # Handle http tarball sources
> > +            elif resolved is None:
> > +                raise ParameterError("Missing 'resolved' field for dep=
endency '%s'" % name, ud.url)
> > +
> >              elif resolved.startswith("http") and integrity:
> >                  localfile =3D npm_localfile(os.path.basename(resolved)=
)
> >
> >
> > --
> > 2.55.0
> >
> >
> >
> >
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20236): https://lists.openembedded.org/g/bitbake-deve=
l/message/20236
> Mute This Topic: https://lists.openembedded.org/mt/120533563/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [martin=
.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

