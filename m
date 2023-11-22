Return-Path: <ceggers@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66507C61D9B
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 10:55:27 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.93])
 by mx.groups.io with SMTP id smtpd.web10.16633.1700650522769928142
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Nov 2023 02:55:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arri.de header.s=selector1 header.b=EHo0GEjT;
 spf=pass (domain: arri.de, ip: 40.107.8.93, mailfrom: ceggers@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVkcFYHilEl3AHS/ZkXQJHyemw258mXzBjwqXeoRIfmuTKlbF4NZng1EqSaDg7sN8yMzEA2OzBS8eltZoXw3nYK0pwTaY6Ty2Vq0oSBJKMWs6t/K/VZfnVPhWMFpXUL70BfFzEs17fPfgpcZDFBnpPNMA1X+KJE0fMDTsv9dgwt6FTt3ioCeSdGoxZbL0eJwjzSzln84Tif5DETu1dyAo9PBgY5wBWlr4PsyYzvBCgjk3ShdisriYAMSlWG5eCJtXjBpzMzcrOsnkbI7FENiu8cWfg23dZPzjKvVUTjdyRtJTmE3WWArW9NFpqks9543/w5C5Lb53t486ewg3ARv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu4OplS9UUjtPgC8lv9ja/D76LYaDg5bi5lpnXU6nCQ=;
 b=OUDwjR6Yd7emzHcAQsLzssMRES/MkD3hBgu1KXrnQh2hhJwexVTagIYcewQZqmr1nifulLsQg7hfeYszkJAjKQYcD8ig59pH+3UTbYbSd69EmO0ntSjcaOZvN6t+sQNfGE0iPjAzUqtFwSVKXdUSmvCe75ZTh0yEw/aTBSjsIMmp7h6z6zhh/dYlllXIJjr667niTVMckS8WlzZl8gLLArFFvspNLsbUIVp+/7Rx0Pt1sG5kobzMg2QwBloitqp1m6UfBsmx4kszOoXEiiErPYkiJFqazz8XverDchAY7b0yjfH2so1X8+6OhFPL36DHSzuCJ3s+b+V3pOpePEYWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.169.0.179) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arri.de;
 dmarc=bestguesspass action=none header.from=arri.de; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu4OplS9UUjtPgC8lv9ja/D76LYaDg5bi5lpnXU6nCQ=;
 b=EHo0GEjTmSPUTplgZBz6GdQnN7Tq2jeMKPMfCbyAKnndvoLdMP9kPEJsXmTQHiKX4p/IEq8TkkieVfUL295rj1KcJYJcVizDeqXCVxslgDXGjPo3+I3l3sVbztPkrbfBoJ5GGfteFyRvlMWoevCPV9HcXM7Vc0pETFEhowYBP2M=
Received: from AS4P191CA0031.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::13)
 by DB5PR07MB9513.eurprd07.prod.outlook.com (2603:10a6:10:48c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 10:55:18 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::98) by AS4P191CA0031.outlook.office365.com
 (2603:10a6:20b:657::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 10:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.169.0.179)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net; pr=C
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 10:55:17 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.105)
	 by eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Wed, 22 Nov 2023 10:55:17 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 8618491
X-ExclaimerImprintLatency: 3228549
X-ExclaimerImprintAction: cd3e1c015a5f400f972f401814a9389f
Content-Type: multipart/related;
	boundary="----_=_NextPart_c8b394bb-86bd-4875-a30a-9812323d4b16"
