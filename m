Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4676BCD37BE
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 16:14:02 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.54422.1778516039317379328
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 May 2026 09:13:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dG8l44iv;
 spf=pass (domain: gmail.com, ip: 74.125.224.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65db820588aso1118858d50.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 May 2026 09:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778516038; cv=none;
        d=google.com; s=arc-20240605;
        b=M6OzGmiNYlmmMt+bQUfRVsFW59S898psHc1++sCuIxEeukPcsE1x+LhGr3zERRjXmj
         Hr6zNgLh0hbpOqvfuDVc7KrzhV4EURoCGtmbNYC/iTSyQcnH87tWaXN96RTHYMAJll3U
         nsTrf+tQNNWT24t5fM+RZY/rRy5zvIqAg9nF4O8v5/1ybjaJ9Ftd10pD1vpp6FqJTBCc
         HOv40fD9wrGHTRKxa41+cUt30NTOafTnvCUUDwmbLMCruSG79evus88dBonTveUxGOEv
         PBRe8gktdI2FozZlYyaMaRx4hpbQNEvUJ8B42lzw/oXys4L0LQ44TU0Fv3jKclj+tbBS
         CsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WN1y20Kp6loELV36l59ssh1DtI4x2epm+OMi2MoBuYQ=;
        fh=CXP6ezNhZ2dwV30j1TErAxvqUUUhI3me3DSdqP20/oA=;
        b=TSSwU6wdqQln2yvdx1NRVFXaWNDDvOCKUs/VoZjUE2vjmkoklG87ZCbIyybwczmvly
         K8LDbgIi2RIIG8RcD9KaGIAAD5kQFkuf82dAUwVCe66tiCbiNdito+JlKzWaomyzYLU1
         tc6F4IUl2Se5IZeDnNygStSo1gSlQCP1gG8GxotAdDTGExL2t51xBpGcRbnx2pfKJbD4
         pQ3sKFNIJzu9ETDxuCreyW12LMzQFDm6c1CuZ6ibF5EspecpeXocBnUXd1keHFPufIbc
         85hTsxiXxz+JGH4Q3vWqhdhTTyt++UDYNfkZC+4k8bwiGTMcVuc4CX5J4s1LeLJ1Lgye
         9hDA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516038; x=1779120838; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WN1y20Kp6loELV36l59ssh1DtI4x2epm+OMi2MoBuYQ=;
        b=dG8l44ivs9jEZtYk8hKQccP41aaWRRWS6VrqkXMZWRsKzktmaPqMPd5Q4sXR/ShxIV
         8Ddka4cg+fkIGHnrHE67H2EVI369wUhZQInt1zXUY9PiFB18+gAcDB48WIoClojiJSS+
         bUz0SqGRH63DxgcmzSbCAUi+VDRnq3bNZRyvXM4CmKxHsA1audDSVuCvB1AZmAe4Ddea
         FBGKjPvx2YVAhmZTI+Dywl0skG8olXKPIwuvQkkms1hptbCMBYy6uz645PBkIMRLLnTl
         LKLNNC48tVNYSEjqR2TRRAN3EMecjkcD2+pjPK8tF+2q1XCU9ZrGG4Pn2v1xIH+zEuep
         oXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516038; x=1779120838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WN1y20Kp6loELV36l59ssh1DtI4x2epm+OMi2MoBuYQ=;
        b=LpVyWkA9UD5OUEZuxZXlR1yPNrFp+4wNqWrHlxgi4sF77wg1kGBMQr4L1g0M/MUPKO
         cungR0pdmP5ah1mFGA5hdZTnKf5qv8jvwSGHP3QwMuDzFRpN3HBaGQN2IiVJOVMbDbAL
         pEwCGfXPfggwQrFw9TZLp9pLN2b3dqbLnJlLNRFXosFYIBEbRpm3komrDkBGo42mUJxZ
         +2vD7z60iAW0duimLbFclMrTwAW30KCVQ5c4xNFg7Z30lSYUhbACqPOWGNGjDD1O5Te4
         L3BzEdrQ0oR5qwo3BoZuCXZMLpo1tPrNstHRuvN2xvDOIM22sCmZ8AGV4ibaAJXFo9MX
         1LxQ==
X-Gm-Message-State: AOJu0Yw4QgNoDMPLYAkmJ6TPqGYKdRMQ0gPN0IUFI04O/b2MiC6OATBT
	qJ83V9PEaD+zIE+kl0k/3LnAdxUkmif9xBvy+Q91k0x/83PMhR9dsfQv87QESRX/rbhvOlWuNN9
	rnsMyYNBl+BZ2mwryGOsP6oZJbnlszZ0=
X-Gm-Gg: Acq92OFLTDzBt55r47NhKk6y6Fybi24sjOJapol8zv4xKwhZI3NVaLbsqNEszMk1IDU
	IncF9peXH2GGO/uHHmjeg3+iJYxjJUJpYky2yu0oIjPilwlCVEog2u8iTf8jSA6H8vaJjdGTXux
	96JqDazzPdNCe2ke7Ujuhz9rr4F7Twz/9VIT8l+nXkN58aj+wEhOTxvjR3lh5pw3jpESPZgTC6S
	z4JPMRZOEWkfGO7M77KgDhpYjyEo0de1yKH2/ezghfI/+7ZrP+tOyRBnje6zm0oZcadJ2Fxfjk1
	SDAQc0oM7gWOFpfWFWQ+uQ==
X-Received: by 2002:a05:690e:480f:b0:651:cc5e:b8d7 with SMTP id
 956f58d0204a3-65c799387c2mr16381228d50.22.1778516038160; Mon, 11 May 2026
 09:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260506123755.628267-3-corentin.guillevic@smile.fr>
In-Reply-To: <20260506123755.628267-3-corentin.guillevic@smile.fr>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 11 May 2026 10:13:47 -0600
X-Gm-Features: AVHnY4JoAtJvBkpJirYIpU14FliIXTq1T49ecDDGCXdlQY9EftbUZ8K8tINH3sI
Message-ID: <CAJdd5GbH8J=LS0JLEYnb=BgTd6hPtFQfzgsMd=kFxb4_EcqhcQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3] cooker: limit the execution of the
 hashequiv client/server ping
