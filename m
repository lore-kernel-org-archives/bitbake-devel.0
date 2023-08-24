Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B46C6FA8F
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 22:12:21 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.537.1692915135706828762
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 15:12:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=V6hz4fWx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-31768ce2e81so227001f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692915134; x=1693519934;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8kG7NmuDEls4H4944cCyrcSirgC17gxRZw9rG+Wdj/c=;
        b=V6hz4fWxNq+woA+rti4nXY4kIwcw4ebleJNF+XocvJWRoYSD80LGRQg7PRsOXQpDHI
         jb7dpdkY7X0TW/i2TF1z9NylrFaw+JIMvEEGXGuDN1twOdkLJFPDBjq1RRH3VOxM+l42
         JsS/tmvPnjNo1RZ7wepAuEFjjmXv6irgjwOGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692915134; x=1693519934;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kG7NmuDEls4H4944cCyrcSirgC17gxRZw9rG+Wdj/c=;
        b=N/qEWI7P98Y6izC8eb76C6UauQOhRjTZVp+JM+UqHPvEa2d5iNaNtdBQ88td6PYKXn
         gejs8KezYWxq9AaEdVm3IRtMMEj8jjodITMVNuHTNfCO/BPQhr/+pBdce2bSw9hSnfFq
         FLaRJCst1ROv7wU5JndKMGOK032x8g7mTY3m1SmkeZOUcw+a9bi5HDiHuV1qHPyw3ogz
         /47JENwv3ycLzsUVytcjfso7UsWTvbbmEjlJXl1zyItL77lBCNItk50jjIXFHILWARvk
         HTwefAAzTbn8vCzZiQQr/O5bIvtJGykFUwB6qOKfKavn02EDWDPtpRTX26hvL2mrYkdX
         PhKQ==
X-Gm-Message-State: AOJu0YwihcFFOrSuNJunOqHXGv6108Da9XyrigiNpE+TvECNItsR0met
	gVVQJJVw3T5iKhcHmG2nod6iAQ==
X-Google-Smtp-Source: AGHT+IHQOt6rOfcgmhk8JOAc653F6Kn4wXNpO4ukdYCQNZOQmwPJv+DnHDHx/ww5fq+75egbOmxtwQ==
X-Received: by 2002:adf:ec12:0:b0:313:e88d:e6cf with SMTP id x18-20020adfec12000000b00313e88de6cfmr13559393wrn.69.1692915134061;
        Thu, 24 Aug 2023 15:12:14 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5f51:6592:7dd5:4623? ([2001:8b0:aba:5f3c:5f51:6592:7dd5:4623])
        by smtp.gmail.com with ESMTPSA id v1-20020adff681000000b00317eee26bf0sm331626wrp.69.2023.08.24.15.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:12:13 -0700 (PDT)
Message-ID: <5c0b59c02a5ce3aa87439ee67ffe7c74e12be859.camel@linuxfoundation.org>
Subject: Re: [PATCH v4 1/3] fetch2: Add support for upstream source tracing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alberto@pianon.eu, bitbake-devel@lists.openembedded.org
Cc: jpewhacker@gmail.com, carlo@piana.eu, luca.ceresoli@bootlin.com, 
	peter.kjellerstedt@axis.com
Date: Thu, 24 Aug 2023 23:12:12 +0100
In-Reply-To: <20230824155655.448755-1-alberto@pianon.eu>
References: <20230824155655.448755-1-alberto@pianon.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 22:12:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14981