Received: from AS8PR04CA0152.eurprd04.prod.outlook.com (2603:10a6:20b:331::7)
 by GV1PR07MB9046.eurprd07.prod.outlook.com (2603:10a6:150:a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 10:55:15 +0000
Received: from AM1PEPF000252DC.eurprd07.prod.outlook.com
 (2603:10a6:20b:331:cafe::6f) by AS8PR04CA0152.outlook.office365.com
 (2603:10a6:20b:331::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 10:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM1PEPF000252DC.mail.protection.outlook.com (10.167.16.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 10:55:15 +0000
Received: from n95hx1g2.localnet (10.30.5.31) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Nov
 2023 11:55:15 +0100
From: Christian Eggers <ceggers@arri.de>
To: <bitbake-devel@lists.openembedded.org>
Subject: Keeping STAMPS_DIR between CI builds?
Date: Wed, 22 Nov 2023 11:55:14 +0100
Message-ID: <3556314.iIbC2pHGDl@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
X-Originating-IP: [10.30.5.31]
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: 
	AM1PEPF000252DC:EE_|GV1PR07MB9046:EE_|AMS1EPF00000048:EE_|DB5PR07MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e6175b-ad4c-4086-d203-08dbeb4983e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 77B6BDQWBSVwlqGlQTO4mofbS+AS7kj84CVz4kNnTAYdaFo+JyC7yRbUwd/nMEAxHlY6qJWeN8K3WJq4tFVphOypo3wKDyLc7z3O9YXMfZCAECkVbJy49GS6+49j3p6i5X2oey6OGVorXP21AmA7yOKt78YZFFixbVhztDatl3chtZahqcxtQ0hct9l2TuI0FGj0q7GxU576dngKpXkIUXHLBpg4WPA6D67Iw/XqfiKF+MwjqRXwYKwfoKsZenrqyWn+M95/gjHf6Tkf5ClgsWOmLGpO2/nC8SEZ3JOIcUdmod0P6lhQ7NU/2FRYJTYHYfQWQQwOMjjpSRyr7neA8HdKlQpk5K/MGwEXb6nIze4gbQIocMC9NGuD5VQEkoBlTTM3+GupKYPXg3j+Ltw+Wr/BAn4jcfIZIk5RjNZyOkV2KWIRoAaMGMSVF1tBXxITHiDR1YWMWBOhK8vAi8MKVJMx2WX66mDWlxmhc4JznaIIdzefKT5HQxgQTZWPx/6A2LB6OEnCkLxTETj24bcinUQOusIVTWegXFnUjiRdnUYIVvFY/I59dsDsf6KrMNl0eVoonPEGAr2wEeyU1qFI1LmJ1BZdE064UStpZWs8+XE6ELoqeF5cEDzIyXbsVCaQOY3jJ8TsHntZc/mWMxi9Vd+qul9MTwLV9ELoDVKO/YnNjGG+8hkDmKRI95ayMd8OJ1URNl1K1Y+fSuCfa91fw7v0QZrkL6tPEweLaLCAE8AG6Tp4gHJIrguQbmCTh9rGEw5JlfY4UPEQsROEzMth/mM/DGe+JdY3mLog7iizqkXquZc4i7nAd/At4UWjENsn
X-Forefront-Antispam-Report-Untrusted: 
 CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(36840700001)(46966006)(83380400001)(336012)(26005)(9686003)(33716001)(16526019)(426003)(5660300002)(8936002)(47076005)(36860700001)(8676002)(41300700001)(9576002)(2906002)(478600001)(316002)(36916002)(6916009)(70206006)(70586007)(81166007)(356005)(86362001)(82740400003)(40480700001)(39026012)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9046
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	d1f090ff-eb22-4451-503a-08dbeb498249
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uXEyUm0CJLdLtiqvAIbNlPWjxJKQL2clAJspyNdWTtPcO2eYKPWtbdjzCuwEPsTvusDVSX+KCjAg4A73e5xES44QqBSjZPuNP3pk6i13BvzvNvnbdO+wBo5PB7k7fSPleHEsHY8pfc17tbpxco/yy1ww76+F1jueCr+WpkkQl7krde1SvDE3Tyec+vyqPA2eMxb8bxzaKdgcMUvwj7FyBhIVRorOq4wl0ee/k0WemHhSQ1/LxiHLPv93pNT8JUR1ksek05K2/CfA6YquODHqixIO+i+ZAkDfP+35feP1GzUqaTvMeqHRuwkZ1ue0j6L0EOiC4TIdHLENAuAt/gTZDn+UQlI4jh7zfg+VeTKDHXXWJNhdR0q/afvpXWPF1BnCxDjfDge8QI4tHgUQSFzEu02R17+P+nOCWVSV0hERh8Xinecam3n22Sfaq35abMVic8ccaP2qtpfF8YYKCciSU8+oDTo8TePwDp5X/yRqpIdTClPnGJ0Idb8J1hxCUwaUNFpGTkppQOXfUjIlhxOxiptL2uju9UfJb4n5jXbcHc9X9VeSQ2rIa1FrXCU41mKwuedMdUU5YReeI0s1mLw5OmE+vRQAOxV97wfDriK/CpXBjw+AEYMF92ae4wQng4fvwbzBUxExRTvcWE8HfjxZY/VvKd7HrpbE1J59msKxJTGGA5P5+YjEfBa1Ya3r++E5BGJjO5iPZ4SE6hziyspEjDxy8EojikF1uZaH0geFOhpEN2xt8JQtIdF+656yTFeEXkY3VW0Xcq9mwlbjUoyCHYT1snwVAACUWuYDAKJ4A9WWG9bvG+xB3NNrMSKXVhH/1hxcWVclFfI39WvS19pn06Imp86t9DVeGMXlMjzfb9WG5Z1Htu0RuuhkU8CNoS0h
X-Forefront-Antispam-Report: 
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39850400004)(346002)(396003)(230922051799003)(82310400011)(64100799003)(1800799012)(1690799017)(451199024)(7200799017)(186009)(36840700001)(46966006)(40470700004)(9576002)(2906002)(41300700001)(70206006)(8676002)(6916009)(316002)(8936002)(5660300002)(70586007)(478600001)(86362001)(45080400002)(15974865002)(33964004)(36916002)(8400799017)(40480700001)(9686003)(26005)(16526019)(66574015)(336012)(426003)(40460700003)(36860700001)(83380400001)(47076005)(33716001)(82740400003)(7636003)(7596003)(166002)(39026012);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:55:17.6608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e6175b-ad4c-4086-d203-08dbeb4983e6
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9513
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Nov 2023 10:55:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15559

This is a multi-part message in MIME format.

------_=_NextPart_c8b394bb-86bd-4875-a30a-9812323d4b16
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_f21e68f7-93e6-4f59-a918-5b93a79a57e0"

------_=_NextPart_f21e68f7-93e6-4f59-a918-5b93a79a57e0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I build OpenEmbedded on a CI machine (GitLab runner). Between the individua=
l builds,
I keep only the DL_DIR and SSTATE_DIR directories. So if nothing has change=
d between
two builds, I see that mainly setscene tasks are executed.

In one recipe (the "main" application of our embedded product), I have a sp=
ecial task
(between do_build and do_install) which "stamps" the build number of the CI=
 system
(increments on every build) into a special section of the executable. The i=
dea is not
to run the (costly) do_build step on every CI run:

do_stamp() {
    [ -f myexe.orig ] || cp myexe myexe.orig
    # Retrieve original VERSION section size
    ${OBJCOPY} --dump-section VERSION=3Dmyexe.version myexe.orig
    SIZE=3D$(wc -c < myexe.version)
    # Replace VERSION section (ensuring the same section size)
    echo ${MY_VERSION}-${MY_BUILD_ID} > myexe.version
    truncate -s ${SIZE} myexe.version
    ${OBJCOPY} --update-section VERSION=3Dmyexe.version myexe.orig myexe
}
do_stamp[dirs] =3D "${B}"
addtask stamp after do_compile before do_install


This works fine on my local machine (here I don't delete anything between t=
wo
bitbake runs): After changing MY_BUILD_ID in my local.conf, in the next bit=
bake
run only the do_stamp (and the following) tasks are rebuild.

But on the CI system, all tasks of my applications recipe are rebuild (star=
ting
from "do_fetch"). This affects only my application's recipe, for all other
targets (where no task input has changed), only the setscene tasks are run.

Summary:
---------
1. Only build id is incremented (but build tree is kept):
do_stamp (and following tasks) are run (as desired)

2. Build id is not changed, but build tree is deleted:
only setscene tasks are run (as desired)

3. Build id is incremented AND build tree is deleted
full applications recipe is run (starting with do_fetch)


I already found out, that this is somehow related to deleting the STAMPS_DI=
R
directory (what I normally do on the CI system). It seems that the stamps
are not required as long as no input of a recipe has changed. But as soon
as an input of a single tasks changed, the full recipe is rebuild if no
stamps are present.

So what is the best practice for the CI build? Should I keep the STAMPS_DIR
between builds (as I do with DL_DIR and SSTATE_DIR), or is there a better o=
ption
if I want to avoid rebuilding the whole recipe?

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

------_=_NextPart_f21e68f7-93e6-4f59-a918-5b93a79a57e0
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>I build OpenEmbedded on a CI machine (GitLab =
runner). Between the individual builds,<br />I keep only the DL_DIR and SST=
ATE_DIR directories. So if nothing has changed between<br />two builds, I s=
ee that mainly setscene tasks are executed.<br /><br />In one recipe (the &=
quot;main&quot; application of our embedded product), I have a special task=
<br />(between do_build and do_install) which &quot;stamps&quot; the build =
number of the CI system<br />(increments on every build) into a special sec=
tion of the executable. The idea is not<br />to run the (costly) do_build s=
tep on every CI run:<br /><br />do_stamp() {<br />    [ -f myexe.orig ] || =
cp myexe myexe.orig<br />    # Retrieve original VERSION section size<br />=
    ${OBJCOPY} --dump-section VERSION=3Dmyexe.version myexe.orig<br />    S=
IZE=3D$(wc -c &lt; myexe.version)<br />    # Replace VERSION section (ensur=
ing the same section size)<br />    echo ${MY_VERSION}-${MY_BUILD_ID} &gt; =
myexe.version<br />    truncate -s ${SIZE} myexe.version<br />    ${OBJCOPY=
} --update-section VERSION=3Dmyexe.version myexe.orig myexe<br />}<br />do_=
stamp[dirs] =3D &quot;${B}&quot;<br />addtask stamp after do_compile before=
 do_install<br /><br /><br />This works fine on my local machine (here I do=
n&#39;t delete anything between two<br />bitbake runs): After changing MY_B=
UILD_ID in my local.conf, in the next bitbake<br />run only the do_stamp (a=
nd the following) tasks are rebuild.<br /><br />But on the CI system, all t=
asks of my applications recipe are rebuild (starting<br />from &quot;do_fet=
ch&quot;). This affects only my application&#39;s recipe, for all other<br =
/>targets (where no task input has changed), only the setscene tasks are ru=
n.<br /><br />Summary:<br />---------<br />1. Only build id is incremented =
(but build tree is kept):<br />do_stamp (and following tasks) are run (as d=
esired)<br /><br />2. Build id is not changed, but build tree is deleted:<b=
r />only setscene tasks are run (as desired)<br /><br />3. Build id is incr=
emented AND build tree is deleted<br />full applications recipe is run (sta=
rting with do_fetch)<br /><br /><br />I already found out, that this is som=
ehow related to deleting the STAMPS_DIR<br />directory (what I normally do =
on the CI system). It seems that the stamps<br />are not required as long a=
s no input of a recipe has changed. But as soon<br />as an input of a singl=
e tasks changed, the full recipe is rebuild if no<br />stamps are present.<=
br /><br />So what is the best practice for the CI build? Should I keep the=
 STAMPS_DIR<br />between builds (as I do with DL_DIR and SSTATE_DIR), or is=
 there a better option<br />if I want to avoid rebuilding the whole recipe?=
<br /><br />regards,<br />Christian<br /><br /><br /><br /><br /></div><div=
 dir=3D"ltr" style=3D"mso-line-height-rule:exactly;-webkit-text-size-adjust=
:100%;font-size:1px;direction:ltr;"><table cellpadding=3D"0" cellspacing=
=3D"0" border=3D"0" style=3D"width:100%;font-size:1px;"><tr style=3D"font-s=
ize:0;"><td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=
=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=3D"f=
ont-size:0;"><td align=3D"left" style=3D"padding:0;vertical-align:top;"><ta=
ble cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%;fo=
nt-size:0;"><tr style=3D"font-size:14.67px;color:#7F7F7F;font-style:normal;=
font-weight:400;white-space:nowrap;"><td align=3D"left" style=3D"vertical-a=
lign:top;font-family:Calibri,Arial,sans-serif;">___________________________=
____________________________<span style=3D"font-family:remialcxesans;font-s=
ize:1px;color:#FFFFFF;line-height:1px;">&#8203;</span></td></tr><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr =
style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><ta=
ble cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;c=
olor:#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><tr sty=
le=3D"font-size:14.67px;"><td align=3D"left" style=3D"vertical-align:top;fo=
nt-family:Calibri,Arial,sans-serif;">Christian</td><td align=3D"left" style=
=3D"vertical-align:top;color:#000001;font-family:Calibri,Arial,sans-serif;"=
>&nbsp;<br /></td><td align=3D"left" style=3D"vertical-align:top;font-famil=
y:Calibri,Arial,sans-serif;">Eggers</td></tr></table></td></tr><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:=
#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><tr style=
=3D"font-size:14.67px;"><td align=3D"left" style=3D"vertical-align:top;font=
-family:Calibri,Arial,sans-serif;">Software&nbsp;Engineer</td></tr><tr styl=
e=3D"font-size:14.67px;color:#000001;"><td align=3D"left" style=3D"vertical=
-align:top;font-family:Calibri,Arial,sans-serif;">&#8203;</td></tr></table>=
</td></tr></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left" s=
tyle=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" bor=
der=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"le=
ft" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0=
" border=3D"0" style=3D"font-size:0;color:#0E50AD;font-style:normal;font-we=
ight:400;white-space:nowrap;"><tr style=3D"font-size:13.33px;"><td align=
=3D"left" style=3D"vertical-align:top;font-family:&#39;Arial Black&#39;;">A=
RRI</td></tr><tr style=3D"font-size:10.67px;color:#7F7F7F;"><td align=3D"le=
ft" style=3D"vertical-align:top;font-family:Arial;"><span style=3D"font-siz=
e:11px;">Arnold&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&nb=
sp;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG</span>&nbsp;<br /></td></tr></table=
></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-=
align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=
=3D"font-size:0;color:#7F7F7F;font-style:normal;font-weight:400;white-space=
:nowrap;"><tr style=3D"font-size:10.67px;"><td align=3D"left" style=3D"vert=
ical-align:top;font-family:Arial;">Arriweg&nbsp;17</td><td align=3D"left" s=
tyle=3D"vertical-align:top;font-family:Arial;">,&nbsp;<br /></td><td align=
=3D"left" style=3D"vertical-align:middle;font-family:Arial;">83071</td><td =
align=3D"left" style=3D"vertical-align:middle;font-family:Arial;">&nbsp;<br=
 /></td><td align=3D"left" style=3D"vertical-align:middle;font-family:Arial=
;">Stephanskirchen</td></tr></table></td></tr></table></td></tr><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr =
style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><ta=
ble cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;c=
olor:#1532B9;font-style:normal;font-weight:400;white-space:nowrap;"><tr sty=
le=3D"font-size:11px;"><td align=3D"left" style=3D"vertical-align:top;font-=
family:Arial;"><span style=3D"text-decoration:underline;"><a href=3D"http:/=
/www.arri.com/" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decorati=
on:underline;color:#1532B9;">www.arri.com&nbsp;<br /><br /></a></span></td>=
</tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:=
top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font=
-size:0;color:#858080;font-style:normal;font-weight:400;line-height:normal;=
white-space:nowrap;"><tr style=3D"font-size:14.67px;"><td align=3D"left" st=
yle=3D"padding:0;vertical-align:top;font-size:0;"><img src=3D"cid:image0854=
16.png@AB7D2AD2.967CA5A4" width=3D"20" border=3D"0" alt=3D"" style=3D"width=
:20px;min-width:20px;max-width:20px;font-size:0;" /></td><td align=3D"left"=
 style=3D"padding:0;vertical-align:top;font-family:Calibri,Arial,sans-serif=
;"><a href=3D"tel:+49%208036%203009-3118" target=3D"_blank" id=3D"LPlnk6897=
13" style=3D"text-decoration:none;color:#858080;">+49&nbsp;8036&nbsp;3009-3=
118</a></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"pad=
ding:0;vertical-align:top;"></td><td align=3D"left" style=3D"padding:0;vert=
ical-align:top;"></td></tr><tr style=3D"font-size:0;"><td align=3D"left" st=
yle=3D"padding:0;vertical-align:top;"></td><td align=3D"left" style=3D"padd=
ing:0;vertical-align:top;"></td></tr><tr style=3D"font-size:14.67px;"><td a=
lign=3D"left" style=3D"padding:0;vertical-align:top;font-size:0;"><img src=
=3D"cid:image350721.png@A6B42E1A.F35BEEC6" width=3D"20" border=3D"0" alt=
=3D"" style=3D"width:20px;min-width:20px;max-width:20px;font-size:0;" /></t=
d><td align=3D"left" style=3D"padding:0;vertical-align:top;font-family:Cali=
bri,Arial,sans-serif;"><a href=3D"mailto:CEggers@arri.de" target=3D"_blank"=
 id=3D"LPlnk689713" style=3D"text-decoration:none;color:#858080;">CEggers@a=
rri.de</a></td></tr></table></td></tr></table></td></tr></table></td></tr><=
tr style=3D"font-size:14.67px;color:#000001;font-style:normal;font-weight:4=
00;white-space:nowrap;"><td align=3D"left" style=3D"vertical-align:top;font=
-family:Calibri,Arial,sans-serif;"><br />&#8203;</td></tr></table></td></tr=
><tr style=3D"font-size:0;line-height:normal;"><td align=3D"left" style=3D"=
padding:0;vertical-align:top;"><a href=3D"https://www.arri.com/skypanelx" t=
arget=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;"><img sr=
c=3D"https://assets.arri.com/media/sign/20230908a_Stardust_E-mail-Signature=
_800x170@2x.jpg" width=3D"660" border=3D"0" title=3D"SkyPanel X" alt=3D"Sky=
Panel X" style=3D"width:660px;min-width:660px;max-width:660px;font-size:12p=
x;" /></a></td></tr><tr style=3D"font-size:13px;color:#7F7F7F;font-style:no=
rmal;font-weight:400;white-space:nowrap;"><td align=3D"left" style=3D"paddi=
ng:0;vertical-align:top;font-family:Calibri,Arial,sans-serif;">Get&nbsp;all=
&nbsp;the&nbsp;latest&nbsp;information&nbsp;from&nbsp;<span style=3D"text-d=
ecoration:underline;"><a href=3D"https://www.arri.com/" target=3D"_blank" i=
d=3D"LPlnk689713" style=3D"text-decoration:underline;color:#7F7F7F;">www.ar=
ri.com</a></span>,&nbsp;<span style=3D"text-decoration:underline;"><a href=
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
></td></tr></table></td></tr></table></td></tr></table></div></body></html>
------_=_NextPart_f21e68f7-93e6-4f59-a918-5b93a79a57e0--

------_=_NextPart_c8b394bb-86bd-4875-a30a-9812323d4b16
Content-Type: image/png;
	name="image085416.png"
Content-Transfer-Encoding: base64
Content-ID: <image085416.png@AB7D2AD2.967CA5A4>
Content-Description: image085416.png
Content-Disposition: inline;
	creation-date="Wed, 22 Nov 2023 10:55:17 +0000";
	filename=image085416.png;
	modification-date="Wed, 22 Nov 2023 10:55:17 +0000";
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

------_=_NextPart_c8b394bb-86bd-4875-a30a-9812323d4b16
Content-Type: image/png;
	name="image350721.png"
Content-Transfer-Encoding: base64
Content-ID: <image350721.png@A6B42E1A.F35BEEC6>
Content-Description: image350721.png
Content-Disposition: inline;
	creation-date="Wed, 22 Nov 2023 10:55:17 +0000";
	filename=image350721.png;
	modification-date="Wed, 22 Nov 2023 10:55:17 +0000";
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

------_=_NextPart_c8b394bb-86bd-4875-a30a-9812323d4b16--

