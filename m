Return-Path: <ceggers@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CB1C61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 11:36:47 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.108])
 by mx.groups.io with SMTP id smtpd.web10.17345.1700652998387093222
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Nov 2023 03:36:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arri.de header.s=selector1 header.b=TC1YD5ux;
 spf=pass (domain: arri.de, ip: 40.107.21.108, mailfrom: ceggers@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAF1au6jBk1fnRBCqsbW3dXsMJkmqmGPDJa3WftDOPOsAq3DcZXrfObhCpU8uP73DbV0ezWhM5FzVjoRdMAfkZHmhhQPyxT7bA0TlH0tKZYu90bYOzxWXOUUm7t/ssAvte5Tp3oKHm9yMRI/R2ljGdMQIkkJUVqHDkdvUJ18AJ7ta2edbwRSGpJIa8VzQe9cWm8vMm39cTnhp0KbeI6laXAkVKs7DNbG8lhmypfFkX3vep9cYTXkA5nhCfALt6iwCFqI7bZWZHWCNwYX59OEXTgB6qeOCZr6PoygQXzdbvKp3PKvAcUCbW0uLel9HEwbOap3XPPr2yQNZZfOtn7l0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x237DThpXUNOG22VRWu5SPPd5VxDNCa7/nsyrT5pisE=;
 b=egOETx/eX/Fk3sfWwJNy68MpZHA/bIbbN9dSqfMTfXYQRyuwnZo5s4wgTZVm5aHv3f4si2pzIkoAys8Ed/sbLQ4bX7/tn0SVT66RcJCwHWs0+3ihqORwl2zz6+iFeyZKlqAK2a9cVyrvpp5XegveJPOIJRq7U0SpLa72YXpgJ+2GlVKr2eJabKas1Ul+CC7VwF+O6qmzWnOg+j48BuEsqdQqtF1YXK4R+XP2jZ8rfX2Kz7xym/L806+T/kUOqhvn9iVOxXyUvd2qvRtSgenqxNRJ4viZ0I+v412eQ2ha6uE2qtSW8qMfszShYYrC9RxG779tggq+W5rXnU3qx6/d5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.169.0.179) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de;
 dmarc=bestguesspass action=none header.from=arri.de; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x237DThpXUNOG22VRWu5SPPd5VxDNCa7/nsyrT5pisE=;
 b=TC1YD5ux2YmhWYtlty6OI+3R89hOCh5HN1+zEcBRPnJuciqNnlYp12aMpYpWitkQszRU+NLbfJevjXcN9xnCA7zDwOu4mtwZ5xFKth5qixNeR0GPHA8oek6FigjpXw7iS0JH2xBkoKhi0rhtfd6ld2WZYI0AqE93r/9fQT7l5xw=
Received: from DB9PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::10) by DU0PR07MB8394.eurprd07.prod.outlook.com
 (2603:10a6:10:351::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 11:36:33 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::8e) by DB9PR01CA0005.outlook.office365.com
 (2603:10a6:10:1d8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 11:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.169.0.179)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net; pr=C
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 11:36:32 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.51)
	 by eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Wed, 22 Nov 2023 11:36:32 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 8256980
X-ExclaimerImprintLatency: 3279095
X-ExclaimerImprintAction: 6fb89411cf8e467890e3da5a3c33f79a
Content-Type: multipart/related;
	boundary="----_=_NextPart_d4bd292f-ff28-4d64-9b63-20e10b396cc9"
