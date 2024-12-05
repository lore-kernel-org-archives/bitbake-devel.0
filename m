Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81301E77170
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 20:24:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.72])
 by mx.groups.io with SMTP id smtpd.web10.21861.1733430268495572410
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 12:24:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=a9GwVr7U;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.94.72, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDKS2fg4heHzwPR4cpLOA2rUohTU2CGMItR5Sn1+aWkSPC2vgpji3koJqLSUQJ4ZudqAWcAzf9c+L6/+1gdGHgyTFxAgqjDWyWgcXupFEkkpWHqgkK9/ZteGQnT8sfypd6B85han0VGX8fZDhTh34GTBiWKj0fXV2JfTb4nF6x35uDhGQm2Txf63PwobtLDYCkwcdAut9zbR/9yV9/zJjsEzbJxKYe/OY2Wkz9WdqKq2NWJu20iXhusm0d21F48T3seIxHNVUkYUjpwkMD500fh9ObiALFemZzWG3kSv+9ojGvk+5ygRzDILvSYJM9avE0yicJX9FvUwvU1f9LhX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCiIe6jZxcyvzGtddxIcfWqHc5qsglcr8oyuQfQwBuI=;
 b=BtnHk2NHaG+TFo9ZJ/GUsEolHAdv3SkKlxD8ixdynBT5vy7mm4VceGPWCVbNCAKUNBttz4FCGJgcm3N8VoUiplaDmwslJBQDGCcgCybndri++ytLwz1zwJ3cUKffpD9vpBpXkxkKZuE0QqqKwzB0IKl/w27xzmQlUa5o2YOQYa+REKmczpN1haPukhAi/UicO7/3K9U1eFcrunxXo9ISiUFSDgK2D7jvcg1HmEePcFwJsw9dUQn1hgUv7uGX+ypGjh4zIxGIU69DAI76BCAoW9BGyCSQhi0NPTNhUOsMm1s3cBOhvPN20jdhm/xvtKXRzwu3099wfTUOu0qfuNbFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCiIe6jZxcyvzGtddxIcfWqHc5qsglcr8oyuQfQwBuI=;
 b=a9GwVr7UabkTXCXyPcDe6Uhosp18IGd5ixCxFbSXmEnPAMXW+NS8xtK3tFKl8U4bg8/K0cW1747LOYs06JDGX/J8ysBS12dXy01hMadR5BaLqz2vwImoBVBd0vBwfXtolSqL+bghrJbrP2EubPUjpePfQja8iNpl0cEcxs47IbtlTV9rHAPO9C/1dFK1RpAnxyPenhvpf6WjEpU4pbhoFj6oLlaQXfMWkrrKjIAImLvPjYV6ILS6OreT1kH/aEKwlTP6tcKzVDNFedOXaeHhOq5TWOoMy3/xgyzoHyh4l0jUnOYUVJ6O3nsOKIUDtfDODt+uWv/hcogopn4NbejUYw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Thu, 5 Dec 2024 20:24:23 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 20:24:23 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, "JPEWhacker@gmail.com"
	<JPEWhacker@gmail.com>
CC: "dave_clouser@agilent.com" <dave_clouser@agilent.com>,
	"steven_kirk@agilent.com" <steven_kirk@agilent.com>
Subject: Bug with SkipRecipe and multiconfig
Thread-Topic: Bug with SkipRecipe and multiconfig
Thread-Index: AdtHQz0+yx7PiPzVSNOEZrPjczrnLA==
Date: Thu, 5 Dec 2024 20:24:23 +0000
Message-ID: 
 <DM8PR12MB5430DF7192F8D0BF7E6F2BE58B302@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=d3d486f5-8e6a-44fe-91f9-1c879eb91f78;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-12-05T17:50:09Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SJ1PR12MB6121:EE_
