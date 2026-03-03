Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A667EDEBFA
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 21:49:39 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4295.1772574577820160187
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Mar 2026 13:49:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=VmLEhuvs;
 spf=pass (domain: axis.com, ip: 52.101.69.70, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7sFsh0rY4bI10p6DLr9RFIuupc3kNlSM+ffi+Ukuz2DpL+3ObKnBGx5SEVrIY2ojlxu2o7FARertDmOFJd7ZuPNvgrEgspIWZdE8BeK/yHcU+9N5PXTk10fUVvY1hxm8RLQf937AYQGuD74PtHfz3ImbcFBR1H7CoVe15V7/+lbWqNvNs07xgDFn9a+OCM979TeN7q2DmWWKeCtqyvswemBFqhemvvuZsWJWMlvaKYbTQtJUbOVt/4Eg+lpJxQUF9YGeC/IU8HMS0/6tHdu4KfzspjdT5KEc0gD1O6rWs9zBrQSG+hpQNqR105ZZ222NTGxPJ+IdDNeZEHEp45mEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IA/2DtRyGhvFVrDNo/Nqi2IOIpNrhR1iVzZ0b5hQWTQ=;
 b=CKbOzgx6eLg1G2E53m7lOWiC7MQzs4dFb3oGZoqF/Hh4vAq0r8VRFofX+YapfPHh4YYp33/DAKfDRu9D5TCyFpfoiwDhNRoznmlmZ5aUYVnxZaq9jKrhgvBZSBQoCY978jTvKAfZEuqGSUPDmGjNWm03nz6oHJNcKFydX+YF6bxHmm91hJ9RdL76mzkJmdIfF7edtYk8auoSqWsaqPYsRfth7r3IIEfxcgU0xejT61zRwpxkxpNrtLwLnnHXoqr5D7vlNakowxHH74aVRMd6hAH1o50sPNWcXadhOHoeIxV9GfQ7GzvUcGU/SFIXoVwzzJZ8tez0YHVvjKCoNaYuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA/2DtRyGhvFVrDNo/Nqi2IOIpNrhR1iVzZ0b5hQWTQ=;
 b=VmLEhuvswxmHASm4QEH7o/beI9BivFP/lgNpd8SVftP3Pp5BmTRIP6nqj1xP6IrSiiU2/ySi3DCYJSBp9eyse0umFnF9Mc7koYL1iTgsaIojDaB8ndsamukpbZObRjfkF3Q5/USpTfgizB18z4QUWzMsej9JJ3o32ohEu91v0ak=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by VI0PR02MB10569.eurprd02.prod.outlook.com (2603:10a6:800:1b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 21:49:33 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::e5b6:b9a8:2a5d:e0cd%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 21:49:33 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Trevor Gamblin <tgamblin@baylibre.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH] runqueue.py: make sure we use bb
 multiprocessing
Thread-Topic: [bitbake-devel][PATCH] runqueue.py: make sure we use bb
 multiprocessing
Thread-Index: AQHcqy7IH+/qQmz9dUmd3nNKzSrGJrWdWCAQ
Date: Tue, 3 Mar 2026 21:49:33 +0000
Message-ID: 
 <DB5PR02MB10213F130CD24D9D606824F51EF7FA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20260303165657.1803606-1-tgamblin@baylibre.com>
In-Reply-To: <20260303165657.1803606-1-tgamblin@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|VI0PR02MB10569:EE_
x-ms-office365-filtering-correlation-id: b9b83412-be28-4840-9472-08de796ec1a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 ozHNbw2wx5cWWrBffEF2onoNwJhZt9zMlz7TmiN3HPruXi49mNeXUXQWKRsfTBYuX3jJuTfBfnxY88NadS979Z0hgOcBA+wfHZOE/qtQTNNS/F5e90hk3yJNNOUkuyuiEcuP8lbS3TEOA2WJCzCct6jaq9+e0qbOP2HeVoxgL3YW0IDe4ZkotIIm667QY05QyFKaE7FuTUb8n+epxMlbf67p41yIqhFOPZ66k7WaIRxk9MZLxLUTWMcO7q0fQDgion4r23gbb+AgnOCD9YBFSHDqIXHDVtOTPNfES0yb7Vy3n5MEFhw59CA6vySc0l1np/zl7C2ME0wkOuo7KYyt1K2jjXVLdoIzLYV9D1PRhh88AHd9SiepM5VvvaDgR9XrYnAh7gEowVeI0Q/WPzDl4gBMMeb4tWPaZn5dFtaCVSKoQ8Zddnx20KFFZdIr0ORSMreTAxSqRqdGlEcLzn7msU7/A5Yu1QmDruhL5x+Oc/jFV09f8WnwtMfT5CEknzAPsD+eJ2/a59P5xAv5vbPaT18q1TB3Xb0sZ/LtTyLbuhZt1kUAG9DMMmG6Qp2gPkkif9eQQH9/nWdT59HO5oiCjD7kUViGcdaXGmsbmis0bnKfpRzq51MXAsDZOoj0MyvZj/Novqd5xkX9x9i6iDYcEFIhT44J274ao7engkxk9d8YlivaAb8+pGKBktPjbrBoBf7hVXS6U7m/6Bquwun6s8pN3dUeFI4K/Oizq9VVLr4NYyC7Dbpl/NkTLlLs/alb/Q7sgDkg7w25N7POtold5Rv+Or/sQxUm+1gSjKIIjj8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?308H6AnDito/UZlWp5De8fQTeYM/1XzxMW7/aK60Kr2GE1BJ7RjoplXUu4js?=
 =?us-ascii?Q?Eabo3fagrEWJubZF+abivE5M8sSz1kBdpkBZJ30SlW1E4IgeGgRUvnFZUORq?=
 =?us-ascii?Q?zCe7yZU8gGaIfp48EYf3JAyDyYOd+N78WutWFBBCzF5c1gKMZaKGSl5ej0Wn?=
 =?us-ascii?Q?b7ylMEf1zJkUAgLcD2EMDHrsB8yTdLH7qadr1uzKGgA9xuDGcR/edbu5DGrb?=
 =?us-ascii?Q?66dkveJ5qkD1vJ84TrAc2nH+URVog7m1jaFWZd1xzJgdJPMGsa4ssesLaAxU?=
 =?us-ascii?Q?tcEpKkDp1FqkYcRcsU/JZdhE5QmoR9M2SuMldIPndbMzCPj/RRbLky8IN4yE?=
 =?us-ascii?Q?gJyscCFgXvBmVWWhMJ0hAr+gWSG9i7o4xhpkziD6I1FrAwXGW27dYNrQiR0N?=
 =?us-ascii?Q?3rBWI6gM1I1LVtR+TUZvFlgudyetJzTdaFcnHuHRKt2+dK4UO02Lh9GlAjdW?=
 =?us-ascii?Q?aWlE97AyCWlHRT2jfiF2qElrPxVNkUE3V6ATRsxGY5oPTKS1nXaSWsoevwuG?=
 =?us-ascii?Q?e+zeo7o3IW7k0WMncqthYgkWO9g1lpwLgD9+VPE/Bp3xHoRy/YpuzYzDSJgh?=
 =?us-ascii?Q?Ylzi1cVY7Qep8GAHfbkPZUWTbSYvBHLxrO/ggorc/20FmLNs9ufZi5HQ3bGw?=
 =?us-ascii?Q?CtGIPB0ZsyW404i0xPECg4WhkH8idtHihJ1XtD4pdW1cnzH3xZ9P9aaAoI1e?=
 =?us-ascii?Q?UmgjiD4Wb/DmhM0ZyA+hRVlr0xg8z/x5k0IQA9qd1Jt1z6/A8u9GBpvSN8E5?=
 =?us-ascii?Q?lXPurzH3vvPj2s5JQXqhY5+4Iu0wSIhpLOH9VufsOjC8bx5i77CqYwrAj+PQ?=
 =?us-ascii?Q?LBjlMBT/b/8O/gMaqgCd9h8j4/ZLvKlhQg1BZMUQq3B0bYbIFby1JJND831M?=
 =?us-ascii?Q?3OtPZ7jgCNc9lh6L6asButGKsfEdJkihvAHHzXDWzd8gz2S2DLlNDEdEaMaM?=
 =?us-ascii?Q?nd+oLZmMTKf7BSZeO5T4ynaVK/rzhdOZcJID4PbqUis1l8MdQVbmoDt31bwE?=
 =?us-ascii?Q?R1Qvt475rUkOd5+jY69q5Rn2Jtnlg5Jc1wOTrrBeo2ohMbsp9bgx9n7wLPQj?=
 =?us-ascii?Q?lvmbZmEfsxbNkEDsAnasT4pDmOb6fG29NRTgLnKjYjh8iGZ4jL0kIWeAqgXi?=
 =?us-ascii?Q?A6XLk7tmPMIkpfM3PVjJfKPINHJxiJTH4pvd5Qp+EYhHB+JfS/Xs2fJN9RA6?=
 =?us-ascii?Q?83aFY6fcZVUd7Y3Z0im1Bw0pA4PeOSFaADgQ8zfGx6c1wXMlMXqFK+Am3Tdn?=
 =?us-ascii?Q?hSpPizzJuwX+qSWcag1Hio3VTfk5lwPwk7rEwb/0Wa/u6uQgF0Ep1g66Cpdy?=
 =?us-ascii?Q?/Am3ysfOWevM00Xgy7FVEGyrw9IMfxBx9I7Wfgho0rLZDKi/xeN3cU0KFaWE?=
 =?us-ascii?Q?xIJ/hsYc9guhq5TOGH1hnEvALEKjNg8RtVeaWVV95tM0t2dal9x51I/Kw47m?=
 =?us-ascii?Q?UWGfHbSGlKxjmNR8B9v1fCaIhyTd5H9E/73pXidMfLhv6ewWkr2hy6pkMyyN?=
 =?us-ascii?Q?6n2be/2i+cML+mzWMRZMFvnXrNJbkwgtjg96I1esBPeOX/KzeXL3QMicB60i?=
 =?us-ascii?Q?FkVP6CGLSXnjrlQ/KwyKk9iqzu5nOmK3mcmrlYLevnnMiq0I20H9QLVPcDm+?=
 =?us-ascii?Q?8KSblnvkK1hpEM7kR9bUk/ktFh5zv0Z6KvNhAQ+SuvYCaxW9pZDvLatAmp1y?=
 =?us-ascii?Q?NdecbNHYMgmwYmIb/ehjaem6L78=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b83412-be28-4840-9472-08de796ec1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 21:49:33.4692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37NXxX6+8fr4ImP7LynpwXpfFFhTgYU/VjucYmlcKI38v454edNOV7NkEjL/MwLw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10569
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Mar 2026 21:49:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19103

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Trevor Gamblin
> Sent: den 3 mars 2026 17:57
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel][PATCH] runqueue.py: make sure we use bb multipro=
cessing
>=20
> Otherwise, we see errors like:
>=20
> |ERROR: An uncaught exception occurred in runqueue
> |Traceback (most recent call last):
> |  File "/srv/pokybuild/yocto-worker/check-layer/build/layers/bitbake/lib=
/bb/runqueue.py", line 1663, in execute_runqueue
> |    return self._execute_runqueue()
> |           ~~~~~~~~~~~~~~~~~~~~~~^^
> |  File "/srv/pokybuild/yocto-worker/check-layer/build/layers/bitbake/lib=
/bb/runqueue.py", line 1607, in _execute_runqueue
> |    retval =3D self.dump_signatures(dumpsigs)
> |  File "/srv/pokybuild/yocto-worker/check-layer/build/layers/bitbake/lib=
/bb/runqueue.py", line 1718, in dump_signatures
> |    p.start()
> |    ~~~~~~~^^
> |  File "/usr/lib64/python3.14/multiprocessing/process.py", line 121, in =
start
> |    self._popen =3D self._Popen(self)
> |                  ~~~~~~~~~~~^^^^^^
> |  File "/usr/lib64/python3.14/multiprocessing/context.py", line 224, in =
_Popen
> |    return _default_context.get_context().Process._Popen(process_obj)
> |           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^
> |  File "/usr/lib64/python3.14/multiprocessing/context.py", line 300, in =
_Popen
> |    return Popen(process_obj)
> |  File "/usr/lib64/python3.14/multiprocessing/popen_forkserver.py", line=
 35, in __init__