Received: from AM4PR05CA0031.eurprd05.prod.outlook.com (2603:10a6:205::44) by
 AM7PR07MB6328.eurprd07.prod.outlook.com (2603:10a6:20b:135::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.18; Wed, 22 Nov 2023 11:36:29 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:205:0:cafe::98) by AM4PR05CA0031.outlook.office365.com
 (2603:10a6:205::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Wed, 22 Nov 2023 11:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.3 via Frontend Transport; Wed, 22 Nov 2023 11:36:29 +0000
Received: from n95hx1g2.localnet (10.30.5.31) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Nov
 2023 12:36:29 +0100
From: Christian Eggers <ceggers@arri.de>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] Keeping STAMPS_DIR between CI builds?
Date: Wed, 22 Nov 2023 12:36:28 +0100
Message-ID: <1994066.usQuhbGJ8B@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CANNYZj83WzD9L6=rw3JRG4TQSjkPjCC+_5gatOzUDr+ZL_4bNw@mail.gmail.com>
References: <3556314.iIbC2pHGDl@n95hx1g2> <CANNYZj83WzD9L6=rw3JRG4TQSjkPjCC+_5gatOzUDr+ZL_4bNw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [10.30.5.31]
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: 
	AM4PEPF00025F9B:EE_|AM7PR07MB6328:EE_|DB5PEPF00014B98:EE_|DU0PR07MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e07e0cb-c9b2-4c2a-187f-08dbeb4f46e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 R5q2CQh//ONpWzDuq3fr6lIiwDHI/R9wYFrR2p67JlIZ/BIvU7ylStdjc9ymNQA9T/YoyY+816WK/OKT6PCnFcURn1LpbmsoiPaP565ezwnqjcdq6cxuL58f7VibEpxZ7y7YhITDxJXXR460bugxd6RyOv/vPv4Sm9E6vTKYZ6/qPwNzkqU3ODmYYvmX7KiNHrqwoKn9NCHhyuG/oAiGpwXJdUxCaKYKEWr2JzkGtOquyBzmPmKwpQotAhOlv8o/eWkSx5GnhdKItxRdsVSQ7w5qAig0Xa7NnS3wsqgK3mIpCw1I1UORTmYS4HgOC+FNuKlAqJHlsaSUO+Y10qHFGCcc7PjfQNXnwD6r3oGEYIbUkLWyX3EoK2I+wPWwAuoAFBadCUnKkqI4bfvXF0tYEOEh1aSZPAin8hpCtmccGxJn2TJjsyNPl6SAhLMzNLFo7I6oGJ3fRBMYwRJlRKVo6jUnJUNs5VzyClkI1xS9WlgZtMC3ttZKp9uoDQoBElIfWl9BrZ81PCtmmLlUHkr6oturUOJQIfHVwmxDVvoJBFsqXTLLDBYsmNU8JB5YmTYIDuGEGdltjHwszUd4s4DVWlDGLI4TC1LqD50XOikH3lNrNfXDIN4u3hbVwrB1FyhGcsqdvRwYOoTeV6wxmd5O2yAPPPOWl0IT6BpgAZU1JetdFDOvRvDul53xIJ2u3sF42XO5hz6hqe60y3aAJ5fscLgevq86Uxovt7P/BtFtzbnjcqgEpB18mTaWCuUQAPhx56mwVOHZErgWq9nsIrrBRw==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:217.111.95.7;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39850400004)(396003)(376002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(16526019)(26005)(36916002)(40480700001)(5660300002)(9686003)(9576002)(2906002)(336012)(4326008)(426003)(83380400001)(8676002)(8936002)(33716001)(316002)(6916009)(356005)(81166007)(41300700001)(70586007)(70206006)(36860700001)(478600001)(47076005)(82740400003)(86362001)(39026012)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6328
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	21f6e165-f5f3-4df3-c04a-08dbeb4f44e5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QvvxNgz+4ds+mhIUr338uv1hVObCJISmTc3aQfmDDIjvMRhlYlXzUvFRVzru5lspGUlciQQz1wRHQ5ejaGdeBfb4ssjUlWL2enKSdp1fmoFbSXCJEdVFBiWbIgjkQXoTyEcDdd4qs8Ypn5i4V/6iNyF+CEqMD6FI1fYscQRcu9Le0qT1qD2aCSIBcKdovRXmovJU+Meo1iu7u2TGeUhi5rvhPBkK0pECexeZBYp1JBmUQ5JzXAkdhpKT58tSfFAAAuPbPhWZOSNWCe0sc3BrbZhFAtpXKXAgEpdJyGWWKda4KqM+0MASjBDQF7umullQ+AbWWivyYcl4GFIJNwHbP/7Rd8oGe6MxyBH75DBr0Dt1plJsdtL8ibJOV9wh+5ByL3cjXotpRrtRj+E2imn5KCWN6sa7Z0gZnULNz8IacztYUWvG06ijhoJIDuL0/NLgPvX1UoLn6k/OiCfFlguzPPKZ5ize8OALy6sST0Zzh7JNIP+a1jm4Bysi5Ft5+XG2B8caFb5tEt0w+lVuAyLZohfSd3kctXapev6D4+kyHvE75hlwCYDSt0rTBup/kTd7oFrK7h57Z102jtcp/Qm7VcKocme+GHiRHGQW5CtPinWaM0GMJ1366dFhEYhIyV+p/YklnwE+PHZYkbYcQZzCqQlLlDjesVPI1gzouidz1w0NfEbg72DuasKiWvlC6zgqrO1900R6rKOwgZ5AuaEO6pTm08w9KwlQdOMxAnl+qTcG+Ifbaym25Smk757mGvxBW/xK8QIV+DMTQ/cJAFCgPrcqXNpLY9yj4y1uDdzuwTxh67RZjAo/ljSCtEfVanrS8UhO0aHwcxJNYc3Duv44ZZ+BCVDpQQwkWJbX3G8Lr6t/W+O+ItcMOBDQ4mz7CMoR
X-Forefront-Antispam-Report: 
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1690799017)(7200799017)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(316002)(6916009)(70206006)(70586007)(36916002)(9686003)(33964004)(66574015)(166002)(7596003)(426003)(45080400002)(336012)(16526019)(26005)(7636003)(33716001)(82740400003)(83380400001)(15974865002)(36860700001)(86362001)(47076005)(478600001)(8400799017)(40480700001)(9576002)(5660300002)(2906002)(41300700001)(4326008)(8936002)(8676002)(39026012);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:36:32.2248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e07e0cb-c9b2-4c2a-187f-08dbeb4f46e0
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8394
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Nov 2023 11:36:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15561