x-ms-office365-filtering-correlation-id: c3795736-99a5-4172-341e-08dd156ace86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?rwo2jmPZ+3Ec1XJEymIh44819RZECcYI9qnXT186rxLcSZn7fXeoBInfJlIS?=
 =?us-ascii?Q?FbYUu9pMChWTWegPZEXaF+HMcKdzZQZRN/eM7eWXEM2fsEoEP3xwTZeU38HT?=
 =?us-ascii?Q?Vp/z4+ZypIqmG3/22U4S42tlz/IvOPrS1GY6ivLcHCJRJJd842hBzJQvwhwt?=
 =?us-ascii?Q?rZjMfGxJpDyQAB8FFYDkIj4M7KvRKJ4SdWP3A6QzIBpno6e6K7HaB2jLH3E5?=
 =?us-ascii?Q?T1Trfv19fFvf1T09rhnEFj2MYzUj4CtEujsWsWCcnd3Dm11gExUy9XSpqdOR?=
 =?us-ascii?Q?8JQMPOJBCPEroz8erQ23zDE0xKOzhnlAK6ktlydzetE9CTayIhAJWiYgIf2h?=
 =?us-ascii?Q?a7nfapmy/BKVOtbeuW4KL5H47r/m+IkG0pZRz8igOVszCHJtrt2RdB7WEpev?=
 =?us-ascii?Q?PG/ZQfCxTLovnZcLRe0N5nsGAn/RevVeOK01oLX9ZKF+R74KfKf+BEEJB1VF?=
 =?us-ascii?Q?AtOWFSPxMe3a1m+ne8rWHlPrJgsM9r8JCVyWtrjZEVLz3Z0EkHech+U3mEkc?=
 =?us-ascii?Q?Mwd3tF/qIi/FUKR156XlNSZRSvLvVdvDaPAioNEqCgc058kuiZaz55M0bU2U?=
 =?us-ascii?Q?kwIyJvFzWtwrxmOC2vvlujsUm6JBZXlW4ouAY2plcnzri3PVJWOO6FTlkxAs?=
 =?us-ascii?Q?5PDDdkXWndqNClPZCGGtRI4Stg0HE6kGLozEkTYi6V8Ll9nHhB6D66FBVJJO?=
 =?us-ascii?Q?APs9SVfspWncK4M0h7nmiAPSW2K+2Fk9AZ/HufRLMfiDfrdMe8icwvpffY+x?=
 =?us-ascii?Q?ueDwjsgmrcXA0I03JP0sY7BNBhGBnxySCVy+xwaOP08AbE6MQOyFgsfiCi7A?=
 =?us-ascii?Q?h2n5Evqzqn/tgECT0QiLfo22wjNb69Y2p58IrDeL4v5fBUqhHeztVavz4wDn?=
 =?us-ascii?Q?KXo02Od7GaG5jc1thMFzmIZ74zMdlroPIyL/RneGbWapP8U4W7wYLqx5Ij1q?=
 =?us-ascii?Q?Uc4Fa3Mqpy1tuYL79w7bMobCaSsUdKSnLXJK9FW/7yIPnkHGQz5e8PfFSuK0?=
 =?us-ascii?Q?IuLuXhyQZqREsLQG/55rTOMbJW9Ny5E8nIGRC81yKxIxSC24zUwNVRW0luT2?=
 =?us-ascii?Q?P+Z5kbCBBAhY+WmTEKzcUbGuMx3npbLlMP1NLWMb8rKkkT6nq6KxuXI2abyR?=
 =?us-ascii?Q?hhjW5Yjtz2eBaLc2lDVVsIPAiKn/q9IZmI4vtfGclQxyK6bou+deWzvqs80x?=
 =?us-ascii?Q?vwbend9lW+kkoXUC8DKJb0Mxar6+woxs/Ibqfq5mctTcz86tWp97PKHpfnmd?=
 =?us-ascii?Q?oeagorUO80k3Mv+/2LE/Em7a8YLm/1tqxl9UVTwBBCM55xX6WqcjPURPAJqW?=
 =?us-ascii?Q?VECzqmHOOShJtyO3hmAJ3eK2piHvKLl+jhYPeapcEqMm1Y1wjMWFVX4tiJFA?=
 =?us-ascii?Q?bwO5yw+OY5rM1en4fKCjzQU+7a2ib1Nafr/SF1HKH+kgmSNCVg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?SlxAFXzVea4d0vqY+HkvGNuphf4S2VpAPdhiBW4qBycN+9BIBAwd3IsslVC2?=
 =?us-ascii?Q?ca+TdX4o+c4HcQFwgUa6XqIxr67eQyUoX1vcVg3YlTU00ZVLvxxLrFfELR+v?=
 =?us-ascii?Q?dzeQ6X8zfMKlT95dgtTKozik7Y7X8trKDccuVgdiG0WYePw01laaEWD5lqus?=
 =?us-ascii?Q?HvOJQlF4KOsvLw6tHOncDdjPPaWutDJVZK12s/daME4VKURCB9SXPnyyQGny?=
 =?us-ascii?Q?RQs/yP/OSkh1l1gOqtc/vnZW6bKG/pSTlgNoAF1dC7VVOYMlpyXSrLrwuBdP?=
 =?us-ascii?Q?JM8dpsvGddXcuBgLh7l3f9yfC518xjfrfl8HKyCtIMAFST27dXdS3XIWIfk+?=
 =?us-ascii?Q?qPIATWEuKukQgZkUcqQvXmM7dR7A9gsxHYQX+d4CyHnHkprrA4CjBmlN68lu?=
 =?us-ascii?Q?TkV6o8N0PM5k6jOHnlzrZ7XZBjrCJT0J14Hnn2qohHmgIsd5ROMsbXhM/EjA?=
 =?us-ascii?Q?R++EVv6Wf0thTCj3YNJDr5uBfdsyRXgE/zJqvmZq6crqubDOcoDs/CJWsPOM?=
 =?us-ascii?Q?v+B/Tq0j84GZDTFt5YZdtTfbDfiLViVTTPIHFj3IYvUCXXTCnO9g+xIH/A8Y?=
 =?us-ascii?Q?+5VnCPJjrU7QUIdoYcYBTn7KvYAYH3Y0W3qZKbFjmFY+DnL2yzdhSjxVWuyy?=
 =?us-ascii?Q?tNDhpoyOETTiLvA/3BTihNsFGipYB09KZzyx8SegPL8rRnDFBtgbd+Iqd9U6?=
 =?us-ascii?Q?KepDGwcNIEWCD6uMbyMTme1nMQzd/irwdMNE2lPZgYya0jRY2XEPzoQcIhht?=
 =?us-ascii?Q?vrPBo3eKnNH1kURrrMmeNQo00gr7HjghoMzLLm1Q4g7x+hD4b2i4Z7Uvm6fN?=
 =?us-ascii?Q?pGGjVySosOP4QT7tjkV8OVMJDx4BR06dIEjSE/2qnsTLw0bnaPL5WYlHsEn5?=
 =?us-ascii?Q?FQ7sU7z2ujMKtJvnWwm+wDjnMSzbBRpcdEuOz0AbPYs0uMeXBkbzOXs8Gcsu?=
 =?us-ascii?Q?CVcQJNquze+vQksgKlY/ALOp1v7W3FiUaVeMliAUuYijNGX9gLbI+VWizb5h?=
 =?us-ascii?Q?gkEkMM629BOwXNxmOgAeu3OVieTxpEqAeVxjS9OCWwMK6UMmuerMUrTB0YFK?=
 =?us-ascii?Q?KxIapPfGFO445tQJhwpoGXpVcfUHWpGQ8KG4UpByOXqqcfw0KYN3sQK/4YPc?=
 =?us-ascii?Q?1XmKvvyRkMwNGZwjNdx+F+mv/j++qd6Re0cxqAXvrmpaf1KA2iAJJpZCcyWk?=
 =?us-ascii?Q?uGUUzoBtjzB71xgA2NHcvuCVJMltfDNhTRYsmwrVVEvo6mGJ1ouRESF0t3f0?=
 =?us-ascii?Q?xkD8ABJBOjD6tPPSmldSnSpor5BgXLaoHPgPBridQ3dJYHHd4aChA5hzH2gz?=
 =?us-ascii?Q?Y18YFqkUk394PUSDeHA/EXvHbvMehs/Y5WrN2MAHx8m3ryYKjEn7zO8W+nkL?=
 =?us-ascii?Q?MhiJ5fVeCPWFDI8PjlptxMXmsWZ2nQ4GJcd3MoCtY61atGvALJaV0K9XeJ7S?=
 =?us-ascii?Q?VhVbtT3IqMtOq4KpYX+7gaaNGLZbr9uRL14OCq81AiZfkKHb7ptiiPMl5E9W?=
 =?us-ascii?Q?jdwM3gwfUfJfYauGWBNxEEl1VY+BoUqUdNEhDjQyWsxvc4qtKYN6bUAQFBc9?=
 =?us-ascii?Q?ekPPBLE/0jznkesTiKe+s2461cpr2vmppL3EWCPA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3795736-99a5-4172-341e-08dd156ace86
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 20:24:23.1495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: km+0yHpw0fplhtoel3WFPytG41PfqgXnZnthjUXidHHrGevtoIX8Nmcq1MmPuEhoBQ8MZ9UrLSzPKJJYVn/L4iiC75LRX6MzuGQq2DgeTO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 20:24:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16888

