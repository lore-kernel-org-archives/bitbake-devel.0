Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF02CAC582
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=FPjJBAsj;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihainYY7dQqL03/3WvuT93kJvq3N22ckGR3HGYfWiKEe4QNhZCJBQpzioukSA93nJbyKTe3D4LNP4XZf+982Fh5SrNedpxq49c0ihDCJbdl82h8pofoAnXMJlO2rpAx4YBNLBF4U9TkGiiKBItRikvbu6S/T0waT+PATkNYNH8W4+6LCkGyioMnVoXtW3ULq8BneHlyKH10OywpiE8xNiWKOuyuGVAu/nSn98nZ3jkBRNg7sKeClRzQZFJxzTybTSaKD8av3vAux2SioTXfONBKrXwB1sicpJU2GS6oUjGfhFtzfSiSlqrao6Wu1387w8p1PQuMdPEMqt8KAmDivig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMCkKcMBY03PuLziBFG3egOtD7u1Swlu9SwKD7ogNJ4=;
 b=hfgHXo0K76olOlpJk4z1KRwHwCYCA4JldaRsZs4ulYZqMGkWjWPSUVOKZeD4CiNjeiyc576XkZk8tjzcELjtOPzxyuNdQeKYhFmd0V4XXvQNREW+P6YnkoEtMS7nB/BSTS4uVOg/Dd07NVHahS48CadUYHRA0fIYTFXdJQMiPgwoKkKR3+OoeAhSnT7HZGiip2X1hKx7d7uqlv7GU2LBJiJuL0yG/i6XdjVDAq0FXR6AShCUoIVNNVaUH2LnRed3hIhmBtppQStlSCRm7GM2RUkVHN9C33pi4CdCsutkUTuNCVuJjgAHkL3Yc15wmJkqEh0DDRecAV2a1IMJ2AjjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMCkKcMBY03PuLziBFG3egOtD7u1Swlu9SwKD7ogNJ4=;
 b=FPjJBAsjn2MJBW846rwOrLihS3sm1zVc/MhofmZA1i1M9LVvPNHnVBTozSq/TKrddkDX5xzEocd2JgImV1QKQUcgRuM4QO/0pCpJXvqzwki5FPwYw2CJFxIB0VbAAsBQW4WXU9Bmn9u2J+RIb0YYg/RDZq5vrZqZ9nLLrT2al+Tbz78uwy6V4rGt5UvL1394e2XZxFgHFxTVrbFztmiCnGplcyAoJfMbIkTDD4PEKz6SFRo71uAXrDmtwXBhTERQzd9JLRQq0q5hasxbkFKPlMYY+3pwMXGIMrnTIsOrEmQ5P32pIY8buGry5CKRy0/qXcHLi9W7SewMzeuPsuVQAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:10 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:10 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 02/15] fetch2: support URL rev paramter for named URLs together with default