This is a multi-part message in MIME format.

------_=_NextPart_d4bd292f-ff28-4d64-9b63-20e10b396cc9
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_353afa75-6811-47ff-88ed-892693fe8290"

------_=_NextPart_353afa75-6811-47ff-88ed-892693fe8290
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Alex,

On Wednesday, 22 November 2023, 12:22:52 CET, Alexander Kanavin wrote:
> Your description shows that everything works as intended. If something
> needs artefacts in ${B} then do_compile has to run at least once to
> populate ${B}. Preserving ${STAMPS_DIR} would clash with that and isn't
> going to work. And do_compile isn't sstate-enabled, so there's no shortcu=
t
> that way.

that sounds like not every task's output goes to the shared state cache
(is there documentation about this?). As do_compile doesn't go to cache,
all previous tasks (also not cached?) have to be rerun.

Would it make sense to put the result of do_compile into the cache for my
particular recipe?

> I'd suggest that instead of embedding any build id data into the binary
> from its recipe, you can do the same step when building the image. There
> are hooks for this, e.g. ROOTFS_POSTPROCESS_COMMAND.

Of course this is much more straight forward (and what I already do). Be fo=
r
some use cases (automatic testing), we handle with individual IPK files / e=
xecutables
rather than with complete rootfs images. For this use case it would be help=
ful
if the application could "identify" itself.