Hi all,

I believe I have tracked down a bug with SkipRecipe and multiconfig. Before=
 I submit a patch, I wanted to check my understanding of the code and my su=
ggested fix.

The issue I observed is that when you have a recipe that is incompatible (e=
.g. due to COMPATIBLE_MACHINE) with more than one active multiconfig, inclu=
ding 'default', then BitBake will inconsistently report why the recipe is u=
navailable.

For an example, please see the below patch. It adds a test case to oeqa sel=
ftest that adds a 'musl' multiconfig (with MACHINE =3D qemumips), and write=
s a 'm4' bbappend setting COMPATIBLE_MACHINE=3D"qemuarm". The 'default' mul=
ticonfig has MACHINE =3D qemux86-64. I also modified the 'incompatible' mes=
sage to report BB_CURRENT_MC. If you run the test a few times, you should s=
ee that the reason is not consistent:=20

Sometimes it will correctly report:

    ERROR: Nothing PROVIDES 'm4'
    m4 was skipped: incompatible with machine qemux86-64 (not in COMPATIBLE=
_MACHINE), mc: default

while other times you get a message seemingly from the 'musl' multiconfig c=
ontext:

    ERROR: Nothing PROVIDES 'm4'
    m4 was skipped: incompatible with machine qemumips (not in COMPATIBLE_M=
ACHINE), mc: musl=09

