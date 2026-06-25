Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C25CDE002
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:15 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5833.1782371286374348394
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 00:08:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=VKlm6teM;
 spf=pass (domain: est.tech, ip: 52.101.69.24, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch482WFiMKu7xHIcfy+wfNyUKnoKPD6Dxx8TWeJmetMQwZp53vTEMY8AWcAx5bIun01fiSPuPqQZkPCe4rXyScgxWRpyOkvs6Z5BBOAtlKZC9Lba/U8CB9I+/dR2WU43D1+tEWm3fItRBe+STOhby1K8ouikwZ+7vWIAgNuCGWLRvW4YtrRMp/2jr8n08+XfMRAvMJFgMlt+pEPfsZUbblxGsnDkBNzydyvBviF0nATfp7HNDe/2IJ1Mtfx6hwLm0+TOvdNyzRY294+OT3lioOiI4H1/W4CUBepdT62pA8Im/vLQr2Qxdk2km7Y9yZcFiDLjjU7Di330DBfPM+wMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Aj96EjVO9usxShsHSb7ZgujnwGj1ZPGEuDsSGRUGGI=;
 b=qav3VAZTxaqhXvbPnrsRCa8XydP+kFH8aFNgazKUFHMMyANDgCzgXotlodCNuKyuKPc6vTW2OTaEh8ub1GLkLQO6wwxxO7YfKgvvS2gujjcBj6g9+VbCAYBtcw+SuoHbqAEJatOSkYEfoGGy8LwlMSDLLlbC6Rfvuc2yAaMMgysTusAEgWvaMLRFtNS1JD0/lSCzJiTUdGMdsqS1X5w8u2nNuVkrLDt2/7OesC0Kre8irf5KXiHkwwUUXUhaeS14qQZyCj+NN8bLi3/3eiLCUMIxss3afGXLPSLtI0E6OsmM5SBwiZGcGDZJVfAxxi7ool1JcqExXedn/t+9y4jmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Aj96EjVO9usxShsHSb7ZgujnwGj1ZPGEuDsSGRUGGI=;
 b=VKlm6teMfr90BuPI0Lfvx3edhre/MJj/uni0J1PQIhSCbKt6A8CDi0RwhLkyfFTIS51dOPWXDiwn47/8S6emjc1Br2Y1GDEClcklfJnnGk1b+A8tbw2Ekri8VmzZVH9F98XPskljz9dI22nc7S6oV5pHXYX/sP8haQq1pi07S3At7zc93LwcEV2l486AruWEvd4P2lbroau8fDimStCNXRQdJPn8ce0Am4R3xdRJ994agHUQelObMSLUOVtBZNOb++ZYRnKG9G1tHMJKPLYF4YpliMEznJy9m6OIHSZxIWfbm5CwzL8e1B1/XYBQR6AkLmTrDem8PHvh1RXlg99VLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 BESP189MB3178.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Thu, 25 Jun 2026 07:08:08 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:08:08 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 8/9] fetch2/svn: remove shell quotes from the tar exclusion