> |    super().__init__(process_obj)
> |    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^
> |  File "/usr/lib64/python3.14/multiprocessing/popen_fork.py", line 20, i=
n __init__
> |    self._launch(process_obj)
> |    ~~~~~~~~~~~~^^^^^^^^^^^^^
> |  File "/usr/lib64/python3.14/multiprocessing/popen_forkserver.py", line=
 47, in _launch
> |    reduction.dump(process_obj, buf)
> |    ~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^
> |  File "/usr/lib64/python3.14/multiprocessing/reduction.py", line 60, in=
 dump
> |    ForkingPickler(file, protocol).dump(obj)
> |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^
> |_pickle.PicklingError: Can't pickle local object <function CoreRecipeInf=
o.init_cacheData.<locals>.<lambda> at 0x7f7925667d70>
> |when serializing tuple item 0
> |when serializing collections.defaultdict reconstructor arguments
> |when serializing collections.defaultdict object
> |when serializing dict item 'rundeps'
> |when serializing bb.cache.CacheData state
> |when serializing bb.cache.CacheData object
> |when serializing dict item ''
> |when serializing dict item 'recipecaches'
> |when serializing bb.cooker.BBCooker state
> |when serializing bb.cooker.BBCooker object
> |when serializing dict item 'cooker'
> |when serializing bb.runqueue.RunQueue state
> |when serializing bb.runqueue.RunQueue object
> |when serializing tuple item 0
> |when serializing method reconstructor arguments
> |when serializing method object
> |when serializing dict item '_target'
> |when serializing multiprocessing.context.Process state
> |when serializing multiprocessing.context.Process object
>=20
> Fixes: [YOCTO #16184]
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>  lib/bb/runqueue.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index a880a0d54..27da5efaa 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -21,13 +21,15 @@ import re
>  import bb
>  from bb import msg, event
>  from bb import monitordisk
> +from bb import multiprocessing

Is this really needed? You use bb.multiprocessing below,=20
not multiprocessing.

>  import subprocess
>  import pickle
> -from multiprocessing import Process
>  import shlex
>  import pprint
>  import time
>=20
> +Process =3D bb.multiprocessing.Process
> +
>  bblogger =3D logging.getLogger("BitBake")
>  logger =3D logging.getLogger("BitBake.RunQueue")
>  hashequiv_logger =3D logging.getLogger("BitBake.RunQueue.HashEquiv")
> --
> 2.53.0

//Peter