regards,
Christian
> 
> Alex
> 

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
> On Wed, 22 Nov 2023 at 11:55, Christian Eggers <ceggers@arri.de> wrote:
> 
> > I build OpenEmbedded on a CI machine (GitLab runner). Between the
> > individual builds,
> > I keep only the DL_DIR and SSTATE_DIR directories. So if nothing has
> > changed between
> > two builds, I see that mainly setscene tasks are executed.
> >
> > In one recipe (the "main" application of our embedded product), I have =
a
> > special task
> > (between do_build and do_install) which "stamps" the build number of th=
e
> > CI system
> > (increments on every build) into a special section of the executable. T=
he
> > idea is not
> > to run the (costly) do_build step on every CI run:
> >
> > do_stamp() {
> > [ -f myexe.orig ] || cp myexe myexe.orig
> > # Retrieve original VERSION section size
> > ${OBJCOPY} --dump-section VERSION=3Dmyexe.version myexe.orig
> > SIZE=3D$(wc -c < myexe.version)
> > # Replace VERSION section (ensuring the same section size)
> > echo ${MY_VERSION}-${MY_BUILD_ID} > myexe.version
> > truncate -s ${SIZE} myexe.version
> > ${OBJCOPY} --update-section VERSION=3Dmyexe.version myexe.orig myexe
> > }
> > do_stamp[dirs] =3D "${B}"
> > addtask stamp after do_compile before do_install
> >
> >
> > This works fine on my local machine (here I don't delete anything betwe=
en
> > two
> > bitbake runs): After changing MY_BUILD_ID in my local.conf, in the next
> > bitbake
> > run only the do_stamp (and the following) tasks are rebuild.
> >
> > But on the CI system, all tasks of my applications recipe are rebuild
> > (starting
> > from "do_fetch"). This affects only my application's recipe, for all ot=
her
> > targets (where no task input has changed), only the setscene tasks are =
run.
> >
> > Summary:
> > ---------
> > 1. Only build id is incremented (but build tree is kept):
> > do_stamp (and following tasks) are run (as desired)
> >
> > 2. Build id is not changed, but build tree is deleted:
> > only setscene tasks are run (as desired)
> >
> > 3. Build id is incremented AND build tree is deleted
> > full applications recipe is run (starting with do_fetch)
> >
> >
> > I already found out, that this is somehow related to deleting the
> > STAMPS_DIR
> > directory (what I normally do on the CI system). It seems that the stam=
ps
> > are not required as long as no input of a recipe has changed. But as so=
on
> > as an input of a single tasks changed, the full recipe is rebuild if no
> > stamps are present.
> >
> > So what is the best practice for the CI build? Should I keep the STAMPS=
_DIR
> > between builds (as I do with DL_DIR and SSTATE_DIR), or is there a bett=
er
> > option
> > if I want to avoid rebuilding the whole recipe?
> >
> > regards,
> > Christian
> >



------_=_NextPart_353afa75-6811-47ff-88ed-892693fe8290
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>Hi Alex,<br /><br />On Wednesday, 22 November=
 2023, 12:22:52 CET, Alexander Kanavin wrote:<br />&gt; Your description sh=
ows that everything works as intended. If something<br />&gt; needs artefac=
ts in ${B} then do_compile has to run at least once to<br />&gt; populate $=
{B}. Preserving ${STAMPS_DIR} would clash with that and isn&#39;t<br />&gt;=
 going to work. And do_compile isn&#39;t sstate-enabled, so there&#39;s no =
shortcut<br />&gt; that way.<br /><br />that sounds like not every task&#39=
;s output goes to the shared state cache<br />(is there documentation about=
 this?). As do_compile doesn&#39;t go to cache,<br />all previous tasks (al=
so not cached?) have to be rerun.<br /><br />Would it make sense to put the=
 result of do_compile into the cache for my<br />particular recipe?<br /><b=
r />&gt; I&#39;d suggest that instead of embedding any build id data into t=
he binary<br />&gt; from its recipe, you can do the same step when building=
 the image. There<br />&gt; are hooks for this, e.g. ROOTFS_POSTPROCESS_COM=
