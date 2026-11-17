Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13887.1794905902980857379
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 00:58:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=UOLyfWlP;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=nT83gZjs;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.157, mailfrom: paul@pbarker.dev)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 00D421400105
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 03:58:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 17 Nov 2026 03:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794905901;
	 x=1794992301; bh=6NMJ1GLrsB0q74GMK+D5RThy9vialepBoJS3jcYqse0=; b=
	UOLyfWlPn7G4Ls4Ps0+C8XnJ5nN8bqHGGbCX0A2ppV6+VmXCoAu8vqbC+D4HA+Yb
	ppw8ubkjBuntOCUPH8q5I9QK9MOY0+7cVEY/MesXhxo/tgOIWH7SBqixFTFLIVpK
	6Pz+hkP6xt0T1dc1URCJwoVhP08AasiOdN6ZwpjAZwpwBAO++rFG7GVg+7Ob20HU
	0QlU78A2n6d8QRH97XMqUxEOjuCGPtqzp6g8x686RqJCLFHyRKK2iiDw+S4+cVsT
	XT25DhNV7FmoYoA8mnKF86hnQy2Qx4cqyxm9guKsfYL/g2ua3Vi0QM3Ijj7x6XUd
	Ft+u1xPDTfnRoTZ4PCNUlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794905901; x=1794992301; bh=6
	NMJ1GLrsB0q74GMK+D5RThy9vialepBoJS3jcYqse0=; b=nT83gZjsecrHxUMPy
	JE6FykJlK4IZE+OrNrr49Okfb9eMAOBFiKfmQCqxysZ98AHinc3H9FbG+iXhSDYS
	EMcP33y2BzL0n3BEOo+fQd573aGmdBICYKapbOFgiI817j3nXD4FuTtgzgaJ9DeU
	eVb+XBJJb1YuaVu373daPZq2y/vwjjlFiyB5/DX/f2aPFnfm4A2HYq6gj+JJkcuh
	wcxIRODe3AYE3FCx6LTAsJRa6B3wfY3hyA3Wem7/oyeyHn1UAu+ossD+6syA9Cq1
	Qlt76ao/JAxMz/D49zG4UHv0Lj1UPxsuBnS4J2ib8A3GgnQLxbXY4JaoP9xhShgF
	bpDng==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pbarker.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794905901; d=pbarker.dev;
	mf=PHBhdWxAcGJhcmtlci5kZXY+;
	rt=PGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4=;
	s=fm2:rsa-sha256:h9PSQcT/bwQvwURILJlGxqbW7UAGVXsgdt/vqaVhiOOycYK
	16Dhsa0zMhuApKaLLAHeGekeR+QCpeHtQIV9rlEVhZS0BMLPNg968lpqkV1/4jfM
	WqT5oQnATfDPx/P2bASSlFA1iQhGtkcDr9X2E7tpC3FOC7aWC0B5waC2yDLc2WEA
	R3H8/yvQPhqLzXTU+aFvAD9HfWaXTUbMYc7pxpffUBOtXoIylYb/YDFbxeQGV8RE
	Gpxn4bp5tRTQ3LK1XzDh+uE5lIsne5tHn6S+5WorOoIio98Q2ktjZcyS6L2NoXK3
	gSQxWhzsUNe7LY0BANlainbCvpDMGBrYRgk5Q3Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/J9rcRU2sShfObivx5YxpsZp+fMxLBwhw+HhxHMqJDg=:UjwqaDoBKfKt/pF0gADXqacwCPNUJ8fy8XoYqO16q4Y=;
X-ME-Sender: <xms:LRf8aszLWMW6wOGr8CdZvn_6lTpODN4NfSKVUynXl_nHIrtNlXOytA>
    <xme:LRf8amSti24pjccpVsDk47YrXttSlo90l0Aq8ZZiqoqFbYzQff4_quzxL-cSQRh6b
    CXEx9STtIq31jXPL9GQQTlxGAM88G4YiicUrCfXjfWmXKonEnVFVod7>
X-ME-Received: <xmr:LRf8ar-huVMYt-NnEYAYFSxt0dxw42V2Rkor9rSmrBA-bCEopbsxF5bJpW1FHQJ4pReiqnMmAbmS_dX9_SQYzmEAnG8g>
X-ME-Proxy-Cause: dmFkZTEe5iSoketnKAIFDhMPnjaPCyB7qQrSMdzhNh02saWxmy3uxkPeBiuZJOigV2onRJ
    7o9MX3O6IE7I80AiSxK6iH0TLOCPRDwQ3LRRoMyYUDYxdzAYTC8DOWpE8xZw2Y94PHuUCO
    iD/8L0cOMdmucG1K4ixWMI5un5kZHokE/W9XdMJyxOrNvMX10N5EobVzE6bnrpJYytib+T
    svv3hh2/h9X3rXH+gXT9ljUwH86g4Ian38JM97Gb9RAovLXrU6Ap1cmAlRgSEj5M4KyUCF
    /fpDcYKhFZnBAvfpmK2nk2NqYFjf1c02uM1o0ouiz32Z+Ax44lE6YxQImrdW4dJCjMVNq3
    PM1ZCh8HAzD3eX11kmvN6ujJP9Pmn4EQU1bVuWSbMsVm7FJYnE85n7QKlVoaoA/R7CUweg
    ppkfCOsH4KBhzsQhQKpdFzI5j+xjWMbR4RDxbpO7TxWQzRVioc2P2ej5DFtvIS1mni8jT0
    2bv37hPH7t7XyHMsJJC6CFYDeyUwXCQc3isIqb491tXEywkT0ZLv+sJ+DnKnBwSEUXW/Yt
    zDZKU07XB2eOyURj2WyfMzWzNrPC2bLTzlwfqanb+pGFXonzuwS7T4lcvZ3aUWgrJFPerO
    tFLqCLazs9CNwiJ5T3ivqCLu2O9Jd2bKxptL8f4bMgDfTRnnbjhr+kYYkpWw
