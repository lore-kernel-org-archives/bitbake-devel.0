Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D6C001DC
	for <webhook@archiver.kernel.org>; Mon, 31 Jul 2023 14:08:17 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web10.8349.1690812496406571686
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 Jul 2023 07:08:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=knEBz2cS;
 spf=pass (domain: gmail.com, ip: 209.85.208.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so67558821fa.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 31 Jul 2023 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690812494; x=1691417294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FrYeeHvTJSveusTVAzKIiblAXHngDvGqdITXMN5Yb4=;
        b=knEBz2cS48ol7QqUcHnET4V+D3bHmdLY/ebJHJjlwtLHLVCC8rx2GDstVi4rZLfub6
         QyCsviDZKVyXf85AdsrXM/jrwjSyAJgUbrIK5QSmJLRNP+KHmCL6sXHjDvWBaTIIVsbH
         kSMxflmna0TySVQYUgJKiirt2sl3QMYX5hJQtdtiTXVrKPSuCyXLWku89V+naClKrc7m
         XAq2nJ1Lazt4NdA8IXuk2ylZ8psme/kmxqaCG5S7b2Eb8jnoCl2jq799kUPOk6kbgkqE
         1AazLnaqnkp0JiOnjfTzuF5sSn5iETaMuhgZZfNCxEv2vtHbV2fjkIIgYP/eGJ5Bgmeh
         onHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690812494; x=1691417294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FrYeeHvTJSveusTVAzKIiblAXHngDvGqdITXMN5Yb4=;
        b=Q3tf+oLSLcwPstuIoUGywtv8tu6o6DufacTvPL9cXrZOUEt+cMXlI93vICOoiGyvUu
         CFXUlpA2zIvIFVSNfVEetw0XP5XVVaJ8IAiJwyMc3gVaN3VfoRpjEl/27EzV3S77sACD
         FikVCUcYohT7OhWADSFBC2TzETFoD+gpaXzMUOvDoiYiFKI5oAG/ItXMAZ8hxbc0waiJ
         LRsgUvsYSkKCdmcsnTelc26ptkUzXfOuFo7o+oY827ol/koDgcsAOKzxr2rYcVqwF5P8
         2gf+0blMKVFz/83/De9EzmMx0fFa41KUloOI8JFqD4+RDva7FcxB6HmWXHU0pERavvCR
         yBeA==
X-Gm-Message-State: ABy/qLZjGSNacUSNWd2s9IImz2A442xgBrmok+TFInCb6Uuh2jAVCGEj
	MPvPSLX16JzB9KeK1taU6PZrllCnInZRicRFfMo=
X-Google-Smtp-Source: APBJJlHJhK510TVg+bmwV0kXDA5FxHHEjsmkScFjSzC9kQ0P9cK3mJvjfjWQGWYzFyNNn3glKTvWOHslJr9y3HvkWnY=
X-Received: by 2002:a2e:7816:0:b0:2b6:d7d1:95bf with SMTP id
 t22-20020a2e7816000000b002b6d7d195bfmr66585ljc.9.1690812494057; Mon, 31 Jul
 2023 07:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230731133444.713728-1-eekmecic@snap.com>
In-Reply-To: <20230731133444.713728-1-eekmecic@snap.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 31 Jul 2023 16:08:02 +0200
Message-ID: <CANNYZj_Ndq4FQwTqq1_9Aj9dNMAGWn6zZBJRsc3RBn8TC9KPSw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: add Google Cloud Platform (GCP) fetcher
To: eekmecic@snap.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Jul 2023 14:08:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14895

There are a number of expectations that any new fetcher should either
fulfil, or explain why it doesn't apply:
https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/fetch2/README

Can you please go over that list, and provide answers to the points in it?

Alex

On Mon, 31 Jul 2023 at 15:34, eekmecic via lists.openembedded.org
<eekmecic=3Dsnap.com@lists.openembedded.org> wrote:
>
> From: Emil Ekme=C4=8Di=C4=87 <eekmecic@snap.com>
>
> This fetcher allows BitBake to fetch from a Google Cloud Storage
> bucket. The fetcher expects a gs:// URI of the following form:
>
> SSTATE_MIRRORS =3D "file://.* gs://<bucket name>/PATH"
>
> In addition, a GCP project name must be specified using the
> GCP_PROJECT_NAME variable like so:
>
> GCP_PROJECT_NAME =3D "my-project"
>
> The fetcher uses the Google Cloud Storage Python Client, and
> expects it to be installed, configured, and authenticated prior
> to use.
>
> Signed-off-by: Emil Ekme=C4=8Di=C4=87 <eekmecic@snap.com>
> ---
>  lib/bb/fetch2/__init__.py |   4 +-
>  lib/bb/fetch2/gcp.py      | 108 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 111 insertions(+), 1 deletion(-)
>  create mode 100644 lib/bb/fetch2/gcp.py
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 8afe012e..0a3d7a58 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1290,7 +1290,7 @@ class FetchData(object):
>
>              if checksum_name in self.parm:
>                  checksum_expected =3D self.parm[checksum_name]
> -            elif self.type not in ["http", "https", "ftp", "ftps", "sftp=
", "s3", "az", "crate"]:
> +            elif self.type not in ["http", "https", "ftp", "ftps", "sftp=
", "s3", "az", "crate", "gs"]:
>                  checksum_expected =3D None
>              else:
>                  checksum_expected =3D d.getVarFlag("SRC_URI", checksum_n=
ame)
> @@ -1973,6 +1973,7 @@ from . import npm
>  from . import npmsw
>  from . import az
>  from . import crate
> +from . import gcp
>
>  methods.append(local.Local())
>  methods.append(wget.Wget())
> @@ -1994,3 +1995,4 @@ methods.append(npm.Npm())
>  methods.append(npmsw.NpmShrinkWrap())
>  methods.append(az.Az())
>  methods.append(crate.Crate())
> +methods.append(gcp.GCP())
> diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
> new file mode 100644
> index 00000000..7431ea4d
> --- /dev/null
> +++ b/lib/bb/fetch2/gcp.py
> @@ -0,0 +1,108 @@
> +"""
> +BitBake 'Fetch' implementation for Google Cloup Platform Storage.
> +
> +Class for fetching files from Google Cloud Storage using the
> +Google Cloud Storage Python Client. The GCS Python Client must
> +be correctly installed, configured and authenticated prior to use.
> +Additionally, gsutil must also be installed.
> +
> +"""
> +
> +# Copyright (C) 2023, Snap Inc.
> +#
> +# Based in part on bb.fetch2.s3:
> +#    Copyright (C) 2017 Andre McCurdy
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Based on functions from the base bb module, Copyright 2003 Holger Schu=
rig
> +
> +import os
> +import bb
> +import urllib.parse, urllib.error
> +from bb.fetch2 import FetchMethod
> +from bb.fetch2 import FetchError
> +from bb.fetch2 import logger
> +from google.cloud import storage
> +
> +class GCP(FetchMethod):
> +    """
> +    Class to fetch urls via GCP's Python API.
> +    """
> +    def __init__(self):
> +        self.gcp_client =3D None
> +
> +    def init(self, d):
> +        """
> +        Initialize GCP client with the correct project name.
> +        """
> +        self.get_gcp_client(d)
> +
> +    def supports(self, ud, d):
> +        """
> +        Check to see if a given url can be fetched with GCP.
> +        """
> +        return ud.type in ['gs']
> +
> +    def recommends_checksum(self, urldata):
> +        return True
> +
> +    def urldata_init(self, ud, d):
> +        if 'downloadfilename' in ud.parm:
> +            ud.basename =3D ud.parm['downloadfilename']
> +        else:
> +            ud.basename =3D os.path.basename(ud.path)
> +
> +        ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
> +
> +    def get_gcp_client(self, d):
> +        project =3D d.getVar("GCP_PROJECT_NAME") or ""
> +        if project =3D=3D "":
> +            raise FetchError(f"No GCP project was specified using the GC=
P_PROJECT_NAME variable, unable to initialize GCP client!")
> +        logger.debug2(f"Trying to get GCP client for GCP project '{proje=
ct}'")
> +        self.gcp_client =3D storage.Client(project=3Dproject)
> +
> +    def download(self, ud, d):
> +        """
> +        Fetch urls using the GCP API.
> +        Assumes localpath was called first.
> +        """
> +        logger.debug2(f"Trying to download gs://{ud.host}{ud.path} to {u=
d.localpath}")
> +        if self.gcp_client is None:
> +            self.get_gcp_client(d)
> +
> +        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
> +
> +        # Path sometimes has leading slash, so strip it
> +        path =3D ud.path.lstrip("/")
> +        blob =3D self.gcp_client.bucket(ud.host).blob(path)
> +        blob.download_to_filename(ud.localpath)
> +
> +        # Additional sanity checks copied from the wget class (although =
there
> +        # are no known issues which mean these are required, treat the G=
CP API
> +        # tool with a little healthy suspicion).
> +        if not os.path.exists(ud.localpath):
> +            raise FetchError(f"The GCP API returned success for gs://{ud=
.host}{ud.path} but {ud.localpath} doesn't exist?!")
> +
> +        if os.path.getsize(ud.localpath) =3D=3D 0:
> +            os.remove(ud.localpath)
> +            raise FetchError(f"The downloaded file for gs://{ud.host}{ud=
.path} resulted in a zero size file?! Deleting and failing since this isn't=
 right.")
> +
> +        return True
> +
> +    def checkstatus(self, fetch, ud, d):
> +        """
> +        Check the status of a URL.
> +        """
> +        logger.debug2(f"Checking status of gs://{ud.host}{ud.path}")
> +        if self.gcp_client is None:
> +            self.get_gcp_client(d)
> +
> +        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
> +
> +        # Path sometimes has leading slash, so strip it
> +        path =3D ud.path.lstrip("/")
> +        if self.gcp_client.bucket(ud.host).blob(path).exists() =3D=3D Fa=
lse:
> +            raise FetchError(f"The GCP API reported that gs://{ud.host}{=
ud.path} does not exist")
> +        else:
> +            return True
> --
> 2.40.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14894): https://lists.openembedded.org/g/bitbake-deve=
l/message/14894
> Mute This Topic: https://lists.openembedded.org/mt/100461456/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