MAND.<br /><br />Of course this is much more straight forward (and what I a=
lready do). Be for<br />some use cases (automatic testing), we handle with =
individual IPK files / executables<br />rather than with complete rootfs im=
ages. For this use case it would be helpful<br />if the application could &=
quot;identify&quot; itself.<br /><br />regards,<br />Christian<br />&gt; <b=
r />&gt; Alex<br />&gt; <br /><div dir=3D"ltr" style=3D"mso-line-height-rul=
e:exactly;-webkit-text-size-adjust:100%;font-size:1px;direction:ltr;"><tabl=
e cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%;font=
-size:1px;"><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical=
-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=
=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"left" style=3D"pa=
dding:0;vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" bor=
der=3D"0" style=3D"width:100%;font-size:0;"><tr style=3D"font-size:14.67px;=
color:#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><td al=
ign=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-ser=
if;">_______________________________________________________<span style=3D"=
font-family:remialcxesans;font-size:1px;color:#FFFFFF;line-height:1px;">&#8=
203;</span></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=
=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"left"=
 style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" b=
order=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:normal;font-weigh=
t:400;white-space:nowrap;"><tr style=3D"font-size:14.67px;"><td align=3D"le=
ft" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;">Chri=
stian</td><td align=3D"left" style=3D"vertical-align:top;color:#000001;font=
-family:Calibri,Arial,sans-serif;">&nbsp;<br /></td><td align=3D"left" styl=
e=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;">Eggers</td><=
/tr></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=
=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:normal;font-weight:400=
;white-space:nowrap;"><tr style=3D"font-size:14.67px;"><td align=3D"left" s=
tyle=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;">Software&=
nbsp;Engineer</td></tr><tr style=3D"font-size:14.67px;color:#000001;"><td a=
lign=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-se=
rif;">&#8203;</td></tr></table></td></tr></table></td></tr><tr style=3D"fon=
t-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table cellpadd=
ing=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:=
#0E50AD;font-style:normal;font-weight:400;white-space:nowrap;"><tr style=
=3D"font-size:13.33px;"><td align=3D"left" style=3D"vertical-align:top;font=
-family:&#39;Arial Black&#39;;">ARRI</td></tr><tr style=3D"font-size:10.67p=
x;color:#7F7F7F;"><td align=3D"left" style=3D"vertical-align:top;font-famil=
y:Arial;"><span style=3D"font-size:11px;">Arnold&nbsp;&amp;&nbsp;Richter&nb=
sp;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG</s=
pan>&nbsp;<br /></td></tr></table></td></tr><tr style=3D"font-size:0;"><td =
align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cells=
pacing=3D"0" border=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:nor=
mal;font-weight:400;white-space:nowrap;"><tr style=3D"font-size:10.67px;"><=
td align=3D"left" style=3D"vertical-align:top;font-family:Arial;">Arriweg&n=
bsp;17</td><td align=3D"left" style=3D"vertical-align:top;font-family:Arial=
;">,&nbsp;<br /></td><td align=3D"left" style=3D"vertical-align:middle;font=
-family:Arial;">83071</td><td align=3D"left" style=3D"vertical-align:middle=
;font-family:Arial;">&nbsp;<br /></td><td align=3D"left" style=3D"vertical-=
align:middle;font-family:Arial;">Stephanskirchen</td></tr></table></td></tr=
></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"v=
ertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"=
 style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"left" style=
