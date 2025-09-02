Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2274ACA1010
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=euNSxvpk;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez0LmgP7hnyKRb+ISHZkOHEWN9UDQNKeWc/OruFltaLEcxR4Ys4OdDguMoUyntRzYK9/8qW8t+FMUmx53pntQa8eXBHmMK+RQtunQrXENEp2A+OCgQ+DUVPZMmLgSpmqgO9ccpMMIi9E/t/LwwnC1bOA6R2mtnJqIE+YwLCuvR+Dc6L2vtD1IU+6qzoVnjwgMBozX1msZLepSOV2C29F64tXLw661bqPjLJJW7W/TUiTmA8jMySqIycwmrwZjtP5cMsD7W3KAwUUVsFxSGuY3+6eWdvIjqgaaNFbOumGzJvBXENpzFEIrEfHXp2Q1hqPIF/DGEK52dW38avwJIMfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFRoA7JRy7OshtUdplLpdrbr9Tx6NIq1eHXePa49Zl8=;
 b=wORWqin5WbzOK5rys7XX2oHX5IrEFuJEYusLKJcAdEs2Tea+OTEOPAMnFqCWEIf6JCAKj91XrLQkS0BJGttTTPJ51SmU4K6SZkReoumRrERDWGCgLXn8EllgkrUVPm/33mdPxX69LkhoXggif5/AwRpib871NwkylD9bh4wplz++yh6pMwDMB6ooaPe+z0ml1yyzKBrOhDu8PJ8S6hPU/n6XwTqj7bVV5+GQEEjXFPP4r49dxIFVL0j1mOYopCT+p8fq+3ADNCxi/Kl5Dhn7rIkBoDrfaM2Tmg9XBU3nLA03bgHzslGoLodXPeMLQ6j3/qMjnlACPkcfrn3NbeBxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFRoA7JRy7OshtUdplLpdrbr9Tx6NIq1eHXePa49Zl8=;
 b=euNSxvpkxcMVHjO7lE6EmEohb4v0HcaPiovRLtnAXXDkb2yX8We/2gI57YJKT3RiZU5apmrCOrCESzBA4xAbIlNpO6UR+1aa6YWNO5zdeCdVeKSTGtQOjpdyfR7u9XhKbI7n6bFfc6kW+FHlcHpw/iRVuVg+O8WUbd1q1ZTg5rUVsOaxPlXuQ7EVoPdjydVnDb0Eu1Z62Rv+Zct3Pk+FSMPDdeHPX+ocL+2zLBMcSXLX1IYbpum/9xPVSSCXgvseJhR/S4JIR2WY3fZ3iTBFH8Dvpn/R942fYWiNzKReOWxqhShAlC1O2B5MtLxqUDaDBdTPHd/0FN4ACbtI0jQ+qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:43 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:41 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 09/15] fetch2: gitsm: use subdir parameter for submodule
