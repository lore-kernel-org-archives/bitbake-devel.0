Return-Path: <eekmecic@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4937EC001DB
	for <webhook@archiver.kernel.org>; Tue,  8 Aug 2023 10:26:09 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.web11.58062.1691490367840512238
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Aug 2023 03:26:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=QiZEoucn;
 spf=pass (domain: snapchat.com, ip: 209.85.161.51, mailfrom: eekmecic@snapchat.com)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-56d0f4180bbso3665804eaf.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Aug 2023 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1691490367; x=1692095167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjEpBjk14angDrD7P+DYqgTUCax/b6KJ4byVSzOLX0k=;
        b=QiZEoucnrHn2YHSAE5kRtWi9mVBoxMR6HptxSDZNQSOmT0/kvR2Qw+cdlGiQ0eXRGC
         kzq0c8bEeytYUTqAO9eZSPAbjDqbjtRfhsqQyeGdT/XRBf9ORI2nBOvDghCBgcFbOpvg
         gu0/EQMnFwkmz9ZPrxNmgQ+Qovytsi8brQ624=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691490367; x=1692095167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjEpBjk14angDrD7P+DYqgTUCax/b6KJ4byVSzOLX0k=;
        b=EsxFGy4x+SUcajBeL0fLehrMO0jdAo1ZM9XNyuRaYwCvbuwbxuxzPMRr5d6PekyK4J
         Z1D2cNfTMzOXzxOkdKHbDLqEgtCLr/f7jglQWKI0tbnEbW/CqRD4MOfsDEphSdw0HX6Q
         B4HZexJa8L9dHmm0ADu+biiuiMrgnxcMBxTIWZI6Zpsms7ndcif1bH3oNkyQ2HPGXree
         dMAAIwe7WzLOpF61UvZtPQytusRivXp1Dfl/J7McnVKNdxvWnVQDuYD89m+lJcIOiFPe
         Nj5YoBAP5Djm19TZSDYjazQz3R113TRigL4LHBsNaiXbHr4HmPWQ4g0+dmpR8nfz5a+M
         RGGQ==
X-Gm-Message-State: AOJu0YyGFCbo1Ho5KN02tckVYTLCo7TfyPQjl8IPEhXiWa6DEkThIabi
	d9/h1XtSOhAPYbhVntda0RohtZGeUp1YEDbd2pBZtm81DiyVoe89yNkzoXPb
X-Google-Smtp-Source: AGHT+IEZ3EkDuc333e4DvwDBRv8PLXh109T69VH3F/8iDz7ePXeWdgVct+dAopdCItzC7D7Nb6QRafqoDJavjmAE/vs=
X-Received: by 2002:a05:6808:1a88:b0:3a7:4998:710 with SMTP id
 bm8-20020a0568081a8800b003a749980710mr11607784oib.8.1691490366893; Tue, 08
 Aug 2023 03:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230802130632.805865-1-eekmecic@snap.com> <202308072156510534a9ce@mail.local>
In-Reply-To: <202308072156510534a9ce@mail.local>
From: =?UTF-8?B?RW1pbCBFa21lxI1pxIc=?= <eekmecic@snap.com>
Date: Tue, 8 Aug 2023 12:25:55 +0200
Message-ID: <CACjag3vGrbb=aZq0hMfQUobbyzLn+5GD1Tj6pWze7zVOakWwqg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v3] fetch2: add Google Cloud Platform (GCP) fetcher
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Aug 2023 10:26:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14927