=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0;color:#1532B9;font-style:normal;font-weight:400=
;white-space:nowrap;"><tr style=3D"font-size:11px;"><td align=3D"left" styl=
e=3D"vertical-align:top;font-family:Arial;"><span style=3D"text-decoration:=
underline;"><a href=3D"http://www.arri.com/" target=3D"_blank" id=3D"LPlnk6=
89713" style=3D"text-decoration:underline;color:#1532B9;">www.arri.com&nbsp=
;<br /><br /></a></span></td></tr><tr style=3D"font-size:0;"><td align=3D"l=
eft" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"=
0" border=3D"0" style=3D"font-size:0;color:#858080;font-style:normal;font-w=
eight:400;line-height:normal;white-space:nowrap;"><tr style=3D"font-size:14=
=2E67px;"><td align=3D"left" style=3D"padding:0;vertical-align:top;font-siz=
e:0;"><img src=3D"cid:image269418.png@4E1FCCD4.DB6AA5AB" width=3D"20" borde=
r=3D"0" alt=3D"" style=3D"width:20px;min-width:20px;max-width:20px;font-siz=
e:0;" /></td><td align=3D"left" style=3D"padding:0;vertical-align:top;font-=
family:Calibri,Arial,sans-serif;"><a href=3D"tel:+49%208036%203009-3118" ta=
rget=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#858=
080;">+49&nbsp;8036&nbsp;3009-3118</a></td></tr><tr style=3D"font-size:0;">=
<td align=3D"left" style=3D"padding:0;vertical-align:top;"></td><td align=
=3D"left" style=3D"padding:0;vertical-align:top;"></td></tr><tr style=3D"fo=
nt-size:0;"><td align=3D"left" style=3D"padding:0;vertical-align:top;"></td=
><td align=3D"left" style=3D"padding:0;vertical-align:top;"></td></tr><tr s=
tyle=3D"font-size:14.67px;"><td align=3D"left" style=3D"padding:0;vertical-=
align:top;font-size:0;"><img src=3D"cid:image393112.png@D29F754E.839E8AE0" =
width=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-width:20px;max-w=
idth:20px;font-size:0;" /></td><td align=3D"left" style=3D"padding:0;vertic=
al-align:top;font-family:Calibri,Arial,sans-serif;"><a href=3D"mailto:CEgge=
rs@arri.de" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:n=
one;color:#858080;">CEggers@arri.de</a></td></tr></table></td></tr></table>=
</td></tr></table></td></tr><tr style=3D"font-size:14.67px;color:#000001;fo=
nt-style:normal;font-weight:400;white-space:nowrap;"><td align=3D"left" sty=
le=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;"><br />&#820=
3;</td></tr></table></td></tr><tr style=3D"font-size:0;line-height:normal;"=
><td align=3D"left" style=3D"padding:0;vertical-align:top;"><a href=3D"http=
s://www.arri.com/skypanelx" target=3D"_blank" id=3D"LPlnk689713" style=3D"t=
ext-decoration:none;"><img src=3D"https://assets.arri.com/media/sign/202309=
08a_Stardust_E-mail-Signature_800x170@2x.jpg" width=3D"660" border=3D"0" ti=
tle=3D"SkyPanel X" alt=3D"SkyPanel X" style=3D"width:660px;min-width:660px;=
max-width:660px;font-size:12px;" /></a></td></tr><tr style=3D"font-size:13p=
x;color:#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><td =
align=3D"left" style=3D"padding:0;vertical-align:top;font-family:Calibri,Ar=
ial,sans-serif;">Get&nbsp;all&nbsp;the&nbsp;latest&nbsp;information&nbsp;fr=
om&nbsp;<span style=3D"text-decoration:underline;"><a href=3D"https://www.a=
rri.com/" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:und=
erline;color:#7F7F7F;">www.arri.com</a></span>,&nbsp;<span style=3D"text-de=
coration:underline;"><a href=3D"https://www.facebook.com/TeamARRI" target=
=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:underline;color:#7F=
7F7F;">Facebook</a></span>,&nbsp;<span style=3D"text-decoration:underline;"=
><a href=3D"https://twitter.com/ARRIChannel" target=3D"_blank" id=3D"LPlnk6=
89713" style=3D"text-decoration:underline;color:#7F7F7F;">Twitter</a></span=
>,&nbsp;<a href=3D"https://www.instagram.com/arri/" target=3D"_blank" id=
=3D"LPlnk689713" style=3D"text-decoration:none;color:#7F7F7F;"><span style=
=3D"text-decoration:underline;">Instagram</span></a>,&nbsp;<a href=3D"https=
://www.linkedin.com/company/arri" target=3D"_blank" id=3D"LPlnk689713" styl=
e=3D"text-decoration:none;color:#7F7F7F;"><span style=3D"text-decoration:un=
derline;">LinkedIn</span></a>&nbsp;and&nbsp;<a href=3D"https://www.youtube.=
com/user/ARRIChannel" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-de=
coration:none;color:#7F7F7F;"><span style=3D"text-decoration:underline;">Yo=
uTube</span></a>&nbsp;and&nbsp;<a href=3D"https://twitter.com/ARRIChannel" =
target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#7=
F7F7F;"><span style=3D"text-decoration:underline;">X</span></a>.<br /></td>=
</tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;verti=
cal-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" sty=
le=3D"font-size:0;color:#6A6A6A;font-style:normal;font-weight:400;white-spa=
ce:nowrap;"><tr style=3D"font-size:10px;"><td align=3D"left" style=3D"verti=
cal-align:top;font-family:Arial;"><br />Arnold&nbsp;&amp;&nbsp;Richter&nbsp=
;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG<br /=
>Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:&nbsp;Amtsgeri=
cht&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternummer:&nbsp;HRA&n=
bsp;57918<br />Pers&#246;nlich&nbsp;haftender&nbsp;Gesellschafter:&nbsp;Arn=
old&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH<br />Sitz:&nbs=
p;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:&nbsp;Amtsgericht&nbsp;M=
&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternummer:&nbsp;HRB&nbsp;54477<=
br />Gesch&#228;ftsf&#252;hrer:&nbsp;Dr.&nbsp;Matthias&nbsp;Erb&nbsp;(Chair=
man);&nbsp;Lars&nbsp;Weyer;&nbsp;Stephan&nbsp;Schenk;&nbsp;Walter&nbsp;Trau=
ninger<br /></td></tr><tr style=3D"font-size:14.67px;color:#000001;"><td al=
ign=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-ser=
if;"><br />&#8203;<br /></td></tr></table></td></tr></table></td></tr></tab=
le></div>&gt; On Wed, 22 Nov 2023 at 11:55, Christian Eggers &lt;ceggers@ar=
ri.de&gt; wrote:<br />&gt; <br />&gt; &gt; I build OpenEmbedded on a CI mac=
hine (GitLab runner). Between the<br />&gt; &gt; individual builds,<br />&g=
t; &gt; I keep only the DL_DIR and SSTATE_DIR directories. So if nothing ha=
s<br />&gt; &gt; changed between<br />&gt; &gt; two builds, I see that main=
ly setscene tasks are executed.<br />&gt; &gt;<br />&gt; &gt; In one recipe=
 (the &quot;main&quot; application of our embedded product), I have a<br />=
