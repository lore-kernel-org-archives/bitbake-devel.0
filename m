Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8F0C2D0CD
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 16:34:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web11.3579.1747845240907755638
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 May 2025 09:34:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=TDpDuZiy;
 spf=pass (domain: siemens.com, ip: 40.107.21.55, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2jCL97WBhyxmBVXItul7+ir5e9AapJtGw9iSd39QQbIz50rcC7j//KtoQ9k3iWLAj2MV/vHSVrS8p8yxmrZePZSPLeKWIYTEKp1KIqr3oLeuzB668cY8/fBASNBqBgn3ktsASZB28v3Pkgqt4HNGM5KL3anqxL5zvZ2rQBn/FRhWZjAc6oZ6+US7T4BgA8sYe7X8sGvFLJ/FTrPdz+dgX+a/Z4OMJQA6RX45P7UjJ/QM2c1ZhabJMB2Sdii276ge6AQsgFKmwEPor2s1L3oxxuM3iZPOgwmtbEvPJ0dEQMSo11RvoNNlJatvVLK5N7/cuPEeFTnZoIFJRZu0++o/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTwdn/fuuf6ZLOz2tircGO5dcB1C+DpMuLnUUMmqcRI=;
 b=oZxGlUYktRhO49psBQJI72B4FOQ+3l2v+yJQpA8Ks3JrhlhMqRYu7gktpMvhW3pEIeFax1NcTMY4nH7NpClTf4HsWiyUijBImxhY5d7TWTiiIPgegx38VqIpFGzN4D4egBIHjEUkWWj0BzG1uCaNPtNfmsGZZ5dcIvOEBsvdzgCUfDYTUNbPPAUNU/NpnW1fsPm6SbFowPKX5V7+8+4RnNOQ5vGqmYTPClWWCmsebeabpXy9zVOhEu+a0iVh7dkFJsR3u4anPciB66vVaXW83SxAVZZyLNAxvLkTw6aavZfy6vBRw9p8/MhodPSu1/fM9BSnAZVcTLyXvkDOdj5ODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTwdn/fuuf6ZLOz2tircGO5dcB1C+DpMuLnUUMmqcRI=;
 b=TDpDuZiy2HQswn6EBKunV1YpGXjPgnQ/NU5QewtF9DrlS65w2POi16wJguK+qwQ6t649Z+ipSxrujPfSbnZUfUpLJi0ffPoWUh3MUYxq5JK96/ZQqzyJTSgpgPL9SpQVOrP6mGprVgS/fRbN7FsbyRzWeo1jpiq+Ap7QIq93b/ATnVaYCyPCx0O1gopjzDU+47/wfS/3WE9inWVwVteXl4Gt78OhzDLA7GBIHtKxiZ26CB/+RU5L5nuK2lZBv6cCbXO0L3cPZr44yk/THhSufKkRnYyIKuwkxNKerlE8uTwx7oH9iMIlYRBcSxcqf4XS1s6k2MKIMkgbQmCktqV5mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by GV2PR10MB6236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 16:33:14 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 16:33:14 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	richard.purdie@linuxfoundation.org,
	liezhi.yang@windriver.com,
	niqingliang2003@gmail.com,
	alex.kanavin@gmail.com,
	quentin.schulz@cherry.de,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com
Subject: [PATCH v2] fetch2: Ensure a valid symlink in `PREMIRRORS` case when using shallow cloning
Date: Wed, 21 May 2025 18:33:11 +0200
Message-ID: <20250521163311.2745308-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|GV2PR10MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: d02fd6d9-4d3d-4553-c4ab-08dd98852ec2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sZt4CC+LVQOuxMTFbMWuHSLZojRjqKDpnzc3666JkIyvCcmBAN6v2mt8w/vT?=
 =?us-ascii?Q?8yIGaHEKTqTaKrw92BL3jnICs0v4d5s0yKouDoEL5kwVqs1I2a76KDSuRrba?=
 =?us-ascii?Q?jPHVCvBCu0fbDMmBL4rMrhtcAvWfqzPXd1I3arVjKPZHI4+lB7JsmOQK/vcS?=
 =?us-ascii?Q?e+q238gwJEq/kiFUejRJ8bT1zyUP7D8tgogCS3e9SNjyxZj9W2k3zohyKEy+?=
 =?us-ascii?Q?ob6TCup6rTHr7SFvXfLAHp8VhlHanLqhSoefZ9u1jeJLLIMLKmrIT+W/HQBY?=
 =?us-ascii?Q?6R2ABQvAjr6ZdZd1qxf7+TGNUToKPKCvZAiLe0RBr5PARsWfID0zx1jl7f31?=
 =?us-ascii?Q?PWaHPIcxPQ9q0Z637JU0I/ch2SIgZnS5IEKYKoWGgSpABWg6gbTlNfK7MDh6?=
 =?us-ascii?Q?nh4TrsZQ//uhtC88wYu/lL5a20bM9g9MGgivDD/cRop4o6EVWQg/uh7Jt6aq?=
 =?us-ascii?Q?2uPVJS4045VyhwNOOYfsMEGajqaSAr/YWrME44BU4r/BdbXwrAg/cw9d//VN?=
 =?us-ascii?Q?XMegnZR54PDIhGy3HSL/dgH6u3NeBykDj2mT3sFuxm0xf4EafVQQqhSxogwz?=
 =?us-ascii?Q?dMpaOS5LIzTpsI+ZoeSD2KqYipKHt9zspCwdzV0uuPDvjUCI8CHA8baSTfiB?=
 =?us-ascii?Q?QSYSlM8YlJE4ky4lwrhEnzkZEL3RSE9GeCoqQvRetpAZK10hw4l8YAVv70w3?=
 =?us-ascii?Q?CS47/KYDn611e2y8KYFWQwW/dK9xGyrjQ3Gj/FRPLbU6mCxTrhqg+fM6doc0?=
 =?us-ascii?Q?8jXhIUN5F2ezFxMLY0Ivf6xq5x1+7cWfIqyPgXjhJYzz1s48gl7eSZvdNLha?=
 =?us-ascii?Q?b2mYMOMxmEBCGe24GrTp8RLRqAVoaBOEbz2BunaX2f1kx7Ilpm1DIgpLYbM9?=
 =?us-ascii?Q?5fa3hf4Dibaztdq+VGQ7xIH6fa3CtjxhNvfrglhWLi9yuHSmeYRYxVM8hvYc?=
 =?us-ascii?Q?4Ca2sq4YryN34eqPOITaBDe1g5z2zu7o1+8pUa9liLhgIjkOJXMe4LwUle+U?=
 =?us-ascii?Q?aDaO8ShqMhQYRlj8WtcHTRrRlzwJtjhGC7QI48v5wRwutH9FbGK/j+bmru0l?=
 =?us-ascii?Q?oAxfeJjmcPWoeRfc2z+m4sFRfl0AE9kFPddpKd4pUMFKbF+atfKVzW8FbTWi?=
 =?us-ascii?Q?7owos0T77mqQLFhFS6JTfgjf7JYQu8MfRZxUsAtqTG4ih43T/RfjhavMNGdD?=
 =?us-ascii?Q?lYOeXvRM1XTmdYe4CZ7E3gu49ykPjeuwzruQ1ksurUxc6jbjD1ifY2RmyzVm?=
 =?us-ascii?Q?DFVMzKznijKRBwDvbOf1rILqOFNVjtKe5U5KjaRBZCzHQd8/fa+6jCoadDPT?=
 =?us-ascii?Q?WSbW89mFLe4Pp34r1AxpINHM7qtUZzjAxlAuR5vOFbo/t29wQBjjzxcdUoHA?=
 =?us-ascii?Q?tUOYFS9VDRZc60I+NwLeAQ18tPCIZyN67eu9otm02dcGA912UnkAYZGYmQpU?=
 =?us-ascii?Q?ygOcmjhAows=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eMH//1UJi58LM/hz5NPEe9CKf62y5UFK9Ia3H9kaCCsJJ9yBorObF1VUz80v?=
 =?us-ascii?Q?FCR8xxKeVfoppL9OUI8AEnnP8goN2f79HREvkoZlY6lDVY9iMzskFsssEjcB?=
 =?us-ascii?Q?ro9jGxvEMDRBcS1IZ+UlozkHmizxpw5OvQLhPz2qYYpGO+HJYvBoL67bbL8z?=
 =?us-ascii?Q?ctEqBKq6Cfe61ZtX1w8LTLC8BMiCH2yBkmhzke2HWBzAFPWeBJ9pRCNcQI/J?=
 =?us-ascii?Q?IsGyhpHcJC+BWVKlafKV5Bpfm45LyHcWrMJgk1QaHqOTfQMybds710LG0+Lm?=
 =?us-ascii?Q?/M5eUYb0tx1E750wl+1WLipnW7xkBfwFEv4TL1LACighex+/BgEsmih2yIJF?=
 =?us-ascii?Q?OcWkjMTshOeulWxn+SPevRMTDEpi4m2IF5wBw7aKz/L/r8zygR9xCLOs8Dhs?=
 =?us-ascii?Q?1sEioWkvoZwy2R5G9v9978MvQq9CV0Qoozb/p4d5z39ZVfqkTsZP2IvdWoM8?=
 =?us-ascii?Q?ScqFD5IXC+uC/w2R1Fv5FBYrKLBY/8A5XlzTcE44uVP0uXmE3eZaqA0H7rZv?=
 =?us-ascii?Q?+xzHWx6lMmRZTliO2zaa9LTl/UJjDLGH7+w8DsHM+c5QWtDmkAMH1WusOMVf?=
 =?us-ascii?Q?A1ebzmjxA+aTf+foG9SYpzZGN2sqxPT2Vwb6dSMl8IhoficeEwlOOtbhBoDO?=
 =?us-ascii?Q?k3z3hFOMNtgbivXYskhXIQSEVa85S2FwGI9bw89s6k+RaNQjY1XqYnEwlA10?=
 =?us-ascii?Q?x6Xy9hs9KLHO0gq5PpzDdhZi98eenKjgsuilfRYrQ6oXZkNptFFkqNvuECJP?=
 =?us-ascii?Q?+U4NDbyEiJBhbf694TCoUW1x70HXUAlDxl+Y0EiI86i0UMDH+V6b2YoVgiNK?=
 =?us-ascii?Q?gv7+5NeFGISt3SkM5hy6MrZDGmSS3MzidiyvDmEON4cZaZNE5eNCELA2R8nZ?=
 =?us-ascii?Q?WvtvY+BOFrr8xtfLmE3rBepANodfNtREYM+SGF8znkyh/b6v0N4hCKrkMVps?=
 =?us-ascii?Q?/1BKcXGOviB/QgK4TVnCsoiU4KGGEy/drQ6z/hXvw6q66LJxosBiAgDi7H9b?=
 =?us-ascii?Q?3A6xioYBsALX2TFx4odR3FIMhWdQ0lTQ1R3MpZA0IRSlmXHK3uFBo4e6cgLu?=
 =?us-ascii?Q?PGH2YSKglnjdGa2zj7yTjCbf2BiX45kiQ0POd1bfBlhNzGtYPMxYFpG4FZct?=
 =?us-ascii?Q?Gq8dzBgs8t3sLwz1cAGnNo4DWHVBLGfuDy42/UDWrNGPuo4Vk/B6OSwV3bO8?=
 =?us-ascii?Q?I4v/tiisJTIZ5kx2ZMaqOo5x9OnEDp8ZE8/WpF0f4O/njSBu/nylAew/xRJ7?=
 =?us-ascii?Q?64m7y4z3pkokhL7vPJcpY6GIVvG8+tI4HHxdgRwcI3QmTdAsnxlsI4B2uSbu?=
 =?us-ascii?Q?qdQJtb25LfSgZ6UZlkQQB8G7GciV+cF/ATDmDdko914Cabchc/UfmkF8qalG?=
 =?us-ascii?Q?S+ARBduSKZjTU/X373CdYaKqKKhWdHI/oOnYcHqEXmXDJ5UO4XQqqItUGr9n?=
 =?us-ascii?Q?cqjT8xIeu/7nLWJ0ycUcK0D1FFPLFEwIGAJ9N29X0ltQefTtFu9WVi00kShG?=
 =?us-ascii?Q?VnTZsbGm7CSkWW0XY+2kvQXljUQ0XxTs08D2Z8OR4OUiwnPXCye3O9sw5Ad4?=
 =?us-ascii?Q?VZMwegBEIEfz1RS0VgK4esRg7ywczwRDKQOeuprKgmvz6IfxsQ+Lh+wSsrhH?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02fd6d9-4d3d-4553-c4ab-08dd98852ec2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 16:33:14.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5leH8+uUh+tKQTcZdL64CynSHiKlAn6UjTyRzC8ijLd5mclAUzx45CsN8UyVGdi2m2XjZvDoXunMlUbynbkrbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6236
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 May 2025 16:34:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17627

- Since `ud.path` contains in that case the `PREMIRRORS` prefix path,
  this change ensures that a correct symlink is set up.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/__init__.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2de4f4f8c..052505456 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1117,7 +1117,12 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D =
False):
                     origud.method.build_mirror_data(origud, ld)
             return origud.localpath
         # Otherwise the result is a local file:// and we symlink to it
+        # This could also be a link to a shallow archive
         ensure_symlink(ud.localpath, origud.localpath)
+        # When using shallow mode, add a symlink to the original fullshall=
ow
+        # path to ensure a valid symlink even in the `PREMIRRORS` case
+        if getattr(ud, 'shallow', False) and not os.path.exists(origud.ful=
lshallow):
+            ensure_symlink(ud.localpath, origud.fullshallow)
         update_stamp(origud, ld)
         return ud.localpath
=20
--=20
2.39.5