On Mon, Aug 7, 2023 at 11:56=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 02/08/2023 06:06:32-0700, Emil Ekme=C4=8Di=C4=87 via lists.openembedde=
d.org wrote:
> > From: Emil Ekme=C4=8Di=C4=87 <eekmecic@snap.com>
> >
> > This fetcher allows BitBake to fetch from a Google Cloud Storage
> > bucket. The fetcher expects a gs:// URI of the following form:
> >
> > SSTATE_MIRRORS =3D "file://.* gs://<bucket name>/PATH"
> >
> > The fetcher uses the Google Cloud Storage Python Client, and
> > expects it to be installed, configured, and authenticated prior
> > to use.
> >
> > There is also documentation for the fetcher added to the User
> > Manual. I'm still not completely sure about the recommends_checksum()
> > being set to True. As I've noted in the mailing list, it will throw
> > warnings if the fetcher is used in recipes without specifying a
> > checksum. Please let me know if this is intended behavior or if it
> > should be modified.
> >
> > If accepted, this patch should merge in with the corresponding oe-core
> > patch titled "Add GCP fetcher to list of supported protocols".
> >
> > Here is how this fetcher conforms to the fetcher expectations
> > described at this link:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.yoctoproject=
.org_poky_tree_bitbake_lib_bb_fetch2_README&d=3DDwIDaQ&c=3DncDTmphkJTvjIDPh=
0hpF_4vCHvabgGkICC2epckfdiw&r=3D-qewWg5dex9CwAblTO44EJ2bhBWUgkZe5H_fuhgqghM=
&m=3DCvAyJVYZKshHk188u8i0NiJA832j5QjdZ_--XJORTSNpgI2XT-DB376uf7TDPsKy&s=3Dd=
pXb4lEG1eVgg6yPziVtXLfDLefCddQnmjcC-WPYrjk&e=3D
> >
> > a) Yes, network fetching only happens in the fetcher
> >
> > b) The fetcher has nothing to do with the unpack phase so there is no
> > network access there
> >
> > c) This change doesn't affect the behavior of DL_DIR. The GCP fetcher
> > only downloads to the DL_DIR in the same way that other fetchers,
> > namely the S3 and Azure fetchers do.
> >
> > d) The fetcher is identical to the S3 and Azure fetchers in this
> > context
> >
> > e) Yes, the fetcher output is deterministic because it is downloading
> > tarballs from a bucket and not modifying them in any way.
> >
> > f) I set up a local proxy using tinyproxy and set the http_proxy
> > variable to test whether the Python API respected the proxy. It
> > appears that it did as I could see traffic passing through the
> > proxy. I also did some searching online and found posts indicating
> > that the Google Cloud Python APIs supported the classic Linux proxy
> > variables, namely:
> >   - https://github.com/googleapis/google-api-python-client/issues/1260
> >
> > g) Access is minimal, only checking if the file exists and downloading
> > it if it does.
> >
> > h) Not applicable, BitBake already knows which version it wants and
> > the version infomation is encoded in the filename. The fetcher has no
> > concept of versions.
> >
> > i) Not applicable
> >
> > j) Not applicable
> >
> > k) No tests were added as part of this change. I didn't see any tests
> > for the S3 or Azure changes either, is that OK?
> >
> > l) I'm not 100% familiar but I don't believe this fetcher is using any
> > tools during parse time. Please correct me if I'm wrong.
> >
> > Signed-off-by: Emil Ekme=C4=8Di=C4=87 <eekmecic@snap.com>
> > ---
> >  .../bitbake-user-manual-fetching.rst          |  36 ++++++
> >  lib/bb/fetch2/__init__.py                     |   4 +-
> >  lib/bb/fetch2/gcp.py                          | 104 ++++++++++++++++++
> >  3 files changed, 143 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/bb/fetch2/gcp.py
> >
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b=
/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> > index c061bd70..f5723d67 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> > @@ -688,6 +688,40 @@ Here is an example URL::
> >
> >  It can also be used when setting mirrors definitions using the :term:`=
PREMIRRORS` variable.
> >
> > +.. _gcp-fetcher:
> > +
> > +GCP Fetcher (``gs://``)
> > +--------------------------
> > +
> > +This submodule fetches data from a
> > +`Google Cloud Storage Bucket <https://cloud.google.com/storage/docs/bu=
ckets>`__.
> > +It uses the `Google Cloud Storage Python Client <https://cloud.google.=
com/python/docs/reference/storage/latest>`__
> > +to check the status of objects in the bucket and download them.
> > +The use of the Python client makes it substantially faster than using =
command
> > +line tools such as gsutil.
> > +
> > +The fetcher requires the Google Cloud Storage Python Client to be inst=
alled, along
> > +with the gsutil tool.
> > +
> > +The fetcher requires that the machine has valid credentials for access=
ing the
> > +chosen bucket. Instructions for authentication can be found in the
> > +`Google Cloud documentation <https://cloud.google.com/docs/authenticat=
ion/provide-credentials-adc#local-dev>`__.
> > +
> > +The fetcher can be used for fetching sstate artifacts from a GCS bucke=
t by
> > +specifying the :term:`SSTATE_MIRRORS` variable as shown below::
> > +
> > +   SSTATE_MIRRORS ?=3D "\
> > +       file://.* gs://<bucket name>/PATH \
> > +   "
> > +
> > +The fetcher can also be used in recipes::
> > +
> > +   SRC_URI =3D "gs://<bucket name>/<foo_container>/<bar_file>"
> > +
> > +However, the checksum of the file should be also be provided::
> > +
> > +   SRC_URI[sha256sum] =3D "<sha256 string>"
> > +
> >  .. _crate-fetcher:
> >
> >  Crate Fetcher (``crate://``)
> > @@ -791,6 +825,8 @@ Fetch submodules also exist for the following:
> >
> >  -  OSC (``osc://``)
> >
> > +-  S3 (``s3://``)
> > +
> >  -  Secure FTP (``sftp://``)
> >
> >  -  Secure Shell (``ssh://``)
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index 8afe012e..0a3d7a58 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -1290,7 +1290,7 @@ class FetchData(object):
> >
> >              if checksum_name in self.parm:
> >                  checksum_expected =3D self.parm[checksum_name]
> > -            elif self.type not in ["http", "https", "ftp", "ftps", "sf=
tp", "s3", "az", "crate"]:
> > +            elif self.type not in ["http", "https", "ftp", "ftps", "sf=
tp", "s3", "az", "crate", "gs"]:
> >                  checksum_expected =3D None
> >              else:
> >                  checksum_expected =3D d.getVarFlag("SRC_URI", checksum=
_name)
> > @@ -1973,6 +1973,7 @@ from . import npm
> >  from . import npmsw
> >  from . import az
> >  from . import crate
> > +from . import gcp
> >
> >  methods.append(local.Local())
> >  methods.append(wget.Wget())
> > @@ -1994,3 +1995,4 @@ methods.append(npm.Npm())
> >  methods.append(npmsw.NpmShrinkWrap())
> >  methods.append(az.Az())
> >  methods.append(crate.Crate())
> > +methods.append(gcp.GCP())
> > diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
> > new file mode 100644
> > index 00000000..66efbbdd
> > --- /dev/null
> > +++ b/lib/bb/fetch2/gcp.py
> > @@ -0,0 +1,104 @@
> > +"""
> > +BitBake 'Fetch' implementation for Google Cloup Platform Storage.
> > +
> > +Class for fetching files from Google Cloud Storage using the
> > +Google Cloud Storage Python Client. The GCS Python Client must
> > +be correctly installed, configured and authenticated prior to use.
> > +Additionally, gsutil must also be installed.
> > +
> > +"""
> > +
> > +# Copyright (C) 2023, Snap Inc.
> > +#
> > +# Based in part on bb.fetch2.s3:
> > +#    Copyright (C) 2017 Andre McCurdy
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Based on functions from the base bb module, Copyright 2003 Holger Sc=
hurig
> > +
> > +import os
> > +import bb
> > +import urllib.parse, urllib.error
> > +from bb.fetch2 import FetchMethod
> > +from bb.fetch2 import FetchError
> > +from bb.fetch2 import logger
> > +from google.cloud import storage
>
> This fails on the autobuilders with:
>
>   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/bin/bitbake-lay=
ers", line 24, in <module>
>     import bb.tinfoil
>   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/lib/bb/__init__=
.py", line 139, in <module>
>     from bb import fetch2 as fetch
>   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/lib/bb/fetch2/_=
_init__.py", line 1979, in <module>
>     from . import gcp
>   File "/home/pokybuild/yocto-worker/a-full/build/bitbake/lib/bb/fetch2/g=
cp.py", line 26, in <module>
>     from google.cloud import storage
> ModuleNotFoundError: No module named 'google'
>

Hello!

As noted in the comment at the top of the file and the documentation,
using the GCP fetcher requires the Python package to be installed.
I'm not sure the best way to handle this given that using the GCP
fetcher is optional. Other fetchers (S3, Azure) rely on third party
tools to be installed on the command line but no fetchers that I
found rely on Python packages to be installed.

I'm submitting an updated patch where the import statement is wrapped
in a try-catch block with a descriptive error message but I welcome
other approaches too.

Thank you for letting me know about this issue. I apologize for
the malformed URLs in my messages, my workplace enforces
these anti-phishing measures with no way to preserve URLs as
they were written for "security reasons".

> > +
> > +class GCP(FetchMethod):
> > +    """
> > +    Class to fetch urls via GCP's Python API.
> > +    """
> > +    def __init__(self):
> > +        self.gcp_client =3D None
> > +
> > +    def init(self, d):
> > +        """
> > +        Initialize GCP client.
> > +        """
> > +        self.get_gcp_client()
> > +
> > +    def supports(self, ud, d):
> > +        """
> > +        Check to see if a given url can be fetched with GCP.
> > +        """
> > +        return ud.type in ['gs']
> > +
> > +    def recommends_checksum(self, urldata):
> > +        return True
> > +
> > +    def urldata_init(self, ud, d):
> > +        if 'downloadfilename' in ud.parm:
> > +            ud.basename =3D ud.parm['downloadfilename']
> > +        else:
> > +            ud.basename =3D os.path.basename(ud.path)
> > +
> > +        ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
> > +
> > +    def get_gcp_client(self):
> > +        self.gcp_client =3D storage.Client(project=3DNone)
> > +
> > +    def download(self, ud, d):
> > +        """
> > +        Fetch urls using the GCP API.
> > +        Assumes localpath was called first.
> > +        """
> > +        logger.debug2(f"Trying to download gs://{ud.host}{ud.path} to =
{ud.localpath}")
> > +        if self.gcp_client is None:
> > +            self.get_gcp_client()
> > +
> > +        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
> > +
> > +        # Path sometimes has leading slash, so strip it
> > +        path =3D ud.path.lstrip("/")
> > +        blob =3D self.gcp_client.bucket(ud.host).blob(path)
> > +        blob.download_to_filename(ud.localpath)
> > +
> > +        # Additional sanity checks copied from the wget class (althoug=
h there
> > +        # are no known issues which mean these are required, treat the=
 GCP API
> > +        # tool with a little healthy suspicion).
> > +        if not os.path.exists(ud.localpath):
> > +            raise FetchError(f"The GCP API returned success for gs://{=
ud.host}{ud.path} but {ud.localpath} doesn't exist?!")
> > +
> > +        if os.path.getsize(ud.localpath) =3D=3D 0:
> > +            os.remove(ud.localpath)
> > +            raise FetchError(f"The downloaded file for gs://{ud.host}{=
ud.path} resulted in a zero size file?! Deleting and failing since this isn=
't right.")
> > +
> > +        return True
> > +
> > +    def checkstatus(self, fetch, ud, d):
> > +        """
> > +        Check the status of a URL.
> > +        """
> > +        logger.debug2(f"Checking status of gs://{ud.host}{ud.path}")
> > +        if self.gcp_client is None:
> > +            self.get_gcp_client()
> > +
> > +        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
> > +
> > +        # Path sometimes has leading slash, so strip it
> > +        path =3D ud.path.lstrip("/")
> > +        if self.gcp_client.bucket(ud.host).blob(path).exists() =3D=3D =
False:
> > +            raise FetchError(f"The GCP API reported that gs://{ud.host=
}{ud.path} does not exist")
> > +        else:
> > +            return True
> > --
> > 2.40.1
> >
>
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14908): https://urldefense.proofpoint.com/v2/url?u=
=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_14908&d=3DDwI=
DaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3D-qewWg5dex9CwAblTO4=
4EJ2bhBWUgkZe5H_fuhgqghM&m=3DCvAyJVYZKshHk188u8i0NiJA832j5QjdZ_--XJORTSNpgI=
2XT-DB376uf7TDPsKy&s=3DXY64fSpxAqHu4uyDYO4YvbYE_KlyUXuJ13J9-DORUWE&e=3D
> > Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_lists.openembedded.org_mt_100504608_3617179&d=3DDwIDaQ&c=3DncDTmphkJTvjIDP=
h0hpF_4vCHvabgGkICC2epckfdiw&r=3D-qewWg5dex9CwAblTO44EJ2bhBWUgkZe5H_fuhgqgh=
M&m=3DCvAyJVYZKshHk188u8i0NiJA832j5QjdZ_--XJORTSNpgI2XT-DB376uf7TDPsKy&s=3D=
7-Hb79byS7HZy-wInTZBO-i8xjXaWx_CZmGBODxGXwo&e=3D
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lis=
ts.openembedded.org_g_bitbake-2Ddevel_unsub&d=3DDwIDaQ&c=3DncDTmphkJTvjIDPh=
0hpF_4vCHvabgGkICC2epckfdiw&r=3D-qewWg5dex9CwAblTO44EJ2bhBWUgkZe5H_fuhgqghM=
&m=3DCvAyJVYZKshHk188u8i0NiJA832j5QjdZ_--XJORTSNpgI2XT-DB376uf7TDPsKy&s=3Db=
xklH72VbomKygu1uYboGaJjNXwn3mWHMI7fVKJmgQ0&e=3D  [alexandre.belloni@bootlin=
.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bootlin.com&d=3DDw=
IDaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3D-qewWg5dex9CwAblTO=
44EJ2bhBWUgkZe5H_fuhgqghM&m=3DCvAyJVYZKshHk188u8i0NiJA832j5QjdZ_--XJORTSNpg=
I2XT-DB376uf7TDPsKy&s=3Df4rAdmMi5at0u5ywQfZvdUX5lConsT8_z1Jt0pBmpzY&e=3D

Emil Ekme=C4=8Di=C4=87