&gt; &gt; special task<br />&gt; &gt; (between do_build and do_install) whi=
ch &quot;stamps&quot; the build number of the<br />&gt; &gt; CI system<br /=
>&gt; &gt; (increments on every build) into a special section of the execut=
able. The<br />&gt; &gt; idea is not<br />&gt; &gt; to run the (costly) do_=
build step on every CI run:<br />&gt; &gt;<br />&gt; &gt; do_stamp() {<br /=
>&gt; &gt; [ -f myexe.orig ] || cp myexe myexe.orig<br />&gt; &gt; # Retrie=
ve original VERSION section size<br />&gt; &gt; ${OBJCOPY} --dump-section V=
ERSION=3Dmyexe.version myexe.orig<br />&gt; &gt; SIZE=3D$(wc -c &lt; myexe.=
version)<br />&gt; &gt; # Replace VERSION section (ensuring the same sectio=
n size)<br />&gt; &gt; echo ${MY_VERSION}-${MY_BUILD_ID} &gt; myexe.version=
<br />&gt; &gt; truncate -s ${SIZE} myexe.version<br />&gt; &gt; ${OBJCOPY}=
 --update-section VERSION=3Dmyexe.version myexe.orig myexe<br />&gt; &gt; }=
<br />&gt; &gt; do_stamp[dirs] =3D &quot;${B}&quot;<br />&gt; &gt; addtask =
stamp after do_compile before do_install<br />&gt; &gt;<br />&gt; &gt;<br /=
>&gt; &gt; This works fine on my local machine (here I don&#39;t delete any=
thing between<br />&gt; &gt; two<br />&gt; &gt; bitbake runs): After changi=
ng MY_BUILD_ID in my local.conf, in the next<br />&gt; &gt; bitbake<br />&g=
t; &gt; run only the do_stamp (and the following) tasks are rebuild.<br />&=
gt; &gt;<br />&gt; &gt; But on the CI system, all tasks of my applications =
recipe are rebuild<br />&gt; &gt; (starting<br />&gt; &gt; from &quot;do_fe=
tch&quot;). This affects only my application&#39;s recipe, for all other<br=
 />&gt; &gt; targets (where no task input has changed), only the setscene t=
