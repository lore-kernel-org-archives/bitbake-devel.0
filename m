Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.74])
 by mx.groups.io with SMTP id smtpd.web10.8877.1631091032465341045
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Sep 2021 01:50:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@cherrycloud.onmicrosoft.com header.s=selector2-cherrycloud-onmicrosoft-com header.b=pymBNfXh;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.7.74, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InF+eWNs7Kb7BGjGLEd+JchKoJcnpqFMSst39sx3z+153Xzbo9HJnAw1Os3AGS2FGPdDPvSd4cvfR7vI4Pex6bs49ZOmKpQY+JMqmR3hNrJLWe2VtmwzWRTVrAdsSR6zh6rlhbKFwPmK6WvxbqJc/S3WSYqQOAx5s13bylz9KNzIWaawbICps/7FwwD7tkhm+ffwN5f6DytC3pevRL5hN9nPieVBowILeOhaHG8I0mlLDioV4nD5CoKjICSI2kdgGmLWQ2qu99BVfbyfRFvOTLAVvTySzeN8ctYsh+qkjbGFLhoVNKHuj5n3HpfcD8e2LnqOwBZwVO6aegF3fJbkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=chb9X8INg48LUE64OVY9s9m4euvp9F2ljokuyuxFZt4=;
 b=GVbL8/P1k3cjRVVx22yV9eytW8IKCMpYn0kMU3JDCrs/fStCI6VKqsOYpcIoZMTKsue0tJh33/YIIPNvRBgvm7Z5GrjlD9pu4BdrlBIJCOOyOeCyuaelrbtg+pa7esCa98DUJ9mBvz4eZxiEYBg7bYp0Zri+7JWQ0c+RtFS0vRDckQLk1UWawnKV1ZzAb1M4O+wFQN6wKVU7boQJLVxl9RfuFl2RdFZfLLVN/3VH6hd92JyyvB8lORi+tBCbHFvFAmt/caS0leawznHtwsLCA5jcaOvyfKXNOGCKKi4NTUQp7Le8sedEzNvFMoYrFb7HlJi3to9lm/t+mDB71G8pRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chb9X8INg48LUE64OVY9s9m4euvp9F2ljokuyuxFZt4=;
 b=pymBNfXhVWFAE8AnWO+y0/78IUrTTd26733TFOE6vU5wMT43H65BF0PkJ1TO5u+efIbpAYjpBSXyJ9NyPyx6tUwUa5O4BHKZgXB7UXRv3byUuZt/fvrJpbF+Y0G95+Km2Me4nTJNLMLT6hONTAULnbZQUFxtUvgMYtTHsXsII+E=
Authentication-Results: lists.yoctoproject.org; dkim=none (message not signed)
 header.d=none;lists.yoctoproject.org; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB5939.eurprd04.prod.outlook.com
 (2603:10a6:208:111::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 08:50:28 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::7987:898f:55bd:ec64]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::7987:898f:55bd:ec64%7]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 08:50:27 +0000
