Return-Path: <yann.dirson@vates.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D77CA5FFC
	for <webhook@archiver.kernel.org>; Wed,  7 Oct 2026 13:06:15 +0000 (UTC)
Received: from prod-mta-13.swg-srv.net (prod-mta-13.swg-srv.net [185.255.28.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9131.1791378370771338575
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Oct 2026 06:06:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@vates.tech header.s=selector1 header.b=YTYUGmvA;
 spf=pass (domain: swg.vates.tech, ip: 185.255.28.18, mailfrom: prod-mta-13.8631fc262581453bbf619ec5b2062170.1a1167895fa0003f66@swg.vates.tech)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 q=dns/txt; s=selector1; bh=/ggt3hA5Ki9ptjcq3nZY1in7+nY1H/XpBXhI/u0ZIR8=;
 h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:references:feedback-id;
 b=YTYUGmvAHFDsHLmFH203bcUz34C91wcIice+a76aVm6CHzkOY7y0gBF9FsGW+ZViFbnKpjSqY
 JQ01wf9/hQIT2HgSMvG95UYE3ocIuEU4YWHRc35RYxcGBKBqz5N6vV1+VDv71zSQS9PToKx+lQi
 4wfRdWb2Oc/yEegQqtmey2vZFWTt0uNz5jllvYb8WnfAPtCXXFbWUf4TWGDdSKkD8ww5h/J2Jut
 AWo7CL+b4OVObmrY570m+g1m1xGb4jSihTkas4sIstk4DbCidUHcYIBSJVp0FLB338Ng/B8nVh1
 4ueemRVWvrHithUthViHH6lg7xr5PPoXu5kQX0p+nUdw==
Received: from mail2.vates.fr ([37.26.189.201] mail2.vates.fr)
 (Authenticated sender: 8631fc262581453bbf619ec5b2062170/smtp/7773de5a-2839-4720-82ee-e06722ae1d3e)
 by prod-mta-13.swg-srv.net (ZoneMTA - prod-mta-13) with ESMTPSA id 1a1167895fa0003f66.001
 for <bitbake-devel@lists.openembedded.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 07 Oct 2026 13:06:03 +0000
X-Zone-Loop: 0d4c788f08f0fa3aa18fa46cc76789d24cc6130f09a9
x-campaign-type: default
x-transaction-id: 83ff48dc-e0c1-446c-a0ce-38dfad6090cb
x-swg-uid: 01-01e2b8f3-6fbb-4e98-bc08-169641737113
X-Mailer: Sweego
Message-ID: 
 <1791378363.8631fc262581453bbf619ec5b2062170.1a1167895fa0003f66@vates.tech>
x-swg-bid: 1791378363.8631fc262581453bbf619ec5b2062170.1a1167895fa0003f66
Feedback-ID: default:8631fc262581453bbf619ec5b2062170:Sweego
x-campaign-id: default
x-client-id: 8631fc262581453bbf619ec5b2062170
X-Originating-IP: [37.26.189.201]
Received: from [10.137.0.41] (88-161-245-20.subs.proxad.net [88.161.245.20])
	(Authenticated sender: yann.dirson)
	by mail2.vates.fr (Postfix) with ESMTPSA id 0F8EC80AF6
	for <bitbake-devel@lists.openembedded.org>; Wed,  7 Oct 2026 15:06:03 +0200 (CEST)
Date: Wed, 7 Oct 2026 15:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] parse: add a (failing) test for a variable override
 with capital letters
To: bitbake-devel@lists.openembedded.org
References: <20261007125138.59937-1-yann.dirson@vates.tech>
Content-Language: en-US
From: Yann Dirson <yann.dirson@vates.tech>
Organization: Vates
In-Reply-To: <20261007125138.59937-1-yann.dirson@vates.tech>
X-BM-Disclaimer: Yes
Content-Type: multipart/alternative; boundary="-=Part.6ec.2ba128934473f10.1a1167892e4.fb3bd38c60599d99=-"
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1791378363108
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Oct 2026 13:06:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20305

---=Part.6ec.2ba128934473f10.1a1167892e4.fb3bd38c60599d99=-
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Both patches are meant for both master and 2=2E18=2E

On 10/7/26 2:51 PM, Yann Dirson wrote:
> Signed-off-by: Yann Dirson <yann=2Edirson@vates=2Etech>
> ---
>   lib/bb/tests/parse=2Epy | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>=20
> diff --git a/lib/bb/tests/parse=2Epy b/lib/bb/tests/parse=2Epy
> index 6ac2137e0=2E=2E9fc094b16 100644
> --- a/lib/bb/tests/parse=2Epy
> +++ b/lib/bb/tests/parse=2Epy
> @@ -150,6 +150,27 @@ exportD =3D "d"
>           self=2EassertEqual(d=2EgetVar("exportD"), "d")
>           self=2EassertIsNone(d=2EgetVarFlag("exportD", "export"))
>  =20
> +    mixedcase_pn_override =3D """
> +PN =3D "${@bb=2Eparse=2Evars_from_file(d=2EgetVar('FILE', False), d)[0]=
}"
> +OVERRIDES =3D "pn-${PN}"
> +RPROVIDES:perl-ExtUtils-MakeMaker =3D "base"
> +RPROVIDES:perl-ExtUtils-MakeMaker:append:pn-ExtUtils-MakeMaker =3D " te=
xt"
> +"""
> +
> +    def test_parse_mixedcase_pn_override(self):
> +        # Recipes named after CPAN distributions have mixed-case PNs, s=
o
> +        # OVERRIDES contains a mixed-case pn-${PN} entry=2E An operatio=
n
> +        # guarded by that override must still be applied=2E
> +        with tempfile=2ETemporaryDirectory() as tempdir:
> +            recipe =3D os=2Epath=2Ejoin(tempdir, "ExtUtils-MakeMaker=2E=
bb")
> +            with open(recipe, "w") as f:
> +                f=2Ewrite(self=2Emixedcase_pn_override)
> +            os=2Echdir(tempdir)
> +            d =3D bb=2Eparse=2Ehandle(recipe, self=2Ed)['']
> +        self=2EassertEqual(d=2EgetVar("PN"), "ExtUtils-MakeMaker")
> +        self=2EassertIn("pn-ExtUtils-MakeMaker", d=2EgetVar("OVERRIDES"=
)=2Esplit(":"))
> +        self=2EassertEqual(d=2EgetVar("RPROVIDES:perl-ExtUtils-MakeMake=
r"), "base text")
> +
>       overridetest =3D """
>   RRECOMMENDS:${PN} =3D "a"
>   RRECOMMENDS:${PN}:libc =3D "b"



-- 
Yann Dirson | Vates Platform Developer

XCP-ng & Xen Orchestra - Vates=
 solutions

web: https://vates=2Etech
---=Part.6ec.2ba128934473f10.1a1167892e4.fb3bd38c60599d99=---

