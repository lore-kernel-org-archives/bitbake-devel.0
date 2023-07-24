Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E1BC0015E
	for <webhook@archiver.kernel.org>; Mon, 24 Jul 2023 13:48:41 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web11.47355.1690206515614707775
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Jul 2023 06:48:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RTwEPPjg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.169, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9338e4695so63182281fa.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Jul 2023 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690206514; x=1690811314;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xWIACjr3Knll7Va4HZii0oB+ORYBnJIIHdQ8Iyp0Q8Q=;
        b=RTwEPPjgSvVRMRZzgb0xu3XkJF59mhOernhk8BMZ42QuT1DhhfTk5R9fCJXXoKJ4cx
         exwL9PNBEEdPsRYy1apc4AtHoWQLBTXju2wYco1IdSWj1uxZvBAX9WKEHZ59tBMerN5U
         PIm+d2qRCaQzW5ynGLeyowqNbatv0+a6Bfg5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206514; x=1690811314;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWIACjr3Knll7Va4HZii0oB+ORYBnJIIHdQ8Iyp0Q8Q=;
        b=j/V4aBC464/zSwmqNH2RFDztxyuUgFZ2Q8ECdMZbO0wNtMGUZ31IWn5A4s1T8u26To
         zGyDqioF9qs7J03ksE7i1aBntQuMDmd5wfaCCOOB4xrhkII/gB1DDYdEhRE342owUD3A
         qMUtE3uAYx9n0lynAuRaWa6G3DsoihZgTWHf81txIrEjo5p7O1jtDnt2tY4i/GzcBgUy
         g1i/MWR+1GQFfVFKlYSeirJqZdZTbsFLHIb8ajXIsBeRxYBwwEYAYEONoJYVDmwhTEuY
         GzkpYkbqpl7zQ6t6KvSGzBsHOCIue+FmP9wY6yUF8n3wIRgpdMFVt1h7GTUgoP0QSWy9
         y9jA==
X-Gm-Message-State: ABy/qLaEa3dVcf+aJMNlgsn+V9zsOgWq1rl15mGEz5lFR6OvkpQhJHQl
	sO+Bu/8IiODY3qQPDfhLbCvPMytY+n3kUSWpJSI=
X-Google-Smtp-Source: APBJJlEIzkxIbctEMpIErlwBaC4ykB+wOPx5HTW7kI9gpu+/aca0dLzdPMzK+kxVa/9xPghGNhvG7w==
X-Received: by 2002:a5d:4611:0:b0:317:943:eaf1 with SMTP id t17-20020a5d4611000000b003170943eaf1mr6750492wrq.28.1690206184960;
        Mon, 24 Jul 2023 06:43:04 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:10d:c2a3:d51c:55a1? ([2001:8b0:aba:5f3c:10d:c2a3:d51c:55a1])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5492000000b003142e438e8csm12988850wrv.26.2023.07.24.06.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:43:04 -0700 (PDT)
Message-ID: <0aeb32068dbd46fe0be6d534e9675be603e22efc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2:init check if path is none
 before calculating checksums
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: belouargamohamed@gmail.com, bitbake-devel@lists.openembedded.org
Cc: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Date: Mon, 24 Jul 2023 14:43:03 +0100
In-Reply-To: <20230721234907.220309-1-m.belouarga@technologyandstrategy.com>
References: <20230721234907.220309-1-m.belouarga@technologyandstrategy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Jul 2023 13:48:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14884

On Sat, 2023-07-22 at 01:49 +0200, belouargamohamed@gmail.com wrote:
> From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
>=20
> Add one more verification that checks if localpath is None, because
> we can't compute checksum of a None.
>=20
> Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
> ---
>  lib/bb/fetch2/__init__.py | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 770021de16..f6e5d19627 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1402,6 +1402,9 @@ class FetchMethod(object):
>          Is localpath something that can be represented by a checksum?
>          """
> =20
> +        # We cannot compute checksums for None
> +        if urldata.localpath is None:
> +            return False
>          # We cannot compute checksums for directories
>          if os.path.isdir(urldata.localpath):
>              return False

What was the situation which produced this error? I'm wondering if we
need a new test case in bitbake-selftest (in lib/bb/test/fetch.py)?

Cheers,

Richard