To: corentin.guillevic@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 May 2026 16:14:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19494

On Wed, May 6, 2026 at 6:40=E2=80=AFAM Corentin Guillevic via
lists.openembedded.org
<corentin.guillevic=3Dsmile.fr@lists.openembedded.org> wrote:
>
> From: Corentin Guillevic <corentin.guillevic@smile.fr>
>
> The ping method is used to test the connection to the hash equivalence se=
rver.
> However, if the server is unavailable, the bitbake server has to wait sev=
eral
> minutes for the system to terminate.
>
> While waiting for a response from the hash server, the bitbake server doe=
s not
> provide any feedback to the bitbake client. The latter then closes the li=
nk and
> fails with the error:
>
> Timeout while waiting for a reply from the bitbake server (60s at 09:50:1=
5.377337)
>
> Adding a timeout to the ping step allows quicker action when a remote ser=
ver is
> unavailable, and prevents disconnection of the client due to timeout.
> The default timeout is 10 seconds, but this can be set using the
> BB_HASHSERVE_UPSTREAM_TIMEOUT variable.

There is already a 30 second timeout in the async client code; is
there a reason this timeout isn't working? If it just needs to be
shorter, it would probably be better to allow that timeout to be set
from a variable. While I do agree that the timeout should be
adjustable, I don't really want to make it specific to just the ping
API.

>
> Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
> ---
>
> Notes:
>     Changes in v3:
>     - Fix TypeError exception when BB_HASHSERVE_UPSTREAM_TIMEOUT is not d=
efined
>
>  .../bitbake-user-manual-ref-variables.rst             | 11 +++++++++++
>  lib/bb/asyncrpc/client.py                             |  4 ++--
>  lib/bb/cooker.py                                      |  4 ++--
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 9824b58ef..cce03bc0c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -511,6 +511,17 @@ overview of their function and contents.
>
>           BB_HASHSERVE_UPSTREAM =3D "hashserv.yoctoproject.org:8686"
>
> +   :term:`BB_HASHSERVE_UPSTREAM_TIMEOUT`
> +      Specifies the duration (in seconds) for which BitBake waits for th=
e first
> +      response from the upstream Hash Equivalence server (specified by
> +      :term:`BB_HASHSERVE_UPSTREAM`).
> +
> +      This variable prevents BitBake from waiting too long for an unavai=
lable server.
> +      If the time expires, the upstream Hash Equivalence server will be =
skipped for
> +      the build.
> +
> +      The default value is "10" (seconds).
> +
>     :term:`BB_INVALIDCONF`
>        Used in combination with the ``ConfigParsed`` event to trigger
>        re-parsing the base metadata (i.e. all the recipes). The
> diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
> index 17b72033b..5e2505494 100644
> --- a/lib/bb/asyncrpc/client.py
> +++ b/lib/bb/asyncrpc/client.py
> @@ -199,8 +199,8 @@ class AsyncClient(object):
>          self.check_invoke_error(result)
>          return result
>
> -    async def ping(self):
> -        return await self.invoke({"ping": {}})
> +    async def ping(self, timeout=3DNone):
> +        return await asyncio.wait_for(self.invoke({"ping": {}}), timeout=
)
>
>      async def __aenter__(self):
>          return self
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 4b6ba3196..128cbaee9 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -342,7 +342,7 @@ according to https://docs.yoctoproject.org/dev-manual=
/hashequivserver.html""".fo
>                  if upstream:
>                      try:
>                          with hashserv.create_client(upstream) as client:
> -                            client.ping()
> +                            client.ping(int(self.data.getVar("BB_HASHSER=
VE_UPSTREAM_TIMEOUT") or 10))
>                      except ImportError as e:
>                          bb.fatal(""""Unable to use hash equivalence serv=
er at '%s' due to missing or incorrect python module:
>  %s
> @@ -352,7 +352,7 @@ Please install the needed module on the build host, o=
r use an environment contai
>   - or set up pip venv
>  You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may resu=
lt in significantly longer build times as bitbake will be unable to reuse p=
rebuilt sstate artefacts."""
>                                   % (upstream, repr(e)))
> -                    except ConnectionError as e:
> +                    except (ConnectionError, TimeoutError) as e:
>                          bb.warn("Unable to connect to hash equivalence s=
erver at '%s', please correct or remove BB_HASHSERVE_UPSTREAM:\n%s"
>                                   % (upstream, repr(e)))
>                          upstream =3D None
> --
> 2.51.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19445): https://lists.openembedded.org/g/bitbake-deve=
l/message/19445
> Mute This Topic: https://lists.openembedded.org/mt/119177877/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