Date: Tue,  2 Sep 2025 08:45:08 +0200
Message-ID: <20250902064515.30879-10-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd53c2c-ef5e-4873-fec2-08dde9ec5478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hJQHeYJt0oeQxjHMyNMvTUZWKMQ0Ec/Ln0MVBcnVadsSV/KLkYMqX97ay71y?=
 =?us-ascii?Q?TxrgmVoRe3GTH525CGElGVxGWurPKP/oAw6SL2gfhP/v0mX+AE8fu4jEbDC2?=
 =?us-ascii?Q?6eDrnCJmeQXBG5uCFYzEOrvP33ic4L5NJPSZixrfAg6NKapNqF8lxYgndErf?=
 =?us-ascii?Q?cPL0+nrqllHG4ngWryIX5Zq19FrVKtv2ZYsqMxoIJGcl/ELrxLx+iPJVPO7p?=
 =?us-ascii?Q?7hJE3hZdtRQ53FXG83u8swKO2cr/OIVn2IL6tOXTF/5itgm2mfa4gRCAa9na?=
 =?us-ascii?Q?t2E4gs12M0OWiHUw8p2xkqrlLBY7f/eDA+D7vDZpvt2wBVZi9eJCPgtzo/KD?=
 =?us-ascii?Q?mDuZywRdqX4VBOZMKuhGbXMTcyx8eXsiluPV8Wkf1OVk9836KLtTQzmpO/PO?=
 =?us-ascii?Q?YNYGKTE+8OL8Zh8sT4zb3NY3W0xaoQeCviRmO5UbJ8PnnaSgeMtJP1fsLiGJ?=
 =?us-ascii?Q?fHAnnpxUr31fqU9FKwuX819zwz4gPYSzFa2pLPs2gB5grL4lv6Nbhp94Wxfv?=
 =?us-ascii?Q?yJdOwOYmRuQnWbbH/RaB7ck49sQpJdOS3XsElYBjWtAKSGEwhXK6mGluzZqQ?=
 =?us-ascii?Q?yvUbIrRDzrJw7C3vLSGlfgAkk6gg6UORvpaqLxYlFFYknZ9Mz6bhNkGhyV6w?=
 =?us-ascii?Q?+8t/lko+DPZxid9RvkA4V1YpJlZwO651FLsyOxmd+x+buqh1eQRH0RKSZhtH?=
 =?us-ascii?Q?iaVyGJ+O4jrCYJlRxQL5kEgouX2kvM7zTGtBQ7wMisuc4T29RRSQa0tSbY1k?=
 =?us-ascii?Q?avhzL/t9yJ/e03dY3p2rEXvWiLBvpioNCFJUL6hlljHVJawbN0u3TEjrTpEN?=
 =?us-ascii?Q?z6X6zk7u6E7c+4y6BPUlciKbzjIGvqmd2mOd3ipcdRv2WRW1pD3ThvcrvLsy?=
 =?us-ascii?Q?VbLrbkKkrBnaeVsGQ6OCBSYqsZhasC9tiyyJk/lT32JL8FOZ21EKmtfOLoRK?=
 =?us-ascii?Q?Y9MZpFgDEVc+g0qZNisAC942ARuCuLAAG+mmb5sECTyEg4rgLSlvX9Nd8VFO?=
 =?us-ascii?Q?ebmPtexQgWNE7HGF6xID+8ybWCkIKg5nrz3GomplSddscVKvjJJQu5lKllG1?=
 =?us-ascii?Q?KMboyFsbdywIPaj2eKLsORmYFUeb68+7uTkqtZvdxe1kqIHdAMRhqf/MMI8n?=
 =?us-ascii?Q?yNdpYd5zicX2/Jl4Oqho9OxKfLX35upo7H3eBOJeh+iFVni1dfbHb+hHKUeK?=
 =?us-ascii?Q?G6IfHTyDruLfWKtehEdhs3Gu8aDoPLzNa6dpiHLIa3Ik+8KJOkNNp41yZZFQ?=
 =?us-ascii?Q?zTInDRf4JMXdl1U2Q1Gv4LG3ZVHbB0psV1cGw+rnYPqTD9rtLNgMyInj2VO9?=
 =?us-ascii?Q?CsIgOOfhG3+o8gLk520lnsIFpvJt0hwlklc7Yl0W6HoV30d/YI6PVFGpQd17?=
 =?us-ascii?Q?S+KV7YCmEfQZiuuy8dmXx3Zjj17F36tG6z+4BrPv4H/eI9Y0P604nqJlVMsA?=
 =?us-ascii?Q?gMAJqNQm6ah/ZU72QOd6vjtw/NCpudZYjX/me9uJ4YhDSNosnbFlpg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?317rIKShk9zfwADNrEYILBjlyBIva48MnAKY7nb8oq4JUGUB4BwK9TDzs5ly?=
 =?us-ascii?Q?h8GHHPi2EDLq7z6jzordVgdNcSmiDJKjPl1PvI2sevRpsuYuHz9KuWXbPD1e?=
 =?us-ascii?Q?xgnwXZtbZMNlHSeWnFkoxy0VnV6hqQHapzu4Hhl/mtqTBeBAKoCslasIsale?=
 =?us-ascii?Q?PVJGHwzX5RpEtQ7nygIgArTQFEn7OlVf0onCJlc/dIMhVoFVPeFOpEV/zVh4?=
 =?us-ascii?Q?5jtp7snIhnmUhMQ7ANZGCoyrF4CUZrDZ5IW9cCbmn3kiwXPckj6c3azZvWSr?=
 =?us-ascii?Q?IQ+WdHjq9sFWoenWFzKAILEz/nOCmTVytSMhcdiuVI33bUJGEnR5+46ZZfZ9?=
 =?us-ascii?Q?fi9enx9iOIqmiEE1GxjRDXlG4Y4TMeGQ4uHE9bR12+2udLzJA7a1saomUuwf?=
 =?us-ascii?Q?k54Gfdb001tH4p4pyLyHZCE78NLlGXZxYrwjQ1teq34VsI7QtSf1b+akbsfS?=
 =?us-ascii?Q?aqufDpF8q6DI00JibmZHGmXrdb25OgbovYtqTrblWK0Q7UwCa0rhWNXenae0?=
 =?us-ascii?Q?+iY+v+RxfbrUXnJiwPiIQXv+dyv6z+Jjy6lCcO6JpDQa93UaTSQhZw1ZCoj6?=
 =?us-ascii?Q?xHK0BEYguTnruVl96LDrKDkeJZ7zAPYZtKPYTVWCPws6opNO/aaZbCQTZizw?=
 =?us-ascii?Q?Q07LTzqkuOiZkJyvl3gsh2BLB84pPpoKXpgNZYjCguu+Q0fyMn/U+EP+ifvl?=
 =?us-ascii?Q?YxnMFn4t4QF1EqD8NyaoTk2K0viyyp0Qth8RE5O5m1dDn73Zap9oMo15QFLW?=
 =?us-ascii?Q?MmONNSDztws8qWyelf9K8unnMK8lOHjCeuEC8jPXoS6C5ITsa4xS0Ps1dbuT?=
 =?us-ascii?Q?bXANTwN7t9RPuJ8pxNllr6FND6wq9Ae7qrg7VrcmKX/SntcDOl60PfCDv8rM?=
 =?us-ascii?Q?buysLJEm8Z2VwHzrgOMJSm5o6O5A1uCddsV84Km2hnl1NY8QtIVhVwi8i9st?=
 =?us-ascii?Q?B9ZD1IX4wFhS6HruEqoy/cUAXv5/ACR0gjv3arRtykS1QtCR6x2CHEBoGx28?=
 =?us-ascii?Q?r/R0vHrM5o+NMavV/86fXw3j86hjM7qmt1Bae1bbCYxMN5Od7LeGUPUr77jx?=
 =?us-ascii?Q?Y6TR8b17wIpCfK0sj0xG06VQMJjllYQbrPo2A1Xu2a9E/2oxDPRRh8OweFAq?=
 =?us-ascii?Q?fvKDV1lXS94eio9/AqotZoRPaE3YoQr+0UvHjFu0BRRYtbjfzYdcBNzGsx67?=
 =?us-ascii?Q?OqwYtYhzwUs7h/g4VgBuaQHV9ey3hvCRzs9QlUNyqf8Uq7S6GV1NLgFKwhQG?=
 =?us-ascii?Q?hGa91FifGuU/OHgGgp/lGvzirLEXtH6h4PguN40uRdyLCOdzK/KQgTYVUimC?=
 =?us-ascii?Q?gT7bTvuuhUDD5GUkFYLo/cZrM+qiI7/pHVuORPXxtt1A4xAyEdP6nAITODXy?=
 =?us-ascii?Q?n6uWOCcuCh/LJ1vNS4sMZTXCMKIbgl9nllkiSzjrFFTFg13Eu2gygs8XgmTM?=
 =?us-ascii?Q?vIApW3AmAH8rLi3dvTEVtaAHttOGdyY/uL303Anv6ulEWrYKzZTLKZ4wMnBL?=
 =?us-ascii?Q?8wP1w7o8c3NGfAphC6LHu9j8mLtFulFbviZA0B88vDwQPSa7UZYQulo7deMV?=
 =?us-ascii?Q?xsN+kAhe/+JHl91zH9pGcuP7/8dah9yC7nyPF1TMpcMtDB86uPOT5JTItSC5?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd53c2c-ef5e-4873-fec2-08dde9ec5478
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:39.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrS80dw4hgHo0L6ZjfNAReE0xU22nEYw2h8jaI9eDeVj2rCSO8SOa5ywYoe/v0KZu4z0V4/kGN4V89sBcV54uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17927

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Use the subdir parameter to pass the destination directory to the unpack
function.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 953a1ca39..d013a09d6 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -125,6 +125,12 @@ class GitSM(Git):
             url +=3D ";lfs=3D%s" % ("1" if self._need_lfs(ud) else "0")
             url +=3D ";rev=3D%s" % subrevision[module]
             url +=3D ";bareclone=3D1"