I believe the bug is caused by the fact that BBCooker has a single 'skiplis=
t' dict, which is manipulated across all mcs. This dict is populated by Coo=
kerParser::parse_next:

        for virtualfn, info_array in result:
            if info_array[0].skipped:=09
                self.skipped +=3D 1
                self.cooker.skiplist[virtualfn] =3D SkippedPackage(info_arr=
ay[0])
            self.bb_caches[mc].add_info(virtualfn, info_array, self.cooker.=
recipecaches[mc],
                                        parsed=3Dparsed, watcher =3D self.c=
ooker.add_filewatch)

CookerParser has a separate MulticonfigCache for each mc (self.bb_caches), =
but it is using the same 'skiplist' regardless of mc.=20

I think BBCooker either needs a separate skiplist per mc, or switch to usin=
g tuples of (mc, virtualfn) as the keys. Then we'd adjust code elsewhere to=
 respect the mc. For example, in BBCooker::buildTaskData, this code:

        for mc in self.multiconfigs:
            taskdata[mc] =3D bb.taskdata.TaskData(halt, skiplist=3Dself.ski=
plist, allowincomplete=3Dallowincomplete)
            localdata[mc] =3D data.createCopy(self.databuilder.mcdata[mc])
            bb.data.expandKeys(localdata[mc])

becomes something like:

        for mc in self.multiconfigs:
            # Assuming we use the per-mc skiplist approach
            taskdata[mc] =3D bb.taskdata.TaskData(halt, skiplist=3Dself.ski=
plist_by_mc[mc], allowincomplete=3Dallowincomplete)
            localdata[mc] =3D data.createCopy(self.databuilder.mcdata[mc])
            bb.data.expandKeys(localdata[mc])


Does this sound reasonable?

Thanks,
Chris


diff --git a/meta/classes-global/base.bbclass b/meta/classes-global/base.bb=
class
index b81e61fdb7..a639792504 100644
--- a/meta/classes-global/base.bbclass
+++ b/meta/classes-global/base.bbclass
@@ -560,7 +560,7 @@ python () {
             if re.match(need_machine, m):
                 break
         else:
-            raise bb.parse.SkipRecipe("incompatible with machine %s (not i=
n COMPATIBLE_MACHINE)" % d.getVar('MACHINE'))
+            raise bb.parse.SkipRecipe(f"incompatible with machine {d.getVa=
r('MACHINE')} (not in COMPATIBLE_MACHINE), mc: {d.getVar('BB_CURRENT_MC')}"=
)

     source_mirror_fetch =3D d.getVar('SOURCE_MIRROR_FETCH', False) or d.ge=
tVar('PARSE_ALL_RECIPES', False)
     if not source_mirror_fetch:
diff --git a/meta/lib/oeqa/selftest/cases/multiconfig.py b/meta/lib/oeqa/se=
lftest/cases/multiconfig.py
index f509cbf607..c74bbd2fcf 100644
--- a/meta/lib/oeqa/selftest/cases/multiconfig.py
+++ b/meta/lib/oeqa/selftest/cases/multiconfig.py
@@ -85,3 +85,24 @@ BBMULTICONFIG =3D "muslmc"

         # Build a core-image-minimal, only dry run needed to check config =
is present
         bitbake('mc:muslmc:bash -n')
+
+    def test_multiconfig_skip_recipe(self):
+        config =3D """
+BBMULTICONFIG =3D "musl"
+"""
+        self.write_config(config)
+
+        muslconfig =3D """
+MACHINE =3D "qemumips"
+DISTRO =3D "poky"
+TCLIBC =3D "musl"
+TMPDIR =3D "${TOPDIR}/tmp-mc-musl"
+"""
+        self.write_config(muslconfig, 'musl')
+
+        # Write a recipe that is not compatible with qemux86-64
+        self.write_recipeinc('m4', 'COMPATIBLE_MACHINE=3D"qemuarm"')
+
+        m =3D bitbake("m4 -n")
+        m =3D [line for line in m.output.splitlines() if "MACHINE=3D" in l=
ine]
+