Date: Thu, 25 Jun 2026 09:07:49 +0200
Message-ID: <20260625070750.2757558-9-anders.heimer@est.tech>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260625070750.2757558-1-anders.heimer@est.tech>
References: <20260625070750.2757558-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::19) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|BESP189MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d8e3e1-06a6-406b-6b4f-08ded288827f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	SYB5rmWTIdR8HWfTtRoDndRVPpVW/XLpZzPZnANs/qlqgyfhHn6FNWXry8VxE2Wdgj0ekTYx61Wn2gT+C1igaaTH7qP8+EtXT3Sv7z2tv8+ve9X7LzSsXzHwPSKpqJnVDBInEWg3gtnnTLEDZQ2a6XFdtYIW332mgTdqxF262C7sxbHoi52Ffsg+uGhquMvu9KXOwzAo/ycVn2WlYMSjfGOLsMWiZprnNGCKFmOoukOo4neoCiguasEx+1yrAJ/WF0zX1q8IFnviStELf/+Ypmw/pd4V9BKmMw65UA2Jg5UxKKiAtS6+NjgkQBc7pJIMFOMM3EB0LrBTxUdx01m8BTcJEQwzDzh77jvBRIUNFZ3QuvSGg0qJiL00yeAfuCKffFrzUNVv8pHGdONfbldculnyRJNCpcZxP58sLNogNXyhantAWA/7QHd9wtj9LilsMqiyskpxon2fhDc6A8Jdn2yOC00iIy6l75t6rBsmS1gaz3ofLsR3vaancINwzHVSLSOt+xMWrQJeXQ2DHsHHANeN/6PZYWO4kgj3o8a2DS6/6X4cqOVK8+9cosvumpIxJeWZ//WWcEgk7Dr6iMXIo/ntvFKIitDyDsIH+Psu+EFQj4GfSqxNYSr6DNpim5iTf09N1dIb5+eg8YwEGWAQjatlt23ISWzRDOJdGb4Oo0c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VJN21EdTm9WuFAJP0mugatEBJfu/gHWBrz+7G+75IcwTEYAIB+6eK2JZVFzC?=
 =?us-ascii?Q?ssg5GKjvtQXTRO0+iGe2IvOGITR+UYooXwoTozAlvwNxbh+bmFIBMtDWlMk5?=
 =?us-ascii?Q?LGGmLBv9YkGfHAUI4PTxP8pMX59WS7/fyIkiSWLbFz6/oSJqFRwNuMSkTIaq?=
 =?us-ascii?Q?CwS6s3W6mNaOr84CSBXJwGBfkg9jN5SpAfRp3cpzFKrrm2Tg8QWTzVas+/WS?=
 =?us-ascii?Q?vO0tMqPaBbfHYD4M3ut+693tPsjxFEYl/oCpObArijFQaZkb70Yd2DFbv9UH?=
 =?us-ascii?Q?U8aCW3oILXXJDCCt7JpvuM+AUc2HIExegXVByjC3EqbuJtjVs4dKYt10Apup?=
 =?us-ascii?Q?DTQ6lYyIIHx622pECwwpcuHGfPUc2ILqhlx/KFF43GWs54NVLu01leTZza1Y?=
 =?us-ascii?Q?gBtf6rcnOWxEPiMyF5EafHhkViZeiIKljB2JOqUh5JO7kHNI61WtCYiUnRJK?=
 =?us-ascii?Q?X728vR1ZRYfG20mgjTcrTLaYivM/0QjKA8Jl5H0oEiINnVNsIldk74kr4Xla?=
 =?us-ascii?Q?8tTi0UldsG1erBO2YbqlM1+Ss/8MBR/EiJ2Z87DbJZJ72WE/qx/pv2mhmQ4/?=
 =?us-ascii?Q?zzxemkO8Q0HF69VGbBiLs3SQBRBoKeEi945dh/W1ZiB7mGn7+jMjmDvkOv4F?=
 =?us-ascii?Q?3AeBUHN9zsC0aHpkDmkY+CWa694BvqiDdCkdtVPoZZE9h37294fjbp3HuZGa?=
 =?us-ascii?Q?8hzNy3K8Us8UlWX9NWEwmsX4VAfhLQJ+oQNLlDkS9EJlDblmtq9AL7S7Dc3c?=
 =?us-ascii?Q?DdAwnJl+YQFqXCwGHFiBe3B0enFnVuqOg1uXcXGtvsfn9HQS+WjViE4setMw?=
 =?us-ascii?Q?vxoRbMDltfsPRA892BRzQ89HMq3/kwV41H+6jqatm1Mkc+LDlbXapKkToSiV?=
 =?us-ascii?Q?KSNzjIF6GKhpYTSlTE8Mz49JbbeTw4oZCjh5zVbFkbQX9hSL9na70hhDFwd1?=
 =?us-ascii?Q?EAK3V9hWjnSqUr+a3sJOIbpxdBm6yHblEjblimocLHpjDIaJtWReZ4yaOxrn?=
 =?us-ascii?Q?127zfVFHUBMHpJkGzixYqwlMDH3rLWlJxl/+pYf7WwHpURRRmxOewaPeQr7y?=
 =?us-ascii?Q?DkthcJgOhWjbaiMOdKPHSyFhUJMDRbGZ/pRwtEZRw0YLB0OBJfUyfJyBsQt7?=
 =?us-ascii?Q?bFeNLT/eSHtQg+7AlL1OcNET4AxQtM+D6aSBcEOt1dRSqiwaD8fJb9h8rzfC?=
 =?us-ascii?Q?5lxwhbiJLTI6McHbPAl2pDGcUPReHr9ia8UQCbVT9yNMwlfN0BcIo2XRY5/8?=
 =?us-ascii?Q?obK5CsmPmLqXU4E7UfTAoJIQyn7+0snDvzmQ27HuKpWMPb8q552/rbpYLb7G?=
 =?us-ascii?Q?1hgfGOs8OaZGv4LtJQXtvn/5lNBjKiZPylg7OjKQY7ahPNAncnbTyzV7HSEp?=
 =?us-ascii?Q?GbEovaitCnTuR4EQBBXi7sNQ2ycx++eS8JzH61TR3DC6nocIMYNMAp2IAgxO?=
 =?us-ascii?Q?CpDg2XSL/3lcuFQpudQheJUE1cyfElU6QZ4EvZnquc6IMY25fW5eAv8OYlCG?=
 =?us-ascii?Q?3FMYBM0DUoUijTxtuGhroj3wiVw/qDqqGZ0BQZsv3O4ZrsNufjIh36FVJ/69?=
 =?us-ascii?Q?Vu8TLqOWyO/0sFVow4W+9MQrNO0/JWDuc3lkrmSLcZ5JdugiMcOtFnJ8SDef?=
 =?us-ascii?Q?rygIr0hxWr3C1DzxqeJo61LtDJarW6pei+qqxGfrRBXQMyk/ORbjm/i+tQUI?=
 =?us-ascii?Q?4amMOVRVPSbFSbDBos3aONyntiS2CkoRt55wWEfLeo8L7UpkFPxzChqQe7Hw?=
 =?us-ascii?Q?3p/++c8PDQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d8e3e1-06a6-406b-6b4f-08ded288827f
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:08:08.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oxt89lJhVclUjiJeSGdbeazOwe70LaWGtuGT86nM9ihaiHFxKAbPIp8B1HRQ5ZGDZpPF2Oo61KibNgBfQ7ZTQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP189MB3178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2026 07:08:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19787

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/svn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 84e15c02d..973f76f00 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -170,7 +170,7 @@ class Svn(FetchMethod):
             if scmdata =3D=3D "keep":
                 tar_flags =3D []
             else:
-                tar_flags =3D ["--exclude=3D'.svn'"]
+                tar_flags =3D ["--exclude=3D.svn"]
=20
             # tar them up to a defined filename
             runfetchcmd(['tar'] + tar_flags + ['-czf', ud.localpath, ud.pa=
th_spec], d,