+
+            parentdir =3D self.destdir(ud, '', d)
+            gitdir =3D '' if ud.bareclone else '.git'
+            subdir =3D os.path.join(parentdir, gitdir, 'modules', module)
+            url +=3D ";subdir=3D%s" % subdir
+
             # Note that adding "user=3D" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git:=
//
             # URL a password is not supported, one have to use one of the
@@ -194,15 +200,11 @@ class GitSM(Git):
         subdestdir =3D self.destdir(ud, destdir, d)
=20
         def unpack_submodules(ud, url, module, modpath, workdir, d):
-            # Figure out where we clone over the bare submodules...
-            if ud.bareclone:
-                repo_conf =3D ''
-            else:
-                repo_conf =3D '.git'
-
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
-                newfetch.unpack(root=3Dos.path.dirname(os.path.join(subdes=
tdir, repo_conf, 'modules', module)))
+                new_ud =3D newfetch.ud[url]
+                fulldestdir =3D self.destdir(new_ud, destdir, d)
+                newfetch.unpack(root=3Ddestdir)
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (ty=
pe(e).__name__, str(e)))
                 raise
@@ -217,9 +219,9 @@ class GitSM(Git):
=20
             # Ensure the submodule repository is NOT set to bare, since we=
're checking it out...
             try:
-                runfetchcmd("%s config core.bare false" % (ud.basecmd), d,=
 quiet=3DTrue, workdir=3Dos.path.join(subdestdir, repo_conf, 'modules', mod=
ule))
+                runfetchcmd("%s config core.bare false" % (ud.basecmd), d,=
 quiet=3DTrue, workdir=3Dfulldestdir)
             except:
-                logger.error("Unable to set git config core.bare to false =
for %s" % os.path.join(subdestdir, repo_conf, 'modules', module))
+                logger.error("Unable to set git config core.bare to false =
for %s" % fulldestdir)
                 raise
=20
         Git.unpack(self, ud, destdir, d)
--=20
2.39.5