On Thu, 2023-08-24 at 17:56 +0200, alberto@pianon.eu wrote:
> From: Alberto Pianon <alberto@pianon.eu>
>=20
> License compliance and SBoM generation require to be able to trace each
> source file back to its corresponding upstream source. The current
> implementation of bb.fetch2 makes it difficult, especially when multiple
> upstream sources are combined together.
>=20
> This patch provides an interface to solve the issue by implementing a
> process that unpacks each SRC_URI element into a temporary directory,
> creates an entrypoint to collect relevant provenance metadata on each
> source file, moves everything to the recipe rootdir, and saves metadata
> in a JSON file.
>=20
> This patch contains required modifications to fetchers' code plus a
> TraceUnpackBase class that implements the above described process. Data
> collection logic should be separately implemented by subclassing
> TraceUnpackBase, implementing _collect_data() and _process_data()
> methods.
>=20
> Splitting the above described solution in multiple patches and in
> multiple modules/classes aims at easing review and merge process, and
> also at decoupling the development of the data collection logic from the
> process that enables it.
>=20
> Signed-off-by: Alberto Pianon <alberto@pianon.eu>
> ---
>  bin/bitbake-selftest        |   1 +
>  lib/bb/fetch2/__init__.py   |  55 +++++++-
>  lib/bb/fetch2/crate.py      |   2 +
>  lib/bb/fetch2/gitsm.py      |  24 +++-
>  lib/bb/fetch2/hg.py         |   1 +
>  lib/bb/fetch2/npm.py        |   1 +
>  lib/bb/fetch2/npmsw.py      |  25 +++-
>  lib/bb/fetch2/trace_base.py | 256 ++++++++++++++++++++++++++++++++++++
>  lib/bb/tests/trace_base.py  | 227 ++++++++++++++++++++++++++++++++
>  9 files changed, 583 insertions(+), 9 deletions(-)
>  create mode 100644 lib/bb/fetch2/trace_base.py
>  create mode 100644 lib/bb/tests/trace_base.py
>=20
> diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
> index f25f23b1..6d60a5d2 100755
> --- a/bin/bitbake-selftest
> +++ b/bin/bitbake-selftest
> @@ -31,6 +31,7 @@ tests =3D ["bb.tests.codeparser",
>           "bb.tests.runqueue",
>           "bb.tests.siggen",
>           "bb.tests.utils",
> +         "bb.tests.trace_base",
>           "bb.tests.compression",
>           "hashserv.tests",
>           "layerindexlib.tests.layerindexobj",
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index e4c1d206..aef5fcb4 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -28,6 +28,8 @@ import bb.checksum
>  import bb.process
>  import bb.event
> =20
> +from .trace_base import TraceUnpackBase
> +
>  __version__ =3D "2"
>  _checksum_cache =3D bb.checksum.FileChecksumCache()
> =20
> @@ -1279,6 +1281,7 @@ class FetchData(object):
>          if not self.pswd and "pswd" in self.parm:
>              self.pswd =3D self.parm["pswd"]
>          self.setup =3D False
> +        self.destdir =3D None
> =20
>          def configure_checksum(checksum_id):
>              if "name" in self.parm:
> @@ -1557,6 +1560,8 @@ class FetchMethod(object):
>              bb.utils.mkdirhier(unpackdir)
>          else:
>              unpackdir =3D rootdir
> +        urldata.destdir =3D unpackdir
> +        urldata.is_unpacked_archive =3D unpack and cmd
> =20
>          if not unpack or not cmd:
>              # If file =3D=3D dest, then avoid any copies, as we already =
put the file into dest!
> @@ -1572,6 +1577,7 @@ class FetchMethod(object):
>                      if urlpath.find("/") !=3D -1:
>                          destdir =3D urlpath.rsplit("/", 1)[0] + '/'
>                          bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir=
))
> +                        urldata.destdir =3D "%s/%s" % (unpackdir, destdi=
r)
>                  cmd =3D 'cp -fpPRH "%s" "%s"' % (file, destdir)
> =20
>          if not cmd:
> @@ -1855,26 +1861,69 @@ class Fetch(object):
>              if not ret:
>                  raise FetchError("URL %s doesn't work" % u, u)
> =20
> -    def unpack(self, root, urls=3DNone):
> +    def unpack(self, root, urls=3DNone, is_module=3DFalse, checkout_dest=
dir=3DNone):
>          """
> -        Unpack urls to root
> +        Unpack urls to a tmp dir, trace, and then move everything to roo=
t
> +
> +        is_module needs to be set to true when this method is recursivel=
y called
> +        by a fetcher's unpack method to unpack (sub)modules (gitsm, npms=
w)
> +
> +        checkout_destdir needs to be passed when this method is recursiv=
ely
> +        called by gitsm fetcher
>          """
> =20
>          if not urls:
>              urls =3D self.urls
> +        if is_module:
> +            destdir =3D root
> +        else:
> +            trace =3D TraceUnpackBase(root, self.d)
> +            destdir =3D trace.tmpdir
> =20
>          for u in urls:
>              ud =3D self.ud[u]
> +            # absolute subdir, destsuffix and subpath params wouldn't wo=
rk when
> +            # unpacking in the tmp dir, convert them to relative paths
> +            realroot =3D os.path.realpath(root)
> +            params =3D [ 'subdir', 'destsuffix', 'subpath' ]
> +            for p in params:
> +                if not ud.parm.get(p):
> +                    continue
> +                if os.path.isabs(ud.parm[p]):
> +                    realpath =3D os.path.realpath(ud.parm[p])
> +                    if realpath.startswith(realroot):
> +                        ud.parm[p] =3D os.path.relpath(realpath, realroo=
t)
>              ud.setup_localpath(self.d)
> +            ud.rootdir =3D root
> +
> +            if hasattr(ud, "checkout_destdir"):
> +                ud.checkout_destdir =3D checkout_destdir
> =20
>              if ud.lockfile:
>                  lf =3D bb.utils.lockfile(ud.lockfile)
> =20
> -            ud.method.unpack(ud, root, self.d)
> +            ud.method.unpack(ud, destdir, self.d)
> =20
>              if ud.lockfile:
>                  bb.utils.unlockfile(lf)
> =20
> +            if is_module:
> +                continue
> +
> +            if hasattr(ud, "nocheckout") and ud.nocheckout:
> +                logger.warning(
> +                    "Can't trace sources for"
> +                    " %s because repo has not been checked out" % u)
> +            else:
> +                trace.commit(u, ud)
> +
> +            trace.move2root()
> +
> +        if is_module:
> +            return
> +        trace.write_data()
> +        trace.close()
> +
>      def clean(self, urls=3DNone):
>          """
>          Clean files that the fetcher gets or places

This patch takes a relatively clean function and adds logic which isn't
particularly clear or easy to follow. For example why should the
function skip the trace.commit() if it is a module? Surely you need the
trace data for modules as well? I guess you collect this differently
for things registered as modules?

Other things which concern me:

* backend specific parameters such as nocheckout are now appearing in
the core function
* we're switching absolute paths for relative paths for very unclear
reasons which will make the code more fragile to changes
* gitsm specific handling is being added to the core

I was willing to accept intercept hooks on this code but this rewrites
the code paths and the fetcher behaviour significantly in ways most of
our users don't need or want.

Whilst I know I did say to submit it, getting the code 1 working day
before feature freeze does also limit my options somewhat in what I can
do with it during review.


I'm basically worried that this convolutes the unpack process so badly
that nobody is going to be able to follow, maintain or modify this code
in future. I know I can barely follow what this is doing and it won't
encourage anyone else to touch it :(.


I do understand why you want to do this but I'm not convinced that the
project should be taking changes like this for what I personally think
are very marginal gains.

I appreciate from some legal perspectives, you feel you absolutely must
resolve every file back to every original source but in reality for
99.9% of our users, they just don't need to do this.

This puts me in a really difficult position. I appreciate the work
you've put into this and I do see what you want to do but in it's
current form, I don't think I'll do the project any favours by
accepting it.

I do think there must be a way for improving the interface so that my
concerns are alleviated and the risk is pushed to the people enabling
it, but without diving into the code myself to try and illustrate that,
I'm not sure how I can help us get there.

Cheers,

Richard