From: "Quentin Schulz" <quentin.schulz@theobroma-systems.com>
To: 
CC: docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH] doc: bitbake-user-manual-fetching: S should be set to WORKDIR/git for git fetcher
Date: Wed,  8 Sep 2021 10:50:03 +0200
Message-ID: <20210908085003.963899-1-quentin.schulz@theobroma-systems.com>
X-Mailer: git-send-email 2.31.1
X-ClientProxiedBy: AM0PR02CA0124.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::21) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
Return-Path: quentin.schulz@theobroma-systems.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (92.42.140.82) by AM0PR02CA0124.eurprd02.prod.outlook.com (2603:10a6:20b:28c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 08:50:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd9478f-9770-49ac-e21a-08d972a5b4c9
X-MS-TrafficTypeDiagnostic: AM0PR04MB5939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB593985A36C5461559C968B00C2D49@AM0PR04MB5939.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iPrt3mmGFpreQ7JhfMNvCTGocm+C6TntfiV0fEEFs1YsvRXKCqP7EHQlCGaWn3WBMiVfNs4Z1atiSiBM7o14Flyy+VpOS4HPPH4v3yBaprkmqzi650pWYpb3ytz04c8KPNgm+fiD5wYZe/0Xwg9/av/jPUAIR42ZxMvmYKoZGdBle/+LS38vYd1PAv3/sOrP9wg4n16+WhEaaPLgjURiy/NlqaaFTLWrxyLUVKjGGxQspndmHol2IXkUQfjLaumKkY2X7XnJ/j/kFWADY80YxiJOqNTxhhWGv2i4mEeEt7WQ3MiL9UtiG81Z12ssN9JQWX4rWFs+6gBVJMzMJTL8227Vk1Sp8lbvwBvmMImK1TtYE8PXnxU3uVY8moQtxckDsHgXRTnXejdcbm8veDrv9iqNAbDozJnWmJZhbUp69Ex2LoiZ1vZQaYd4nIT8Qinp5HuLV8VVx7NvkKpbGV+90/1La54pTX+fbZ8goN14dhEIyOBB5a3OVN17fEBOrMNo4UsfXwQ5VYBlrh7nLAUaGgziqP0ehO12MRV+9/D57BAhS6RwcxoyziorSL/EVZlSrJYrb+qADHq3YH8SY3LsBWfhge4sDWt2q6kntCTNuGSjgbEKaY+RvC81uM9Akvu3D6EIKKBNAZS8noaSvjzZsKxHg0oQBIXgnTQb+n1cPEuOGYzy5Bpg8QNr0G2hMaBleoE8L4sWVDnJ5VHoAgrcaw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(396003)(136003)(376002)(366004)(2906002)(26005)(316002)(6512007)(66556008)(86362001)(6506007)(4326008)(66946007)(36756003)(186003)(44832011)(52116002)(38350700002)(66476007)(5660300002)(38100700002)(2616005)(478600001)(956004)(8936002)(6666004)(6486002)(1076003)(109986005)(107886003)(8676002)(83380400001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a853GWb7kQ0xKqMzlYqC322ff70LKIJa2/hcah/wM1pP2Cw+730VsBRDezNx?=
 =?us-ascii?Q?YJYJDpQagz23gZCZzlLbGbjkJAyVp/mu2VG37SXp5OkAuGDg4g1OpczwbEvT?=
 =?us-ascii?Q?Hr/OOkSdM6iZsru4eimEnTKCdiuBM5DMyT8xF0KVR3j1ycB27SfX/+7ubu+N?=
 =?us-ascii?Q?sg18vPpakxsOfNzhlE+v16EpDk1We+VGnHBPiMnCvGCuUIznX0yBBzdmvhZI?=
 =?us-ascii?Q?6PRtQRoLks4M8BJHBv7TQXnFx195MGcAUjmr1yFA+ZgSjIisQtTkjLYUGDfe?=
 =?us-ascii?Q?Hg+Rc1t3bjE1XWL/qpyuWyvXx+LLeba5yc5O+ZD4T+RT1yT8PlMuPNFTACwP?=
 =?us-ascii?Q?no1MNpj9ZhHuD5jz0r5uBob70hdXyQv50sSPoyv3q/55oO9ccDsOqOT3Cr9O?=
 =?us-ascii?Q?+fhazCDowoCvBfZehm9mLcHX2OLGdSi0eqqId86PtLaxlEiOY1Mc3DqOBBx/?=
 =?us-ascii?Q?wfAzsSOoIry0CkHyh8Es6o4XNQmNel11yuMP2NLUZv7+rS6N20219ktvScu1?=
 =?us-ascii?Q?0KDnYlmle12VmKJF+WQYt4GOQ/gKRAdcM0Xh3yA9kfBVLP3/0KiseYIBV9aj?=
 =?us-ascii?Q?e+gclMp/xiUGnrmZnEhucijiT6sUy7fcbfv1z1/BUDCHl87TXrlIYoA38tU7?=
 =?us-ascii?Q?+ITRyytBxnvcP6bYEm1KyB/wn7ywro0rgPumqQFpqSA0Q6+ekG9s/749Z9ip?=
 =?us-ascii?Q?0eHzqQeICRWBbcqJMPWYcXOIZg3tKVPEsCwiOu7fviMg7a4I5WnUGvQilk8u?=
 =?us-ascii?Q?loSj94dawgrooC8rRY7ZGI9oIGG4r+gbRAazmobtBhK3/4C2h8VnQ/Vrqpnx?=
 =?us-ascii?Q?qhnV7+yNsxKlCAgbYvWZGfffTgmn0cB3gq5OeFbE/zdTfe8DKfF5xKahe5V7?=
 =?us-ascii?Q?IFsURxNhr6wYgu1Ur1xAnGJHonjgvS4VWrajeYrZHL3mr4pDwMB+okk1/oCo?=
 =?us-ascii?Q?iPRP5eRYAgrRo+IB0jasLcfQiHPrJpBT5Ba4AIwyIQUVpdbEf6p4+r8976ur?=
 =?us-ascii?Q?FCXCTjkhL97GWrYUwFAGTl9jbDouLRQOO08xkeD59Hg+Dumzem4wCVr7qLqQ?=
 =?us-ascii?Q?FMxHtuiskhNV9LSEP7i2qlXepGWwOJ7q+7T0QbhceD6Uqc8L55EVeE6ki8yJ?=
 =?us-ascii?Q?fXkYC0/tpUTc8cfSTK4R9pvMYvwFIcFC1bcSuJYB3XpADNzDayLiVxAXuxWa?=
 =?us-ascii?Q?U0TxUoVySLC/Vl6u7w4RXyGJ6iXD6eQidLiY0LM+9cK/aV/MHVCdsmxdHK/X?=
 =?us-ascii?Q?kzMF+vRN4Pe75hsEhA88BjZMlu4wAun7Np6jYLdTZq24eytvK3iNC612dL8r?=
 =?us-ascii?Q?l5SBMe8+5DFLGpNK74keVmFx?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd9478f-9770-49ac-e21a-08d972a5b4c9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 08:50:27.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mp+z0K83QQuoJ8oK19wx/0z19r6X7A2wzqYx+Q6Cu+HdCkiBrdDRyWQ9Ip5xwtJangNI/7Zrt37Xr+jSKwJ8uRGPa1iZxutgApN162/oGILoEqljDl/2SQVVR9mgbFTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5939
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Document that S has to be set to "${WORKDIR}/git" in order for the
recipe to work if the git fetcher is fetching the main source of code
for the recipe.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc=
/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 40b245b6d3..aad0700180 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -439,6 +439,13 @@ Here are some example URLs::
    SRC_URI =3D "git://git.oe.handhelds.org/git/vip.git;tag=3Dversion-1"
    SRC_URI =3D "git://git.oe.handhelds.org/git/vip.git;protocol=3Dhttp"
=20
+.. note::
+
+   When using ``git`` as the fetcher of the main source code of your softw=
are,
+   ``S`` should be set accordingly::
+
+       S =3D "${WORKDIR}/git"
+
 .. note::
=20
    Specifying passwords directly in ``git://`` urls is not supported.
--=20
2.31.1

