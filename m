Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4EEE49A5
	for <webhook@archiver.kernel.org>; Mon, 21 Aug 2023 21:10:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.59])
 by mx.groups.io with SMTP id smtpd.web10.2447.1692652043645759009
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Aug 2023 14:07:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@welotec.com header.s=selector1 header.b=On13s4vH;
 spf=pass (domain: welotec.com, ip: 40.107.21.59, mailfrom: p.lobacz@welotec.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzeS2r2NrT8semtor6geU5w7m5BHhvB4i0e9eiJ7EFGHpjRBwajVYuvvxEZn4tU0Uvl1c/H7a4STWDIy9KNw0AozusCr075DmOMb6FZgjZ9hZj3zmACitl5ZFSd365U6XtSoypUWdEmz1m0HsWbKWB864O0GJxMYTKfxwksRpR45MCZJnV2oswaH211c8R2u8sjPeOl9J+IfUWipJj0beW6Np2Xjg3dEw8rZz/GsLLtUHoJGIGVvfF1idKZQT0Ija+KkDyB/jOVhjpRQZRo3u4qYXFXrnVF3l3nTI0oFpTT6yN3mfuTqy3SwsAZnBAOITGbZmSn2jgmHHl+20yYEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPoQVoPEPuAv+Uqhay1NWJ7Xb1OelvgOdMlQtyDObH8=;
 b=F6dYwd+EJiov6WbCBby0IVAnsMzmLb0+WHOXAJtyCddwn2pQk6dZAtcC3hbPvBfOw2IuXz3VB9yodF/QOEto/GOBIKvzrDZgbacUOvwxFsN5mApyFR4/CRkHSamdJMBYgmL+aUNrc2lm9oaLS3Auu9RM5jVTNYPI5vzgC8HNVmB1xPqtFumH5B1Mc1yIywKI7kUdMIgJZ+bf5IUpuhIdHfyuqgW6F6h/jRHrA4et1tL0VKSSYc60IUeYHVkudBjr004DgLQmFZEbN+v67IfBndXMGuYBMTQk3UR6imIoPb0vCQvGJoUXVCr5yKh/QJiRH7sYyv6Bft0ixmoM3RwM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=welotec.com; dmarc=pass action=none header.from=welotec.com;
 dkim=pass header.d=welotec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=welotec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPoQVoPEPuAv+Uqhay1NWJ7Xb1OelvgOdMlQtyDObH8=;
 b=On13s4vH8s99ul03O3ZZ7CCsQDQ7UDUeCOROpUIRbk8bMDrxEPmzd6j3LtUMwWtHmFETxUFnXmcyt07WccgY3cyq3khRQgxaGCsgP/w5CVdLx5FBCReJ47htPWcmeqfu1zQe6nXhcbAJdMg5URqyu1kVpiDTBQxUl5VXt3F5VwMo7pRGp85IPfS6uRldwpZiDG6YUBwJYyl7V9gWdVz7DCzs5mFDjhF9hQq0GT2/tqHyo4PIeVA8cgle3vuzVSGqvrX5LxOrrXZk56ExOLT+DOsB/EhaOCalZ1f8IincdT3HxspSIEuApRc8zMw/EfWwSspcjgvlWoD9jCfjOva11Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=welotec.com;
Received: from VI1PR04MB5373.eurprd04.prod.outlook.com (2603:10a6:803:da::22)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Mon, 21 Aug
 2023 21:07:19 +0000
Received: from VI1PR04MB5373.eurprd04.prod.outlook.com
 ([fe80::f8b6:e68b:c240:b500]) by VI1PR04MB5373.eurprd04.prod.outlook.com
 ([fe80::f8b6:e68b:c240:b500%3]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 21:07:19 +0000
Message-ID: <6254c396-b6eb-d285-6349-c655fe538819@welotec.com>
Date: Mon, 21 Aug 2023 23:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bitbake-devel][PATCH] Add xattr and acl libraries
To: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20230817185318.1562354-1-JPEWhacker@gmail.com>
From: =?UTF-8?B?UGlvdHIgxYFvYmFjeg==?= <p.lobacz@welotec.com>
In-Reply-To: <20230817185318.1562354-1-JPEWhacker@gmail.com>
X-ClientProxiedBy: BE1P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::8) To VI1PR04MB5373.eurprd04.prod.outlook.com
 (2603:10a6:803:da::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5373:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: ce27fdf8-58b6-4a6a-4e7e-08dba28a9b2e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zwGIWXAh65RhtORM27dAS0iU14C5GQgpwPBk3tgBG5E4uIm8XUJhZBIflh8Yel/SwuNWcK3bl1nG+7NFd/BfA6x3/M/7LDap+CnTcIbxbRLmOmrZieKaCb8k94iCtzAHOfMqPijXD8/FGpRb80pwA7mMCrxo9vpBbxbJ/jMWER4NMoEa436PkwLMoawYiv63mgHrdhnbZNx/aT2LjH/DRr0yaxxmwBZfW76qTm88JgaPGeMeO/eUTVqALAvrlRpO5IRNdA61av1qohARgK2BubRGlCJ7WL2kKI3C57jqpaDflVvDC3B9vkm3LFAfcEnqvsxbisF7CluGldl3C0AVohSVZEZklGBltMNt81MRVl7qjyitjJBrSz50I/spaLYrtTQT+RSeC6xWLt7rUluibEln8amnItEhki2UuVAunRNNtveo701+NToub2N8bS5ji8IuBPBDrj1BU7ld3cO+8rHpu+oQnGBA+bkaL8ZDt58u0PGOeQIaGX7T9G5yvLO34QG3iPcd2nQNYGWX1o+xmGpIUKKIHoQ3NkddJNq3WDaiXiiq2/0ous2JSKVdqaHzyFX5xsaxrWOWOP+cYetemjzY1iIuAhWlPTPjJUPnrKW9IwpcSYjqFhX46csLOWanAkwUbGP1YkyjfEwk7b/ssg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5373.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(376002)(346002)(136003)(396003)(1800799009)(186009)(451199024)(478600001)(66574015)(83380400001)(2906002)(6486002)(8676002)(66476007)(6506007)(66946007)(26005)(66556008)(5660300002)(41300700001)(2616005)(6512007)(316002)(8936002)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e6OHlz11lWBNWOQ0TegX97fkNOwwAxFhyc7PttrkahrJeFMaPjY/MELNDqci?=
 =?us-ascii?Q?Ljr9hyDAY/H691fKOMvkZmuBHyalYB9uLI0MujO7ZS9g4qU8O/UGQSpWyvGh?=
 =?us-ascii?Q?qtsgNXYGz4JuaSDLDBpOWG708dHsk8Ntm3LXHIIG2vWPZqZvPex2dXsC6kTa?=
 =?us-ascii?Q?V45EEMogpcrJM3RYf+TdpwTkh44n1xCA0AVbMx6qVhHggcB7kWz1PG3uwZdx?=
 =?us-ascii?Q?vnFoJchFDXPkXdiLspmC7WZnV4KJlsBzCrxKvWCLN5/sMc8MNQY1pgPfl8tX?=
 =?us-ascii?Q?shmia/CBh/dYqq7S1KriIBHIQ6KXiJCR8FBN0OjAzwv8+kjUEDSM2ZfQx0Y2?=
 =?us-ascii?Q?j1nN5ncLk/2wN7hdyahX0MaAZ7XVSCOLg/1uTpV095QpIk84lZ0my+/F2q73?=
 =?us-ascii?Q?bNDddnM32dvXAthqygoXmbsmgp7BUVD7WYrtvD5/Zoj52fxpVnxF1kyFk2+b?=
 =?us-ascii?Q?kUH0DtAnk5uwDpTRIVnHkMJhtdWmb/TxPXHGhGlFzNApys1dHHMBn5W5t8z9?=
 =?us-ascii?Q?L94+mN8UO1tS3GBS8pELLjgqqVeREeX8wsKGJDpP9DxobZXeBILGQaOG8AGU?=
 =?us-ascii?Q?8Siv8ZTkru6EUD97wlDN1xmLLGYMBHAAomeZSEy98WVIEVgYpe5BEeaAj4Zj?=
 =?us-ascii?Q?5ZVdv+DRmZwjU0f/piKqYzhHlG9/yu+VyiEWKft2fZNc6E5Qg0is6edn127z?=
 =?us-ascii?Q?uC6+/n5Uy0/qyYLzz1hwKnHKsIvT9vgScDEGZn7/csnVKCj3pUbx32I41fCl?=
 =?us-ascii?Q?GUR1MCUVARlA5hHX5sIZNXL/2vJ+h0y+aCEl4SBtp+GQuV83N+WfGp0RRsSU?=
 =?us-ascii?Q?Z7XtCS91qIieZcg0FFrkt7BM2T8YW8cYKVqzP6flrgqla/JGJlwkRGwHp1rk?=
 =?us-ascii?Q?mJcP6MQHaanM6fnSHL6gGcJ8rGv6eYr8lvYERQ7IJJMhktXWzRfDk/AfdVlw?=
 =?us-ascii?Q?Ctb9Z/Qu+IdLLb7v5cnz+NyVx06hcS26KCo6fK6qtnMsiIBHBKe+PyfGHIt1?=
 =?us-ascii?Q?aPYpOdDUsSnZIMIGaeMH/ujPkbs+6KiILC2kBr/tDCK/ONqMZmkIFdpuMtoZ?=
 =?us-ascii?Q?pHmEhDXrLrB15M96YpXYcIkIGFYtOFkVL2qG07p9RpUVGzAChRGDmz4BEuOK?=
 =?us-ascii?Q?kAo3q9Py3Jog82UnzoZ3zqkmtJxQw0PVPt4+SECL1CkWmwmrZrmT6ZhDj3ll?=
 =?us-ascii?Q?G9NAYg0Ux9j4tDGxzu8awUGZPxzI7u84Cq/SYsGDmpr+JQHIbco248pCVHxK?=
 =?us-ascii?Q?JpyCfcbc7GH3THJxgJv0NdFrV7V2csTlY97rJdGR8GqAV/bh2TojjfV9gNx9?=
 =?us-ascii?Q?ehNPVgkAOHJtg1Du/7ifUUHfCH8F9f9K/ROamR0XNSUn5JrwsfJ4ZP+8TBtB?=
 =?us-ascii?Q?L/I3l4uTnq7ne7FXHR3UC/vQDer+j96v84GBvddKF5jX5fxEn46tRB4xy+XJ?=
 =?us-ascii?Q?Ep9ERbuW6fjqiAp3d4BQBqB7LE4KOAMFrilP+ScV177d7asUqys/Dh8MdHAB?=
 =?us-ascii?Q?4+nRJRCn5IbgS1BuZ/OXXqXLhgX9VSmMhNR7j4Sb7jTINfXs9QBK2hOOlWx0?=
 =?us-ascii?Q?GQL3kFoDrQ9qZiWha6LTaNmbM2K7AL3/AS2GkvA7?=
X-OriginatorOrg: welotec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce27fdf8-58b6-4a6a-4e7e-08dba28a9b2e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5373.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 21:07:19.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 25111a7f-1d5a-4c51-a4ca-7f8e44011b39
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWFU5mRjO93dhuVshAUrhUtONbAOzqd3KKQRB2WqU8iaFF3cn9kwAZSaXsmxpJUjnQhvYbhHb3X+UeC8DgmDGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Aug 2023 21:10:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14956


W dniu 17.08.2023 o=C2=A020:53, Joshua Watt pisze:
> Adds Python wrappers around the xattr API from libc and the ACL API from
> libacl.
>
Reviewed-by: Piotr =C5=81obacz <p.lobacz@welotec.com>
Tested-by: Piotr =C5=81obacz <p.lobacz@welotec.com>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   bitbake/lib/bb/acl.py   | 215 ++++++++++++++++++++++++++++++++++++++++
>   bitbake/lib/bb/xattr.py | 126 +++++++++++++++++++++++
>   2 files changed, 341 insertions(+)
>   create mode 100755 bitbake/lib/bb/acl.py
>   create mode 100755 bitbake/lib/bb/xattr.py
>
> diff --git a/bitbake/lib/bb/acl.py b/bitbake/lib/bb/acl.py
> new file mode 100755
> index 00000000000..0f41b275cf6
> --- /dev/null
> +++ b/bitbake/lib/bb/acl.py
> @@ -0,0 +1,215 @@
> +#! /usr/bin/env python3
> +#
> +# Copyright 2023 by Garmin Ltd. or its subsidiaries
> +#
> +# SPDX-License-Identifier: MIT
> +
> +
> +import sys
> +import ctypes
> +import os
> +import errno
> +import pwd
> +import grp
> +
> +libacl =3D ctypes.CDLL("libacl.so.1", use_errno=3DTrue)
> +
> +
> +ACL_TYPE_ACCESS =3D 0x8000
> +ACL_TYPE_DEFAULT =3D 0x4000
> +
> +ACL_FIRST_ENTRY =3D 0
> +ACL_NEXT_ENTRY =3D 1
> +
> +ACL_UNDEFINED_TAG =3D 0x00
> +ACL_USER_OBJ =3D 0x01
> +ACL_USER =3D 0x02
> +ACL_GROUP_OBJ =3D 0x04
> +ACL_GROUP =3D 0x08
> +ACL_MASK =3D 0x10
> +ACL_OTHER =3D 0x20
> +
> +ACL_READ =3D 0x04
> +ACL_WRITE =3D 0x02
> +ACL_EXECUTE =3D 0x01
> +
> +acl_t =3D ctypes.c_void_p
> +acl_entry_t =3D ctypes.c_void_p
> +acl_permset_t =3D ctypes.c_void_p
> +acl_perm_t =3D ctypes.c_uint
> +
> +acl_tag_t =3D ctypes.c_int
> +
> +libacl.acl_free.argtypes =3D [acl_t]
> +
> +
> +def acl_free(acl):
> +    libacl.acl_free(acl)
> +
> +
> +libacl.acl_get_file.restype =3D acl_t
> +libacl.acl_get_file.argtypes =3D [ctypes.c_char_p, ctypes.c_uint]
> +
> +
> +def acl_get_file(path, typ):
> +    acl =3D libacl.acl_get_file(os.fsencode(path), typ)
> +    if acl is None:
> +        err =3D ctypes.get_errno()
> +        raise OSError(err, os.strerror(err), str(path))
> +
> +    return acl
> +
> +
> +libacl.acl_get_entry.argtypes =3D [acl_t, ctypes.c_int, ctypes.c_void_p]
> +
> +
> +def acl_get_entry(acl, entry_id):
> +    entry =3D acl_entry_t()
> +    ret =3D libacl.acl_get_entry(acl, entry_id, ctypes.byref(entry))
> +    if ret < 0:
> +        err =3D ctypes.get_errno()
> +        raise OSError(err, os.strerror(err))
> +
> +    if ret =3D=3D 0:
> +        return None
> +
> +    return entry
> +
> +
> +libacl.acl_get_tag_type.argtypes =3D [acl_entry_t, ctypes.c_void_p]
> +
> +
> +def acl_get_tag_type(entry_d):
> +    tag =3D acl_tag_t()
> +    ret =3D libacl.acl_get_tag_type(entry_d, ctypes.byref(tag))
> +    if ret < 0:
> +        err =3D ctypes.get_errno()
> +        raise OSError(err, os.strerror(err))
> +    return tag.value
> +
> +
> +libacl.acl_get_qualifier.restype =3D ctypes.c_void_p
> +libacl.acl_get_qualifier.argtypes =3D [acl_entry_t]
> +
> +
> +def acl_get_qualifier(entry_d):
> +    ret =3D libacl.acl_get_qualifier(entry_d)
> +    if ret is None:
> +        err =3D ctypes.get_errno()
> +        raise OSError(err, os.strerror(err))
> +    return ctypes.c_void_p(ret)
> +
> +
> +libacl.acl_get_permset.argtypes =3D [acl_entry_t, ctypes.c_void_p]
> +
> +
> +def acl_get_permset(entry_d):
> +    permset =3D acl_permset_t()
> +    ret =3D libacl.acl_get_permset(entry_d, ctypes.byref(permset))
> +    if ret < 0:
> +        err =3D ctypes.get_errno()
> +        raise OSError(err, os.strerror(err))
> +
> +    return permset
> +
> +
> +libacl.acl_get_perm.argtypes =3D [acl_permset_t, acl_perm_t]
> +
> +
> +def acl_get_perm(permset_d, perm):
> +    ret =3D libacl.acl_get_perm(permset_d, perm)
> +    if ret < 0:
> +        err =3D ctypes.get_errno()
> +        raise OSError(err, os.strerror(err))
> +    return bool(ret)
> +
> +
> +class Entry(object):
> +    def __init__(self, tag, qualifier, mode):
> +        self.tag =3D tag
> +        self.qualifier =3D qualifier
> +        self.mode =3D mode
> +
> +    def __str__(self):
> +        typ =3D ""
> +        qual =3D ""
> +        if self.tag =3D=3D ACL_USER:
> +            typ =3D "user"
> +            qual =3D pwd.getpwuid(self.qualifier).pw_name
> +        elif self.tag =3D=3D ACL_GROUP:
> +            typ =3D "group"
> +            qual =3D grp.getgrgid(self.qualifier).gr_name
> +        elif self.tag =3D=3D ACL_USER_OBJ:
> +            typ =3D "user"
> +        elif self.tag =3D=3D ACL_GROUP_OBJ:
> +            typ =3D "group"
> +        elif self.tag =3D=3D ACL_MASK:
> +            typ =3D "mask"
> +        elif self.tag =3D=3D ACL_OTHER:
> +            typ =3D "other"
> +
> +        r =3D "r" if self.mode & ACL_READ else "-"
> +        w =3D "w" if self.mode & ACL_WRITE else "-"
> +        x =3D "x" if self.mode & ACL_EXECUTE else "-"
> +
> +        return f"{typ}:{qual}:{r}{w}{x}"
> +
> +
> +class ACL(object):
> +    def __init__(self, acl):
> +        self.acl =3D acl
> +
> +    def __del__(self):
> +        acl_free(self.acl)
> +
> +    def entries(self):
> +        entry_id =3D ACL_FIRST_ENTRY
> +        while True:
> +            entry =3D acl_get_entry(self.acl, entry_id)
> +            if entry is None:
> +                break
> +
> +            permset =3D acl_get_permset(entry)
> +
> +            mode =3D 0
> +            for m in (ACL_READ, ACL_WRITE, ACL_EXECUTE):
> +                if acl_get_perm(permset, m):
> +                    mode |=3D m
> +
> +            qualifier =3D None
> +            tag =3D acl_get_tag_type(entry)
> +
> +            if tag =3D=3D ACL_USER or tag =3D=3D ACL_GROUP:
> +                qual =3D acl_get_qualifier(entry)
> +                qualifier =3D ctypes.cast(qual, ctypes.POINTER(ctypes.c_=
int))[0]
> +
> +            yield Entry(tag, qualifier, mode)
> +
> +            entry_id =3D ACL_NEXT_ENTRY
> +
> +    @classmethod
> +    def from_path(cls, path, typ):
> +        acl =3D acl_get_file(path, typ)
> +        return cls(acl)
> +
> +
> +def main():
> +    import argparse
> +    import pwd
> +    import grp
> +    from pathlib import Path
> +
> +    parser =3D argparse.ArgumentParser()
> +    parser.add_argument("path", help=3D"File Path", type=3DPath)
> +
> +    args =3D parser.parse_args()
> +
> +    acl =3D ACL.from_path(args.path, ACL_TYPE_ACCESS)
> +    for entry in acl.entries():
> +        print(str(entry))
> +
> +    return 0
> +
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(main())
> diff --git a/bitbake/lib/bb/xattr.py b/bitbake/lib/bb/xattr.py
> new file mode 100755
> index 00000000000..7b634944a40
> --- /dev/null
> +++ b/bitbake/lib/bb/xattr.py
> @@ -0,0 +1,126 @@
> +#! /usr/bin/env python3
> +#
> +# Copyright 2023 by Garmin Ltd. or its subsidiaries
> +#
> +# SPDX-License-Identifier: MIT
> +
> +import sys
> +import ctypes
> +import os
> +import errno
> +
> +libc =3D ctypes.CDLL("libc.so.6", use_errno=3DTrue)
> +fsencoding =3D sys.getfilesystemencoding()
> +
> +
> +libc.listxattr.argtypes =3D [ctypes.c_char_p, ctypes.c_char_p, ctypes.c_=
size_t]
> +libc.llistxattr.argtypes =3D [ctypes.c_char_p, ctypes.c_char_p, ctypes.c=
_size_t]
> +
> +
> +def listxattr(path, follow=3DTrue):
> +    func =3D libc.listxattr if follow else libc.llistxattr
> +
> +    os_path =3D os.fsencode(path)
> +
> +    while True:
> +        length =3D func(os_path, None, 0)
> +
> +        if length < 0:
> +            err =3D ctypes.get_errno()
> +            raise OSError(err, os.strerror(err), str(path))
> +
> +        if length =3D=3D 0:
> +            return []
> +
> +        arr =3D ctypes.create_string_buffer(length)
> +
> +        read_length =3D func(os_path, arr, length)
> +        if read_length !=3D length:
> +            # Race!
> +            continue
> +
> +        return [a.decode(fsencoding) for a in arr.raw.split(b"\x00") if =
a]
> +
> +
> +libc.getxattr.argtypes =3D [
> +    ctypes.c_char_p,
> +    ctypes.c_char_p,
> +    ctypes.c_char_p,
> +    ctypes.c_size_t,
> +]
> +libc.lgetxattr.argtypes =3D [
> +    ctypes.c_char_p,
> +    ctypes.c_char_p,
> +    ctypes.c_char_p,
> +    ctypes.c_size_t,
> +]
> +
> +
> +def getxattr(path, name, follow=3DTrue):
> +    func =3D libc.getxattr if follow else libc.lgetxattr
> +
> +    os_path =3D os.fsencode(path)
> +    os_name =3D os.fsencode(name)
> +
> +    while True:
> +        length =3D func(os_path, os_name, None, 0)
> +
> +        if length < 0:
> +            err =3D ctypes.get_errno()
> +            if err =3D=3D errno.ENODATA:
> +                return None
> +            raise OSError(err, os.strerror(err), str(path))
> +
> +        if length =3D=3D 0:
> +            return ""
> +
> +        arr =3D ctypes.create_string_buffer(length)
> +
> +        read_length =3D func(os_path, os_name, arr, length)
> +        if read_length !=3D length:
> +            # Race!
> +            continue
> +
> +        return arr.raw
> +
> +
> +def get_all_xattr(path, follow=3DTrue):
> +    attrs =3D {}
> +
> +    names =3D listxattr(path, follow)
> +
> +    for name in names:
> +        value =3D getxattr(path, name, follow)
> +        if value is None:
> +            # This can happen if a value is erased after listxattr is ca=
lled,
> +            # so ignore it
> +            continue
> +        attrs[name] =3D value
> +
> +    return attrs
> +
> +
> +def main():
> +    import argparse
> +    from pathlib import Path
> +
> +    parser =3D argparse.ArgumentParser()
> +    parser.add_argument("path", help=3D"File Path", type=3DPath)
> +
> +    args =3D parser.parse_args()
> +
> +    attrs =3D get_all_xattr(args.path)
> +
> +    for name, value in attrs.items():
> +        try:
> +            value =3D value.decode(fsencoding)
> +        except UnicodeDecodeError:
> +            pass
> +
> +        print(f"{name} =3D {value}")
> +
> +    return 0
> +
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(main())

