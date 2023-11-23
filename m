Return-Path: <ceggers@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A23C5AD4C
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 12:22:47 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.100])
 by mx.groups.io with SMTP id smtpd.web10.89413.1700742154681808270
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Nov 2023 04:22:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arri.de header.s=selector1 header.b=AKGfkopg;
 spf=pass (domain: arri.de, ip: 40.107.247.100, mailfrom: ceggers@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sebpz3mjjGEe9j1rx7+z1AsXaaKtHoFcUtTXuKUpzfLYp3ooISuJL9DL4cHYXUICO3ge+iPwOs0Z+axO+IyI2FzxIbu+WwbsUKZs4PuaWDxxfswhRVWFdOwLkrmn1fbC6sDHxy37rWUmvcvbIKN98c2v21AdfkJgxff9ITMmOAL8WTclL7LcJb9smOWrnChRdbmZ5UUS1qoowGuGSJHo3AJ0qY5EVbL0L+B7P5AUqafjqnomdlMDCt4wiImGvG0sQcG52B2aHP15qyK5j2u7CznlgycRx+h5Tjp4TmqBgfrMoEU7xP9r/CrItqODgVNRFQguIsCeJQo+y9zOEWxr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9VcQWEItRYP8Csh90++8EM7mWrVQJslvvn9TCbrTVc=;
 b=cL2E3tqdgRdpT9cJ3w5ABr4bX1Ed1xB7H2QFkg0xm0Z0QsoecRZy7aNZH6DiNIpoxRM9Q2zDQBGY3jnuPF8AfH5S/jffmb+i2uLVTpF/msfTMrLefwmW8faRxZ8/0TbgLJ9XMIcz//yrd3+xV5bMXpebtPrPkjywknOya4BJy8HH9Lik0si2ndHop/12QG2y/iEUW9xGCqMD08SGgfeU1dglF8YmBd3nZ5gsGwUbeJqsscFvzTq5dWB44zMhgmg4wrt4mKC+hQ8nigeHD8s7xGpubB8RDlVuh6mEFti/QBjD6rtzYBSoHDa2BndIKE9jBEvukbedIj/tlbzHPOTxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.169.0.179) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=arri.de;
 dmarc=bestguesspass action=none header.from=arri.de; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9VcQWEItRYP8Csh90++8EM7mWrVQJslvvn9TCbrTVc=;
 b=AKGfkopgBB2x1pQxaQQb+55Hf3g+fA55lISiyf6z8DrAsrkH7aG4ZflfiodcO09mgkqsD5VnqtKcAgasL18P9mO0pbNMS4CdGVEsoPc9IIoITM+/dOLheDEO7CDDbDbyp1ffTvxQyYSwKGJ2iK0y8wOs0KDfD4KqUCJIO+KvJs0=
Received: from DB9PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:10:1da::25)
 by AS8PR07MB7909.eurprd07.prod.outlook.com (2603:10a6:20b:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 12:22:30 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::82) by DB9PR05CA0020.outlook.office365.com
 (2603:10a6:10:1da::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Thu, 23 Nov 2023 12:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.169.0.179)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net; pr=C
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 12:22:27 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.51)
	 by eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Thu, 23 Nov 2023 12:22:29 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 28788956
X-ExclaimerImprintLatency: 4046094
X-ExclaimerImprintAction: 22bec85142124d96aa4b3815fa39a7be
Content-Type: multipart/related;
	boundary="----_=_NextPart_76f81d9a-9afe-43aa-8a7d-52dd34b161fc"