Date: Fri,  5 Sep 2025 08:20:45 +0200
Message-ID: <20250905062058.2563806-3-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 71381b30-1f5d-49d8-cd94-08ddec4467e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FY4tG2ExjymswvTB1uMwyKgFNu6yCPivAnoaDlw94OWXQWfIBd5qbQIywPHt?=
 =?us-ascii?Q?Df3xz1+zML33qxAvCaXrF5g2qHhIoLFX/L8g7qJPQklNrEyyr+FOj72QnxaK?=
 =?us-ascii?Q?ishRskHI6+bOlNTQnUMhQ20aiTJXVU1uwaXus6cHuxzfQeWkV/Nhrbiv0A1O?=
 =?us-ascii?Q?2rEvu7JpJw7xUuhuHQgRh5NV6N9/u92otHJ9Jw46zXhxv0H7pBq703fFS+Yv?=
 =?us-ascii?Q?XOXEBJ4eH7S9ddr5Zpp4hqDBA4JbtkIXtzWhUO8dj5LPB4lEiZQw0pGXlbQ5?=
 =?us-ascii?Q?2eYJ0qInPNGhNsBw5VEMbokgVlpbR8NUVw3/DzHF4Fvt7KiDHz3EraFv++j6?=
 =?us-ascii?Q?NHmjPchmpsY2fZizb8kdf8EWPtv+8rGfbM1TUZrNeUy+JoiAO1IL+W7Cmgby?=
 =?us-ascii?Q?I9AfaPf2i5IB88eFu3PtIId9BwNBU3svYhHkzqqvuVi2QVtYiVov8x579aeO?=
 =?us-ascii?Q?kBaNGju105XoitlwxiZ7nwAez4COqKuzoPr+If3NWyCcmjH7fXcRxxmNjLtQ?=
 =?us-ascii?Q?PBwLYTHBi9eqAtFPayiu2gW9fUF4SRV+7bk5k62Y8Yqlz7jfbWHB0DsTcD7W?=
 =?us-ascii?Q?7oOgQzTVg42J5iJ0tDsFtw7+4x4rs9bMiEjey0z+FvDSgEfygvMlvfUtuiuN?=
 =?us-ascii?Q?NztZ2rESZ+fm4fauozA29moT2qdnfFjKDCZ6jN8Qmcv8gqpaZ3pZjngvo0eM?=
 =?us-ascii?Q?ImKg0A2VxW9CseF3oMmoSIbbM9/D5vBo4mzCAY6PDYSFfuu6wkdw6y+0VVBs?=
 =?us-ascii?Q?0G9rZEUiVS9o9H9UabDlfSOfCVw537oqE9C67u6vK644ZB8YlZAD9jpYXF9J?=
 =?us-ascii?Q?a81gKsYZVK3TjLakMuIoqtL215Q0BwG3IJCdIWvGOx7NmDgkt++R6C4HnzYi?=
 =?us-ascii?Q?uqp6mG4c8LbdNvAo76ETSwBLpZn+rYM/j+S3L95U28f1XB9iS3Ckyu4knpyc?=
 =?us-ascii?Q?tvzcRw6mLCSSlu4wLuJdxNolwlEuEUkfnUU55aMB5NgbqGLnXNn4A4zy3tpj?=
 =?us-ascii?Q?+nok21XY9iuqWaQEJhKiZsAjHEE3TN3xYjWC1S/2FSFHvxnrmuK4J5MbeRFD?=
 =?us-ascii?Q?1bUyRGQpBd3UkC8mD1xSOAMBG6GBawXayhVd8EK0SGBy63K0ZE168zrQleaA?=
 =?us-ascii?Q?5v47GwH2K95FB+rMlLOtSlZSQnzt5GsAQSig6tMmiZ7Uw+qTI35QZHVT5G5G?=
 =?us-ascii?Q?5CNT88kJni5rlGUNtX5ZtrFvMnSQQBBcANO3T0lX8j1oWhdiCTdoOrZO9bt0?=
 =?us-ascii?Q?zgQv9olF6ETZGtgoC6yhTT/YBFzSeeJEZtXXsT+/dhCQAUYtEKAsfF2w9Yn/?=
 =?us-ascii?Q?9aa9t8A31m75LC3FZvE4jo37AoREv2EnrHO1ey+4LrRBcIggIK2WWMKbJiMY?=
 =?us-ascii?Q?b+td1OuxGTkUGcIggTm2GaEKWVN6MPfQzH8zVnN7n3dxEcTZ7J5v4638rkYX?=
 =?us-ascii?Q?AOHgQPYxF4S3fzuR96THtUaPKnrhsiWtbWnRh+gYcot73L/li9xKyg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gp9f0elEshZZRRqPwZyG83cyoLFbRQIcEBJw79UCDC9YsnKnrgI+Z2vhUx9X?=
 =?us-ascii?Q?gVZDzFEnWfeeJyy52D0q1MKbMxFyJs5X87rKsbS25Gib+0Dvb0/euV3sVwkt?=
 =?us-ascii?Q?LZexX/6PXtRtuzqDhripuXfKsF1UnAM+XJ4lNKTpFYvGbDa0RcyOaaAjClzE?=
 =?us-ascii?Q?sMTOSEwWuz0HreAlNoILCeeYSAMwdUVu3NMT/lI9MfEIH0xW9sVc17meCWSs?=
 =?us-ascii?Q?pHHqyUhNzVJM/PYqPC7APsA9Z353OOaGawE06VI+zeRfnxP4ruFWuWh2wLi+?=
 =?us-ascii?Q?LIU7xgNj6IzBF0waTVyidAYRp23CgJ+a09IARaNFTw+yvWmGCQ54jD+4/p0H?=
 =?us-ascii?Q?EnyX5+3i+Q2jJCHZmGxSe4DNSTAPIj13sFXTA40QvGRDQ5wS87nTUX7LSFIH?=
 =?us-ascii?Q?Dhzu6Hck+JOAYG738Ej8+6KpfqjmIW29yx26ir51Dh68Om6ctwajDNv0V9xr?=
 =?us-ascii?Q?0ZJRCxOJEZI8lQx0lscczZs5xJJ/YU58oz4zInOYphVhfiDt674ADRRT8TcU?=
 =?us-ascii?Q?kcWEajf3qOvpI56DATV6oIWlEBBcb7UfWUAs0xIKmZ5UFs36UvZCTikJ0bsS?=
 =?us-ascii?Q?fKJFNVeWf6VuEBbS/OJGfnRbqJb6oXaTO9z1sAHMX0j4etR24h5nT6QkQV4+?=
 =?us-ascii?Q?RLgXsLsUpNoSV5R8wzvjqYRpk6rQWfsCGmnygpdUJVl/wLqRHq3dBA/nMX6g?=
 =?us-ascii?Q?Zsdp7PCBBtvi2IHBMgfhxzhLTL5APu/7JjNjbjEkv3OIaxyjqnCoipO7J2ti?=
 =?us-ascii?Q?u1DsJ/zpvJpA9Yi/ST9NMdXUqrwd4ZAh/8NFxvyRKN3W4fo1TWQ6LuWfd130?=
 =?us-ascii?Q?QfDnvtDa7H50NGG7NqQ5d9wtciiKRUivv0S9cohuNSqiwEa2HxT8Lo77S+9B?=
 =?us-ascii?Q?X1VodAJXhMWJJ3jPHPIJBqlqvG6QEkqicQUg9cSw2f8Jo9Xl2i3+T775o8+X?=
 =?us-ascii?Q?b1Ewj5Ht9/4wupLeUY7C/EAO144/tL8mPzaITWt4mCZGf8W9GMHW5T63eq5+?=
 =?us-ascii?Q?IZbDZ0CDlOn7Sfui5h91BFe6i342rP+AjUT14bdEszjHXWYH3n7U0yx1noHX?=
 =?us-ascii?Q?1sBhXY2kCuAfeSb77uX7jGqjEz5zonJqopWq+SnidID+Ezbqi/aWWOoehraz?=
 =?us-ascii?Q?5+ZWaaNtDRpiYToWQ52PmgXeC13OMqdpRAe8HFk3GgnRQSRkT6rTcrjnffZ8?=
 =?us-ascii?Q?JKFU42xSIE4gKVCnVaix8e1upVWFZEbBGR/Li3jvkc1ZR9O83QZhIYB5b9gm?=
 =?us-ascii?Q?HQp+fZn9nL78dseUmWBkYjysAnAmQ//A5TnkyScBeH++hRGU/mSnIbE1Nuph?=
 =?us-ascii?Q?XP7Um0CTwAuHtddE8R/TQk9dfN8wG8aJUpSp5TvcYb4WnDs3ol9bPW0qyl7/?=
 =?us-ascii?Q?hdxG8fvIrVEUa1oQFsr/nj9DDHLNQvzFfy0CNMg0dLbt+hgHlrxg6KbAmMNW?=
 =?us-ascii?Q?Z3/AkaTELx8qUVI9RIBYSbydAgmYA8N0vEGlF7Lasoca80ew6MEXXrD1U3su?=
 =?us-ascii?Q?wQwrmVh8bf2MTqxa1wWL2+ZcpEZFlQb9TpYxPd0qT5cGjnLSnPLDxyonsd13?=
 =?us-ascii?Q?vmAbErLFm5+W21DUXsIl7/+salFAtOU6+6SaR0z1B1w2BiFuuzdc5nn3IqpE?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71381b30-1f5d-49d8-cd94-08ddec4467e4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:10.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK5Z3a1Fi30LpkY+WRHgg+pkYhH3aW3AMMA+lEBkKIGJMtnqCPKgsqNZICoaBBcRvkA1ooX8W30KedDtfcCYKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17959

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Support the rev parameter for named SRC_URIs together with SRCREV or
SRCREV:pn-<PN>. Only raise conflicting revisions fetch error for rev
parameter and SRCREV_<NAME> or SRCREV_<NAME>:pn-<PN>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/__init__.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0ad987c59..de301543a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1226,9 +1226,10 @@ def srcrev_internal_helper(ud, d, name):
         attempts.append("SRCREV_%s:pn-%s" % (name, pn))
     if name !=3D '':
         attempts.append("SRCREV_%s" % name)
-    if pn:
-        attempts.append("SRCREV:pn-%s" % pn)
-    attempts.append("SRCREV")
+    if name =3D=3D 'default' or 'rev' not in ud.parm:
+        if pn:
+            attempts.append("SRCREV:pn-%s" % pn)
+        attempts.append("SRCREV")
=20
     for a in attempts:
         srcrev =3D d.getVar(a)
--=20
2.39.5