X-ME-Proxy: <xmx:LRf8alrBSVPysbc6I0w18VvQ1Mj2WIhCQ09v6kKQih5BExnnvKa4qQ>
    <xmx:LRf8agmt3O67crjgMksaDHxEm3z3Z1Kq_ogEySD0_rP3SClh458LmA>
    <xmx:LRf8akKuT-frCdpgPuAL3B8n-3dI1vsHRiRPOVvV2qb91XS9qF2dsA>
    <xmx:LRf8atww6c-cC-x08d7ovbTX_rMQTqu796tXQy98QYDYalRMyTcyFg>
    <xmx:LRf8alJDiiI4qH5DU7VuFOfwiRq1P0r5Nu9-X0nEh4UK5U5isUp3Hole>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 03:58:21 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 08:58:20 +0000
Message-Id: <DMXD1FDZAIFH.170S6L7DXU6FC@pbarker.dev>
To: <ecordonnier@snap.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2 2/2] fetch/wget: Reuse the checkstatus() urllib
 opener
From: "Paul Barker" <paul@pbarker.dev>
X-Mailer: aerc 0.22.0
References: <20260928125051.2483039-1-ecordonnier@snap.com>
 <20260928125051.2483039-3-ecordonnier@snap.com>
In-Reply-To: <20260928125051.2483039-3-ecordonnier@snap.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 08:58:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20443

On Mon Sep 28, 2026 at 1:50 PM BST, ecordonnier wrote:
> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> checkstatus() builds a new urllib opener with its redirect, proxy and
> connection cache handlers on every call, although sstate.bbclass calls it
> for every object in an sstate mirror check with the same settings. Keep
> the opener on the FetchConnectionCache, keyed on the certificate checking
> setting and the fetcher environment, and rebuild it only when those
> change. A connection cache is only used by one thread at a time, so no
> locking is needed.
>
> Checking 2,114 objects on the Yocto sstate mirror with BB_NUMBER_THREADS =
=3D "8"
> reduced the time to task execution from 26.9s to 25.1s on average.

This is about a 7% performance improvement, so would be good to have.

The question is, what state do the urlllib opener and the handler
instances maintain across requests? Is there risk of credentials or
headers intended for one host being inappropriately sent with the
request to a different host?

Someone needs to look at this and confirm that it doesn't introduce any
security risks.

>
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  lib/bb/fetch/__init__.py |  2 ++
>  lib/bb/fetch/wget.py     | 22 +++++++++++++++-------
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
> index 55ab710f3..0eb660685 100644
> --- a/lib/bb/fetch/__init__.py
> +++ b/lib/bb/fetch/__init__.py
> @@ -2090,6 +2090,8 @@ class FetchConnectionCache(object):
>      """
>      def __init__(self):
>          self.cache =3D {}
> +        # urllib openers built by the wget fetcher, see Wget.checkstatus=
()
> +        self.opener_cache =3D {}
> =20
>      def get_connection_name(self, host, port, connection_id=3DNone):
>          if connection_id is None:
> diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
> index fe2de25d3..9cb4a4f32 100644
> --- a/lib/bb/fetch/wget.py
> +++ b/lib/bb/fetch/wget.py
> @@ -435,13 +435,21 @@ class Wget(FetchMethod):
>          # to scope the changes to the build_opener request, which is whe=
n the
>          # environment lookups happen.
>          with bb.utils.environment(**newenv):
> -            context =3D self.ssl_context(d)
> -            handlers =3D [FixedHTTPRedirectHandler,
> -                        HTTPMethodFallback,
> -                        urllib.request.ProxyHandler(),
> -                        CacheHTTPHandler(),
> -                        CacheHTTPSHandler(context=3Dcontext)]
> -            opener =3D urllib.request.build_opener(*handlers)
> +            opener =3D None
> +            if connection_cache is not None:
> +                opener_key =3D (check_certs, tuple(sorted(newenv.items()=
)))
> +                opener =3D connection_cache.opener_cache.get(opener_key)
> +
> +            if opener is None:
> +                context =3D self.ssl_context(d)
> +                handlers =3D [FixedHTTPRedirectHandler,
> +                            HTTPMethodFallback,
> +                            urllib.request.ProxyHandler(),
> +                            CacheHTTPHandler(),
> +                            CacheHTTPSHandler(context=3Dcontext)]
> +                opener =3D urllib.request.build_opener(*handlers)
> +                if connection_cache is not None:
> +                    connection_cache.opener_cache[opener_key] =3D opener
> =20
>              try:
>                  parts =3D urllib.parse.urlparse(ud.url.split(";")[0])



Best regards,

--=20
Paul Barker