Received: from AS4P195CA0033.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::20)
 by AM8PR07MB7361.eurprd07.prod.outlook.com (2603:10a6:20b:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 12:22:24 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:20b:65a:cafe::cc) by AS4P195CA0033.outlook.office365.com
 (2603:10a6:20b:65a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Thu, 23 Nov 2023 12:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.3 via Frontend Transport; Thu, 23 Nov 2023 12:22:24 +0000
Received: from n95hx1g2.localnet (10.30.5.31) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Nov
 2023 13:22:23 +0100
From: Christian Eggers <ceggers@arri.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: Alexander Kanavin <alex.kanavin@gmail.com>,
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Keeping STAMPS_DIR between CI builds?
Date: Thu, 23 Nov 2023 13:22:23 +0100
Message-ID: <8327916.T7Z3S40VBb@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <e850b68b1b7c3a6eac139f5b72b19b2868531ee7.camel@linuxfoundation.org>
References: <3556314.iIbC2pHGDl@n95hx1g2> <1994066.usQuhbGJ8B@n95hx1g2> <e850b68b1b7c3a6eac139f5b72b19b2868531ee7.camel@linuxfoundation.org>
MIME-Version: 1.0
X-Originating-IP: [10.30.5.31]
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: 
	AM4PEPF00025F97:EE_|AM8PR07MB7361:EE_|DU6PEPF00009524:EE_|AS8PR07MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e20ca39-3187-49b4-a6ee-08dbec1edc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 EUvuVquLWnWopz/VVLdJp2kAaxbQT/0DSiTq8zXvl281TbbzsGBaFIpdKFAKFkzt97t5l0gP088WJCg1z1mNppgize5LB9oiteXGynfHWUv/bgbNGh/u8yqizYNQetF2QTyw0+v7COITDLpX6t7bWo4zw5zTbw+vMUxtIasNxaRB6Z3EfjqmgKor1kE5S6NxiUdUZtJN2mEoqJWkNGnAX6iLSghwbIG/wX56kYIVIIxj+gehEbSknUd6q/8FE9/X1lMWr0mNjNMmj/DbAJykFepv0cS1p3vPYgLPP3vkL/tK07Ndf2/tn4i3Bisk/aexz7PQXO0BxcmwCXrRXTUtwuYD+UVLJ/p22JHMs3P3lizsjTrLjcKrZzHLUvm00OIs+u/8mR/gin8jqIyWhPuv2WupPh4orfbhUUdiYxrzIQ6KDDKGlXiV2cRYTxJs/ORrPcwfwzOPvZbpUbZywixfEMK0zb1lMk3ySFQGbJK1QJV2RdXz2xk6YJ6XT1EgdPwjEiN3uTH+L9MV4IbsrMPobU7V7RX71hrCaD5sLxL2qSterOXJclCgDxEbO0qqw5mZxWxym0RXvWwz3dwH4C0yRDzbRGph+BIImssLMIunzqpCD18iwEGOfgvjV/TzNpBrrfWAXyAmig1kcOPlSeTMncisgddcXexJA2mNd8EaectVV89gLsK8MEi2skaRM6WAOSEAVec9dQrxhVleCf85qU90mk8CoWVTLr0iBp4+vjw61KVK79BQhhtBZZhOMa7aLtj2BYQLkcASvXIaO9D6eb3QAH8oAc5Yx1K6hRrG43U=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:217.111.95.7;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(336012)(82740400003)(426003)(478600001)(83380400001)(966005)(26005)(33716001)(36916002)(9686003)(40480700001)(16526019)(8936002)(8676002)(316002)(70206006)(54906003)(4326008)(70586007)(356005)(6916009)(47076005)(36860700001)(5660300002)(81166007)(9576002)(2906002)(41300700001)(4001150100001)(86362001)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7361
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	c3f518da-c615-4f32-3526-08dbec1ed97a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XqOBIhPOgOFXaYWJ7cqBIMfbeDSXckhqhRjYDmelMK6TgYTrirpFKbya61LJn4BYA3gVqPBK0jvriIBhnkMABbJwDsVAXG/GHvELbXhqmh7+8uMjnbZ/Ti1fHVm0NSRnOtpvBjDDYbczHPuoau7/6+qMAFSXLkKvY+f/gkJdiv4F4Tq0EIvje2mcvxyQk8nKpr3wuvXO7hJ4Yvix+d4G0t/b69DGRaO63CoOHCRyn3r36Tcy1k9SruFdE1qoWaqeUqeRqGCdDtLYZjqzih8uqi2yKfcz2AYzEDtfQAr2ItSMwIOvhnz4oKpCPoKB8QQfvi+8ZxctM1mIL28BpN/jCv0KmrcHU9SiuzVuCWKCzYBqYwPsA2lFT7Y/wlegbQUlcrLiiLJx/9evObAHqKMDlgFC1XC5Uw5aeq7UIySVN+Ue8OwO+4EjW5OvGOC7LFRL0rLvnQK/1V5S7zoeTg03MDuvd5zp7LhisBTfcboMktqXSBoRE4ls8g+pzO2LOKZ7yqGwmesclVGdT9tqBswER5QbPkNja2kfe4lWi3+uR2FZHOwMap/85kSp2PpzukQR0aKhNmwttTZS2VszFzsHEjSEtu2hOoi74BHlr7Ofw8JxhQ5ukXZWakZh2NzI+17a8jSgZB0BntdtbrvHw7xZ4QuetPfuMg6oStLNE3o7PycG+QkaZ6J7Z1AMUczt/11kjm3pHtjBlHeolGRxS7TV6EFKUpRywKTDcQBEriJ5E8RDoyCtr1XAooZGbzrAsGoLD+knv1Wb5yN39sCZYD4VeLywzxNOO5heLlNPbpmU6soAQKnuGq5sexA9yUL2koGHWs+aOMSev50TRHAiNEDguUUwfVeglWebBVDEeI43p05gG9U+57Xiy3H2bKNJFN4X5Nqd7UjHni5DPuN66uhnkQ==
X-Forefront-Antispam-Report: 
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(82310400011)(1690799017)(186009)(7200799017)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(8936002)(4326008)(8676002)(40460700003)(166002)(54906003)(6916009)(41300700001)(316002)(70206006)(70586007)(5660300002)(33716001)(2906002)(30864003)(66574015)(426003)(336012)(4001150100001)(82740400003)(83380400001)(9576002)(15974865002)(26005)(16526019)(7596003)(7636003)(36860700001)(47076005)(86362001)(9686003)(45080400002)(40480700001)(36916002)(33964004)(966005)(8400799017)(478600001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 12:22:27.0992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e20ca39-3187-49b4-a6ee-08dbec1edc8a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7909
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Nov 2023 12:22:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15566

This is a multi-part message in MIME format.

------_=_NextPart_76f81d9a-9afe-43aa-8a7d-52dd34b161fc
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_eaada676-d7be-4818-a2aa-6424c379dcd4"

------_=_NextPart_eaada676-d7be-4818-a2aa-6424c379dcd4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Richard,

On Wednesday, 22 November 2023, 23:11:02 CET, Richard Purdie wrote:
> On Wed, 2023-11-22 at 12:36 +0100, Christian Eggers wrote:
> > On Wednesday, 22 November 2023, 12:22:52 CET, Alexander Kanavin
> > wrote:
> > > Your description shows that everything works as intended. If
> > > something
> > > needs artefacts in ${B} then do_compile has to run at least once to
> > > populate ${B}. Preserving ${STAMPS_DIR} would clash with that and
> > > isn't
> > > going to work. And do_compile isn't sstate-enabled, so there's no
> > > shortcut
> > > that way.
> > 
> > that sounds like not every task's output goes to the shared state
> > cache (is there documentation about this?). As do_compile doesn't go
> > to cache, all previous tasks (also not cached?) have to be rerun.
> 
> SSTATETASKS gives a hint about which ones write to sstate. It doesn't
> make sense for everything to go there as the computation to recreate
> some things is similar to that of storing it, or storage is large and
> not often used, therefore not cost effective.
> 
> > Would it make sense to put the result of do_compile into the cache
> > for my particular recipe?
> 
> You could create an sstate task which stored the binary, which would
> work out very similar to the way do_deploy works. do_deploy would be
> the simplest example we have.
> 
> I would caution that sstate tasks aren't "easy" and the system does
> have to have knowledge of when to run dependent tasks and when not to
> so there are complications in making them work accurately. It isn't
> documented for that reason.

although I have been warned, I couldn't resist trying to add the
do_compile task of my recipe to the sstate cache after finding the docs
here:

https://docs.yoctoproject.org/overview-manual/concepts.html#shared-state

But adding do_compile seems to eat children, I got error messages like 

ERROR: myapp-3.0.12+gitAUTOINC+c80b310bcd-r0 do_prepare_recipe_sysroot: The=
 sstate manifest for task 'kern-tools-native:populate_sysroot' (multilib va=
riant '') could not be found.
The pkgarchs considered were: x86_64, x86_64_opensuseleap-15.5.
But none of these manifests exists:
    /build/devel/tmp/sstate-control/manifest-x86_64-kern-tools-native.popul=
ate_sysroot
    /build/devel/tmp/sstate-control/manifest-x86_64_opensuseleap-15.5-kern-=
tools-native.populate_sysroot


After having learned that only do_package goes to the cache, I tried to
squeeze my do_stamp task between do_package and do_package_write_ipk:

do_stamp() {
    [ -f myapp.orig ] || cp myapp myapp.orig
    # Retrieve original section size
    ${OBJCOPY} --dump-section VERSION=3Dmyapp.version myapp.orig
    SIZE=3D$(stat -c '%s' myapp.version)
    # Update section (ensuring the same section size)
    echo ${SW_VERSION}-${CI_PIPELINE_ID} > myapp.version
    truncate -s ${SIZE} myapp.version
    ${OBJCOPY} --update-section VERSION=3Dmyapp.version myapp.orig myapp
    rm myapp.orig myapp.version
}
do_stamp[dirs] =3D "${PKGDEST}/${PN}${bindir}"
addtask stamp after do_prepare_recipe_sysroot do_package before do_packaged=
ata

I am not sure whether this will hit back like a boomerang some day later, 
but first tests seem to be promising. I needed some tries to figure out whe=
re
exactly (image, package, packages-split) I have to apply my "binary patch".


> Regardless, keeping STAMPS_DIR around is a really bad idea unless you
> really know what you're doing.
> 
> > > I'd suggest that instead of embedding any build id data into the
> > > binary
> > > from its recipe, you can do the same step when building the image.
> > > There
> > > are hooks for this, e.g. ROOTFS_POSTPROCESS_COMMAND.
> > 
> > Of course this is much more straight forward (and what I already do).
> > Be for
> > some use cases (automatic testing), we handle with individual IPK
> > files / executables
> > rather than with complete rootfs images. For this use case it would
> > be helpful
> > if the application could "identify" itself.
> 
> You could embed the ID into a file in the package instead of the binary
> itself but that doesn't solve the individual binary challenge. You
> could record the checksum of the binary and have a mapping maintained
> the other way?

I think this is what GNU build-id already provides (which would also be
compatible with reproducible builds). But most of my team voted for having
the version and CI id inside the executable. 

In contrast to putting these into the rootfs (either by a post rootfs hook
or by a separate package), embedding the version information into the execu=
table
covers both, CI builds (by bitbake) and local builds (SDK + cmake).

regards,
Christian




_______________________________________________________
Christian 
Eggers
Software Engineer
=E2=80=8B
ARRI
Arnold & Richter Cine Technik GmbH & Co. Betriebs KG 
Arriweg 17, 
83071 
Stephanskirchen
www.arri.com 

+49 8036 3009-3118
CEggers@arri.de

=E2=80=8B
Get all the latest information from www.arri.com, Facebook, Twitter, Instag=
ram, LinkedIn and YouTube and X.

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsreg=
isternummer: HRA 57918
Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik Gmb=
H
Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsreg=
isternummer: HRB 54477
Gesch=C3=A4ftsf=C3=BChrer: Dr. Matthias Erb (Chairman); Lars Weyer; Stephan=
 Schenk; Walter Trauninger

=E2=80=8B

------_=_NextPart_eaada676-d7be-4818-a2aa-6424c379dcd4
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>Hi Richard,<br /><br />On Wednesday, 22 Novem=
ber 2023, 23:11:02 CET, Richard Purdie wrote:<br />&gt; <div dir=3D"ltr" st=
yle=3D"mso-line-height-rule:exactly;-webkit-text-size-adjust:100%;font-size=
:1px;direction:ltr;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0=
" style=3D"width:100%;font-size:1px;"><tr style=3D"font-size:0;"><td align=
=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacin=
g=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td =
align=3D"left" style=3D"padding:0;vertical-align:top;"><table cellpadding=
=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%;font-size:0;"><tr=
 style=3D"font-size:14.67px;color:#7F7F7F;font-style:normal;font-weight:400=
;white-space:nowrap;"><td align=3D"left" style=3D"vertical-align:top;font-f=
amily:Calibri,Arial,sans-serif;">__________________________________________=
_____________<span style=3D"font-family:remialcxesans;font-size:1px;color:#=
FFFFFF;line-height:1px;">&#8203;<span style=3D"font-family:&#39;template-LZ=
3Cj7wTEei85wANOiIRuQ&#39;;">&#8203;</span><span style=3D"font-family:&#39;z=
one-1&#39;;">&#8203;</span><span style=3D"font-family:&#39;zones-AQ&#39;;">=
&#8203;</span></span></td></tr><tr style=3D"font-size:0;"><td align=3D"left=
" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" =
border=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=
=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacin=
g=3D"0" border=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:normal;f=
ont-weight:400;white-space:nowrap;"><tr style=3D"font-size:14.67px;"><td al=
ign=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-ser=
if;">Christian</td><td align=3D"left" style=3D"vertical-align:top;color:#00=
0001;font-family:Calibri,Arial,sans-serif;">&nbsp;<br /></td><td align=3D"l=
eft" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;">Egg=
ers</td></tr></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left=
" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" =
border=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:normal;font-weig=
ht:400;white-space:nowrap;"><tr style=3D"font-size:14.67px;"><td align=3D"l=
eft" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;">Sof=
tware&nbsp;Engineer</td></tr><tr style=3D"font-size:14.67px;color:#000001;"=
><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,s=
ans-serif;">&#8203;</td></tr></table></td></tr></table></td></tr><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr =
style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><ta=
ble cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;c=
olor:#0E50AD;font-style:normal;font-weight:400;white-space:nowrap;"><tr sty=
le=3D"font-size:13.33px;"><td align=3D"left" style=3D"vertical-align:top;fo=
nt-family:&#39;Arial Black&#39;;">ARRI</td></tr><tr style=3D"font-size:10.6=
7px;color:#7F7F7F;"><td align=3D"left" style=3D"vertical-align:top;font-fam=
ily:Arial;"><span style=3D"font-size:11px;">Arnold&nbsp;&amp;&nbsp;Richter&=
nbsp;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG<=
/span>&nbsp;<br /></td></tr></table></td></tr><tr style=3D"font-size:0;"><t=
d align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cel=
lspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:n=
ormal;font-weight:400;white-space:nowrap;"><tr style=3D"font-size:10.67px;"=
><td align=3D"left" style=3D"vertical-align:top;font-family:Arial;">Arriweg=
&nbsp;17</td><td align=3D"left" style=3D"vertical-align:top;font-family:Ari=
al;">,&nbsp;<br /></td><td align=3D"left" style=3D"vertical-align:middle;fo=
nt-family:Arial;">83071</td><td align=3D"left" style=3D"vertical-align:midd=
le;font-family:Arial;">&nbsp;<br /></td><td align=3D"left" style=3D"vertica=
l-align:middle;font-family:Arial;">Stephanskirchen</td></tr></table></td></=
tr></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=
=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"left"=
 style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" b=
order=3D"0" style=3D"font-size:0;color:#1532B9;font-style:normal;font-weigh=
t:400;white-space:nowrap;"><tr style=3D"font-size:11px;"><td align=3D"left"=
 style=3D"vertical-align:top;font-family:Arial;"><span style=3D"text-decora=
tion:underline;"><a href=3D"http://www.arri.com/" target=3D"_blank" id=3D"L=
Plnk689713" style=3D"text-decoration:underline;color:#1532B9;">www.arri.com=
&nbsp;<br /><br /></a></span></td></tr><tr style=3D"font-size:0;"><td align=
=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacin=
g=3D"0" border=3D"0" style=3D"font-size:0;color:#858080;font-style:normal;f=
ont-weight:400;line-height:normal;white-space:nowrap;"><tr style=3D"font-si=
ze:14.67px;"><td align=3D"left" style=3D"padding:0;vertical-align:top;font-=
size:0;"><img src=3D"cid:image047282.png@2961E6F6.7659B60D" width=3D"20" he=
ight=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-width:20px;max-wi=
dth:20px;height:20px;min-height:20px;max-height:20px;font-size:0;" /></td><=
td align=3D"left" style=3D"padding:0;vertical-align:top;font-family:Calibri=
,Arial,sans-serif;"><a href=3D"tel:+49%208036%203009-3118" target=3D"_blank=
" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#858080;">+49&nbsp=
;8036&nbsp;3009-3118</a></td></tr><tr style=3D"font-size:0;"><td align=3D"l=
eft" style=3D"padding:0;vertical-align:top;"></td><td align=3D"left" style=
=3D"padding:0;vertical-align:top;"></td></tr><tr style=3D"font-size:0;"><td=
 align=3D"left" style=3D"padding:0;vertical-align:top;"></td><td align=3D"l=
eft" style=3D"padding:0;vertical-align:top;"></td></tr><tr style=3D"font-si=
ze:14.67px;"><td align=3D"left" style=3D"padding:0;vertical-align:top;font-=
size:0;"><img src=3D"cid:image096400.png@DCF39C15.7974C259" width=3D"20" he=
ight=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-width:20px;max-wi=
dth:20px;height:20px;min-height:20px;max-height:20px;font-size:0;" /></td><=
td align=3D"left" style=3D"padding:0;vertical-align:top;font-family:Calibri=
,Arial,sans-serif;"><a href=3D"mailto:CEggers@arri.de" target=3D"_blank" id=
=3D"LPlnk689713" style=3D"text-decoration:none;color:#858080;">CEggers@arri=
=2Ede</a></td></tr></table></td></tr></table></td></tr></table></td></tr><t=
r style=3D"font-size:14.67px;color:#000001;font-style:normal;font-weight:40=
0;white-space:nowrap;"><td align=3D"left" style=3D"vertical-align:top;font-=
family:Calibri,Arial,sans-serif;"><br />&#8203;</td></tr></table></td></tr>=
<tr style=3D"font-size:0;line-height:normal;"><td align=3D"left" style=3D"p=
adding:0;vertical-align:top;"><a href=3D"https://www.arri.com/skypanelx" ta=
rget=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;"><img src=
=3D"https://assets.arri.com/media/sign/20230908a_Stardust_E-mail-Signature_=
800x170@2x.jpg" width=3D"660" border=3D"0" title=3D"SkyPanel X" alt=3D"SkyP=
anel X" style=3D"width:660px;min-width:660px;max-width:660px;font-size:12px=
;" /></a></td></tr><tr style=3D"font-size:13px;color:#7F7F7F;font-style:nor=
mal;font-weight:400;white-space:nowrap;"><td align=3D"left" style=3D"paddin=
g:0;vertical-align:top;font-family:Calibri,Arial,sans-serif;">Get&nbsp;all&=
nbsp;the&nbsp;latest&nbsp;information&nbsp;from&nbsp;<span style=3D"text-de=
coration:underline;"><a href=3D"https://www.arri.com/" target=3D"_blank" id=
=3D"LPlnk689713" style=3D"text-decoration:underline;color:#7F7F7F;">www.arr=
i.com</a></span>,&nbsp;<span style=3D"text-decoration:underline;"><a href=
=3D"https://www.facebook.com/TeamARRI" target=3D"_blank" id=3D"LPlnk689713"=
 style=3D"text-decoration:underline;color:#7F7F7F;">Facebook</a></span>,&nb=
sp;<span style=3D"text-decoration:underline;"><a href=3D"https://twitter.co=
m/ARRIChannel" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoratio=
n:underline;color:#7F7F7F;">Twitter</a></span>,&nbsp;<a href=3D"https://www=
=2Einstagram.com/arri/" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-=
decoration:none;color:#7F7F7F;"><span style=3D"text-decoration:underline;">=
Instagram</span></a>,&nbsp;<a href=3D"https://www.linkedin.com/company/arri=
" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:=
#7F7F7F;"><span style=3D"text-decoration:underline;">LinkedIn</span></a>&nb=
sp;and&nbsp;<a href=3D"https://www.youtube.com/user/ARRIChannel" target=3D"=
_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#7F7F7F;"><s=
pan style=3D"text-decoration:underline;">YouTube</span></a>&nbsp;and&nbsp;<=
a href=3D"https://twitter.com/ARRIChannel" target=3D"_blank" id=3D"LPlnk689=
713" style=3D"text-decoration:none;color:#7F7F7F;"><span style=3D"text-deco=
ration:underline;">X</span></a>.<br /></td></tr><tr style=3D"font-size:0;">=
<td align=3D"left" style=3D"padding:0;vertical-align:top;"><table cellpaddi=
ng=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#6A6A6A;=
font-style:normal;font-weight:400;white-space:nowrap;"><tr style=3D"font-si=
ze:10px;"><td align=3D"left" style=3D"vertical-align:top;font-family:Arial;=
"><br />Arnold&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&nbs=
p;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG<br />Sitz:&nbsp;M&#252;nchen&nbsp;=
=E2=80=91&nbsp;Registergericht:&nbsp;Amtsgericht&nbsp;M&#252;nchen&nbsp;=
=E2=80=91&nbsp;Handelsregisternummer:&nbsp;HRA&nbsp;57918<br />Pers&#246;nl=
ich&nbsp;haftender&nbsp;Gesellschafter:&nbsp;Arnold&nbsp;&amp;&nbsp;Richter=
&nbsp;Cine&nbsp;Technik&nbsp;GmbH<br />Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=
=91&nbsp;Registergericht:&nbsp;Amtsgericht&nbsp;M&#252;nchen&nbsp;=E2=80=
=91&nbsp;Handelsregisternummer:&nbsp;HRB&nbsp;54477<br />Gesch&#228;ftsf&#2=
52;hrer:&nbsp;Dr.&nbsp;Matthias&nbsp;Erb&nbsp;(Chairman);&nbsp;Lars&nbsp;We=
yer;&nbsp;Stephan&nbsp;Schenk;&nbsp;Walter&nbsp;Trauninger<br /></td></tr><=
tr style=3D"font-size:14.67px;color:#000001;"><td align=3D"left" style=3D"v=
ertical-align:top;font-family:Calibri,Arial,sans-serif;"><br />&#8203;<br /=
></td></tr></table></td></tr></table></td></tr></table></div>On Wed, 2023-1=
1-22 at 12:36 +0100, Christian Eggers wrote:<br />&gt; &gt; On Wednesday, 2=
2 November 2023, 12:22:52 CET, Alexander Kanavin<br />&gt; &gt; wrote:<br /=
>&gt; &gt; &gt; Your description shows that everything works as intended. I=
f<br />&gt; &gt; &gt; something<br />&gt; &gt; &gt; needs artefacts in ${B}=
 then do_compile has to run at least once to<br />&gt; &gt; &gt; populate $=
{B}. Preserving ${STAMPS_DIR} would clash with that and<br />&gt; &gt; &gt;=
 isn&#39;t<br />&gt; &gt; &gt; going to work. And do_compile isn&#39;t ssta=
te-enabled, so there&#39;s no<br />&gt; &gt; &gt; shortcut<br />&gt; &gt; &=
gt; that way.<br />&gt; &gt; <br />&gt; &gt; that sounds like not every tas=
k&#39;s output goes to the shared state<br />&gt; &gt; cache (is there docu=
mentation about this?). As do_compile doesn&#39;t go<br />&gt; &gt; to cach=
e, all previous tasks (also not cached?) have to be rerun.<br />&gt; <br />=
&gt; SSTATETASKS gives a hint about which ones write to sstate. It doesn&#3=
9;t<br />&gt; make sense for everything to go there as the computation to r=
ecreate<br />&gt; some things is similar to that of storing it, or storage =
is large and<br />&gt; not often used, therefore not cost effective.<br />&=
gt; <br />&gt; &gt; Would it make sense to put the result of do_compile int=
o the cache<br />&gt; &gt; for my particular recipe?<br />&gt; <br />&gt; Y=
ou could create an sstate task which stored the binary, which would<br />&g=
t; work out very similar to the way do_deploy works. do_deploy would be<br =
/>&gt; the simplest example we have.<br />&gt; <br />&gt; I would caution t=
hat sstate tasks aren&#39;t &quot;easy&quot; and the system does<br />&gt; =
have to have knowledge of when to run dependent tasks and when not to<br />=
&gt; so there are complications in making them work accurately. It isn&#39;=
t<br />&gt; documented for that reason.<br /><br />although I have been war=
ned, I couldn&#39;t resist trying to add the<br />do_compile task of my rec=
ipe to the sstate cache after finding the docs<br />here:<br /><br />https:=
//docs.yoctoproject.org/overview-manual/concepts.html#shared-state<br /><br=
 />But adding do_compile seems to eat children, I got error messages like <=
br /><br />ERROR: myapp-3.0.12+gitAUTOINC+c80b310bcd-r0 do_prepare_recipe_s=
ysroot: The sstate manifest for task &#39;kern-tools-native:populate_sysroo=
t&#39; (multilib variant &#39;&#39;) could not be found.<br />The pkgarchs =
considered were: x86_64, x86_64_opensuseleap-15.5.<br />But none of these m=
anifests exists:<br />    /build/devel/tmp/sstate-control/manifest-x86_64-k=
ern-tools-native.populate_sysroot<br />    /build/devel/tmp/sstate-control/=
manifest-x86_64_opensuseleap-15.5-kern-tools-native.populate_sysroot<br /><=
br /><br />After having learned that only do_package goes to the cache, I t=
ried to<br />squeeze my do_stamp task between do_package and do_package_wri=
te_ipk:<br /><br />do_stamp() {<br />    [ -f myapp.orig ] || cp myapp myap=
p.orig<br />    # Retrieve original section size<br />    ${OBJCOPY} --dump=
-section VERSION=3Dmyapp.version myapp.orig<br />    SIZE=3D$(stat -c &#39;=
%s&#39; myapp.version)<br />    # Update section (ensuring the same section=
 size)<br />    echo ${SW_VERSION}-${CI_PIPELINE_ID} &gt; myapp.version<br =
/>    truncate -s ${SIZE} myapp.version<br />    ${OBJCOPY} --update-sectio=
n VERSION=3Dmyapp.version myapp.orig myapp<br />    rm myapp.orig myapp.ver=
sion<br />}<br />do_stamp[dirs] =3D &quot;${PKGDEST}/${PN}${bindir}&quot;<b=
r />addtask stamp after do_prepare_recipe_sysroot do_package before do_pack=
agedata<br /><br />I am not sure whether this will hit back like a boomeran=
g some day later, <br />but first tests seem to be promising. I needed some=
 tries to figure out where<br />exactly (image, package, packages-split) I =
have to apply my &quot;binary patch&quot;.<br /><br /><br />&gt; Regardless=
, keeping STAMPS_DIR around is a really bad idea unless you<br />&gt; reall=
y know what you&#39;re doing.<br />&gt; <br />&gt; &gt; &gt; I&#39;d sugges=
t that instead of embedding any build id data into the<br />&gt; &gt; &gt; =
binary<br />&gt; &gt; &gt; from its recipe, you can do the same step when b=
uilding the image.<br />&gt; &gt; &gt; There<br />&gt; &gt; &gt; are hooks =
for this, e.g. ROOTFS_POSTPROCESS_COMMAND.<br />&gt; &gt; <br />&gt; &gt; O=
f course this is much more straight forward (and what I already do).<br />&=
gt; &gt; Be for<br />&gt; &gt; some use cases (automatic testing), we handl=
e with individual IPK<br />&gt; &gt; files / executables<br />&gt; &gt; rat=
her than with complete rootfs images. For this use case it would<br />&gt; =
&gt; be helpful<br />&gt; &gt; if the application could &quot;identify&quot=
; itself.<br />&gt; <br />&gt; You could embed the ID into a file in the pa=
ckage instead of the binary<br />&gt; itself but that doesn&#39;t solve the=
 individual binary challenge. You<br />&gt; could record the checksum of th=
e binary and have a mapping maintained<br />&gt; the other way?<br /><br />=
I think this is what GNU build-id already provides (which would also be<br =
/>compatible with reproducible builds). But most of my team voted for havin=
g<br />the version and CI id inside the executable. <br /><br />In contrast=
 to putting these into the rootfs (either by a post rootfs hook<br />or by =
a separate package), embedding the version information into the executable<=
br />covers both, CI builds (by bitbake) and local builds (SDK + cmake).<br=
 /><br />regards,<br />Christian<br /><br /><br /><br /></div></body></html=
>
------_=_NextPart_eaada676-d7be-4818-a2aa-6424c379dcd4--

------_=_NextPart_76f81d9a-9afe-43aa-8a7d-52dd34b161fc
Content-Type: image/png;
	name="image047282.png"
Content-Transfer-Encoding: base64
Content-ID: <image047282.png@2961E6F6.7659B60D>
Content-Description: image047282.png
Content-Disposition: inline;
	creation-date="Thu, 23 Nov 2023 12:22:29 +0000";
	filename=image047282.png;
	modification-date="Thu, 23 Nov 2023 12:22:29 +0000";
	size=528

iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAGlSURBVDhP1ZOxSgNBEIZ3o6QSSWGRwiJFCl9A
iCDEIqKFgo2FYGHjA1hYRZ0sGrURgq0WgkoqEUHQShJMYWFhmcLCwsIHsJBEs/5zmTvvJIE9sPGD
Zf7Zu/tvdndW/TVaogcRDSWVKlilMhvGVGQ6FoEhzAaTWt9AFji31q7C9Jh1HBISFSpbQPDMGK31
NlcsqTOBIRxmRPmkUTGJdubHUKmsxDA5ic6EDV8k+jRa1i6KdiYw/LL2QiTzDrNpY8yb5M4EhlvG
XKNdniXl9pkTHYvwkrlXDkTxIR3tEWUkcyZi2FbqBOGxm6lUR+tT7k/JnYgYYs8+sHfzkP7eTaJ1
LmGaktyjTDSGsSxphMjV89khyqGx7yG96rC3r7g5S5vGNHaJsrb7LI3RwPw6btQDv8f0NGRwTWYT
Wlch/eo+Mc5gPoWPfu9tpVgqrbGIHkoIVHOLQ5qAQVOmuNqVHma8guDK9jVkisY029aOQ/JhcYU9
wbLPRaoBiX2p1+utu1rtqpDPV9FKHVQziiqH5fETzMr40yHe68hcfPaJRnHyI5L+K5T6BsZ9gKi6
xb3hAAAAAElFTkSuQmCC

------_=_NextPart_76f81d9a-9afe-43aa-8a7d-52dd34b161fc
Content-Type: image/png;
	name="image096400.png"
Content-Transfer-Encoding: base64
Content-ID: <image096400.png@DCF39C15.7974C259>
Content-Description: image096400.png
Content-Disposition: inline;
	creation-date="Thu, 23 Nov 2023 12:22:29 +0000";
	filename=image096400.png;
	modification-date="Thu, 23 Nov 2023 12:22:29 +0000";
	size=824

iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALNSURBVDhPtZQ/SNVRFMfv1Z/S4PCGBoeg1Uih
oaFB8j1wMGgweBJBgUNRUQ2BQaH2e79SaKipwcGhlkioQEiooT++7RUOBkYODg0GgiIOLyi1bp/v
/d3fL8U31hfuO/ec3z3nfM895z7zr2GDbIg4jgutxvQ6Yw5IRy5uGzOfJMmKP9AADQMSaH+LtQ/5
WEaNUutfEHj5t3OXbyfJTDDl2BNwPI7LxtoJthFOD5A1WM0hf7QY04FDB98vohdZjzeduwbjOnuP
piA9QrBnMJjl4KHRJBmD3hJlF5HdW8Z8HU6SqeFKpeScu4BLmUoepd4pcoYqs9XaLwo2UqkMoEfo
YjrIysreNs6dI+kk515b516wf4ptgETPdSBnqDtDRFuUIJ1g0s/jOE3pJ7TQZ30AY9pg4tmyn8E2
AYE29mlmdVMNwInrSFbG4vgq5kvY7lHeLZ0ROFcj0SrbCFYfZNM9N1n7XveLOucZajQQCl6TTsYr
MFv66dyo1wNItoFQg4QF/dAwL0GnfnxAnP2cqZu6S3WSD1MEwLQbnFVpdcpdlM6ZNcSatfaw9Cyg
2Ml5G7bd3ubcJ8md0D2RTEzmU0uOPLEPyM8yIiLqEYIXZMtY7wTJhsI2K1tJ2hHtEPgs3QfcVPdS
HGP5UijhtGSGO3F8EuOw9pmzGNOkSbYbkHkjGxWkGK9UXsGqk7Hp4tBLTN3oU2RcQvahH0VO49DP
XgxF4iyr8Is5zJ6hZyg08TY5XCDY3WbnzgTnMnKEz5FeBgN/ijG5gW1fSKLh7tr5pnOGguaPUjXQ
93l6GhlddlsYl13gmfZzVTXNbTB5NAfp8a5a/Vjq6flO0JsM6yD3sspaf1utruu77qy3WDzeWyo9
4T6HKO8bPunsBuximIHs+kfRo1eThA1KrHM46/w8pV/nzyNrZo6GATNwBRqjPtgeRK2H7i6MJEk+
Nv8ZxvwBPgIhrepF7fMAAAAASUVORK5CYII=

------_=_NextPart_76f81d9a-9afe-43aa-8a7d-52dd34b161fc--