asks are run.<br />&gt; &gt;<br />&gt; &gt; Summary:<br />&gt; &gt; -------=
--<br />&gt; &gt; 1. Only build id is incremented (but build tree is kept):=
<br />&gt; &gt; do_stamp (and following tasks) are run (as desired)<br />&g=
t; &gt;<br />&gt; &gt; 2. Build id is not changed, but build tree is delete=
d:<br />&gt; &gt; only setscene tasks are run (as desired)<br />&gt; &gt;<b=
r />&gt; &gt; 3. Build id is incremented AND build tree is deleted<br />&gt=
; &gt; full applications recipe is run (starting with do_fetch)<br />&gt; &=
gt;<br />&gt; &gt;<br />&gt; &gt; I already found out, that this is somehow=
 related to deleting the<br />&gt; &gt; STAMPS_DIR<br />&gt; &gt; directory=
 (what I normally do on the CI system). It seems that the stamps<br />&gt; =
&gt; are not required as long as no input of a recipe has changed. But as s=
oon<br />&gt; &gt; as an input of a single tasks changed, the full recipe i=
s rebuild if no<br />&gt; &gt; stamps are present.<br />&gt; &gt;<br />&gt;=
 &gt; So what is the best practice for the CI build? Should I keep the STAM=
PS_DIR<br />&gt; &gt; between builds (as I do with DL_DIR and SSTATE_DIR), =
or is there a better<br />&gt; &gt; option<br />&gt; &gt; if I want to avoi=
d rebuilding the whole recipe?<br />&gt; &gt;<br />&gt; &gt; regards,<br />=
&gt; &gt; Christian<br />&gt; &gt;<br /><br /><br /></div></body></html>
------_=_NextPart_353afa75-6811-47ff-88ed-892693fe8290--

------_=_NextPart_d4bd292f-ff28-4d64-9b63-20e10b396cc9
Content-Type: image/png;
	name="image269418.png"
Content-Transfer-Encoding: base64
Content-ID: <image269418.png@4E1FCCD4.DB6AA5AB>
Content-Description: image269418.png
Content-Disposition: inline;
	creation-date="Wed, 22 Nov 2023 11:36:32 +0000";
	filename=image269418.png;
	modification-date="Wed, 22 Nov 2023 11:36:32 +0000";
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

------_=_NextPart_d4bd292f-ff28-4d64-9b63-20e10b396cc9
Content-Type: image/png;
	name="image393112.png"
Content-Transfer-Encoding: base64
Content-ID: <image393112.png@D29F754E.839E8AE0>
Content-Description: image393112.png
Content-Disposition: inline;
	creation-date="Wed, 22 Nov 2023 11:36:32 +0000";
	filename=image393112.png;
	modification-date="Wed, 22 Nov 2023 11:36:32 +0000";
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

------_=_NextPart_d4bd292f-ff28-4d64-9b63-20e10b396cc9--

